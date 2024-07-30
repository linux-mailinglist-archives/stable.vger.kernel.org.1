Return-Path: <stable+bounces-62855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996099415E7
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC8928342C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 15:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D291B5837;
	Tue, 30 Jul 2024 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vK5KOcp6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D3329A2;
	Tue, 30 Jul 2024 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354854; cv=none; b=GEgsJi9axoWY34Ox8RABy08xausNZOKlSsahAAsx3CWEztnZ883f5XqNAhGMYBEh7irXqAywaM/zowF1B/scfTjOsX+fTZ2XF/wn2ViIk8TLN3wyuObmUGvD0QxYXNqeeFMX2SKzhUaVwpD+uE/RFdq7ctN9Dfp1dyGkC1HB6+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354854; c=relaxed/simple;
	bh=oo4kLDYN4D1RQ2Oj1p7AahjNaphgsaqIKPD8d2ptGEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xggw6aMPiUZpwMYEADU09GSJiKLKWiEggR6eX8G/DPFlf2pK1hDb0GPJn4vQ10430FmBDkL5KWXtiJn/ieg/t8Fqky050ou3cqkqa2bvbU/K5/kW7a6NZt4T6CPhlnSGy+sWQ9U9FQVzr4/aOmMiMbM8ojri7RI7gZ+LwrINnA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vK5KOcp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2304C32782;
	Tue, 30 Jul 2024 15:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722354854;
	bh=oo4kLDYN4D1RQ2Oj1p7AahjNaphgsaqIKPD8d2ptGEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vK5KOcp6WylpT6aC7JVCa1Lsbw+WhQeBTZVV2iNlJt56rzgqjeErIf7Ir1zscTyfI
	 yDLKccr4OfVGiGa/2eMgfBP91VXFnoWXKI3He35X/4cT5gR9x4GRSrUmPmQTEdFCuj
	 NGRXA7FWdN9ahZGOzrDvAA6x0rn/uNQ1PBl/cOZI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 017/440] kernfs: fix all kernel-doc warnings and multiple typos
Date: Tue, 30 Jul 2024 17:44:10 +0200
Message-ID: <20240730151616.436485926@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 24b3e3dd9c9c742a4dd18e71b6963f9e7ab72911 ]

Fix kernel-doc warnings. Many of these are about a function's
return value, so use the kernel-doc Return: format to fix those

Use % prefix on numeric constant values.

dir.c: fix typos/spellos
file.c fix typo: s/taret/target/

Fix all of these kernel-doc warnings:

dir.c:305: warning: missing initial short description on line:
 *      kernfs_name_hash

dir.c:137: warning: No description found for return value of 'kernfs_path_from_node_locked'
dir.c:196: warning: No description found for return value of 'kernfs_name'
dir.c:224: warning: No description found for return value of 'kernfs_path_from_node'
dir.c:292: warning: No description found for return value of 'kernfs_get_parent'
dir.c:312: warning: No description found for return value of 'kernfs_name_hash'
dir.c:404: warning: No description found for return value of 'kernfs_unlink_sibling'
dir.c:588: warning: No description found for return value of 'kernfs_node_from_dentry'
dir.c:806: warning: No description found for return value of 'kernfs_find_ns'
dir.c:879: warning: No description found for return value of 'kernfs_find_and_get_ns'
dir.c:904: warning: No description found for return value of 'kernfs_walk_and_get_ns'
dir.c:927: warning: No description found for return value of 'kernfs_create_root'
dir.c:996: warning: No description found for return value of 'kernfs_root_to_node'
dir.c:1016: warning: No description found for return value of 'kernfs_create_dir_ns'
dir.c:1048: warning: No description found for return value of 'kernfs_create_empty_dir'
dir.c:1306: warning: No description found for return value of 'kernfs_next_descendant_post'
dir.c:1568: warning: No description found for return value of 'kernfs_remove_self'
dir.c:1630: warning: No description found for return value of 'kernfs_remove_by_name_ns'
dir.c:1667: warning: No description found for return value of 'kernfs_rename_ns'

file.c:66: warning: No description found for return value of 'of_on'
file.c:88: warning: No description found for return value of 'kernfs_deref_open_node_locked'
file.c:1036: warning: No description found for return value of '__kernfs_create_file'

inode.c:100: warning: No description found for return value of 'kernfs_setattr'

mount.c:160: warning: No description found for return value of 'kernfs_root_from_sb'
mount.c:198: warning: No description found for return value of 'kernfs_node_dentry'
mount.c:302: warning: No description found for return value of 'kernfs_super_ns'
mount.c:318: warning: No description found for return value of 'kernfs_get_tree'

symlink.c:28: warning: No description found for return value of 'kernfs_create_link'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tejun Heo <tj@kernel.org>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20221112031456.22980-1-rdunlap@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 1be59c97c83c ("cgroup/cpuset: Prevent UAF in proc_cpuset_show()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/kernfs/dir.c             | 82 ++++++++++++++++++++++---------------
 fs/kernfs/file.c            | 18 ++++----
 fs/kernfs/inode.c           |  8 ++--
 fs/kernfs/kernfs-internal.h |  2 +-
 fs/kernfs/mount.c           | 10 +++--
 fs/kernfs/symlink.c         |  2 +-
 6 files changed, 74 insertions(+), 48 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index a00e11ebfa775..44b907874fba1 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -125,9 +125,9 @@ static struct kernfs_node *kernfs_common_ancestor(struct kernfs_node *a,
  * kn_to:   /n1/n2/n3         [depth=3]
  * result:  /../..
  *
- * [3] when @kn_to is NULL result will be "(null)"
+ * [3] when @kn_to is %NULL result will be "(null)"
  *
- * Returns the length of the full path.  If the full length is equal to or
+ * Return: the length of the full path.  If the full length is equal to or
  * greater than @buflen, @buf contains the truncated path with the trailing
  * '\0'.  On error, -errno is returned.
  */
@@ -185,10 +185,12 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
  * @buflen: size of @buf
  *
  * Copies the name of @kn into @buf of @buflen bytes.  The behavior is
- * similar to strlcpy().  It returns the length of @kn's name and if @buf
- * isn't long enough, it's filled upto @buflen-1 and nul terminated.
+ * similar to strlcpy().
  *
- * Fills buffer with "(null)" if @kn is NULL.
+ * Fills buffer with "(null)" if @kn is %NULL.
+ *
+ * Return: the length of @kn's name and if @buf isn't long enough,
+ * it's filled up to @buflen-1 and nul terminated.
  *
  * This function can be called from any context.
  */
@@ -215,7 +217,7 @@ int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
  * path (which includes '..'s) as needed to reach from @from to @to is
  * returned.
  *
- * Returns the length of the full path.  If the full length is equal to or
+ * Return: the length of the full path.  If the full length is equal to or
  * greater than @buflen, @buf contains the truncated path with the trailing
  * '\0'.  On error, -errno is returned.
  */
@@ -287,6 +289,8 @@ void pr_cont_kernfs_path(struct kernfs_node *kn)
  *
  * Determines @kn's parent, pins and returns it.  This function can be
  * called from any context.
+ *
+ * Return: parent node of @kn
  */
 struct kernfs_node *kernfs_get_parent(struct kernfs_node *kn)
 {
@@ -302,11 +306,11 @@ struct kernfs_node *kernfs_get_parent(struct kernfs_node *kn)
 }
 
 /**
- *	kernfs_name_hash
+ *	kernfs_name_hash - calculate hash of @ns + @name
  *	@name: Null terminated string to hash
  *	@ns:   Namespace tag to hash
  *
- *	Returns 31 bit hash of ns + name (so it fits in an off_t )
+ *	Return: 31-bit hash of ns + name (so it fits in an off_t)
  */
 static unsigned int kernfs_name_hash(const char *name, const void *ns)
 {
@@ -354,8 +358,8 @@ static int kernfs_sd_compare(const struct kernfs_node *left,
  *	Locking:
  *	kernfs_rwsem held exclusive
  *
- *	RETURNS:
- *	0 on susccess -EEXIST on failure.
+ *	Return:
+ *	%0 on success, -EEXIST on failure.
  */
 static int kernfs_link_sibling(struct kernfs_node *kn)
 {
@@ -394,8 +398,10 @@ static int kernfs_link_sibling(struct kernfs_node *kn)
  *	@kn: kernfs_node of interest
  *
  *	Try to unlink @kn from its sibling rbtree which starts from
- *	kn->parent->dir.children.  Returns %true if @kn was actually
- *	removed, %false if @kn wasn't on the rbtree.
+ *	kn->parent->dir.children.
+ *
+ *	Return: %true if @kn was actually removed,
+ *	%false if @kn wasn't on the rbtree.
  *
  *	Locking:
  *	kernfs_rwsem held exclusive
@@ -419,10 +425,10 @@ static bool kernfs_unlink_sibling(struct kernfs_node *kn)
  *	@kn: kernfs_node to get an active reference to
  *
  *	Get an active reference of @kn.  This function is noop if @kn
- *	is NULL.
+ *	is %NULL.
  *
- *	RETURNS:
- *	Pointer to @kn on success, NULL on failure.
+ *	Return:
+ *	Pointer to @kn on success, %NULL on failure.
  */
 struct kernfs_node *kernfs_get_active(struct kernfs_node *kn)
 {
@@ -442,7 +448,7 @@ struct kernfs_node *kernfs_get_active(struct kernfs_node *kn)
  *	@kn: kernfs_node to put an active reference to
  *
  *	Put an active reference to @kn.  This function is noop if @kn
- *	is NULL.
+ *	is %NULL.
  */
 void kernfs_put_active(struct kernfs_node *kn)
 {
@@ -464,7 +470,7 @@ void kernfs_put_active(struct kernfs_node *kn)
  * kernfs_drain - drain kernfs_node
  * @kn: kernfs_node to drain
  *
- * Drain existing usages and nuke all existing mmaps of @kn.  Mutiple
+ * Drain existing usages and nuke all existing mmaps of @kn.  Multiple
  * removers may invoke this function concurrently on @kn and all will
  * return after draining is complete.
  */
@@ -577,7 +583,7 @@ EXPORT_SYMBOL_GPL(kernfs_put);
  * kernfs_node_from_dentry - determine kernfs_node associated with a dentry
  * @dentry: the dentry in question
  *
- * Return the kernfs_node associated with @dentry.  If @dentry is not a
+ * Return: the kernfs_node associated with @dentry.  If @dentry is not a
  * kernfs one, %NULL is returned.
  *
  * While the returned kernfs_node will stay accessible as long as @dentry
@@ -698,8 +704,8 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
  * @id's lower 32bits encode ino and upper gen.  If the gen portion is
  * zero, all generations are matched.
  *
- * RETURNS:
- * NULL on failure. Return a kernfs node with reference counter incremented
+ * Return: %NULL on failure,
+ * otherwise a kernfs node with reference counter incremented.
  */
 struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 						   u64 id)
@@ -747,8 +753,8 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
  *	function increments nlink of the parent's inode if @kn is a
  *	directory and link into the children list of the parent.
  *
- *	RETURNS:
- *	0 on success, -EEXIST if entry with the given name already
+ *	Return:
+ *	%0 on success, -EEXIST if entry with the given name already
  *	exists.
  */
 int kernfs_add_one(struct kernfs_node *kn)
@@ -811,8 +817,9 @@ int kernfs_add_one(struct kernfs_node *kn)
  * @name: name to look for
  * @ns: the namespace tag to use
  *
- * Look for kernfs_node with name @name under @parent.  Returns pointer to
- * the found kernfs_node on success, %NULL on failure.
+ * Look for kernfs_node with name @name under @parent.
+ *
+ * Return: pointer to the found kernfs_node on success, %NULL on failure.
  */
 static struct kernfs_node *kernfs_find_ns(struct kernfs_node *parent,
 					  const unsigned char *name,
@@ -885,8 +892,9 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
  * @ns: the namespace tag to use
  *
  * Look for kernfs_node with name @name under @parent and get a reference
- * if found.  This function may sleep and returns pointer to the found
- * kernfs_node on success, %NULL on failure.
+ * if found.  This function may sleep.
+ *
+ * Return: pointer to the found kernfs_node on success, %NULL on failure.
  */
 struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
 					   const char *name, const void *ns)
@@ -910,8 +918,9 @@ EXPORT_SYMBOL_GPL(kernfs_find_and_get_ns);
  * @ns: the namespace tag to use
  *
  * Look for kernfs_node with path @path under @parent and get a reference
- * if found.  This function may sleep and returns pointer to the found
- * kernfs_node on success, %NULL on failure.
+ * if found.  This function may sleep.
+ *
+ * Return: pointer to the found kernfs_node on success, %NULL on failure.
  */
 struct kernfs_node *kernfs_walk_and_get_ns(struct kernfs_node *parent,
 					   const char *path, const void *ns)
@@ -933,7 +942,7 @@ struct kernfs_node *kernfs_walk_and_get_ns(struct kernfs_node *parent,
  * @flags: KERNFS_ROOT_* flags
  * @priv: opaque data associated with the new directory
  *
- * Returns the root of the new hierarchy on success, ERR_PTR() value on
+ * Return: the root of the new hierarchy on success, ERR_PTR() value on
  * failure.
  */
 struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
@@ -1005,6 +1014,8 @@ void kernfs_destroy_root(struct kernfs_root *root)
 /**
  * kernfs_root_to_node - return the kernfs_node associated with a kernfs_root
  * @root: root to use to lookup
+ *
+ * Return: @root's kernfs_node
  */
 struct kernfs_node *kernfs_root_to_node(struct kernfs_root *root)
 {
@@ -1021,7 +1032,7 @@ struct kernfs_node *kernfs_root_to_node(struct kernfs_root *root)
  * @priv: opaque data associated with the new directory
  * @ns: optional namespace tag of the directory
  *
- * Returns the created node on success, ERR_PTR() value on failure.
+ * Return: the created node on success, ERR_PTR() value on failure.
  */
 struct kernfs_node *kernfs_create_dir_ns(struct kernfs_node *parent,
 					 const char *name, umode_t mode,
@@ -1055,7 +1066,7 @@ struct kernfs_node *kernfs_create_dir_ns(struct kernfs_node *parent,
  * @parent: parent in which to create a new directory
  * @name: name of the new directory
  *
- * Returns the created node on success, ERR_PTR() value on failure.
+ * Return: the created node on success, ERR_PTR() value on failure.
  */
 struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 					    const char *name)
@@ -1304,6 +1315,8 @@ static struct kernfs_node *kernfs_leftmost_descendant(struct kernfs_node *pos)
  * Find the next descendant to visit for post-order traversal of @root's
  * descendants.  @root is included in the iteration and the last node to be
  * visited.
+ *
+ * Return: the next descendant to visit or %NULL when done.
  */
 static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 						       struct kernfs_node *root)
@@ -1567,6 +1580,8 @@ void kernfs_unbreak_active_protection(struct kernfs_node *kn)
  * the whole kernfs_ops which won the arbitration.  This can be used to
  * guarantee, for example, all concurrent writes to a "delete" file to
  * finish only after the whole operation is complete.
+ *
+ * Return: %true if @kn is removed by this call, otherwise %false.
  */
 bool kernfs_remove_self(struct kernfs_node *kn)
 {
@@ -1627,7 +1642,8 @@ bool kernfs_remove_self(struct kernfs_node *kn)
  * @ns: namespace tag of the kernfs_node to remove
  *
  * Look for the kernfs_node with @name and @ns under @parent and remove it.
- * Returns 0 on success, -ENOENT if such entry doesn't exist.
+ *
+ * Return: %0 on success, -ENOENT if such entry doesn't exist.
  */
 int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 			     const void *ns)
@@ -1665,6 +1681,8 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
  * @new_parent: new parent to put @sd under
  * @new_name: new name
  * @new_ns: new namespace tag
+ *
+ * Return: %0 on success, -errno on failure.
  */
 int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 		     const char *new_name, const void *new_ns)
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 9ab6c92e02dab..e4a50e4ff0d23 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -33,7 +33,7 @@ struct kernfs_open_node {
  * pending queue is implemented as a singly linked list of kernfs_nodes.
  * The list is terminated with the self pointer so that whether a
  * kernfs_node is on the list or not can be determined by testing the next
- * pointer for NULL.
+ * pointer for %NULL.
  */
 #define KERNFS_NOTIFY_EOL			((void *)&kernfs_notify_list)
 
@@ -59,8 +59,10 @@ static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
 }
 
 /**
- * of_on - Return the kernfs_open_node of the specified kernfs_open_file
- * @of: taret kernfs_open_file
+ * of_on - Get the kernfs_open_node of the specified kernfs_open_file
+ * @of: target kernfs_open_file
+ *
+ * Return: the kernfs_open_node of the kernfs_open_file
  */
 static struct kernfs_open_node *of_on(struct kernfs_open_file *of)
 {
@@ -82,6 +84,8 @@ static struct kernfs_open_node *of_on(struct kernfs_open_file *of)
  * outside RCU read-side critical section.
  *
  * The caller needs to make sure that kernfs_open_file_mutex is held.
+ *
+ * Return: @kn->attr.open when kernfs_open_file_mutex is held.
  */
 static struct kernfs_open_node *
 kernfs_deref_open_node_locked(struct kernfs_node *kn)
@@ -548,11 +552,11 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
  *	If @kn->attr.open exists, increment its reference count; otherwise,
  *	create one.  @of is chained to the files list.
  *
- *	LOCKING:
+ *	Locking:
  *	Kernel thread context (may sleep).
  *
- *	RETURNS:
- *	0 on success, -errno on failure.
+ *	Return:
+ *	%0 on success, -errno on failure.
  */
 static int kernfs_get_open_node(struct kernfs_node *kn,
 				struct kernfs_open_file *of)
@@ -1024,7 +1028,7 @@ const struct file_operations kernfs_file_fops = {
  * @ns: optional namespace tag of the file
  * @key: lockdep key for the file's active_ref, %NULL to disable lockdep
  *
- * Returns the created node on success, ERR_PTR() value on error.
+ * Return: the created node on success, ERR_PTR() value on error.
  */
 struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
 					 const char *name,
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 3d783d80f5daa..076ba9884916c 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -94,7 +94,7 @@ int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
  * @kn: target node
  * @iattr: iattr to set
  *
- * Returns 0 on success, -errno on failure.
+ * Return: %0 on success, -errno on failure.
  */
 int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 {
@@ -241,11 +241,11 @@ static void kernfs_init_inode(struct kernfs_node *kn, struct inode *inode)
  *	allocated and basics are initialized.  New inode is returned
  *	locked.
  *
- *	LOCKING:
+ *	Locking:
  *	Kernel thread context (may sleep).
  *
- *	RETURNS:
- *	Pointer to allocated inode on success, NULL on failure.
+ *	Return:
+ *	Pointer to allocated inode on success, %NULL on failure.
  */
 struct inode *kernfs_get_inode(struct super_block *sb, struct kernfs_node *kn)
 {
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index fc5821effd97d..9046d9f39e635 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -58,7 +58,7 @@ struct kernfs_root {
  * kernfs_root - find out the kernfs_root a kernfs_node belongs to
  * @kn: kernfs_node of interest
  *
- * Return the kernfs_root @kn belongs to.
+ * Return: the kernfs_root @kn belongs to.
  */
 static inline struct kernfs_root *kernfs_root(struct kernfs_node *kn)
 {
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index d0859f72d2d64..e08e8d9998070 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -153,7 +153,7 @@ static const struct export_operations kernfs_export_ops = {
  * kernfs_root_from_sb - determine kernfs_root associated with a super_block
  * @sb: the super_block in question
  *
- * Return the kernfs_root associated with @sb.  If @sb is not a kernfs one,
+ * Return: the kernfs_root associated with @sb.  If @sb is not a kernfs one,
  * %NULL is returned.
  */
 struct kernfs_root *kernfs_root_from_sb(struct super_block *sb)
@@ -167,7 +167,7 @@ struct kernfs_root *kernfs_root_from_sb(struct super_block *sb)
  * find the next ancestor in the path down to @child, where @parent was the
  * ancestor whose descendant we want to find.
  *
- * Say the path is /a/b/c/d.  @child is d, @parent is NULL.  We return the root
+ * Say the path is /a/b/c/d.  @child is d, @parent is %NULL.  We return the root
  * node.  If @parent is b, then we return the node for c.
  * Passing in d as @parent is not ok.
  */
@@ -192,6 +192,8 @@ static struct kernfs_node *find_next_ancestor(struct kernfs_node *child,
  * kernfs_node_dentry - get a dentry for the given kernfs_node
  * @kn: kernfs_node for which a dentry is needed
  * @sb: the kernfs super_block
+ *
+ * Return: the dentry pointer
  */
 struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 				  struct super_block *sb)
@@ -296,7 +298,7 @@ static int kernfs_set_super(struct super_block *sb, struct fs_context *fc)
  * kernfs_super_ns - determine the namespace tag of a kernfs super_block
  * @sb: super_block of interest
  *
- * Return the namespace tag associated with kernfs super_block @sb.
+ * Return: the namespace tag associated with kernfs super_block @sb.
  */
 const void *kernfs_super_ns(struct super_block *sb)
 {
@@ -313,6 +315,8 @@ const void *kernfs_super_ns(struct super_block *sb)
  * implementation, which should set the specified ->@fs_type and ->@flags, and
  * specify the hierarchy and namespace tag to mount via ->@root and ->@ns,
  * respectively.
+ *
+ * Return: %0 on success, -errno on failure.
  */
 int kernfs_get_tree(struct fs_context *fc)
 {
diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 0ab13824822f7..45371a70caa71 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -19,7 +19,7 @@
  * @name: name of the symlink
  * @target: target node for the symlink to point to
  *
- * Returns the created node on success, ERR_PTR() value on error.
+ * Return: the created node on success, ERR_PTR() value on error.
  * Ownership of the link matches ownership of the target.
  */
 struct kernfs_node *kernfs_create_link(struct kernfs_node *parent,
-- 
2.43.0




