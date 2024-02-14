Return-Path: <stable+bounces-20162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C9785471C
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 11:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226EE1C26F7F
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 10:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8CD18038;
	Wed, 14 Feb 2024 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="exOabs+p"
X-Original-To: stable@vger.kernel.org
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6412B182B5
	for <stable@vger.kernel.org>; Wed, 14 Feb 2024 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707906352; cv=none; b=jH/A7tS5jr1FG9ixkYmlryiufvGpmHcLZsoSoRW3+Q1qoS3KsjsfLhaNbRXPbT41DMoL9XLn7yY3jIAuzajIwhDHyP00oIqyld+Wah57ORcaHjbmi42VxmTpjzgTOT5nmECBcKGWPuNIjTPtvvmmEpxHQGG/2Rka+Oyh86V0YA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707906352; c=relaxed/simple;
	bh=5UHs3KrKRSaIy/zqJ8Q+2D2lWZZ439IsltxamPjz7fI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ECQXcWc2xapRLCkycr5CLf5Khv8MnRZSKh0K3ivN2jOdovDYMuWfEVakcMpDmHfi09lgyaBYV/z1f/z+8FjZbz8Z7NprtfBQSu1mLRgiW4qU5F0rCxeNPGDB3C4MVSg+wcTTXrIh5Iag/Wj5XQB5fN1xpSWcDasoAS4oZT2mQPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=exOabs+p; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:36ad:0:640:5aad:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 0C7B664770;
	Wed, 14 Feb 2024 13:23:48 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6b8:b081:6505::1:28])
	by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id UNlXS85IZW20-QuPUYcUK;
	Wed, 14 Feb 2024 13:23:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1707906227;
	bh=BuTnouTSWBE4EV4LJqRmLFqylNCnk9qhhS5sZxUPPeM=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=exOabs+pDQU3fhyeSfR7M/BfISDRvSlEGKAqv0BNEmVdMHXumPSNPL/wrae2bcMM4
	 1mJfudH7ZikV6Sv8O07BTV0xwql5CCV6ISeK9Oa1d2y9ctEpx7gAOlWfpAGH/tv/Ij
	 fpkAGKnIucSL//g3w+3LueiAiemzatzRABBZj924=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Nikolay Kuratov <kniv@yandex-team.ru>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	tytso@mit.edu,
	lvc-project@linuxtesting.org,
	Nikolay Kuratov <kniv@yandex-team.ru>,
	syzbot+9543479984ae9e576000@syzkaller.appspotmail.com
Subject: [PATCH 5.15 1/1] ext4, jbd2: add an optimized bmap for the journal inode
Date: Wed, 14 Feb 2024 13:23:09 +0300
Message-Id: <20240214102309.1382551-2-kniv@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214102309.1382551-1-kniv@yandex-team.ru>
References: <20240214102309.1382551-1-kniv@yandex-team.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Theodore Ts'o <tytso@mit.edu>

commit 62913ae96de747091c4dacd06d158e7729c1a76d upstream

The generic bmap() function exported by the VFS takes locks and does
checks that are not necessary for the journal inode.  So allow the
file system to set a journal-optimized bmap function in
journal->j_bmap.

Reported-by: syzbot+9543479984ae9e576000@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=e4aaa78795e490421c79f76ec3679006c8ff4cf0
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
---
 fs/ext4/super.c      | 23 +++++++++++++++++++++++
 fs/jbd2/journal.c    |  9 ++++++---
 include/linux/jbd2.h |  8 ++++++++
 3 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 601e097e1720..9083bbeb51a6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5752,6 +5752,28 @@ static struct inode *ext4_get_journal_inode(struct super_block *sb,
 	return journal_inode;
 }
 
+static int ext4_journal_bmap(journal_t *journal, sector_t *block)
+{
+	struct ext4_map_blocks map;
+	int ret;
+
+	if (journal->j_inode == NULL)
+		return 0;
+
+	map.m_lblk = *block;
+	map.m_len = 1;
+	ret = ext4_map_blocks(NULL, journal->j_inode, &map, 0);
+	if (ret <= 0) {
+		ext4_msg(journal->j_inode->i_sb, KERN_CRIT,
+			 "journal bmap failed: block %llu ret %d\n",
+			 *block, ret);
+		jbd2_journal_abort(journal, ret ? ret : -EIO);
+		return ret;
+	}
+	*block = map.m_pblk;
+	return 0;
+}
+
 static journal_t *ext4_get_journal(struct super_block *sb,
 				   unsigned int journal_inum)
 {
@@ -5772,6 +5794,7 @@ static journal_t *ext4_get_journal(struct super_block *sb,
 		return NULL;
 	}
 	journal->j_private = sb;
+	journal->j_bmap = ext4_journal_bmap;
 	ext4_init_journal_params(sb, journal);
 	return journal;
 }
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 3df45e4699f1..3e1dd3f90dfd 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -970,10 +970,13 @@ int jbd2_journal_bmap(journal_t *journal, unsigned long blocknr,
 {
 	int err = 0;
 	unsigned long long ret;
-	sector_t block = 0;
+	sector_t block = blocknr;
 
-	if (journal->j_inode) {
-		block = blocknr;
+	if (journal->j_bmap) {
+		err = journal->j_bmap(journal, &block);
+		if (err == 0)
+			*retp = block;
+	} else if (journal->j_inode) {
 		ret = bmap(journal->j_inode, &block);
 
 		if (ret || !block) {
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 6611af5f1d0c..d7930dfca73f 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1302,6 +1302,14 @@ struct journal_s
 				    struct buffer_head *bh,
 				    enum passtype pass, int off,
 				    tid_t expected_commit_id);
+
+	/**
+	 * @j_bmap:
+	 *
+	 * Bmap function that should be used instead of the generic
+	 * VFS bmap function.
+	 */
+	int (*j_bmap)(struct journal_s *journal, sector_t *block);
 };
 
 #define jbd2_might_wait_for_commit(j) \
-- 
2.34.1


