Return-Path: <stable+bounces-163684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B83CB0D6CE
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 12:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B301890164
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 10:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7DB2E7637;
	Tue, 22 Jul 2025 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a48jtkUH"
X-Original-To: stable@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56D32E1C5B;
	Tue, 22 Jul 2025 10:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178446; cv=none; b=PTfUp8s8/7yIFu/6koPJ1rAcQ9Y9XA+gbhV7NsikS0NYXLgkfhECzHRH5aSzSqTURyBp3uW7b9Q+dW9F8pcKL0G5XVLY8DdQqynj3vLWAzEASEEa+RiXz3H5tbnLSlhRY09X9wzqJWlO5XlNgyZEDqINOmNtzbCDGRFkt4bDuL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178446; c=relaxed/simple;
	bh=YsSTRr30KqKgxd9rZ5VWP+z9Iy/mEK/wUMenALLyxyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYOawJ0SzE91Li92A/6f4CQlAhYPmIz5m/Hltfwp9fxTVvJr/OwatyOSmm1n/mdyOItGqNmWZ/6rS3YAd9d5a3Fs8wsr4YR35E8Oh+nCqL6CG40oyaynKMLCdGCnJz7vsJ3+CJW/sHapJA+ShHOgFskvfgm27XyHPlxPSHoGskA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a48jtkUH; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753178440; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=gxV1WKa5S/2KsJQTNxmbmmX0Y1yNxfEKlF7T1cOeQVY=;
	b=a48jtkUH1Tgwl0xxTWuRgGE3x/LtMXFXsUBYILMGwTYoc8+6bwyOUsk5QHrFsv+dDTKOzJTMBiqODvEvMmf6xuFY+ji04nDw4pSIxJz7wNMVC3sk8UOTvCriWzj6hcDUNXtTMQz82NNCNDErQQR8AVzGPiOt3T2Cmi82MFMA768=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjVvTra_1753178438 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Jul 2025 18:00:39 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: linux-erofs@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Yue Hu <huyue2@coolpad.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 6.1.y 4/5] erofs: simplify z_erofs_transform_plain()
Date: Tue, 22 Jul 2025 18:00:28 +0800
Message-ID: <20250722100029.3052177-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250722100029.3052177-1-hsiangkao@linux.alibaba.com>
References: <20250722100029.3052177-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit c5539762f32e97c5e16215fa1336e32095b8b0fd upstream.

Use memcpy_to_page() instead of open-coding them.

In addition, add a missing flush_dcache_page() even though almost all
modern architectures clear `PG_dcache_clean` flag for new file cache
pages so that it doesn't change anything in practice.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20230627161240.331-2-hsiangkao@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/decompressor.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 0eaa9e495346..b1746215efe6 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -323,7 +323,7 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 	const unsigned int lefthalf = rq->outputsize - righthalf;
 	const unsigned int interlaced_offset =
 		rq->alg == Z_EROFS_COMPRESSION_SHIFTED ? 0 : rq->pageofs_out;
-	unsigned char *src, *dst;
+	u8 *src;
 
 	if (outpages > 2 && rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
 		DBG_BUGON(1);
@@ -336,22 +336,19 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 	}
 
 	src = kmap_local_page(rq->in[inpages - 1]) + rq->pageofs_in;
-	if (rq->out[0]) {
-		dst = kmap_local_page(rq->out[0]);
-		memcpy(dst + rq->pageofs_out, src + interlaced_offset,
-		       righthalf);
-		kunmap_local(dst);
-	}
+	if (rq->out[0])
+		memcpy_to_page(rq->out[0], rq->pageofs_out,
+			       src + interlaced_offset, righthalf);
 
 	if (outpages > inpages) {
 		DBG_BUGON(!rq->out[outpages - 1]);
 		if (rq->out[outpages - 1] != rq->in[inpages - 1]) {
-			dst = kmap_local_page(rq->out[outpages - 1]);
-			memcpy(dst, interlaced_offset ? src :
-					(src + righthalf), lefthalf);
-			kunmap_local(dst);
+			memcpy_to_page(rq->out[outpages - 1], 0, src +
+					(interlaced_offset ? 0 : righthalf),
+				       lefthalf);
 		} else if (!interlaced_offset) {
 			memmove(src, src + righthalf, lefthalf);
+			flush_dcache_page(rq->in[inpages - 1]);
 		}
 	}
 	kunmap_local(src);
-- 
2.43.5


