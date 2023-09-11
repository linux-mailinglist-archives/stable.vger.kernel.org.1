Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C9879BF02
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240131AbjIKWjf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238898AbjIKOHf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:07:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC43CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:07:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AAAC433C7;
        Mon, 11 Sep 2023 14:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441251;
        bh=u0W47arON9wkGxWZTEu+RWK+bPW3uia03lX2+2yth6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cNLF5LD1vZOwdMGvn8kexPPi0ln8ACrrAUEdY5RcjixtX3t6e8ca4hIyUyqx0+QGU
         C8LvQwVcxf1usNMEzO+/Jy7pjbyee6+uatT7NRHmPbbK+C1a79zgwPVy/Z98BqCl9d
         deoM6yWNsYeQvyHCb+lqYZdwuei826ePUd2Y9kB0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 311/739] drm/msm/dpu: fix the irq index in dpu_encoder_phys_wb_wait_for_commit_done
Date:   Mon, 11 Sep 2023 15:41:50 +0200
Message-ID: <20230911134659.804144078@linuxfoundation.org>
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
index a466ff70a4d62..78037a697633b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
@@ -446,7 +446,8 @@ static int dpu_encoder_phys_wb_wait_for_commit_done(
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



