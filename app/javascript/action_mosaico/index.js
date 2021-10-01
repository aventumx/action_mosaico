import { AttachmentUpload } from "./attachment_upload"

addEventListener("mosaico-attachment-add", event => {
  const { attachment, target } = event

  if (attachment.file) {
    const upload = new AttachmentUpload(attachment, target)
    upload.start()
  }
})
