Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBB57E2320
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjKFNJD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjKFNJD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:09:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2A191
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:08:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3180AC433C9;
        Mon,  6 Nov 2023 13:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276139;
        bh=dnAs7t+sxqDgTqskZxvQacBEQk9bft/EJ4pIc3oDTcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MLXo7xSQ1OBXsCD1J9SKzBStvqQHAF75+ugOCO51ZfZPUowxnSxAtlXu12TnDJL9a
         ISVAmI6DYQY29vWmeThRIiRK7RZadGl+jVB6u9carXP83OKo+5I5PjGcXNYDXSe6mM
         IpbMVNTEtl2blNXeWQLb8plfeO+Yqt197bI40wOY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.6 07/30] eventfs: Delete eventfs_inode when the last dentry is freed
Date:   Mon,  6 Nov 2023 14:03:25 +0100
Message-ID: <20231106130258.186326482@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130257.903265688@linuxfoundation.org>
References: <20231106130257.903265688@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

commit 020010fbfa202aa528a52743eba4ab0da3400a4e upstream

There exists a race between holding a reference of an eventfs_inode dentry
and the freeing of the eventfs_inode. If user space has a dentry held long
enough, it may still be able to access the dentry's eventfs_inode after it
has been freed.

To prevent this, have he eventfs_inode freed via the last dput() (or via
RCU if the eventfs_inode does not have a dentry).

This means reintroducing the eventfs_inode del_list field at a temporary
place to put the eventfs_inode. It needs to mark it as freed (via the
list) but also must invalidate the dentry immediately as the return from
eventfs_remove_dir() expects that they are. But the dentry invalidation
must not be called under the eventfs_mutex, so it must be done after the
eventfs_inode is marked as free (put on a deletion list).

Link: https://lkml.kernel.org/r/20231101172650.123479767@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ajay Kaher <akaher@vmware.com>
Fixes: 5bdcd5f5331a2 ("eventfs: Implement removal of meta data from eventfs")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/tracefs/event_inode.c |  150 +++++++++++++++++++++++------------------------
 1 file changed, 74 insertions(+), 76 deletions(-)

--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -53,10 +53,12 @@ struct eventfs_file {
 	const struct inode_operations	*iop;
 	/*
 	 * Union - used for deletion
+	 * @llist:	for calling dput() if needed after RCU
 	 * @del_list:	list of eventfs_file to delete
 	 * @rcu:	eventfs_file to delete in RCU
 	 */
 	union {
+		struct llist_node	llist;
 		struct list_head	del_list;
 		struct rcu_head		rcu;
 	};
@@ -113,8 +115,7 @@ static int eventfs_set_attr(struct mnt_i
 
 	mutex_lock(&eventfs_mutex);
 	ef = dentry->d_fsdata;
-	/* The LSB is set when the eventfs_inode is being freed */
-	if (((unsigned long)ef & 1UL) || ef->is_freed) {
+	if (ef->is_freed) {
 		/* Do not allow changes if the event is about to be removed. */
 		mutex_unlock(&eventfs_mutex);
 		return -ENODEV;
@@ -258,6 +259,13 @@ static struct dentry *create_dir(struct
 	return eventfs_end_creating(dentry);
 }
 
+static void free_ef(struct eventfs_file *ef)
+{
+	kfree(ef->name);
+	kfree(ef->ei);
+	kfree(ef);
+}
+
 /**
  * eventfs_set_ef_status_free - set the ef->status to free
  * @ti: the tracefs_inode of the dentry
@@ -270,34 +278,20 @@ void eventfs_set_ef_status_free(struct t
 {
 	struct tracefs_inode *ti_parent;
 	struct eventfs_inode *ei;
-	struct eventfs_file *ef, *tmp;
+	struct eventfs_file *ef;
 
 	/* The top level events directory may be freed by this */
 	if (unlikely(ti->flags & TRACEFS_EVENT_TOP_INODE)) {
-		LIST_HEAD(ef_del_list);
-
 		mutex_lock(&eventfs_mutex);
-
 		ei = ti->private;
 
-		/* Record all the top level files */
-		list_for_each_entry_srcu(ef, &ei->e_top_files, list,
-					 lockdep_is_held(&eventfs_mutex)) {
-			list_add_tail(&ef->del_list, &ef_del_list);
-		}
-
 		/* Nothing should access this, but just in case! */
 		ti->private = NULL;
-
 		mutex_unlock(&eventfs_mutex);
 
-		/* Now safely free the top level files and their children */
-		list_for_each_entry_safe(ef, tmp, &ef_del_list, del_list) {
-			list_del(&ef->del_list);
-			eventfs_remove(ef);
-		}
-
-		kfree(ei);
+		ef = dentry->d_fsdata;
+		if (ef)
+			free_ef(ef);
 		return;
 	}
 
@@ -311,16 +305,13 @@ void eventfs_set_ef_status_free(struct t
 	if (!ef)
 		goto out;
 
-	/*
-	 * If ef was freed, then the LSB bit is set for d_fsdata.
-	 * But this should not happen, as it should still have a
-	 * ref count that prevents it. Warn in case it does.
-	 */
-	if (WARN_ON_ONCE((unsigned long)ef & 1))
-		goto out;
+	if (ef->is_freed) {
+		free_ef(ef);
+	} else {
+		ef->dentry = NULL;
+	}
 
 	dentry->d_fsdata = NULL;
-	ef->dentry = NULL;
 out:
 	mutex_unlock(&eventfs_mutex);
 }
@@ -847,13 +838,53 @@ int eventfs_add_file(const char *name, u
 	return 0;
 }
 
-static void free_ef(struct rcu_head *head)
+static LLIST_HEAD(free_list);
+
+static void eventfs_workfn(struct work_struct *work)
+{
+        struct eventfs_file *ef, *tmp;
+        struct llist_node *llnode;
+
+	llnode = llist_del_all(&free_list);
+        llist_for_each_entry_safe(ef, tmp, llnode, llist) {
+		/* This should only get here if it had a dentry */
+		if (!WARN_ON_ONCE(!ef->dentry))
+			dput(ef->dentry);
+        }
+}
+
+static DECLARE_WORK(eventfs_work, eventfs_workfn);
+
+static void free_rcu_ef(struct rcu_head *head)
 {
 	struct eventfs_file *ef = container_of(head, struct eventfs_file, rcu);
 
-	kfree(ef->name);
-	kfree(ef->ei);
-	kfree(ef);
+	if (ef->dentry) {
+		/* Do not free the ef until all references of dentry are gone */
+		if (llist_add(&ef->llist, &free_list))
+			queue_work(system_unbound_wq, &eventfs_work);
+		return;
+	}
+
+	free_ef(ef);
+}
+
+static void unhook_dentry(struct dentry *dentry)
+{
+	if (!dentry)
+		return;
+
+	/* Keep the dentry from being freed yet (see eventfs_workfn()) */
+	dget(dentry);
+
+	dentry->d_fsdata = NULL;
+	d_invalidate(dentry);
+	mutex_lock(&eventfs_mutex);
+	/* dentry should now have at least a single reference */
+	WARN_ONCE((int)d_count(dentry) < 1,
+		  "dentry %px (%s) less than one reference (%d) after invalidate\n",
+		  dentry, dentry->d_name.name, d_count(dentry));
+	mutex_unlock(&eventfs_mutex);
 }
 
 /**
@@ -905,58 +936,25 @@ void eventfs_remove(struct eventfs_file
 {
 	struct eventfs_file *tmp;
 	LIST_HEAD(ef_del_list);
-	struct dentry *dentry_list = NULL;
-	struct dentry *dentry;
 
 	if (!ef)
 		return;
 
+	/*
+	 * Move the deleted eventfs_inodes onto the ei_del_list
+	 * which will also set the is_freed value. Note, this has to be
+	 * done under the eventfs_mutex, but the deletions of
+	 * the dentries must be done outside the eventfs_mutex.
+	 * Hence moving them to this temporary list.
+	 */
 	mutex_lock(&eventfs_mutex);
 	eventfs_remove_rec(ef, &ef_del_list, 0);
-	list_for_each_entry_safe(ef, tmp, &ef_del_list, del_list) {
-		if (ef->dentry) {
-			unsigned long ptr = (unsigned long)dentry_list;
-
-			/* Keep the dentry from being freed yet */
-			dget(ef->dentry);
-
-			/*
-			 * Paranoid: The dget() above should prevent the dentry
-			 * from being freed and calling eventfs_set_ef_status_free().
-			 * But just in case, set the link list LSB pointer to 1
-			 * and have eventfs_set_ef_status_free() check that to
-			 * make sure that if it does happen, it will not think
-			 * the d_fsdata is an event_file.
-			 *
-			 * For this to work, no event_file should be allocated
-			 * on a odd space, as the ef should always be allocated
-			 * to be at least word aligned. Check for that too.
-			 */
-			WARN_ON_ONCE(ptr & 1);
-
-			ef->dentry->d_fsdata = (void *)(ptr | 1);
-			dentry_list = ef->dentry;
-			ef->dentry = NULL;
-		}
-		call_srcu(&eventfs_srcu, &ef->rcu, free_ef);
-	}
 	mutex_unlock(&eventfs_mutex);
 
-	while (dentry_list) {
-		unsigned long ptr;
-
-		dentry = dentry_list;
-		ptr = (unsigned long)dentry->d_fsdata & ~1UL;
-		dentry_list = (struct dentry *)ptr;
-		dentry->d_fsdata = NULL;
-		d_invalidate(dentry);
-		mutex_lock(&eventfs_mutex);
-		/* dentry should now have at least a single reference */
-		WARN_ONCE((int)d_count(dentry) < 1,
-			  "dentry %p less than one reference (%d) after invalidate\n",
-			  dentry, d_count(dentry));
-		mutex_unlock(&eventfs_mutex);
-		dput(dentry);
+	list_for_each_entry_safe(ef, tmp, &ef_del_list, del_list) {
+		unhook_dentry(ef->dentry);
+		list_del(&ef->del_list);
+		call_srcu(&eventfs_srcu, &ef->rcu, free_rcu_ef);
 	}
 }
 


