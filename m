Return-Path: <stable+bounces-224214-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBvRDj4AsGmoeQIAu9opvQ
	(envelope-from <stable+bounces-224214-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:27:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F00C824ABE5
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03483303B802
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0421387590;
	Tue, 10 Mar 2026 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbB/H4fC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F812387368;
	Tue, 10 Mar 2026 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141912; cv=none; b=bo/0TFokzOjyXmA4eY/MnRh+x/S47TnWXazmYovlAo70jzwGD+thAzwz3x9ds/hahq+3JvV4abMtW5wJ27vdTGCQczPWJtY4M7m8lnTPwzSrmeyVkoRLUECQz05HJ/Ycao2JVE/cksaVtVPGaY5600ZAGeXfjGtRbAp952x+jYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141912; c=relaxed/simple;
	bh=57TFy824UURSjzuOC8e5wn+qDnUcs/8jgq70ZIbVjac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTFYcea1eEjsPHm3dP7AOeaf8P6vrZGAksKvzWxVQoZDRUplhBa6IIyk4KS3tIrKsxsNW+IsKAi0LvK469zi5y5o46ijRJ6mi6iywlSNR7kdKluUDtsYkinmRF1VkagmLWQNu7tYIeIiWEcmMjuYL1wTsILinwXLsYXMhupbC8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbB/H4fC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45BFC19423;
	Tue, 10 Mar 2026 11:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141912;
	bh=57TFy824UURSjzuOC8e5wn+qDnUcs/8jgq70ZIbVjac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SbB/H4fCkRuW/hhRA5EzMynUX5wI+bnhS+ZqwWDBYwjrrl6nvyVkHlPcb3MYvfBbq
	 X3YSoNz8NXWyVpsrJlzrGgbuxUPAF09gJ1PjR9R6mIm5flaKNQQJVbWbqXmydGWxqo
	 EFkaMM+9hi1Fo3lBmDz+D4knkopR55GgFkMe5JF9I1SzkrVS1MniT4NJc/4OTBPB61
	 PIUCnVMUBXcLptRJTX2xBOHSafYig+vI0ax0ezuIrvCOHLBgCKJVwYvC2eh1YJkQ/B
	 PqyoDJyKt2YwI8sYj+J9Ccz9yEehaZ1ZjI2RqiKSsh+CzmJvCZHx4cZ3cQcYt5UGXh
	 b8FT0fQsiiqzQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Peter Wang <peter.wang@mediatek.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 035/314] scsi: ufs: core: Move link recovery for hibern8 exit failure to wl_resume
Date: Tue, 10 Mar 2026 07:14:54 -0400
Message-ID: <11e4ea900e88535a3481764540bf07c4c45974dd.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F00C824ABE5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224214-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Peter Wang <peter.wang@mediatek.com>

[ Upstream commit 62c015373e1cdb1cdca824bd2dbce2dac0819467 ]

Move the link recovery trigger from ufshcd_uic_pwr_ctrl() to
__ufshcd_wl_resume(). Ensure link recovery is only attempted when hibern8
exit fails during resume, not during hibern8 enter in suspend. Improve
error handling and prevent unnecessary link recovery attempts.

Fixes: 35dabf4503b9 ("scsi: ufs: core: Use link recovery when h8 exit fails during runtime resume")
Signed-off-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20260223103906.2533654-1-peter.wang@mediatek.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 755aa9c0017df..dae23ec4fcea8 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4401,14 +4401,6 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 	mutex_unlock(&hba->uic_cmd_mutex);
 
-	/*
-	 * If the h8 exit fails during the runtime resume process, it becomes
-	 * stuck and cannot be recovered through the error handler.  To fix
-	 * this, use link recovery instead of the error handler.
-	 */
-	if (ret && hba->pm_op_in_progress)
-		ret = ufshcd_link_recovery(hba);
-
 	return ret;
 }
 
@@ -10058,7 +10050,15 @@ static int __ufshcd_wl_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 		} else {
 			dev_err(hba->dev, "%s: hibern8 exit failed %d\n",
 					__func__, ret);
-			goto vendor_suspend;
+			/*
+			 * If the h8 exit fails during the runtime resume
+			 * process, it becomes stuck and cannot be recovered
+			 * through the error handler. To fix this, use link
+			 * recovery instead of the error handler.
+			 */
+			ret = ufshcd_link_recovery(hba);
+			if (ret)
+				goto vendor_suspend;
 		}
 	} else if (ufshcd_is_link_off(hba)) {
 		/*
-- 
2.51.0


