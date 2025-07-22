Return-Path: <stable+bounces-163683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 632E9B0D6BF
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 12:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8298DAA05C1
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 10:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506D12E1C7E;
	Tue, 22 Jul 2025 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lSWBxzAV"
X-Original-To: stable@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053B82E0402;
	Tue, 22 Jul 2025 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178444; cv=none; b=cchk9CnB66wZw5E1X0VO8o5tzen09R8OY9XCeo9ZrLOWJHF6xFrT2t+mCyx0aN+aSOQ8ThqFwl8nnrs5CFRAv8Glxy1ELfbpINrW8mdgAuq1oppNchLc7zBTZyGOuoYkerdwnbspMTEPg0AhEpbDPZlmHxE4JeyPEgxWGwFu16A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178444; c=relaxed/simple;
	bh=8YKGjpMzeEknsjq1h3Y6UJ7KcbQXboDSUy92iWzcFvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N26HvucFgB9vkT85kpVQkPlaZaoFSgLrzjwrsADgjLWpFTGdvzO+Hg0CUzhkj53pkrIs7oYgBi1zdQ+xiaN2lg9sA2gpeCd/OwCz6bMTelW2QQyoRTt9T7cNEkF4R61cUO/H86jyKkZC653kayPkAkxo/CAmJ+LRQedO5qut5JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lSWBxzAV; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753178437; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZF3uulUA+O49eHkCxAbB2EunI3MkghBKmd/YNGAhKRU=;
	b=lSWBxzAVejulqNtCsU0y5NODdHNzLOr51Zh38/TRsMS5ePNBkCJLBED+lyrU4FTHoDoc08iRor+YwqhuQTCth5DKeb9josVFdK/VM3DXK/hqPBFlgzl16MZY+KehaPSHbDtEFJE65XJqadl+769Ajds4g5Y16JnD8XY788r+aJc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjVvTpN_1753178435 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Jul 2025 18:00:36 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: linux-erofs@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Yue Hu <huyue2@coolpad.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 6.1.y 1/5] erofs: get rid of debug_one_dentry()
Date: Tue, 22 Jul 2025 18:00:25 +0800
Message-ID: <20250722100029.3052177-2-hsiangkao@linux.alibaba.com>
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

commit e324eaa9790614577c93e819651e0a83963dac79 upstream.

Since erofsdump is available, no need to keep this debugging
functionality at all.

Also drop a useless comment since it's the VFS behavior.

Link: https://lore.kernel.org/r/20230114125746.399253-1-xiang@kernel.org
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/dir.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index 966a88cc529e..963bbed0b699 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -6,21 +6,6 @@
  */
 #include "internal.h"
 
-static void debug_one_dentry(unsigned char d_type, const char *de_name,
-			     unsigned int de_namelen)
-{
-#ifdef CONFIG_EROFS_FS_DEBUG
-	/* since the on-disk name could not have the trailing '\0' */
-	unsigned char dbg_namebuf[EROFS_NAME_LEN + 1];
-
-	memcpy(dbg_namebuf, de_name, de_namelen);
-	dbg_namebuf[de_namelen] = '\0';
-
-	erofs_dbg("found dirent %s de_len %u d_type %d", dbg_namebuf,
-		  de_namelen, d_type);
-#endif
-}
-
 static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 			       void *dentry_blk, struct erofs_dirent *de,
 			       unsigned int nameoff, unsigned int maxsize)
@@ -52,10 +37,8 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 			return -EFSCORRUPTED;
 		}
 
-		debug_one_dentry(d_type, de_name, de_namelen);
 		if (!dir_emit(ctx, de_name, de_namelen,
 			      le64_to_cpu(de->nid), d_type))
-			/* stopped by some reason */
 			return 1;
 		++de;
 		ctx->pos += sizeof(struct erofs_dirent);
-- 
2.43.5


