Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA9879BDCA
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241846AbjIKWYl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238907AbjIKOHo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:07:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494D2E40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:07:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E71C433C7;
        Mon, 11 Sep 2023 14:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441260;
        bh=TDaBuXMyCoo57jtLVaisMhhF0dmZ6KACD7e+H1RAJ9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DkU+bSePm69FNKKp88ZFBs9SwOK2TKjsw2xEgYpaxIydZ8cyEEvmtzYxmYiZNmY82
         ORNwJe2xEdjt36wmqIKDHylzCcgNIAFba6bGq8sSc9EWPV6dxhQu6E+cLrWPxsaF45
         mpc4Tw4c4wWjSj0q7C47FgIWVs8PRTqFAQQka85U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rob Clark <robdclark@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 351/739] drm/msm/a690: Switch to a660_gmu.bin
Date:   Mon, 11 Sep 2023 15:42:30 +0200
Message-ID: <20230911134700.925818544@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Clark <robdclark@chromium.org>

[ Upstream commit 18ff50e582a08eb365729b7c5507a86c41f2edf8 ]

There isn't actually a a690_gmu.bin.  But it appears that the normal
a660_gmu.bin works fine.  Normally all the devices within a sub-
generation (or "family") will use the same fw, and a690 is in the a660
family.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Fixes: 5e7665b5e484 ("drm/msm/adreno: Add Adreno A690 support")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/552406/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index ce8d0b2475bf1..6e3c1368c5e15 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -371,7 +371,7 @@ static const struct adreno_info gpulist[] = {
 		.rev = ADRENO_REV(6, 9, 0, ANY_ID),
 		.fw = {
 			[ADRENO_FW_SQE] = "a660_sqe.fw",
-			[ADRENO_FW_GMU] = "a690_gmu.bin",
+			[ADRENO_FW_GMU] = "a660_gmu.bin",
 		},
 		.gmem = SZ_4M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-- 
2.40.1



