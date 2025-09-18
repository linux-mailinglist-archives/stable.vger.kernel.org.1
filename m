Return-Path: <stable+bounces-173320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDACB35C80
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 503DB7AEAF3
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813A52FAC1C;
	Tue, 26 Aug 2025 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RIUU6B4k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC9F2F9992;
	Tue, 26 Aug 2025 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207941; cv=none; b=qJCXEM8s6q0N0PiOn6ZYY1sC9dVdrD+Tw0mHnrTYYsR/VGopzDw7eQycFVSPV5q12rcygvqf2B6Aj0BDCcpNskUSKCzoknO9AWwgp5na8V1g570U4JAqeNe7WPFs7OljXgZId5eMg4DMCTj897sbQV5E6K8P17xEXyltfRnStRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207941; c=relaxed/simple;
	bh=5Sy58UanjlDvBeBLeHLa4YWDTkkEXRZ9Lmwb8odPJ40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ul+3/chiFoNJyoGKDJ+xzWXfE2wh+EhPkL1f39lLk54uC06LfsovYk0KuqH3pbH7R5E/iB53aZJh/p1/fnYLNs8mge5Y/FIen29bUDfVBF4wi0iMjya09O0cuYQvKqvXOrT2s9QcAgvy91pItuZoKWVVFc0tRMI5LEc7SG7Myb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RIUU6B4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA407C4CEF1;
	Tue, 26 Aug 2025 11:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756207941;
	bh=5Sy58UanjlDvBeBLeHLa4YWDTkkEXRZ9Lmwb8odPJ40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RIUU6B4kBmrl5OFqxhkN9TM+3GZXlQPPqo/gvHIVMjsMxU79SPTYwMpNYgfalPBcs
	 HOeFttiaaTmo3PPtjXS5zHpFQY5I7gAvcWUQLsTbUI8GqFrtO1gBlzHZJbrpuDCfOB
	 LmlPoZyOf9hQAOMv+y8ehD8rVf5XZlngpujEKKrM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 349/457] drm/tests: Do not use drm_fb_blit() in format-helper tests
Date: Tue, 26 Aug 2025 13:10:33 +0200
Message-ID: <20250826110945.950981244@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 5a4856e0e38109ba994f369962f054ecb445c098 ]

Export additional helpers from the format-helper library and open-code
drm_fb_blit() in tests. Prepares for the removal of drm_fb_blit(). Only
sysfb drivers use drm_fb_blit(). The function will soon be removed from
format helpers and be refactored within sysfb helpers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: José Expósito <jose.exposito89@gmail.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Link: https://lore.kernel.org/r/20250616083846.221396-2-tzimmermann@suse.de
Stable-dep-of: 05663d88fd0b ("drm/tests: Fix drm_test_fb_xrgb8888_to_xrgb2101010() on big-endian")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_format_helper.c           | 108 ++++++++++++++++--
 drivers/gpu/drm/drm_format_internal.h         |   8 ++
 .../gpu/drm/tests/drm_format_helper_test.c    | 108 +++---------------
 include/drm/drm_format_helper.h               |   9 ++
 4 files changed, 131 insertions(+), 102 deletions(-)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index d36e6cacc575..73b5a80771cc 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -857,11 +857,33 @@ static void drm_fb_xrgb8888_to_abgr8888_line(void *dbuf, const void *sbuf, unsig
 	drm_fb_xfrm_line_32to32(dbuf, sbuf, pixels, drm_pixel_xrgb8888_to_abgr8888);
 }
 
-static void drm_fb_xrgb8888_to_abgr8888(struct iosys_map *dst, const unsigned int *dst_pitch,
-					const struct iosys_map *src,
-					const struct drm_framebuffer *fb,
-					const struct drm_rect *clip,
-					struct drm_format_conv_state *state)
+/**
+ * drm_fb_xrgb8888_to_abgr8888 - Convert XRGB8888 to ABGR8888 clip buffer
+ * @dst: Array of ABGR8888 destination buffers
+ * @dst_pitch: Array of numbers of bytes between the start of two consecutive scanlines
+ *             within @dst; can be NULL if scanlines are stored next to each other.
+ * @src: Array of XRGB8888 source buffer
+ * @fb: DRM framebuffer
+ * @clip: Clip rectangle area to copy
+ * @state: Transform and conversion state
+ *
+ * This function copies parts of a framebuffer to display memory and converts the
+ * color format during the process. The parameters @dst, @dst_pitch and @src refer
+ * to arrays. Each array must have at least as many entries as there are planes in
+ * @fb's format. Each entry stores the value for the format's respective color plane
+ * at the same index.
+ *
+ * This function does not apply clipping on @dst (i.e. the destination is at the
+ * top-left corner).
+ *
+ * Drivers can use this function for ABGR8888 devices that don't support XRGB8888
+ * natively. It sets an opaque alpha channel as part of the conversion.
+ */
+void drm_fb_xrgb8888_to_abgr8888(struct iosys_map *dst, const unsigned int *dst_pitch,
+				 const struct iosys_map *src,
+				 const struct drm_framebuffer *fb,
+				 const struct drm_rect *clip,
+				 struct drm_format_conv_state *state)
 {
 	static const u8 dst_pixsize[DRM_FORMAT_MAX_PLANES] = {
 		4,
@@ -870,17 +892,40 @@ static void drm_fb_xrgb8888_to_abgr8888(struct iosys_map *dst, const unsigned in
 	drm_fb_xfrm(dst, dst_pitch, dst_pixsize, src, fb, clip, false, state,
 		    drm_fb_xrgb8888_to_abgr8888_line);
 }
+EXPORT_SYMBOL(drm_fb_xrgb8888_to_abgr8888);
 
 static void drm_fb_xrgb8888_to_xbgr8888_line(void *dbuf, const void *sbuf, unsigned int pixels)
 {
 	drm_fb_xfrm_line_32to32(dbuf, sbuf, pixels, drm_pixel_xrgb8888_to_xbgr8888);
 }
 
-static void drm_fb_xrgb8888_to_xbgr8888(struct iosys_map *dst, const unsigned int *dst_pitch,
-					const struct iosys_map *src,
-					const struct drm_framebuffer *fb,
-					const struct drm_rect *clip,
-					struct drm_format_conv_state *state)
+/**
+ * drm_fb_xrgb8888_to_xbgr8888 - Convert XRGB8888 to XBGR8888 clip buffer
+ * @dst: Array of XBGR8888 destination buffers
+ * @dst_pitch: Array of numbers of bytes between the start of two consecutive scanlines
+ *             within @dst; can be NULL if scanlines are stored next to each other.
+ * @src: Array of XRGB8888 source buffer
+ * @fb: DRM framebuffer
+ * @clip: Clip rectangle area to copy
+ * @state: Transform and conversion state
+ *
+ * This function copies parts of a framebuffer to display memory and converts the
+ * color format during the process. The parameters @dst, @dst_pitch and @src refer
+ * to arrays. Each array must have at least as many entries as there are planes in
+ * @fb's format. Each entry stores the value for the format's respective color plane
+ * at the same index.
+ *
+ * This function does not apply clipping on @dst (i.e. the destination is at the
+ * top-left corner).
+ *
+ * Drivers can use this function for XBGR8888 devices that don't support XRGB8888
+ * natively.
+ */
+void drm_fb_xrgb8888_to_xbgr8888(struct iosys_map *dst, const unsigned int *dst_pitch,
+				 const struct iosys_map *src,
+				 const struct drm_framebuffer *fb,
+				 const struct drm_rect *clip,
+				 struct drm_format_conv_state *state)
 {
 	static const u8 dst_pixsize[DRM_FORMAT_MAX_PLANES] = {
 		4,
@@ -889,6 +934,49 @@ static void drm_fb_xrgb8888_to_xbgr8888(struct iosys_map *dst, const unsigned in
 	drm_fb_xfrm(dst, dst_pitch, dst_pixsize, src, fb, clip, false, state,
 		    drm_fb_xrgb8888_to_xbgr8888_line);
 }
+EXPORT_SYMBOL(drm_fb_xrgb8888_to_xbgr8888);
+
+static void drm_fb_xrgb8888_to_bgrx8888_line(void *dbuf, const void *sbuf, unsigned int pixels)
+{
+	drm_fb_xfrm_line_32to32(dbuf, sbuf, pixels, drm_pixel_xrgb8888_to_bgrx8888);
+}
+
+/**
+ * drm_fb_xrgb8888_to_bgrx8888 - Convert XRGB8888 to BGRX8888 clip buffer
+ * @dst: Array of BGRX8888 destination buffers
+ * @dst_pitch: Array of numbers of bytes between the start of two consecutive scanlines
+ *             within @dst; can be NULL if scanlines are stored next to each other.
+ * @src: Array of XRGB8888 source buffer
+ * @fb: DRM framebuffer
+ * @clip: Clip rectangle area to copy
+ * @state: Transform and conversion state
+ *
+ * This function copies parts of a framebuffer to display memory and converts the
+ * color format during the process. The parameters @dst, @dst_pitch and @src refer
+ * to arrays. Each array must have at least as many entries as there are planes in
+ * @fb's format. Each entry stores the value for the format's respective color plane
+ * at the same index.
+ *
+ * This function does not apply clipping on @dst (i.e. the destination is at the
+ * top-left corner).
+ *
+ * Drivers can use this function for BGRX8888 devices that don't support XRGB8888
+ * natively.
+ */
+void drm_fb_xrgb8888_to_bgrx8888(struct iosys_map *dst, const unsigned int *dst_pitch,
+				 const struct iosys_map *src,
+				 const struct drm_framebuffer *fb,
+				 const struct drm_rect *clip,
+				 struct drm_format_conv_state *state)
+{
+	static const u8 dst_pixsize[DRM_FORMAT_MAX_PLANES] = {
+		4,
+	};
+
+	drm_fb_xfrm(dst, dst_pitch, dst_pixsize, src, fb, clip, false, state,
+		    drm_fb_xrgb8888_to_bgrx8888_line);
+}
+EXPORT_SYMBOL(drm_fb_xrgb8888_to_bgrx8888);
 
 static void drm_fb_xrgb8888_to_xrgb2101010_line(void *dbuf, const void *sbuf, unsigned int pixels)
 {
diff --git a/drivers/gpu/drm/drm_format_internal.h b/drivers/gpu/drm/drm_format_internal.h
index 9f857bfa368d..0aa458b8a3e0 100644
--- a/drivers/gpu/drm/drm_format_internal.h
+++ b/drivers/gpu/drm/drm_format_internal.h
@@ -111,6 +111,14 @@ static inline u32 drm_pixel_xrgb8888_to_xbgr8888(u32 pix)
 	       ((pix & 0x000000ff) << 16);
 }
 
+static inline u32 drm_pixel_xrgb8888_to_bgrx8888(u32 pix)
+{
+	return ((pix & 0xff000000) >> 24) | /* also copy filler bits */
+	       ((pix & 0x00ff0000) >> 8) |
+	       ((pix & 0x0000ff00) << 8) |
+	       ((pix & 0x000000ff) << 24);
+}
+
 static inline u32 drm_pixel_xrgb8888_to_abgr8888(u32 pix)
 {
 	return GENMASK(31, 24) | /* fill alpha bits */
diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index 2a3d80b27cae..8b62adbd4dfa 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -748,14 +748,9 @@ static void drm_test_fb_xrgb8888_to_rgb565(struct kunit *test)
 	buf = dst.vaddr;
 	memset(buf, 0, dst_size);
 
-	int blit_result = 0;
-
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_RGB565, &src, &fb, &params->clip,
-				  &fmtcnv_state);
-
+	drm_fb_xrgb8888_to_rgb565(&dst, dst_pitch, &src, &fb, &params->clip,
+				  &fmtcnv_state, false);
 	buf = le16buf_to_cpu(test, (__force const __le16 *)buf, dst_size / sizeof(__le16));
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
@@ -795,14 +790,8 @@ static void drm_test_fb_xrgb8888_to_xrgb1555(struct kunit *test)
 	buf = dst.vaddr; /* restore original value of buf */
 	memset(buf, 0, dst_size);
 
-	int blit_result = 0;
-
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_XRGB1555, &src, &fb, &params->clip,
-				  &fmtcnv_state);
-
+	drm_fb_xrgb8888_to_xrgb1555(&dst, dst_pitch, &src, &fb, &params->clip, &fmtcnv_state);
 	buf = le16buf_to_cpu(test, (__force const __le16 *)buf, dst_size / sizeof(__le16));
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
@@ -842,14 +831,8 @@ static void drm_test_fb_xrgb8888_to_argb1555(struct kunit *test)
 	buf = dst.vaddr; /* restore original value of buf */
 	memset(buf, 0, dst_size);
 
-	int blit_result = 0;
-
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_ARGB1555, &src, &fb, &params->clip,
-				  &fmtcnv_state);
-
+	drm_fb_xrgb8888_to_argb1555(&dst, dst_pitch, &src, &fb, &params->clip, &fmtcnv_state);
 	buf = le16buf_to_cpu(test, (__force const __le16 *)buf, dst_size / sizeof(__le16));
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
@@ -889,14 +872,8 @@ static void drm_test_fb_xrgb8888_to_rgba5551(struct kunit *test)
 	buf = dst.vaddr; /* restore original value of buf */
 	memset(buf, 0, dst_size);
 
-	int blit_result = 0;
-
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_RGBA5551, &src, &fb, &params->clip,
-				  &fmtcnv_state);
-
+	drm_fb_xrgb8888_to_rgba5551(&dst, dst_pitch, &src, &fb, &params->clip, &fmtcnv_state);
 	buf = le16buf_to_cpu(test, (__force const __le16 *)buf, dst_size / sizeof(__le16));
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
@@ -939,12 +916,7 @@ static void drm_test_fb_xrgb8888_to_rgb888(struct kunit *test)
 	buf = dst.vaddr; /* restore original value of buf */
 	memset(buf, 0, dst_size);
 
-	int blit_result = 0;
-
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_RGB888, &src, &fb, &params->clip,
-				  &fmtcnv_state);
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
+	drm_fb_xrgb8888_to_rgb888(&dst, dst_pitch, &src, &fb, &params->clip, &fmtcnv_state);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
@@ -985,12 +957,8 @@ static void drm_test_fb_xrgb8888_to_bgr888(struct kunit *test)
 	buf = dst.vaddr; /* restore original value of buf */
 	memset(buf, 0, dst_size);
 
-	int blit_result = 0;
-
-	blit_result = drm_fb_blit(&dst, &result->dst_pitch, DRM_FORMAT_BGR888, &src, &fb, &params->clip,
+	drm_fb_xrgb8888_to_bgr888(&dst, &result->dst_pitch, &src, &fb, &params->clip,
 				  &fmtcnv_state);
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
@@ -1030,14 +998,8 @@ static void drm_test_fb_xrgb8888_to_argb8888(struct kunit *test)
 	buf = dst.vaddr; /* restore original value of buf */
 	memset(buf, 0, dst_size);
 
-	int blit_result = 0;
-
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_ARGB8888, &src, &fb, &params->clip,
-				  &fmtcnv_state);
-
+	drm_fb_xrgb8888_to_argb8888(&dst, dst_pitch, &src, &fb, &params->clip, &fmtcnv_state);
 	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
@@ -1077,12 +1039,7 @@ static void drm_test_fb_xrgb8888_to_xrgb2101010(struct kunit *test)
 	buf = dst.vaddr; /* restore original value of buf */
 	memset(buf, 0, dst_size);
 
-	int blit_result = 0;
-
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_XRGB2101010, &src, &fb,
-				  &params->clip, &fmtcnv_state);
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
+	drm_fb_xrgb8888_to_xrgb2101010(&dst, dst_pitch, &src, &fb, &params->clip, &fmtcnv_state);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
@@ -1122,14 +1079,8 @@ static void drm_test_fb_xrgb8888_to_argb2101010(struct kunit *test)
 	buf = dst.vaddr; /* restore original value of buf */
 	memset(buf, 0, dst_size);
 
-	int blit_result = 0;
-
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_ARGB2101010, &src, &fb,
-				  &params->clip, &fmtcnv_state);
-
+	drm_fb_xrgb8888_to_argb2101010(&dst, dst_pitch, &src, &fb, &params->clip, &fmtcnv_state);
 	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
@@ -1202,23 +1153,15 @@ static void drm_test_fb_swab(struct kunit *test)
 	buf = dst.vaddr; /* restore original value of buf */
 	memset(buf, 0, dst_size);
 
-	int blit_result;
-
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_XRGB8888 | DRM_FORMAT_BIG_ENDIAN,
-				  &src, &fb, &params->clip, &fmtcnv_state);
+	drm_fb_swab(&dst, dst_pitch, &src, &fb, &params->clip, false, &fmtcnv_state);
 	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 
 	buf = dst.vaddr;
 	memset(buf, 0, dst_size);
 
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_BGRX8888, &src, &fb, &params->clip,
-				  &fmtcnv_state);
+	drm_fb_xrgb8888_to_bgrx8888(&dst, dst_pitch, &src, &fb, &params->clip, &fmtcnv_state);
 	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 
 	buf = dst.vaddr;
@@ -1229,11 +1172,8 @@ static void drm_test_fb_swab(struct kunit *test)
 	mock_format.format |= DRM_FORMAT_BIG_ENDIAN;
 	fb.format = &mock_format;
 
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_XRGB8888, &src, &fb, &params->clip,
-				  &fmtcnv_state);
+	drm_fb_swab(&dst, dst_pitch, &src, &fb, &params->clip, false, &fmtcnv_state);
 	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
@@ -1266,14 +1206,8 @@ static void drm_test_fb_xrgb8888_to_abgr8888(struct kunit *test)
 	const unsigned int *dst_pitch = (result->dst_pitch == TEST_USE_DEFAULT_PITCH) ?
 		NULL : &result->dst_pitch;
 
-	int blit_result = 0;
-
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_ABGR8888, &src, &fb, &params->clip,
-				  &fmtcnv_state);
-
+	drm_fb_xrgb8888_to_abgr8888(&dst, dst_pitch, &src, &fb, &params->clip, &fmtcnv_state);
 	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
@@ -1306,14 +1240,8 @@ static void drm_test_fb_xrgb8888_to_xbgr8888(struct kunit *test)
 	const unsigned int *dst_pitch = (result->dst_pitch == TEST_USE_DEFAULT_PITCH) ?
 		NULL : &result->dst_pitch;
 
-	int blit_result = 0;
-
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_XBGR8888, &src, &fb, &params->clip,
-				  &fmtcnv_state);
-
+	drm_fb_xrgb8888_to_xbgr8888(&dst, dst_pitch, &src, &fb, &params->clip, &fmtcnv_state);
 	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
@@ -1910,12 +1838,8 @@ static void drm_test_fb_memcpy(struct kunit *test)
 		memset(buf[i], 0, dst_size[i]);
 	}
 
-	int blit_result;
-
-	blit_result = drm_fb_blit(dst, dst_pitches, params->format, src, &fb, &params->clip,
-				  &fmtcnv_state);
+	drm_fb_memcpy(dst, dst_pitches, src, &fb, &params->clip);
 
-	KUNIT_EXPECT_FALSE(test, blit_result);
 	for (size_t i = 0; i < fb.format->num_planes; i++) {
 		expected[i] = cpubuf_to_le32(test, params->expected[i], TEST_BUF_SIZE);
 		KUNIT_EXPECT_MEMEQ_MSG(test, buf[i], expected[i], dst_size[i],
diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index d8539174ca11..49a2e09155d1 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -102,6 +102,15 @@ void drm_fb_xrgb8888_to_bgr888(struct iosys_map *dst, const unsigned int *dst_pi
 void drm_fb_xrgb8888_to_argb8888(struct iosys_map *dst, const unsigned int *dst_pitch,
 				 const struct iosys_map *src, const struct drm_framebuffer *fb,
 				 const struct drm_rect *clip, struct drm_format_conv_state *state);
+void drm_fb_xrgb8888_to_abgr8888(struct iosys_map *dst, const unsigned int *dst_pitch,
+				 const struct iosys_map *src, const struct drm_framebuffer *fb,
+				 const struct drm_rect *clip, struct drm_format_conv_state *state);
+void drm_fb_xrgb8888_to_xbgr8888(struct iosys_map *dst, const unsigned int *dst_pitch,
+				 const struct iosys_map *src, const struct drm_framebuffer *fb,
+				 const struct drm_rect *clip, struct drm_format_conv_state *state);
+void drm_fb_xrgb8888_to_bgrx8888(struct iosys_map *dst, const unsigned int *dst_pitch,
+				 const struct iosys_map *src, const struct drm_framebuffer *fb,
+				 const struct drm_rect *clip, struct drm_format_conv_state *state);
 void drm_fb_xrgb8888_to_xrgb2101010(struct iosys_map *dst, const unsigned int *dst_pitch,
 				    const struct iosys_map *src, const struct drm_framebuffer *fb,
 				    const struct drm_rect *clip,
-- 
2.50.1




