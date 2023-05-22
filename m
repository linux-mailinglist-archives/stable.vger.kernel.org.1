Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EE970C76D
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbjEVT3k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbjEVT3g (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:29:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE9A1B1
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:29:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E0CA628E5
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3380EC4339E;
        Mon, 22 May 2023 19:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783760;
        bh=Z24HX7WCxDnwX4J6yU6RFgP+QN3agI2JPu0wTMgqjLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pjBjlbEViJ4+uRcD7Xaa7oy2JCtbll1QrZqxxwAeWIu9ilpQS6XrHo53gc/JpWoln
         h8Et9Vfo+CXsjXLk68obwU/Rt5uESZDHN17kK7PeOVg99AWhmZWlmC3yl5TjN1+VlC
         Zp9DCHZ7/3GmPvyH4Pby0unLeUWMamJljeY1TIT8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 154/292] drm/msm/dpu: Assign missing writeback log_mask
Date:   Mon, 22 May 2023 20:08:31 +0100
Message-Id: <20230522190409.811809415@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

From: Marijn Suijten <marijn.suijten@somainline.org>

[ Upstream commit a432fc31f03db2546a48bcf5dd69ca28ceb732bf ]

The WB debug log mask ended up never being assigned, leading to writes
to this block to never be logged even if the mask is enabled in
dpu_hw_util_log_mask via debugfs.

Fixes: 84a33d0fd921 ("drm/msm/dpu: add dpu_hw_wb abstraction for writeback blocks")
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/533860/
Link: https://lore.kernel.org/r/20230418-dpu-drop-useless-for-lookup-v3-1-e8d869eea455@somainline.org
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
index 2d28afdf860ef..a3e413d277175 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
@@ -61,6 +61,7 @@ static const struct dpu_wb_cfg *_wb_offset(enum dpu_wb wb,
 	for (i = 0; i < m->wb_count; i++) {
 		if (wb == m->wb[i].id) {
 			b->blk_addr = addr + m->wb[i].base;
+			b->log_mask = DPU_DBG_MASK_WB;
 			return &m->wb[i];
 		}
 	}
-- 
2.39.2



