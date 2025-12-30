Return-Path: <stable+bounces-204240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F40E2CEA1EB
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 17:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E26713003B36
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 16:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FBB2264D5;
	Tue, 30 Dec 2025 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVj4N7BV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778B11A9F86
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767110522; cv=none; b=jgmmlOXP8E9WVFykBsMTxZnO3+8L2yFujARzTi7IqZOyJxCc6e3USlgi5Y43DbdVx0Lkj88/U6VvSephMs0mBK5cR+FDytyeLjtzlO9BUUQvJNRTX3Ug0euLnlgE6yo5mQK43L4dSSV4ZUh2QhsCQTqVr29yAlDNyloFNktguNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767110522; c=relaxed/simple;
	bh=aS5CMnA/W2qga5jIWVPg06BdV7RGBWCVjA1BmhplcYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qouM5I0FFInTfy24CjCVCgLpyUVyotf+mSDqVvQzELwTamBHxX0Nz2p2EC2P4Zi5wCQxA4AqkjeEXYfKzojKx8+o3AzP10f6sWnHOZpAw6eKbzJpywlu9AREy1tLtthdemw04IOXjseWsTXIYck4hb6o8H81rWHu53zzrZpCg5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVj4N7BV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A4AC4CEFB;
	Tue, 30 Dec 2025 16:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767110521;
	bh=aS5CMnA/W2qga5jIWVPg06BdV7RGBWCVjA1BmhplcYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MVj4N7BV2xoSvOTJI5uJHdElOurlBl+vbR9u73gY/NTCqM1Ut+PwSD70IBiRn8r23
	 6l1ntww29WrhvP+IYkl686t8Vk8Uyn8fcYPE4xXtJpLL9ZtFaD6u2IC1r84vTWduBC
	 UVMA+IajwNcThqnWydH2Qg598gUBnX4ycX8x/u9zsZ+tnnmwWX7rJ+qLhnL3vTt6tO
	 9mmhuGpqnY6DCQxcNtRTxCCYZ3FaWAsNB4Q7KrWqDsYYLcwC7SvCWyv3Vh8Nnhw8VK
	 14PDHum73pMzavdDkTe2s/TpnvBQ5HUBa8p4GMQK/7pItX0xRN0CmzUSqZzcAlUA3b
	 4OLlT+zoQltFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Seunghwan Baek <sh8267.baek@samsung.com>,
	Peter Wang <peter.wang@mediatek.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] scsi: ufs: core: Add ufshcd_update_evt_hist() for UFS suspend error
Date: Tue, 30 Dec 2025 11:01:59 -0500
Message-ID: <20251230160159.2292887-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122946-repeater-wasting-b205@gregkh>
References: <2025122946-repeater-wasting-b205@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seunghwan Baek <sh8267.baek@samsung.com>

[ Upstream commit c9f36f04a8a2725172cdf2b5e32363e4addcb14c ]

If UFS resume fails, the event history is updated in ufshcd_resume(), but
there is no code anywhere to record UFS suspend. Therefore, add code to
record UFS suspend error event history.

Fixes: dd11376b9f1b ("scsi: ufs: Split the drivers/scsi/ufs directory")
Cc: stable@vger.kernel.org
Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Link: https://patch.msgid.link/20251210063854.1483899-2-sh8267.baek@samsung.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 1120e83f781e..21613808c90d 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9437,7 +9437,7 @@ static int ufshcd_suspend(struct ufs_hba *hba)
 	ret = ufshcd_setup_clocks(hba, false);
 	if (ret) {
 		ufshcd_enable_irq(hba);
-		return ret;
+		goto out;
 	}
 	if (ufshcd_is_clkgating_allowed(hba)) {
 		hba->clk_gating.state = CLKS_OFF;
@@ -9448,6 +9448,9 @@ static int ufshcd_suspend(struct ufs_hba *hba)
 	ufshcd_vreg_set_lpm(hba);
 	/* Put the host controller in low power mode if possible */
 	ufshcd_hba_vreg_set_lpm(hba);
+out:
+	if (ret)
+		ufshcd_update_evt_hist(hba, UFS_EVT_SUSPEND_ERR, (u32)ret);
 	return ret;
 }
 
-- 
2.51.0


