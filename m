Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD25755266
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjGPUHY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjGPUHW (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:07:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAC8C0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:07:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B44060E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF08C433C7;
        Sun, 16 Jul 2023 20:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538039;
        bh=mSgG5gkOV1LJklX3i/ip3vlnOJhVYMT1KOPUoF0J6sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=beiloiz9tOmuiTZoM9/8TXYErRfcVpGdtuX0J5rnW5zrJXphHxzel+gB3uUOOKOhG
         mn/ed2uDRqjJl0t2NSMa6q2VxOEzfxLlQLH6s+ev0Eh5pvAXLWTZYjJp//7+amIEEF
         be5SIu++vd8SivxwR3zHdTYznGQE7gBEsH7IwkK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnaud Vrac <avrac@freebox.fr>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 275/800] drm/msm/dpu: fix cursor block register bit offset in msm8998 hw catalog
Date:   Sun, 16 Jul 2023 21:42:08 +0200
Message-ID: <20230716194955.479732802@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnaud Vrac <avrac@freebox.fr>

[ Upstream commit c95771905c494aa5c2abbb56b3e2f7d4aa3b34f9 ]

This matches the value for both fbdev and sde implementations in the
downstream msm-4.4 repository.

Signed-off-by: Arnaud Vrac <avrac@freebox.fr>
Fixes: 94391a14fc27 ("drm/msm/dpu1: Add MSM8998 to hw catalog")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/532899/
Link: https://lore.kernel.org/r/20230419-dpu-tweaks-v1-8-d1bac46db075@freebox.fr
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
index bdcd554fc8a80..9116129527797 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
@@ -39,8 +39,8 @@ static const struct dpu_mdp_cfg msm8998_mdp[] = {
 	.clk_ctrls[DPU_CLK_CTRL_DMA1] = { .reg_off = 0x2b4, .bit_off = 8 },
 	.clk_ctrls[DPU_CLK_CTRL_DMA2] = { .reg_off = 0x2c4, .bit_off = 8 },
 	.clk_ctrls[DPU_CLK_CTRL_DMA3] = { .reg_off = 0x2c4, .bit_off = 12 },
-	.clk_ctrls[DPU_CLK_CTRL_CURSOR0] = { .reg_off = 0x3a8, .bit_off = 15 },
-	.clk_ctrls[DPU_CLK_CTRL_CURSOR1] = { .reg_off = 0x3b0, .bit_off = 15 },
+	.clk_ctrls[DPU_CLK_CTRL_CURSOR0] = { .reg_off = 0x3a8, .bit_off = 16 },
+	.clk_ctrls[DPU_CLK_CTRL_CURSOR1] = { .reg_off = 0x3b0, .bit_off = 16 },
 	},
 };
 
-- 
2.39.2



