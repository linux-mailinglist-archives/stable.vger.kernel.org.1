Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329737A38F7
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239915AbjIQTnD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240073AbjIQTmt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:42:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB36F103
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:42:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2073C433C8;
        Sun, 17 Sep 2023 19:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979763;
        bh=00sUMgE8xKk2JkTCi2ahUPktoCYAwPEI4tlDHuBhS2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IOh5nDAxGHd7kYnQjag8qryDNQSwtS3zzkQF0bfrzYD/fBd25v9mrG7puzvGN26vL
         v9w5zznupU9CAJ6j6r5XcS54jm0pQX6RtUawH8PmzSztmmsoIiskr8IaVQLMt2Sj0e
         Xi9haEiTJ/h6561bqmX86c4beS9X7lD/K7Dk9C60=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qiang Yu <quic_qianyu@quicinc.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 389/406] bus: mhi: host: Skip MHI reset if device is in RDDM
Date:   Sun, 17 Sep 2023 21:14:03 +0200
Message-ID: <20230917191111.537670906@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qiang Yu <quic_qianyu@quicinc.com>

[ Upstream commit cabce92dd805945a090dc6fc73b001bb35ed083a ]

In RDDM EE, device can not process MHI reset issued by host. In case of MHI
power off, host is issuing MHI reset and polls for it to get cleared until
it times out. Since this timeout can not be avoided in case of RDDM, skip
the MHI reset in this scenarios.

Cc: <stable@vger.kernel.org>
Fixes: a6e2e3522f29 ("bus: mhi: core: Add support for PM state transitions")
Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://lore.kernel.org/r/1684390959-17836-1-git-send-email-quic_qianyu@quicinc.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/mhi/host/pm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index 7d69b740b9f93..fe8ecd6eaa4d1 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -490,6 +490,10 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl,
 		u32 in_reset = -1;
 		unsigned long timeout = msecs_to_jiffies(mhi_cntrl->timeout_ms);
 
+		/* Skip MHI RESET if in RDDM state */
+		if (mhi_cntrl->rddm_image && mhi_get_exec_env(mhi_cntrl) == MHI_EE_RDDM)
+			goto skip_mhi_reset;
+
 		dev_dbg(dev, "Triggering MHI Reset in device\n");
 		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
 
@@ -515,6 +519,7 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl,
 		mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
 	}
 
+skip_mhi_reset:
 	dev_dbg(dev,
 		 "Waiting for all pending event ring processing to complete\n");
 	mhi_event = mhi_cntrl->mhi_event;
-- 
2.40.1



