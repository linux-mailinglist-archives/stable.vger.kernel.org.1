Return-Path: <stable+bounces-234728-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OQtK82m1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234728-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:04:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B8D3C2578
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 244DC30B5B80
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2409F3D4134;
	Wed,  8 Apr 2026 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uw5rLy/S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF00B67E;
	Wed,  8 Apr 2026 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673608; cv=none; b=ZjkQQf+Z8EsaTLXnWiA65AvjqAs6ByfTubSdpThMqMkyRIzmQt5HOmi22zNk13P1fYwizU7ggjiWydV8YIGqEetfXQH+84ofNBJXjw4YERwrSM1uH5eH/6Y+m+vH1k+NYIZvft3kl0L+hjcR/ffO927c0DKp3WZHkRL+akKbYwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673608; c=relaxed/simple;
	bh=MPmmUIa7jEsuM5nhZkT3EwNl2W3So9QvZ3d1QQ4Bur8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqgJOwesyXlgLA52Zb34Xh23h32MpgAXPxbMDzFRay58kWOi3FqqzWBzchWpvjq99YZytab/MrWjhR318y+5aFB06prGJBPTPFhHYv0CVuOdtH96CybbTJ4BqDJ7CqUYl4gE5FHRJo6P/OSijAkmrZmK1RLvrNnOMR1WNigkFg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uw5rLy/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717D6C19421;
	Wed,  8 Apr 2026 18:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673608;
	bh=MPmmUIa7jEsuM5nhZkT3EwNl2W3So9QvZ3d1QQ4Bur8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uw5rLy/SG7jRILXCHZuh+GILCwzfyleqp/lcwR8OzFmc+Q41+sdvU4PTFHGCrYyFJ
	 FfIKSb6doxzzC1VxpVJTZ1uNn07XwiPt49CUqxv4qjEUy6rKU5deG2G4+p9MGa3WXm
	 cFT7esSUN7dfkrzhoaH7BiuLwerzlpW5LBKal6gw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Norman Maurer <norman_maurer@apple.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.12 020/242] io_uring/kbuf: enable bundles for incrementally consumed buffers
Date: Wed,  8 Apr 2026 20:01:00 +0200
Message-ID: <20260408175927.828917879@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234728-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 26B8D3C2578
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

Commit cf9536e550dd243a1681fdbf804221527da20a80 upstream.

The original support for incrementally consumed buffers didn't allow it
to be used with bundles, with the assumption being that incremental
buffers are generally larger, and hence there's less of a nedd to
support it.

But that assumption may not be correct - it's perfectly viable to use
smaller buffers with incremental consumption, and there may be valid
reasons for an application or framework to do so.

As there's really no need to explicitly disable bundles with
incrementally consumed buffers, allow it. This actually makes the peek
side cheaper and simpler, with the completion side basically the same,
just needing to iterate for the consumed length.

Reported-by: Norman Maurer <norman_maurer@apple.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/kbuf.c |   56 ++++++++++++++++++++++++++------------------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -32,6 +32,25 @@ struct io_provide_buf {
 	__u16				bid;
 };
 
+static bool io_kbuf_inc_commit(struct io_buffer_list *bl, int len)
+{
+	while (len) {
+		struct io_uring_buf *buf;
+		u32 this_len;
+
+		buf = io_ring_head_to_buf(bl->buf_ring, bl->head, bl->mask);
+		this_len = min_t(u32, len, buf->len);
+		buf->len -= this_len;
+		if (buf->len) {
+			buf->addr += this_len;
+			return false;
+		}
+		bl->head++;
+		len -= this_len;
+	}
+	return true;
+}
+
 bool io_kbuf_commit(struct io_kiocb *req,
 		    struct io_buffer_list *bl, int len, int nr)
 {
@@ -42,20 +61,8 @@ bool io_kbuf_commit(struct io_kiocb *req
 
 	if (unlikely(len < 0))
 		return true;
-
-	if (bl->flags & IOBL_INC) {
-		struct io_uring_buf *buf;
-
-		buf = io_ring_head_to_buf(bl->buf_ring, bl->head, bl->mask);
-		if (WARN_ON_ONCE(len > buf->len))
-			len = buf->len;
-		buf->len -= len;
-		if (buf->len) {
-			buf->addr += len;
-			return false;
-		}
-	}
-
+	if (bl->flags & IOBL_INC)
+		return io_kbuf_inc_commit(bl, len);
 	bl->head += nr;
 	return true;
 }
@@ -235,25 +242,14 @@ static int io_ring_buffers_peek(struct i
 	buf = io_ring_head_to_buf(br, head, bl->mask);
 	if (arg->max_len) {
 		u32 len = READ_ONCE(buf->len);
+		size_t needed;
 
 		if (unlikely(!len))
 			return -ENOBUFS;
-		/*
-		 * Limit incremental buffers to 1 segment. No point trying
-		 * to peek ahead and map more than we need, when the buffers
-		 * themselves should be large when setup with
-		 * IOU_PBUF_RING_INC.
-		 */
-		if (bl->flags & IOBL_INC) {
-			nr_avail = 1;
-		} else {
-			size_t needed;
-
-			needed = (arg->max_len + len - 1) / len;
-			needed = min_not_zero(needed, (size_t) PEEK_MAX_IMPORT);
-			if (nr_avail > needed)
-				nr_avail = needed;
-		}
+		needed = (arg->max_len + len - 1) / len;
+		needed = min_not_zero(needed, (size_t) PEEK_MAX_IMPORT);
+		if (nr_avail > needed)
+			nr_avail = needed;
 	}
 
 	/*



