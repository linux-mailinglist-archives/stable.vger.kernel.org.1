Return-Path: <stable+bounces-161047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FA6AFD320
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37B4A176941
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4A38F5E;
	Tue,  8 Jul 2025 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KABz33j8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278D22DFA22;
	Tue,  8 Jul 2025 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993443; cv=none; b=N2oETJs6lCGzArFxJIP0z1lM2KCnWmYW7rNc9nynfAOkDVO2zJOPXG9U5tMEYmlNwMknLrscEoTshomuf1cx/HokjcoF0N1HklTWx/R5Md73cFijUCb7xqJU8Xel//AkHaFPtVRvsQXQshB65rHTkfzN4ZnFm9t5maYGRCUktbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993443; c=relaxed/simple;
	bh=tV+mMAAWlvRD/3fESGFsOqpiTy09Oo2JwT4McET0OoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAoB5CqjIgO0mEY73C9j9RDIRIVkYdoPj7+Ziih9YLI70i0TQdytbhQDkVtR3FiRdKcLO8TQ+7JMmYCbb6a4Wuu4P/3BN4zFN1usqViSVjHpx2xDeVmcVICKnrOS5ftL4xh/+aFz8nOn5A4RXHnJFcn+74PIS6nwFgFSBqzi44A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KABz33j8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F66C4CEED;
	Tue,  8 Jul 2025 16:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993443;
	bh=tV+mMAAWlvRD/3fESGFsOqpiTy09Oo2JwT4McET0OoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KABz33j8qcjdAP+d3Tvs1UDpCFuI9X5npgzrKxHLHf7dUEtNqpSrUML4r0gm5ywdY
	 WtEQ85cdiaJKcYOu3F9+KpfXQCkk6Bel+ioaruHvBGwsJPG+pnRW9SAEMYvaZrSfUt
	 glmHAjOBrFWBof3fFPXMVfDs5saIZOQAYli+E1ME=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shivank Garg <shivankg@amd.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 046/178] fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypass
Date: Tue,  8 Jul 2025 18:21:23 +0200
Message-ID: <20250708162237.889805541@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
References: <20250708162236.549307806@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shivank Garg <shivankg@amd.com>

[ Upstream commit cbe4134ea4bc493239786220bd69cb8a13493190 ]

Export anon_inode_make_secure_inode() to allow KVM guest_memfd to create
anonymous inodes with proper security context. This replaces the current
pattern of calling alloc_anon_inode() followed by
inode_init_security_anon() for creating security context manually.

This change also fixes a security regression in secretmem where the
S_PRIVATE flag was not cleared after alloc_anon_inode(), causing
LSM/SELinux checks to be bypassed for secretmem file descriptors.

As guest_memfd currently resides in the KVM module, we need to export this
symbol for use outside the core kernel. In the future, guest_memfd might be
moved to core-mm, at which point the symbols no longer would have to be
exported. When/if that happens is still unclear.

Fixes: 2bfe15c52612 ("mm: create security context for memfd_secret inodes")
Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Shivank Garg <shivankg@amd.com>
Link: https://lore.kernel.org/20250620070328.803704-3-shivankg@amd.com
Acked-by: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/anon_inodes.c   | 23 ++++++++++++++++++-----
 include/linux/fs.h |  2 ++
 mm/secretmem.c     |  9 +--------
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index e51e7d88980a2..1d847a939f29a 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -98,14 +98,25 @@ static struct file_system_type anon_inode_fs_type = {
 	.kill_sb	= kill_anon_super,
 };
 
-static struct inode *anon_inode_make_secure_inode(
-	const char *name,
-	const struct inode *context_inode)
+/**
+ * anon_inode_make_secure_inode - allocate an anonymous inode with security context
+ * @sb:		[in]	Superblock to allocate from
+ * @name:	[in]	Name of the class of the newfile (e.g., "secretmem")
+ * @context_inode:
+ *		[in]	Optional parent inode for security inheritance
+ *
+ * The function ensures proper security initialization through the LSM hook
+ * security_inode_init_security_anon().
+ *
+ * Return:	Pointer to new inode on success, ERR_PTR on failure.
+ */
+struct inode *anon_inode_make_secure_inode(struct super_block *sb, const char *name,
+					   const struct inode *context_inode)
 {
 	struct inode *inode;
 	int error;
 
-	inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
+	inode = alloc_anon_inode(sb);
 	if (IS_ERR(inode))
 		return inode;
 	inode->i_flags &= ~S_PRIVATE;
@@ -118,6 +129,7 @@ static struct inode *anon_inode_make_secure_inode(
 	}
 	return inode;
 }
+EXPORT_SYMBOL_GPL_FOR_MODULES(anon_inode_make_secure_inode, "kvm");
 
 static struct file *__anon_inode_getfile(const char *name,
 					 const struct file_operations *fops,
@@ -132,7 +144,8 @@ static struct file *__anon_inode_getfile(const char *name,
 		return ERR_PTR(-ENOENT);
 
 	if (make_inode) {
-		inode =	anon_inode_make_secure_inode(name, context_inode);
+		inode =	anon_inode_make_secure_inode(anon_inode_mnt->mnt_sb,
+						     name, context_inode);
 		if (IS_ERR(inode)) {
 			file = ERR_CAST(inode);
 			goto err;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ef41a8213a6fa..1fe7bf10d442c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3552,6 +3552,8 @@ extern int simple_write_begin(struct file *file, struct address_space *mapping,
 extern const struct address_space_operations ram_aops;
 extern int always_delete_dentry(const struct dentry *);
 extern struct inode *alloc_anon_inode(struct super_block *);
+struct inode *anon_inode_make_secure_inode(struct super_block *sb, const char *name,
+					   const struct inode *context_inode);
 extern int simple_nosetlease(struct file *, int, struct file_lease **, void **);
 extern const struct dentry_operations simple_dentry_operations;
 
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 1b0a214ee5580..4662f2510ae5f 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -195,18 +195,11 @@ static struct file *secretmem_file_create(unsigned long flags)
 	struct file *file;
 	struct inode *inode;
 	const char *anon_name = "[secretmem]";
-	int err;
 
-	inode = alloc_anon_inode(secretmem_mnt->mnt_sb);
+	inode = anon_inode_make_secure_inode(secretmem_mnt->mnt_sb, anon_name, NULL);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-	err = security_inode_init_security_anon(inode, &QSTR(anon_name), NULL);
-	if (err) {
-		file = ERR_PTR(err);
-		goto err_free_inode;
-	}
-
 	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
 				 O_RDWR, &secretmem_fops);
 	if (IS_ERR(file))
-- 
2.39.5




