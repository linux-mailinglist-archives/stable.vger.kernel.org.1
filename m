Return-Path: <stable+bounces-222000-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CADoKPqbo2k3IQUAu9opvQ
	(envelope-from <stable+bounces-222000-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:52:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2014A1CC1B4
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 522103041D51
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D99F2F3C37;
	Sun,  1 Mar 2026 01:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Im7mEb2U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44B32F39A7;
	Sun,  1 Mar 2026 01:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329661; cv=none; b=A8p94J0tvHVvFX/J0EVI3Xi6AEhd02lk3GxPcvGqx4PDl9Y+czB0e1CebJR9hkCrvvlgVjPjW/i8kaKpJ0JaEaaioR2uEUsIkbk/XifsQl9iuUyxiBsWFWsL6aKWmsVeP73GjawfAUxT4nJI4UYpHadDm97BcYyl4OUpg6nIB7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329661; c=relaxed/simple;
	bh=ARllGZ6tB1zTW9sg85pAasRHhvOtyZxhNhLSBGTqQzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z33rgu4BwrdyO+UWXTa31GFQZBwOu30I38bwCJ9zSu8oSnn5WSp0h8bL/tWew+w3llAzWrNt7myc+4+NKUcC0h97KLhOCy3usgwvfKs1nVABFeu0rMrHuSA9j3+sXNfsTInZ+eVeq3KCa2P4qqgtTLKH6xxYKOOaPWWoJnquva4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Im7mEb2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2E7C19421;
	Sun,  1 Mar 2026 01:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329661;
	bh=ARllGZ6tB1zTW9sg85pAasRHhvOtyZxhNhLSBGTqQzk=;
	h=From:To:Cc:Subject:Date:From;
	b=Im7mEb2UKE3W+lvMw7KHPNjPwptFIMTElhlyptUSFT6DXdh0qTFvE99bs47iz/bx+
	 2r8zr9QLnL+BwSNy1FmhnY3wIj4nRMNNA4rXjvs03MJ95MrN+WDFYzuxnzHayTDf8F
	 soGpjmCrc4E0w3x48GrPmvRzFNBmOVTt9tiYl+SvAGFvy1VjyUAam9jGW6CaOCmmUL
	 xQYWcitXpMfFdzFDzvV4xFBZDUF4Mufqi6jxwULMSKtcAdudOjzHcX27qFc3bMT3fH
	 ldQG+U1hwi9cBjEmPCJYeY+AyPt59RJtuNjTlHhzJcJIsE0Y/eytRI8oyAmnkz+4sG
	 6GGrGjdqXWOwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	duoming@zju.edu.cn
Cc: stable@kernel.org,
	Jijie Shao <shaojijie@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org
Subject: FAILED: Patch "atm: fore200e: fix use-after-free in tasklets during device removal" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:47:37 -0500
Message-ID: <20260301014739.1711600-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222000-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 2014A1CC1B4
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
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





