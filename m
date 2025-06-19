Return-Path: <stable+bounces-154716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DE1ADFA73
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 03:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8388A1890FDA
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 01:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC1A15A85A;
	Thu, 19 Jun 2025 01:04:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cosmicgizmosystems.com (cosmicgizmosystems.com [63.249.102.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA092BB15
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 01:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.249.102.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750295053; cv=none; b=Yr17erMfRDPuG8oxtucqvL2vWphNI8Bkwb2pUiJY6n7Egsgcm55hgyk2CG6JshrxX3MNR9rhl/4TldYGD1mbD1Tts5ptFCAHkQZgS2G+51Zkkp1KzCsKzKk2TGXoB0GNjSrRZ9LDoTfGcwMDNWV9TFLzLmP8Tyk4X1OEfCj4v8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750295053; c=relaxed/simple;
	bh=I/tC5ILiV4BrLrM0rbdmweOHU2iG4+ydeSofxTEvyqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vc2L9nCaKLmvqzoT0+3pDBdy/A5UAmR0IxZ/QPi7ZamAkdpqlENaL97mfSTXZ5IqTiwEKLVFUL2qfEJbWCz/ycxUduShGrlZSmr9wf/LhJ0SuBzseUCKsEXBvMjVkVbnno4+MNW3X/FrFRW5r7jY3KouR1k7urXOAqaILc1qNMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cosmicgizmosystems.com; spf=pass smtp.mailfrom=cosmicgizmosystems.com; arc=none smtp.client-ip=63.249.102.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cosmicgizmosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cosmicgizmosystems.com
Received: from terrys-Precision-M4600.. (c-71-193-224-155.hsd1.wa.comcast.net [71.193.224.155])
	by host11.cruzio.com (Postfix) with ESMTPSA id 5128A2062217;
	Wed, 18 Jun 2025 17:54:08 -0700 (PDT)
From: Terry Junge <linuxhid@cosmicgizmosystems.com>
To: stable@vger.kernel.org
Cc: Terry Junge <linuxhid@cosmicgizmosystems.com>,
	syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com,
	Michael Kelley <mhklinux@outlook.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 5.4.y] HID: usbhid: Eliminate recurrent out-of-bounds bug in usbhid_parse()
Date: Wed, 18 Jun 2025 17:53:10 -0700
Message-ID: <20250619005310.11573-1-linuxhid@cosmicgizmosystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025061739-tiger-fritter-acf8@gregkh>
References: <2025061739-tiger-fritter-acf8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
(cherry picked from commit fe7f7ac8e0c708446ff017453add769ffc15deed)
Signed-off-by: Terry Junge <linuxhid@cosmicgizmosystems.com>
---
 drivers/hid/hid-hyperv.c            |  5 +++--
 drivers/hid/usbhid/hid-core.c       | 25 ++++++++++++++-----------
 drivers/usb/gadget/function/f_hid.c | 12 ++++++------
 include/linux/hid.h                 |  3 ++-
 4 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 5928e934d734..f9eb7ebec76f 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -197,7 +197,8 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 	if (!input_device->hid_desc)
 		goto cleanup;
 
-	input_device->report_desc_size = desc->desc[0].wDescriptorLength;
+	input_device->report_desc_size = le16_to_cpu(
+					desc->rpt_desc.wDescriptorLength);
 	if (input_device->report_desc_size == 0) {
 		input_device->dev_info_status = -EINVAL;
 		goto cleanup;
@@ -213,7 +214,7 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 
 	memcpy(input_device->report_desc,
 	       ((unsigned char *)desc) + desc->bLength,
-	       desc->desc[0].wDescriptorLength);
+	       le16_to_cpu(desc->rpt_desc.wDescriptorLength));
 
 	/* Send the ack */
 	memset(&ack, 0, sizeof(struct mousevsc_prt_msg));
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 8537fcdb456d..6e5770b8cc4c 100644
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
index 571560d689c8..77354626252c 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -114,8 +114,8 @@ static struct hid_descriptor hidg_desc = {
 	.bcdHID				= cpu_to_le16(0x0101),
 	.bCountryCode			= 0x00,
 	.bNumDescriptors		= 0x1,
-	/*.desc[0].bDescriptorType	= DYNAMIC */
-	/*.desc[0].wDescriptorLenght	= DYNAMIC */
+	/*.rpt_desc.bDescriptorType	= DYNAMIC */
+	/*.rpt_desc.wDescriptorLength	= DYNAMIC */
 };
 
 /* Super-Speed Support */
@@ -730,8 +730,8 @@ static int hidg_setup(struct usb_function *f,
 			struct hid_descriptor hidg_desc_copy = hidg_desc;
 
 			VDBG(cdev, "USB_REQ_GET_DESCRIPTOR: HID\n");
-			hidg_desc_copy.desc[0].bDescriptorType = HID_DT_REPORT;
-			hidg_desc_copy.desc[0].wDescriptorLength =
+			hidg_desc_copy.rpt_desc.bDescriptorType = HID_DT_REPORT;
+			hidg_desc_copy.rpt_desc.wDescriptorLength =
 				cpu_to_le16(hidg->report_desc_length);
 
 			length = min_t(unsigned short, length,
@@ -972,8 +972,8 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
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
index af73e8c815af..69a0967004d2 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -672,8 +672,9 @@ struct hid_descriptor {
 	__le16 bcdHID;
 	__u8  bCountryCode;
 	__u8  bNumDescriptors;
+	struct hid_class_descriptor rpt_desc;
 
-	struct hid_class_descriptor desc[1];
+	struct hid_class_descriptor opt_descs[];
 } __attribute__ ((packed));
 
 #define HID_DEVICE(b, g, ven, prod)					\
-- 
2.43.0


