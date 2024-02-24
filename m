Return-Path: <stable+bounces-23557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B66168622E8
	for <lists+stable@lfdr.de>; Sat, 24 Feb 2024 07:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73381C21615
	for <lists+stable@lfdr.de>; Sat, 24 Feb 2024 06:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F20717585;
	Sat, 24 Feb 2024 06:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qCeFBw49"
X-Original-To: stable@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE0917580
	for <stable@vger.kernel.org>; Sat, 24 Feb 2024 06:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708756025; cv=none; b=oriKE/wK0Kl8DCVeVJ7cj8Gz1yrhVB07ZvALeH6fozupjLQHEYeZbK48GpImBvplp+k048KCpinoX1yuib8T3yZwZ7W37bCVirbh0OaNGNmxnpUqWOPIfRnMe3b9YlqtaFsHKWqL8znf4eSONktpGBHfpE3XdlI/3KQq94WTqDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708756025; c=relaxed/simple;
	bh=HVohwScl9FB3IiOm4Uo28mv4smjpJOlOMB1YKEcvzks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jc+JD71KPRZW4nnctffNLs8UkpbNFsqwuv1czvsL6cSrwAw7D+z/rtkHLftWt5qcYU9fV82d7fawEKEoX0ntn+56kHMGDT/9pWVnaHZO9TQKLM2Tk0qS5HyJlfaOummB+u8x4iuozUoZ106gJ/H4yQ/D+kcUzJO6dhpne+zJp9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qCeFBw49; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708756013; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4GEqWX6yU3+p/xenHNHEWR+mKGMypPUF4pv+LX4hbk0=;
	b=qCeFBw49SGMz180niRY219nuoo0qGittB+IqDgPrmQA5wr8W8tHUowK+vaxe0sldMexmqc29clXri9Bc5s52QXYiph3vmklcoNGOMPrqj2VoYgwzHxVqAC2l9wJzOJQznvhmYtRznHVJLyMNnUW0rRhrj3bGyWFa+yscD8t5e9g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W16.xLk_1708756005;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W16.xLk_1708756005)
          by smtp.aliyun-inc.com;
          Sat, 24 Feb 2024 14:26:53 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-erofs@lists.ozlabs.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Juhyung Park <qkrwngud825@gmail.com>,
	Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Subject: [PATCH 5.15.y] erofs: fix lz4 inplace decompression
Date: Sat, 24 Feb 2024 14:26:43 +0800
Message-Id: <20240224062643.2099614-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <2024012648-backwater-colt-7290@gregkh>
References: <2024012648-backwater-colt-7290@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 3c12466b6b7bf1e56f9b32c366a3d83d87afb4de upstream.

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
---
Adapt 5.15.y codebase due to non-trivial conflicts out of
recent new features & cleanups.

I've done my own EROFS tests, yet more test on new x86
platform triggered by FSRM is helpful too.

 fs/erofs/decompressor.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 8193c14bb111..b4be6c524815 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -124,11 +124,11 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 }
 
 static void *z_erofs_handle_inplace_io(struct z_erofs_decompress_req *rq,
-			void *inpage, unsigned int *inputmargin, int *maptype,
-			bool support_0padding)
+		void *inpage, void *out, unsigned int *inputmargin, int *maptype,
+		bool support_0padding)
 {
 	unsigned int nrpages_in, nrpages_out;
-	unsigned int ofull, oend, inputsize, total, i, j;
+	unsigned int ofull, oend, inputsize, total, i;
 	struct page **in;
 	void *src, *tmp;
 
@@ -143,12 +143,13 @@ static void *z_erofs_handle_inplace_io(struct z_erofs_decompress_req *rq,
 		    ofull - oend < LZ4_DECOMPRESS_INPLACE_MARGIN(inputsize))
 			goto docopy;
 
-		for (i = 0; i < nrpages_in; ++i) {
-			DBG_BUGON(rq->in[i] == NULL);
-			for (j = 0; j < nrpages_out - nrpages_in + i; ++j)
-				if (rq->out[j] == rq->in[i])
-					goto docopy;
-		}
+		for (i = 0; i < nrpages_in; ++i)
+			if (rq->out[nrpages_out - nrpages_in + i] !=
+			    rq->in[i])
+				goto docopy;
+		kunmap_atomic(inpage);
+		*maptype = 3;
+		return out + ((nrpages_out - nrpages_in) << PAGE_SHIFT);
 	}
 
 	if (nrpages_in <= 1) {
@@ -156,7 +157,6 @@ static void *z_erofs_handle_inplace_io(struct z_erofs_decompress_req *rq,
 		return inpage;
 	}
 	kunmap_atomic(inpage);
-	might_sleep();
 	src = erofs_vm_map_ram(rq->in, nrpages_in);
 	if (!src)
 		return ERR_PTR(-ENOMEM);
@@ -193,10 +193,10 @@ static void *z_erofs_handle_inplace_io(struct z_erofs_decompress_req *rq,
 	return src;
 }
 
-static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
+static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *dst)
 {
 	unsigned int inputmargin;
-	u8 *headpage, *src;
+	u8 *out, *headpage, *src;
 	bool support_0padding;
 	int ret, maptype;
 
@@ -220,11 +220,12 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 	}
 
 	rq->inputsize -= inputmargin;
-	src = z_erofs_handle_inplace_io(rq, headpage, &inputmargin, &maptype,
-					support_0padding);
+	src = z_erofs_handle_inplace_io(rq, headpage, dst, &inputmargin,
+					&maptype, support_0padding);
 	if (IS_ERR(src))
 		return PTR_ERR(src);
 
+	out = dst + rq->pageofs_out;
 	/* legacy format could compress extra data in a pcluster. */
 	if (rq->partial_decoding || !support_0padding)
 		ret = LZ4_decompress_safe_partial(src + inputmargin, out,
@@ -253,7 +254,7 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 		vm_unmap_ram(src, PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT);
 	} else if (maptype == 2) {
 		erofs_put_pcpubuf(src);
-	} else {
+	} else if (maptype != 3) {
 		DBG_BUGON(1);
 		return -EFAULT;
 	}
@@ -354,8 +355,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 	dst_maptype = 2;
 
 dstmap_out:
-	ret = alg->decompress(rq, dst + rq->pageofs_out);
-
+	ret = alg->decompress(rq, dst);
 	if (!dst_maptype)
 		kunmap_atomic(dst);
 	else if (dst_maptype == 2)
-- 
2.39.3


