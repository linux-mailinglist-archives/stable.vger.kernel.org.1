Return-Path: <stable+bounces-134249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43317A92A0E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E76616FF5F
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCA22571B2;
	Thu, 17 Apr 2025 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ms3JjnZu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BD82571A0;
	Thu, 17 Apr 2025 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915553; cv=none; b=K57A8AEtMVx7YDnuT3RU3oQd55OxA4rXLja1dNDu7QX0FFVmRM823eOZmhBLBZhciOaPMU7u+sgrX7UrRD6w+DEYVafKgv1lYJDK4dS/KfQymTwQ2Ne4ZL5kHKeFW/lPaHX5H9T2ziZKPOjBi3RtJjQ7OosworyKhpLZyUun5rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915553; c=relaxed/simple;
	bh=RPpjemuun+7ScjQcc51XyRQK5dy6yakreaV/uDbtDnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNj1awqjrCWgNpsUxdQcTWU9DMgEgayQiZ51qiDlmqlbPuxM8tGERkDWjHDNIEyUjTLWQYS7+kt8H+YBpONGPUixtL6TFnwj+PHKVNSI7SLQjASfwPYHQbgODa6sZq134bbX7RAIUUMiU2qLA0dfQnNvJg/vps7uGH2g2eT6LyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ms3JjnZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5941DC4CEEA;
	Thu, 17 Apr 2025 18:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744915552;
	bh=RPpjemuun+7ScjQcc51XyRQK5dy6yakreaV/uDbtDnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ms3JjnZutCXupwh8yvSQWWxtcWsFbqWCDkmQ9PygO8UK9h9NrHWgXdJ2SQlZtSEdb
	 xpM2nC8g+HXMgH5c3J6CgMoYRBb57dEtmFSNq5Qm2Rze3o5JvJnQp9LsQcA3N/5AQz
	 K7fYV09l6leaZIIECuCCDz3Bw6PjVdirA6cnCbrE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jann Horn <jannh@google.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 164/393] ext4: dont treat fhandle lookup of ea_inode as FS corruption
Date: Thu, 17 Apr 2025 19:49:33 +0200
Message-ID: <20250417175114.179040751@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
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

From: Jann Horn <jannh@google.com>

[ Upstream commit 642335f3ea2b3fd6dba03e57e01fa9587843a497 ]

A file handle that userspace provides to open_by_handle_at() can
legitimately contain an outdated inode number that has since been reused
for another purpose - that's why the file handle also contains a generation
number.

But if the inode number has been reused for an ea_inode, check_igot_inode()
will notice, __ext4_iget() will go through ext4_error_inode(), and if the
inode was newly created, it will also be marked as bad by iget_failed().
This all happens before the point where the inode generation is checked.

ext4_error_inode() is supposed to only be used on filesystem corruption; it
should not be used when userspace just got unlucky with a stale file
handle. So when this happens, let __ext4_iget() just return an error.

Fixes: b3e6bcb94590 ("ext4: add EA_INODE checking to ext4_iget()")
Signed-off-by: Jann Horn <jannh@google.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20241129-ext4-ignore-ea-fhandle-v1-1-e532c0d1cee0@google.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/inode.c | 68 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 20 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 67a5b937f5a92..ffa6aa55a1a7a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4681,22 +4681,43 @@ static inline void ext4_inode_set_iversion_queried(struct inode *inode, u64 val)
 		inode_set_iversion_queried(inode, val);
 }
 
-static const char *check_igot_inode(struct inode *inode, ext4_iget_flags flags)
-
+static int check_igot_inode(struct inode *inode, ext4_iget_flags flags,
+			    const char *function, unsigned int line)
 {
+	const char *err_str;
+
 	if (flags & EXT4_IGET_EA_INODE) {
-		if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
-			return "missing EA_INODE flag";
+		if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)) {
+			err_str = "missing EA_INODE flag";
+			goto error;
+		}
 		if (ext4_test_inode_state(inode, EXT4_STATE_XATTR) ||
-		    EXT4_I(inode)->i_file_acl)
-			return "ea_inode with extended attributes";
+		    EXT4_I(inode)->i_file_acl) {
+			err_str = "ea_inode with extended attributes";
+			goto error;
+		}
 	} else {
-		if ((EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
-			return "unexpected EA_INODE flag";
+		if ((EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)) {
+			/*
+			 * open_by_handle_at() could provide an old inode number
+			 * that has since been reused for an ea_inode; this does
+			 * not indicate filesystem corruption
+			 */
+			if (flags & EXT4_IGET_HANDLE)
+				return -ESTALE;
+			err_str = "unexpected EA_INODE flag";
+			goto error;
+		}
+	}
+	if (is_bad_inode(inode) && !(flags & EXT4_IGET_BAD)) {
+		err_str = "unexpected bad inode w/o EXT4_IGET_BAD";
+		goto error;
 	}
-	if (is_bad_inode(inode) && !(flags & EXT4_IGET_BAD))
-		return "unexpected bad inode w/o EXT4_IGET_BAD";
-	return NULL;
+	return 0;
+
+error:
+	ext4_error_inode(inode, function, line, 0, err_str);
+	return -EFSCORRUPTED;
 }
 
 struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
@@ -4708,7 +4729,6 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	struct ext4_inode_info *ei;
 	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
 	struct inode *inode;
-	const char *err_str;
 	journal_t *journal = EXT4_SB(sb)->s_journal;
 	long ret;
 	loff_t size;
@@ -4737,10 +4757,10 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 	if (!(inode->i_state & I_NEW)) {
-		if ((err_str = check_igot_inode(inode, flags)) != NULL) {
-			ext4_error_inode(inode, function, line, 0, err_str);
+		ret = check_igot_inode(inode, flags, function, line);
+		if (ret) {
 			iput(inode);
-			return ERR_PTR(-EFSCORRUPTED);
+			return ERR_PTR(ret);
 		}
 		return inode;
 	}
@@ -5012,13 +5032,21 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		ret = -EFSCORRUPTED;
 		goto bad_inode;
 	}
-	if ((err_str = check_igot_inode(inode, flags)) != NULL) {
-		ext4_error_inode(inode, function, line, 0, err_str);
-		ret = -EFSCORRUPTED;
-		goto bad_inode;
+	ret = check_igot_inode(inode, flags, function, line);
+	/*
+	 * -ESTALE here means there is nothing inherently wrong with the inode,
+	 * it's just not an inode we can return for an fhandle lookup.
+	 */
+	if (ret == -ESTALE) {
+		brelse(iloc.bh);
+		unlock_new_inode(inode);
+		iput(inode);
+		return ERR_PTR(-ESTALE);
 	}
-
+	if (ret)
+		goto bad_inode;
 	brelse(iloc.bh);
+
 	unlock_new_inode(inode);
 	return inode;
 
-- 
2.39.5




