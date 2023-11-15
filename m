Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474DA7ECFE2
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbjKOTvd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbjKOTvc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:51:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E2012C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:51:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077A0C433C8;
        Wed, 15 Nov 2023 19:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077888;
        bh=MgFdDJurRtMegPr5PLJT36O46BT8wP5eja4nLG1yAhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=svPICpSJtdtmNukMNJtLlRPPgUA47m7gg85bxdwJx9SY1Dke2lqPUkCjTFFobujox
         +rE6Ms40226vog5NqTN4z/UNBVL+ltCaRKGASv7Eo+5sDer8bTp3nnSc5486UwZTQ8
         ntMgRzI8unrxmteFkekAiLwB8j+row8GW7nmI/KU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 582/603] drm/vc4: tests: Fix UAF in the mock helpers
Date:   Wed, 15 Nov 2023 14:18:47 -0500
Message-ID: <20231115191651.652858495@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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



