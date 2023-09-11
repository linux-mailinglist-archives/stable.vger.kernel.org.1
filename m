Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC61579B0A3
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbjIKWIx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240432AbjIKOoD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:44:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3BE12A
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:43:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70797C433C8;
        Mon, 11 Sep 2023 14:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443438;
        bh=m5ZovS8z5eZDtp84P0m1iaHi8Rb41jSjNgTymHI6BTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w1zmJ6Ehth3LsAHhc/AvoSfkon6w5rLHdlW9hiJMvhmsjiCndPGqaW5juGxtApchr
         /6Qw3LaO4WNX94HFIJ8dI8xkwvF+f1ahyR43SE67QPFav0LtOaEJBvBTLFViam433L
         YIQ2aTIP3nSjNKEXSeqM/Rx/a0+bgfrhSff0YZ/g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 360/737] drm/msm/dpu: fix the irq index in dpu_encoder_phys_wb_wait_for_commit_done
Date:   Mon, 11 Sep 2023 15:43:39 +0200
Message-ID: <20230911134700.585739405@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit d93cf453f51da168f4410ba73656f1e862096973 ]

Since commit 1e7ac595fa46 ("drm/msm/dpu: pass irq to
dpu_encoder_helper_wait_for_irq()") the
dpu_encoder_phys_wb_wait_for_commit_done expects the IRQ index rather
than the IRQ index in phys_enc->intr table, however writeback got the
older invocation in place. This was unnoticed for several releases, but
now it's time to fix it.

Fixes: d7d0e73f7de3 ("drm/msm/dpu: introduce the dpu_encoder_phys_* for writeback")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/550924/
Link: https://lore.kernel.org/r/20230802100426.4184892-2-dmitry.baryshkov@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
index bac4aa807b4bc..2553d6374482b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
@@ -455,7 +455,8 @@ static int dpu_encoder_phys_wb_wait_for_commit_done(
 	wait_info.atomic_cnt = &phys_enc->pending_kickoff_cnt;
 	wait_info.timeout_ms = KICKOFF_TIMEOUT_MS;
 
-	ret = dpu_encoder_helper_wait_for_irq(phys_enc, INTR_IDX_WB_DONE,
+	ret = dpu_encoder_helper_wait_for_irq(phys_enc,
+			phys_enc->irq[INTR_IDX_WB_DONE],
 			dpu_encoder_phys_wb_done_irq, &wait_info);
 	if (ret == -ETIMEDOUT)
 		_dpu_encoder_phys_wb_handle_wbdone_timeout(phys_enc);
-- 
2.40.1



