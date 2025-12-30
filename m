Return-Path: <stable+bounces-204163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44ABBCE8762
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 02:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC0593010AB5
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 01:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4C32D9EF3;
	Tue, 30 Dec 2025 01:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNrznijt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4C413B584
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 01:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767056801; cv=none; b=oddEmKeA3E6HLG2HADGmbcsOWBN1LCsEimXeK/KT6Ko8RRU6AgpD++jjsIc3Ew/dgmGxNIixvYXp0CU+hBuy8fcPKCI+2ezIQxUmFIQiUsOe5iejMhYT0FBgD/uZRbU1SRyP+YtcqjBx9wu3Ko+8MkxDbR9Ac1ix82xKmoZdYDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767056801; c=relaxed/simple;
	bh=5bGeP5LhFZQcW6Svl4UBx7A6vrlqvGDmTsYs6Ird8Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCqC0uHmgCnvgpcCJkpwmduFViP5UGvI2kJBRS4tZxHaSGI2U6LhivaCdSBmm/sDstU0cqB2WlT4S+kse+PGnkGeVUsIlQd5InvOLPW/PtFuxoBUYQ1H98/FjJJbteY3pGvTVMToi0yA5uogZ4Va5H+Gwn7dOvgl64wGn6I1m94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNrznijt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491F5C4CEF7;
	Tue, 30 Dec 2025 01:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767056801;
	bh=5bGeP5LhFZQcW6Svl4UBx7A6vrlqvGDmTsYs6Ird8Fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vNrznijt0bDSH9Uz8E0K4Qq8Nai7C1hbC8/xiIiBgzZ+ewEURtOJA6v3wv+AVFqGV
	 hoZoBOut7dQBquR7dvJWrhRhvJY2Bx4uRk0BCBWDfFFzq3ngLNuh8rd9CWJ9tCawhz
	 dakO8D4OSXKP70JiqfbCoYfucBiAB/LP8Tvol6fvwSqAN1Petzu7B1YWpZorMXarl6
	 OBaMFzZ2l0ODPdqS8YODqWa8QKS2gip5DtwLcFgspG8MYptcegIMUxCebzXNUvKclW
	 ucPkZus+9zdqA4jsBGQ4BhWlT6znoW4Ql6N80fHikPO81gNHVQ5QhXJA7a4lC4oRAD
	 hQSg9RUSGDHHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ye Bin <yebin10@huawei.com>,
	Baokun Li <libaokun1@huawei.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] jbd2: fix the inconsistency between checksum and data in memory for journal sb
Date: Mon, 29 Dec 2025 20:06:38 -0500
Message-ID: <20251230010638.1905408-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122936-jaunt-sliding-0a13@gregkh>
References: <2025122936-jaunt-sliding-0a13@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit 6abfe107894af7e8ce3a2e120c619d81ee764ad5 ]

Copying the file system while it is mounted as read-only results in
a mount failure:
[~]# mkfs.ext4 -F /dev/sdc
[~]# mount /dev/sdc -o ro /mnt/test
[~]# dd if=/dev/sdc of=/dev/sda bs=1M
[~]# mount /dev/sda /mnt/test1
[ 1094.849826] JBD2: journal checksum error
[ 1094.850927] EXT4-fs (sda): Could not load journal inode
mount: mount /dev/sda on /mnt/test1 failed: Bad message

The process described above is just an abstracted way I came up with to
reproduce the issue. In the actual scenario, the file system was mounted
read-only and then copied while it was still mounted. It was found that
the mount operation failed. The user intended to verify the data or use
it as a backup, and this action was performed during a version upgrade.
Above issue may happen as follows:
ext4_fill_super
 set_journal_csum_feature_set(sb)
  if (ext4_has_metadata_csum(sb))
   incompat = JBD2_FEATURE_INCOMPAT_CSUM_V3;
  if (test_opt(sb, JOURNAL_CHECKSUM)
   jbd2_journal_set_features(sbi->s_journal, compat, 0, incompat);
    lock_buffer(journal->j_sb_buffer);
    sb->s_feature_incompat  |= cpu_to_be32(incompat);
    //The data in the journal sb was modified, but the checksum was not
      updated, so the data remaining in memory has a mismatch between the
      data and the checksum.
    unlock_buffer(journal->j_sb_buffer);

In this case, the journal sb copied over is in a state where the checksum
and data are inconsistent, so mounting fails.
To solve the above issue, update the checksum in memory after modifying
the journal sb.

Fixes: 4fd5ea43bc11 ("jbd2: checksum journal superblock")
Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Message-ID: <20251103010123.3753631-1-yebin@huaweicloud.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
[ Changed jbd2_superblock_csum(sb) to jbd2_superblock_csum(journal, sb) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/journal.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 23314218fb0d..14b176d63482 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2224,6 +2224,12 @@ int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
 	sb->s_feature_compat    |= cpu_to_be32(compat);
 	sb->s_feature_ro_compat |= cpu_to_be32(ro);
 	sb->s_feature_incompat  |= cpu_to_be32(incompat);
+	/*
+	 * Update the checksum now so that it is valid even for read-only
+	 * filesystems where jbd2_write_superblock() doesn't get called.
+	 */
+	if (jbd2_journal_has_csum_v2or3(journal))
+		sb->s_checksum = jbd2_superblock_csum(journal, sb);
 	unlock_buffer(journal->j_sb_buffer);
 	journal->j_revoke_records_per_block =
 				journal_revoke_records_per_block(journal);
@@ -2254,9 +2260,17 @@ void jbd2_journal_clear_features(journal_t *journal, unsigned long compat,
 
 	sb = journal->j_superblock;
 
+	lock_buffer(journal->j_sb_buffer);
 	sb->s_feature_compat    &= ~cpu_to_be32(compat);
 	sb->s_feature_ro_compat &= ~cpu_to_be32(ro);
 	sb->s_feature_incompat  &= ~cpu_to_be32(incompat);
+	/*
+	 * Update the checksum now so that it is valid even for read-only
+	 * filesystems where jbd2_write_superblock() doesn't get called.
+	 */
+	if (jbd2_journal_has_csum_v2or3(journal))
+		sb->s_checksum = jbd2_superblock_csum(journal, sb);
+	unlock_buffer(journal->j_sb_buffer);
 	journal->j_revoke_records_per_block =
 				journal_revoke_records_per_block(journal);
 }
-- 
2.51.0


