Return-Path: <stable+bounces-178584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 727BEB47F41
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C7717FADF
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CD721ADAE;
	Sun,  7 Sep 2025 20:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QY818sQF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D781DF246;
	Sun,  7 Sep 2025 20:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757277303; cv=none; b=VWN/dzQn2GrAMxfWLUuxHEcJ6RUU5t8mxsFHFjyTlx1gr2+JkljIr+TB7YTxRuh+r6O49LzjHF+JuWrn1m0cDHpDRNePRJRASv9nTQ7AsdJqGjWTr+JjmoIB1GoeQLudJ2KiSqdZnBbKur25EiuicPR7lOlQWszCfovvEw0Bg/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757277303; c=relaxed/simple;
	bh=/2kg4pQ3bu1c9q3/jvngVWpQ9c++qRbKZr/DdJFBit0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r47wspEcX9o747HhKK+V+P4mq/Bq7b3oOQH7Gg1oSgnnJTLKCie12zsehBEXs6Pm5lWf8jKc9CnVODD1UV+D4U8AZ7HwlXL848lE+xll+btLqsYy9bekkBGSXq6cq6/UmIRuj1boOQwY/vzHc3hZJekoK/wwWxMPyL5CRzKQKBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QY818sQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8FAC4CEF0;
	Sun,  7 Sep 2025 20:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757277303;
	bh=/2kg4pQ3bu1c9q3/jvngVWpQ9c++qRbKZr/DdJFBit0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QY818sQFQpPkFtBc1PdBoGi9BgPA9xLsERL8KmaBZ7StrbLMCtaNNOLRZhduItr9G
	 rC90C4dpuu2sItUhqauG7k12Vcb4CK7IyvY+UUJbM+kG+b0WZyvE571JOjgOD/pxlY
	 GpyavQBaguNuR22FnWbuKpOcjjFLRBB6ifUPJpEw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mahesh Kumar <maheshkumar657g@gmail.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12 132/175] ext4: avoid journaling sb update on error if journal is destroying
Date: Sun,  7 Sep 2025 21:58:47 +0200
Message-ID: <20250907195617.977825024@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195614.892725141@linuxfoundation.org>
References: <20250907195614.892725141@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ojaswin Mujoo <ojaswin@linux.ibm.com>

commit ce2f26e73783b4a7c46a86e3af5b5c8de0971790 upstream.

Presently we always BUG_ON if trying to start a transaction on a journal marked
with JBD2_UNMOUNT, since this should never happen. However, while ltp running
stress tests, it was observed that in case of some error handling paths, it is
possible for update_super_work to start a transaction after the journal is
destroyed eg:

(umount)
ext4_kill_sb
  kill_block_super
    generic_shutdown_super
      sync_filesystem /* commits all txns */
      evict_inodes
        /* might start a new txn */
      ext4_put_super
	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
        jbd2_journal_destroy
          journal_kill_thread
            journal->j_flags |= JBD2_UNMOUNT;
          jbd2_journal_commit_transaction
            jbd2_journal_get_descriptor_buffer
              jbd2_journal_bmap
                ext4_journal_bmap
                  ext4_map_blocks
                    ...
                    ext4_inode_error
                      ext4_handle_error
                        schedule_work(&sbi->s_sb_upd_work)

                                               /* work queue kicks in */
                                               update_super_work
                                                 jbd2_journal_start
                                                   start_this_handle
                                                     BUG_ON(journal->j_flags &
                                                            JBD2_UNMOUNT)

Hence, introduce a new mount flag to indicate journal is destroying and only do
a journaled (and deferred) update of sb if this flag is not set. Otherwise, just
fallback to an un-journaled commit.

Further, in the journal destroy path, we have the following sequence:

  1. Set mount flag indicating journal is destroying
  2. force a commit and wait for it
  3. flush pending sb updates

This sequence is important as it ensures that, after this point, there is no sb
update that might be journaled so it is safe to update the sb outside the
journal. (To avoid race discussed in 2d01ddc86606)

Also, we don't need a similar check in ext4_grp_locked_error since it is only
called from mballoc and AFAICT it would be always valid to schedule work here.

Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/9613c465d6ff00cd315602f99283d5f24018c3f7.1742279837.git.ojaswin@linux.ibm.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/ext4.h      |    3 ++-
 fs/ext4/ext4_jbd2.h |   15 +++++++++++++++
 fs/ext4/super.c     |   16 ++++++++--------
 3 files changed, 25 insertions(+), 9 deletions(-)

--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1823,7 +1823,8 @@ static inline int ext4_valid_inum(struct
  */
 enum {
 	EXT4_MF_MNTDIR_SAMPLED,
-	EXT4_MF_FC_INELIGIBLE	/* Fast commit ineligible */
+	EXT4_MF_FC_INELIGIBLE,	/* Fast commit ineligible */
+	EXT4_MF_JOURNAL_DESTROY	/* Journal is in process of destroying */
 };
 
 static inline void ext4_set_mount_flag(struct super_block *sb, int bit)
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -521,6 +521,21 @@ static inline int ext4_journal_destroy(s
 {
 	int err = 0;
 
+	/*
+	 * At this point only two things can be operating on the journal.
+	 * JBD2 thread performing transaction commit and s_sb_upd_work
+	 * issuing sb update through the journal. Once we set
+	 * EXT4_JOURNAL_DESTROY, new ext4_handle_error() calls will not
+	 * queue s_sb_upd_work and ext4_force_commit() makes sure any
+	 * ext4_handle_error() calls from the running transaction commit are
+	 * finished. Hence no new s_sb_upd_work can be queued after we
+	 * flush it here.
+	 */
+	ext4_set_mount_flag(sbi->s_sb, EXT4_MF_JOURNAL_DESTROY);
+
+	ext4_force_commit(sbi->s_sb);
+	flush_work(&sbi->s_sb_upd_work);
+
 	err = jbd2_journal_destroy(journal);
 	sbi->s_journal = NULL;
 
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -719,9 +719,13 @@ static void ext4_handle_error(struct sup
 		 * In case the fs should keep running, we need to writeout
 		 * superblock through the journal. Due to lock ordering
 		 * constraints, it may not be safe to do it right here so we
-		 * defer superblock flushing to a workqueue.
+		 * defer superblock flushing to a workqueue. We just need to be
+		 * careful when the journal is already shutting down. If we get
+		 * here in that case, just update the sb directly as the last
+		 * transaction won't commit anyway.
 		 */
-		if (continue_fs && journal)
+		if (continue_fs && journal &&
+		    !ext4_test_mount_flag(sb, EXT4_MF_JOURNAL_DESTROY))
 			schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
 		else
 			ext4_commit_super(sb);
@@ -1306,7 +1310,6 @@ static void ext4_put_super(struct super_
 	ext4_unregister_li_request(sb);
 	ext4_quotas_off(sb, EXT4_MAXQUOTAS);
 
-	flush_work(&sbi->s_sb_upd_work);
 	destroy_workqueue(sbi->rsv_conversion_wq);
 	ext4_release_orphan_info(sb);
 
@@ -1316,7 +1319,8 @@ static void ext4_put_super(struct super_
 		if ((err < 0) && !aborted) {
 			ext4_abort(sb, -err, "Couldn't clean up the journal");
 		}
-	}
+	} else
+		flush_work(&sbi->s_sb_upd_work);
 
 	ext4_es_unregister_shrinker(sbi);
 	timer_shutdown_sync(&sbi->s_err_report);
@@ -4954,8 +4958,6 @@ static int ext4_load_and_init_journal(st
 	return 0;
 
 out:
-	/* flush s_sb_upd_work before destroying the journal. */
-	flush_work(&sbi->s_sb_upd_work);
 	ext4_journal_destroy(sbi, sbi->s_journal);
 	return -EINVAL;
 }
@@ -5645,8 +5647,6 @@ failed_mount_wq:
 	sbi->s_ea_block_cache = NULL;
 
 	if (sbi->s_journal) {
-		/* flush s_sb_upd_work before journal destroy. */
-		flush_work(&sbi->s_sb_upd_work);
 		ext4_journal_destroy(sbi, sbi->s_journal);
 	}
 failed_mount3a:



