Return-Path: <stable+bounces-45434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 972858C9A08
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 11:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB879B209BC
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 09:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF4E1BC4F;
	Mon, 20 May 2024 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PdULT3Gi"
X-Original-To: stable@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070038BEA;
	Mon, 20 May 2024 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716195678; cv=none; b=CaNPMQxMpoomi6wHOM5QD9Uk3AeWAuWZ4B7KaCXTiTioAsLNh3dBMbQAkg8Nd4La8xZ5RuVje3deOUxtIB81wak1joUYWnQVklwwhYAN7o9L9hzOsr/VP+UILIHY2sytDkzja2Digu22VHeID+lsYF6tOVpJFb5jmGUYLessb/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716195678; c=relaxed/simple;
	bh=jkFAETIK4QuKC1KMeY+1wqV2VTAYN1BlF9iAKEqQo8I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jSs878Tqa0BfeQ/QQZBgfEcDBQXkMvcWlM3W5W+AQqds1Ls8r13AF084OqwZwODzL5pPsehPJBtiKnVc6zJtgnir74K/Sl1y1v3kx30FhYvHGUOPCdwbPYzrNg9jw0Kzyek1UtjsHAjsawoazncOnulua0mHnYixM9Q0bHcsGow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PdULT3Gi; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716195672; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+kDVR19ysmhcpcyTyT19ZSJuTM3Y2KTmTiRTyEtjSE4=;
	b=PdULT3GiKnsdSwgXikI5mDGA4B7LBsR5NuJTs0DzBdPWSGuAw9CE9fHcrNFmRz/O9IPd1DaVR8kDVlZA2IC55WO0F9GhwNNlFVgtstvTnea1yHBOS2y3TuE9q6Z2gkOTp1Xq9vp3H0pTb+F9T/N7EzTdxxtVlpqvWwRi3TiSro4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W6qDeFY_1716195667;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W6qDeFY_1716195667)
          by smtp.aliyun-inc.com;
          Mon, 20 May 2024 17:01:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	stable@vger.kernel.org
Subject: [PATCH] erofs: avoid allocating DEFLATE streams before mounting
Date: Mon, 20 May 2024 17:01:06 +0800
Message-Id: <20240520090106.2898681-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, each DEFLATE stream takes one 32 KiB permanent internal
window buffer even if there is no running instance which uses DEFLATE
algorithm.

It's unexpected and wasteful on embedded devices with limited resources
and servers with hundreds of CPU cores if DEFLATE is enabled but unused.

Fixes: ffa09b3bd024 ("erofs: DEFLATE compression support")
Cc: <stable@vger.kernel.org> # 6.6+
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/decompressor_deflate.c | 55 +++++++++++++++++----------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index 81e65c453ef0..3a3461561a3c 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -46,39 +46,15 @@ int __init z_erofs_deflate_init(void)
 	/* by default, use # of possible CPUs instead */
 	if (!z_erofs_deflate_nstrms)
 		z_erofs_deflate_nstrms = num_possible_cpus();
-
-	for (; z_erofs_deflate_avail_strms < z_erofs_deflate_nstrms;
-	     ++z_erofs_deflate_avail_strms) {
-		struct z_erofs_deflate *strm;
-
-		strm = kzalloc(sizeof(*strm), GFP_KERNEL);
-		if (!strm)
-			goto out_failed;
-
-		/* XXX: in-kernel zlib cannot shrink windowbits currently */
-		strm->z.workspace = vmalloc(zlib_inflate_workspacesize());
-		if (!strm->z.workspace) {
-			kfree(strm);
-			goto out_failed;
-		}
-
-		spin_lock(&z_erofs_deflate_lock);
-		strm->next = z_erofs_deflate_head;
-		z_erofs_deflate_head = strm;
-		spin_unlock(&z_erofs_deflate_lock);
-	}
 	return 0;
-
-out_failed:
-	erofs_err(NULL, "failed to allocate zlib workspace");
-	z_erofs_deflate_exit();
-	return -ENOMEM;
 }
 
 int z_erofs_load_deflate_config(struct super_block *sb,
 			struct erofs_super_block *dsb, void *data, int size)
 {
 	struct z_erofs_deflate_cfgs *dfl = data;
+	static DEFINE_MUTEX(deflate_resize_mutex);
+	static bool inited;
 
 	if (!dfl || size < sizeof(struct z_erofs_deflate_cfgs)) {
 		erofs_err(sb, "invalid deflate cfgs, size=%u", size);
@@ -89,9 +65,36 @@ int z_erofs_load_deflate_config(struct super_block *sb,
 		erofs_err(sb, "unsupported windowbits %u", dfl->windowbits);
 		return -EOPNOTSUPP;
 	}
+	mutex_lock(&deflate_resize_mutex);
+	if (!inited) {
+		for (; z_erofs_deflate_avail_strms < z_erofs_deflate_nstrms;
+		     ++z_erofs_deflate_avail_strms) {
+			struct z_erofs_deflate *strm;
+
+			strm = kzalloc(sizeof(*strm), GFP_KERNEL);
+			if (!strm)
+				goto failed;
+			/* XXX: in-kernel zlib cannot customize windowbits */
+			strm->z.workspace = vmalloc(zlib_inflate_workspacesize());
+			if (!strm->z.workspace) {
+				kfree(strm);
+				goto failed;
+			}
 
+			spin_lock(&z_erofs_deflate_lock);
+			strm->next = z_erofs_deflate_head;
+			z_erofs_deflate_head = strm;
+			spin_unlock(&z_erofs_deflate_lock);
+		}
+		inited = true;
+	}
+	mutex_unlock(&deflate_resize_mutex);
 	erofs_info(sb, "EXPERIMENTAL DEFLATE feature in use. Use at your own risk!");
 	return 0;
+failed:
+	mutex_unlock(&deflate_resize_mutex);
+	z_erofs_deflate_exit();
+	return -ENOMEM;
 }
 
 int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
-- 
2.39.3


