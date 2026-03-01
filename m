Return-Path: <stable+bounces-222375-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ITnGKOho2k3IQUAu9opvQ
	(envelope-from <stable+bounces-222375-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:17:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 968861CD5E9
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B63A4303DF71
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99162FFFB5;
	Sun,  1 Mar 2026 02:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLw2Dxta"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3142FE59C;
	Sun,  1 Mar 2026 02:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330724; cv=none; b=M8Z9bN6X9J6beY/MpB61oIsNmF71QdLQFbZcbiItG1ZfxKABxSK8YcbMxZksMpZtkMVUtevrAtrU4Q8fBmqEkTEkH7tk8dOU4iLgwpvKB2aDF7U+xiQ4KfGbWi73hHLhfG8kqigvykpwUpVXixRs3dOXNs5yXzpbclQ6L1qGTo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330724; c=relaxed/simple;
	bh=E8bZfk1m4w0ex3MMS3VmfA8XccNPAJX6qmf5KIxzNdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z7rtWs3nUEdt6DMMp+7677fz1qGSnlvXKUG715GCbgmKewq/8UoIcNiGVl2AUCoQoOiLmfvLizc5DUjOWWvvuukp7qoDREW4AR8BY4J31VjbamBP/L/917EhpvpQKOE5wxC3FqzP1VoC2MRo9yscIL8HD5YTTMmtk8vtigI+4RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLw2Dxta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB03C19421;
	Sun,  1 Mar 2026 02:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330724;
	bh=E8bZfk1m4w0ex3MMS3VmfA8XccNPAJX6qmf5KIxzNdk=;
	h=From:To:Cc:Subject:Date:From;
	b=vLw2DxtatSJ/ZZ81CShMZmTB37+7LqfR2DgUBqEmL5pUuWhcrev5hMTvKemxgnEs3
	 lDcF7eHfHYe7snCTusAcaYz/kRnwEfdJg1CTJsO5mnI/mDub/oBsTC3yY6HqbBZFyX
	 tOGOIesbF7gOfpWvp2IfZYgBUvMQyMmbDcx5uxa4FcdvCqtQ5bSyT9rEtf9lLe1vb4
	 +BoXWwkqo840bEh4DcrMHfYdusd0/O7emnEVth7/2LgHe2AwnAkCMipbflpJR2l5Ox
	 iLNiY+DTepj6uOSxqT4mQobiie6qada7mhxyiM1MHcb5k20h+fXXWY7jO+HiyZHosM
	 AEtrUpo/ptO9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	duoming@zju.edu.cn
Cc: stable@kernel.org,
	Jijie Shao <shaojijie@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org
Subject: FAILED: Patch "atm: fore200e: fix use-after-free in tasklets during device removal" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:05:19 -0500
Message-ID: <20260301020522.1734023-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222375-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,huawei.com:email,zju.edu.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 968861CD5E9
X-Rspamd-Action: no action

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8930878101cd40063888a68af73b1b0f8b6c79bc Mon Sep 17 00:00:00 2001
From: Duoming Zhou <duoming@zju.edu.cn>
Date: Tue, 10 Feb 2026 17:45:37 +0800
Subject: [PATCH] atm: fore200e: fix use-after-free in tasklets during device
 removal

When the PCA-200E or SBA-200E adapter is being detached, the fore200e
is deallocated. However, the tx_tasklet or rx_tasklet may still be running
or pending, leading to use-after-free bug when the already freed fore200e
is accessed again in fore200e_tx_tasklet() or fore200e_rx_tasklet().

One of the race conditions can occur as follows:

CPU 0 (cleanup)           | CPU 1 (tasklet)
fore200e_pca_remove_one() | fore200e_interrupt()
  fore200e_shutdown()     |   tasklet_schedule()
    kfree(fore200e)       | fore200e_tx_tasklet()
                          |   fore200e-> // UAF

Fix this by ensuring tx_tasklet or rx_tasklet is properly canceled before
the fore200e is released. Add tasklet_kill() in fore200e_shutdown() to
synchronize with any pending or running tasklets. Moreover, since
fore200e_reset() could prevent further interrupts or data transfers,
the tasklet_kill() should be placed after fore200e_reset() to prevent
the tasklet from being rescheduled in fore200e_interrupt(). Finally,
it only needs to do tasklet_kill() when the fore200e state is greater
than or equal to FORE200E_STATE_IRQ, since tasklets are uninitialized
in earlier states. In a word, the tasklet_kill() should be placed in
the FORE200E_STATE_IRQ branch within the switch...case structure.

This bug was identified through static analysis.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@kernel.org
Suggested-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Reviewed-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260210094537.9767-1-duoming@zju.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/atm/fore200e.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index f62e385714403..fec081db36dc4 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -373,6 +373,10 @@ fore200e_shutdown(struct fore200e* fore200e)
 	fallthrough;
     case FORE200E_STATE_IRQ:
 	free_irq(fore200e->irq, fore200e->atm_dev);
+#ifdef FORE200E_USE_TASKLET
+	tasklet_kill(&fore200e->tx_tasklet);
+	tasklet_kill(&fore200e->rx_tasklet);
+#endif
 
 	fallthrough;
     case FORE200E_STATE_ALLOC_BUF:
-- 
2.51.0





