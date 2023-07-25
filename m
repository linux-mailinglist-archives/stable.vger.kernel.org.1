Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8083A7616F0
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbjGYLnv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbjGYLnS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:43:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202CB212B
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:42:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FE4E616B9
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBA8C433C7;
        Tue, 25 Jul 2023 11:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285347;
        bh=x8i/cMqqPdk8x0DQXZN7QHViFeaZNDPqeadNO64hUnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SFZ9vSmhY+l9RzbbFMlSQxw2uBVyl+BhtwUJyR838EdECZ+3Hcs1hhzYd7F2YNRP/
         MX9ixVxAUeSBxd3CS8jl3uX3CvP1BCygt9KVPNBFJs15m3XqCi3LR5Vgh4PM1uXUoY
         d+BXH1lBgBNjCrNfVgQXHyLFZQfwoUgeT73mKFtE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 5.4 173/313] fs: Lock moved directories
Date:   Tue, 25 Jul 2023 12:45:26 +0200
Message-ID: <20230725104528.436342513@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jan Kara <jack@suse.cz>

commit 28eceeda130f5058074dd007d9c59d2e8bc5af2e upstream.

When a directory is moved to a different directory, some filesystems
(udf, ext4, ocfs2, f2fs, and likely gfs2, reiserfs, and others) need to
update their pointer to the parent and this must not race with other
operations on the directory. Lock the directories when they are moved.
Although not all filesystems need this locking, we perform it in
vfs_rename() because getting the lock ordering right is really difficult
and we don't want to expose these locking details to filesystems.

CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
Message-Id: <20230601105830.13168-5-jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/filesystems/directory-locking.rst |   26 ++++++++++++------------
 fs/namei.c                                      |   22 ++++++++++++--------
 2 files changed, 28 insertions(+), 20 deletions(-)

--- a/Documentation/filesystems/directory-locking.rst
+++ b/Documentation/filesystems/directory-locking.rst
@@ -22,12 +22,11 @@ exclusive.
 3) object removal.  Locking rules: caller locks parent, finds victim,
 locks victim and calls the method.  Locks are exclusive.
 
-4) rename() that is _not_ cross-directory.  Locking rules: caller locks
-the parent and finds source and target.  In case of exchange (with
-RENAME_EXCHANGE in flags argument) lock both.  In any case,
-if the target already exists, lock it.  If the source is a non-directory,
-lock it.  If we need to lock both, lock them in inode pointer order.
-Then call the method.  All locks are exclusive.
+4) rename() that is _not_ cross-directory.  Locking rules: caller locks the
+parent and finds source and target.  We lock both (provided they exist).  If we
+need to lock two inodes of different type (dir vs non-dir), we lock directory
+first.  If we need to lock two inodes of the same type, lock them in inode
+pointer order.  Then call the method.  All locks are exclusive.
 NB: we might get away with locking the the source (and target in exchange
 case) shared.
 
@@ -44,15 +43,17 @@ All locks are exclusive.
 rules:
 
 	* lock the filesystem
-	* lock parents in "ancestors first" order.
+	* lock parents in "ancestors first" order. If one is not ancestor of
+	  the other, lock them in inode pointer order.
 	* find source and target.
 	* if old parent is equal to or is a descendent of target
 	  fail with -ENOTEMPTY
 	* if new parent is equal to or is a descendent of source
 	  fail with -ELOOP
-	* If it's an exchange, lock both the source and the target.
-	* If the target exists, lock it.  If the source is a non-directory,
-	  lock it.  If we need to lock both, do so in inode pointer order.
+	* Lock both the source and the target provided they exist. If we
+	  need to lock two inodes of different type (dir vs non-dir), we lock
+	  the directory first. If we need to lock two inodes of the same type,
+	  lock them in inode pointer order.
 	* call the method.
 
 All ->i_rwsem are taken exclusive.  Again, we might get away with locking
@@ -66,8 +67,9 @@ If no directory is its own ancestor, the
 
 Proof:
 
-	First of all, at any moment we have a partial ordering of the
-	objects - A < B iff A is an ancestor of B.
+	First of all, at any moment we have a linear ordering of the
+	objects - A < B iff (A is an ancestor of B) or (B is not an ancestor
+        of A and ptr(A) < ptr(B)).
 
 	That ordering can change.  However, the following is true:
 
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4367,7 +4367,7 @@ SYSCALL_DEFINE2(link, const char __user
  *	   sb->s_vfs_rename_mutex. We might be more accurate, but that's another
  *	   story.
  *	c) we have to lock _four_ objects - parents and victim (if it exists),
- *	   and source (if it is not a directory).
+ *	   and source.
  *	   And that - after we got ->i_mutex on parents (until then we don't know
  *	   whether the target exists).  Solution: try to be smart with locking
  *	   order for inodes.  We rely on the fact that tree topology may change
@@ -4444,10 +4444,16 @@ int vfs_rename(struct inode *old_dir, st
 
 	take_dentry_name_snapshot(&old_name, old_dentry);
 	dget(new_dentry);
-	if (!is_dir || (flags & RENAME_EXCHANGE))
-		lock_two_nondirectories(source, target);
-	else if (target)
-		inode_lock(target);
+	/*
+	 * Lock all moved children. Moved directories may need to change parent
+	 * pointer so they need the lock to prevent against concurrent
+	 * directory changes moving parent pointer. For regular files we've
+	 * historically always done this. The lockdep locking subclasses are
+	 * somewhat arbitrary but RENAME_EXCHANGE in particular can swap
+	 * regular files and directories so it's difficult to tell which
+	 * subclasses to use.
+	 */
+	lock_two_inodes(source, target, I_MUTEX_NORMAL, I_MUTEX_NONDIR2);
 
 	error = -EBUSY;
 	if (is_local_mountpoint(old_dentry) || is_local_mountpoint(new_dentry))
@@ -4491,9 +4497,9 @@ int vfs_rename(struct inode *old_dir, st
 			d_exchange(old_dentry, new_dentry);
 	}
 out:
-	if (!is_dir || (flags & RENAME_EXCHANGE))
-		unlock_two_nondirectories(source, target);
-	else if (target)
+	if (source)
+		inode_unlock(source);
+	if (target)
 		inode_unlock(target);
 	dput(new_dentry);
 	if (!error) {


