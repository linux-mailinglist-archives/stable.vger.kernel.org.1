Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DEB7797BF
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 21:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbjHKT1q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 15:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbjHKT1p (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 15:27:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7448D30DB
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 12:27:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08DEF67960
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 19:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F3FC433C7;
        Fri, 11 Aug 2023 19:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691782064;
        bh=5pexEhRscUYVCBoTj2iIl4EYeALS6HJzSbRTgnBZA6E=;
        h=Subject:To:From:Date:From;
        b=t6L5a7Ft3LMc3WbpIfVjWqWmNZhzglJWd23lihA5X2RvkFDtqo6iyCqeZwPSqPYC/
         sGPAMtpKUR6zbAN1T1TUvvPF8Mu6CzLxFX5uKOdJyuJdQ4vOiDFfNzQjOMedmLwAr+
         Vxw//i8xjIu89doXe2KsNI6+3S/rQTHVdl56/ZlY=
Subject: patch "bus: mhi: host: Skip MHI reset if device is in RDDM" added to char-misc-testing
To:     quic_qianyu@quicinc.com, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, quic_jhugo@quicinc.com,
        stable@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 11 Aug 2023 21:26:59 +0200
Message-ID: <2023081159-pursuable-resemble-868a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    bus: mhi: host: Skip MHI reset if device is in RDDM

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From cabce92dd805945a090dc6fc73b001bb35ed083a Mon Sep 17 00:00:00 2001
From: Qiang Yu <quic_qianyu@quicinc.com>
Date: Thu, 18 May 2023 14:22:39 +0800
Subject: bus: mhi: host: Skip MHI reset if device is in RDDM

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
---
 drivers/bus/mhi/host/pm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index 083459028a4b..8a4362d75fc4 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -470,6 +470,10 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
 
 	/* Trigger MHI RESET so that the device will not access host memory */
 	if (!MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state)) {
+		/* Skip MHI RESET if in RDDM state */
+		if (mhi_cntrl->rddm_image && mhi_get_exec_env(mhi_cntrl) == MHI_EE_RDDM)
+			goto skip_mhi_reset;
+
 		dev_dbg(dev, "Triggering MHI Reset in device\n");
 		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
 
@@ -495,6 +499,7 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
 		}
 	}
 
+skip_mhi_reset:
 	dev_dbg(dev,
 		 "Waiting for all pending event ring processing to complete\n");
 	mhi_event = mhi_cntrl->mhi_event;
-- 
2.41.0


