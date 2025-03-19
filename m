Return-Path: <stable+bounces-125261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B129A69092
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665FE885A54
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BAB1E1DF4;
	Wed, 19 Mar 2025 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zn3RtMBM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C721C5F26;
	Wed, 19 Mar 2025 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395065; cv=none; b=adKzOJB4+H3lcWsnmZgofx1t6HX+4SBrf0KOt+QboL2TlW7EOSpW5tfiKHZoUl6XosoVuo2IEbNQnGcPUQ74wkGPeIupt75C/z5chdIFpsURwtDe+dxHf3oGJzUmBpw8J8P5vZwLm+N7vDqv+znDr8PwWIW8TNAfFPjY98bL/Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395065; c=relaxed/simple;
	bh=u23H56AMD10V832nFKYCl66g3RUHpCy4YbuRp61u8O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g32Abe9QhCG7pnvvvRWG9LsXe1ZiyTH+Yn6oJQeEgKqqPn6EavD8GulOnnWKDAgzhv7r0Tv4A9abXUbRUG9OH3xbrvpTVJHw8ZsmX5EijyWO11msq2WIAQ+JdSqUct8JJ39fI/X6Kl3dfxiIh8ULZr5OyCdjeqvz3VyDS168qvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zn3RtMBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D085C4CEE4;
	Wed, 19 Mar 2025 14:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395065;
	bh=u23H56AMD10V832nFKYCl66g3RUHpCy4YbuRp61u8O8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zn3RtMBMoGrhzcrcQE0e7odLdqDZTlFeMqjzPyrpXoR9Ctao1EC8cOauNynNwZnDY
	 NRnE/gjIjHwgeKtPjZuih8y20V/h76BsjfbhQH4lA61SXz0HhmFFzs4ta3w5KxGN8B
	 08WNbwBffk8stqKz+sQkAVV7Dp/unexde+bTsNRA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 101/231] drm/tests: hdmi: Fix recursive locking
Date: Wed, 19 Mar 2025 07:29:54 -0700
Message-ID: <20250319143029.332216126@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143026.865956961@linuxfoundation.org>
References: <20250319143026.865956961@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maxime Ripard <mripard@kernel.org>

[ Upstream commit 5d14c08a47460e8eedf0185a28b116420ea7f29d ]

The find_preferred_mode() functions takes the mode_config mutex, but due
to the order most tests have, is called with the crtc_ww_class_mutex
taken. This raises a warning for a circular dependency when running the
tests with lockdep.

Reorder the tests to call find_preferred_mode before the acquire context
has been created to avoid the issue.

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20250129-test-kunit-v2-4-fe59c43805d5@kernel.org
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/tests/drm_hdmi_state_helper_test.c    | 114 +++++++++---------
 1 file changed, 57 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 1dfd346c6fb39..383fbe128348e 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -262,12 +262,12 @@ static void drm_test_check_broadcast_rgb_crtc_mode_changed(struct kunit *test)
 	crtc = priv->crtc;
 	conn = &priv->connector;
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
 	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -326,12 +326,12 @@ static void drm_test_check_broadcast_rgb_crtc_mode_not_changed(struct kunit *tes
 	crtc = priv->crtc;
 	conn = &priv->connector;
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
 	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -391,13 +391,13 @@ static void drm_test_check_broadcast_rgb_auto_cea_mode(struct kunit *test)
 	conn = &priv->connector;
 	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 	KUNIT_ASSERT_NE(test, drm_match_cea_mode(preferred), 1);
 
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
 	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -502,13 +502,13 @@ static void drm_test_check_broadcast_rgb_full_cea_mode(struct kunit *test)
 	conn = &priv->connector;
 	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 	KUNIT_ASSERT_NE(test, drm_match_cea_mode(preferred), 1);
 
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
 	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -617,13 +617,13 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode(struct kunit *test)
 	conn = &priv->connector;
 	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 	KUNIT_ASSERT_NE(test, drm_match_cea_mode(preferred), 1);
 
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
 	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -737,12 +737,12 @@ static void drm_test_check_output_bpc_crtc_mode_changed(struct kunit *test)
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz));
 	KUNIT_ASSERT_GT(test, ret, 0);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
 	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -811,12 +811,12 @@ static void drm_test_check_output_bpc_crtc_mode_not_changed(struct kunit *test)
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz));
 	KUNIT_ASSERT_GT(test, ret, 0);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
 	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -885,12 +885,12 @@ static void drm_test_check_output_bpc_dvi(struct kunit *test)
 	info = &conn->display_info;
 	KUNIT_ASSERT_FALSE(test, info->is_hdmi);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
 	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -929,13 +929,13 @@ static void drm_test_check_tmds_char_rate_rgb_8bpc(struct kunit *test)
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_max_200mhz));
 	KUNIT_ASSERT_GT(test, ret, 0);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 	KUNIT_ASSERT_FALSE(test, preferred->flags & DRM_MODE_FLAG_DBLCLK);
 
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
 	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -976,13 +976,13 @@ static void drm_test_check_tmds_char_rate_rgb_10bpc(struct kunit *test)
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz));
 	KUNIT_ASSERT_GT(test, ret, 0);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 	KUNIT_ASSERT_FALSE(test, preferred->flags & DRM_MODE_FLAG_DBLCLK);
 
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
 	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -1023,13 +1023,13 @@ static void drm_test_check_tmds_char_rate_rgb_12bpc(struct kunit *test)
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz));
 	KUNIT_ASSERT_GT(test, ret, 0);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 	KUNIT_ASSERT_FALSE(test, preferred->flags & DRM_MODE_FLAG_DBLCLK);
 
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
 	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -1070,12 +1070,12 @@ static void drm_test_check_hdmi_funcs_reject_rate(struct kunit *test)
 	crtc = priv->crtc;
 	conn = &priv->connector;
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
 	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -1135,9 +1135,6 @@ static void drm_test_check_max_tmds_rate_bpc_fallback(struct kunit *test)
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
 	KUNIT_ASSERT_GT(test, info->max_tmds_clock, 0);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 	KUNIT_ASSERT_FALSE(test, preferred->flags & DRM_MODE_FLAG_DBLCLK);
@@ -1148,6 +1145,9 @@ static void drm_test_check_max_tmds_rate_bpc_fallback(struct kunit *test)
 	rate = drm_hdmi_compute_mode_clock(preferred, 10, HDMI_COLORSPACE_RGB);
 	KUNIT_ASSERT_LT(test, rate, info->max_tmds_clock * 1000);
 
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
 	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
@@ -1204,9 +1204,6 @@ static void drm_test_check_max_tmds_rate_format_fallback(struct kunit *test)
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
 	KUNIT_ASSERT_GT(test, info->max_tmds_clock, 0);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 	KUNIT_ASSERT_FALSE(test, preferred->flags & DRM_MODE_FLAG_DBLCLK);
@@ -1220,6 +1217,9 @@ static void drm_test_check_max_tmds_rate_format_fallback(struct kunit *test)
 	rate = drm_hdmi_compute_mode_clock(preferred, 12, HDMI_COLORSPACE_YUV422);
 	KUNIT_ASSERT_LT(test, rate, info->max_tmds_clock * 1000);
 
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
 	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
@@ -1266,9 +1266,6 @@ static void drm_test_check_output_bpc_format_vic_1(struct kunit *test)
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
 	KUNIT_ASSERT_GT(test, info->max_tmds_clock, 0);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-
 	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 1);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
@@ -1282,6 +1279,9 @@ static void drm_test_check_output_bpc_format_vic_1(struct kunit *test)
 	rate = mode->clock * 1500;
 	KUNIT_ASSERT_LT(test, rate, info->max_tmds_clock * 1000);
 
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
 	crtc = priv->crtc;
 	ret = light_up_connector(test, drm, crtc, conn, mode, ctx);
 	KUNIT_EXPECT_EQ(test, ret, 0);
@@ -1327,9 +1327,6 @@ static void drm_test_check_output_bpc_format_driver_rgb_only(struct kunit *test)
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
 	KUNIT_ASSERT_GT(test, info->max_tmds_clock, 0);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
@@ -1348,6 +1345,9 @@ static void drm_test_check_output_bpc_format_driver_rgb_only(struct kunit *test)
 	rate = drm_hdmi_compute_mode_clock(preferred, 12, HDMI_COLORSPACE_YUV422);
 	KUNIT_ASSERT_LT(test, rate, info->max_tmds_clock * 1000);
 
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
 	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
@@ -1394,9 +1394,6 @@ static void drm_test_check_output_bpc_format_display_rgb_only(struct kunit *test
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
 	KUNIT_ASSERT_GT(test, info->max_tmds_clock, 0);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
@@ -1415,6 +1412,9 @@ static void drm_test_check_output_bpc_format_display_rgb_only(struct kunit *test
 	rate = drm_hdmi_compute_mode_clock(preferred, 12, HDMI_COLORSPACE_YUV422);
 	KUNIT_ASSERT_LT(test, rate, info->max_tmds_clock * 1000);
 
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
 	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
@@ -1460,9 +1460,6 @@ static void drm_test_check_output_bpc_format_driver_8bpc_only(struct kunit *test
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
 	KUNIT_ASSERT_GT(test, info->max_tmds_clock, 0);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
@@ -1473,6 +1470,9 @@ static void drm_test_check_output_bpc_format_driver_8bpc_only(struct kunit *test
 	rate = drm_hdmi_compute_mode_clock(preferred, 12, HDMI_COLORSPACE_RGB);
 	KUNIT_ASSERT_LT(test, rate, info->max_tmds_clock * 1000);
 
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
 	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
@@ -1520,9 +1520,6 @@ static void drm_test_check_output_bpc_format_display_8bpc_only(struct kunit *tes
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
 	KUNIT_ASSERT_GT(test, info->max_tmds_clock, 0);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
@@ -1533,6 +1530,9 @@ static void drm_test_check_output_bpc_format_display_8bpc_only(struct kunit *tes
 	rate = drm_hdmi_compute_mode_clock(preferred, 12, HDMI_COLORSPACE_RGB);
 	KUNIT_ASSERT_LT(test, rate, info->max_tmds_clock * 1000);
 
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
 	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
-- 
2.39.5




