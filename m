Return-Path: <stable+bounces-219556-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCBnEJegnmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219556-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:11:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA78193111
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA315316AA0B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875C331354C;
	Wed, 25 Feb 2026 06:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G/hfhui8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB5130E85C;
	Wed, 25 Feb 2026 06:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002794; cv=none; b=bLspGAoHJg+GMUd45IW7O8jBmO6iGVBRwjhy3CNZuAOgppg7EJK9fNjVbrGKhuS3zy4H77K8toiB2CEJdcsJfDszkoFJsWn8Re9xpvHkQCiV59kKZdPjqbgRHZE9PXe+qzqHif0Q7waExepXDFD0PYk0xf8mk+pQkEI/jh9p8h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002794; c=relaxed/simple;
	bh=W2tlkqe4+5jnUkh2e8mBJyg5HAcQ2wuTlvLoSJjpSkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBhgmNvgVWGe9B+CFhzIieQtAaFu8TkRQz4DSSpPF9K10K1X4zkLoSK28QU0aoSAfXA2mAESTulI/hZxTsVyWdpbeduex62YfMVk1BM6ZwGoVG5BsXsfy9eghEoecXQHQnvhFrRtKRC2Y5+JKC+IuwWS+FrDAULj0vIJkeh/7vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G/hfhui8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6BBC19425;
	Wed, 25 Feb 2026 06:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002794;
	bh=W2tlkqe4+5jnUkh2e8mBJyg5HAcQ2wuTlvLoSJjpSkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G/hfhui894oFUa9c+pGedPdh5RlxN2EaWGuol79XoqZB+LOX2jzZCfL5EMXnBrqlL
	 9jP9AZi2d9QRfev5NjFFf4T2qD23jmPw1dUCx5mpTf17cb7IsegsE3V2XUe19ma7eP
	 WBkj388OMLf86A5fgoJR+qnJx8zAbHs2nkwe3t+s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joanne Koong <joannelkoong@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.18 638/641] io_uring/rsrc: clean up buffer cloning arg validation
Date: Tue, 24 Feb 2026 17:26:04 -0800
Message-ID: <20260225012403.964095983@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219556-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.dk];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AAA78193111
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joanne Koong <joannelkoong@gmail.com>

commit b8201b50e403815f941d1c6581a27fdbfe7d0fd4 upstream.

Get rid of some redundant checks and move the src arg validation to
before the buffer table allocation, which simplifies error handling.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/rsrc.c |   27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1185,12 +1185,16 @@ static int io_clone_buffers(struct io_ri
 		return -EBUSY;
 
 	nbufs = src_ctx->buf_table.nr;
+	if (!nbufs)
+		return -ENXIO;
 	if (!arg->nr)
 		arg->nr = nbufs;
 	else if (arg->nr > nbufs)
 		return -EINVAL;
 	else if (arg->nr > IORING_MAX_REG_BUFFERS)
 		return -EINVAL;
+	if (check_add_overflow(arg->nr, arg->src_off, &off) || off > nbufs)
+		return -EOVERFLOW;
 	if (check_add_overflow(arg->nr, arg->dst_off, &nbufs))
 		return -EOVERFLOW;
 	if (nbufs > IORING_MAX_REG_BUFFERS)
@@ -1210,21 +1214,6 @@ static int io_clone_buffers(struct io_ri
 		}
 	}
 
-	ret = -ENXIO;
-	nbufs = src_ctx->buf_table.nr;
-	if (!nbufs)
-		goto out_free;
-	ret = -EINVAL;
-	if (!arg->nr)
-		arg->nr = nbufs;
-	else if (arg->nr > nbufs)
-		goto out_free;
-	ret = -EOVERFLOW;
-	if (check_add_overflow(arg->nr, arg->src_off, &off))
-		goto out_free;
-	if (off > nbufs)
-		goto out_free;
-
 	off = arg->dst_off;
 	i = arg->src_off;
 	nr = arg->nr;
@@ -1237,8 +1226,8 @@ static int io_clone_buffers(struct io_ri
 		} else {
 			dst_node = io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
 			if (!dst_node) {
-				ret = -ENOMEM;
-				goto out_free;
+				io_rsrc_data_free(ctx, &data);
+				return -ENOMEM;
 			}
 
 			refcount_inc(&src_node->buf->refs);
@@ -1274,10 +1263,6 @@ static int io_clone_buffers(struct io_ri
 	WARN_ON_ONCE(ctx->buf_table.nr);
 	ctx->buf_table = data;
 	return 0;
-
-out_free:
-	io_rsrc_data_free(ctx, &data);
-	return ret;
 }
 
 /*



