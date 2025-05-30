Return-Path: <stable+bounces-148320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C24F9AC95A2
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 20:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D10A165ABC
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 18:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8851027703E;
	Fri, 30 May 2025 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="d2Xa3M++"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F250264A77;
	Fri, 30 May 2025 18:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748629916; cv=none; b=c173ObSYWH1N6SL1RtrHihWALnBERMsxZoXgYv3MUMd61aQee0DHkJ5kzHaz8yxY6wbOkHSivFz034Z9kHXOmDwIscd4qT7YZ5qs3ZDtDEgGVmO0kI9skD1rRuyyumoCH2NQWnjCZHYalbwy+wOYnrTtNv4486AZb33rEgHWMQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748629916; c=relaxed/simple;
	bh=IXcGfRmy+QSLxbIDnuWEMrDh5ssmCdbJQ9iAfYC4dbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUQv0ZIvpPunv5WgsPr9/T6Vi3y1t9WdWq7uAVOFOFevb/znffkjq0gDHf+16FOwRGyo9dplsdVQ84IgN/vzCfjIQBkc3WWaaTR1bE/nQ+ttqnllpxM5yUI7kt9gFmqkFRyj9Jqv1P00mSag4ahlmnjWn7dKt0QKMR146yOz6aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=d2Xa3M++; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.16])
	by mail.ispras.ru (Postfix) with ESMTPSA id 1D8B940755EB;
	Fri, 30 May 2025 18:31:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 1D8B940755EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1748629912;
	bh=yf3N76z1AZ6dIBtW7rVAoKXhww6/Z7dw6mR+g/CZJXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2Xa3M++ikZHaMDp6rKgXYOCySkUY8jrjt5AUS/L1g3TwNnMsW9ndUV8ELIJQwc1G
	 HhFGIjRnnx2z6Of1Im4cPL2zisr/UdjfbVQMzPEQdNvMQXco4WdMG8Z0YwVec2rsSn
	 +JUYBhlu1ixQDhqZ9VFMYWeEmVRDRtMEPKt6VUFg=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Richard Weinberger <richard@nod.at>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Wang Yong <wang.yong12@zte.com.cn>,
	Lu Zhongjun <lu.zhongjun@zte.com.cn>,
	Yang Tao <yang.tao172@zte.com.cn>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH resend 1/2] jffs2: initialize filesystem-private inode info in ->alloc_inode callback
Date: Fri, 30 May 2025 21:31:38 +0300
Message-ID: <20250530183141.222155-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530183141.222155-1-pchelkin@ispras.ru>
References: <20250530183141.222155-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The symlink body (->target) should be freed at the same time as the inode
itself per commit 4fdcfab5b553 ("jffs2: fix use-after-free on symlink
traversal"). It is a filesystem-specific field but there exist several
error paths during generic inode allocation when ->free_inode(), namely
jffs2_free_inode(), is called with still uninitialized private info.

The calltrace looks like:
 alloc_inode
  inode_init_always // fails
   i_callback
    free_inode
    jffs2_free_inode // touches uninit ->target field

Commit af9a8730ddb6 ("jffs2: Fix potential illegal address access in
jffs2_free_inode") approached the observed problem but fixed it only
partially. Our local Syzkaller instance is still hitting these kinds of
failures.

The thing is that jffs2_i_init_once(), where the initialization of
f->target has been moved, is called once per slab allocation so it won't
be called for the object structure possibly retrieved later from the slab
cache for reuse.

The practice followed by many other filesystems is to initialize
filesystem-private inode contents in the corresponding ->alloc_inode()
callbacks. This also allows to drop initialization from jffs2_iget() and
jffs2_new_inode() as ->alloc_inode() is called in those places.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 4fdcfab5b553 ("jffs2: fix use-after-free on symlink traversal")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/jffs2/fs.c    | 2 --
 fs/jffs2/super.c | 3 ++-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index d175cccb7c55..85c4b273918f 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -271,7 +271,6 @@ struct inode *jffs2_iget(struct super_block *sb, unsigned long ino)
 	f = JFFS2_INODE_INFO(inode);
 	c = JFFS2_SB_INFO(inode->i_sb);
 
-	jffs2_init_inode_info(f);
 	mutex_lock(&f->sem);
 
 	ret = jffs2_do_read_inode(c, f, inode->i_ino, &latest_node);
@@ -439,7 +438,6 @@ struct inode *jffs2_new_inode (struct inode *dir_i, umode_t mode, struct jffs2_r
 		return ERR_PTR(-ENOMEM);
 
 	f = JFFS2_INODE_INFO(inode);
-	jffs2_init_inode_info(f);
 	mutex_lock(&f->sem);
 
 	memset(ri, 0, sizeof(*ri));
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 4545f885c41e..b56ff63357f3 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -42,6 +42,8 @@ static struct inode *jffs2_alloc_inode(struct super_block *sb)
 	f = alloc_inode_sb(sb, jffs2_inode_cachep, GFP_KERNEL);
 	if (!f)
 		return NULL;
+
+	jffs2_init_inode_info(f);
 	return &f->vfs_inode;
 }
 
@@ -58,7 +60,6 @@ static void jffs2_i_init_once(void *foo)
 	struct jffs2_inode_info *f = foo;
 
 	mutex_init(&f->sem);
-	f->target = NULL;
 	inode_init_once(&f->vfs_inode);
 }
 
-- 
2.49.0


