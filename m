Return-Path: <stable+bounces-234727-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFWsDsam1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234727-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:04:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2AA3C255B
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF65531DA337
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6713B0AFC;
	Wed,  8 Apr 2026 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="juq8Ao0+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5081DB67E;
	Wed,  8 Apr 2026 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673606; cv=none; b=e7pAxpN54bPFdUoXV+7VoTtUVBYqOFjBvnLiVC5dojox/I8BhiCR4vR++v0IfNJKF6rwzB5YR84JMXzyxIu12n7cBYm+YfFaXu7ZI4P/hW3BdE+ClYANwUEKhM9o4CkCg5RlmgHc6dS++4A0cDwcsVapLtlATdQxCObBJTJjrbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673606; c=relaxed/simple;
	bh=IpwYeWk1eJSiiEZNCkTs7LcPjeuk5jcQFy6W60ytTvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMhlw6mw3ghtEyQ1TA2NieXSAq88C2w6O+ou/SH43LE5JblllAkMMzth2fRNtdBHXlYZ3d3p0eI8NQ2dzgHDOkAM/oj6EcOIzDpeaLA5l8QFystN6dKPhs9XTO7ghnqZ+r7xm7NMnZ/eOHMh/Z/9dnmRyJ2X+AlsjWligqklTEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=juq8Ao0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC127C19421;
	Wed,  8 Apr 2026 18:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673606;
	bh=IpwYeWk1eJSiiEZNCkTs7LcPjeuk5jcQFy6W60ytTvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=juq8Ao0+IWpeI/AkM9eD4eeVPor8aDfS41n+JLMlT2I3LnqABXF/j0bDzPgoAVEou
	 p2hJPHcv1tmu1smi9M6SXOpyzJrgCSxhepL/FpdZD/5pw2jM9kezA98FuXYcEjKXkr
	 yQOfdsMMVVqL14saXOz7GgjSdIi3aBOPXEP5oDv4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.12 002/242] io_uring/kbuf: remove legacy kbuf kmem cache
Date: Wed,  8 Apr 2026 20:00:42 +0200
Message-ID: <20260408175927.162009444@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-234727-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,kernel.dk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA2AA3C255B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Begunkov <asml.silence@gmail.com>

Commit 9afe6847cff78e7f3aa8f4c920265cf298033251 upstream.

Remove the kmem cache used by legacy provided buffers.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/8195c207d8524d94e972c0c82de99282289f7f5c.1738724373.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |    2 --
 io_uring/io_uring.h |    1 -
 io_uring/kbuf.c     |    8 +++-----
 3 files changed, 3 insertions(+), 8 deletions(-)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3867,8 +3867,6 @@ static int __init io_uring_init(void)
 	req_cachep = kmem_cache_create("io_kiocb", sizeof(struct io_kiocb), &kmem_args,
 				SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT |
 				SLAB_TYPESAFE_BY_RCU);
-	io_buf_cachep = KMEM_CACHE(io_buffer,
-					  SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
 
 	iou_wq = alloc_workqueue("iou_exit", WQ_UNBOUND, 64);
 
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -389,7 +389,6 @@ static inline bool io_req_cache_empty(st
 }
 
 extern struct kmem_cache *req_cachep;
-extern struct kmem_cache *io_buf_cachep;
 
 static inline struct io_kiocb *io_extract_req(struct io_ring_ctx *ctx)
 {
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -20,8 +20,6 @@
 /* BIDs are addressed by a 16-bit field in a CQE */
 #define MAX_BIDS_PER_BGID (1 << 16)
 
-struct kmem_cache *io_buf_cachep;
-
 struct io_provide_buf {
 	struct file			*file;
 	__u64				addr;
@@ -70,7 +68,7 @@ bool io_kbuf_recycle_legacy(struct io_ki
 	if (bl && !(bl->flags & IOBL_BUF_RING))
 		list_add(&buf->list, &bl->buf_list);
 	else
-		kmem_cache_free(io_buf_cachep, buf);
+		kfree(buf);
 	req->flags &= ~REQ_F_BUFFER_SELECTED;
 	req->kbuf = NULL;
 
@@ -430,7 +428,7 @@ void io_destroy_buffers(struct io_ring_c
 
 	list_for_each_safe(item, tmp, &ctx->io_buffers_cache) {
 		buf = list_entry(item, struct io_buffer, list);
-		kmem_cache_free(io_buf_cachep, buf);
+		kfree(buf);
 	}
 }
 
@@ -541,7 +539,7 @@ static int io_refill_buffer_cache(struct
 		spin_unlock(&ctx->completion_lock);
 	}
 
-	buf = kmem_cache_alloc(io_buf_cachep, GFP_KERNEL);
+	buf = kmalloc(sizeof(*buf), GFP_KERNEL_ACCOUNT);
 	if (!buf)
 		return -ENOMEM;
 	list_add_tail(&buf->list, &ctx->io_buffers_cache);



