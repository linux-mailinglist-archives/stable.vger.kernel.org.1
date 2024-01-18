Return-Path: <stable+bounces-11980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27B8831735
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 11:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235E41C223B0
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 10:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9AA23746;
	Thu, 18 Jan 2024 10:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BxrjQBfK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8E6219FC;
	Thu, 18 Jan 2024 10:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575271; cv=none; b=Y3duIhcI4HmTDHNlfK2t6yW73HGq7KzzdPMUP8k/jSJEJah7DYEvHGk5i9XkFxp4hFtd8DyBJ1qbD7GWSfgerzcLayT4tVKVUMVRlM/TCeijNC9z5qfUuWrDwHx0ezCXtFBjikDHt7bmiDdZnibMxLjB2G6rlDmag6lfI8mqi4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575271; c=relaxed/simple;
	bh=YYNx3cm/SirQ27otQPSLf2Sav6YDzlQht1nskqp9fKA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:User-Agent:X-stable:
	 X-Patchwork-Hint:MIME-Version:Content-Transfer-Encoding; b=mydqkO1KruF55WPLcyyNcRPQMCW5MaOo2qd5vNGIRQxJUaK0D4t/J5Lj2RKGIH5AMZKopFvljzeRfpTIeBwZoqFX2o8dCbeHnmAtUNDN3ah4P35e57uBd8aIl99fBkPZpq1YVzvBSmEgmny5s+X8pGoj9AXBH9dPLO2ZiPxfoHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BxrjQBfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5497C433F1;
	Thu, 18 Jan 2024 10:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705575271;
	bh=YYNx3cm/SirQ27otQPSLf2Sav6YDzlQht1nskqp9fKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BxrjQBfKtiYN7Iv/SEqBsXvr+s8xlu1R/QWzabwtoyG2hdMFtiZxyx3dYbB67Q0lI
	 Ic722Q/35nSoJS4DVgkn7KWLcYBZGh7W5HEpR3io9G9LsBuIOSSM2wH1QSYtRhZWPY
	 azKD/euMYnvj8ljuhgn5QOyxV485lYy/XEfCuxNY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 073/150] jbd2: increase the journal IOs priority
Date: Thu, 18 Jan 2024 11:48:15 +0100
Message-ID: <20240118104323.358805917@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118104320.029537060@linuxfoundation.org>
References: <20240118104320.029537060@linuxfoundation.org>
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

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 6a3afb6ac6dfab158ebdd4b87941178f58c8939f ]

Current jbd2 only add REQ_SYNC for descriptor block, metadata log
buffer, commit buffer and superblock buffer, the submitted IO could be
throttled by writeback throttle in block layer, that could lead to
priority inversion in some cases. The log IO looks like a kind of high
priority metadata IO, so it should not be throttled by WBT like QOS
policies in block layer, let's add REQ_SYNC | REQ_IDLE to exempt from
writeback throttle, and also add REQ_META together indicates it's a
metadata IO.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20231129114740.2686201-2-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/commit.c     |  9 +++++----
 fs/jbd2/journal.c    | 20 +++++++++++---------
 include/linux/jbd2.h |  3 +++
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 8d6f934c3d95..9bdb377a348f 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -119,7 +119,7 @@ static int journal_submit_commit_record(journal_t *journal,
 	struct commit_header *tmp;
 	struct buffer_head *bh;
 	struct timespec64 now;
-	blk_opf_t write_flags = REQ_OP_WRITE | REQ_SYNC;
+	blk_opf_t write_flags = REQ_OP_WRITE | JBD2_JOURNAL_REQ_FLAGS;
 
 	*cbh = NULL;
 
@@ -395,8 +395,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		 */
 		jbd2_journal_update_sb_log_tail(journal,
 						journal->j_tail_sequence,
-						journal->j_tail,
-						REQ_SYNC);
+						journal->j_tail, 0);
 		mutex_unlock(&journal->j_checkpoint_mutex);
 	} else {
 		jbd2_debug(3, "superblock not updated\n");
@@ -715,6 +714,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 
 			for (i = 0; i < bufs; i++) {
 				struct buffer_head *bh = wbuf[i];
+
 				/*
 				 * Compute checksum.
 				 */
@@ -727,7 +727,8 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 				clear_buffer_dirty(bh);
 				set_buffer_uptodate(bh);
 				bh->b_end_io = journal_end_buffer_io_sync;
-				submit_bh(REQ_OP_WRITE | REQ_SYNC, bh);
+				submit_bh(REQ_OP_WRITE | JBD2_JOURNAL_REQ_FLAGS,
+					  bh);
 			}
 			cond_resched();
 
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index e7aa47a02d4d..19c69229ac6e 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1100,8 +1100,7 @@ int __jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block)
 	 * space and if we lose sb update during power failure we'd replay
 	 * old transaction with possibly newly overwritten data.
 	 */
-	ret = jbd2_journal_update_sb_log_tail(journal, tid, block,
-					      REQ_SYNC | REQ_FUA);
+	ret = jbd2_journal_update_sb_log_tail(journal, tid, block, REQ_FUA);
 	if (ret)
 		goto out;
 
@@ -1768,8 +1767,7 @@ static int journal_reset(journal_t *journal)
 		 */
 		jbd2_journal_update_sb_log_tail(journal,
 						journal->j_tail_sequence,
-						journal->j_tail,
-						REQ_SYNC | REQ_FUA);
+						journal->j_tail, REQ_FUA);
 		mutex_unlock(&journal->j_checkpoint_mutex);
 	}
 	return jbd2_journal_start_thread(journal);
@@ -1791,6 +1789,11 @@ static int jbd2_write_superblock(journal_t *journal, blk_opf_t write_flags)
 		return -EIO;
 	}
 
+	/*
+	 * Always set high priority flags to exempt from block layer's
+	 * QOS policies, e.g. writeback throttle.
+	 */
+	write_flags |= JBD2_JOURNAL_REQ_FLAGS;
 	if (!(journal->j_flags & JBD2_BARRIER))
 		write_flags &= ~(REQ_FUA | REQ_PREFLUSH);
 
@@ -2045,7 +2048,7 @@ void jbd2_journal_update_sb_errno(journal_t *journal)
 	jbd2_debug(1, "JBD2: updating superblock error (errno %d)\n", errcode);
 	sb->s_errno    = cpu_to_be32(errcode);
 
-	jbd2_write_superblock(journal, REQ_SYNC | REQ_FUA);
+	jbd2_write_superblock(journal, REQ_FUA);
 }
 EXPORT_SYMBOL(jbd2_journal_update_sb_errno);
 
@@ -2166,8 +2169,7 @@ int jbd2_journal_destroy(journal_t *journal)
 				++journal->j_transaction_sequence;
 			write_unlock(&journal->j_state_lock);
 
-			jbd2_mark_journal_empty(journal,
-					REQ_SYNC | REQ_PREFLUSH | REQ_FUA);
+			jbd2_mark_journal_empty(journal, REQ_PREFLUSH | REQ_FUA);
 			mutex_unlock(&journal->j_checkpoint_mutex);
 		} else
 			err = -EIO;
@@ -2468,7 +2470,7 @@ int jbd2_journal_flush(journal_t *journal, unsigned int flags)
 	 * the magic code for a fully-recovered superblock.  Any future
 	 * commits of data to the journal will restore the current
 	 * s_start value. */
-	jbd2_mark_journal_empty(journal, REQ_SYNC | REQ_FUA);
+	jbd2_mark_journal_empty(journal, REQ_FUA);
 
 	if (flags)
 		err = __jbd2_journal_erase(journal, flags);
@@ -2514,7 +2516,7 @@ int jbd2_journal_wipe(journal_t *journal, int write)
 	if (write) {
 		/* Lock to make assertions happy... */
 		mutex_lock_io(&journal->j_checkpoint_mutex);
-		jbd2_mark_journal_empty(journal, REQ_SYNC | REQ_FUA);
+		jbd2_mark_journal_empty(journal, REQ_FUA);
 		mutex_unlock(&journal->j_checkpoint_mutex);
 	}
 
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 52772c826c86..0fc6c1f51262 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1374,6 +1374,9 @@ JBD2_FEATURE_INCOMPAT_FUNCS(csum2,		CSUM_V2)
 JBD2_FEATURE_INCOMPAT_FUNCS(csum3,		CSUM_V3)
 JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
 
+/* Journal high priority write IO operation flags */
+#define JBD2_JOURNAL_REQ_FLAGS		(REQ_META | REQ_SYNC | REQ_IDLE)
+
 /*
  * Journal flag definitions
  */
-- 
2.43.0




