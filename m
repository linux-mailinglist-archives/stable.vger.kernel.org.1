Return-Path: <stable+bounces-249971-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGfdCqPKDWqT3QUAu9opvQ
	(envelope-from <stable+bounces-249971-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:52:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EE35902FE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E627309086D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91723EA979;
	Wed, 20 May 2026 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vpJAORba"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED3D3D8130
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288102; cv=none; b=GaL8Buc8+82UgtXE+SjepL06SFcgZTruCyCgG9MYwOtNUsSPPIPWo2j2Pifp7cigeQG+wKRSw3DfJhcljOuRuKfrdWbGVE5POxjK+2K6FqYHGVY6FBpD/r7YrQfvg1cwamgsMHDhcJwJqrEni5cRBA+NZ5g6a6Dq2jZCO51RkYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288102; c=relaxed/simple;
	bh=2VLXjvz75Ar/4Jj3DavhPQYWXQjYmeDKKj25Uv6YWAc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ctj2970guQi02kdX21AmqImICQ82Nn91S0/pbelOU6dxaOdhPKHqfFnS71FBrNmH7iz5N0xAMc5QzApBq78OqINiv+rYOt3aR4nydsCMhFE5d3V3n0hCDZXHo1WLfjWdVi+L7PxjLSUoDQ4U13asfctyjDcpjqumU82cwgQ4LKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vpJAORba; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21201F000E9;
	Wed, 20 May 2026 14:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779288101;
	bh=Koa59LwEfkGE5hkdc2aAutXWuMvfdctjyPrYzzjEdgc=;
	h=Subject:To:Cc:From:Date;
	b=vpJAORba8JTfcxDBNRjELkbTRDKAVnWB7H78xrg5qoD/4Q3aC7hXTgNUy9wIWSh1h
	 LqPfR39jEHiGpfNLwyPh6tmcYRyFAZTZsbxcuf6GdhWbM/Gl7ydKgLa3Z3JTiKfJo1
	 zS8lhd/yj8XkQJ9gcfoLrQa7rep1n1M/dNoA7b8k=
Subject: FAILED: patch "[PATCH] io-wq: check that the predecessor is hashed in" failed to apply to 5.15-stable tree
To: nicholas@carlini.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:41:36 +0200
Message-ID: <2026052036-arbitrate-wasp-6200@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249971-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,carlini.com:email,linuxfoundation.org:dkim,gregkh:email,kernel.dk:email]
X-Rspamd-Queue-Id: 58EE35902FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d6a2d7b04b5a093021a7a0e2e69e9d5237dfa8cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052036-arbitrate-wasp-6200@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d6a2d7b04b5a093021a7a0e2e69e9d5237dfa8cc Mon Sep 17 00:00:00 2001
From: Nicholas Carlini <nicholas@carlini.com>
Date: Mon, 11 May 2026 18:02:16 +0000
Subject: [PATCH] io-wq: check that the predecessor is hashed in
 io_wq_remove_pending()

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

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 7a9f94a0ce6f..8cc7b47d3089 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -1124,7 +1124,8 @@ static inline void io_wq_remove_pending(struct io_wq *wq,
 	if (io_wq_is_hashed(work) && work == wq->hash_tail[hash]) {
 		if (prev)
 			prev_work = container_of(prev, struct io_wq_work, list);
-		if (prev_work && io_get_work_hash(prev_work) == hash)
+		if (prev_work && io_wq_is_hashed(prev_work) &&
+		    io_get_work_hash(prev_work) == hash)
 			wq->hash_tail[hash] = prev_work;
 		else
 			wq->hash_tail[hash] = NULL;


