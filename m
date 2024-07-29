Return-Path: <stable+bounces-62532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F1193F52A
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 14:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5D91F22407
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FE9147C7F;
	Mon, 29 Jul 2024 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MNtkbz5e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C441474CF
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722255783; cv=none; b=OM2/UHD8yD6l0RBtOqTTpcZ2eZTYagoVd/mVp9YInBM3veaU50/s+tQL0GGSFlbyoCNwleZ4af+yHmGXRxrPQTCfxFwxrxKc/arMbaD0R6goLDesJ2+L3Ry+eedz6sVp/0l36sLGZ4pmUaZMBXOGKZ9q9fswaN3TKrLL6qIgHn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722255783; c=relaxed/simple;
	bh=vLxkjtga2nBbTenRsj+lRgyjkwuo4NK1rNwtnjuV4Hc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=k7g9t8IfIYoXzRgZ/pfVC0/dX5y/iJEEQB3FHKsFuwCykCe0GR8ijEqQsixgQFFak9k+hVK7CXi6FB2gaKlMl3YmesB7ZeHzO89ppJA7uKrtSzhSBR/ko6q/fY/a+VyE3+UoykzWTFj+dnjHmcK2BfOaBIdaRYEDZREJLS+8uZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MNtkbz5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D99C32786;
	Mon, 29 Jul 2024 12:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722255783;
	bh=vLxkjtga2nBbTenRsj+lRgyjkwuo4NK1rNwtnjuV4Hc=;
	h=Subject:To:Cc:From:Date:From;
	b=MNtkbz5eyBTFcCZ78KyxHTnhdiwlkeKmjmCjIZCD3Co9QZZQO65dYZobi1uFjFsT8
	 Sfs9o9nl2SdSna4x7avrtwKjK5UOU63n79hqXLmVWCPsMiywjt8xmx363YyCtqvV9a
	 S4Fc9kdlwbvUI2pY5CVWsToLVqd+aGGlhdolbA6M=
Subject: FAILED: patch "[PATCH] nilfs2: add missing check for inode numbers on directory" failed to apply to 6.10-stable tree
To: konishi.ryusuke@gmail.com,akpm@linux-foundation.org,hdanton@sina.com,jack@suse.cz,stable@vger.kernel.org,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 14:22:32 +0200
Message-ID: <2024072932-sage-amazingly-1d3e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 49ae997f8f0d5e268bbd271c5fd66166ce8287fe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072932-sage-amazingly-1d3e@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

49ae997f8f0d ("nilfs2: add missing check for inode numbers on directory entries")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 49ae997f8f0d5e268bbd271c5fd66166ce8287fe Mon Sep 17 00:00:00 2001
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Sun, 23 Jun 2024 14:11:34 +0900
Subject: [PATCH] nilfs2: add missing check for inode numbers on directory
 entries

Syzbot reported that mounting and unmounting a specific pattern of
corrupted nilfs2 filesystem images causes a use-after-free of metadata
file inodes, which triggers a kernel bug in lru_add_fn().

As Jan Kara pointed out, this is because the link count of a metadata file
gets corrupted to 0, and nilfs_evict_inode(), which is called from iput(),
tries to delete that inode (ifile inode in this case).

The inconsistency occurs because directories containing the inode numbers
of these metadata files that should not be visible in the namespace are
read without checking.

Fix this issue by treating the inode numbers of these internal files as
errors in the sanity check helper when reading directory folios/pages.

Also thanks to Hillf Danton and Matthew Wilcox for their initial mm-layer
analysis.

Link: https://lkml.kernel.org/r/20240623051135.4180-3-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d79afb004be235636ee8
Reported-by: Jan Kara <jack@suse.cz>
Closes: https://lkml.kernel.org/r/20240617075758.wewhukbrjod5fp5o@quack3
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 52e50b1b7f22..dddfa604491a 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -135,6 +135,9 @@ static bool nilfs_check_folio(struct folio *folio, char *kaddr)
 			goto Enamelen;
 		if (((offs + rec_len - 1) ^ offs) & ~(chunk_size-1))
 			goto Espan;
+		if (unlikely(p->inode &&
+			     NILFS_PRIVATE_INODE(le64_to_cpu(p->inode))))
+			goto Einumber;
 	}
 	if (offs != limit)
 		goto Eend;
@@ -160,6 +163,9 @@ static bool nilfs_check_folio(struct folio *folio, char *kaddr)
 	goto bad_entry;
 Espan:
 	error = "directory entry across blocks";
+	goto bad_entry;
+Einumber:
+	error = "disallowed inode number";
 bad_entry:
 	nilfs_error(sb,
 		    "bad entry in directory #%lu: %s - offset=%lu, inode=%lu, rec_len=%zd, name_len=%d",
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index 7e39e277c77f..4017f7856440 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -121,6 +121,11 @@ enum {
 	((ino) >= NILFS_FIRST_INO(sb) ||				\
 	 ((ino) < NILFS_USER_INO && (NILFS_SYS_INO_BITS & BIT(ino))))
 
+#define NILFS_PRIVATE_INODE(ino) ({					\
+	ino_t __ino = (ino);						\
+	((__ino) < NILFS_USER_INO && (__ino) != NILFS_ROOT_INO &&	\
+	 (__ino) != NILFS_SKETCH_INO); })
+
 /**
  * struct nilfs_transaction_info: context information for synchronization
  * @ti_magic: Magic number


