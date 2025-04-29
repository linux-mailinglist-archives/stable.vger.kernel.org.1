Return-Path: <stable+bounces-137659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CFFAA1440
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E2217F044
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DC7243364;
	Tue, 29 Apr 2025 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Gj/ZM4u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C6727453;
	Tue, 29 Apr 2025 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946735; cv=none; b=N/Nm5YRH21/RHbDjNSp7iV642j1d/awg+vwJdIP/+pLf+GgVvJ1Y8dnxQyrJtX+jW9xoGv94SK6aBZQOLCMewfgD2Nk0TBAEvD/de2omEMXWEVAgJ6ZOmZ4II+9u4Wt7ZpZJshGa/+naGMw3YWV0h8K42LTihAHGkenYM+sL2RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946735; c=relaxed/simple;
	bh=B2d9TwestPfNKOJUdWwYsmvFoWvZcdYGeGd3WsbjCbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ietrDzqKQsHTNBKHpBKEor8D7jpimvPebDujOGP2OrSwlQ4ar1kVTZj8xFBQmpL9Vc16TjAY/qHo6/SWGedC65EL5VHOBHLwugnyC+N5jmLBVEu3zdAr2rCl7uuswdQ2EeK71x95f9Z7w1XXCl8Gi/pUDwKdxBCOx1sRTQA5p2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2Gj/ZM4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA265C4CEE9;
	Tue, 29 Apr 2025 17:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745946735;
	bh=B2d9TwestPfNKOJUdWwYsmvFoWvZcdYGeGd3WsbjCbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2Gj/ZM4u4LM5SNC8TChGtRJudXovhlOqIbUP9VIHJqYdqMUBinZP15ZwE3S7nCbul
	 G7jy6aKCxlabcYko6k+glaSuWNkFx2MLttQeMTy0l3oXhwMCD4/liHJQ6s9y8P8wV8
	 GQQBpNjkIG0WoTJ5kWqp3cKBEoetPHcfEi3HVbfQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jann Horn <jannh@google.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 052/286] ext4: dont treat fhandle lookup of ea_inode as FS corruption
Date: Tue, 29 Apr 2025 18:39:16 +0200
Message-ID: <20250429161109.995862016@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index d0fcf91ec9d62..52d68edb6a09b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4681,22 +4681,43 @@ static inline u64 ext4_inode_peek_iversion(const struct inode *inode)
 		return inode_peek_iversion(inode);
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
@@ -4707,7 +4728,6 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	struct ext4_inode *raw_inode;
 	struct ext4_inode_info *ei;
 	struct inode *inode;
-	const char *err_str;
 	journal_t *journal = EXT4_SB(sb)->s_journal;
 	long ret;
 	loff_t size;
@@ -4732,10 +4752,10 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
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
@@ -5010,13 +5030,21 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
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




