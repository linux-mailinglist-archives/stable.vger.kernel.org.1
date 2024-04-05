Return-Path: <stable+bounces-36092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51831899B23
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 12:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05DD71F228EC
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 10:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58B416ABC6;
	Fri,  5 Apr 2024 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SLPDqJZc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6698F18E02
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313880; cv=none; b=hwoXdk+G7khLJdrn3SQc6Az1/N8jiw4HmpvIbiX0f3AmbgjC1zwMdbN01OvnCLkwjT6zlGJjQuHhvFxPeX29EsUHoYJ1HYABT+z5T6bvRMr7c094lrqsSx1NZcdnl4q1AD1+Vj85NKe2cfp9if9B6SG8/20/gdh4CsUJW7hJSdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313880; c=relaxed/simple;
	bh=/JmbL5H7e3utU3RIr8glc8+kPrDeBIPQkrHUSmkoS1U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=e/K5CJgZXN7upDSZqAkJvbjba8QykxtELsRZ12vmcol+VNxhMfFzq6YiA2tPc2pGd2pyx5QLA20FIWv4nZwD59YSVfb0HCw/hn4qLNsRn0LPT270eYmQcvN3LbyJUVNrSGmYCyX0wdA8eYwO3iUh1MHfKKCCsnpfbGpfccnfskc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SLPDqJZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA84EC433C7;
	Fri,  5 Apr 2024 10:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712313880;
	bh=/JmbL5H7e3utU3RIr8glc8+kPrDeBIPQkrHUSmkoS1U=;
	h=Subject:To:Cc:From:Date:From;
	b=SLPDqJZcQ4UhNlhZJBkbJ00DCvoVAqvziiK4cQYcgSkycwu/t0QCpS9NVCrYnSCAh
	 I2zou5dXzeARc4V1E8tQDnngo7/Y2h7ySpWt8dMBjG+pBWOwvCCjYY8JryR6e86D1H
	 H+9oF5qOf0dgcBxCUaEAAUJtFPrYd/3yPvwlVBJM=
Subject: FAILED: patch "[PATCH] e1000e: move force SMBUS from enable ulp function to avoid" failed to apply to 5.4-stable tree
To: vitaly.lifshits@intel.com,anthony.l.nguyen@intel.com,dima.ruinskiy@intel.com,naamax.meir@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 12:44:37 +0200
Message-ID: <2024040536-paying-life-0a32@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 861e8086029e003305750b4126ecd6617465f5c7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040536-paying-life-0a32@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 861e8086029e003305750b4126ecd6617465f5c7 Mon Sep 17 00:00:00 2001
From: Vitaly Lifshits <vitaly.lifshits@intel.com>
Date: Sun, 3 Mar 2024 12:51:32 +0200
Subject: [PATCH] e1000e: move force SMBUS from enable ulp function to avoid
 PHY loss issue

Forcing SMBUS inside the ULP enabling flow leads to sporadic PHY loss on
some systems. It is suspected to be caused by initiating PHY transactions
before the interface settles.

Separating this configuration from the ULP enabling flow and moving it to
the shutdown function allows enough time for the interface to settle and
avoids adding a delay.

Fixes: 6607c99e7034 ("e1000e: i219 - fix to enable both ULP and EEE in Sx state")
Co-developed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index d8e97669f31b..f9e94be36e97 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1165,25 +1165,6 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
 	if (ret_val)
 		goto out;
 
-	/* Switching PHY interface always returns MDI error
-	 * so disable retry mechanism to avoid wasting time
-	 */
-	e1000e_disable_phy_retry(hw);
-
-	/* Force SMBus mode in PHY */
-	ret_val = e1000_read_phy_reg_hv_locked(hw, CV_SMB_CTRL, &phy_reg);
-	if (ret_val)
-		goto release;
-	phy_reg |= CV_SMB_CTRL_FORCE_SMBUS;
-	e1000_write_phy_reg_hv_locked(hw, CV_SMB_CTRL, phy_reg);
-
-	e1000e_enable_phy_retry(hw);
-
-	/* Force SMBus mode in MAC */
-	mac_reg = er32(CTRL_EXT);
-	mac_reg |= E1000_CTRL_EXT_FORCE_SMBUS;
-	ew32(CTRL_EXT, mac_reg);
-
 	/* Si workaround for ULP entry flow on i127/rev6 h/w.  Enable
 	 * LPLU and disable Gig speed when entering ULP
 	 */
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index cc8c531ec3df..3692fce20195 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6623,6 +6623,7 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
 	struct e1000_hw *hw = &adapter->hw;
 	u32 ctrl, ctrl_ext, rctl, status, wufc;
 	int retval = 0;
+	u16 smb_ctrl;
 
 	/* Runtime suspend should only enable wakeup for link changes */
 	if (runtime)
@@ -6696,6 +6697,23 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
 			if (retval)
 				return retval;
 		}
+
+		/* Force SMBUS to allow WOL */
+		/* Switching PHY interface always returns MDI error
+		 * so disable retry mechanism to avoid wasting time
+		 */
+		e1000e_disable_phy_retry(hw);
+
+		e1e_rphy(hw, CV_SMB_CTRL, &smb_ctrl);
+		smb_ctrl |= CV_SMB_CTRL_FORCE_SMBUS;
+		e1e_wphy(hw, CV_SMB_CTRL, smb_ctrl);
+
+		e1000e_enable_phy_retry(hw);
+
+		/* Force SMBus mode in MAC */
+		ctrl_ext = er32(CTRL_EXT);
+		ctrl_ext |= E1000_CTRL_EXT_FORCE_SMBUS;
+		ew32(CTRL_EXT, ctrl_ext);
 	}
 
 	/* Ensure that the appropriate bits are set in LPI_CTRL


