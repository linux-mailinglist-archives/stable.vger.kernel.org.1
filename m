Return-Path: <stable+bounces-64455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6DB941E28
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9318B2827A
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741C91A76DE;
	Tue, 30 Jul 2024 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u7f2kbfv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3380A1A76A1;
	Tue, 30 Jul 2024 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360178; cv=none; b=p2aZgqpq0fIZS+JaYFC9ZnvrCS3238ZL1ocFgpU8oTr2bQ4K5FE+NL1Px1H73OigY9YXq9ZbcdO2hlUC0hyvLq1LnBRmziyFm2G7Z+zXY7auw28VATI2yK1zjSt47w0/8H138K1Yaki+zPLgxtt1QwpMWRPksXEwxpzKqtqYD18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360178; c=relaxed/simple;
	bh=pOe861v5Wj8y60QgxC4ijOJLMJ3FoHaZpyfKppbfl+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgqEDgfrYVNMzRgHi4DKtb4jGOBEDb7Cv9vOS8fkR5HdOn8BtQreCHqLMrlP0iiCFSmCBv+AEQXksFQTXW3jRZ3kfjsj+3yiK1WC+XUPqq2Qj0q02YOJhXLkq42Mm6ss/6hKKQBx4vtAO/5of6r9xhrJCHhB+s9zSTmAbbE4Fo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u7f2kbfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C4CC32782;
	Tue, 30 Jul 2024 17:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722360178;
	bh=pOe861v5Wj8y60QgxC4ijOJLMJ3FoHaZpyfKppbfl+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u7f2kbfvobSK4pcDif9O7XBMBj/bI9tHvN5AVGUqt4smERzCy/0+MvlsLYaVGwOxo
	 csq7MAiktDZGEMCLjabiHwpbctlcnu/BpM5U2x6au+q8SZxx5H+L7r3PUwMynoSZ4u
	 Ub2iYJlg/Pc6r7omAon39iuOD0S++KI0XhdlFcYI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+ae688d469e36fb5138d0@syzkaller.appspotmail.com,
	stable@kernel.org,
	Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.10 593/809] ext4: make sure the first directory block is not a hole
Date: Tue, 30 Jul 2024 17:47:49 +0200
Message-ID: <20240730151748.252196817@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baokun Li <libaokun1@huawei.com>

commit f9ca51596bbfd0f9c386dd1c613c394c78d9e5e6 upstream.

The syzbot constructs a directory that has no dirblock but is non-inline,
i.e. the first directory block is a hole. And no errors are reported when
creating files in this directory in the following flow.

    ext4_mknod
     ...
      ext4_add_entry
        // Read block 0
        ext4_read_dirblock(dir, block, DIRENT)
          bh = ext4_bread(NULL, inode, block, 0)
          if (!bh && (type == INDEX || type == DIRENT_HTREE))
          // The first directory block is a hole
          // But type == DIRENT, so no error is reported.

After that, we get a directory block without '.' and '..' but with a valid
dentry. This may cause some code that relies on dot or dotdot (such as
make_indexed_dir()) to crash.

Therefore when ext4_read_dirblock() finds that the first directory block
is a hole report that the filesystem is corrupted and return an error to
avoid loading corrupted data from disk causing something bad.

Reported-by: syzbot+ae688d469e36fb5138d0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ae688d469e36fb5138d0
Fixes: 4e19d6b65fb4 ("ext4: allow directory holes")
Cc: stable@kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20240702132349.2600605-3-libaokun@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/namei.c |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -151,10 +151,11 @@ static struct buffer_head *__ext4_read_d
 
 		return bh;
 	}
-	if (!bh && (type == INDEX || type == DIRENT_HTREE)) {
+	/* The first directory block must not be a hole. */
+	if (!bh && (type == INDEX || type == DIRENT_HTREE || block == 0)) {
 		ext4_error_inode(inode, func, line, block,
-				 "Directory hole found for htree %s block",
-				 (type == INDEX) ? "index" : "leaf");
+				 "Directory hole found for htree %s block %u",
+				 (type == INDEX) ? "index" : "leaf", block);
 		return ERR_PTR(-EFSCORRUPTED);
 	}
 	if (!bh)
@@ -3129,10 +3130,7 @@ bool ext4_empty_dir(struct inode *inode)
 		EXT4_ERROR_INODE(inode, "invalid size");
 		return false;
 	}
-	/* The first directory block must not be a hole,
-	 * so treat it as DIRENT_HTREE
-	 */
-	bh = ext4_read_dirblock(inode, 0, DIRENT_HTREE);
+	bh = ext4_read_dirblock(inode, 0, EITHER);
 	if (IS_ERR(bh))
 		return false;
 
@@ -3577,10 +3575,7 @@ static struct buffer_head *ext4_get_firs
 		struct ext4_dir_entry_2 *de;
 		unsigned int offset;
 
-		/* The first directory block must not be a hole, so
-		 * treat it as DIRENT_HTREE
-		 */
-		bh = ext4_read_dirblock(inode, 0, DIRENT_HTREE);
+		bh = ext4_read_dirblock(inode, 0, EITHER);
 		if (IS_ERR(bh)) {
 			*retval = PTR_ERR(bh);
 			return NULL;



