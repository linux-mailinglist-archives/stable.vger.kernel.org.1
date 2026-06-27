Return-Path: <stable+bounces-269355-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MD8oHRJpP2rzSwkAu9opvQ
	(envelope-from <stable+bounces-269355-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 08:09:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4786D1411
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 08:09:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=iNBLrK9I;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269355-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269355-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4464301FA8E
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 06:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EB636F8FB;
	Sat, 27 Jun 2026 06:09:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E18F38D;
	Sat, 27 Jun 2026 06:09:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782540554; cv=none; b=s+BXuEz3CQyT0Oi7sQ/kdi8OjloT795SunAG5UZuUAaSwsq6ol7zr+LpHOp8aYXpLDCj6N28Whp6YHbWvXXsQFtdQ0RIeG4v/2wcV82E4ocg9CJO1KB2KSP2NK3hFSVcqam0U/EIocZkPAw6ZNE25YAaZt3kMMGu/HbcIr2Evx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782540554; c=relaxed/simple;
	bh=AYihhBPrL0XoG8KCDlIIajredVZEYI5qL8w3Wwm21pc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QrmTbN+znKA66jxaUH7JZbVFU+2yonQ25UqGa9Qb+mVjB2L6RpP/ZyZaqfj4EZnAp81sOE1sPUtK0YmXIiy5ckAjN5VXa+J6fMXcQkNc9F2C41WfZi4D5+9RHIcQa/hwxHwVVTdujqY9Eo1mKtQFyKtMYrAryNidlTlnmA29pVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=iNBLrK9I; arc=none smtp.client-ip=45.254.49.197
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 43fb57366;
	Sat, 27 Jun 2026 14:03:52 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: sgoutham@marvell.com
Cc: gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	bbhushan2@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jbrandeb@kernel.org,
	richardcochran@gmail.com,
	amakarov@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	zilin@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>
Subject: [PATCH net] octeontx2-pf: fix SQ resource leaks on init failure
Date: Sat, 27 Jun 2026 14:03:50 +0800
Message-Id: <20260627060350.2544241-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f07ad657d03a2kunm948e381aec012
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHR0eVk5KSUpOQ0waGRpPHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=iNBLrK9IdYKGg+jmUYxW/DwjeeAbypKlIANigz6yR8cCnOLOVGpNmnoUcqqbr8BDOIQQrMm1vcVylSSgHim4v6ZSdWy3p+q63AmTLPmWrhjGMe9ygA0OWYtw55968TFWkMHWmgvkp5VlpMk7o7HxyPHKGHukjmSVVWGMiBM/eOc=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=TGdQCFxvjEVVGPSadzxYNU8w92CyeUjRWOKitEo2+38=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sgoutham@marvell.com,m:gakula@marvell.com,m:sbhatta@marvell.com,m:hkelam@marvell.com,m:bbhushan2@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jbrandeb@kernel.org,m:richardcochran@gmail.com,m:amakarov@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:zilin@seu.edu.cn,m:dawei.feng@seu.edu.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-269355-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,seu.edu.cn];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:dkim,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB4786D1411

otx2_init_hw_resources() initializes SQ aura and pool resources
before several later setup steps. On failure, err_free_sq_ptrs only
frees SQB pages, leaving the per-SQ sqb_ptrs arrays behind. If
otx2_config_nix_queues() has initialized some SQs before failing, their
qmem-backed resources can be left behind too.

Use otx2_free_sq_res() for the SQ unwind path and let it free sqb_ptrs
even when sq->sqe has not been allocated yet. Also free the PTP
timestamp qmem from the same helper.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1.1.

An x86_64 allyesconfig build showed no new warnings. As we do not have an
OcteonTX2 PF device and the corresponding AF mailbox setup to test with,
no runtime testing was able to be performed.

Fixes: caa2da34fd25 ("octeontx2-pf: Initialize and config queues")
Fixes: c9c12d339d93 ("octeontx2-pf: Add support for PTP clock")
Cc: stable@vger.kernel.org
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 41a0ebdf201e..88ac85354445 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1568,14 +1568,15 @@ static void otx2_free_sq_res(struct otx2_nic *pf)
 	otx2_sq_free_sqbs(pf);
 	for (qidx = 0; qidx < otx2_get_total_tx_queues(pf); qidx++) {
 		sq = &qset->sq[qidx];
-		/* Skip freeing Qos queues if they are not initialized */
-		if (!sq->sqe)
-			continue;
-		qmem_free(pf->dev, sq->sqe);
-		qmem_free(pf->dev, sq->sqe_ring);
-		qmem_free(pf->dev, sq->cpt_resp);
-		qmem_free(pf->dev, sq->tso_hdrs);
-		kfree(sq->sg);
+		/* sq->sqe is not initialized for unused QoS queues */
+		if (sq->sqe) {
+			qmem_free(pf->dev, sq->sqe);
+			qmem_free(pf->dev, sq->sqe_ring);
+			qmem_free(pf->dev, sq->cpt_resp);
+			qmem_free(pf->dev, sq->tso_hdrs);
+			qmem_free(pf->dev, sq->timestamps);
+			kfree(sq->sg);
+		}
 		kfree(sq->sqb_ptrs);
 	}
 }
@@ -1710,13 +1711,12 @@ int otx2_init_hw_resources(struct otx2_nic *pf)
 	return err;
 
 err_free_nix_queues:
-	otx2_free_sq_res(pf);
 	otx2_free_cq_res(pf);
 	otx2_ctx_disable(mbox, NIX_AQ_CTYPE_RQ, false);
 err_free_txsch:
 	otx2_txschq_stop(pf);
 err_free_sq_ptrs:
-	otx2_sq_free_sqbs(pf);
+	otx2_free_sq_res(pf);
 err_free_rq_ptrs:
 	otx2_free_aura_ptr(pf, AURA_NIX_RQ);
 	otx2_ctx_disable(mbox, NPA_AQ_CTYPE_POOL, true);
-- 
2.34.1


