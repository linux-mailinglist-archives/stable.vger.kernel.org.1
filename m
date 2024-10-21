Return-Path: <stable+bounces-87031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB069A5F20
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07472283F54
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 08:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BA01E1C06;
	Mon, 21 Oct 2024 08:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iFcx6QVj"
X-Original-To: stable@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1C51E105F
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 08:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500604; cv=none; b=kSlqTE6W4Kk3NlniQP3/BzIvTwOAxqmeGEW8+4p76Ad0d87UERtbDwU8Kz5oS95TUbxxGWcOLmeT+vbjFStjOfNyCXqDa19NhMroMiDmnDv+qivyPjxvgBKcfSIOIOxmaQPt2nLSG4K3PzeEMfarvQCR4UsnjTSQoANhcj4OZfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500604; c=relaxed/simple;
	bh=y4+95gWLrOM8hs6Lz5Oi1tFjUoNRKKizyR4I6dFfy1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sQ98Nnom+euS+Y4NmGvh8Aqd8DdFWYbkXgBsMd6UdEZbmwULNXnCmrLcZBn+CTvyUuHqLFZXnNl4Ehdf5AtwAcjfahGqLrGvD8KXKPJYa4DhKqczC4DcbPt9aQ2wYtgLXk6IWtd4DFvfshD4RcGSHXsdCW4Pju4Zonpihrk9ZaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iFcx6QVj; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729500594; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=CI2IO2w1zARuj9xj4CaUPdugLON1s/s7SFz+eWwBHnY=;
	b=iFcx6QVjnFlDg1Fvm3JKfXBioqaEbAxnM/2LiR8hiwr2W0pAG22gDmGeBQ0V99NiLGw99wq1agWd3AdlxwUen3UxVJcEli4uGXxGh5Ikx6jMBF4TUQgQaoCXWxfzDywmu4wRXj/uYpUMp4C/6IK0sxpAZ71ySpV7POGg7zFFueU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHZK12o_1729500270 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 21 Oct 2024 16:44:36 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-erofs@lists.ozlabs.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Juhyung Park <qkrwngud825@gmail.com>,
	Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Subject: [PATCH 5.4.y] erofs: fix lz4 inplace decompression
Date: Mon, 21 Oct 2024 16:44:29 +0800
Message-ID: <20241021084429.3742972-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Link: https://lore.kernel.org/r/20231206045534.3920847-1-hsiangkao@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
The remaining stable patch to address the issue "CVE-2023-52497" for
5.4.y, which is the same as the 5.10.y one [1].

[1] https://lore.kernel.org/r/20240224063248.2157885-1-hsiangkao@linux.alibaba.com

 fs/erofs/decompressor.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 38eeec5e3032..d06a3b77fb39 100644
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
 
@@ -178,7 +182,7 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 	if (copied)
 		erofs_put_pcpubuf(src);
 	else
-		kunmap_atomic(src);
+		kunmap_atomic(src2);
 	return ret;
 }
 
@@ -248,7 +252,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 			return PTR_ERR(dst);
 
 		rq->inplace_io = false;
-		ret = alg->decompress(rq, dst);
+		ret = alg->decompress(rq, dst, NULL);
 		if (!ret)
 			copy_from_pcpubuf(rq->out, dst, rq->pageofs_out,
 					  rq->outputsize);
@@ -282,7 +286,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 	dst_maptype = 2;
 
 dstmap_out:
-	ret = alg->decompress(rq, dst + rq->pageofs_out);
+	ret = alg->decompress(rq, dst + rq->pageofs_out, dst);
 
 	if (!dst_maptype)
 		kunmap_atomic(dst);
-- 
2.43.5


