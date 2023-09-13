Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE1579F1C6
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 21:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjIMTL7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 15:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjIMTL6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 15:11:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28B81999
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 12:11:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0F9C433C7;
        Wed, 13 Sep 2023 19:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694632314;
        bh=fBBjFeafaFcgGf4M6QjldGrc4iOM/OPjsin1hP80WgQ=;
        h=Subject:To:Cc:From:Date:From;
        b=Kw+idCtauHtl98mWQ99DIRKuumINo3i4vpqLlJxkmMYyZHVDW7egQzaD+A9FHH48D
         BKw0/DSg//NcbAF9TXPRN7rni+Dr53otwl7H/Fhx1Trt8KvXd1j+ZOP7KUvwtwOoTm
         hO2s6x1JcUBYhGoWr1+WriG9Scq8vYPumNdTKC68=
Subject: FAILED: patch "[PATCH] bus: mhi: host: Skip MHI reset if device is in RDDM" failed to apply to 5.10-stable tree
To:     quic_qianyu@quicinc.com, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, quic_jhugo@quicinc.com,
        stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 13 Sep 2023 21:11:50 +0200
Message-ID: <2023091350-mahogany-jump-02dd@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x cabce92dd805945a090dc6fc73b001bb35ed083a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091350-mahogany-jump-02dd@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

cabce92dd805 ("bus: mhi: host: Skip MHI reset if device is in RDDM")
a0f5a630668c ("bus: mhi: Move host MHI code to "host" directory")
44b1eba44dc5 ("bus: mhi: core: Fix power down latency")
a03c7a86e127 ("bus: mhi: core: Mark and maintain device states early on after power down")
556bbb442bbb ("bus: mhi: core: Separate system error and power down handling")
855a70c12021 ("bus: mhi: Add MHI PCI support for WWAN modems")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cabce92dd805945a090dc6fc73b001bb35ed083a Mon Sep 17 00:00:00 2001
From: Qiang Yu <quic_qianyu@quicinc.com>
Date: Thu, 18 May 2023 14:22:39 +0800
Subject: [PATCH] bus: mhi: host: Skip MHI reset if device is in RDDM

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

