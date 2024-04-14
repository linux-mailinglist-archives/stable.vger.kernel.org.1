Return-Path: <stable+bounces-37313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B9F89C455
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E728282757
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E9A7EEF3;
	Mon,  8 Apr 2024 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IWng+upz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6437E0E4;
	Mon,  8 Apr 2024 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583867; cv=none; b=nTFWjGcAj5Hy5EU2xqkcbxlvt5dZgumpWjSSu5wjZ9SsrK1kIywUqXzsp0asseJqqaQ4Gi8u0nSZT7F8LnEPvOcL//BgjJWkGmL8IGkeUv82dB22ZxjZWQ1lecX5mfGBcXqjPFKIX3yIuu78sdfV9FEyKJuo207h2LBzQAZIEus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583867; c=relaxed/simple;
	bh=+ox5GqGKewCeyaV5Bz4wuvw66mSmAQxO2eLX9ci48yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbEDXPeL7frurzm9NOhL+P2jZ8SB6pmQ8QhhQa3iLhCOcl8nnESTdCH+Mfakpcxxo245BoNVRUJwFGuDBn9NvD+eQQIJ3VwlH5egC9uUhUlqaui36FbSFuXPxSZXOxgsdxm6cmmx7pU7yF85hrweu1SOggTceAio23GDsKscTNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IWng+upz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B58C433C7;
	Mon,  8 Apr 2024 13:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583867;
	bh=+ox5GqGKewCeyaV5Bz4wuvw66mSmAQxO2eLX9ci48yI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IWng+upzuhFlskeTap8PAsFihX7+4vOis3kQusKU9Axd7uYu8oHR3ri8GBDxjmFWY
	 dSr/QHNZKKGPA5jYSRhYkOUI528LuDrCzfSO5u/QVjW3Tys2SBKet/YmSNjs0tH9rA
	 ApwC9muqNkO8wvPLD0HFlpiNj6FRJFhAlmo+pmss=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 297/690] fsnotify: allow adding an inode mark without pinning inode
Date: Mon,  8 Apr 2024 14:52:43 +0200
Message-ID: <20240408125410.374843136@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit c3638b5b13740fa31762d414bbce8b7a694e582a ]

fsnotify_add_mark() and variants implicitly take a reference on inode
when attaching a mark to an inode.

Make that behavior opt-out with the mark flag FSNOTIFY_MARK_FLAG_NO_IREF.

Instead of taking the inode reference when attaching connector to inode
and dropping the inode reference when detaching connector from inode,
take the inode reference on attach of the first mark that wants to hold
an inode reference and drop the inode reference on detach of the last
mark that wants to hold an inode reference.

Backends can "upgrade" an existing mark to take an inode reference, but
cannot "downgrade" a mark with inode reference to release the refernce.

This leaves the choice to the backend whether or not to pin the inode
when adding an inode mark.

This is intended to be used when adding a mark with ignored mask that is
used for optimization in cases where group can afford getting unneeded
events and reinstate the mark with ignored mask when inode is accessed
again after being evicted.

Link: https://lore.kernel.org/r/20220422120327.3459282-12-amir73il@gmail.com
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/notify/mark.c                 | 76 +++++++++++++++++++++++---------
 include/linux/fsnotify_backend.h |  2 +
 2 files changed, 58 insertions(+), 20 deletions(-)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 982ca2f20ff5d..c74ef947447d6 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -116,20 +116,64 @@ __u32 fsnotify_conn_mask(struct fsnotify_mark_connector *conn)
 	return *fsnotify_conn_mask_p(conn);
 }
 
-static void __fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
+static void fsnotify_get_inode_ref(struct inode *inode)
+{
+	ihold(inode);
+	atomic_long_inc(&inode->i_sb->s_fsnotify_connectors);
+}
+
+/*
+ * Grab or drop inode reference for the connector if needed.
+ *
+ * When it's time to drop the reference, we only clear the HAS_IREF flag and
+ * return the inode object. fsnotify_drop_object() will be resonsible for doing
+ * iput() outside of spinlocks. This happens when last mark that wanted iref is
+ * detached.
+ */
+static struct inode *fsnotify_update_iref(struct fsnotify_mark_connector *conn,
+					  bool want_iref)
+{
+	bool has_iref = conn->flags & FSNOTIFY_CONN_FLAG_HAS_IREF;
+	struct inode *inode = NULL;
+
+	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE ||
+	    want_iref == has_iref)
+		return NULL;
+
+	if (want_iref) {
+		/* Pin inode if any mark wants inode refcount held */
+		fsnotify_get_inode_ref(fsnotify_conn_inode(conn));
+		conn->flags |= FSNOTIFY_CONN_FLAG_HAS_IREF;
+	} else {
+		/* Unpin inode after detach of last mark that wanted iref */
+		inode = fsnotify_conn_inode(conn);
+		conn->flags &= ~FSNOTIFY_CONN_FLAG_HAS_IREF;
+	}
+
+	return inode;
+}
+
+static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 {
 	u32 new_mask = 0;
+	bool want_iref = false;
 	struct fsnotify_mark *mark;
 
 	assert_spin_locked(&conn->lock);
 	/* We can get detached connector here when inode is getting unlinked. */
 	if (!fsnotify_valid_obj_type(conn->type))
-		return;
+		return NULL;
 	hlist_for_each_entry(mark, &conn->list, obj_list) {
-		if (mark->flags & FSNOTIFY_MARK_FLAG_ATTACHED)
-			new_mask |= fsnotify_calc_mask(mark);
+		if (!(mark->flags & FSNOTIFY_MARK_FLAG_ATTACHED))
+			continue;
+		new_mask |= fsnotify_calc_mask(mark);
+		if (conn->type == FSNOTIFY_OBJ_TYPE_INODE &&
+		    !(mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF))
+			want_iref = true;
 	}
 	*fsnotify_conn_mask_p(conn) = new_mask;
+
+	return fsnotify_update_iref(conn, want_iref);
 }
 
 /*
@@ -169,12 +213,6 @@ static void fsnotify_connector_destroy_workfn(struct work_struct *work)
 	}
 }
 
-static void fsnotify_get_inode_ref(struct inode *inode)
-{
-	ihold(inode);
-	atomic_long_inc(&inode->i_sb->s_fsnotify_connectors);
-}
-
 static void fsnotify_put_inode_ref(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
@@ -213,6 +251,10 @@ static void *fsnotify_detach_connector_from_object(
 	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
 		inode = fsnotify_conn_inode(conn);
 		inode->i_fsnotify_mask = 0;
+
+		/* Unpin inode when detaching from connector */
+		if (!(conn->flags & FSNOTIFY_CONN_FLAG_HAS_IREF))
+			inode = NULL;
 	} else if (conn->type == FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
 		fsnotify_conn_mount(conn)->mnt_fsnotify_mask = 0;
 	} else if (conn->type == FSNOTIFY_OBJ_TYPE_SB) {
@@ -274,7 +316,8 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
 		objp = fsnotify_detach_connector_from_object(conn, &type);
 		free_conn = true;
 	} else {
-		__fsnotify_recalc_mask(conn);
+		objp = __fsnotify_recalc_mask(conn);
+		type = conn->type;
 	}
 	WRITE_ONCE(mark->connector, NULL);
 	spin_unlock(&conn->lock);
@@ -497,7 +540,6 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 					       unsigned int obj_type,
 					       __kernel_fsid_t *fsid)
 {
-	struct inode *inode = NULL;
 	struct fsnotify_mark_connector *conn;
 
 	conn = kmem_cache_alloc(fsnotify_mark_connector_cachep, GFP_KERNEL);
@@ -505,6 +547,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 		return -ENOMEM;
 	spin_lock_init(&conn->lock);
 	INIT_HLIST_HEAD(&conn->list);
+	conn->flags = 0;
 	conn->type = obj_type;
 	conn->obj = connp;
 	/* Cache fsid of filesystem containing the object */
@@ -515,10 +558,6 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 		conn->fsid.val[0] = conn->fsid.val[1] = 0;
 		conn->flags = 0;
 	}
-	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
-		inode = fsnotify_conn_inode(conn);
-		fsnotify_get_inode_ref(inode);
-	}
 	fsnotify_get_sb_connectors(conn);
 
 	/*
@@ -527,8 +566,6 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 	 */
 	if (cmpxchg(connp, NULL, conn)) {
 		/* Someone else created list structure for us */
-		if (inode)
-			fsnotify_put_inode_ref(inode);
 		fsnotify_put_sb_connectors(conn);
 		kmem_cache_free(fsnotify_mark_connector_cachep, conn);
 	}
@@ -690,8 +727,7 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 	if (ret)
 		goto err;
 
-	if (mark->mask || mark->ignored_mask)
-		fsnotify_recalc_mask(mark->connector);
+	fsnotify_recalc_mask(mark->connector);
 
 	return ret;
 err:
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index d62111e832440..9a1a9e78f69f5 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -456,6 +456,7 @@ struct fsnotify_mark_connector {
 	spinlock_t lock;
 	unsigned short type;	/* Type of object [lock] */
 #define FSNOTIFY_CONN_FLAG_HAS_FSID	0x01
+#define FSNOTIFY_CONN_FLAG_HAS_IREF	0x02
 	unsigned short flags;	/* flags [lock] */
 	__kernel_fsid_t fsid;	/* fsid of filesystem containing object */
 	union {
@@ -510,6 +511,7 @@ struct fsnotify_mark {
 #define FSNOTIFY_MARK_FLAG_IN_ONESHOT		0x0020
 	/* fanotify mark flags */
 #define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY	0x0100
+#define FSNOTIFY_MARK_FLAG_NO_IREF		0x0200
 	unsigned int flags;		/* flags [mark->lock] */
 };
 
-- 
2.43.0




