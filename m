Return-Path: <stable+bounces-81526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE544994057
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 10:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74001C25BA6
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 08:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFDF1F708D;
	Tue,  8 Oct 2024 07:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="psbxSAq1"
X-Original-To: stable@vger.kernel.org
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F8C1F706F;
	Tue,  8 Oct 2024 07:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370979; cv=none; b=skBoZ4LV0EfgF3KdOnJ1Xq6PDbs0KAiZ+IliCA31N+OlvyNca3m8zSxqOHXsW6N9MyK6I/VgS1V39seu2VNAzyeqBxZ+N66023qpb6AeiSFsGzjSJDFH0wUxOX5y7gOrgFiZDlHkwrryxSeFXWUd18grqziCI72qd/AwflJj9aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370979; c=relaxed/simple;
	bh=glnnO6a4WlJMcLhTyz/xBKXSbgTunCMaW/KHI4x3UFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fsCFfVUBL2IoQFztasWz17JF7Dx5DzdsULO7dJwjcNsSywfmoQcEbkkFn3FzKh/D4cGMcgbxH8rvdYaG4BvGA+259Lx8cUT+nMbpbsUeuTu8NKrNTtXem/SvDfVXKzw8Ro+ogMazVXUnRa4+fZUwdR9p2ggIvucr0gQgttFRZ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=psbxSAq1; arc=none smtp.client-ip=47.90.199.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728370964; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Qzw3uPLvC2c1Ig93+/usRmDOA6a9YuiU/S67IDUtqwU=;
	b=psbxSAq1iNgKaYDf6qpzaVLDXWJO1UoCfzAZWdVfY9yEkjh2KEs9mTWhKOeMRT/9DPu2B8mcZdUxwFBjAco8PW88yx8olO1Ie9Zy1dlj8Ro8AR4J4vLeiW1pxl5u6/mktRLlO2U+Pbt4si64S4cjfcEpzkAI+tWmCZfUiOoIvdE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGbLQYt_1728370629)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 14:57:24 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 6.1.y 1/5] erofs: get rid of erofs_inode_datablocks()
Date: Tue,  8 Oct 2024 14:57:04 +0800
Message-ID: <20241008065708.727659-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 4efdec36dc9907628e590a68193d6d8e5e74d032 upstream.

erofs_inode_datablocks() has the only one caller, let's just get
rid of it entirely.  No logic changes.

Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Stable-dep-of: 9ed50b8231e3 ("erofs: fix incorrect symlink detection in fast symlink")
Link: https://lore.kernel.org/r/20230204093040.97967-1-hsiangkao@linux.alibaba.com
[ Gao Xiang: apply this to 6.6.y to avoid further backport twists
             due to obsoleted EROFS_BLKSIZ. ]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Obsoleted EROFS_BLKSIZ impedes efforts to backport
 9ed50b8231e3 ("erofs: fix incorrect symlink detection in fast symlink")
 9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted images properly")

To avoid further bugfix conflicts due to random EROFS_BLKSIZs
around the whole codebase, just backport the dependencies for 6.1.y.

 fs/erofs/internal.h |  6 ------
 fs/erofs/namei.c    | 18 +++++-------------
 2 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 79a7a5815ea6..30d464230ae0 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -347,12 +347,6 @@ static inline erofs_off_t erofs_iloc(struct inode *inode)
 		(EROFS_I(inode)->nid << sbi->islotbits);
 }
 
-static inline unsigned long erofs_inode_datablocks(struct inode *inode)
-{
-	/* since i_size cannot be changed */
-	return DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
-}
-
 static inline unsigned int erofs_bitrange(unsigned int value, unsigned int bit,
 					  unsigned int bits)
 {
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index e8ccaa761bd6..642431350bea 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2022, Alibaba Cloud
  */
 #include "xattr.h"
-
 #include <trace/events/erofs.h>
 
 struct erofs_qstr {
@@ -87,19 +86,13 @@ static struct erofs_dirent *find_target_dirent(struct erofs_qstr *name,
 	return ERR_PTR(-ENOENT);
 }
 
-static void *find_target_block_classic(struct erofs_buf *target,
-				       struct inode *dir,
-				       struct erofs_qstr *name,
-				       int *_ndirents)
+static void *erofs_find_target_block(struct erofs_buf *target,
+		struct inode *dir, struct erofs_qstr *name, int *_ndirents)
 {
-	unsigned int startprfx, endprfx;
-	int head, back;
+	int head = 0, back = DIV_ROUND_UP(dir->i_size, EROFS_BLKSIZ) - 1;
+	unsigned int startprfx = 0, endprfx = 0;
 	void *candidate = ERR_PTR(-ENOENT);
 
-	startprfx = endprfx = 0;
-	head = 0;
-	back = erofs_inode_datablocks(dir) - 1;
-
 	while (head <= back) {
 		const int mid = head + (back - head) / 2;
 		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
@@ -180,8 +173,7 @@ int erofs_namei(struct inode *dir, const struct qstr *name, erofs_nid_t *nid,
 	qn.end = name->name + name->len;
 
 	ndirents = 0;
-
-	de = find_target_block_classic(&buf, dir, &qn, &ndirents);
+	de = erofs_find_target_block(&buf, dir, &qn, &ndirents);
 	if (IS_ERR(de))
 		return PTR_ERR(de);
 
-- 
2.43.5


