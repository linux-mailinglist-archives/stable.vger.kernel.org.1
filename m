Return-Path: <stable+bounces-13702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD4C837D78
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4961C230B7
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409475A793;
	Tue, 23 Jan 2024 00:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="URn7mOfG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38914E1D8;
	Tue, 23 Jan 2024 00:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969974; cv=none; b=mt/kiDp3y9+WPYGVKEpFHVjXXCDJ/sEm2B/Zb1X50L5xLObmEcqf5YjhWL9yi/Nu+zX8xc593HD4XgGso6JAYLh06svfBx0Wy2iV4XoKZRQz0I/4/4/Ii4vk0HjXGya5U+9JFCLSIPbo/BXzAUhD9QWgp3gVCT9mpZZliAY2KUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969974; c=relaxed/simple;
	bh=Drx1eAqLEeiZkLcvDuDo2ZQR8hfWLWZPQRRr8HybdBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVf/9D6Xd9Dq6vkIrB+w0s2iD8OfMZD65dLZyed0+2j7JWgEXeVAwsrJK+53pgVQtUB5oC5NqvFpRf4f33gXAi4ArXgSrqiLqMGK9J8pQkpu/uZKMEUrbcYIKKb+ldvPPYSkpBioCXRNTAOf2k0XS3EKKhlRmUPurHOyfTAe0qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=URn7mOfG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EB4C433C7;
	Tue, 23 Jan 2024 00:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969973;
	bh=Drx1eAqLEeiZkLcvDuDo2ZQR8hfWLWZPQRRr8HybdBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=URn7mOfGJ8BPU6GsStWH7AXv52hcN8S8t1pt3nBMa4RgnSMNGgAvTlCajhDrg9jCK
	 oZZ8bo0ThhvkD7EqcSw/EkIll/fTC+TG+sGFpnHt24m98nokClr8/sd+qmnXMyqjSX
	 pR0DQ3n6XSYFFQ3LIMuMBqneDOyPsR1Vv5KyxymY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 546/641] usb: gadget: webcam: Make g_webcam loadable again
Date: Mon, 22 Jan 2024 15:57:30 -0800
Message-ID: <20240122235835.227903023@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

[ Upstream commit f1fd91a0924b6bff91ca1287461fb8e3b3b61d92 ]

commit 588b9e85609b ("usb: gadget: uvc: add v4l2 enumeration api calls")
has rendered the precomposed (aka legacy) webcam gadget unloadable.

uvc_alloc() since then has depended on certain config groups being
available in configfs tree related to the UVC function. However, legacy
gadgets do not create anything in configfs, so uvc_alloc() must fail
with -ENOENT no matter what.

This patch mimics the required configfs hierarchy to satisfy the code which
inspects formats and frames found in uvcg_streaming_header.

This has been tested with guvcview on the host side, using vivid as a
source of video stream on the device side and using the userspace program
found at https://gitlab.freedesktop.org/camera/uvc-gadget.git.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Fixes: 588b9e85609b ("usb: gadget: uvc: add v4l2 enumeration api calls")
Link: https://lore.kernel.org/r/20231215131614.29132-1-andrzej.p@collabora.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_uvc.c |  45 ++--
 drivers/usb/gadget/function/u_uvc.h |   6 +
 drivers/usb/gadget/legacy/webcam.c  | 333 +++++++++++++++++++++-------
 3 files changed, 284 insertions(+), 100 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index fc508a039967..c6965e389473 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -976,7 +976,8 @@ static void uvc_free(struct usb_function *f)
 	struct uvc_device *uvc = to_uvc(f);
 	struct f_uvc_opts *opts = container_of(f->fi, struct f_uvc_opts,
 					       func_inst);
-	config_item_put(&uvc->header->item);
+	if (!opts->header)
+		config_item_put(&uvc->header->item);
 	--opts->refcnt;
 	kfree(uvc);
 }
@@ -1068,25 +1069,29 @@ static struct usb_function *uvc_alloc(struct usb_function_instance *fi)
 	uvc->desc.hs_streaming = opts->hs_streaming;
 	uvc->desc.ss_streaming = opts->ss_streaming;
 
-	streaming = config_group_find_item(&opts->func_inst.group, "streaming");
-	if (!streaming)
-		goto err_config;
-
-	header = config_group_find_item(to_config_group(streaming), "header");
-	config_item_put(streaming);
-	if (!header)
-		goto err_config;
-
-	h = config_group_find_item(to_config_group(header), "h");
-	config_item_put(header);
-	if (!h)
-		goto err_config;
-
-	uvc->header = to_uvcg_streaming_header(h);
-	if (!uvc->header->linked) {
-		mutex_unlock(&opts->lock);
-		kfree(uvc);
-		return ERR_PTR(-EBUSY);
+	if (opts->header) {
+		uvc->header = opts->header;
+	} else {
+		streaming = config_group_find_item(&opts->func_inst.group, "streaming");
+		if (!streaming)
+			goto err_config;
+
+		header = config_group_find_item(to_config_group(streaming), "header");
+		config_item_put(streaming);
+		if (!header)
+			goto err_config;
+
+		h = config_group_find_item(to_config_group(header), "h");
+		config_item_put(header);
+		if (!h)
+			goto err_config;
+
+		uvc->header = to_uvcg_streaming_header(h);
+		if (!uvc->header->linked) {
+			mutex_unlock(&opts->lock);
+			kfree(uvc);
+			return ERR_PTR(-EBUSY);
+		}
 	}
 
 	uvc->desc.extension_units = &opts->extension_units;
diff --git a/drivers/usb/gadget/function/u_uvc.h b/drivers/usb/gadget/function/u_uvc.h
index 1ce58f61253c..3ac392cbb779 100644
--- a/drivers/usb/gadget/function/u_uvc.h
+++ b/drivers/usb/gadget/function/u_uvc.h
@@ -98,6 +98,12 @@ struct f_uvc_opts {
 	 */
 	struct mutex			lock;
 	int				refcnt;
+
+	/*
+	 * Only for legacy gadget. Shall be NULL for configfs-composed gadgets,
+	 * which is guaranteed by alloc_inst implementation of f_uvc doing kzalloc.
+	 */
+	struct uvcg_streaming_header	*header;
 };
 
 #endif /* U_UVC_H */
diff --git a/drivers/usb/gadget/legacy/webcam.c b/drivers/usb/gadget/legacy/webcam.c
index c06dd1af7a0c..c395438d3978 100644
--- a/drivers/usb/gadget/legacy/webcam.c
+++ b/drivers/usb/gadget/legacy/webcam.c
@@ -12,6 +12,7 @@
 #include <linux/usb/video.h>
 
 #include "u_uvc.h"
+#include "uvc_configfs.h"
 
 USB_GADGET_COMPOSITE_OPTIONS();
 
@@ -84,8 +85,6 @@ static struct usb_device_descriptor webcam_device_descriptor = {
 	.bNumConfigurations	= 0, /* dynamic */
 };
 
-DECLARE_UVC_HEADER_DESCRIPTOR(1);
-
 static const struct UVC_HEADER_DESCRIPTOR(1) uvc_control_header = {
 	.bLength		= UVC_DT_HEADER_SIZE(1),
 	.bDescriptorType	= USB_DT_CS_INTERFACE,
@@ -158,43 +157,112 @@ static const struct UVC_INPUT_HEADER_DESCRIPTOR(1, 2) uvc_input_header = {
 	.bmaControls[1][0]	= 4,
 };
 
-static const struct uvc_format_uncompressed uvc_format_yuv = {
-	.bLength		= UVC_DT_FORMAT_UNCOMPRESSED_SIZE,
-	.bDescriptorType	= USB_DT_CS_INTERFACE,
-	.bDescriptorSubType	= UVC_VS_FORMAT_UNCOMPRESSED,
-	.bFormatIndex		= 1,
-	.bNumFrameDescriptors	= 2,
-	.guidFormat		=
-		{ 'Y',  'U',  'Y',  '2', 0x00, 0x00, 0x10, 0x00,
-		 0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71},
-	.bBitsPerPixel		= 16,
-	.bDefaultFrameIndex	= 1,
-	.bAspectRatioX		= 0,
-	.bAspectRatioY		= 0,
-	.bmInterlaceFlags	= 0,
-	.bCopyProtect		= 0,
+static const struct uvcg_color_matching uvcg_color_matching = {
+	.desc = {
+		.bLength		= UVC_DT_COLOR_MATCHING_SIZE,
+		.bDescriptorType	= USB_DT_CS_INTERFACE,
+		.bDescriptorSubType	= UVC_VS_COLORFORMAT,
+		.bColorPrimaries	= 1,
+		.bTransferCharacteristics	= 1,
+		.bMatrixCoefficients	= 4,
+	},
+};
+
+static struct uvcg_uncompressed uvcg_format_yuv = {
+	.fmt = {
+		.type			= UVCG_UNCOMPRESSED,
+		/* add to .frames and fill .num_frames at runtime */
+		.color_matching		= (struct uvcg_color_matching *)&uvcg_color_matching,
+	},
+	.desc = {
+		.bLength		= UVC_DT_FORMAT_UNCOMPRESSED_SIZE,
+		.bDescriptorType	= USB_DT_CS_INTERFACE,
+		.bDescriptorSubType	= UVC_VS_FORMAT_UNCOMPRESSED,
+		.bFormatIndex		= 1,
+		.bNumFrameDescriptors	= 2,
+		.guidFormat		= {
+			'Y',  'U',  'Y',  '2', 0x00, 0x00, 0x10, 0x00,
+			 0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71
+		},
+		.bBitsPerPixel		= 16,
+		.bDefaultFrameIndex	= 1,
+		.bAspectRatioX		= 0,
+		.bAspectRatioY		= 0,
+		.bmInterlaceFlags	= 0,
+		.bCopyProtect		= 0,
+	},
+};
+
+static struct uvcg_format_ptr uvcg_format_ptr_yuv = {
+	.fmt = &uvcg_format_yuv.fmt,
 };
 
 DECLARE_UVC_FRAME_UNCOMPRESSED(1);
 DECLARE_UVC_FRAME_UNCOMPRESSED(3);
 
+#define UVCG_WIDTH_360P			640
+#define UVCG_HEIGHT_360P		360
+#define UVCG_MIN_BITRATE_360P		18432000
+#define UVCG_MAX_BITRATE_360P		55296000
+#define UVCG_MAX_VIDEO_FB_SZ_360P	460800
+#define UVCG_FRM_INTERV_0_360P		666666
+#define UVCG_FRM_INTERV_1_360P		1000000
+#define UVCG_FRM_INTERV_2_360P		5000000
+#define UVCG_DEFAULT_FRM_INTERV_360P	UVCG_FRM_INTERV_0_360P
+
 static const struct UVC_FRAME_UNCOMPRESSED(3) uvc_frame_yuv_360p = {
 	.bLength		= UVC_DT_FRAME_UNCOMPRESSED_SIZE(3),
 	.bDescriptorType	= USB_DT_CS_INTERFACE,
 	.bDescriptorSubType	= UVC_VS_FRAME_UNCOMPRESSED,
 	.bFrameIndex		= 1,
 	.bmCapabilities		= 0,
-	.wWidth			= cpu_to_le16(640),
-	.wHeight		= cpu_to_le16(360),
-	.dwMinBitRate		= cpu_to_le32(18432000),
-	.dwMaxBitRate		= cpu_to_le32(55296000),
-	.dwMaxVideoFrameBufferSize	= cpu_to_le32(460800),
-	.dwDefaultFrameInterval	= cpu_to_le32(666666),
+	.wWidth			= cpu_to_le16(UVCG_WIDTH_360P),
+	.wHeight		= cpu_to_le16(UVCG_HEIGHT_360P),
+	.dwMinBitRate		= cpu_to_le32(UVCG_MIN_BITRATE_360P),
+	.dwMaxBitRate		= cpu_to_le32(UVCG_MAX_BITRATE_360P),
+	.dwMaxVideoFrameBufferSize	= cpu_to_le32(UVCG_MAX_VIDEO_FB_SZ_360P),
+	.dwDefaultFrameInterval	= cpu_to_le32(UVCG_DEFAULT_FRM_INTERV_360P),
 	.bFrameIntervalType	= 3,
-	.dwFrameInterval[0]	= cpu_to_le32(666666),
-	.dwFrameInterval[1]	= cpu_to_le32(1000000),
-	.dwFrameInterval[2]	= cpu_to_le32(5000000),
+	.dwFrameInterval[0]	= cpu_to_le32(UVCG_FRM_INTERV_0_360P),
+	.dwFrameInterval[1]	= cpu_to_le32(UVCG_FRM_INTERV_1_360P),
+	.dwFrameInterval[2]	= cpu_to_le32(UVCG_FRM_INTERV_2_360P),
+};
+
+static u32 uvcg_frame_yuv_360p_dw_frame_interval[] = {
+	[0] = UVCG_FRM_INTERV_0_360P,
+	[1] = UVCG_FRM_INTERV_1_360P,
+	[2] = UVCG_FRM_INTERV_2_360P,
+};
+
+static const struct uvcg_frame uvcg_frame_yuv_360p = {
+	.fmt_type		= UVCG_UNCOMPRESSED,
+	.frame = {
+		.b_length			= UVC_DT_FRAME_UNCOMPRESSED_SIZE(3),
+		.b_descriptor_type		= USB_DT_CS_INTERFACE,
+		.b_descriptor_subtype		= UVC_VS_FRAME_UNCOMPRESSED,
+		.b_frame_index			= 1,
+		.bm_capabilities		= 0,
+		.w_width			= UVCG_WIDTH_360P,
+		.w_height			= UVCG_HEIGHT_360P,
+		.dw_min_bit_rate		= UVCG_MIN_BITRATE_360P,
+		.dw_max_bit_rate		= UVCG_MAX_BITRATE_360P,
+		.dw_max_video_frame_buffer_size	= UVCG_MAX_VIDEO_FB_SZ_360P,
+		.dw_default_frame_interval	= UVCG_DEFAULT_FRM_INTERV_360P,
+		.b_frame_interval_type		= 3,
+	},
+	.dw_frame_interval	= uvcg_frame_yuv_360p_dw_frame_interval,
+};
+
+static struct uvcg_frame_ptr uvcg_frame_ptr_yuv_360p = {
+	.frm = (struct uvcg_frame *)&uvcg_frame_yuv_360p,
 };
+#define UVCG_WIDTH_720P			1280
+#define UVCG_HEIGHT_720P		720
+#define UVCG_MIN_BITRATE_720P		29491200
+#define UVCG_MAX_BITRATE_720P		29491200
+#define UVCG_MAX_VIDEO_FB_SZ_720P	1843200
+#define UVCG_FRM_INTERV_0_720P		5000000
+#define UVCG_DEFAULT_FRM_INTERV_720P	UVCG_FRM_INTERV_0_720P
 
 static const struct UVC_FRAME_UNCOMPRESSED(1) uvc_frame_yuv_720p = {
 	.bLength		= UVC_DT_FRAME_UNCOMPRESSED_SIZE(1),
@@ -202,28 +270,66 @@ static const struct UVC_FRAME_UNCOMPRESSED(1) uvc_frame_yuv_720p = {
 	.bDescriptorSubType	= UVC_VS_FRAME_UNCOMPRESSED,
 	.bFrameIndex		= 2,
 	.bmCapabilities		= 0,
-	.wWidth			= cpu_to_le16(1280),
-	.wHeight		= cpu_to_le16(720),
-	.dwMinBitRate		= cpu_to_le32(29491200),
-	.dwMaxBitRate		= cpu_to_le32(29491200),
-	.dwMaxVideoFrameBufferSize	= cpu_to_le32(1843200),
-	.dwDefaultFrameInterval	= cpu_to_le32(5000000),
+	.wWidth			= cpu_to_le16(UVCG_WIDTH_720P),
+	.wHeight		= cpu_to_le16(UVCG_HEIGHT_720P),
+	.dwMinBitRate		= cpu_to_le32(UVCG_MIN_BITRATE_720P),
+	.dwMaxBitRate		= cpu_to_le32(UVCG_MAX_BITRATE_720P),
+	.dwMaxVideoFrameBufferSize	= cpu_to_le32(UVCG_MAX_VIDEO_FB_SZ_720P),
+	.dwDefaultFrameInterval	= cpu_to_le32(UVCG_DEFAULT_FRM_INTERV_720P),
 	.bFrameIntervalType	= 1,
-	.dwFrameInterval[0]	= cpu_to_le32(5000000),
+	.dwFrameInterval[0]	= cpu_to_le32(UVCG_FRM_INTERV_0_720P),
 };
 
-static const struct uvc_format_mjpeg uvc_format_mjpg = {
-	.bLength		= UVC_DT_FORMAT_MJPEG_SIZE,
-	.bDescriptorType	= USB_DT_CS_INTERFACE,
-	.bDescriptorSubType	= UVC_VS_FORMAT_MJPEG,
-	.bFormatIndex		= 2,
-	.bNumFrameDescriptors	= 2,
-	.bmFlags		= 0,
-	.bDefaultFrameIndex	= 1,
-	.bAspectRatioX		= 0,
-	.bAspectRatioY		= 0,
-	.bmInterlaceFlags	= 0,
-	.bCopyProtect		= 0,
+static u32 uvcg_frame_yuv_720p_dw_frame_interval[] = {
+	[0] = UVCG_FRM_INTERV_0_720P,
+};
+
+static const struct uvcg_frame uvcg_frame_yuv_720p = {
+	.fmt_type		= UVCG_UNCOMPRESSED,
+	.frame = {
+		.b_length			= UVC_DT_FRAME_UNCOMPRESSED_SIZE(1),
+		.b_descriptor_type		= USB_DT_CS_INTERFACE,
+		.b_descriptor_subtype		= UVC_VS_FRAME_UNCOMPRESSED,
+		.b_frame_index			= 2,
+		.bm_capabilities		= 0,
+		.w_width			= UVCG_WIDTH_720P,
+		.w_height			= UVCG_HEIGHT_720P,
+		.dw_min_bit_rate		= UVCG_MIN_BITRATE_720P,
+		.dw_max_bit_rate		= UVCG_MAX_BITRATE_720P,
+		.dw_max_video_frame_buffer_size	= UVCG_MAX_VIDEO_FB_SZ_720P,
+		.dw_default_frame_interval	= UVCG_DEFAULT_FRM_INTERV_720P,
+		.b_frame_interval_type		= 1,
+	},
+	.dw_frame_interval	= uvcg_frame_yuv_720p_dw_frame_interval,
+};
+
+static struct uvcg_frame_ptr uvcg_frame_ptr_yuv_720p = {
+	.frm = (struct uvcg_frame *)&uvcg_frame_yuv_720p,
+};
+
+static struct uvcg_mjpeg uvcg_format_mjpeg = {
+	.fmt = {
+		.type			= UVCG_MJPEG,
+		/* add to .frames and fill .num_frames at runtime */
+		.color_matching		= (struct uvcg_color_matching *)&uvcg_color_matching,
+	},
+	.desc = {
+		.bLength		= UVC_DT_FORMAT_MJPEG_SIZE,
+		.bDescriptorType	= USB_DT_CS_INTERFACE,
+		.bDescriptorSubType	= UVC_VS_FORMAT_MJPEG,
+		.bFormatIndex		= 2,
+		.bNumFrameDescriptors	= 2,
+		.bmFlags		= 0,
+		.bDefaultFrameIndex	= 1,
+		.bAspectRatioX		= 0,
+		.bAspectRatioY		= 0,
+		.bmInterlaceFlags	= 0,
+		.bCopyProtect		= 0,
+	},
+};
+
+static struct uvcg_format_ptr uvcg_format_ptr_mjpeg = {
+	.fmt = &uvcg_format_mjpeg.fmt,
 };
 
 DECLARE_UVC_FRAME_MJPEG(1);
@@ -235,16 +341,45 @@ static const struct UVC_FRAME_MJPEG(3) uvc_frame_mjpg_360p = {
 	.bDescriptorSubType	= UVC_VS_FRAME_MJPEG,
 	.bFrameIndex		= 1,
 	.bmCapabilities		= 0,
-	.wWidth			= cpu_to_le16(640),
-	.wHeight		= cpu_to_le16(360),
-	.dwMinBitRate		= cpu_to_le32(18432000),
-	.dwMaxBitRate		= cpu_to_le32(55296000),
-	.dwMaxVideoFrameBufferSize	= cpu_to_le32(460800),
-	.dwDefaultFrameInterval	= cpu_to_le32(666666),
+	.wWidth			= cpu_to_le16(UVCG_WIDTH_360P),
+	.wHeight		= cpu_to_le16(UVCG_HEIGHT_360P),
+	.dwMinBitRate		= cpu_to_le32(UVCG_MIN_BITRATE_360P),
+	.dwMaxBitRate		= cpu_to_le32(UVCG_MAX_BITRATE_360P),
+	.dwMaxVideoFrameBufferSize	= cpu_to_le32(UVCG_MAX_VIDEO_FB_SZ_360P),
+	.dwDefaultFrameInterval	= cpu_to_le32(UVCG_DEFAULT_FRM_INTERV_360P),
 	.bFrameIntervalType	= 3,
-	.dwFrameInterval[0]	= cpu_to_le32(666666),
-	.dwFrameInterval[1]	= cpu_to_le32(1000000),
-	.dwFrameInterval[2]	= cpu_to_le32(5000000),
+	.dwFrameInterval[0]	= cpu_to_le32(UVCG_FRM_INTERV_0_360P),
+	.dwFrameInterval[1]	= cpu_to_le32(UVCG_FRM_INTERV_1_360P),
+	.dwFrameInterval[2]	= cpu_to_le32(UVCG_FRM_INTERV_2_360P),
+};
+
+static u32 uvcg_frame_mjpeg_360p_dw_frame_interval[] = {
+	[0] = UVCG_FRM_INTERV_0_360P,
+	[1] = UVCG_FRM_INTERV_1_360P,
+	[2] = UVCG_FRM_INTERV_2_360P,
+};
+
+static const struct uvcg_frame uvcg_frame_mjpeg_360p = {
+	.fmt_type		= UVCG_MJPEG,
+	.frame = {
+		.b_length			= UVC_DT_FRAME_MJPEG_SIZE(3),
+		.b_descriptor_type		= USB_DT_CS_INTERFACE,
+		.b_descriptor_subtype		= UVC_VS_FRAME_MJPEG,
+		.b_frame_index			= 1,
+		.bm_capabilities		= 0,
+		.w_width			= UVCG_WIDTH_360P,
+		.w_height			= UVCG_HEIGHT_360P,
+		.dw_min_bit_rate		= UVCG_MIN_BITRATE_360P,
+		.dw_max_bit_rate		= UVCG_MAX_BITRATE_360P,
+		.dw_max_video_frame_buffer_size	= UVCG_MAX_VIDEO_FB_SZ_360P,
+		.dw_default_frame_interval	= UVCG_DEFAULT_FRM_INTERV_360P,
+		.b_frame_interval_type		= 3,
+	},
+	.dw_frame_interval	= uvcg_frame_mjpeg_360p_dw_frame_interval,
+};
+
+static struct uvcg_frame_ptr uvcg_frame_ptr_mjpeg_360p = {
+	.frm = (struct uvcg_frame *)&uvcg_frame_mjpeg_360p,
 };
 
 static const struct UVC_FRAME_MJPEG(1) uvc_frame_mjpg_720p = {
@@ -253,23 +388,44 @@ static const struct UVC_FRAME_MJPEG(1) uvc_frame_mjpg_720p = {
 	.bDescriptorSubType	= UVC_VS_FRAME_MJPEG,
 	.bFrameIndex		= 2,
 	.bmCapabilities		= 0,
-	.wWidth			= cpu_to_le16(1280),
-	.wHeight		= cpu_to_le16(720),
-	.dwMinBitRate		= cpu_to_le32(29491200),
-	.dwMaxBitRate		= cpu_to_le32(29491200),
-	.dwMaxVideoFrameBufferSize	= cpu_to_le32(1843200),
-	.dwDefaultFrameInterval	= cpu_to_le32(5000000),
+	.wWidth			= cpu_to_le16(UVCG_WIDTH_720P),
+	.wHeight		= cpu_to_le16(UVCG_HEIGHT_720P),
+	.dwMinBitRate		= cpu_to_le32(UVCG_MIN_BITRATE_720P),
+	.dwMaxBitRate		= cpu_to_le32(UVCG_MAX_BITRATE_720P),
+	.dwMaxVideoFrameBufferSize	= cpu_to_le32(UVCG_MAX_VIDEO_FB_SZ_720P),
+	.dwDefaultFrameInterval	= cpu_to_le32(UVCG_DEFAULT_FRM_INTERV_720P),
 	.bFrameIntervalType	= 1,
-	.dwFrameInterval[0]	= cpu_to_le32(5000000),
+	.dwFrameInterval[0]	= cpu_to_le32(UVCG_FRM_INTERV_0_720P),
 };
 
-static const struct uvc_color_matching_descriptor uvc_color_matching = {
-	.bLength		= UVC_DT_COLOR_MATCHING_SIZE,
-	.bDescriptorType	= USB_DT_CS_INTERFACE,
-	.bDescriptorSubType	= UVC_VS_COLORFORMAT,
-	.bColorPrimaries	= 1,
-	.bTransferCharacteristics	= 1,
-	.bMatrixCoefficients	= 4,
+static u32 uvcg_frame_mjpeg_720p_dw_frame_interval[] = {
+	[0] = UVCG_FRM_INTERV_0_720P,
+};
+
+static const struct uvcg_frame uvcg_frame_mjpeg_720p = {
+	.fmt_type		= UVCG_MJPEG,
+	.frame = {
+		.b_length			= UVC_DT_FRAME_MJPEG_SIZE(1),
+		.b_descriptor_type		= USB_DT_CS_INTERFACE,
+		.b_descriptor_subtype		= UVC_VS_FRAME_MJPEG,
+		.b_frame_index			= 2,
+		.bm_capabilities		= 0,
+		.w_width			= UVCG_WIDTH_720P,
+		.w_height			= UVCG_HEIGHT_720P,
+		.dw_min_bit_rate		= UVCG_MIN_BITRATE_720P,
+		.dw_max_bit_rate		= UVCG_MAX_BITRATE_720P,
+		.dw_max_video_frame_buffer_size	= UVCG_MAX_VIDEO_FB_SZ_720P,
+		.dw_default_frame_interval	= UVCG_DEFAULT_FRM_INTERV_720P,
+		.b_frame_interval_type		= 1,
+	},
+	.dw_frame_interval	= uvcg_frame_mjpeg_720p_dw_frame_interval,
+};
+
+static struct uvcg_frame_ptr uvcg_frame_ptr_mjpeg_720p = {
+	.frm = (struct uvcg_frame *)&uvcg_frame_mjpeg_720p,
+};
+
+static struct uvcg_streaming_header uvcg_streaming_header = {
 };
 
 static const struct uvc_descriptor_header * const uvc_fs_control_cls[] = {
@@ -290,40 +446,40 @@ static const struct uvc_descriptor_header * const uvc_ss_control_cls[] = {
 
 static const struct uvc_descriptor_header * const uvc_fs_streaming_cls[] = {
 	(const struct uvc_descriptor_header *) &uvc_input_header,
-	(const struct uvc_descriptor_header *) &uvc_format_yuv,
+	(const struct uvc_descriptor_header *) &uvcg_format_yuv.desc,
 	(const struct uvc_descriptor_header *) &uvc_frame_yuv_360p,
 	(const struct uvc_descriptor_header *) &uvc_frame_yuv_720p,
-	(const struct uvc_descriptor_header *) &uvc_color_matching,
-	(const struct uvc_descriptor_header *) &uvc_format_mjpg,
+	(const struct uvc_descriptor_header *) &uvcg_color_matching.desc,
+	(const struct uvc_descriptor_header *) &uvcg_format_mjpeg.desc,
 	(const struct uvc_descriptor_header *) &uvc_frame_mjpg_360p,
 	(const struct uvc_descriptor_header *) &uvc_frame_mjpg_720p,
-	(const struct uvc_descriptor_header *) &uvc_color_matching,
+	(const struct uvc_descriptor_header *) &uvcg_color_matching.desc,
 	NULL,
 };
 
 static const struct uvc_descriptor_header * const uvc_hs_streaming_cls[] = {
 	(const struct uvc_descriptor_header *) &uvc_input_header,
-	(const struct uvc_descriptor_header *) &uvc_format_yuv,
+	(const struct uvc_descriptor_header *) &uvcg_format_yuv.desc,
 	(const struct uvc_descriptor_header *) &uvc_frame_yuv_360p,
 	(const struct uvc_descriptor_header *) &uvc_frame_yuv_720p,
-	(const struct uvc_descriptor_header *) &uvc_color_matching,
-	(const struct uvc_descriptor_header *) &uvc_format_mjpg,
+	(const struct uvc_descriptor_header *) &uvcg_color_matching.desc,
+	(const struct uvc_descriptor_header *) &uvcg_format_mjpeg.desc,
 	(const struct uvc_descriptor_header *) &uvc_frame_mjpg_360p,
 	(const struct uvc_descriptor_header *) &uvc_frame_mjpg_720p,
-	(const struct uvc_descriptor_header *) &uvc_color_matching,
+	(const struct uvc_descriptor_header *) &uvcg_color_matching.desc,
 	NULL,
 };
 
 static const struct uvc_descriptor_header * const uvc_ss_streaming_cls[] = {
 	(const struct uvc_descriptor_header *) &uvc_input_header,
-	(const struct uvc_descriptor_header *) &uvc_format_yuv,
+	(const struct uvc_descriptor_header *) &uvcg_format_yuv.desc,
 	(const struct uvc_descriptor_header *) &uvc_frame_yuv_360p,
 	(const struct uvc_descriptor_header *) &uvc_frame_yuv_720p,
-	(const struct uvc_descriptor_header *) &uvc_color_matching,
-	(const struct uvc_descriptor_header *) &uvc_format_mjpg,
+	(const struct uvc_descriptor_header *) &uvcg_color_matching.desc,
+	(const struct uvc_descriptor_header *) &uvcg_format_mjpeg.desc,
 	(const struct uvc_descriptor_header *) &uvc_frame_mjpg_360p,
 	(const struct uvc_descriptor_header *) &uvc_frame_mjpg_720p,
-	(const struct uvc_descriptor_header *) &uvc_color_matching,
+	(const struct uvc_descriptor_header *) &uvcg_color_matching.desc,
 	NULL,
 };
 
@@ -387,6 +543,23 @@ webcam_bind(struct usb_composite_dev *cdev)
 	uvc_opts->hs_streaming = uvc_hs_streaming_cls;
 	uvc_opts->ss_streaming = uvc_ss_streaming_cls;
 
+	INIT_LIST_HEAD(&uvcg_format_yuv.fmt.frames);
+	list_add_tail(&uvcg_frame_ptr_yuv_360p.entry, &uvcg_format_yuv.fmt.frames);
+	list_add_tail(&uvcg_frame_ptr_yuv_720p.entry, &uvcg_format_yuv.fmt.frames);
+	uvcg_format_yuv.fmt.num_frames = 2;
+
+	INIT_LIST_HEAD(&uvcg_format_mjpeg.fmt.frames);
+	list_add_tail(&uvcg_frame_ptr_mjpeg_360p.entry, &uvcg_format_mjpeg.fmt.frames);
+	list_add_tail(&uvcg_frame_ptr_mjpeg_720p.entry, &uvcg_format_mjpeg.fmt.frames);
+	uvcg_format_mjpeg.fmt.num_frames = 2;
+
+	INIT_LIST_HEAD(&uvcg_streaming_header.formats);
+	list_add_tail(&uvcg_format_ptr_yuv.entry, &uvcg_streaming_header.formats);
+	list_add_tail(&uvcg_format_ptr_mjpeg.entry, &uvcg_streaming_header.formats);
+	uvcg_streaming_header.num_fmt = 2;
+
+	uvc_opts->header = &uvcg_streaming_header;
+
 	/* Allocate string descriptor numbers ... note that string contents
 	 * can be overridden by the composite_dev glue.
 	 */
-- 
2.43.0




