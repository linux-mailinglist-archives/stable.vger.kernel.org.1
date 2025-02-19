Return-Path: <stable+bounces-117174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D65A3B4EC
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D09F7A4F2C
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 08:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796431DED53;
	Wed, 19 Feb 2025 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ae0aCJai"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9821CAA95;
	Wed, 19 Feb 2025 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954434; cv=none; b=nQ9Huoh7eT+XI6kIbYH54gb3h2dOP452TCL0WNy4io59itX1omQ4nMS/MirbQ2PJpHHjNaT0HxMbSeQj7IXtINPWPv9fLaXDEi+9dJ9R3oE80TRSqfesFOyHI/Z2MirVotYAEbUUpD04CL174utha27lTmJVgEt0lTf92iSolIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954434; c=relaxed/simple;
	bh=8oOFGOgdLEmwvseKWIZ+8sq5sScDp5m9iTvraiKsqeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1kIfLHecrFWdGmELbjYXtiTkVkpYNnP6DFzBuufNL+6nS4JCQ71EZyof37lrOcumL10HQL7AkF0aTs05WsJG4u6PkkwERkJPROgx88abG4z4ONPgNxKDClihwMY5DkXz1noQt0thSGO2F63Khcw94mIXzLOwaKplGedsj+b0Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ae0aCJai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C095C4CED1;
	Wed, 19 Feb 2025 08:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739954433;
	bh=8oOFGOgdLEmwvseKWIZ+8sq5sScDp5m9iTvraiKsqeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ae0aCJaiVjNeGOZVwpEii2R460CoyohBsQcK8N7lYg2ojHUul6xzkwXsmHoPE8vRt
	 emrToJQpj8mfzNLWAanbqeZg7Hublj5FlunGQtcouHiISd/dlaAmVwBGoN45oWa/lX
	 FmPEcpWDCT+Yp1jROIFMscI+2lVulsEkqi3niv6U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 202/274] scsi: ufs: core: Introduce ufshcd_has_pending_tasks()
Date: Wed, 19 Feb 2025 09:27:36 +0100
Message-ID: <20250219082617.484222349@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082609.533585153@linuxfoundation.org>
References: <20250219082609.533585153@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Avri Altman <avri.altman@wdc.com>

[ Upstream commit e738ba458e7539be1757dcdf85835a5c7b11fad4 ]

Prepare to remove hba->clk_gating.active_reqs check from
ufshcd_is_ufs_dev_busy().

Signed-off-by: Avri Altman <avri.altman@wdc.com>
Link: https://lore.kernel.org/r/20241124070808.194860-2-avri.altman@wdc.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 839a74b5649c ("scsi: ufs: Fix toggling of clk_gating.state when clock gating is not allowed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index d4a628169a51a..f2cacdac1a4fe 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -258,10 +258,16 @@ ufs_get_desired_pm_lvl_for_dev_link_state(enum ufs_dev_pwr_mode dev_state,
 	return UFS_PM_LVL_0;
 }
 
+static bool ufshcd_has_pending_tasks(struct ufs_hba *hba)
+{
+	return hba->outstanding_tasks || hba->active_uic_cmd ||
+	       hba->uic_async_done;
+}
+
 static bool ufshcd_is_ufs_dev_busy(struct ufs_hba *hba)
 {
-	return (hba->clk_gating.active_reqs || hba->outstanding_reqs || hba->outstanding_tasks ||
-		hba->active_uic_cmd || hba->uic_async_done);
+	return hba->clk_gating.active_reqs || hba->outstanding_reqs ||
+	       ufshcd_has_pending_tasks(hba);
 }
 
 static const struct ufs_dev_quirk ufs_fixups[] = {
@@ -1999,8 +2005,7 @@ static void __ufshcd_release(struct ufs_hba *hba)
 
 	if (hba->clk_gating.active_reqs || hba->clk_gating.is_suspended ||
 	    hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL ||
-	    hba->outstanding_tasks || !hba->clk_gating.is_initialized ||
-	    hba->active_uic_cmd || hba->uic_async_done ||
+	    ufshcd_has_pending_tasks(hba) || !hba->clk_gating.is_initialized ||
 	    hba->clk_gating.state == CLKS_OFF)
 		return;
 
-- 
2.39.5




