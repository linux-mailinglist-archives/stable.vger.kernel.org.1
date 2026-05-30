Return-Path: <stable+bounces-258803-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOAiC64sG2pa/wgAu9opvQ
	(envelope-from <stable+bounces-258803-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:30:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A26D611D8B
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0220030941C7
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE98D282F23;
	Sat, 30 May 2026 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y2QWb38t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658A1279DC9;
	Sat, 30 May 2026 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165591; cv=none; b=KtGWM2loYeYFm26MAfz+MzDoalj4gbkFXRV39HoqzHREIYjITcC1eoiBP0pD/S61WVOi3LyOzURPBSdpaTBwlKcPEDbnYRQA+rsrcCXvkPZvdSPsOjTe84JqXzKp+y5REim0TVmkNx0KWnU87xeO0JEO/nGpmHAflmaWsKpbvQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165591; c=relaxed/simple;
	bh=CfvlMbHJZy8VaoIZQ4NnKwWHZYAGbpbNXcQRQCsl9Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GeYMfyunYEbdOM6AMgWRWTdHwaey38hizzoTovLrY3V7Up8caZ3DziZkKz3sxBseXY9dxSQklfdl0yI6GWBkzPLWVw5cEPlVqelF8Rcc7uNIssX1aCTILa2VlPBflN6xOMlsPquBznzaSzbXVF5uSl1u1yrsi4UFB8E/tzXLSCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y2QWb38t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2911F00893;
	Sat, 30 May 2026 18:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780165590;
	bh=vKKj4oQPtmEKZE7RajeG/8pAi8szjFLPN4FRfByOw3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=y2QWb38tYX6rPS1XUtKmLG3hDuYXE/CyfsWGCNWOZjBZtHowi7RN5E1ZinQ32DzPC
	 E3Jh8CIFpnEvDo/YbJ6YGS19iJtUH1L1wkLucasyS7JwB5cOI0pnKqUE5b9UswVdr1
	 aYM3HceAIMmdmMB/mcrnftiNfSdv2wKv7f3RJmqw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bean Huo <beanhuo@micron.com>,
	Stanley Chu <stanley.chu@mediatek.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 096/589] scsi: ufs: core: Improve SCSI abort handling
Date: Sat, 30 May 2026 17:59:37 +0200
Message-ID: <20260530160227.218464986@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258803-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altlinux.org:email,acm.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,oracle.com:email,mediatek.com:email]
X-Rspamd-Queue-Id: 9A26D611D8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

commit 3ff1f6b6ba6f97f50862aa50e79959cc8ddc2566 upstream.

The following has been observed on a test setup:

WARNING: CPU: 4 PID: 250 at drivers/scsi/ufs/ufshcd.c:2737 ufshcd_queuecommand+0x468/0x65c
Call trace:
 ufshcd_queuecommand+0x468/0x65c
 scsi_send_eh_cmnd+0x224/0x6a0
 scsi_eh_test_devices+0x248/0x418
 scsi_eh_ready_devs+0xc34/0xe58
 scsi_error_handler+0x204/0x80c
 kthread+0x150/0x1b4
 ret_from_fork+0x10/0x30

That warning is triggered by the following statement:

	WARN_ON(lrbp->cmd);

Fix this warning by clearing lrbp->cmd from the abort handler.

Link: https://lore.kernel.org/r/20211104181059.4129537-1-bvanassche@acm.org
Fixes: 7a3e97b0dc4b ("[SCSI] ufshcd: UFS Host controller driver")
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[ kovalev: bp to fix CVE-2021-47188; adapted placement of
  lrbp->cmd = NULL for 5.10 function structure ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index c7bf0e6bc303d..1b8072f47e7e8 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6788,6 +6788,7 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 		__ufshcd_transfer_req_compl(hba, (1UL << tag));
 		spin_unlock_irqrestore(host->host_lock, flags);
 out:
+		lrbp->cmd = NULL;
 		err = SUCCESS;
 	} else {
 		dev_err(hba->dev, "%s: failed with err %d\n", __func__, err);
-- 
2.53.0




