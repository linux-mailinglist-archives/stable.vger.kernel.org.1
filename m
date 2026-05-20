Return-Path: <stable+bounces-252808-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLDRMn0pDmrI7gUAu9opvQ
	(envelope-from <stable+bounces-252808-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:37:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CB159B1D9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C619732E7FA6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514FC3F9F25;
	Wed, 20 May 2026 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nY9j42kQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ECC3F9F2D;
	Wed, 20 May 2026 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301643; cv=none; b=qNwneVI9MXDpUBEotO4CRQ8U5EJB7fdxRBg3bqj2PKj7IhZuka5ZRwLfYbitHRlLU47gRLZaENIgn0ds8Gq6mvR9gBAfOFWS9zlU4Zi2VZsGzQhTtMHARXN/Dgiy9ke7WWwsBvSkKQhlEHgnyXJb0pK9Ox400EdOTGON3QXvrkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301643; c=relaxed/simple;
	bh=nJgbPTjXYaMbRuVsr4s57DEh9FAZLoEzaT+q73AQeoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sws5RLmE1s8c6SCKKdMgLjfVO6il0Ln36kM7lGOmHPdnkMi7ljjbYCanRB6dZLqmxXkJqOlPVjDtS9tb2u11kY0OlwUO+L1Zve773YvzowZlQgfXFrn8QlBXdyeYB5/f4GEhY4t4UxNjwV1drJ5ew7dLTPCB2Xhjnimv5EbuKfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nY9j42kQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA481F000E9;
	Wed, 20 May 2026 18:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301641;
	bh=p/bxONIKdS1kTtIywLgE8cpboIDxRiWnmUZHvZVxcHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nY9j42kQe3zv9cKbQtR36eJp7gqRdYAsJfLgl4xxrRGUHNKcGfQqE0K/ZuJBlzt70
	 FU7F4RFo/vg5olIihHGTSfrTnddWGUHufVfb2dWZnQvzFO+wSm93U5wJUvCKCIex6t
	 j1lpdZwLxngWPS4yanvPBIgp/W71ayuEbvjQ1kkc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicholas Carlini <nicholas@carlini.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.12 632/666] io-wq: check that the predecessor is hashed in io_wq_remove_pending()
Date: Wed, 20 May 2026 18:24:03 +0200
Message-ID: <20260520162124.975151174@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252808-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kernel.dk:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,carlini.com:email]
X-Rspamd-Queue-Id: 28CB159B1D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Carlini <nicholas@carlini.com>

commit d6a2d7b04b5a093021a7a0e2e69e9d5237dfa8cc upstream.

io_wq_remove_pending() needs to fix up wq->hash_tail[] if the cancelled
work was the tail of its hash bucket. When doing this, it checks whether
the preceding entry in acct->work_list has the same hash value, but
never checks that the predecessor is hashed at all. io_get_work_hash()
is simply atomic_read(&work->flags) >> IO_WQ_HASH_SHIFT, and the hash
bits are never set for non-hashed work, so it returns 0. Thus, when a
hashed bucket-0 work is cancelled while a non-hashed work is its list
predecessor, the check spuriously passes and a pointer to the non-hashed
io_kiocb is stored in wq->hash_tail[0].

Because non-hashed work is dequeued via the fast path in
io_get_next_work(), which never touches hash_tail[], the stale pointer
is never cleared. Therefore, after the non-hashed io_kiocb completes and
is freed back to req_cachep, wq->hash_tail[0] is a dangling pointer. The
io_wq is per-task (tctx->io_wq) and survives ring open/close, so the
dangling pointer persists for the lifetime of the task; the next hashed
bucket-0 enqueue dereferences it in io_wq_insert_work() and
wq_list_add_after() writes through freed memory.

Add the missing io_wq_is_hashed() check so a non-hashed predecessor
never inherits a hash_tail[] slot.

Cc: stable@vger.kernel.org
Fixes: 204361a77f40 ("io-wq: fix hang after cancelling pending hashed work")
Signed-off-by: Nicholas Carlini <nicholas@carlini.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io-wq.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -1044,7 +1044,8 @@ static inline void io_wq_remove_pending(
 	if (io_wq_is_hashed(work) && work == wq->hash_tail[hash]) {
 		if (prev)
 			prev_work = container_of(prev, struct io_wq_work, list);
-		if (prev_work && io_get_work_hash(prev_work) == hash)
+		if (prev_work && io_wq_is_hashed(prev_work) &&
+		    io_get_work_hash(prev_work) == hash)
 			wq->hash_tail[hash] = prev_work;
 		else
 			wq->hash_tail[hash] = NULL;



