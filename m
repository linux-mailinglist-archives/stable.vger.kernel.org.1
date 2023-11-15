Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20D27ECDDE
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbjKOTi5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjKOTiy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:38:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AA3D48
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:38:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66368C433C8;
        Wed, 15 Nov 2023 19:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077130;
        bh=CcBypeyYnfLQnxSWcC945VkHap2jYgMbSZIApF2aaUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PioKve+8oz8L3wfTfm/DlVamVxKMG1SAJDDj3sTD7XXH0ffpmgHzQiLTgo5uiX85Y
         pEub5NTbEQUQ87NB4hkH+l1+IYHE7FFo+bDZR51XIaicuIygRdoGn0AMWWRMdeHrYb
         8JCqiii2pVHhSuJzGWDvZhh/+HL0ZZwww5wra4Sc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 531/550] drm/vc4: tests: Fix UAF in the mock helpers
Date:   Wed, 15 Nov 2023 14:18:35 -0500
Message-ID: <20231115191637.745306793@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maxime Ripard <mripard@kernel.org>

[ Upstream commit cdcd6aef9db5797995d4153ea19fdf56d189f0e4 ]

The VC4 mock helpers allocate the CRTC, encoders and connectors using a
call to kunit_kzalloc(), but the DRM device they are attache to survives
for longer than the test itself which leads to use-after-frees reported
by KASAN.

Switch to drmm_kzalloc to tie the lifetime of these objects to the main
DRM device.

Fixes: f759f5b53f1c ("drm/vc4: tests: Introduce a mocking infrastructure")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/all/CA+G9fYvJA2HGqzR9LGgq63v0SKaUejHAE6f7+z9cwWN-ourJ_g@mail.gmail.com/
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20231024105640.352752-1-mripard@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vc4/tests/vc4_mock_crtc.c   | 2 +-
 drivers/gpu/drm/vc4/tests/vc4_mock_output.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock_crtc.c b/drivers/gpu/drm/vc4/tests/vc4_mock_crtc.c
index 5d12d7beef0eb..ade3309ae042f 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_mock_crtc.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_mock_crtc.c
@@ -26,7 +26,7 @@ struct vc4_dummy_crtc *vc4_mock_pv(struct kunit *test,
 	struct vc4_crtc *vc4_crtc;
 	int ret;
 
-	dummy_crtc = kunit_kzalloc(test, sizeof(*dummy_crtc), GFP_KERNEL);
+	dummy_crtc = drmm_kzalloc(drm, sizeof(*dummy_crtc), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, dummy_crtc);
 
 	vc4_crtc = &dummy_crtc->crtc;
diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock_output.c b/drivers/gpu/drm/vc4/tests/vc4_mock_output.c
index 6e11fcc9ef45e..e70d7c3076acf 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_mock_output.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_mock_output.c
@@ -32,7 +32,7 @@ struct vc4_dummy_output *vc4_dummy_output(struct kunit *test,
 	struct drm_encoder *enc;
 	int ret;
 
-	dummy_output = kunit_kzalloc(test, sizeof(*dummy_output), GFP_KERNEL);
+	dummy_output = drmm_kzalloc(drm, sizeof(*dummy_output), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dummy_output);
 	dummy_output->encoder.type = vc4_encoder_type;
 
-- 
2.42.0



