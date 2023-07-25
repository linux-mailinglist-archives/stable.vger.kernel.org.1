Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98187616E3
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjGYLoK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235424AbjGYLnc (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:43:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79392106
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:43:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D641616BE
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB47C433C8;
        Tue, 25 Jul 2023 11:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285344;
        bh=aHV1WXDUL34Uipx+rq8uhgs2jmfOliZwbdfJUjyUh4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yRxxiTE+zc99x+4hi+EBAx85RTGT11n71KpRKMNOEFEQK2gmaksZN0BCYdGmKfhG1
         TncSRpIfFCYfwlt/4DflfrZs7U+LxOL3WwwduHLtRpoIPTIuUu0H6EuIapwXXzugab
         OkwRB7CiLVh+o9warzpe62NO8MREhd2dkDNUktHQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 5.4 172/313] fs: Establish locking order for unrelated directories
Date:   Tue, 25 Jul 2023 12:45:25 +0200
Message-ID: <20230725104528.390217262@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jan Kara <jack@suse.cz>

commit f23ce757185319886ca80c4864ce5f81ac6cc9e9 upstream.

Currently the locking order of inode locks for directories that are not
in ancestor relationship is not defined because all operations that
needed to lock two directories like this were serialized by
sb->s_vfs_rename_mutex. However some filesystems need to lock two
subdirectories for RENAME_EXCHANGE operations and for this we need the
locking order established even for two tree-unrelated directories.
Provide a helper function lock_two_inodes() that establishes lock
ordering for any two inodes and use it in lock_two_directories().

CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
Message-Id: <20230601105830.13168-4-jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/inode.c    |   42 ++++++++++++++++++++++++++++++++++++++++++
 fs/internal.h |    2 ++
 fs/namei.c    |    4 ++--
 3 files changed, 46 insertions(+), 2 deletions(-)

--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1013,6 +1013,48 @@ void discard_new_inode(struct inode *ino
 EXPORT_SYMBOL(discard_new_inode);
 
 /**
+ * lock_two_inodes - lock two inodes (may be regular files but also dirs)
+ *
+ * Lock any non-NULL argument. The caller must make sure that if he is passing
+ * in two directories, one is not ancestor of the other.  Zero, one or two
+ * objects may be locked by this function.
+ *
+ * @inode1: first inode to lock
+ * @inode2: second inode to lock
+ * @subclass1: inode lock subclass for the first lock obtained
+ * @subclass2: inode lock subclass for the second lock obtained
+ */
+void lock_two_inodes(struct inode *inode1, struct inode *inode2,
+		     unsigned subclass1, unsigned subclass2)
+{
+	if (!inode1 || !inode2) {
+		/*
+		 * Make sure @subclass1 will be used for the acquired lock.
+		 * This is not strictly necessary (no current caller cares) but
+		 * let's keep things consistent.
+		 */
+		if (!inode1)
+			swap(inode1, inode2);
+		goto lock;
+	}
+
+	/*
+	 * If one object is directory and the other is not, we must make sure
+	 * to lock directory first as the other object may be its child.
+	 */
+	if (S_ISDIR(inode2->i_mode) == S_ISDIR(inode1->i_mode)) {
+		if (inode1 > inode2)
+			swap(inode1, inode2);
+	} else if (!S_ISDIR(inode1->i_mode))
+		swap(inode1, inode2);
+lock:
+	if (inode1)
+		inode_lock_nested(inode1, subclass1);
+	if (inode2 && inode2 != inode1)
+		inode_lock_nested(inode2, subclass2);
+}
+
+/**
  * lock_two_nondirectories - take two i_mutexes on non-directory objects
  *
  * Lock any non-NULL argument that is not a directory.
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -138,6 +138,8 @@ extern int vfs_open(const struct path *,
 extern long prune_icache_sb(struct super_block *sb, struct shrink_control *sc);
 extern void inode_add_lru(struct inode *inode);
 extern int dentry_needs_remove_privs(struct dentry *dentry);
+void lock_two_inodes(struct inode *inode1, struct inode *inode2,
+		     unsigned subclass1, unsigned subclass2);
 
 /*
  * fs-writeback.c
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2870,8 +2870,8 @@ struct dentry *lock_rename(struct dentry
 		return p;
 	}
 
-	inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
-	inode_lock_nested(p2->d_inode, I_MUTEX_PARENT2);
+	lock_two_inodes(p1->d_inode, p2->d_inode,
+			I_MUTEX_PARENT, I_MUTEX_PARENT2);
 	return NULL;
 }
 EXPORT_SYMBOL(lock_rename);


