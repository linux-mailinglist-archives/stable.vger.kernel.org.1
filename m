Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85626FAD07
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbjEHLaW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbjEHLaE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:30:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BCCD05C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:29:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 750EF62EE2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63463C433EF;
        Mon,  8 May 2023 11:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545391;
        bh=gTFlwNTDbnyYDPAUWDCRZ34DnjHWc3QPnM19pvRr0YM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zAkd3bU7DYw3zmLNByRqbipzDfAUjPmHFq96TPZvRMLDLT165VXeptW/x+412sjF9
         oXiIeXfJBPok9kqu1vHItRyJmmA7XY1Qju4u3Qo6qn5rUC6zduzRIUeFmZJantjjEa
         idurrMlvzzsmjbGY6K2kwyRQH2YbZLwz2XT4Kc14=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 5.15 024/371] ext4: use ext4_journal_start/stop for fast commit transactions
Date:   Mon,  8 May 2023 11:43:45 +0200
Message-Id: <20230508094813.093213242@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

commit 2729cfdcfa1cc49bef5a90d046fa4a187fdfcc69 upstream.

This patch drops all calls to ext4_fc_start_update() and
ext4_fc_stop_update(). To ensure that there are no ongoing journal
updates during fast commit, we also make jbd2_fc_begin_commit() lock
journal for updates. This way we don't have to maintain two different
transaction start stop APIs for fast commit and full commit. This
patch doesn't remove the functions altogether since in future we want
to have inode level locking for fast commits.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Link: https://lore.kernel.org/r/20211223202140.2061101-2-harshads@google.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/acl.c     |    2 --
 fs/ext4/extents.c |    3 ---
 fs/ext4/file.c    |    4 ----
 fs/ext4/inode.c   |    7 +------
 fs/ext4/ioctl.c   |   10 +---------
 fs/jbd2/journal.c |    2 ++
 6 files changed, 4 insertions(+), 24 deletions(-)

--- a/fs/ext4/acl.c
+++ b/fs/ext4/acl.c
@@ -246,7 +246,6 @@ retry:
 	handle = ext4_journal_start(inode, EXT4_HT_XATTR, credits);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
-	ext4_fc_start_update(inode);
 
 	if ((type == ACL_TYPE_ACCESS) && acl) {
 		error = posix_acl_update_mode(mnt_userns, inode, &mode, &acl);
@@ -264,7 +263,6 @@ retry:
 	}
 out_stop:
 	ext4_journal_stop(handle);
-	ext4_fc_stop_update(inode);
 	if (error == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
 		goto retry;
 	return error;
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4701,8 +4701,6 @@ long ext4_fallocate(struct file *file, i
 		     FALLOC_FL_INSERT_RANGE))
 		return -EOPNOTSUPP;
 
-	ext4_fc_start_update(inode);
-
 	inode_lock(inode);
 	ret = ext4_convert_inline_data(inode);
 	inode_unlock(inode);
@@ -4772,7 +4770,6 @@ out:
 	inode_unlock(inode);
 	trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
 exit:
-	ext4_fc_stop_update(inode);
 	return ret;
 }
 
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -259,7 +259,6 @@ static ssize_t ext4_buffered_write_iter(
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		return -EOPNOTSUPP;
 
-	ext4_fc_start_update(inode);
 	inode_lock(inode);
 	ret = ext4_write_checks(iocb, from);
 	if (ret <= 0)
@@ -271,7 +270,6 @@ static ssize_t ext4_buffered_write_iter(
 
 out:
 	inode_unlock(inode);
-	ext4_fc_stop_update(inode);
 	if (likely(ret > 0)) {
 		iocb->ki_pos += ret;
 		ret = generic_write_sync(iocb, ret);
@@ -558,9 +556,7 @@ static ssize_t ext4_dio_write_iter(struc
 			goto out;
 		}
 
-		ext4_fc_start_update(inode);
 		ret = ext4_orphan_add(handle, inode);
-		ext4_fc_stop_update(inode);
 		if (ret) {
 			ext4_journal_stop(handle);
 			goto out;
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5366,7 +5366,7 @@ int ext4_setattr(struct user_namespace *
 		if (error)
 			return error;
 	}
-	ext4_fc_start_update(inode);
+
 	if ((ia_valid & ATTR_UID && !uid_eq(attr->ia_uid, inode->i_uid)) ||
 	    (ia_valid & ATTR_GID && !gid_eq(attr->ia_gid, inode->i_gid))) {
 		handle_t *handle;
@@ -5390,7 +5390,6 @@ int ext4_setattr(struct user_namespace *
 
 		if (error) {
 			ext4_journal_stop(handle);
-			ext4_fc_stop_update(inode);
 			return error;
 		}
 		/* Update corresponding info in inode so that everything is in
@@ -5402,7 +5401,6 @@ int ext4_setattr(struct user_namespace *
 		error = ext4_mark_inode_dirty(handle, inode);
 		ext4_journal_stop(handle);
 		if (unlikely(error)) {
-			ext4_fc_stop_update(inode);
 			return error;
 		}
 	}
@@ -5417,12 +5415,10 @@ int ext4_setattr(struct user_namespace *
 			struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 
 			if (attr->ia_size > sbi->s_bitmap_maxbytes) {
-				ext4_fc_stop_update(inode);
 				return -EFBIG;
 			}
 		}
 		if (!S_ISREG(inode->i_mode)) {
-			ext4_fc_stop_update(inode);
 			return -EINVAL;
 		}
 
@@ -5548,7 +5544,6 @@ err_out:
 		ext4_std_error(inode->i_sb, error);
 	if (!error)
 		error = rc;
-	ext4_fc_stop_update(inode);
 	return error;
 }
 
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -744,7 +744,6 @@ int ext4_fileattr_set(struct user_namesp
 	u32 flags = fa->flags;
 	int err = -EOPNOTSUPP;
 
-	ext4_fc_start_update(inode);
 	if (flags & ~EXT4_FL_USER_VISIBLE)
 		goto out;
 
@@ -765,7 +764,6 @@ int ext4_fileattr_set(struct user_namesp
 		goto out;
 	err = ext4_ioctl_setproject(inode, fa->fsx_projid);
 out:
-	ext4_fc_stop_update(inode);
 	return err;
 }
 
@@ -1272,13 +1270,7 @@ resizefs_out:
 
 long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
-	long ret;
-
-	ext4_fc_start_update(file_inode(filp));
-	ret = __ext4_ioctl(filp, cmd, arg);
-	ext4_fc_stop_update(file_inode(filp));
-
-	return ret;
+	return __ext4_ioctl(filp, cmd, arg);
 }
 
 #ifdef CONFIG_COMPAT
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -757,6 +757,7 @@ int jbd2_fc_begin_commit(journal_t *jour
 	}
 	journal->j_flags |= JBD2_FAST_COMMIT_ONGOING;
 	write_unlock(&journal->j_state_lock);
+	jbd2_journal_lock_updates(journal);
 
 	return 0;
 }
@@ -768,6 +769,7 @@ EXPORT_SYMBOL(jbd2_fc_begin_commit);
  */
 static int __jbd2_fc_end_commit(journal_t *journal, tid_t tid, bool fallback)
 {
+	jbd2_journal_unlock_updates(journal);
 	if (journal->j_fc_cleanup_callback)
 		journal->j_fc_cleanup_callback(journal, 0, tid);
 	write_lock(&journal->j_state_lock);


