Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527366F8FAB
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 09:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjEFHL1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 03:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFHL0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 03:11:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489A22D53
        for <stable@vger.kernel.org>; Sat,  6 May 2023 00:11:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D09CF617EA
        for <stable@vger.kernel.org>; Sat,  6 May 2023 07:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546D1C433D2;
        Sat,  6 May 2023 07:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683357084;
        bh=lNXj5k2eqHAfyay8PuD7kSAQk41Bxps7EWV3Z29pUkw=;
        h=Subject:To:Cc:From:Date:From;
        b=tQN6xDMhn/rJ+0I6HXsSy7tzsphceGcQzWvQ4AznjuQZSlL43vIrcV4zI4G3HWrP9
         /ul+5F65arC9YMxjAKRt+2hTo/zHGg1vp281njjF0RHabC+zgqTbTIJrzVxALi3IUa
         H4wKYF3WQ1PmH0xEhj7Y9lBqjMoDKZ2M3wOG79DE=
Subject: FAILED: patch "[PATCH] bus: mhi: host: Use mhi_tryset_pm_state() for setting fw" failed to apply to 5.15-stable tree
To:     quic_jhugo@quicinc.com, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, quic_carlv@quicinc.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 06 May 2023 15:57:53 +0900
Message-ID: <2023050652-balancing-evasive-6713@gregkh>
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
git cherry-pick -x 1d1493bdc25f498468a606a4ece947d155cfa3a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050652-balancing-evasive-6713@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

1d1493bdc25f ("bus: mhi: host: Use mhi_tryset_pm_state() for setting fw error state")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1d1493bdc25f498468a606a4ece947d155cfa3a9 Mon Sep 17 00:00:00 2001
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
Date: Mon, 10 Apr 2023 09:58:12 -0600
Subject: [PATCH] bus: mhi: host: Use mhi_tryset_pm_state() for setting fw
 error state

If firmware loading fails, the controller's pm_state is updated to
MHI_PM_FW_DL_ERR unconditionally.  This can corrupt the pm_state as the
update is not done under the proper lock, and also does not validate
the state transition.  The firmware loading can fail due to a detected
syserr, but if MHI_PM_FW_DL_ERR is unconditionally set as the pm_state,
the handling of the syserr can break when it attempts to transition from
syserr detect, to syserr process.

By grabbing the lock, we ensure we don't race with some other pm_state
update.  By using mhi_try_set_pm_state(), we check that the transition
to MHI_PM_FW_DL_ERR is valid via the state machine logic.  If it is not
valid, then some other transition is occurring like syserr processing, and
we assume that will resolve the firmware loading error.

Fixes: 12e050c77be0 ("bus: mhi: core: Move to an error state on any firmware load failure")
Cc: stable@vger.kernel.org
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://lore.kernel.org/r/1681142292-27571-3-git-send-email-quic_jhugo@quicinc.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
index 1c69feee1703..d2a19b07ccb8 100644
--- a/drivers/bus/mhi/host/boot.c
+++ b/drivers/bus/mhi/host/boot.c
@@ -391,6 +391,7 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 {
 	const struct firmware *firmware = NULL;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_pm_state new_state;
 	const char *fw_name;
 	void *buf;
 	dma_addr_t dma_addr;
@@ -508,14 +509,18 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	}
 
 error_fw_load:
-	mhi_cntrl->pm_state = MHI_PM_FW_DL_ERR;
-	wake_up_all(&mhi_cntrl->state_event);
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	new_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_FW_DL_ERR);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	if (new_state == MHI_PM_FW_DL_ERR)
+		wake_up_all(&mhi_cntrl->state_event);
 }
 
 int mhi_download_amss_image(struct mhi_controller *mhi_cntrl)
 {
 	struct image_info *image_info = mhi_cntrl->fbc_image;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_pm_state new_state;
 	int ret;
 
 	if (!image_info)
@@ -526,8 +531,11 @@ int mhi_download_amss_image(struct mhi_controller *mhi_cntrl)
 			       &image_info->mhi_buf[image_info->entries - 1]);
 	if (ret) {
 		dev_err(dev, "MHI did not load AMSS, ret:%d\n", ret);
-		mhi_cntrl->pm_state = MHI_PM_FW_DL_ERR;
-		wake_up_all(&mhi_cntrl->state_event);
+		write_lock_irq(&mhi_cntrl->pm_lock);
+		new_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_FW_DL_ERR);
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		if (new_state == MHI_PM_FW_DL_ERR)
+			wake_up_all(&mhi_cntrl->state_event);
 	}
 
 	return ret;

