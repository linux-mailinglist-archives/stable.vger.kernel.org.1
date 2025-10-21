Return-Path: <stable+bounces-188335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D84BF6AF6
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 15:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97C919A4E39
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 13:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EBE334C2B;
	Tue, 21 Oct 2025 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+HfqsJZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7B42459F7
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052340; cv=none; b=rn3Qf1+CWQIiczo0t0Hv7vfjSLydbj7sZpslHIhDeaO3s0bMgDrlzbn09y7DfHi0RhLhUiwhRNBG32SCErOqZxN0Yzk+QADZPB+oCQZJdKoiH0p02EJtPfS5kb/0+d6Y7RuntFE+w3U2iMDsn8i99mC1PPS02M0f4lZz+BmoLYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052340; c=relaxed/simple;
	bh=rcXbxJf5aLUUoNor2PlJo/ESwnrM7+TkozK5rDQcDDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fm03bG01eD0UnZuP/l+NvM/xqRmbdFEf7XwXjl/xEtdrbMxsJr9ZCOCQ56OSid7m2yoqzWL8+1fY0fXP7y7hcozQeJc4StGZcAuCkzgF8aeyin8bhmfd7v4ryGl75SIVb66gDpRYrVPB9so6W3iWyHyj6VRXOBlMCB782vhd8Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+HfqsJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805EDC4CEF1;
	Tue, 21 Oct 2025 13:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761052340;
	bh=rcXbxJf5aLUUoNor2PlJo/ESwnrM7+TkozK5rDQcDDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B+HfqsJZ/0GBSjlNvVemlvYgVaqALrtl/qA0GuKz1On+pa/0gju77Qw0aGCgY7E/q
	 g0Y3nyB4a4y6bkZWIdDanjVV1wqSoEnhQr+JGqLDlWb6AXzhJjD1f7tKrOTtCjB7Pu
	 7B9MYb9q3SJN19hSX13pzBNSUP/WCyoh0rgE2R2840etpT/bprS5pOkdE1kSVPdogh
	 Mh/qY8apxwROxhlx9LHWBCAhycsPpmShWdSQBd5Zue7Ii1RtfQD4Xn9QmKjdofD+iu
	 RDy6cnvnpUt0LBtfiVyd+nkyfwt22ASYpy9qeyfWvzMwW9zalL+E1HEtU/d0sQakzd
	 X352ig9zlZo0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	stable@kernel.org,
	syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] ext4: detect invalid INLINE_DATA + EXTENTS flag combination
Date: Tue, 21 Oct 2025 09:12:17 -0400
Message-ID: <20251021131217.2071970-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102009-dares-negligent-77e3@gregkh>
References: <2025102009-dares-negligent-77e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Deepanshu Kartikey <kartikey406@gmail.com>

[ Upstream commit 1d3ad183943b38eec2acf72a0ae98e635dc8456b ]

syzbot reported a BUG_ON in ext4_es_cache_extent() when opening a verity
file on a corrupted ext4 filesystem mounted without a journal.

The issue is that the filesystem has an inode with both the INLINE_DATA
and EXTENTS flags set:

    EXT4-fs error (device loop0): ext4_cache_extents:545: inode #15:
    comm syz.0.17: corrupted extent tree: lblk 0 < prev 66

Investigation revealed that the inode has both flags set:
    DEBUG: inode 15 - flag=1, i_inline_off=164, has_inline=1, extents_flag=1

This is an invalid combination since an inode should have either:
- INLINE_DATA: data stored directly in the inode
- EXTENTS: data stored in extent-mapped blocks

Having both flags causes ext4_has_inline_data() to return true, skipping
extent tree validation in __ext4_iget(). The unvalidated out-of-order
extents then trigger a BUG_ON in ext4_es_cache_extent() due to integer
underflow when calculating hole sizes.

Fix this by detecting this invalid flag combination early in ext4_iget()
and rejecting the corrupted inode.

Cc: stable@kernel.org
Reported-and-tested-by: syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=038b7bf43423e132b308
Suggested-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <20250930112810.315095-1-kartikey406@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fe54c84a1df09..99eab1157d04f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5071,6 +5071,14 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	}
 	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
 	ext4_set_inode_flags(inode);
+	/* Detect invalid flag combination - can't have both inline data and extents */
+	if (ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA) &&
+	    ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
+		ext4_error_inode(inode, function, line, 0,
+			"inode has both inline data and extents flags");
+		ret = -EFSCORRUPTED;
+		goto bad_inode;
+	}
 	inode->i_blocks = ext4_inode_blocks(raw_inode, ei);
 	ei->i_file_acl = le32_to_cpu(raw_inode->i_file_acl_lo);
 	if (ext4_has_feature_64bit(sb))
-- 
2.51.0


