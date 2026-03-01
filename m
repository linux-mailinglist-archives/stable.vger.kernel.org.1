Return-Path: <stable+bounces-221539-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKGMETaYo2lIHwUAu9opvQ
	(envelope-from <stable+bounces-221539-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:36:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8D81CB24C
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BBC32304A12C
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A034296BC1;
	Sun,  1 Mar 2026 01:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0W3wU6W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6622727EB;
	Sun,  1 Mar 2026 01:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328521; cv=none; b=rM+F+63QfIWRwLa1jC7jgJ31fr0Y3D6ihrpWEP8S640SybmRnjpOWBDqf2ac8NuB4mul4NVJRw3bqSMuqV+YlpIt6766mrWLdpcwocYp32Rd2NtZR2mBsVv0RQtSV0oryW4ZtNxPWkrxNGdHrIIkaOSH+dIspgVAPoRVHxJa5sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328521; c=relaxed/simple;
	bh=4+tFazkyzB7/bfSJ8R3j05kUOAlEtsZWkVl3o/0XcSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QPoGKeG6BmN1ueHd5CNxc6dq7fSySC1Ni8hmzww1ZfZtK4MsOYMnoB96ceRmjAoKSNfMC3ammDsoHRDv1IdboHSSYg2mx5108VuivvMJKDG4hcD8WCuYEKR2dW0XasG2i0rDUDYT5Pbfv0xorbtpsTFahvin7yZt6hp0J/RTPL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0W3wU6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE81C19421;
	Sun,  1 Mar 2026 01:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328521;
	bh=4+tFazkyzB7/bfSJ8R3j05kUOAlEtsZWkVl3o/0XcSU=;
	h=From:To:Cc:Subject:Date:From;
	b=O0W3wU6WAGyMpyoOBp/44E43vC32+qd3s1FDC/tZyLtJunmfKxdcBrC5RtRkICv0D
	 etS+jpWqo/dTyzGSGX6tplAIdWK9oeUraOIo5snPSneBVdCF0130Cpe7dpCKQM9Lnb
	 +g9fWd8rNfjdNB20PtWa2W+Rk54/dCAOxh0aDHbfyLgxa3NoPnb7yvEvItbg/UmsDp
	 /8wqaOM9VXEV1crDH8+WkYvs2jbk4kR7UTUYFj6nYvS0Xs0VJxWllJjMa9j6Fn+JWC
	 2lu31oOIHRuXfDeK1FgmP+Z/EYjvgAQZRVx/IVNpcwJLQcfhHkgbLFc/a77c6U9cIr
	 Zej3662sKdtdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	duoming@zju.edu.cn
Cc: stable@kernel.org,
	Jijie Shao <shaojijie@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org
Subject: FAILED: Patch "atm: fore200e: fix use-after-free in tasklets during device removal" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:28:36 -0500
Message-ID: <20260301012839.1686396-1-sashal@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221539-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2D8D81CB24C
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
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





