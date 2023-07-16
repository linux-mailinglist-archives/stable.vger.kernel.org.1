Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F287555A1
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjGPUm5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjGPUm5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:42:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6CCE43
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:42:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E126760E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31F0C433C8;
        Sun, 16 Jul 2023 20:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540175;
        bh=rN+OHt0Gk9T+3I2X9YnjwrsPpph0wJrrJt1i9NMVsyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u7z/LMYQFL8qxhMnGj3/0qEftVJW88fWyYAXbEO+Amh5+pfHzuVbO9yDp+NxeMPFE
         1o9r9kAsvuDt2b/0KK9IihFKsY2hFMCW++vMO2gyeIzMfEZxlXwZkjFerSijC6ClOn
         X+H6Hc/+ozqtBLRpC4AjaAUBS3wN8lZqnueH9E/w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 270/591] drm/msm/dpu: correct MERGE_3D length
Date:   Sun, 16 Jul 2023 21:46:49 +0200
Message-ID: <20230716194930.882836692@linuxfoundation.org>
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 9a6c13b847d61b0c3796820ca6e976789df59cd8 ]

Each MERGE_3D block has just two registers. Correct the block length
accordingly.

Fixes: 4369c93cf36b ("drm/msm/dpu: initial support for merge3D hardware block")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/542177/
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Link: https://lore.kernel.org/r/20230613001004.3426676-3-dmitry.baryshkov@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 80e59d3f9dd3e..b2f330e99b0cd 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -1203,7 +1203,7 @@ static struct dpu_pingpong_cfg qcm2290_pp[] = {
 #define MERGE_3D_BLK(_name, _id, _base) \
 	{\
 	.name = _name, .id = _id, \
-	.base = _base, .len = 0x100, \
+	.base = _base, .len = 0x8, \
 	.features = MERGE_3D_SM8150_MASK, \
 	.sblk = NULL \
 	}
-- 
2.39.2



