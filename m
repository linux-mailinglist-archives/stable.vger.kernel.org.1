Return-Path: <stable+bounces-220151-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAwzNX4so2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220151-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:57:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 509E01C5422
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 503D130F0FAE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECDF48C8DA;
	Sat, 28 Feb 2026 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ptgxzod8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53EA34D4FE;
	Sat, 28 Feb 2026 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300059; cv=none; b=XMw6lmYO/9ec8JwVD8QovmkkNNI1lmHvswoeqUNbepg+mxe1e/baTzTZ5fZNyUfYndKZBtaEcHUHNlFja2dRExCnvjTMCTEI6L0FfkYvjAX9i48N2a12pPDcxUDED+JIb8yJ9Tte4bRa87Yo6udeiSCu8pxyL9gEdbJAPI5JQbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300059; c=relaxed/simple;
	bh=ZB/QjOcRQSR7jSiCPUV7WmVsTIcYLesh42owSyloUOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/oyOOIGHSIitimybM/g1JRHAcgE9BDCeVpy2GbXNEBuqgZe4lqRxOGAbxNN767UinyRNENHQ1/lAsDfx+O9YLZO79ziAFUVnokPCGWF0T/NP7Ta6pDXSOfmY3IZAP8FtnXLTxj+vgGvSvchv5B3kUtjaEwoljSoLoOzxLFXo8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ptgxzod8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E257C116D0;
	Sat, 28 Feb 2026 17:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300059;
	bh=ZB/QjOcRQSR7jSiCPUV7WmVsTIcYLesh42owSyloUOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ptgxzod85qUvP770PYPD76M2ELk4PBAxOeyLYdppdQ7vNyCn0eFzwxWoJj8yhD8XH
	 jUAbjgZebq2sNiPp8jv08gT9KClt/nvH1OyPicc/QwxVPdWykr+AgNOyP+aEVyZ1JP
	 XWBqmA/C0kUsNEvPkgYjF51CD6bW8KkeGFs2/PuK8x3OFlv4O5DtiJIWlM6h2/3O2k
	 SGhxnt9hXPaFklTijR2fm+Cgscq10k0z2IcTRII8LWC0c4iuUxfrYTUsd/hox0Os2p
	 puVJjePoqeu4MWWfQx+V5NTtDPdP4+6nUC/f/klzgj/C8nJH8dKEEkZaToSYw9e6fu
	 HDF5ONMu2vLhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	syzbot+6c48db7d94402407301e@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 073/844] io_uring/timeout: annotate data race in io_flush_timeouts()
Date: Sat, 28 Feb 2026 12:19:46 -0500
Message-ID: <20260228173244.1509663-74-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220151-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,6c48db7d94402407301e];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 509E01C5422
X-Rspamd-Action: no action

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 42b12cb5fd4554679bac06bbdd05dc8b643bcc42 ]

syzbot correctly reports this as a KCSAN race, as ctx->cached_cq_tail
should be read under ->uring_lock. This isn't immediately feasible in
io_flush_timeouts(), but as long as we read a stable value, that should
be good enough. If two io-wq threads compete on this value, then they
will both end up calling io_flush_timeouts() and at least one of them
will see the correct value.

Reported-by: syzbot+6c48db7d94402407301e@syzkaller.appspotmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/timeout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/timeout.c b/io_uring/timeout.c
index d8fbbaf31cf35..84dda24f3eb24 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -130,7 +130,7 @@ __cold void io_flush_timeouts(struct io_ring_ctx *ctx)
 	u32 seq;
 
 	raw_spin_lock_irq(&ctx->timeout_lock);
-	seq = ctx->cached_cq_tail - atomic_read(&ctx->cq_timeouts);
+	seq = READ_ONCE(ctx->cached_cq_tail) - atomic_read(&ctx->cq_timeouts);
 
 	list_for_each_entry_safe(timeout, tmp, &ctx->timeout_list, list) {
 		struct io_kiocb *req = cmd_to_io_kiocb(timeout);
-- 
2.51.0


