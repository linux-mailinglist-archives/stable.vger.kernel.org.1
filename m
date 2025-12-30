Return-Path: <stable+bounces-204238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 617BACEA1DC
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 16:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD6A53004E0B
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 15:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9756B86277;
	Tue, 30 Dec 2025 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPpvjQBc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F87D2C15AA
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767110284; cv=none; b=FKphm9eBWWWpqXr5hcA4r+xPbiWSFvnbpfTGXYIGu9IWr9T7RvDsIlm8z89aXVzqCnwPDkDYAyr/k397JqwgbbKdeSu2ScLidkkuR6xFY6yzpzT4m99AFffx00ac8Q4VV40Bs7S+UzBNCzY1WDbpB0S1spG2EaXDybcr9RJQLPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767110284; c=relaxed/simple;
	bh=DOpLZBV1hZ9PiZRtib3hMF8Db91sDhgS/uQAlGJOfjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mc/sBNDavAgBkY3WM/IOSBVMVD7BMy0EhDUJehdFhxzTCq8FyGtuZXMDpOiJF/ZC7jWyJhl+/SN5ZtIopFc5x6TDmOwIvpq3TqvLMBDOEILvUAhSbicvIz22aUM4gw0/RSlCgjKrVBuBjbfr3QRVt7GMd1xEfYGMgkyBA7yC1bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPpvjQBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22389C4CEFB;
	Tue, 30 Dec 2025 15:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767110283;
	bh=DOpLZBV1hZ9PiZRtib3hMF8Db91sDhgS/uQAlGJOfjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FPpvjQBce8Gv3f5W7r14ZZhasqDU/abY07r0oSvU/ITsnVJE3ewE6pm4shBoEVRLw
	 C/jn0DeXZmwkO2WEMJcI1VkljE/e5hK1gz17h2YMk+K4VtQOhEfs7cR4ZP9XwIYkaX
	 sYGBkNWboYoW7rS8MX4uG5cMduQIVSMrWZ2iUdtC2LIBxvomBztayMaVaL4/lyX7Bs
	 Sa6O0iNAQIPZ8WN9HnKqEIaHHL/fOJgqPQvr6ssbEyv7bXmkxyDE65bTOl34MkCusB
	 z63CR4yNZoI4t0O0LDwS5kE+YbKFfGMV0+x0zIue4eYuucrw5UmM6oWpdjFdazkzJZ
	 mQkniGIqNSZ3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Seunghwan Baek <sh8267.baek@samsung.com>,
	Peter Wang <peter.wang@mediatek.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] scsi: ufs: core: Add ufshcd_update_evt_hist() for UFS suspend error
Date: Tue, 30 Dec 2025 10:58:01 -0500
Message-ID: <20251230155801.2291044-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122946-attic-proofread-96f2@gregkh>
References: <2025122946-attic-proofread-96f2@gregkh>
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
index 01a7c1720ce1..1bd1f999dab0 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -10182,7 +10182,7 @@ static int ufshcd_suspend(struct ufs_hba *hba)
 	ret = ufshcd_setup_clocks(hba, false);
 	if (ret) {
 		ufshcd_enable_irq(hba);
-		return ret;
+		goto out;
 	}
 	if (ufshcd_is_clkgating_allowed(hba)) {
 		hba->clk_gating.state = CLKS_OFF;
@@ -10193,6 +10193,9 @@ static int ufshcd_suspend(struct ufs_hba *hba)
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


