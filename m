Return-Path: <stable+bounces-15932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C1183E4C7
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F2F7B21D23
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 22:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6BE24B33;
	Fri, 26 Jan 2024 22:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="de0Y0ogS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D13541C99
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 22:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306868; cv=none; b=PqZG49b8QjvXl3BR80SEeX2ONphyctfSVw7Hfx7kU9DMp8lE4WeOij0K0TCK3hyYxRhdFyZs4jnbyT6QcKLU29kBRvg3e8HUUrEbNrOkxuaOvo0AwBWOZwWPjKaegob9kLRu3DvEKgbUkMcK0xLrJzg+kDlPbNdUlprpZxFk5ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306868; c=relaxed/simple;
	bh=WJGMm0dPsSfLmpVkBoAter58EOPU7lA4AXIkXTgrz7o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pnbZE5mc9xdT5k9XTRbAJsw3TV8JnqthhYXwjwodY5WC/idzNLmr21fHIFlc6N13YPnmHh/dgrjzQvG+RCPjpDiDE1iZbe0kpwG3Fz+pBpbYwW/GbfrpsL++DnHNgzE2B16efKE5FS5FlvYaBlYzqcH+LJQ13RW+dBKqrzgJf/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=de0Y0ogS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B7EC433C7;
	Fri, 26 Jan 2024 22:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706306868;
	bh=WJGMm0dPsSfLmpVkBoAter58EOPU7lA4AXIkXTgrz7o=;
	h=Subject:To:Cc:From:Date:From;
	b=de0Y0ogSKBEZJkbTxn+vQURfddeDilcVfvHJro0gpotGlz17zkIS3G87Oq224eVt+
	 m87LO18x71AF1fW4cNx1vfzYjYmo7AtK6CscMiMUkWQzlZjim9UKgN3saC6n7AvPr0
	 Pxv05A/xwPuvEz2UA1sEeYcHrTFAwB+BICQvCGPw=
Subject: FAILED: patch "[PATCH] erofs: fix lz4 inplace decompression" failed to apply to 6.1-stable tree
To: xiang@kernel.org,hsiangkao@linux.alibaba.com,qkrwngud825@gmail.com,stable@vger.kernel.org,zhaoyifan@sjtu.edu.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 14:07:47 -0800
Message-ID: <2024012647-disband-negotiate-1447@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3c12466b6b7bf1e56f9b32c366a3d83d87afb4de
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012647-disband-negotiate-1447@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

3c12466b6b7b ("erofs: fix lz4 inplace decompression")
123ec246ebe3 ("erofs: get rid of the remaining kmap_atomic()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3c12466b6b7bf1e56f9b32c366a3d83d87afb4de Mon Sep 17 00:00:00 2001
From: Gao Xiang <xiang@kernel.org>
Date: Wed, 6 Dec 2023 12:55:34 +0800
Subject: [PATCH] erofs: fix lz4 inplace decompression

Currently EROFS can map another compressed buffer for inplace
decompression, that was used to handle the cases that some pages of
compressed data are actually not in-place I/O.

However, like most simple LZ77 algorithms, LZ4 expects the compressed
data is arranged at the end of the decompressed buffer and it
explicitly uses memmove() to handle overlapping:
  __________________________________________________________
 |_ direction of decompression --> ____ |_ compressed data _|

Although EROFS arranges compressed data like this, it typically maps two
individual virtual buffers so the relative order is uncertain.
Previously, it was hardly observed since LZ4 only uses memmove() for
short overlapped literals and x86/arm64 memmove implementations seem to
completely cover it up and they don't have this issue.  Juhyung reported
that EROFS data corruption can be found on a new Intel x86 processor.
After some analysis, it seems that recent x86 processors with the new
FSRM feature expose this issue with "rep movsb".

Let's strictly use the decompressed buffer for lz4 inplace
decompression for now.  Later, as an useful improvement, we could try
to tie up these two buffers together in the correct order.

Reported-and-tested-by: Juhyung Park <qkrwngud825@gmail.com>
Closes: https://lore.kernel.org/r/CAD14+f2AVKf8Fa2OO1aAUdDNTDsVzzR6ctU_oJSmTyd6zSYR2Q@mail.gmail.com
Fixes: 0ffd71bcc3a0 ("staging: erofs: introduce LZ4 decompression inplace")
Fixes: 598162d05080 ("erofs: support decompress big pcluster for lz4 backend")
Cc: stable <stable@vger.kernel.org> # 5.4+
Tested-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20231206045534.3920847-1-hsiangkao@linux.alibaba.com

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 021be5feb1bc..e0d609c3958f 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -121,11 +121,11 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_lz4_decompress_ctx *ctx,
 }
 
 static void *z_erofs_lz4_handle_overlap(struct z_erofs_lz4_decompress_ctx *ctx,
-			void *inpage, unsigned int *inputmargin, int *maptype,
-			bool may_inplace)
+			void *inpage, void *out, unsigned int *inputmargin,
+			int *maptype, bool may_inplace)
 {
 	struct z_erofs_decompress_req *rq = ctx->rq;
-	unsigned int omargin, total, i, j;
+	unsigned int omargin, total, i;
 	struct page **in;
 	void *src, *tmp;
 
@@ -135,12 +135,13 @@ static void *z_erofs_lz4_handle_overlap(struct z_erofs_lz4_decompress_ctx *ctx,
 		    omargin < LZ4_DECOMPRESS_INPLACE_MARGIN(rq->inputsize))
 			goto docopy;
 
-		for (i = 0; i < ctx->inpages; ++i) {
-			DBG_BUGON(rq->in[i] == NULL);
-			for (j = 0; j < ctx->outpages - ctx->inpages + i; ++j)
-				if (rq->out[j] == rq->in[i])
-					goto docopy;
-		}
+		for (i = 0; i < ctx->inpages; ++i)
+			if (rq->out[ctx->outpages - ctx->inpages + i] !=
+			    rq->in[i])
+				goto docopy;
+		kunmap_local(inpage);
+		*maptype = 3;
+		return out + ((ctx->outpages - ctx->inpages) << PAGE_SHIFT);
 	}
 
 	if (ctx->inpages <= 1) {
@@ -148,7 +149,6 @@ static void *z_erofs_lz4_handle_overlap(struct z_erofs_lz4_decompress_ctx *ctx,
 		return inpage;
 	}
 	kunmap_local(inpage);
-	might_sleep();
 	src = erofs_vm_map_ram(rq->in, ctx->inpages);
 	if (!src)
 		return ERR_PTR(-ENOMEM);
@@ -204,12 +204,12 @@ int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
 }
 
 static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
-				      u8 *out)
+				      u8 *dst)
 {
 	struct z_erofs_decompress_req *rq = ctx->rq;
 	bool support_0padding = false, may_inplace = false;
 	unsigned int inputmargin;
-	u8 *headpage, *src;
+	u8 *out, *headpage, *src;
 	int ret, maptype;
 
 	DBG_BUGON(*rq->in == NULL);
@@ -230,11 +230,12 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 	}
 
 	inputmargin = rq->pageofs_in;
-	src = z_erofs_lz4_handle_overlap(ctx, headpage, &inputmargin,
+	src = z_erofs_lz4_handle_overlap(ctx, headpage, dst, &inputmargin,
 					 &maptype, may_inplace);
 	if (IS_ERR(src))
 		return PTR_ERR(src);
 
+	out = dst + rq->pageofs_out;
 	/* legacy format could compress extra data in a pcluster. */
 	if (rq->partial_decoding || !support_0padding)
 		ret = LZ4_decompress_safe_partial(src + inputmargin, out,
@@ -265,7 +266,7 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 		vm_unmap_ram(src, ctx->inpages);
 	} else if (maptype == 2) {
 		erofs_put_pcpubuf(src);
-	} else {
+	} else if (maptype != 3) {
 		DBG_BUGON(1);
 		return -EFAULT;
 	}
@@ -308,7 +309,7 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
 	}
 
 dstmap_out:
-	ret = z_erofs_lz4_decompress_mem(&ctx, dst + rq->pageofs_out);
+	ret = z_erofs_lz4_decompress_mem(&ctx, dst);
 	if (!dst_maptype)
 		kunmap_local(dst);
 	else if (dst_maptype == 2)


