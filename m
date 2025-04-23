Return-Path: <stable+bounces-135459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CFEA98E2D
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 16:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6652B7A0FB6
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA03280CFF;
	Wed, 23 Apr 2025 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iTeIvdZG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36212280CF0;
	Wed, 23 Apr 2025 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419979; cv=none; b=e0KCiNLqCgCVoapkdq8fKZIu/mevC6MGWqScuPu5IJinUNh0ypdNz+5JpLgdvnFz1lVZXADrpaBnjW7w8q1KbJZjtrakbM3cBim1T2A3+aUt2h2WbpQDs9nkY6rq0APmcwB34BMzdPz7A96Oa4riak4SKDw4kpY42w2u1I778hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419979; c=relaxed/simple;
	bh=1wXJK2/ewcLJg4jTxHVJOPOi17XR7rYor7FRs+OqBMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxl2WjJnyUJwoLR2Kjvm2xkNYYPZ28wKMaT7Pe76BICvUcUBvUbl2BXT1G9FtySsxdime5Qqam7YRViP6ANgejpPpD37+CJZ13jChzcjeKf6RaU60cu77zvPYzQRZHlDJalkJNR0QmgHmO9ZzhxJLkGPuqaPymwQ9MGOS9gBQcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iTeIvdZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB18C4CEE2;
	Wed, 23 Apr 2025 14:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745419979;
	bh=1wXJK2/ewcLJg4jTxHVJOPOi17XR7rYor7FRs+OqBMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iTeIvdZGPgu0a7YQG/10fgFulYy9xeoaMcXqzaGkY4kwHV+zzfkhqQ50elR28dzZq
	 pZ51n1sQ14KexVp/dcYOLiJMDXbtH8q1+6z3W2kkLpmVSnUCs4xX9i3ONO+VxciocX
	 yn3TEnypXaR8z5jsmF1CCIvsOjZ8rPWl/QS5l4Bg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philipp Stanner <phasta@mailbox.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 026/393] drm/tests: probe-helper: Fix drm_display_mode memory leak
Date: Wed, 23 Apr 2025 16:38:42 +0200
Message-ID: <20250423142644.352387339@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
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

From: Maxime Ripard <mripard@kernel.org>

[ Upstream commit 8b6f2e28431b2f9f84073bff50353aeaf25559d0 ]

drm_analog_tv_mode() and its variants return a drm_display_mode that
needs to be destroyed later one. The
drm_test_connector_helper_tv_get_modes_check() test never does however,
which leads to a memory leak.

Let's make sure it's freed.

Reported-by: Philipp Stanner <phasta@mailbox.org>
Closes: https://lore.kernel.org/dri-devel/a7655158a6367ac46194d57f4b7433ef0772a73e.camel@mailbox.org/
Fixes: 1e4a91db109f ("drm/probe-helper: Provide a TV get_modes helper")
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://lore.kernel.org/r/20250408-drm-kunit-drm-display-mode-memleak-v1-7-996305a2e75a@kernel.org
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tests/drm_probe_helper_test.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_probe_helper_test.c b/drivers/gpu/drm/tests/drm_probe_helper_test.c
index 1a2044070a6cb..2a7984431d47b 100644
--- a/drivers/gpu/drm/tests/drm_probe_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_probe_helper_test.c
@@ -98,7 +98,7 @@ drm_test_connector_helper_tv_get_modes_check(struct kunit *test)
 	struct drm_connector *connector = &priv->connector;
 	struct drm_cmdline_mode *cmdline = &connector->cmdline_mode;
 	struct drm_display_mode *mode;
-	const struct drm_display_mode *expected;
+	struct drm_display_mode *expected;
 	size_t len;
 	int ret;
 
@@ -134,6 +134,9 @@ drm_test_connector_helper_tv_get_modes_check(struct kunit *test)
 
 		KUNIT_EXPECT_TRUE(test, drm_mode_equal(mode, expected));
 		KUNIT_EXPECT_TRUE(test, mode->type & DRM_MODE_TYPE_PREFERRED);
+
+		ret = drm_kunit_add_mode_destroy_action(test, expected);
+		KUNIT_ASSERT_EQ(test, ret, 0);
 	}
 
 	if (params->num_expected_modes >= 2) {
@@ -145,6 +148,9 @@ drm_test_connector_helper_tv_get_modes_check(struct kunit *test)
 
 		KUNIT_EXPECT_TRUE(test, drm_mode_equal(mode, expected));
 		KUNIT_EXPECT_FALSE(test, mode->type & DRM_MODE_TYPE_PREFERRED);
+
+		ret = drm_kunit_add_mode_destroy_action(test, expected);
+		KUNIT_ASSERT_EQ(test, ret, 0);
 	}
 
 	mutex_unlock(&priv->drm->mode_config.mutex);
-- 
2.39.5




