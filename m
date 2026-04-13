Return-Path: <stable+bounces-236526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEcmIgwb3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:34:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9043EF46E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 365BC3024DD6
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5D72FE056;
	Mon, 13 Apr 2026 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HoMNTav1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4DA27280A;
	Mon, 13 Apr 2026 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097133; cv=none; b=q10wnLi+vcSyYTp2MXW5IrOpOclnafjEtCLNIIsLuxtyB0PjC2fXWFO6L0r3tBYVgf/ArEOMPGBzAp3UMoOfIqx7OcQy8MnRQQteQcWWBqOLORGPp7Uzfu9BtDS06DT8qcBrY268h1eTm9S5RYHecjm1tzYbCximHbs7Hlgr1BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097133; c=relaxed/simple;
	bh=EObskl9AMg9gxm7iDpOU44zSHyUQHktyXoNQJbWb/C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HaJwH7lDjh8A0khaGPozHmAhAeGJmCF4/1aJ7Fsvu1kg7owL3JXiZl4EyPNfrY0PVzHx0GjKNqhsFvRRlVlrH0Hc7Wt/q1ZrCF6TcQJsWkJaZdWzS8ctJKqq6hfvb1tB6WnVuPTc6kQNXK6Go8DgxhlHidW563OMR5zRnITZYZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HoMNTav1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD26C2BCAF;
	Mon, 13 Apr 2026 16:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097133;
	bh=EObskl9AMg9gxm7iDpOU44zSHyUQHktyXoNQJbWb/C8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HoMNTav1sPaH1M63tQICFYGoqXvEDHY+mhPhzbW0F3S+PR5g7RFBON/jjFpt+2RO/
	 lY+NNDraIO1ZePyRRDF4pSpRnMY4K9NOzlqJHeT8s6qtTic4tdKtvCjv9d18DEvft2
	 AOPxiWWt4ldkH515zWTFNJVBc2st7ozHs/5Bf5hM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Wang <peter.wang@mediatek.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 006/570] scsi: ufs: core: Always initialize the UIC done completion
Date: Mon, 13 Apr 2026 17:52:17 +0200
Message-ID: <20260413155830.633716014@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236526-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,mediatek.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 9E9043EF46E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit b1e8c53749adb795bfb0bf4e2f7836e26684bb90 ]

Simplify __ufshcd_send_uic_cmd() by always initializing the
uic_cmd::done completion. This is fine since the time required to
initialize a completion is small compared to the time required to
process an UIC command.

Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20240912223019.3510966-5-bvanassche@acm.org
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 62c015373e1c ("scsi: ufs: core: Move link recovery for hibern8 exit failure to wl_resume")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 736a2dd630a7a..9d9088e207cc2 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2300,13 +2300,11 @@ ufshcd_wait_for_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
  * __ufshcd_send_uic_cmd - Send UIC commands and retrieve the result
  * @hba: per adapter instance
  * @uic_cmd: UIC command
- * @completion: initialize the completion only if this is set to true
  *
  * Returns 0 only if success.
  */
 static int
-__ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd,
-		      bool completion)
+__ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
 {
 	lockdep_assert_held(&hba->uic_cmd_mutex);
 
@@ -2316,8 +2314,7 @@ __ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd,
 		return -EIO;
 	}
 
-	if (completion)
-		init_completion(&uic_cmd->done);
+	init_completion(&uic_cmd->done);
 
 	uic_cmd->cmd_active = 1;
 	ufshcd_dispatch_uic_cmd(hba, uic_cmd);
@@ -2340,7 +2337,7 @@ int ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
 	mutex_lock(&hba->uic_cmd_mutex);
 	ufshcd_add_delay_before_dme_cmd(hba);
 
-	ret = __ufshcd_send_uic_cmd(hba, uic_cmd, true);
+	ret = __ufshcd_send_uic_cmd(hba, uic_cmd);
 	if (!ret)
 		ret = ufshcd_wait_for_uic_cmd(hba, uic_cmd);
 
@@ -3969,7 +3966,7 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 		reenable_intr = true;
 	}
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
-	ret = __ufshcd_send_uic_cmd(hba, cmd, false);
+	ret = __ufshcd_send_uic_cmd(hba, cmd);
 	if (ret) {
 		dev_err(hba->dev,
 			"pwr ctrl cmd 0x%x with mode 0x%x uic error %d\n",
-- 
2.51.0




