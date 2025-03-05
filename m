Return-Path: <stable+bounces-120644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D597DA507B3
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F67216A54E
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 17:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC722512CB;
	Wed,  5 Mar 2025 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FCO8N/kp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C23214B075;
	Wed,  5 Mar 2025 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197557; cv=none; b=d7l0iZX9N+huvfWgaZZ7WmSXmIi5ssJxL1u6kSv5p1ul3EOTOzVfqyKnk1DSbYuVaBAusswuSuYB1suqVeB5IJGylDDnnt/jwPyVLmj7sQAozFDjdCxI71GQpaGdS6c8yPBHllr3jPV1h42DIHNQoUeOlD3i+tfv88I+0O9ffNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197557; c=relaxed/simple;
	bh=p+HkdvYo6KozQwIyt+KzVtIRrmiC+0ahmj10MJG+yzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X5ciNej1az3tZwI3xWjgw56a4lKOUddrSRZzaKvjScZ/MB1OLMCwwUTR4DCxWOa9wc3/MKMTxDquaZIq5H8aF3/qM9vVkclaBR09LeIKmxCO09N+tQCIb7OOsh7pxH506zJ5HZL1aa7GLsSMVycpWb5UVYRKHCkMxPYqFvDKGNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FCO8N/kp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04102C4CED1;
	Wed,  5 Mar 2025 17:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197557;
	bh=p+HkdvYo6KozQwIyt+KzVtIRrmiC+0ahmj10MJG+yzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FCO8N/kpBilFXIeDP8/Sg3/em8ow9F2JCAkBhZqzzb7tYIN3cbJaRsQt/+TRnauKk
	 /kpzMquLjez11PjXsEBy+dNRlhNn7vTu9ooGZW7nOXgw3ZvtK3KS1JA5EYZB7R+nL7
	 Cvmr5mKVr1icbNzkbH8NB+NvM8VnJFiwkshc+vHk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bean Huo <beanhuo@micron.com>,
	Avri Altman <avri.altman@wdc.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 003/142] scsi: ufs: core: Add ufshcd_is_ufs_dev_busy()
Date: Wed,  5 Mar 2025 18:47:02 +0100
Message-ID: <20250305174500.472126944@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174500.327985489@linuxfoundation.org>
References: <20250305174500.327985489@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bean Huo <beanhuo@micron.com>

[ Upstream commit 9fa268875ca4ff5cad0c1b957388a0aef39920c3 ]

Add helper inline for retrieving whether UFS device is busy or not.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Link: https://lore.kernel.org/r/20231212220825.85255-2-beanhuo@iokpp.de
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 4fa382be4304 ("scsi: ufs: core: Fix ufshcd_is_ufs_dev_busy() and ufshcd_eh_timed_out()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 0ac0b6aaf9c62..fe1c56bc0a127 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -234,6 +234,12 @@ ufs_get_desired_pm_lvl_for_dev_link_state(enum ufs_dev_pwr_mode dev_state,
 	return UFS_PM_LVL_0;
 }
 
+static bool ufshcd_is_ufs_dev_busy(struct ufs_hba *hba)
+{
+	return (hba->clk_gating.active_reqs || hba->outstanding_reqs || hba->outstanding_tasks ||
+		hba->active_uic_cmd || hba->uic_async_done);
+}
+
 static const struct ufs_dev_quirk ufs_fixups[] = {
 	/* UFS cards deviations table */
 	{ .wmanufacturerid = UFS_VENDOR_MICRON,
@@ -1816,10 +1822,7 @@ static void ufshcd_gate_work(struct work_struct *work)
 		goto rel_lock;
 	}
 
-	if (hba->clk_gating.active_reqs
-		|| hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL
-		|| hba->outstanding_reqs || hba->outstanding_tasks
-		|| hba->active_uic_cmd || hba->uic_async_done)
+	if (ufshcd_is_ufs_dev_busy(hba) || hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL)
 		goto rel_lock;
 
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
-- 
2.39.5




