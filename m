Return-Path: <stable+bounces-152841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A831ADCD04
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4553B3BB323
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 13:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DD92E717B;
	Tue, 17 Jun 2025 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="06J+uz2o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787BC2E7164
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750166270; cv=none; b=E/ZP8EjMYrgqauB946tdblEugY2FXQZU90qRwuqZ8R+B9oErZzP3a659Chb0bZzoQOwQBhGdKWE9Jg1nlmimNdF7pof48jT771V6WucFOFDLeBD0BfC+Xo+1yNeIvMyQYwQpGNCWeIwrqh0YgVBQCniGDJg8RX0ospUUC/50tKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750166270; c=relaxed/simple;
	bh=POepr1Y3KEa9OixHLCj9fSGZSnLdiL6wYSgozi6l/Tg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mbkEwI4Kc3OBm06RzoP/G/oM0CPUUJnJYCWDokFifdHQ22dzI/wAwH3v1ML+PdH/2uKsnNnHib6SyUeMhc6lUr9KORKSSHVf5ndwPa04ki3RKTACxVqabzC4n0zMuSSAQVNcbLOW3cGg+B+AQniycLqRXkOvuYaH7H9YDazchWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=06J+uz2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87621C4CEE3;
	Tue, 17 Jun 2025 13:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750166270;
	bh=POepr1Y3KEa9OixHLCj9fSGZSnLdiL6wYSgozi6l/Tg=;
	h=Subject:To:Cc:From:Date:From;
	b=06J+uz2oXirgPYmvJTSThpMbGxVVBxfquEg47ecP3w8wvPOHQvJFJgq9y+GtAubQH
	 NFiss4sbI5NQ0RBXnoJ5xHD5UzOvW2Rq49C7zVxfr0QWQ7PyKilKPyUsBGlzOISaHa
	 rs36ifoIicAVJ2U2SrctjqYHncalzScR6pRdCivE=
Subject: FAILED: patch "[PATCH] HID: usbhid: Eliminate recurrent out-of-bounds bug in" failed to apply to 5.4-stable tree
To: linuxhid@cosmicgizmosystems.com,jkosina@suse.com,mhklinux@outlook.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Jun 2025 15:17:39 +0200
Message-ID: <2025061739-tiger-fritter-acf8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x fe7f7ac8e0c708446ff017453add769ffc15deed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025061739-tiger-fritter-acf8@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fe7f7ac8e0c708446ff017453add769ffc15deed Mon Sep 17 00:00:00 2001
From: Terry Junge <linuxhid@cosmicgizmosystems.com>
Date: Wed, 12 Mar 2025 15:23:31 -0700
Subject: [PATCH] HID: usbhid: Eliminate recurrent out-of-bounds bug in
 usbhid_parse()

Update struct hid_descriptor to better reflect the mandatory and
optional parts of the HID Descriptor as per USB HID 1.11 specification.
Note: the kernel currently does not parse any optional HID class
descriptors, only the mandatory report descriptor.

Update all references to member element desc[0] to rpt_desc.

Add test to verify bLength and bNumDescriptors values are valid.

Replace the for loop with direct access to the mandatory HID class
descriptor member for the report descriptor. This eliminates the
possibility of getting an out-of-bounds fault.

Add a warning message if the HID descriptor contains any unsupported
optional HID class descriptors.

Reported-by: syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c52569baf0c843f35495
Fixes: f043bfc98c19 ("HID: usbhid: fix out-of-bounds bug")
Cc: stable@vger.kernel.org
Signed-off-by: Terry Junge <linuxhid@cosmicgizmosystems.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 0fb210e40a41..9eafff0b6ea4 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -192,7 +192,7 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 		goto cleanup;
 
 	input_device->report_desc_size = le16_to_cpu(
-					desc->desc[0].wDescriptorLength);
+					desc->rpt_desc.wDescriptorLength);
 	if (input_device->report_desc_size == 0) {
 		input_device->dev_info_status = -EINVAL;
 		goto cleanup;
@@ -210,7 +210,7 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 
 	memcpy(input_device->report_desc,
 	       ((unsigned char *)desc) + desc->bLength,
-	       le16_to_cpu(desc->desc[0].wDescriptorLength));
+	       le16_to_cpu(desc->rpt_desc.wDescriptorLength));
 
 	/* Send the ack */
 	memset(&ack, 0, sizeof(struct mousevsc_prt_msg));
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 44c2351b870f..fc2b92dfc242 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -984,12 +984,11 @@ static int usbhid_parse(struct hid_device *hid)
 	struct usb_host_interface *interface = intf->cur_altsetting;
 	struct usb_device *dev = interface_to_usbdev (intf);
 	struct hid_descriptor *hdesc;
+	struct hid_class_descriptor *hcdesc;
 	u32 quirks = 0;
 	unsigned int rsize = 0;
 	char *rdesc;
-	int ret, n;
-	int num_descriptors;
-	size_t offset = offsetof(struct hid_descriptor, desc);
+	int ret;
 
 	quirks = hid_lookup_quirk(hid);
 
@@ -1011,20 +1010,19 @@ static int usbhid_parse(struct hid_device *hid)
 		return -ENODEV;
 	}
 
-	if (hdesc->bLength < sizeof(struct hid_descriptor)) {
-		dbg_hid("hid descriptor is too short\n");
+	if (!hdesc->bNumDescriptors ||
+	    hdesc->bLength != sizeof(*hdesc) +
+			      (hdesc->bNumDescriptors - 1) * sizeof(*hcdesc)) {
+		dbg_hid("hid descriptor invalid, bLen=%hhu bNum=%hhu\n",
+			hdesc->bLength, hdesc->bNumDescriptors);
 		return -EINVAL;
 	}
 
 	hid->version = le16_to_cpu(hdesc->bcdHID);
 	hid->country = hdesc->bCountryCode;
 
-	num_descriptors = min_t(int, hdesc->bNumDescriptors,
-	       (hdesc->bLength - offset) / sizeof(struct hid_class_descriptor));
-
-	for (n = 0; n < num_descriptors; n++)
-		if (hdesc->desc[n].bDescriptorType == HID_DT_REPORT)
-			rsize = le16_to_cpu(hdesc->desc[n].wDescriptorLength);
+	if (hdesc->rpt_desc.bDescriptorType == HID_DT_REPORT)
+		rsize = le16_to_cpu(hdesc->rpt_desc.wDescriptorLength);
 
 	if (!rsize || rsize > HID_MAX_DESCRIPTOR_SIZE) {
 		dbg_hid("weird size of report descriptor (%u)\n", rsize);
@@ -1052,6 +1050,11 @@ static int usbhid_parse(struct hid_device *hid)
 		goto err;
 	}
 
+	if (hdesc->bNumDescriptors > 1)
+		hid_warn(intf,
+			"%u unsupported optional hid class descriptors\n",
+			(int)(hdesc->bNumDescriptors - 1));
+
 	hid->quirks |= quirks;
 
 	return 0;
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 740311c4fa24..c7a05f842745 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -144,8 +144,8 @@ static struct hid_descriptor hidg_desc = {
 	.bcdHID				= cpu_to_le16(0x0101),
 	.bCountryCode			= 0x00,
 	.bNumDescriptors		= 0x1,
-	/*.desc[0].bDescriptorType	= DYNAMIC */
-	/*.desc[0].wDescriptorLenght	= DYNAMIC */
+	/*.rpt_desc.bDescriptorType	= DYNAMIC */
+	/*.rpt_desc.wDescriptorLength	= DYNAMIC */
 };
 
 /* Super-Speed Support */
@@ -939,8 +939,8 @@ static int hidg_setup(struct usb_function *f,
 			struct hid_descriptor hidg_desc_copy = hidg_desc;
 
 			VDBG(cdev, "USB_REQ_GET_DESCRIPTOR: HID\n");
-			hidg_desc_copy.desc[0].bDescriptorType = HID_DT_REPORT;
-			hidg_desc_copy.desc[0].wDescriptorLength =
+			hidg_desc_copy.rpt_desc.bDescriptorType = HID_DT_REPORT;
+			hidg_desc_copy.rpt_desc.wDescriptorLength =
 				cpu_to_le16(hidg->report_desc_length);
 
 			length = min_t(unsigned short, length,
@@ -1210,8 +1210,8 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 	 * We can use hidg_desc struct here but we should not relay
 	 * that its content won't change after returning from this function.
 	 */
-	hidg_desc.desc[0].bDescriptorType = HID_DT_REPORT;
-	hidg_desc.desc[0].wDescriptorLength =
+	hidg_desc.rpt_desc.bDescriptorType = HID_DT_REPORT;
+	hidg_desc.rpt_desc.wDescriptorLength =
 		cpu_to_le16(hidg->report_desc_length);
 
 	hidg_hs_in_ep_desc.bEndpointAddress =
diff --git a/include/linux/hid.h b/include/linux/hid.h
index ef9a90ca0fbd..daae1d6d11a7 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -740,8 +740,9 @@ struct hid_descriptor {
 	__le16 bcdHID;
 	__u8  bCountryCode;
 	__u8  bNumDescriptors;
+	struct hid_class_descriptor rpt_desc;
 
-	struct hid_class_descriptor desc[1];
+	struct hid_class_descriptor opt_descs[];
 } __attribute__ ((packed));
 
 #define HID_DEVICE(b, g, ven, prod)					\


