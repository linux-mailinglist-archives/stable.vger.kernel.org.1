Return-Path: <stable+bounces-110544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1CFA1C9E2
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8907E166BFA
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C490118B476;
	Sun, 26 Jan 2025 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAXydjLJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EE418A943;
	Sun, 26 Jan 2025 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903318; cv=none; b=VrjbnawhzhK4TUjcR+py38F2ZLMEdIghAeDAMf/32/6RIG9eUhbyEYkzaNveJLMEg9dUauqFUglMBCl0aJWl3V3RPxSr4zlcJIdPx9EWzL2Z5mSB1FlKBbWqJZu31yXPNmsaj+yWCEIZD/Q4Tajc6pO66jTnr7H6NXGXftwWUgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903318; c=relaxed/simple;
	bh=+c9crRoiLq21LbpKE4eWo7xq42CI99vQSRdr3RC69Ec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FxBkV99YEJg6N08gzHTVoqs+ZVZws1YMJyAhCfbl0QndwKJkcsAvoTHzKNI/hSgyNPhHAfH/S8sO8ku5sRALyXvpzyw8hq6qeim9+i/HiRCg9qq4/Gcs3cMUFrF9EExLijOG3/4Q446vkETwAc7/KgbuWdu1j/aYHG1HV4LfNhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAXydjLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6FDC4CED3;
	Sun, 26 Jan 2025 14:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903318;
	bh=+c9crRoiLq21LbpKE4eWo7xq42CI99vQSRdr3RC69Ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JAXydjLJsxc7B2Uh0RsfBK2t9GAuhOoNCrbSDY9o1uAQJgOBdjk2Ivoc9SDRBPbuA
	 rX/YXLR5x08JTezt8L9pWABGP330OmVO1zksji+I1cGMnFRECDU6JgJcs7muQMiGdH
	 FFLigzll3hLwBaXpCs065in4dz/EJNIBrTlpIzkAE1oU9a1kg4zHR2H+PAD8/OHIrb
	 AsKhNG0Ki5GX0IJUBDwKnJg29xNbKc7mU3NRFwPAQZwfyGtEqe05+rIBxJZWV2Eucb
	 ZsWBJGls+r2g2PeYUIxRwO+ig18p9sthJbo8Irikw06LMJr7XQWRipQVT3nBjcmp76
	 YH1CQq8Zut4kw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dave.stevenson@raspberrypi.com,
	quic_jjohnson@quicinc.com,
	victor.liu@nxp.com,
	ruanjinjie@huawei.com,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 08/31] drm/tests: hdmi: return meaningful value from set_connector_edid()
Date: Sun, 26 Jan 2025 09:54:24 -0500
Message-Id: <20250126145448.930220-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145448.930220-1-sashal@kernel.org>
References: <20250126145448.930220-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit a8403be6eea91e4f5d8ad5dbc463dd08339eaece ]

The set_connector_edid() function returns a bogus 0, performing the
check on the connector->funcs->fill_modes() result internally. Make the
function pass the fill_modes()'s return value to the caller and move
corresponding checks to the caller site.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20241130-hdmi-mode-valid-v5-3-742644ec3b1f@linaro.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/tests/drm_hdmi_state_helper_test.c    | 31 +++++++++----------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 1e77689af6549..4ba869e0e794c 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -105,9 +105,8 @@ static int set_connector_edid(struct kunit *test, struct drm_connector *connecto
 	mutex_lock(&drm->mode_config.mutex);
 	ret = connector->funcs->fill_modes(connector, 4096, 4096);
 	mutex_unlock(&drm->mode_config.mutex);
-	KUNIT_ASSERT_GT(test, ret, 0);
 
-	return 0;
+	return ret;
 }
 
 static const struct drm_connector_hdmi_funcs dummy_connector_hdmi_funcs = {
@@ -223,7 +222,7 @@ drm_atomic_helper_connector_hdmi_init(struct kunit *test,
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_max_200mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_max_200mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	return priv;
 }
@@ -728,7 +727,7 @@ static void drm_test_check_output_bpc_crtc_mode_changed(struct kunit *test)
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
@@ -802,7 +801,7 @@ static void drm_test_check_output_bpc_crtc_mode_not_changed(struct kunit *test)
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
@@ -873,7 +872,7 @@ static void drm_test_check_output_bpc_dvi(struct kunit *test)
 	ret = set_connector_edid(test, conn,
 				 test_edid_dvi_1080p,
 				 ARRAY_SIZE(test_edid_dvi_1080p));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	info = &conn->display_info;
 	KUNIT_ASSERT_FALSE(test, info->is_hdmi);
@@ -920,7 +919,7 @@ static void drm_test_check_tmds_char_rate_rgb_8bpc(struct kunit *test)
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_max_200mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_max_200mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
@@ -967,7 +966,7 @@ static void drm_test_check_tmds_char_rate_rgb_10bpc(struct kunit *test)
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
@@ -1014,7 +1013,7 @@ static void drm_test_check_tmds_char_rate_rgb_12bpc(struct kunit *test)
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
@@ -1121,7 +1120,7 @@ static void drm_test_check_max_tmds_rate_bpc_fallback(struct kunit *test)
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	info = &conn->display_info;
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
@@ -1190,7 +1189,7 @@ static void drm_test_check_max_tmds_rate_format_fallback(struct kunit *test)
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	info = &conn->display_info;
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
@@ -1254,7 +1253,7 @@ static void drm_test_check_output_bpc_format_vic_1(struct kunit *test)
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	info = &conn->display_info;
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
@@ -1314,7 +1313,7 @@ static void drm_test_check_output_bpc_format_driver_rgb_only(struct kunit *test)
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	info = &conn->display_info;
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
@@ -1381,7 +1380,7 @@ static void drm_test_check_output_bpc_format_display_rgb_only(struct kunit *test
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_max_200mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_max_200mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	info = &conn->display_info;
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
@@ -1447,7 +1446,7 @@ static void drm_test_check_output_bpc_format_driver_8bpc_only(struct kunit *test
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	info = &conn->display_info;
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
@@ -1507,7 +1506,7 @@ static void drm_test_check_output_bpc_format_display_8bpc_only(struct kunit *tes
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_max_340mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_max_340mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	info = &conn->display_info;
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
-- 
2.39.5


