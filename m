Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C04275558F
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjGPUmJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjGPUmI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:42:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38B89F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:42:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7956660EBF
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA31C433C8;
        Sun, 16 Jul 2023 20:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540126;
        bh=Wc+oBlUPon/p9yBKlfjkyN1XYQilpe1FPAEqWJOdC4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f1C/SKh7sflsacc00Fd0ANLid70kGOPdw/EzNrR5v2TD/QA8vH/VDQWvajBPDFKcA
         lUh2U91WKd0XXib292hUffrUqydAPkIHEPOSxXTMGwGzu5KAXOvD9lphrmnD4i1j9o
         Z91h8RPR8AIJndf9bdbZUdCpCJfDUQm/VkLpHnh4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 225/591] drm/msm/dpu: set DSC flush bit correctly at MDP CTL flush register
Date:   Sun, 16 Jul 2023 21:46:04 +0200
Message-ID: <20230716194929.693306527@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kuogee Hsieh <quic_khsieh@quicinc.com>

[ Upstream commit 12cef323c903bd8b13d1f6ff24a9695c2cdc360b ]

The CTL_FLUSH register should be programmed with the 22th bit
(DSC_IDX) to flush the DSC hardware blocks, not the literal value of
22 (which corresponds to flushing VIG1, VIG2 and RGB1 instead).

Changes in V12:
-- split this patch out of "separate DSC flush update out of interface"

Changes in V13:
-- rewording the commit text

Changes in V14:
-- drop 'DSC" from "The DSC CTL_FLUSH register" at commit text

Fixes: 77f6da90487c ("drm/msm/disp/dpu1: Add DSC support in hw_ctl")
Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Patchwork: https://patchwork.freedesktop.org/patch/539496/
Link: https://lore.kernel.org/r/1685036458-22683-2-git-send-email-quic_khsieh@quicinc.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index a35ecb6676c88..696c32d30d10c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -550,7 +550,7 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
 		DPU_REG_WRITE(c, CTL_MERGE_3D_ACTIVE,
 			      BIT(cfg->merge_3d - MERGE_3D_0));
 	if (cfg->dsc) {
-		DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, DSC_IDX);
+		DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, BIT(DSC_IDX));
 		DPU_REG_WRITE(c, CTL_DSC_ACTIVE, cfg->dsc);
 	}
 }
-- 
2.39.2



