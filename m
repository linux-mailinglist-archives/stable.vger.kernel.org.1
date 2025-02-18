Return-Path: <stable+bounces-116851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A9CA3A91B
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86FBE1898CDE
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7BA1EB9E5;
	Tue, 18 Feb 2025 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7xnhbkO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653F91D7E4F;
	Tue, 18 Feb 2025 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910362; cv=none; b=T5YyfjJ7qM5pmXX0bEdV+tWeh3tB6v824KWmSy10i/p5knk1FUvsmu69VnJq/oW7OIN3PwnQCKOBDmuSBd7eFsB7XeNRQwhjtpd9aQyiPA8NIdKlglHaZlrNj8bEEEJb2QTdO7L73UEXYcviRvwuGgnnmnP+ghO8iHhO3I8bato=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910362; c=relaxed/simple;
	bh=VropmkxRvGV2M+HXGjJIyxCbLwUKDK91l3HDTGhaTAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k1mqX5wW+NHxYPOZGzE100G0rmLSj1nJ1KDCIK+YJCRBsx0B3gm7r3LaY3Zwn+4yMffk2uaDs9Z5wq2r3UUPu4RnAk8SEjDWRxhDg4sir8dQ7/lTAV1G3i0BMak+H5GYtUgG0psg+E6BiesIYxxgWdkF/Wdyr5nCsG23a8a1JSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7xnhbkO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B739C4CEE2;
	Tue, 18 Feb 2025 20:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910362;
	bh=VropmkxRvGV2M+HXGjJIyxCbLwUKDK91l3HDTGhaTAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c7xnhbkOsM4EEQcZOU5IKdmzV951tqRXySsxXmMcfH5p904dK74l9fo1BTYRTU5bU
	 d/OiQ6i6+ry3pJsZEyc2LZJrquz3QLqV5sHxWAvmZK2vloFcrS9BRtoXCLz1vzPHaX
	 TkGQw7odvwYt+negXYgQUoXTUicMhKd7BjgmnkvJBmEI/rr1Zkm5xBBpZSavhprIky
	 5OhAf32TFyWT4qk23CAM880Xnyn10xxQKK1Kf85yueRHAUFZsagfrPf/FHNItUYR+X
	 MEZXSDvtvpK0W0eJSYEpdfyTeAI2pEAU80aIkT8lVPsprMraJJmTNDGHGxGWQ12HfQ
	 IRfni2j8PZr8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dmitry.baryshkov@linaro.org,
	dave.stevenson@raspberrypi.com,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 29/31] drm/tests: hdmi: Remove redundant assignments
Date: Tue, 18 Feb 2025 15:24:49 -0500
Message-Id: <20250218202455.3592096-29-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202455.3592096-1-sashal@kernel.org>
References: <20250218202455.3592096-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.3
Content-Transfer-Encoding: 8bit

From: Maxime Ripard <mripard@kernel.org>

[ Upstream commit bb4f929a8875b4801db95b8cf3b2c527c1e475e0 ]

Some tests have the drm pointer assigned multiple times to the same
value. Drop the redundant assignments.

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20250129-test-kunit-v2-2-fe59c43805d5@kernel.org
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Stable-dep-of: 5d14c08a4746 ("drm/tests: hdmi: Fix recursive locking")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 4ba869e0e794c..ac653346e766b 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -443,7 +443,6 @@ static void drm_test_check_broadcast_rgb_auto_cea_mode_vic_1(struct kunit *test)
 	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 1);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
-	drm = &priv->drm;
 	crtc = priv->crtc;
 	ret = light_up_connector(test, drm, crtc, conn, mode, ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
@@ -557,7 +556,6 @@ static void drm_test_check_broadcast_rgb_full_cea_mode_vic_1(struct kunit *test)
 	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 1);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
-	drm = &priv->drm;
 	crtc = priv->crtc;
 	ret = light_up_connector(test, drm, crtc, conn, mode, ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
@@ -673,7 +671,6 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode_vic_1(struct kunit *te
 	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 1);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
-	drm = &priv->drm;
 	crtc = priv->crtc;
 	ret = light_up_connector(test, drm, crtc, conn, mode, ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
@@ -1275,7 +1272,6 @@ static void drm_test_check_output_bpc_format_vic_1(struct kunit *test)
 	rate = mode->clock * 1500;
 	KUNIT_ASSERT_LT(test, rate, info->max_tmds_clock * 1000);
 
-	drm = &priv->drm;
 	crtc = priv->crtc;
 	ret = light_up_connector(test, drm, crtc, conn, mode, ctx);
 	KUNIT_EXPECT_EQ(test, ret, 0);
-- 
2.39.5


