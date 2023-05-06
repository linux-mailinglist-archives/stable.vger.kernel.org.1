Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EEA6F8FB0
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 09:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjEFHLf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 03:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjEFHLe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 03:11:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73121161E
        for <stable@vger.kernel.org>; Sat,  6 May 2023 00:11:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67DB4617DA
        for <stable@vger.kernel.org>; Sat,  6 May 2023 07:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA34C433D2;
        Sat,  6 May 2023 07:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683357092;
        bh=Ujzxx9NDSrXOfYZXh2ulcawwBqMrSL9xOITrRb7FDOg=;
        h=Subject:To:Cc:From:Date:From;
        b=TfzlzFPQi8htdk5+i+hPoLkz7jDDqcLLstfl+tOm5YptPGJHC26n6ulIOQbD0Plpu
         2kSW4pLaHxS0ag39QQKaAQCe8sN8J+76PbPrH/BhwL4EFDM62C0+RkvcOU9Hg6IjRK
         cEFvAKCOjIhQ6LONDCYe2jYW8jhEKULQpylrBK5w=
Subject: FAILED: patch "[PATCH] bus: mhi: host: Range check CHDBOFF and ERDBOFF" failed to apply to 5.15-stable tree
To:     quic_jhugo@quicinc.com, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, quic_pkanojiy@quicinc.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 06 May 2023 15:58:09 +0900
Message-ID: <2023050609-foothold-turret-5465@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
git cherry-pick -x 6a0c637bfee69a74c104468544d9f2a6579626d0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050609-foothold-turret-5465@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

6a0c637bfee6 ("bus: mhi: host: Range check CHDBOFF and ERDBOFF")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6a0c637bfee69a74c104468544d9f2a6579626d0 Mon Sep 17 00:00:00 2001
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
Date: Fri, 24 Mar 2023 10:13:04 -0600
Subject: [PATCH] bus: mhi: host: Range check CHDBOFF and ERDBOFF

If the value read from the CHDBOFF and ERDBOFF registers is outside the
range of the MHI register space then an invalid address might be computed
which later causes a kernel panic.  Range check the read value to prevent
a crash due to bad data from the device.

Fixes: 6cd330ae76ff ("bus: mhi: core: Add support for ringing channel/event ring doorbells")
Cc: stable@vger.kernel.org
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://lore.kernel.org/r/1679674384-27209-1-git-send-email-quic_jhugo@quicinc.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 3d779ee6396d..b46a0821adf9 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -516,6 +516,12 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 		return -EIO;
 	}
 
+	if (val >= mhi_cntrl->reg_len - (8 * MHI_DEV_WAKE_DB)) {
+		dev_err(dev, "CHDB offset: 0x%x is out of range: 0x%zx\n",
+			val, mhi_cntrl->reg_len - (8 * MHI_DEV_WAKE_DB));
+		return -ERANGE;
+	}
+
 	/* Setup wake db */
 	mhi_cntrl->wake_db = base + val + (8 * MHI_DEV_WAKE_DB);
 	mhi_cntrl->wake_set = false;
@@ -532,6 +538,12 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 		return -EIO;
 	}
 
+	if (val >= mhi_cntrl->reg_len - (8 * mhi_cntrl->total_ev_rings)) {
+		dev_err(dev, "ERDB offset: 0x%x is out of range: 0x%zx\n",
+			val, mhi_cntrl->reg_len - (8 * mhi_cntrl->total_ev_rings));
+		return -ERANGE;
+	}
+
 	/* Setup event db address for each ev_ring */
 	mhi_event = mhi_cntrl->mhi_event;
 	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, val += 8, mhi_event++) {

