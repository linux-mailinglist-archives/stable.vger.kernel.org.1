Return-Path: <stable+bounces-220893-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2F6JKx1Go2li+wQAu9opvQ
	(envelope-from <stable+bounces-220893-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:46:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 122FD1C75A2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9D1133BBDBA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F99C352FA1;
	Sat, 28 Feb 2026 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RT2O0sxh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C75424E78;
	Sat, 28 Feb 2026 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300783; cv=none; b=d00Pvj+wrui8E0ioLwFYCm86qvLcA7CK510gBs257xVSMwwm7lCNJKX0lnwllPKIJgpUywbEORnMHRi7wH1FVcTr2DQ8T72mHtvX6GopDUX7zdTX2UCq0Wg55kRBH+bdxKVqWYrg8HDNCYPVlcJu3dhxDMcQ0d/xbAaBKJRt5pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300783; c=relaxed/simple;
	bh=uHYavhVPPsvJNwy5w2zPvNAhQLb38Qw9M/j+w5Q7EOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbqruoOSDoPf1RfAUHH0/I5co/Mnzwpa2LlYCWmQEQwSeqGRJVJ5xN/JcdhZkrTUmVqXthiirMyKo4wolyBhTMgnSQV8cbyucZLDdf/vI97/P7ktpbqmtbORbdGx1ICj54NtVjGf+wTqEKSoYbwg7C3oXzOlJDG2AHidpX5vFj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RT2O0sxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C21C19423;
	Sat, 28 Feb 2026 17:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300782;
	bh=uHYavhVPPsvJNwy5w2zPvNAhQLb38Qw9M/j+w5Q7EOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RT2O0sxhVND+7T/SXLXsJUlZgTrLd83BfDeX1tu/lPLKU0xRxCv3Lh6a1yXd5IBWe
	 dYoU5S5HbXw+c15FQOxMoiwLAFP5XYktR6gpU0T/M+zAlqzDOKnsSe8F+b+KR88DMH
	 rZtp4OrcVco0Co7IEuJ5TVGqX1Bj0Tk8eB6Zpd6Viobbt/2Anahv5p3Nj4ng9AGMlF
	 /zQZsqjz3IF7rBZrzgQ0DgTn+s4P0hrTn6e6ZWxlP+o7ssy6SHbdmzOyp2VG6oUjMN
	 6J2BPoILvl0o74H0Han0s4lIdFL1xBcVV7ns7hPT5lob6qnNMCmAAXpRHNi9Ru+X6I
	 PKsqeMC7LfqRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 814/844] io_uring/zcrx: fix post open error handling
Date: Sat, 28 Feb 2026 12:32:07 -0500
Message-ID: <20260228173244.1509663-815-sashal@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220893-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 122FD1C75A2
X-Rspamd-Action: no action

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit 5d540e4508950c674d6feef1d95463d039bbf4f5 ]

Closing a queue doesn't guarantee that all associated page pools are
terminated right away, let the refcounting do the work instead of
releasing the zcrx ctx directly.

Cc: stable@vger.kernel.org
Fixes: e0793de24a9f6 ("io_uring/zcrx: set pp memory provider for an rx queue")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/zcrx.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index b133c85793c9c..84e37900c0682 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -515,9 +515,6 @@ static void io_close_queue(struct io_zcrx_ifq *ifq)
 		.mp_priv = ifq,
 	};
 
-	if (ifq->if_rxq == -1)
-		return;
-
 	scoped_guard(mutex, &ifq->pp_lock) {
 		netdev = ifq->netdev;
 		netdev_tracker = ifq->netdev_tracker;
@@ -525,7 +522,8 @@ static void io_close_queue(struct io_zcrx_ifq *ifq)
 	}
 
 	if (netdev) {
-		net_mp_close_rxq(netdev, ifq->if_rxq, &p);
+		if (ifq->if_rxq != -1)
+			net_mp_close_rxq(netdev, ifq->if_rxq, &p);
 		netdev_put(netdev, &netdev_tracker);
 	}
 	ifq->if_rxq = -1;
@@ -833,13 +831,12 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 	}
 	return 0;
 netdev_put_unlock:
-	netdev_put(ifq->netdev, &ifq->netdev_tracker);
 	netdev_unlock(ifq->netdev);
 err:
 	scoped_guard(mutex, &ctx->mmap_lock)
 		xa_erase(&ctx->zcrx_ctxs, id);
 ifq_free:
-	io_zcrx_ifq_free(ifq);
+	zcrx_unregister(ifq);
 	return ret;
 }
 
-- 
2.51.0


