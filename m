Return-Path: <stable+bounces-138894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4436AA1A3D
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07151BA7B4D
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6E02517A8;
	Tue, 29 Apr 2025 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TjtFWopI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4816C155A4E;
	Tue, 29 Apr 2025 18:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950693; cv=none; b=PLCvBGvvfYQEMn5aO3sRPJeaX5kBagwqKp2dbBz0bij8cfvhb2FMzNd49oJGqy7nJizQ9YUQII/eK1vCwASk56Ph9rAq9K+ac6JbM5qpc9rlSJM8d32i9GpO9wKPfLNLeRi+PsgK5BlHJ0LFSlHHFr/u7TOfOvkCP5si+EHu/8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950693; c=relaxed/simple;
	bh=mOVd+vJDUqKOOM5ZPOTHCHPssWySwlWtZgJmfFjlAE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMWQapkjmkW5bzew7glXELGCuXj3+pH0qf/gF2ivjVmTxTAdmb0LYJtx297iK2HundbPNQgQsX0X7rwueD6pFdVXVFe5cSN87a4vyTPrj73DiZNsOGXoyHFecQl4ykSsrMeZWX57zj8EMP639QCE5/+LFAAyYBsL4n4V0nmH1hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TjtFWopI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D7AC4CEE3;
	Tue, 29 Apr 2025 18:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745950692;
	bh=mOVd+vJDUqKOOM5ZPOTHCHPssWySwlWtZgJmfFjlAE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TjtFWopIHhuGRQGXYsQQyTi8S7cLItkJDIBjePFukNMzdgCyEXA+9+YoOnaugtxle
	 4X3OkUx7Q7jkx87egk3uloPrRpkm2v1kaVyUIXApSO7MllJKh4QaEqNSL/9DethfGv
	 pYsbmKK/TzDOhMhE4nZygQB3jQ+m7q6WfU0KtYsY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Zhang Yi <yi.zhang@huawei.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 175/204] ext4: make block validity check resistent to sb bh corruption
Date: Tue, 29 Apr 2025 18:44:23 +0200
Message-ID: <20250429161106.562347838@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161059.396852607@linuxfoundation.org>
References: <20250429161059.396852607@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ojaswin Mujoo <ojaswin@linux.ibm.com>

[ Upstream commit ccad447a3d331a239477c281533bacb585b54a98 ]

Block validity checks need to be skipped in case they are called
for journal blocks since they are part of system's protected
zone.

Currently, this is done by checking inode->ino against
sbi->s_es->s_journal_inum, which is a direct read from the ext4 sb
buffer head. If someone modifies this underneath us then the
s_journal_inum field might get corrupted. To prevent against this,
change the check to directly compare the inode with journal->j_inode.

**Slight change in behavior**: During journal init path,
check_block_validity etc might be called for journal inode when
sbi->s_journal is not set yet. In this case we now proceed with
ext4_inode_block_valid() instead of returning early. Since systems zones
have not been set yet, it is okay to proceed so we can perform basic
checks on the blocks.

Suggested-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://patch.msgid.link/0c06bc9ebfcd6ccfed84a36e79147bf45ff5adc1.1743142920.git.ojaswin@linux.ibm.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/block_validity.c | 5 ++---
 fs/ext4/inode.c          | 7 ++++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 6fe3c941b5651..4d6ba140276b5 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -351,10 +351,9 @@ int ext4_check_blockref(const char *function, unsigned int line,
 {
 	__le32 *bref = p;
 	unsigned int blk;
+	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
 
-	if (ext4_has_feature_journal(inode->i_sb) &&
-	    (inode->i_ino ==
-	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
+	if (journal && inode == journal->j_inode)
 		return 0;
 
 	while (bref < p+max) {
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ddfeaf19bff1b..f2b60fb0b937b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -378,10 +378,11 @@ static int __check_block_validity(struct inode *inode, const char *func,
 				unsigned int line,
 				struct ext4_map_blocks *map)
 {
-	if (ext4_has_feature_journal(inode->i_sb) &&
-	    (inode->i_ino ==
-	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
+	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
+
+	if (journal && inode == journal->j_inode)
 		return 0;
+
 	if (!ext4_inode_block_valid(inode, map->m_pblk, map->m_len)) {
 		ext4_error_inode(inode, func, line, map->m_pblk,
 				 "lblock %lu mapped to illegal pblock %llu "
-- 
2.39.5




