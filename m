Return-Path: <stable+bounces-147559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC056AC5831
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ABCF189101A
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A1925A627;
	Tue, 27 May 2025 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eTrQ3NLK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ABB42A9B;
	Tue, 27 May 2025 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367715; cv=none; b=onsSeonSBWLW1flRVhqAh7WnpmmYy61NHwohnl7ijImojyuaAWmoA7+o0t/RvofQPwkobZgB443dXygOv1Kv9B3al1x9MiYE/v/22vPhANHEEeTcnLIz84+8zyK3Y52k4Cm1zi46TwkuuXrmVxhpZ/XANIxtLY+1GlGVcXwr+ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367715; c=relaxed/simple;
	bh=cqzdCU4Z+QdKs2YLzl2QxpbH7Im7bZjanYXuWz8zfo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c27GnGbR4gOSTGfRMtYQuz8EekcXAlCN9lDJbDHvXZLKZpZp4IaWeOphplN8LbSCmREVu1Bt8fFbtxghJ3V2DF+rzI6CmWzufw+SAFNHlSlVre3W3CAzwjBlY2zqd8jIcWuzOxvgLMZHCmOeGqYXNzUMvbnsVLHSJvv52lZCG3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eTrQ3NLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40D2C4CEE9;
	Tue, 27 May 2025 17:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748367715;
	bh=cqzdCU4Z+QdKs2YLzl2QxpbH7Im7bZjanYXuWz8zfo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eTrQ3NLK1qw4YLZ9OrpHgsrPDPkzAcPfU4X8MHPxuxDl7KXQBa+cbszN5k3pq3ynM
	 OLx3Pb7lxrw6GaA1UOciJJqI/yFWBKX6eM9Epbp2yQdAuau8MBBs2yadthqjWSN2bI
	 Xs7chbedHK8gJNCQfpfV9TgTf/D39PGZbjAobAvg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Andreas Dilger <adilger@dilger.ca>,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 475/783] jbd2: Avoid long replay times due to high number or revoke blocks
Date: Tue, 27 May 2025 18:24:32 +0200
Message-ID: <20250527162532.471468638@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

[ Upstream commit a399af4e3b1ab2c5d83292d4487c4d18de551659 ]

Some users are reporting journal replay takes a long time when there is
excessive number of revoke blocks in the journal. Reported times are
like:

1048576 records - 95 seconds
2097152 records - 580 seconds

The problem is that hash chains in the revoke table gets excessively
long in these cases. Fix the problem by sizing the revoke table
appropriately before the revoke pass.

Thanks to Alexey Zhuravlev <azhuravlev@ddn.com> for benchmarking the
patch with large numbers of revoke blocks [1].

[1] https://lore.kernel.org/all/20250113183107.7bfef7b6@x390.bzzz77.ru

Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Link: https://patch.msgid.link/20250121140925.17231-2-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/recovery.c   | 58 ++++++++++++++++++++++++++++++++++++--------
 fs/jbd2/revoke.c     |  8 +++---
 include/linux/jbd2.h |  2 ++
 3 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 23502f1a67c1e..a3c39a71c4ad3 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -39,7 +39,7 @@ struct recovery_info
 
 static int do_one_pass(journal_t *journal,
 				struct recovery_info *info, enum passtype pass);
-static int scan_revoke_records(journal_t *, struct buffer_head *,
+static int scan_revoke_records(journal_t *, enum passtype, struct buffer_head *,
 				tid_t, struct recovery_info *);
 
 #ifdef __KERNEL__
@@ -328,6 +328,12 @@ int jbd2_journal_recover(journal_t *journal)
 		  journal->j_transaction_sequence, journal->j_head);
 
 	jbd2_journal_clear_revoke(journal);
+	/* Free revoke table allocated for replay */
+	if (journal->j_revoke != journal->j_revoke_table[0] &&
+	    journal->j_revoke != journal->j_revoke_table[1]) {
+		jbd2_journal_destroy_revoke_table(journal->j_revoke);
+		journal->j_revoke = journal->j_revoke_table[1];
+	}
 	err2 = sync_blockdev(journal->j_fs_dev);
 	if (!err)
 		err = err2;
@@ -613,6 +619,31 @@ static int do_one_pass(journal_t *journal,
 	first_commit_ID = next_commit_ID;
 	if (pass == PASS_SCAN)
 		info->start_transaction = first_commit_ID;
+	else if (pass == PASS_REVOKE) {
+		/*
+		 * Would the default revoke table have too long hash chains
+		 * during replay?
+		 */
+		if (info->nr_revokes > JOURNAL_REVOKE_DEFAULT_HASH * 16) {
+			unsigned int hash_size;
+
+			/*
+			 * Aim for average chain length of 8, limit at 1M
+			 * entries to avoid problems with malicious
+			 * filesystems.
+			 */
+			hash_size = min(roundup_pow_of_two(info->nr_revokes / 8),
+					1U << 20);
+			journal->j_revoke =
+				jbd2_journal_init_revoke_table(hash_size);
+			if (!journal->j_revoke) {
+				printk(KERN_ERR
+				       "JBD2: failed to allocate revoke table for replay with %u entries. "
+				       "Journal replay may be slow.\n", hash_size);
+				journal->j_revoke = journal->j_revoke_table[1];
+			}
+		}
+	}
 
 	jbd2_debug(1, "Starting recovery pass %d\n", pass);
 
@@ -852,6 +883,13 @@ static int do_one_pass(journal_t *journal,
 			continue;
 
 		case JBD2_REVOKE_BLOCK:
+			/*
+			 * If we aren't in the SCAN or REVOKE pass, then we can
+			 * just skip over this block.
+			 */
+			if (pass != PASS_REVOKE && pass != PASS_SCAN)
+				continue;
+
 			/*
 			 * Check revoke block crc in pass_scan, if csum verify
 			 * failed, check commit block time later.
@@ -864,12 +902,7 @@ static int do_one_pass(journal_t *journal,
 				need_check_commit_time = true;
 			}
 
-			/* If we aren't in the REVOKE pass, then we can
-			 * just skip over this block. */
-			if (pass != PASS_REVOKE)
-				continue;
-
-			err = scan_revoke_records(journal, bh,
+			err = scan_revoke_records(journal, pass, bh,
 						  next_commit_ID, info);
 			if (err)
 				goto failed;
@@ -923,8 +956,9 @@ static int do_one_pass(journal_t *journal,
 
 /* Scan a revoke record, marking all blocks mentioned as revoked. */
 
-static int scan_revoke_records(journal_t *journal, struct buffer_head *bh,
-			       tid_t sequence, struct recovery_info *info)
+static int scan_revoke_records(journal_t *journal, enum passtype pass,
+			       struct buffer_head *bh, tid_t sequence,
+			       struct recovery_info *info)
 {
 	jbd2_journal_revoke_header_t *header;
 	int offset, max;
@@ -945,6 +979,11 @@ static int scan_revoke_records(journal_t *journal, struct buffer_head *bh,
 	if (jbd2_has_feature_64bit(journal))
 		record_len = 8;
 
+	if (pass == PASS_SCAN) {
+		info->nr_revokes += (max - offset) / record_len;
+		return 0;
+	}
+
 	while (offset + record_len <= max) {
 		unsigned long long blocknr;
 		int err;
@@ -957,7 +996,6 @@ static int scan_revoke_records(journal_t *journal, struct buffer_head *bh,
 		err = jbd2_journal_set_revoke(journal, blocknr, sequence);
 		if (err)
 			return err;
-		++info->nr_revokes;
 	}
 	return 0;
 }
diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index f68fc8c255f00..bc328c39028a2 100644
--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -215,7 +215,7 @@ int __init jbd2_journal_init_revoke_table_cache(void)
 	return 0;
 }
 
-static struct jbd2_revoke_table_s *jbd2_journal_init_revoke_table(int hash_size)
+struct jbd2_revoke_table_s *jbd2_journal_init_revoke_table(int hash_size)
 {
 	int shift = 0;
 	int tmp = hash_size;
@@ -231,7 +231,7 @@ static struct jbd2_revoke_table_s *jbd2_journal_init_revoke_table(int hash_size)
 	table->hash_size = hash_size;
 	table->hash_shift = shift;
 	table->hash_table =
-		kmalloc_array(hash_size, sizeof(struct list_head), GFP_KERNEL);
+		kvmalloc_array(hash_size, sizeof(struct list_head), GFP_KERNEL);
 	if (!table->hash_table) {
 		kmem_cache_free(jbd2_revoke_table_cache, table);
 		table = NULL;
@@ -245,7 +245,7 @@ static struct jbd2_revoke_table_s *jbd2_journal_init_revoke_table(int hash_size)
 	return table;
 }
 
-static void jbd2_journal_destroy_revoke_table(struct jbd2_revoke_table_s *table)
+void jbd2_journal_destroy_revoke_table(struct jbd2_revoke_table_s *table)
 {
 	int i;
 	struct list_head *hash_list;
@@ -255,7 +255,7 @@ static void jbd2_journal_destroy_revoke_table(struct jbd2_revoke_table_s *table)
 		J_ASSERT(list_empty(hash_list));
 	}
 
-	kfree(table->hash_table);
+	kvfree(table->hash_table);
 	kmem_cache_free(jbd2_revoke_table_cache, table);
 }
 
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 561025b4f3d91..469c4a191ced4 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1627,6 +1627,8 @@ extern void	   jbd2_journal_destroy_revoke_record_cache(void);
 extern void	   jbd2_journal_destroy_revoke_table_cache(void);
 extern int __init jbd2_journal_init_revoke_record_cache(void);
 extern int __init jbd2_journal_init_revoke_table_cache(void);
+struct jbd2_revoke_table_s *jbd2_journal_init_revoke_table(int hash_size);
+void jbd2_journal_destroy_revoke_table(struct jbd2_revoke_table_s *table);
 
 extern void	   jbd2_journal_destroy_revoke(journal_t *);
 extern int	   jbd2_journal_revoke (handle_t *, unsigned long long, struct buffer_head *);
-- 
2.39.5




