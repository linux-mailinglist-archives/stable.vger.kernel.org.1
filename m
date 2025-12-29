Return-Path: <stable+bounces-203573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE982CE6EFB
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E725B300719A
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 13:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943092798E8;
	Mon, 29 Dec 2025 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X6vEncYW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CB61E51E0
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016729; cv=none; b=VSAxGmp5/+Tg1s9GtmjqNNnoM5IYoTTK3Encr/ITTEn+Ozc/e/OZsFzIumJR5Kpow6MuHbCvOaTJre0oms+wIQkl59ca4ErHFPmviBSjekeaC4974mJLWBpvRz/T1YDVjOKhfnhX2+p1QPIDC4leCPr/Gn2JZMwZCEGxn/IBhkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016729; c=relaxed/simple;
	bh=taevj6wDZqdTQinRPxt7/D1ZW22kEn5MX2uVS2WC1Zo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=itgMUGQnEOSCOoFkCJXQ5yI7cd5l3HmrR/SlAaVHhog3bCd7oeSXNI769kSv3aKH+sPQ5k/0l7yHoBtugQphFBLDjkTyduk1Jv2xUbLwI/b4q1mFVPeIUUSmvXsE4ZdDton0U3O0IuhIWwLSA0I07qX2PmtK2pkM3eg9hrFC3KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X6vEncYW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7388EC4CEF7;
	Mon, 29 Dec 2025 13:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767016728;
	bh=taevj6wDZqdTQinRPxt7/D1ZW22kEn5MX2uVS2WC1Zo=;
	h=Subject:To:Cc:From:Date:From;
	b=X6vEncYWiU6C/CyWCkdarazJnzV2bpNQFofDCrGZSxVbV9R2G0b96o+Yc7ZhD54pu
	 NgUDjXr2l2g/FnsfkGrV6b2WPxPxKlhpMG/6xRdTH83z/nNGQc+3AMrCnZbdNiWcyL
	 bX5B4+5oxPMLkeiu7dh5gTF611ktuQtNrOQ/gPmY=
Subject: FAILED: patch "[PATCH] scsi: ufs: core: Add ufshcd_update_evt_hist() for UFS suspend" failed to apply to 6.6-stable tree
To: sh8267.baek@samsung.com,martin.petersen@oracle.com,peter.wang@mediatek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 14:58:46 +0100
Message-ID: <2025122946-attic-proofread-96f2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c9f36f04a8a2725172cdf2b5e32363e4addcb14c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122946-attic-proofread-96f2@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c9f36f04a8a2725172cdf2b5e32363e4addcb14c Mon Sep 17 00:00:00 2001
From: Seunghwan Baek <sh8267.baek@samsung.com>
Date: Wed, 10 Dec 2025 15:38:54 +0900
Subject: [PATCH] scsi: ufs: core: Add ufshcd_update_evt_hist() for UFS suspend
 error

If UFS resume fails, the event history is updated in ufshcd_resume(), but
there is no code anywhere to record UFS suspend. Therefore, add code to
record UFS suspend error event history.

Fixes: dd11376b9f1b ("scsi: ufs: Split the drivers/scsi/ufs directory")
Cc: stable@vger.kernel.org
Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Link: https://patch.msgid.link/20251210063854.1483899-2-sh8267.baek@samsung.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 80c0b49f30b0..0babb7035200 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -10359,7 +10359,7 @@ static int ufshcd_suspend(struct ufs_hba *hba)
 	ret = ufshcd_setup_clocks(hba, false);
 	if (ret) {
 		ufshcd_enable_irq(hba);
-		return ret;
+		goto out;
 	}
 	if (ufshcd_is_clkgating_allowed(hba)) {
 		hba->clk_gating.state = CLKS_OFF;
@@ -10371,6 +10371,9 @@ static int ufshcd_suspend(struct ufs_hba *hba)
 	/* Put the host controller in low power mode if possible */
 	ufshcd_hba_vreg_set_lpm(hba);
 	ufshcd_pm_qos_update(hba, false);
+out:
+	if (ret)
+		ufshcd_update_evt_hist(hba, UFS_EVT_SUSPEND_ERR, (u32)ret);
 	return ret;
 }
 


