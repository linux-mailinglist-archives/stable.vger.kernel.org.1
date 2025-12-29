Return-Path: <stable+bounces-203519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 259F6CE692A
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 12:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECE9D3016DCE
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 11:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5533D2DC344;
	Mon, 29 Dec 2025 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0cdniZPs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502F830C618
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767008450; cv=none; b=TAfxCvkvCUpFGdqkTggA5bXOXetIu6510yJ859LhIsdMW+RJ4CsZfKayRr9NIOhUUrta2ijyBDe4RaQJbgg8m0lKx+7T72j9gpA62QUCuua7MU38SktHipRq3IjoUniDZjpKvyyKUXCVgtdwbttImp+K2gG+UouHkk947+wPLc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767008450; c=relaxed/simple;
	bh=4+1GJxsfjk/VOvPR42ftrKuTkdCWrp9k9tSwngLJb8M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iN5SBAci08hy+VhrSOO4Q+Jf918wTlbScAMXzlz/s3tTqdsxGQT01QNRwGGvHqQmxQocNu6ea9HnhPn2mxLD2gjcd9M5weOAEmoj+XrF2EPl5myvVWGsf9qsUlXyu2tRI5QXiEQvQQykT7cMPnC51/DgFpzSkr4tYO1AjKnjSgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0cdniZPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DADC116C6;
	Mon, 29 Dec 2025 11:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767008448;
	bh=4+1GJxsfjk/VOvPR42ftrKuTkdCWrp9k9tSwngLJb8M=;
	h=Subject:To:Cc:From:Date:From;
	b=0cdniZPscytg+7Yg8lOt8VAvmknCpbhZow7Uh36xpSR54WYSl9UZmIo2UhLvBDpjb
	 nn6nyfBC6KbsADjJf/M6tyWJN3uN/uvy459jrLCH5ipv5W8vyBuD6gbBARkzqp8wPe
	 cybq4gxnL6xDEoqkPnvqWswE8LkxsO5dlmivKnqg=
Subject: FAILED: patch "[PATCH] jbd2: fix the inconsistency between checksum and data in" failed to apply to 5.10-stable tree
To: yebin10@huawei.com,djwong@kernel.org,jack@suse.cz,libaokun1@huawei.com,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 12:40:36 +0100
Message-ID: <2025122936-jaunt-sliding-0a13@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6abfe107894af7e8ce3a2e120c619d81ee764ad5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122936-jaunt-sliding-0a13@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6abfe107894af7e8ce3a2e120c619d81ee764ad5 Mon Sep 17 00:00:00 2001
From: Ye Bin <yebin10@huawei.com>
Date: Mon, 3 Nov 2025 09:01:23 +0800
Subject: [PATCH] jbd2: fix the inconsistency between checksum and data in
 memory for journal sb

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

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 2fe1786a8f1b..c973162d5b31 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2354,6 +2354,12 @@ int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
 	sb->s_feature_compat    |= cpu_to_be32(compat);
 	sb->s_feature_ro_compat |= cpu_to_be32(ro);
 	sb->s_feature_incompat  |= cpu_to_be32(incompat);
+	/*
+	 * Update the checksum now so that it is valid even for read-only
+	 * filesystems where jbd2_write_superblock() doesn't get called.
+	 */
+	if (jbd2_journal_has_csum_v2or3(journal))
+		sb->s_checksum = jbd2_superblock_csum(sb);
 	unlock_buffer(journal->j_sb_buffer);
 	jbd2_journal_init_transaction_limits(journal);
 
@@ -2383,9 +2389,17 @@ void jbd2_journal_clear_features(journal_t *journal, unsigned long compat,
 
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
+		sb->s_checksum = jbd2_superblock_csum(sb);
+	unlock_buffer(journal->j_sb_buffer);
 	jbd2_journal_init_transaction_limits(journal);
 }
 EXPORT_SYMBOL(jbd2_journal_clear_features);


