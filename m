Return-Path: <stable+bounces-93704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2855B9D0540
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 19:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A981F218CC
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 18:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73F41DC046;
	Sun, 17 Nov 2024 18:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="K7IzjkwP"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B2F1DB366;
	Sun, 17 Nov 2024 18:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731869080; cv=none; b=ItMU0BHnNVLRLAhWyMBRT2q0R7q3jBFPuJnMPvaZIzg8IiPzY22eYjIhK1N+SXvMbeBkYYT8raJtZ+I4VmnxIk2MebD9ju9XOlwkM1I9DaLYn0P/5iII1JvAMK5W7HfLdGspAOZFhCpt9CEBpLlZuRbvt0ct2z9FLwTiwk9VjfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731869080; c=relaxed/simple;
	bh=xQww0AHembV1GDwFeMLbSDN+DhisvJ75fpAxcYvS27I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MwwrNahVYzDfgJMfbT88sIK+fmzpSLn60SdosMUc25GV6UdlPRK4vXk09Uhvan+Ed6Cf6jBWIKAHCsEe3RLStAdTJyxBaDOh3qPF3++18N2rIAvAK2K0hKM7Sbikuuhx+hEcoMcguJbkJOiwcJTYRHLwzk8JUK6V+fOvWUL4jTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=K7IzjkwP; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc.intra.ispras.ru (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id 8F1D1518E779;
	Sun, 17 Nov 2024 18:44:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8F1D1518E779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1731869068;
	bh=UizkzJsqxuNwf5Xw9wKym3zKbiu8RngTlGJwvHGM9ME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K7IzjkwP0LkE4kjgTpXFIHbAU72yRgqEC4jjxSmLHo0f6Q0NPCTTxlUecgl371fV+
	 qWvCGH+D72kmrt+iXhHtvzqAaMIkPRsDGE3jlqqPDJwhHvlYrwkh8dlQFvemSFOoyT
	 QcuWRgSIUhAOUkQfdsytKRrprCvz3uc69ANyGm8s=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	David Woodhouse <dwmw2@infradead.org>,
	Wang Yong <wang.yong12@zte.com.cn>,
	Lu Zhongjun <lu.zhongjun@zte.com.cn>,
	Yang Tao <yang.tao172@zte.com.cn>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] jffs2: initialize filesystem-private inode info in ->alloc_inode callback
Date: Sun, 17 Nov 2024 21:44:11 +0300
Message-Id: <20241117184412.366672-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241117184412.366672-1-pchelkin@ispras.ru>
References: <20241117184412.366672-1-pchelkin@ispras.ru>
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
2.39.5


