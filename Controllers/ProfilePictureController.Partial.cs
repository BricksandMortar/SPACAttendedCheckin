using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Rock;
using Rock.Model;
using Rock.Rest.Filters;

namespace cc.newspring.AttendedCheckIn.Controllers
{
    public partial class ProfilePictureController : Rock.Rest.ApiController<BinaryFile>
    {
        public ProfilePictureController() : base( new BinaryFileService( new Rock.Data.RockContext() ) ) { }
    }
    public partial class ProfilePictureController
    {
        [Authenticate, Secured]
        [HttpPost]
        [System.Web.Http.Route( "api/ProfilePicture/AddPhoto" )]
        public System.Net.Http.HttpResponseMessage AddPhoto( [FromBody] string img64 )
        {
            SetProxyCreation( true );
            var context = ( Rock.Data.RockContext ) Service.Context;

            var dataPortion = img64.Split( ',' )[1];
            char[] toSplitOn = { ';', ':' };
            var mimeType = img64.Split( toSplitOn )[1];
            byte[] array = Convert.FromBase64String( dataPortion );

            BinaryFile photo = new BinaryFile();
            photo.FileName = String.Format( "ProfilePhoto_{0}", DateTime.Now.ToString() );
            photo.BinaryFileTypeId = new BinaryFileTypeService( context ).Get( Rock.SystemGuid.BinaryFiletype.PERSON_IMAGE.AsGuid() ).Id;
            photo.DatabaseData = new BinaryFileData();
            photo.MimeType = mimeType;
            photo.IsTemporary = true;
            photo.DatabaseData.Content = array;
            BinaryFileService binaryFileService = new BinaryFileService( context );
            PersonService personService = new PersonService( context );

            binaryFileService.Add( photo );
            context.SaveChanges();
            var photoId = binaryFileService.Get( photo.Guid ).Id;

           
            return ControllerContext.Request.CreateResponse( HttpStatusCode.Created, photoId );
        }
    }
}
