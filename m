Return-Path: <stable+bounces-228449-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMKjJBpRwWnLSAQAu9opvQ
	(envelope-from <stable+bounces-228449-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:41:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A4B2F4FD8
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 630883120BD3
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5433B0ACD;
	Mon, 23 Mar 2026 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KwoxM428"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51703AF66E;
	Mon, 23 Mar 2026 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275163; cv=none; b=WuF50gGiI7YV+DZjXhpsO3gOmfwSfk4AXcmB0NCxHT6PLFHy60PWADA/xxZwqhhVTGKYEIteg4AX2+5eJdVV/akQNw+DMPfsymyPfDKxV3hmgtRrCV3mPf1luKRBUpH71+jAJsV1oHHICgRRCKgFqyFNuZTQdhmavrAUbf4syAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275163; c=relaxed/simple;
	bh=TtqQnZH6EYXX4p+AhtuzMjaGzetAlPIhTpnm4P+lzGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7uafl12fiUmo7oBDrmaDn/J36A231yQBYRtzml1/g+26JSRPlBGwwOxkfdzYG6XI7xULSSWUr+T65m0uGrIDqiwkhFjT35xflyxv+AIxVqqFxrxvr7fl8CIeg7bEqXC+Ru3zvNqZektP7iPjlFTXiynOl/d6fSR/PhA0d5e6UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KwoxM428; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C76C4CEF7;
	Mon, 23 Mar 2026 14:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275162;
	bh=TtqQnZH6EYXX4p+AhtuzMjaGzetAlPIhTpnm4P+lzGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KwoxM428E/FQER1ejtlkxPXoJiy3ScjEtJKQONmsSfzg8qNpDz5D6OTo7l/CoKboS
	 OVH4hYOXrV+8L3ZRAnZyu+jLqTrVTQsn1HjGYhxVrcIlukXsnECKJvrjFtgcPgLbF1
	 YdziIZbARX1jO9YpVFzcg3nRD0vkB6/vvkrQq+kI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Wang <peter.wang@mediatek.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 008/481] scsi: ufs: core: Always initialize the UIC done completion
Date: Mon, 23 Mar 2026 14:39:50 +0100
Message-ID: <20260323134525.458722251@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228449-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 10A4B2F4FD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/ufs/core/ufshcd.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 01927facaa203..6d44c2adb251a 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2340,13 +2340,11 @@ ufshcd_wait_for_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
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
 
@@ -2356,8 +2354,7 @@ __ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd,
 		return -EIO;
 	}
 
-	if (completion)
-		init_completion(&uic_cmd->done);
+	init_completion(&uic_cmd->done);
 
 	uic_cmd->cmd_active = 1;
 	ufshcd_dispatch_uic_cmd(hba, uic_cmd);
@@ -2383,7 +2380,7 @@ int ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
 	mutex_lock(&hba->uic_cmd_mutex);
 	ufshcd_add_delay_before_dme_cmd(hba);
 
-	ret = __ufshcd_send_uic_cmd(hba, uic_cmd, true);
+	ret = __ufshcd_send_uic_cmd(hba, uic_cmd);
 	if (!ret)
 		ret = ufshcd_wait_for_uic_cmd(hba, uic_cmd);
 
@@ -4081,7 +4078,7 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
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




