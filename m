Return-Path: <stable+bounces-51447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2F0906FE5
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466061C227BE
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652671428F0;
	Thu, 13 Jun 2024 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z5bJawhH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203CE6EB56;
	Thu, 13 Jun 2024 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281325; cv=none; b=bJHZCznvK8gkWemmbUITlkV3yKFIPmV0sErVF4sfjk7hmx5FjxpmsJlJITZzhP9zoOB93npzNXDtCbwJ1hZJ88oqCQg2Ne816MVpjx/fuFY7b+4VLF3/9qBqHIewpPyxi7/Q8q8qa5/P5g5WVTnuKl28Tu6soHRgZikFq32v0Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281325; c=relaxed/simple;
	bh=dDEczvzQbZ7oJETiN3mzw/u1Net4+B8bmSS6bo66+/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8k3bZd/oYD05nHawLsqQwZ7HQiXC2YuDn1TUI3QFaMkV6oARgri9nac17N7f6oro+NFvNjjvhVdoarHonj9zUG6QQX+1U7tEDmIZ5vBUZ2xj2NR2VNrYKUvxbe5Thz+HozTviXxqLGdvqZL5UcYa/nsk6ScM74GTr1ad/8+itE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z5bJawhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC27C2BBFC;
	Thu, 13 Jun 2024 12:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281325;
	bh=dDEczvzQbZ7oJETiN3mzw/u1Net4+B8bmSS6bo66+/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z5bJawhHGcSq4j9vdfzqbs5FP+RfRWdcKY1CuGjVoKKyLOurqet01TN92nJhmqkTE
	 MTUUFFhJKK400h77bRasyLW5VKyNdPKTDSwBLl+vqpA+DNAQeH/z3XoliyeXs7ZHQi
	 TKtx9/K44LoIuSkkaGuATL9WFJHZ5RdgOvjWcmmU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 216/317] media: core headers: fix kernel-doc warnings
Date: Thu, 13 Jun 2024 13:33:54 +0200
Message-ID: <20240613113255.909949991@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>
References: <20240613113247.525431100@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit f12b81e47f48940a6ec82ff308a7d97cd2307442 ]

This patch fixes the following kernel-doc warnings:

include/uapi/linux/videodev2.h:996: warning: Function parameter or member 'm' not described in 'v4l2_plane'
include/uapi/linux/videodev2.h:996: warning: Function parameter or member 'reserved' not described in 'v4l2_plane'
include/uapi/linux/videodev2.h:1057: warning: Function parameter or member 'm' not described in 'v4l2_buffer'
include/uapi/linux/videodev2.h:1057: warning: Function parameter or member 'reserved2' not described in 'v4l2_buffer'
include/uapi/linux/videodev2.h:1057: warning: Function parameter or member 'reserved' not described in 'v4l2_buffer'
include/uapi/linux/videodev2.h:1068: warning: Function parameter or member 'tv' not described in 'v4l2_timeval_to_ns'
include/uapi/linux/videodev2.h:1068: warning: Excess function parameter 'ts' description in 'v4l2_timeval_to_ns'
include/uapi/linux/videodev2.h:1138: warning: Function parameter or member 'reserved' not described in 'v4l2_exportbuffer'
include/uapi/linux/videodev2.h:2237: warning: Function parameter or member 'reserved' not described in 'v4l2_plane_pix_format'
include/uapi/linux/videodev2.h:2270: warning: Function parameter or member 'hsv_enc' not described in 'v4l2_pix_format_mplane'
include/uapi/linux/videodev2.h:2270: warning: Function parameter or member 'reserved' not described in 'v4l2_pix_format_mplane'
include/uapi/linux/videodev2.h:2281: warning: Function parameter or member 'reserved' not described in 'v4l2_sdr_format'
include/uapi/linux/videodev2.h:2315: warning: Function parameter or member 'fmt' not described in 'v4l2_format'

include/uapi/linux/v4l2-subdev.h:53: warning: Function parameter or member 'reserved' not described in 'v4l2_subdev_format'
include/uapi/linux/v4l2-subdev.h:66: warning: Function parameter or member 'reserved' not described in 'v4l2_subdev_crop'
include/uapi/linux/v4l2-subdev.h:89: warning: Function parameter or member 'reserved' not described in 'v4l2_subdev_mbus_code_enum'
include/uapi/linux/v4l2-subdev.h:108: warning: Function parameter or member 'min_width' not described in 'v4l2_subdev_frame_size_enum'
include/uapi/linux/v4l2-subdev.h:108: warning: Function parameter or member 'max_width' not described in 'v4l2_subdev_frame_size_enum'
include/uapi/linux/v4l2-subdev.h:108: warning: Function parameter or member 'min_height' not described in 'v4l2_subdev_frame_size_enum'
include/uapi/linux/v4l2-subdev.h:108: warning: Function parameter or member 'max_height' not described in 'v4l2_subdev_frame_size_enum'
include/uapi/linux/v4l2-subdev.h:108: warning: Function parameter or member 'reserved' not described in 'v4l2_subdev_frame_size_enum'
include/uapi/linux/v4l2-subdev.h:119: warning: Function parameter or member 'reserved' not described in 'v4l2_subdev_frame_interval'
include/uapi/linux/v4l2-subdev.h:140: warning: Function parameter or member 'reserved' not described in 'v4l2_subdev_frame_interval_enum'

include/uapi/linux/cec.h:406: warning: Function parameter or member 'raw' not described in 'cec_connector_info'
include/uapi/linux/cec.h:470: warning: Function parameter or member 'flags' not described in 'cec_event'

include/media/v4l2-h264.h:82: warning: Function parameter or member 'reflist' not described in 'v4l2_h264_build_p_ref_list'
include/media/v4l2-h264.h:82: warning: expecting prototype for v4l2_h264_build_b_ref_lists(). Prototype was for v4l2_h264_build_p_ref_list()
instead

include/media/cec.h:50: warning: Function parameter or member 'lock' not described in 'cec_devnode'

include/media/v4l2-jpeg.h:122: warning: Function parameter or member 'num_dht' not described in 'v4l2_jpeg_header'
include/media/v4l2-jpeg.h:122: warning: Function parameter or member 'num_dqt' not described in 'v4l2_jpeg_header'

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: 47c82aac10a6 ("media: cec: core: avoid recursive cec_claim_log_addrs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/media/cec.h              |  2 +-
 include/media/v4l2-h264.h        |  6 +++---
 include/media/v4l2-jpeg.h        |  2 ++
 include/uapi/linux/cec.h         |  3 ++-
 include/uapi/linux/v4l2-subdev.h | 12 +++++++++++-
 include/uapi/linux/videodev2.h   | 15 ++++++++++++++-
 6 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/include/media/cec.h b/include/media/cec.h
index cd35ae6b7560f..208c9613c07eb 100644
--- a/include/media/cec.h
+++ b/include/media/cec.h
@@ -28,8 +28,8 @@
  * @minor:	device node minor number
  * @registered:	the device was correctly registered
  * @unregistered: the device was unregistered
- * @fhs_lock:	lock to control access to the filehandle list
  * @fhs:	the list of open filehandles (cec_fh)
+ * @lock:	lock to control access to this structure
  *
  * This structure represents a cec-related device node.
  *
diff --git a/include/media/v4l2-h264.h b/include/media/v4l2-h264.h
index f08ba181263d1..1cc89d2e693a3 100644
--- a/include/media/v4l2-h264.h
+++ b/include/media/v4l2-h264.h
@@ -66,11 +66,11 @@ v4l2_h264_build_b_ref_lists(const struct v4l2_h264_reflist_builder *builder,
 			    u8 *b0_reflist, u8 *b1_reflist);
 
 /**
- * v4l2_h264_build_b_ref_lists() - Build the P reference list
+ * v4l2_h264_build_p_ref_list() - Build the P reference list
  *
  * @builder: reference list builder context
- * @p_reflist: 16-bytes array used to store the P reference list. Each entry
- *	       is an index in the DPB
+ * @reflist: 16-bytes array used to store the P reference list. Each entry
+ *	     is an index in the DPB
  *
  * This functions builds the P reference lists. This procedure is describe in
  * section '8.2.4 Decoding process for reference picture lists construction'
diff --git a/include/media/v4l2-jpeg.h b/include/media/v4l2-jpeg.h
index ddba2a56c3214..3a3344a976782 100644
--- a/include/media/v4l2-jpeg.h
+++ b/include/media/v4l2-jpeg.h
@@ -91,7 +91,9 @@ struct v4l2_jpeg_scan_header {
  * struct v4l2_jpeg_header - parsed JPEG header
  * @sof: pointer to frame header and size
  * @sos: pointer to scan header and size
+ * @num_dht: number of entries in @dht
  * @dht: pointers to huffman tables and sizes
+ * @num_dqt: number of entries in @dqt
  * @dqt: pointers to quantization tables and sizes
  * @frame: parsed frame header
  * @scan: pointer to parsed scan header, optional
diff --git a/include/uapi/linux/cec.h b/include/uapi/linux/cec.h
index 7d1a06c524696..dc8879d179fdf 100644
--- a/include/uapi/linux/cec.h
+++ b/include/uapi/linux/cec.h
@@ -396,6 +396,7 @@ struct cec_drm_connector_info {
  * associated with the CEC adapter.
  * @type: connector type (if any)
  * @drm: drm connector info
+ * @raw: array to pad the union
  */
 struct cec_connector_info {
 	__u32 type;
@@ -453,7 +454,7 @@ struct cec_event_lost_msgs {
  * struct cec_event - CEC event structure
  * @ts: the timestamp of when the event was sent.
  * @event: the event.
- * array.
+ * @flags: event flags.
  * @state_change: the event payload for CEC_EVENT_STATE_CHANGE.
  * @lost_msgs: the event payload for CEC_EVENT_LOST_MSGS.
  * @raw: array to pad the union.
diff --git a/include/uapi/linux/v4l2-subdev.h b/include/uapi/linux/v4l2-subdev.h
index a38454d9e0f54..658106f5b5dc9 100644
--- a/include/uapi/linux/v4l2-subdev.h
+++ b/include/uapi/linux/v4l2-subdev.h
@@ -44,6 +44,7 @@ enum v4l2_subdev_format_whence {
  * @which: format type (from enum v4l2_subdev_format_whence)
  * @pad: pad number, as reported by the media API
  * @format: media bus format (format code and frame size)
+ * @reserved: drivers and applications must zero this array
  */
 struct v4l2_subdev_format {
 	__u32 which;
@@ -57,6 +58,7 @@ struct v4l2_subdev_format {
  * @which: format type (from enum v4l2_subdev_format_whence)
  * @pad: pad number, as reported by the media API
  * @rect: pad crop rectangle boundaries
+ * @reserved: drivers and applications must zero this array
  */
 struct v4l2_subdev_crop {
 	__u32 which;
@@ -78,6 +80,7 @@ struct v4l2_subdev_crop {
  * @code: format code (MEDIA_BUS_FMT_ definitions)
  * @which: format type (from enum v4l2_subdev_format_whence)
  * @flags: flags set by the driver, (V4L2_SUBDEV_MBUS_CODE_*)
+ * @reserved: drivers and applications must zero this array
  */
 struct v4l2_subdev_mbus_code_enum {
 	__u32 pad;
@@ -90,10 +93,15 @@ struct v4l2_subdev_mbus_code_enum {
 
 /**
  * struct v4l2_subdev_frame_size_enum - Media bus format enumeration
- * @pad: pad number, as reported by the media API
  * @index: format index during enumeration
+ * @pad: pad number, as reported by the media API
  * @code: format code (MEDIA_BUS_FMT_ definitions)
+ * @min_width: minimum frame width, in pixels
+ * @max_width: maximum frame width, in pixels
+ * @min_height: minimum frame height, in pixels
+ * @max_height: maximum frame height, in pixels
  * @which: format type (from enum v4l2_subdev_format_whence)
+ * @reserved: drivers and applications must zero this array
  */
 struct v4l2_subdev_frame_size_enum {
 	__u32 index;
@@ -111,6 +119,7 @@ struct v4l2_subdev_frame_size_enum {
  * struct v4l2_subdev_frame_interval - Pad-level frame rate
  * @pad: pad number, as reported by the media API
  * @interval: frame interval in seconds
+ * @reserved: drivers and applications must zero this array
  */
 struct v4l2_subdev_frame_interval {
 	__u32 pad;
@@ -127,6 +136,7 @@ struct v4l2_subdev_frame_interval {
  * @height: frame height in pixels
  * @interval: frame interval in seconds
  * @which: format type (from enum v4l2_subdev_format_whence)
+ * @reserved: drivers and applications must zero this array
  */
 struct v4l2_subdev_frame_interval_enum {
 	__u32 index;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 55b8c4b824797..1bbd81f031fe0 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -976,8 +976,10 @@ struct v4l2_requestbuffers {
  *			pointing to this plane
  * @fd:			when memory is V4L2_MEMORY_DMABUF, a userspace file
  *			descriptor associated with this plane
+ * @m:			union of @mem_offset, @userptr and @fd
  * @data_offset:	offset in the plane to the start of data; usually 0,
  *			unless there is a header in front of the data
+ * @reserved:		drivers and applications must zero this array
  *
  * Multi-planar buffers consist of one or more planes, e.g. an YCbCr buffer
  * with two planes can have one plane for Y, and another for interleaved CbCr
@@ -1019,10 +1021,14 @@ struct v4l2_plane {
  *		a userspace file descriptor associated with this buffer
  * @planes:	for multiplanar buffers; userspace pointer to the array of plane
  *		info structs for this buffer
+ * @m:		union of @offset, @userptr, @planes and @fd
  * @length:	size in bytes of the buffer (NOT its payload) for single-plane
  *		buffers (when type != *_MPLANE); number of elements in the
  *		planes array for multi-plane buffers
+ * @reserved2:	drivers and applications must zero this field
  * @request_fd: fd of the request that this buffer should use
+ * @reserved:	for backwards compatibility with applications that do not know
+ *		about @request_fd
  *
  * Contains data exchanged by application and driver using one of the Streaming
  * I/O methods.
@@ -1060,7 +1066,7 @@ struct v4l2_buffer {
 #ifndef __KERNEL__
 /**
  * v4l2_timeval_to_ns - Convert timeval to nanoseconds
- * @ts:		pointer to the timeval variable to be converted
+ * @tv:		pointer to the timeval variable to be converted
  *
  * Returns the scalar nanosecond representation of the timeval
  * parameter.
@@ -1121,6 +1127,7 @@ static inline __u64 v4l2_timeval_to_ns(const struct timeval *tv)
  * @flags:	flags for newly created file, currently only O_CLOEXEC is
  *		supported, refer to manual of open syscall for more details
  * @fd:		file descriptor associated with DMABUF (set by driver)
+ * @reserved:	drivers and applications must zero this array
  *
  * Contains data used for exporting a video buffer as DMABUF file descriptor.
  * The buffer is identified by a 'cookie' returned by VIDIOC_QUERYBUF
@@ -2215,6 +2222,7 @@ struct v4l2_mpeg_vbi_fmt_ivtv {
  *			this plane will be used
  * @bytesperline:	distance in bytes between the leftmost pixels in two
  *			adjacent lines
+ * @reserved:		drivers and applications must zero this array
  */
 struct v4l2_plane_pix_format {
 	__u32		sizeimage;
@@ -2233,8 +2241,10 @@ struct v4l2_plane_pix_format {
  * @num_planes:		number of planes for this format
  * @flags:		format flags (V4L2_PIX_FMT_FLAG_*)
  * @ycbcr_enc:		enum v4l2_ycbcr_encoding, Y'CbCr encoding
+ * @hsv_enc:		enum v4l2_hsv_encoding, HSV encoding
  * @quantization:	enum v4l2_quantization, colorspace quantization
  * @xfer_func:		enum v4l2_xfer_func, colorspace transfer function
+ * @reserved:		drivers and applications must zero this array
  */
 struct v4l2_pix_format_mplane {
 	__u32				width;
@@ -2259,6 +2269,7 @@ struct v4l2_pix_format_mplane {
  * struct v4l2_sdr_format - SDR format definition
  * @pixelformat:	little endian four character code (fourcc)
  * @buffersize:		maximum size in bytes required for data
+ * @reserved:		drivers and applications must zero this array
  */
 struct v4l2_sdr_format {
 	__u32				pixelformat;
@@ -2285,6 +2296,8 @@ struct v4l2_meta_format {
  * @vbi:	raw VBI capture or output parameters
  * @sliced:	sliced VBI capture or output parameters
  * @raw_data:	placeholder for future extensions and custom formats
+ * @fmt:	union of @pix, @pix_mp, @win, @vbi, @sliced, @sdr, @meta
+ *		and @raw_data
  */
 struct v4l2_format {
 	__u32	 type;
-- 
2.43.0




