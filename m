Return-Path: <stable+bounces-21389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E1C85C8B2
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B381F21EEE
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D47151CF0;
	Tue, 20 Feb 2024 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PvK6O7TD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214F4151CD8;
	Tue, 20 Feb 2024 21:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708464270; cv=none; b=p+K0kok01aiBnhJ5ie/WaINzn88BxkcGWi60kDwz9f8sitxe90xpLevyXV7O6KBp9Ziwtci9gPiT6AcxEBKJPXampbYN75wv5TPXUw31PfAIuesw7KHNXwEVIMh6wGY12qtVhS3R3ZN0v8q5UidLNw9WDE9AXXLpK9KztRpQHok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708464270; c=relaxed/simple;
	bh=qZYtjgAt/DZ6sYzOfw8Kx1vfrmrqqUO1sxUfMzInKjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VaIEO7kLCHA/8fh+fZBIFNM/Uze+6PYnQ+mTMfKM+tVHb0/pdOZncZBr6QIulzWtksrafP9c40RV3vUDWkv8LBxYxfm6tQIHJkcDOImQv32LgDaZvzD6tiCkdtWzVIlLOV67wOJTMk2PY3WpFJVfK9WnWa6q0TH/jIdlOldEjmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PvK6O7TD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D32C43399;
	Tue, 20 Feb 2024 21:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708464269;
	bh=qZYtjgAt/DZ6sYzOfw8Kx1vfrmrqqUO1sxUfMzInKjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PvK6O7TD11FJEGnsYG4ho4IZvWY6fwcBxH3C7bIsTmm3GSru1F275FjXB1c3xDSx5
	 hxP5n2facFOhLxpP6kYFqgfsQkkDmm9Qflf1SzMZ3ApglKI75oCitoPZ7bRGFP2K+h
	 5jcJisHckAFnf8IeH7CD5URDsy5MzbZY+qEuq5VA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ajay Kaher <akaher@vmware.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.6 276/331] eventfs: Save ownership and mode
Date: Tue, 20 Feb 2024 21:56:32 +0100
Message-ID: <20240220205646.571314096@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220205637.572693592@linuxfoundation.org>
References: <20240220205637.572693592@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

commit 28e12c09f5aa081b2d13d1340e3610070b6c624d upstream.

Now that inodes and dentries are created on the fly, they are also
reclaimed on memory pressure. Since the ownership and file mode are saved
in the inode, if they are freed, any changes to the ownership and mode
will be lost.

To counter this, if the user changes the permissions or ownership, save
them, and when creating the inodes again, restore those changes.

Link: https://lkml.kernel.org/r/20231101172649.691841445@goodmis.org

Cc: stable@vger.kernel.org
Cc: Ajay Kaher <akaher@vmware.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 63940449555e7 ("eventfs: Implement eventfs lookup, read, open functions")
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/tracefs/event_inode.c |  148 ++++++++++++++++++++++++++++++++++++++++++-----
 fs/tracefs/internal.h    |   16 +++++
 2 files changed, 151 insertions(+), 13 deletions(-)

--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -40,6 +40,15 @@ static DEFINE_MUTEX(eventfs_mutex);
  */
 DEFINE_STATIC_SRCU(eventfs_srcu);
 
+/* Mode is unsigned short, use the upper bits for flags */
+enum {
+	EVENTFS_SAVE_MODE	= BIT(16),
+	EVENTFS_SAVE_UID	= BIT(17),
+	EVENTFS_SAVE_GID	= BIT(18),
+};
+
+#define EVENTFS_MODE_MASK	(EVENTFS_SAVE_MODE - 1)
+
 static struct dentry *eventfs_root_lookup(struct inode *dir,
 					  struct dentry *dentry,
 					  unsigned int flags);
@@ -47,8 +56,89 @@ static int dcache_dir_open_wrapper(struc
 static int dcache_readdir_wrapper(struct file *file, struct dir_context *ctx);
 static int eventfs_release(struct inode *inode, struct file *file);
 
+static void update_attr(struct eventfs_attr *attr, struct iattr *iattr)
+{
+	unsigned int ia_valid = iattr->ia_valid;
+
+	if (ia_valid & ATTR_MODE) {
+		attr->mode = (attr->mode & ~EVENTFS_MODE_MASK) |
+			(iattr->ia_mode & EVENTFS_MODE_MASK) |
+			EVENTFS_SAVE_MODE;
+	}
+	if (ia_valid & ATTR_UID) {
+		attr->mode |= EVENTFS_SAVE_UID;
+		attr->uid = iattr->ia_uid;
+	}
+	if (ia_valid & ATTR_GID) {
+		attr->mode |= EVENTFS_SAVE_GID;
+		attr->gid = iattr->ia_gid;
+	}
+}
+
+static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
+			    struct iattr *iattr)
+{
+	const struct eventfs_entry *entry;
+	struct eventfs_inode *ei;
+	const char *name;
+	int ret;
+
+	mutex_lock(&eventfs_mutex);
+	ei = dentry->d_fsdata;
+	/* The LSB is set when the eventfs_inode is being freed */
+	if (((unsigned long)ei & 1UL) || ei->is_freed) {
+		/* Do not allow changes if the event is about to be removed. */
+		mutex_unlock(&eventfs_mutex);
+		return -ENODEV;
+	}
+
+	/* Preallocate the children mode array if necessary */
+	if (!(dentry->d_inode->i_mode & S_IFDIR)) {
+		if (!ei->entry_attrs) {
+			ei->entry_attrs = kzalloc(sizeof(*ei->entry_attrs) * ei->nr_entries,
+						  GFP_KERNEL);
+			if (!ei->entry_attrs) {
+				ret = -ENOMEM;
+				goto out;
+			}
+		}
+	}
+
+	ret = simple_setattr(idmap, dentry, iattr);
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * If this is a dir, then update the ei cache, only the file
+	 * mode is saved in the ei->m_children, and the ownership is
+	 * determined by the parent directory.
+	 */
+	if (dentry->d_inode->i_mode & S_IFDIR) {
+		update_attr(&ei->attr, iattr);
+
+	} else {
+		name = dentry->d_name.name;
+
+		for (int i = 0; i < ei->nr_entries; i++) {
+			entry = &ei->entries[i];
+			if (strcmp(name, entry->name) == 0) {
+				update_attr(&ei->entry_attrs[i], iattr);
+				break;
+			}
+		}
+	}
+ out:
+	mutex_unlock(&eventfs_mutex);
+	return ret;
+}
+
 static const struct inode_operations eventfs_root_dir_inode_operations = {
 	.lookup		= eventfs_root_lookup,
+	.setattr	= eventfs_set_attr,
+};
+
+static const struct inode_operations eventfs_file_inode_operations = {
+	.setattr	= eventfs_set_attr,
 };
 
 static const struct file_operations eventfs_file_operations = {
@@ -59,10 +149,30 @@ static const struct file_operations even
 	.release	= eventfs_release,
 };
 
+static void update_inode_attr(struct inode *inode, struct eventfs_attr *attr, umode_t mode)
+{
+	if (!attr) {
+		inode->i_mode = mode;
+		return;
+	}
+
+	if (attr->mode & EVENTFS_SAVE_MODE)
+		inode->i_mode = attr->mode & EVENTFS_MODE_MASK;
+	else
+		inode->i_mode = mode;
+
+	if (attr->mode & EVENTFS_SAVE_UID)
+		inode->i_uid = attr->uid;
+
+	if (attr->mode & EVENTFS_SAVE_GID)
+		inode->i_gid = attr->gid;
+}
+
 /**
  * create_file - create a file in the tracefs filesystem
  * @name: the name of the file to create.
  * @mode: the permission that the file should have.
+ * @attr: saved attributes changed by user
  * @parent: parent dentry for this file.
  * @data: something that the caller will want to get to later on.
  * @fop: struct file_operations that should be used for this file.
@@ -72,6 +182,7 @@ static const struct file_operations even
  * call.
  */
 static struct dentry *create_file(const char *name, umode_t mode,
+				  struct eventfs_attr *attr,
 				  struct dentry *parent, void *data,
 				  const struct file_operations *fop)
 {
@@ -95,7 +206,10 @@ static struct dentry *create_file(const
 	if (unlikely(!inode))
 		return eventfs_failed_creating(dentry);
 
-	inode->i_mode = mode;
+	/* If the user updated the directory's attributes, use them */
+	update_inode_attr(inode, attr, mode);
+
+	inode->i_op = &eventfs_file_inode_operations;
 	inode->i_fop = fop;
 	inode->i_private = data;
 
@@ -108,19 +222,19 @@ static struct dentry *create_file(const
 
 /**
  * create_dir - create a dir in the tracefs filesystem
- * @name: the name of the file to create.
+ * @ei: the eventfs_inode that represents the directory to create
  * @parent: parent dentry for this file.
  *
  * This function will create a dentry for a directory represented by
  * a eventfs_inode.
  */
-static struct dentry *create_dir(const char *name, struct dentry *parent)
+static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent)
 {
 	struct tracefs_inode *ti;
 	struct dentry *dentry;
 	struct inode *inode;
 
-	dentry = eventfs_start_creating(name, parent);
+	dentry = eventfs_start_creating(ei->name, parent);
 	if (IS_ERR(dentry))
 		return dentry;
 
@@ -128,7 +242,9 @@ static struct dentry *create_dir(const c
 	if (unlikely(!inode))
 		return eventfs_failed_creating(dentry);
 
-	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+	/* If the user updated the directory's attributes, use them */
+	update_inode_attr(inode, &ei->attr, S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO);
+
 	inode->i_op = &eventfs_root_dir_inode_operations;
 	inode->i_fop = &eventfs_file_operations;
 
@@ -146,6 +262,7 @@ static void free_ei(struct eventfs_inode
 {
 	kfree_const(ei->name);
 	kfree(ei->d_children);
+	kfree(ei->entry_attrs);
 	kfree(ei);
 }
 
@@ -231,7 +348,7 @@ void eventfs_set_ei_status_free(struct t
 /**
  * create_file_dentry - create a dentry for a file of an eventfs_inode
  * @ei: the eventfs_inode that the file will be created under
- * @e_dentry: a pointer to the d_children[] of the @ei
+ * @idx: the index into the d_children[] of the @ei
  * @parent: The parent dentry of the created file.
  * @name: The name of the file to create
  * @mode: The mode of the file.
@@ -244,10 +361,12 @@ void eventfs_set_ei_status_free(struct t
  * just do a dget() on it and return. Otherwise create the dentry and attach it.
  */
 static struct dentry *
-create_file_dentry(struct eventfs_inode *ei, struct dentry **e_dentry,
+create_file_dentry(struct eventfs_inode *ei, int idx,
 		   struct dentry *parent, const char *name, umode_t mode, void *data,
 		   const struct file_operations *fops, bool lookup)
 {
+	struct eventfs_attr *attr = NULL;
+	struct dentry **e_dentry = &ei->d_children[idx];
 	struct dentry *dentry;
 	bool invalidate = false;
 
@@ -264,13 +383,18 @@ create_file_dentry(struct eventfs_inode
 		mutex_unlock(&eventfs_mutex);
 		return *e_dentry;
 	}
+
+	/* ei->entry_attrs are protected by SRCU */
+	if (ei->entry_attrs)
+		attr = &ei->entry_attrs[idx];
+
 	mutex_unlock(&eventfs_mutex);
 
 	/* The lookup already has the parent->d_inode locked */
 	if (!lookup)
 		inode_lock(parent->d_inode);
 
-	dentry = create_file(name, mode, parent, data, fops);
+	dentry = create_file(name, mode, attr, parent, data, fops);
 
 	if (!lookup)
 		inode_unlock(parent->d_inode);
@@ -378,7 +502,7 @@ create_dir_dentry(struct eventfs_inode *
 	if (!lookup)
 		inode_lock(parent->d_inode);
 
-	dentry = create_dir(ei->name, parent);
+	dentry = create_dir(ei, parent);
 
 	if (!lookup)
 		inode_unlock(parent->d_inode);
@@ -495,8 +619,7 @@ static struct dentry *eventfs_root_looku
 			if (r <= 0)
 				continue;
 			ret = simple_lookup(dir, dentry, flags);
-			create_file_dentry(ei, &ei->d_children[i],
-					   ei_dentry, name, mode, cdata,
+			create_file_dentry(ei, i, ei_dentry, name, mode, cdata,
 					   fops, true);
 			break;
 		}
@@ -629,8 +752,7 @@ static int dcache_dir_open_wrapper(struc
 		r = entry->callback(name, &mode, &cdata, &fops);
 		if (r <= 0)
 			continue;
-		d = create_file_dentry(ei, &ei->d_children[i],
-				       parent, name, mode, cdata, fops, false);
+		d = create_file_dentry(ei, i, parent, name, mode, cdata, fops, false);
 		if (d) {
 			ret = add_dentries(&dentries, d, cnt);
 			if (ret < 0)
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -14,6 +14,18 @@ struct tracefs_inode {
 };
 
 /*
+ * struct eventfs_attr - cache the mode and ownership of a eventfs entry
+ * @mode:	saved mode plus flags of what is saved
+ * @uid:	saved uid if changed
+ * @gid:	saved gid if changed
+ */
+struct eventfs_attr {
+	int				mode;
+	kuid_t				uid;
+	kgid_t				gid;
+};
+
+/*
  * struct eventfs_inode - hold the properties of the eventfs directories.
  * @list:	link list into the parent directory
  * @entries:	the array of entries representing the files in the directory
@@ -22,6 +34,8 @@ struct tracefs_inode {
  * @dentry:     the dentry of the directory
  * @d_parent:   pointer to the parent's dentry
  * @d_children: The array of dentries to represent the files when created
+ * @entry_attrs: Saved mode and ownership of the @d_children
+ * @attr:	Saved mode and ownership of eventfs_inode itself
  * @data:	The private data to pass to the callbacks
  * @is_freed:	Flag set if the eventfs is on its way to be freed
  *                Note if is_freed is set, then dentry is corrupted.
@@ -35,6 +49,8 @@ struct eventfs_inode {
 	struct dentry			*dentry; /* Check is_freed to access */
 	struct dentry			*d_parent;
 	struct dentry			**d_children;
+	struct eventfs_attr		*entry_attrs;
+	struct eventfs_attr		attr;
 	void				*data;
 	/*
 	 * Union - used for deletion



