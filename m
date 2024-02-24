Return-Path: <stable+bounces-23558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73788622ED
	for <lists+stable@lfdr.de>; Sat, 24 Feb 2024 07:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74EE1C219ED
	for <lists+stable@lfdr.de>; Sat, 24 Feb 2024 06:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD00A55;
	Sat, 24 Feb 2024 06:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FbZsVYuA"
X-Original-To: stable@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0088838C
	for <stable@vger.kernel.org>; Sat, 24 Feb 2024 06:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708756383; cv=none; b=bDIzSG6CcqWMjYpZEewvwR0znctcBzpmiga62odG5EsqNySSWMm+WHFh3Wcb8dTnKZWFRomATL/dwDa0hTpktpc4tDejgleMOzop2VIe9U3BxEs6KCMs5SFwIOurV4J5u5Grs88DQxfKVWoZqGpNbhjXenUb9xQl71Ag0sfa8Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708756383; c=relaxed/simple;
	bh=QdRK9wg4QIShMcn2nQYDShKXKWed994r999EYcyKLRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EQM7UyditbU03eQlQ6FDJrfL+Ljz8yqUfTd+aoytu3t7dJ2SNyE+hPH9ZJygtpvrfb3kxxPOkz5wl6601TBSM7AIpXd9GDwmv3toTvdm8pwBj0i9jVwsobcbAIXvcbb02bes0rhgU3zz8kz3T7PG9sCYFDFpcUFJxv7CgfAXQdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FbZsVYuA; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708756373; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ZxGSVLYB/zBTdOcMVRAjEhslYD8fvmcl12GLS3hOqto=;
	b=FbZsVYuAbCErN+s1tyWmj8PNr3grAH2x/YdwtMSH5YzOSn4pfg+p9aCRshd/4cpoqY8LO1ASIlo5NFl8Qp+rreBT+rUGwAVYdXozC0cZBwYRxYnHOKJK4AvUivnqhLNPMJNopH3sF5agbryu3J30hfy6FIQ+zWfHQ+Z+wpwrlHU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W15zYPj_1708756371;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W15zYPj_1708756371)
          by smtp.aliyun-inc.com;
          Sat, 24 Feb 2024 14:32:52 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-erofs@lists.ozlabs.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Juhyung Park <qkrwngud825@gmail.com>,
	Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Subject: [PATCH 5.10.y] erofs: fix lz4 inplace decompression
Date: Sat, 24 Feb 2024 14:32:48 +0800
Message-Id: <20240224063248.2157885-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <2024012650-altitude-gush-572f@gregkh>
References: <2024012650-altitude-gush-572f@gregkh>
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
Adapt 5.10.y codebase due to non-trivial conflicts out of
recent new features & cleanups.

I've done my own EROFS tests, yet more test on new x86
platform triggered by FSRM is helpful too.

( This fix for 5.4.y codebase is still ongoing, and I will
  post later. )

 fs/erofs/decompressor.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index f921580b56cb..36693924db18 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -24,7 +24,8 @@ struct z_erofs_decompressor {
 	 */
 	int (*prepare_destpages)(struct z_erofs_decompress_req *rq,
 				 struct list_head *pagepool);
-	int (*decompress)(struct z_erofs_decompress_req *rq, u8 *out);
+	int (*decompress)(struct z_erofs_decompress_req *rq, u8 *out,
+			  u8 *obase);
 	char *name;
 };
 
@@ -114,10 +115,13 @@ static void *generic_copy_inplace_data(struct z_erofs_decompress_req *rq,
 	return tmp;
 }
 
-static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
+static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out,
+				  u8 *obase)
 {
+	const uint nrpages_out = PAGE_ALIGN(rq->pageofs_out +
+					    rq->outputsize) >> PAGE_SHIFT;
 	unsigned int inputmargin, inlen;
-	u8 *src;
+	u8 *src, *src2;
 	bool copied, support_0padding;
 	int ret;
 
@@ -125,6 +129,7 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 		return -EOPNOTSUPP;
 
 	src = kmap_atomic(*rq->in);
+	src2 = src;
 	inputmargin = 0;
 	support_0padding = false;
 
@@ -148,16 +153,15 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 	if (rq->inplace_io) {
 		const uint oend = (rq->pageofs_out +
 				   rq->outputsize) & ~PAGE_MASK;
-		const uint nr = PAGE_ALIGN(rq->pageofs_out +
-					   rq->outputsize) >> PAGE_SHIFT;
-
 		if (rq->partial_decoding || !support_0padding ||
-		    rq->out[nr - 1] != rq->in[0] ||
+		    rq->out[nrpages_out - 1] != rq->in[0] ||
 		    rq->inputsize - oend <
 		      LZ4_DECOMPRESS_INPLACE_MARGIN(inlen)) {
 			src = generic_copy_inplace_data(rq, src, inputmargin);
 			inputmargin = 0;
 			copied = true;
+		} else {
+			src = obase + ((nrpages_out - 1) << PAGE_SHIFT);
 		}
 	}
 
@@ -187,7 +191,7 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 	if (copied)
 		erofs_put_pcpubuf(src);
 	else
-		kunmap_atomic(src);
+		kunmap_atomic(src2);
 	return ret;
 }
 
@@ -257,7 +261,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 			return PTR_ERR(dst);
 
 		rq->inplace_io = false;
-		ret = alg->decompress(rq, dst);
+		ret = alg->decompress(rq, dst, NULL);
 		if (!ret)
 			copy_from_pcpubuf(rq->out, dst, rq->pageofs_out,
 					  rq->outputsize);
@@ -291,7 +295,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 	dst_maptype = 2;
 
 dstmap_out:
-	ret = alg->decompress(rq, dst + rq->pageofs_out);
+	ret = alg->decompress(rq, dst + rq->pageofs_out, dst);
 
 	if (!dst_maptype)
 		kunmap_atomic(dst);
-- 
2.39.3


