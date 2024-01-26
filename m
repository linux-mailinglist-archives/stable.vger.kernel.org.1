Return-Path: <stable+bounces-15934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541B183E4C9
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C097CB259F9
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 22:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EF6524A4;
	Fri, 26 Jan 2024 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lCB/qy+K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328864F88E
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 22:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306872; cv=none; b=JzupfMte7I8jGmUb0uqohCP+rI4CFC6uTq8U348Rorll0UwBb7JmVhz2us+sfMLgjr9SgTgeMogA4oF0D7uXs0B3kbiyCPmPoBH+UnBYv5kLlzNrBlKcZd9K8g8O5uwHxHHXs/08KSRFOqKNXX4mLNNGhTkF5KfD3cxZ43YCnvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306872; c=relaxed/simple;
	bh=En1weIPuyDr0J9NzBpRxQjppYRr2sYoMn7sttjIvFk0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L95uoYqaEOaO1MZP+qRKABcVTLJzRlx9x1WeuZ16pjgAGVPMy4GS4LRUAKNLQMqrQtYhdi2zrGx0O1N14CltU3BBZ+UV75ua/hVvbGIY4UxG/zfzNsLxLEi0SSP6zzlrDmt9na2GIH8mmw/ixKAlcg8y0CN9cu5tjOpwQaDLA5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lCB/qy+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B81C433C7;
	Fri, 26 Jan 2024 22:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706306871;
	bh=En1weIPuyDr0J9NzBpRxQjppYRr2sYoMn7sttjIvFk0=;
	h=Subject:To:Cc:From:Date:From;
	b=lCB/qy+KXObXSuybyyJmnoIdXALZ5v3LILZjBZ8uevCqX9c3kPS4ir6XeCxuWJJLZ
	 OBpmtsLSQQSNPWQAwp7zQmvy67QP8D6tPyu0HzeQ30/VtOi5Dxxx4w1I7o+KUVWf0Q
	 njRRHX9YvzLIn+wO6tDKqabvQrgxXNsGFFyaCL9M=
Subject: FAILED: patch "[PATCH] erofs: fix lz4 inplace decompression" failed to apply to 5.10-stable tree
To: xiang@kernel.org,hsiangkao@linux.alibaba.com,qkrwngud825@gmail.com,stable@vger.kernel.org,zhaoyifan@sjtu.edu.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 14:07:50 -0800
Message-ID: <2024012650-altitude-gush-572f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 3c12466b6b7bf1e56f9b32c366a3d83d87afb4de
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012650-altitude-gush-572f@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

3c12466b6b7b ("erofs: fix lz4 inplace decompression")
123ec246ebe3 ("erofs: get rid of the remaining kmap_atomic()")
ab749badf9f4 ("erofs: support unaligned data decompression")
10e5f6e482e1 ("erofs: introduce z_erofs_fixup_insize")
d67aee76d418 ("erofs: tidy up z_erofs_lz4_decompress")
7e508f2ca8bb ("erofs: rename lz4_0pading to zero_padding")
eaa9172ad988 ("erofs: get rid of ->lru usage")
622ceaddb764 ("erofs: lzma compression support")
966edfb0a3dc ("erofs: rename some generic methods in decompressor")
386292919c25 ("erofs: introduce readmore decompression strategy")
8f89926290c4 ("erofs: get compression algorithms directly on mapping")
dfeab2e95a75 ("erofs: add multiple device support")
e62424651f43 ("erofs: decouple basic mount options from fs_context")
5b6e7e120e71 ("erofs: remove the fast path of per-CPU buffer decompression")
2e5fd489a4e5 ("Merge tag 'libnvdimm-for-5.15' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm")

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


