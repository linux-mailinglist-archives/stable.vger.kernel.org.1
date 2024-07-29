Return-Path: <stable+bounces-62534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DCA93F52C
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 14:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321F0281429
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA9A147C86;
	Mon, 29 Jul 2024 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G7xjljX0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C4C147C74
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722255790; cv=none; b=UUtU+d0oH9Zgf3pNmrHUO12FD0hGi61KkKrxVHJlR8nN4xp/jx4mHZ8dz2zAxU3nX3SGRDij2Q0cf4HBLKvclBcbK8m8bpwHBVAO6AXxJbgap7/V07cuNs2p3NYsf+FJG/DylkyoKNqdRAYxlV5c8pqnRqhu5ML9pjojmj1Aknk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722255790; c=relaxed/simple;
	bh=DJdF1mBPuCGWB0w3hmxK+i5apZdT29PflY5IBAM5q4A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LrOmKdE5e9cNkHu5NppTF3pnUALejiWMBUOTaSHtsQ2Dblq+AmDANpHuVzehzV+KHaTo4/3n5Wx/iT30bb29enLFjY8VPt3qHl7rHVwnHJExvibiTOO1FTnpCWZjjrRoQiA/CWdnZHKpeG3VDb4SuKG6b4FbEK4Fpmx0xZnWy2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G7xjljX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCA8C4AF0A;
	Mon, 29 Jul 2024 12:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722255790;
	bh=DJdF1mBPuCGWB0w3hmxK+i5apZdT29PflY5IBAM5q4A=;
	h=Subject:To:Cc:From:Date:From;
	b=G7xjljX0oxxL8b76t8qXHkRBFcYeOQ8wAfdCGJHu/fz3b3KWDttUpcRGKoaep1XYf
	 B9rnMeNGjFg6FzIKV5fOrapxCMbYsZLpKGHlisIYFtVI+Qopo55jGdEl28WZzkBlwS
	 XFpUjeFEvvlaeXZEJfEcRpiPpic8r+XMLToaoDB4=
Subject: FAILED: patch "[PATCH] nilfs2: add missing check for inode numbers on directory" failed to apply to 6.1-stable tree
To: konishi.ryusuke@gmail.com,akpm@linux-foundation.org,hdanton@sina.com,jack@suse.cz,stable@vger.kernel.org,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 14:22:34 +0200
Message-ID: <2024072934-durable-scuttle-9c45@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 49ae997f8f0d5e268bbd271c5fd66166ce8287fe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072934-durable-scuttle-9c45@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


