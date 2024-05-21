Return-Path: <stable+bounces-45504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 999018CAE51
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 14:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3848C1F23AE1
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 12:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E43B770E4;
	Tue, 21 May 2024 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="R+pT4Fys"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495967641B;
	Tue, 21 May 2024 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716294646; cv=none; b=r1Ru564hf1Wqme6mLMbrnRXAs+oli6Wbn1keUDFmgTr8S1IJ1JwrhWJA1JXXT8DopOiYIbqlM48lNkCxiv24njs/CDQ7rId19l1HWYpCIgpWP/bDBmdj5c0XyUqT4RrPVh1hxBVCdYHVVOFCrOYO6sJ0k+w9H42lTV6u1FYnwjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716294646; c=relaxed/simple;
	bh=Li4W/+yXNqvCUJAgYsUZZdfWI0AWWai5MEvNGUE7iS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bKldejCtP0T7aK/AvGt3dF55LD2RM6XyH/Z8mxkxARYgCXYsz4ikV7wAmKp0ni8sFKRsklqx6VZo39RaRcaVvgiCyict3iOG5Ce4AUYB5AqszRAFWTh4jHIGIg5hQsccNdOBebaPWkz53xKv1xmoPQ2DDop7MRaWK8N6iysC/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=R+pT4Fys; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id B758C14C2DB;
	Tue, 21 May 2024 14:30:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1716294635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DVp6YCfajHs+yNWdfKMUPIPzz9c0Xk93q1PicjfZ4vY=;
	b=R+pT4FysZdDlHaYGG7L5deFEpB/UlAFZCZeqyRZyQvei+WEf8azLbh6hgfkKUkvfrhIHCh
	Kjt0MJiV2OsO+glAXRuT7dtk/C5TsVVPZXsruYwpu94CZTDOM1OCfnhW9QlHCBzI7l4fMk
	ngnklRnV6phwGh9is3T9T8/wFmjYm+rg+dbk4zEHNRxF6KuqNP9gzrQ9ivHrUOtY+Ck4QU
	swtgkh6y7Q4o49ZnuVtVQ1+nsWefkIdVMoqV5EG+I2iQXny2NtGfcxhg+T4Gzz0x/BRzZU
	814E+mjFJI8epx1o+R9jeTzrFEImBBxCQKAA2Mi7ipeuFURY9I92SntV0gyllw==
Received: from gaia.codewreck.org (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 9ee2cc6c;
	Tue, 21 May 2024 12:30:28 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Greg Kurz <groug@kaod.org>,
	Jianyong Wu <jianyong.wu@arm.com>
Cc: stable@vger.kernel.org,
	Eric Van Hensbergen <ericvh@gmail.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] 9p: add missing locking around taking dentry fid list
Date: Tue, 21 May 2024 21:29:46 +0900
Message-ID: <20240521122947.1080227-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a use-after-free on dentry's d_fsdata fid list when a thread
lookups a fid through dentry while another thread unlinks it:

UAF thread:
refcount_t: addition on 0; use-after-free.
 p9_fid_get linux/./include/net/9p/client.h:262
 v9fs_fid_find+0x236/0x280 linux/fs/9p/fid.c:129
 v9fs_fid_lookup_with_uid linux/fs/9p/fid.c:181
 v9fs_fid_lookup+0xbf/0xc20 linux/fs/9p/fid.c:314
 v9fs_vfs_getattr_dotl+0xf9/0x360 linux/fs/9p/vfs_inode_dotl.c:400
 vfs_statx+0xdd/0x4d0 linux/fs/stat.c:248

Freed by:
 p9_client_clunk+0xb0/0xe0 linux/net/9p/client.c:1456
 p9_fid_put linux/./include/net/9p/client.h:278
 v9fs_dentry_release+0xb5/0x140 linux/fs/9p/vfs_dentry.c:55
 v9fs_remove+0x38f/0x620 linux/fs/9p/vfs_inode.c:518
 vfs_unlink+0x29a/0x810 linux/fs/namei.c:4335

The problem is that d_fsdata was not accessed under d_lock, because
d_release() normally is only called once the dentry is otherwise no
longer accessible but since we also call it explicitly in v9fs_remove
that lock is required:
move the hlist out of the dentry under lock then unref its fids once
they are no longer accessible.

Fixes: 154372e67d40 ("fs/9p: fix create-unlink-getattr idiom")
Cc: stable@vger.kernel.org
Reported-by: Meysam Firouzi
Reported-by: Amirmohammad Eftekhar
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 fs/9p/vfs_dentry.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index f16f73581634..01338d4c2d9e 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -48,12 +48,17 @@ static int v9fs_cached_dentry_delete(const struct dentry *dentry)
 static void v9fs_dentry_release(struct dentry *dentry)
 {
 	struct hlist_node *p, *n;
+	struct hlist_head head;
 
 	p9_debug(P9_DEBUG_VFS, " dentry: %pd (%p)\n",
 		 dentry, dentry);
-	hlist_for_each_safe(p, n, (struct hlist_head *)&dentry->d_fsdata)
+
+	spin_lock(&dentry->d_lock);
+	hlist_move_list((struct hlist_head *)&dentry->d_fsdata, &head);
+	spin_unlock(&dentry->d_lock);
+
+	hlist_for_each_safe(p, n, &head)
 		p9_fid_put(hlist_entry(p, struct p9_fid, dlist));
-	dentry->d_fsdata = NULL;
 }
 
 static int v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
-- 
2.44.0


