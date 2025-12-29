Return-Path: <stable+bounces-204008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EFDCE77BF
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71118300FA29
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B689331219;
	Mon, 29 Dec 2025 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qq+FdrAP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288EA33064F;
	Mon, 29 Dec 2025 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767025792; cv=none; b=EjA6Wb6RghNM+RQc7zOUAkCzqFxZrzZcWF4ZvGVCq1S3PvDCGrsSMcqx0pZKIeoGss03WfMo6JpV0iaveshFJcaXLia8muB6Cl/PqkBCEf5xr5AgaT3YubgDn2UdEjNhKrFM/X4oboXG1k321FLc/cxE7dpcCV27BKY6MQJiyzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767025792; c=relaxed/simple;
	bh=/0Cc5hSvvW6ISYpSslGOaHor7aF2T5lE48NdxIAq2cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PigQDaDNRKegy+h8B8f5QI7vXlY0ryBSX863QewVlYflkAboerDPsgzMWxfLYlNmvdNU2IfgHsFOcNm3hQyl79XKC1LOueNUAfyPtJ9t2w1dF0Pu4Hwvat35eFFcSwwNCub54pb4Q85JQAn+pQ0oAkOtqYSLrbeBeDNnFbuc7XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qq+FdrAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4A4C4CEF7;
	Mon, 29 Dec 2025 16:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767025791;
	bh=/0Cc5hSvvW6ISYpSslGOaHor7aF2T5lE48NdxIAq2cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qq+FdrAPBwuDjVNIj8cAk6pYBDNPlEH+U8L6YEtDT7b4m2jvtRSg5EnvD1+ls1GyN
	 aJ9TFdC1Xls0CZQBMRl3qK9/DGnkLoMwfP4mLW67ebMI1Fg+GQDyW93V12PNLE8vnG
	 kWovKubKpYXBDAzN38SF5VtQ5Fd+NWFTGBWdq6c4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Seunghwan Baek <sh8267.baek@samsung.com>,
	Peter Wang <peter.wang@mediatek.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.18 311/430] scsi: ufs: core: Add ufshcd_update_evt_hist() for UFS suspend error
Date: Mon, 29 Dec 2025 17:11:53 +0100
Message-ID: <20251229160735.776530021@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>
References: <20251229160724.139406961@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Seunghwan Baek <sh8267.baek@samsung.com>

commit c9f36f04a8a2725172cdf2b5e32363e4addcb14c upstream.

If UFS resume fails, the event history is updated in ufshcd_resume(), but
there is no code anywhere to record UFS suspend. Therefore, add code to
record UFS suspend error event history.

Fixes: dd11376b9f1b ("scsi: ufs: Split the drivers/scsi/ufs directory")
Cc: stable@vger.kernel.org
Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Link: https://patch.msgid.link/20251210063854.1483899-2-sh8267.baek@samsung.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ufs/core/ufshcd.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -10223,7 +10223,7 @@ static int ufshcd_suspend(struct ufs_hba
 	ret = ufshcd_setup_clocks(hba, false);
 	if (ret) {
 		ufshcd_enable_irq(hba);
-		return ret;
+		goto out;
 	}
 	if (ufshcd_is_clkgating_allowed(hba)) {
 		hba->clk_gating.state = CLKS_OFF;
@@ -10235,6 +10235,9 @@ static int ufshcd_suspend(struct ufs_hba
 	/* Put the host controller in low power mode if possible */
 	ufshcd_hba_vreg_set_lpm(hba);
 	ufshcd_pm_qos_update(hba, false);
+out:
+	if (ret)
+		ufshcd_update_evt_hist(hba, UFS_EVT_SUSPEND_ERR, (u32)ret);
 	return ret;
 }
 



