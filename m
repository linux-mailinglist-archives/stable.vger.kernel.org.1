Return-Path: <stable+bounces-220878-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMogCahao2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220878-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:14:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DB51C8DFA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A4503713F60
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23C04209A9;
	Sat, 28 Feb 2026 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgDpzg28"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F1F4209A1;
	Sat, 28 Feb 2026 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300768; cv=none; b=oXYDwsvlYYEIGvP3dxO6QHNo/JW4qBaSP6tChvSqwVTlwdp7w4ffOULIRTBCtZB2DAF8xqoQkj7sT33ftyllNdUhF0iPwp2pAKV5rtmXaHZbAIteugkn83fczzBkRlFlrO0+LVIQoqOYZlQqAWqPH9mzOEqCs3kpZoAiUQ8U/pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300768; c=relaxed/simple;
	bh=DjEEaLP6mBKwe3/JXcQr75wphCCvX2O5/yn3K2hrHDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhWjxKTVhOwdT3EbUkN3hniU/luZN0I7D/1AnAxkPZoi054oysUZLW2xX21Tull9i933perbu+ZAJnnbTT8pCVnqF039ngRKffmc1BUoCbTTlU5MJeExmV7VHLTvThHT2HPDCJzOI48rnr/QSH0E5NqQpYSSPprYwJA2I+8Fp4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgDpzg28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6194AC19423;
	Sat, 28 Feb 2026 17:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300768;
	bh=DjEEaLP6mBKwe3/JXcQr75wphCCvX2O5/yn3K2hrHDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZgDpzg28rh0sB5LbZuMII/somyvmjJcZwWvPMQv2sO0nqhrg24Mb2RNDhto0XxNVV
	 v3/8Ly3oFZodB90PovgPU/I13yd0hL4oRfHibBx/bhaQvdX8Qi9dd5R/n8rz++dRt5
	 K1T6vjStNjPDC3WBBjH4m/nCjytfEn+0ftoFgWFQkCccuoWWYVJkg6Lm2UovDZoNlF
	 oL7D7jNi31qc5t8pGhDgsY04btFk1VqHlVZZ4AHdDFYyya9WevNwwoNlzlmW+jQLkc
	 XW2+Oi63wyidyyZ2hUfFxAjbJNSSEjZ50YN8Hd9LAlDt6g4AXwPn40qwxNfhM+omor
	 MJ8PO1BaJRUOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Duoming Zhou <duoming@zju.edu.cn>,
	stable@kernel.org,
	Jijie Shao <shaojijie@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 799/844] atm: fore200e: fix use-after-free in tasklets during device removal
Date: Sat, 28 Feb 2026 12:31:52 -0500
Message-ID: <20260228173244.1509663-800-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220878-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 76DB51C8DFA
X-Rspamd-Action: no action

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit 8930878101cd40063888a68af73b1b0f8b6c79bc ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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


