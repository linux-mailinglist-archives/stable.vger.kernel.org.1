Return-Path: <stable+bounces-47688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1BB8D485B
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 11:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ACEDB25AB8
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 09:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5813B183962;
	Thu, 30 May 2024 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JH07/8pB"
X-Original-To: stable@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8A46F313;
	Thu, 30 May 2024 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717060937; cv=none; b=TcYlCJobyrseNkRvng4o6sZuUHPj+LkjN4135fQIb+nnbji4K6AQ+eu7T+439GrC88sw/lYbvpafI0skOq6v20RZVQpJXJ/0LV4uukagxKbt3JwMC9f87HzuJPU/zbVRPVd+R1XCXuxOpqza2lK9d4/CVdcPTpW7jqwuBHOE2qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717060937; c=relaxed/simple;
	bh=PH7lguH/SoU2pDjlCsNDNkRAdVHrJ1mLAeNQcTzlXa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DY34nGUhmU1+r0NtXCWv69OGJxXjbzBJIi62Ia94bmXgLXCor2uRT0+wjn2LtNwjTTL6ZDp18M5XQJJ5YEEe+scO0BaFJtvH+H9SjZmOXHoo4vAulprWZ060O0b6lq9KrpOQ4B8NyONpkr3fduZkAiFrF4pfcy2DGyCormdR+0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JH07/8pB; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717060931; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=KSowKF1yk2HrBD5wWxaTcKui5ikFhcGrTJRBSctfjpk=;
	b=JH07/8pBYGsVwzAz0GaF4LXVRxaYGJ/EZ5qspveSjLDScwrFhSTJeQAcW/Xw7G65Zx1nMYQ7Y3EwjipebP9DKG6Sk4vud7H2VV9yEMTtAq+rPgqIMWkSy1wl7l1RVSLvfIPFF19NgxUhTMtaJx9dkeATpUI3My68cXGwRFJAdbA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W7WbjNt_1717060930;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W7WbjNt_1717060930)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 17:22:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org,
	Baokun Li <libaokun1@huawei.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>
Subject: [PATCH 6.6.y] erofs: avoid allocating DEFLATE streams before mounting
Date: Thu, 30 May 2024 17:22:01 +0800
Message-Id: <20240530092201.16873-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240530092201.16873-1-hsiangkao@linux.alibaba.com>
References: <20240530092201.16873-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 80eb4f62056d6ae709bdd0636ab96ce660f494b2 upstream.

Currently, each DEFLATE stream takes one 32 KiB permanent internal
window buffer even if there is no running instance which uses DEFLATE
algorithm.

It's unexpected and wasteful on embedded devices with limited resources
and servers with hundreds of CPU cores if DEFLATE is enabled but unused.

Fixes: ffa09b3bd024 ("erofs: DEFLATE compression support")
Cc: <stable@vger.kernel.org> # 6.6+
Reviewed-by: Sandeep Dhavale <dhavale@google.com>
Link: https://lore.kernel.org/r/20240520090106.2898681-1-hsiangkao@linux.alibaba.com
[ Gao Xiang: resolve trivial conflicts. ]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/decompressor_deflate.c | 55 +++++++++++++++++----------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index 0e1946a6bda5..aac2c837ef35 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -47,39 +47,15 @@ int __init z_erofs_deflate_init(void)
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
-	pr_err("failed to allocate zlib workspace\n");
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
@@ -90,9 +66,36 @@ int z_erofs_load_deflate_config(struct super_block *sb,
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


