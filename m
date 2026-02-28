Return-Path: <stable+bounces-220907-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNe2OZRGo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220907-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:48:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0B51C760D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06F1C305541B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AD342A78E;
	Sat, 28 Feb 2026 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIamdP1Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01D942A781;
	Sat, 28 Feb 2026 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300795; cv=none; b=sCd6z7/FQ3UaYuM+jN3tt+qjTyQ0dBdewqNjQ9eDL2+VXLQYFfI8F4k7VI8VAYVptu5ktD66alaa6OSibfSrZ2vd+2X0D3Nrfb3jGSUolg3avMrPtzVdF5hlWIAfRaxGooQwzTUOSq4zxRddQLmZS1Lk3N3NQwzidG1KipkFS8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300795; c=relaxed/simple;
	bh=gbqZ++Duhupp4YG/TedHWSOdtQHqxkp2I7pBN0yhjOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYyQUilkHgWYxa3pJBeXAjvVLlQUX1WeelLh8C7ZBPyPuV9FE7EHQe03AnbPGIMG4QP2yyQfp4euZN+s76CNv/QI9Wulfsj71BMBmf0byFvBbKaywRjThD/t4H1ovFCFscmSv92xxrvRDSaP0yqIguqH+vkcUw0fTRy/CUgjyf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIamdP1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF189C19423;
	Sat, 28 Feb 2026 17:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300795;
	bh=gbqZ++Duhupp4YG/TedHWSOdtQHqxkp2I7pBN0yhjOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UIamdP1Z1u9nMN3+muvIkyRwMRE/6Qvyi9V4hL6XRU4HOZ2EUrjgKwtsJkW0keNOG
	 Ml1SHXWCOQpLvPlNHdZkZscKatq9kAcd1gvx4fyXvxubCrgE4dSXwYfQ0bijmw97Co
	 LC6/b8SNeZv6zZyy8IWtER2ciZrpkU6e+iOUz1W+qEC/tArQ/RZdrwpUEHr2mXvYx1
	 I8SP8Vb+fg97oMaKc4phS6IZv8fQ3oPlAPCuSGNKzMyyg6vo/WhyoYi39NXMIInMgY
	 CEgCGXFs5O5bm6MyUobck0euxxogsJNZLBwbolfSy7y7m8/4+EeOhOPQ+bRDIiDXyB
	 uaf8+jxr/aT2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kai Aizen <kai@snailsploit.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 828/844] io_uring/zcrx: fix user_ref race between scrub and refill paths
Date: Sat, 28 Feb 2026 12:32:21 -0500
Message-ID: <20260228173244.1509663-829-sashal@kernel.org>
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
	FREEMAIL_CC(0.00)[snailsploit.com,gmail.com,kernel.dk,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220907-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:email]
X-Rspamd-Queue-Id: 3C0B51C760D
X-Rspamd-Action: no action

From: Kai Aizen <kai@snailsploit.com>

[ Upstream commit 003049b1c4fb8aabb93febb7d1e49004f6ad653b ]

The io_zcrx_put_niov_uref() function uses a non-atomic
check-then-decrement pattern (atomic_read followed by separate
atomic_dec) to manipulate user_refs. This is serialized against other
callers by rq_lock, but io_zcrx_scrub() modifies the same counter with
atomic_xchg() WITHOUT holding rq_lock.

On SMP systems, the following race exists:

  CPU0 (refill, holds rq_lock)          CPU1 (scrub, no rq_lock)
  put_niov_uref:
    atomic_read(uref) - 1
    // window opens
                                        atomic_xchg(uref, 0) - 1
                                        return_niov_freelist(niov) [PUSH #1]
    // window closes
    atomic_dec(uref) - wraps to -1
    returns true
    return_niov(niov)
    return_niov_freelist(niov)           [PUSH #2: DOUBLE-FREE]

The same niov is pushed to the freelist twice, causing free_count to
exceed nr_iovs. Subsequent freelist pushes then perform an out-of-bounds
write (a u32 value) past the kvmalloc'd freelist array into the adjacent
slab object.

Fix this by replacing the non-atomic read-then-dec in
io_zcrx_put_niov_uref() with an atomic_try_cmpxchg loop that atomically
tests and decrements user_refs. This makes the operation safe against
concurrent atomic_xchg from scrub without requiring scrub to acquire
rq_lock.

Fixes: 34a3e60821ab ("io_uring/zcrx: implement zerocopy receive pp memory provider")
Cc: stable@vger.kernel.org
Signed-off-by: Kai Aizen <kai@snailsploit.com>
[pavel: removed a warning and a comment]
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/zcrx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index d41aa01a26d31..93da8933a91fa 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -337,10 +337,14 @@ static inline atomic_t *io_get_user_counter(struct net_iov *niov)
 static bool io_zcrx_put_niov_uref(struct net_iov *niov)
 {
 	atomic_t *uref = io_get_user_counter(niov);
+	int old;
+
+	old = atomic_read(uref);
+	do {
+		if (unlikely(old == 0))
+			return false;
+	} while (!atomic_try_cmpxchg(uref, &old, old - 1));
 
-	if (unlikely(!atomic_read(uref)))
-		return false;
-	atomic_dec(uref);
 	return true;
 }
 
-- 
2.51.0


