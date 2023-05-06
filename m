Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7E76F8FAA
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 09:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjEFHLS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 03:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFHLR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 03:11:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB482D53
        for <stable@vger.kernel.org>; Sat,  6 May 2023 00:11:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5459A616DD
        for <stable@vger.kernel.org>; Sat,  6 May 2023 07:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC55C433EF;
        Sat,  6 May 2023 07:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683357075;
        bh=VqDXqLME2/xQP9LhVuKc8U1oaOY4SoNQnUzFFb4j58c=;
        h=Subject:To:Cc:From:Date:From;
        b=IL5pbUzROcLfGNyTNHeIjQeoldH6o7aQLXWezFiZHbREDeqT6q6fZ7A8umNrfRimf
         EsS1mYkPxLv2lz/Xk1maCUjsjpwVx6/tmlWSM2Fck/VC2Twz2F18Qz/OZV4tI/QAVz
         O6KxGGbkJ+tAjxPKyENnvWdyWTV1NUfrrqnrlPFo=
Subject: FAILED: patch "[PATCH] bus: mhi: host: Remove duplicate ee check for syserr" failed to apply to 5.15-stable tree
To:     quic_jhugo@quicinc.com, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, quic_carlv@quicinc.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 06 May 2023 15:57:38 +0900
Message-ID: <2023050638-murkiness-purple-0e97@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d469d9448a0f1a33c175d3280b1542fa0158ad7a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050638-murkiness-purple-0e97@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

d469d9448a0f ("bus: mhi: host: Remove duplicate ee check for syserr")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d469d9448a0f1a33c175d3280b1542fa0158ad7a Mon Sep 17 00:00:00 2001
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
Date: Mon, 10 Apr 2023 09:58:11 -0600
Subject: [PATCH] bus: mhi: host: Remove duplicate ee check for syserr

If we detect a system error via intvec, we only process the syserr if the
current ee is different than the last observed ee.  The reason for this
check is to prevent bhie from running multiple times, but with the single
queue handling syserr, that is not possible.

The check can cause an issue with device recovery.  If PBL loads a bad SBL
via BHI, but that SBL hangs before notifying the host of an ee change,
then issuing soc_reset to crash the device and retry (after supplying a
fixed SBL) will not recover the device as the host will observe a PBL->PBL
transition and not process the syserr.  The device will be stuck until
either the driver is reloaded, or the host is rebooted.  Instead, remove
the check so that we can attempt to recover the device.

Fixes: ef2126c4e2ea ("bus: mhi: core: Process execution environment changes serially")
Cc: stable@vger.kernel.org
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://lore.kernel.org/r/1681142292-27571-2-git-send-email-quic_jhugo@quicinc.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index c7eb7b8be9d6..74a75439c713 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -503,7 +503,7 @@ irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
 	}
 	write_unlock_irq(&mhi_cntrl->pm_lock);
 
-	if (pm_state != MHI_PM_SYS_ERR_DETECT || ee == mhi_cntrl->ee)
+	if (pm_state != MHI_PM_SYS_ERR_DETECT)
 		goto exit_intvec;
 
 	switch (ee) {

