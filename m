Return-Path: <stable+bounces-234716-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APguKaem1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234716-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:04:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B54E3C24EE
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E6CA31D366C
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F483D4134;
	Wed,  8 Apr 2026 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ePw83QT/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F903D522C;
	Wed,  8 Apr 2026 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673578; cv=none; b=pCVmxmO3ROGJWD9+w9alsioOGVo5SeZG7C03+D7VfzJ5ufZKWx12orEqKNW5Lc9o0pE0f/1Yb/CMBsIFmuVmWgJXJagBr7mXEKInaWoolIyrCYk11fGwdQWbwssA+p6LTLOfyB61f5zOh8pVnSOfwFF1yJUC2sIAxqdEQQsj5eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673578; c=relaxed/simple;
	bh=z/eqAiawmOC75XXU7FjVm1qZIfPsByOsMf0w6vRqoc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/nwH4iCXWlpEuOJ1tznx0khp4iTMoB2NEcUoEOcynD76zf7FkNNsPUy9CisjynjUoGJd2PEKopISZUus6/Mv4U9tdJKnisOFWMrxHnyfZqsRSC4H8tlvk4FahC5NgsHYdh015JNJhcDZfkzEMfaUMRzTxED5nqGGxUTPz5GgSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ePw83QT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96293C19421;
	Wed,  8 Apr 2026 18:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673577;
	bh=z/eqAiawmOC75XXU7FjVm1qZIfPsByOsMf0w6vRqoc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ePw83QT/UH6F1WBempU6HPiOOaBAG23d0DXQ0rJJlc8jiaRFJpaiTmuUwU/I6kfbW
	 ci3qQh/gxhV10OO+Mx64RJbItMhO9oyurI8ixIhYUIqL0VRtqW4+b3wfXBkXOhfxxz
	 Q73v08u6WYOKWFZRF+hh9S7PoalWXExLUq/q8YcE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.12 001/242] io_uring/kbuf: remove legacy kbuf bulk allocation
Date: Wed,  8 Apr 2026 20:00:41 +0200
Message-ID: <20260408175927.125557169@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-234716-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B54E3C24EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Begunkov <asml.silence@gmail.com>

Commit 7919292a961421bfdb22f83c16657684c96076b3 upstream.

Legacy provided buffers are slow and discouraged in favour of the ring
variant. Remove the bulk allocation to keep it simpler as we don't care
about performance.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/a064d70370e590efed8076e9501ae4cfc20fe0ca.1738724373.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/kbuf.c |   30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -521,12 +521,9 @@ int io_provide_buffers_prep(struct io_ki
 	return 0;
 }
 
-#define IO_BUFFER_ALLOC_BATCH 64
-
 static int io_refill_buffer_cache(struct io_ring_ctx *ctx)
 {
-	struct io_buffer *bufs[IO_BUFFER_ALLOC_BATCH];
-	int allocated;
+	struct io_buffer *buf;
 
 	/*
 	 * Completions that don't happen inline (eg not under uring_lock) will
@@ -544,27 +541,10 @@ static int io_refill_buffer_cache(struct
 		spin_unlock(&ctx->completion_lock);
 	}
 
-	/*
-	 * No free buffers and no completion entries either. Allocate a new
-	 * batch of buffer entries and add those to our freelist.
-	 */
-
-	allocated = kmem_cache_alloc_bulk(io_buf_cachep, GFP_KERNEL_ACCOUNT,
-					  ARRAY_SIZE(bufs), (void **) bufs);
-	if (unlikely(!allocated)) {
-		/*
-		 * Bulk alloc is all-or-nothing. If we fail to get a batch,
-		 * retry single alloc to be on the safe side.
-		 */
-		bufs[0] = kmem_cache_alloc(io_buf_cachep, GFP_KERNEL);
-		if (!bufs[0])
-			return -ENOMEM;
-		allocated = 1;
-	}
-
-	while (allocated)
-		list_add_tail(&bufs[--allocated]->list, &ctx->io_buffers_cache);
-
+	buf = kmem_cache_alloc(io_buf_cachep, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	list_add_tail(&buf->list, &ctx->io_buffers_cache);
 	return 0;
 }
 



