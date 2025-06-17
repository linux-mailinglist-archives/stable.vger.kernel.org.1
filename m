Return-Path: <stable+bounces-153758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F501ADD6E1
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F601898B9F
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB0A285055;
	Tue, 17 Jun 2025 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oyA2DvUW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426E7285045;
	Tue, 17 Jun 2025 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177004; cv=none; b=nJ1g7nMvUp1PdDcaKm2Vz21IofnVFZDFn9uzFIiDEGqMnSKhvu4UqD93Tk7vKKnfz50Oe+2GaoGe5xgbA5TUU/t2OWYVNATWbtpk2R/l8URpExPiGLWGM3JqRKAIgs69psbAquaEItrLkDVWp+gaubSqQGNzawAV+K0w1KXISvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177004; c=relaxed/simple;
	bh=BLUr2f6UbqQbseNDPIS+nHXhXL5v1uYxDG1xTioSNII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ep3qehrJ4BGTFOzzg1tOL9DdJuEYcSvBlGSwuciZcwkN4R3mfC4pebEq/AfyKn0B06BnbBtZPrBEabkd3PY63Ax5+ndB1jkoYoWvRTxC/waZbaJy33JgMGPoZohRyUrafZ0KXnJ4gtD1cB9YexjwIyyITuCItXAbMVw6LlkK9YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oyA2DvUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05ECC4CEE3;
	Tue, 17 Jun 2025 16:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750177004;
	bh=BLUr2f6UbqQbseNDPIS+nHXhXL5v1uYxDG1xTioSNII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oyA2DvUWtZd51p2rt99Pv1lUd9uMu8RcrbhAWMxjTSv8XGC4U4Plgrm4k7JH8Nb3/
	 oPapalOVDZzmnJK6bs9btBwg0oLrrFUhwoyh6jcdl3hSc3rgMu1bgP1IiRoHL29nNI
	 t6BkFbitkwhkgMH9weoeMjSBJfukCYr2Zx7N4L9w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com,
	Terry Junge <linuxhid@cosmicgizmosystems.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 6.6 338/356] HID: usbhid: Eliminate recurrent out-of-bounds bug in usbhid_parse()
Date: Tue, 17 Jun 2025 17:27:33 +0200
Message-ID: <20250617152351.736148896@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Terry Junge <linuxhid@cosmicgizmosystems.com>

commit fe7f7ac8e0c708446ff017453add769ffc15deed upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-hyperv.c            |    4 ++--
 drivers/hid/usbhid/hid-core.c       |   25 ++++++++++++++-----------
 drivers/usb/gadget/function/f_hid.c |   12 ++++++------
 include/linux/hid.h                 |    3 ++-
 4 files changed, 24 insertions(+), 20 deletions(-)

--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -192,7 +192,7 @@ static void mousevsc_on_receive_device_i
 		goto cleanup;
 
 	input_device->report_desc_size = le16_to_cpu(
-					desc->desc[0].wDescriptorLength);
+					desc->rpt_desc.wDescriptorLength);
 	if (input_device->report_desc_size == 0) {
 		input_device->dev_info_status = -EINVAL;
 		goto cleanup;
@@ -210,7 +210,7 @@ static void mousevsc_on_receive_device_i
 
 	memcpy(input_device->report_desc,
 	       ((unsigned char *)desc) + desc->bLength,
-	       le16_to_cpu(desc->desc[0].wDescriptorLength));
+	       le16_to_cpu(desc->rpt_desc.wDescriptorLength));
 
 	/* Send the ack */
 	memset(&ack, 0, sizeof(struct mousevsc_prt_msg));
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -982,12 +982,11 @@ static int usbhid_parse(struct hid_devic
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
 
@@ -1009,20 +1008,19 @@ static int usbhid_parse(struct hid_devic
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
@@ -1050,6 +1048,11 @@ static int usbhid_parse(struct hid_devic
 		goto err;
 	}
 
+	if (hdesc->bNumDescriptors > 1)
+		hid_warn(intf,
+			"%u unsupported optional hid class descriptors\n",
+			(int)(hdesc->bNumDescriptors - 1));
+
 	hid->quirks |= quirks;
 
 	return 0;
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -118,8 +118,8 @@ static struct hid_descriptor hidg_desc =
 	.bcdHID				= cpu_to_le16(0x0101),
 	.bCountryCode			= 0x00,
 	.bNumDescriptors		= 0x1,
-	/*.desc[0].bDescriptorType	= DYNAMIC */
-	/*.desc[0].wDescriptorLenght	= DYNAMIC */
+	/*.rpt_desc.bDescriptorType	= DYNAMIC */
+	/*.rpt_desc.wDescriptorLength	= DYNAMIC */
 };
 
 /* Super-Speed Support */
@@ -728,8 +728,8 @@ static int hidg_setup(struct usb_functio
 			struct hid_descriptor hidg_desc_copy = hidg_desc;
 
 			VDBG(cdev, "USB_REQ_GET_DESCRIPTOR: HID\n");
-			hidg_desc_copy.desc[0].bDescriptorType = HID_DT_REPORT;
-			hidg_desc_copy.desc[0].wDescriptorLength =
+			hidg_desc_copy.rpt_desc.bDescriptorType = HID_DT_REPORT;
+			hidg_desc_copy.rpt_desc.wDescriptorLength =
 				cpu_to_le16(hidg->report_desc_length);
 
 			length = min_t(unsigned short, length,
@@ -970,8 +970,8 @@ static int hidg_bind(struct usb_configur
 	 * We can use hidg_desc struct here but we should not relay
 	 * that its content won't change after returning from this function.
 	 */
-	hidg_desc.desc[0].bDescriptorType = HID_DT_REPORT;
-	hidg_desc.desc[0].wDescriptorLength =
+	hidg_desc.rpt_desc.bDescriptorType = HID_DT_REPORT;
+	hidg_desc.rpt_desc.wDescriptorLength =
 		cpu_to_le16(hidg->report_desc_length);
 
 	hidg_hs_in_ep_desc.bEndpointAddress =
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -736,8 +736,9 @@ struct hid_descriptor {
 	__le16 bcdHID;
 	__u8  bCountryCode;
 	__u8  bNumDescriptors;
+	struct hid_class_descriptor rpt_desc;
 
-	struct hid_class_descriptor desc[1];
+	struct hid_class_descriptor opt_descs[];
 } __attribute__ ((packed));
 
 #define HID_DEVICE(b, g, ven, prod)					\



