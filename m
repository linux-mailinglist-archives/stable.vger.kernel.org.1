Return-Path: <stable+bounces-226866-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGPkHX6WuWmhKwIAu9opvQ
	(envelope-from <stable+bounces-226866-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:59:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4852B075C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4675030774FD
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17EC3624B3;
	Tue, 17 Mar 2026 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0O3xKZck"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BC5336EF1;
	Tue, 17 Mar 2026 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768530; cv=none; b=pJ/f13YRfjAiqUHkTgmApJxtt4UUwowq1+7DHM36lxUF+2ejwXoVZH7qqV23jmDdQkatN4TYV9/nXH6T+9JZzNTQR7s8Jx29vcbQRmTXNOxXa7YcS5SUk8o2+WH82VI7sCQtAvoOYft1/5owoxkoQfpYjhrkbgTnL8hGaSz2hmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768530; c=relaxed/simple;
	bh=sblayXlHq+jGZ49RIBGN9Q/EqCqAhMt0eKSYRNUBtss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nf8981bfJc69OAJmBNP6CDg6xRmQi440MsjbI4dZ9zsofrezOtYNwdQ9buoJWuTAB5kTeQBumc+tgHXBAwEtmkC4uweZnEk96dYFfWHAFcoB3GgXHBE/gNLzJj7+WyP/hZPG3k75jTVTBS393NtcxMBFVS+3gJ+We8SLBwQZNRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0O3xKZck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5C2C4CEF7;
	Tue, 17 Mar 2026 17:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768530;
	bh=sblayXlHq+jGZ49RIBGN9Q/EqCqAhMt0eKSYRNUBtss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0O3xKZcksfu+oaYlLpk3krwsFLey+fS0/xhS04nETprSgO8mISsZkRWx8zf1Y56zU
	 m5ZSBo8wpoKjVEadbywi3/IB/XMiuK/MM+6uJH/1Qib+5F+9oni8TLnjID17QRIPKS
	 aUCXINjrOPlH3LvE/lO66RcsJoj9iDp8t2XpCHTk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.18 332/333] io_uring/eventfd: use ctx->rings_rcu for flags checking
Date: Tue, 17 Mar 2026 17:36:01 +0100
Message-ID: <20260317163011.719719074@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226866-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,kernel.dk:email]
X-Rspamd-Queue-Id: DC4852B075C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

Commit 177c69432161f6e4bab07ccacf8a1748a6898a6b upstream.

Similarly to what commit e78f7b70e837 did for local task work additions,
use ->rings_rcu under RCU rather than dereference ->rings directly. See
that commit for more details.

Cc: stable@vger.kernel.org
Fixes: 79cfe9e59c2a ("io_uring/register: add IORING_REGISTER_RESIZE_RINGS")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/eventfd.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/io_uring/eventfd.c
+++ b/io_uring/eventfd.c
@@ -76,11 +76,15 @@ void io_eventfd_signal(struct io_ring_ct
 {
 	bool skip = false;
 	struct io_ev_fd *ev_fd;
-
-	if (READ_ONCE(ctx->rings->cq_flags) & IORING_CQ_EVENTFD_DISABLED)
-		return;
+	struct io_rings *rings;
 
 	guard(rcu)();
+
+	rings = rcu_dereference(ctx->rings_rcu);
+	if (!rings)
+		return;
+	if (READ_ONCE(rings->cq_flags) & IORING_CQ_EVENTFD_DISABLED)
+		return;
 	ev_fd = rcu_dereference(ctx->io_ev_fd);
 	/*
 	 * Check again if ev_fd exists in case an io_eventfd_unregister call



