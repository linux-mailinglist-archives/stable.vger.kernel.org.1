Return-Path: <stable+bounces-249764-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 72A+O3FbDWolwgUAu9opvQ
	(envelope-from <stable+bounces-249764-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 08:57:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 166105888CF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 08:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 792EB3020926
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 06:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A8331BCAE;
	Wed, 20 May 2026 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Dm7mmVK+"
X-Original-To: stable@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31704364935;
	Wed, 20 May 2026 06:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779260050; cv=none; b=M/OUJptTCdmVrpxQh5jkVzp0RyugVQDqp1lFpZVEdT5aFpsf/O8oDGZ+Q+az9ZShoLqu9WQmaGeDt4HQxxELoiEvjjWkcuaIFMwrV/pgFbEyvQ6wunDu8XPpKYy2F9uHLI2MZWAwCQDaHY8a3cVI7UcQAt30GPur8e+QIp8RWXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779260050; c=relaxed/simple;
	bh=nZBzkF22Fnvnv4LAoZSqIjIvQqrXiS0Qc8o7VuIqEeU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EdEgBuDkOakHuRPsK6QnA49PcL8HtjdVfU2JNE0aqK+XWMoFPFpzCo5qCujs74juweozwFregj80kFD/awTJGRpN1AVHAUs7+WhkmYfU2B9zYQd50pJE7XpGJIeZGbT9RhZkyYEQzXfgbD636kawkpsmDUZnBcTr8XyJpkX9BTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Dm7mmVK+; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3f1c758e6;
	Wed, 20 May 2026 14:48:47 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: kashyap.desai@broadcom.com
Cc: sumit.saxena@broadcom.com,
	shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.or,
	jianhao.xu@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	stable@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] scsi: megaraid_sas: Fix double free on cmd_list alloc failure
Date: Wed, 20 May 2026 14:48:43 +0800
Message-Id: <20260520064843.2753646-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e4424deb003a2kunm46fb147c2cc8d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZQhlJVkJKGkhOHkNKThkZHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=Dm7mmVK+pQEIgInA3G7+KmIbUYiMxpn6d6znOpULt6HVvclZHrALQ4iK1ZFB8lI8Af/phCRVf9JffguSsDzGutPaoiamrzkGcztju/8eucIJp8VTfAyMBTJVYMW5RokLk4QKh2qd8jUcRe4yJKEnFS+NmYXbZTWs1ytneTT6Am0=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=z5sb4ODm+96yN5AZ3Nq8GDQprPQ3p91X7QfXI3dIY6A=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249764-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 166105888CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If one of the per-command allocations in
megasas_alloc_cmdlist_fusion() fails, megasas_alloc_cmdlist_fusion()
frees the previously allocated command objects and the cmd_list array
before returning an error. megasas_alloc_cmds_fusion() then goes to
fail_exit and calls megasas_free_cmds_fusion(), which tries to free
the same cmd_list resources again.

Set fusion->cmd_list to NULL after local cleanup in
megasas_alloc_cmdlist_fusion() so the outer cleanup path skips the
already freed array and only releases the remaining resources.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1-rc3.

Runtime validation was not performed because reproducing this path
requires a MegaRAID controller and fault injection for command-list
allocation failure during controller initialization.

Fixes: e97e673ca63b ("scsi: megaraid_sas: Retry with reduced queue depth when alloc fails for higher QD")
Cc: stable@vger.kernel.org
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 2699e4e09b5b..a68e08132a61 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -611,6 +611,7 @@ megasas_alloc_cmdlist_fusion(struct megasas_instance *instance)
 			for (j = 0; j < i; j++)
 				kfree(fusion->cmd_list[j]);
 			kfree(fusion->cmd_list);
+			fusion->cmd_list = NULL;
 			dev_err(&instance->pdev->dev,
 				"Failed from %s %d\n",  __func__, __LINE__);
 			return -ENOMEM;
-- 
2.34.1


