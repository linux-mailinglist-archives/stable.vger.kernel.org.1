Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42B26FA437
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbjEHJ4u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjEHJ4o (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:56:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A052ABE2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:56:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83B3A6224F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882F2C433EF;
        Mon,  8 May 2023 09:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539798;
        bh=VBhMY5cmf929Oo4olu5deEVkrsFV+mIEqWp7K0QMJiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vpYZu1wjFL1TKVXb2Rr27+/gwqYdYR2RgL9CcVCMiNKaSl0nDp+fuU9Uu2oUfD7I6
         IdIcOG3QkH7nio73CSnv4XKk2e7X1RHHFT7PI+03FFJNsHZr6QxlEZjhj0bTOrePJQ
         eCt568FllANXTNKKJJP2P60TvRiOYTmq1nzj2XkQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Carl Vanderlip <quic_carlv@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 6.1 110/611] bus: mhi: host: Use mhi_tryset_pm_state() for setting fw error state
Date:   Mon,  8 May 2023 11:39:12 +0200
Message-Id: <20230508094425.840358265@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Jeffrey Hugo <quic_jhugo@quicinc.com>

commit 1d1493bdc25f498468a606a4ece947d155cfa3a9 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bus/mhi/host/boot.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/drivers/bus/mhi/host/boot.c
+++ b/drivers/bus/mhi/host/boot.c
@@ -393,6 +393,7 @@ void mhi_fw_load_handler(struct mhi_cont
 {
 	const struct firmware *firmware = NULL;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_pm_state new_state;
 	const char *fw_name;
 	void *buf;
 	dma_addr_t dma_addr;
@@ -510,14 +511,18 @@ error_ready_state:
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
@@ -528,8 +533,11 @@ int mhi_download_amss_image(struct mhi_c
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


