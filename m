Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD66703831
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244308AbjEOR3S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244254AbjEOR2u (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:28:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3767271B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:26:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B02C62CF6
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4203DC433EF;
        Mon, 15 May 2023 17:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171591;
        bh=HqBt4IwpuwoTkXOZQ0w179BO0NSCN2gQ0XV6UM7h1/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g5EnuTlyeuk/CsiFGrdDW2Uuo8izDVVPZYnHry+C4xTblPLt2qFrKls7Ac7LXq6XK
         T8oQBSU1aabckI+gw5PuKeewhEbIGHKW2OAfbKjy3NtrJMdLYkm+TgJ77tEjYDHJHC
         guZFg3WWg+PH9kvj6O/mPcOU/B2snguYGotvCahQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Carl Vanderlip <quic_carlv@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 007/134] bus: mhi: host: Use mhi_tryset_pm_state() for setting fw error state
Date:   Mon, 15 May 2023 18:28:04 +0200
Message-Id: <20230515161703.180368726@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
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

[ Upstream commit 1d1493bdc25f498468a606a4ece947d155cfa3a9 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/mhi/host/boot.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
index 0a972620a4030..c9dfb1a48ad6d 100644
--- a/drivers/bus/mhi/host/boot.c
+++ b/drivers/bus/mhi/host/boot.c
@@ -390,6 +390,7 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 {
 	const struct firmware *firmware = NULL;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_pm_state new_state;
 	const char *fw_name;
 	void *buf;
 	dma_addr_t dma_addr;
@@ -507,14 +508,18 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
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
@@ -525,8 +530,11 @@ int mhi_download_amss_image(struct mhi_controller *mhi_cntrl)
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
-- 
2.39.2



