Return-Path: <stable+bounces-172124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40424B2FB60
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C30AAC7C0A
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE17337686;
	Thu, 21 Aug 2025 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DlnyANhj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490A821C18E
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783663; cv=none; b=CyEKuYxoeWElf9dUQF1DQQbLzokprHYWqTGzNenjzlKtdSzfgOf2frd56urAlnwdQ2jQC11uauvY89XtIdnwAtIOI3w5OqUGnQnNqhPjRuBUrzyETnt7yCe5f8uipWDrIt0aAM0xvPIpUEhSk6Hu9zS8KfCJa1yUziTqKp7mOXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783663; c=relaxed/simple;
	bh=D0eZ/h20g7z7H+MtPxQAv3xmwfk8AzuNBeOuizT2/vI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sGYjqQvJf7kZE+9mBo/ip6Z5uJf80SKJlomzeIi34aNY2pCIrpK4D5W6ZTdh9hwv/oVS4GCb//k8pYwK+Tjt6xQHQ+oQ9A/cagvV7d9A2n17L8gGEgNTX5q0RboQqmJR/f/2FSTfciJ+pzyrum1LzclG9udgb6NHs8CjEStLM2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DlnyANhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C470FC4CEEB;
	Thu, 21 Aug 2025 13:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755783663;
	bh=D0eZ/h20g7z7H+MtPxQAv3xmwfk8AzuNBeOuizT2/vI=;
	h=Subject:To:Cc:From:Date:From;
	b=DlnyANhjqevFbtVst9xpEg5qybC4ZLhGT8N8zqkjT9/wiF7r9EjAlp0ZHdyKFDqlZ
	 M9AxxtTz4PhCVJtmRjiKqlBeciE1MGDWLO2p6AnFbytoacNVDjcqeiVevYsZTUg4jK
	 KGxakhE30sp74SseSYyq5ec8Y8NO8mcy+sUYZwY4=
Subject: FAILED: patch "[PATCH] f2fs: fix to avoid out-of-boundary access in dnode page" failed to apply to 6.1-stable tree
To: chao@kernel.org,jaegeuk@kernel.org,r772577952@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:39:07 +0200
Message-ID: <2025082107-suitcase-motivator-6687@gregkh>
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
git cherry-pick -x 77de19b6867f2740cdcb6c9c7e50d522b47847a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082107-suitcase-motivator-6687@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 77de19b6867f2740cdcb6c9c7e50d522b47847a4 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Thu, 17 Jul 2025 21:26:33 +0800
Subject: [PATCH] f2fs: fix to avoid out-of-boundary access in dnode page

As Jiaming Zhang reported:

 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x1c1/0x2a0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x17e/0x800 mm/kasan/report.c:480
 kasan_report+0x147/0x180 mm/kasan/report.c:593
 data_blkaddr fs/f2fs/f2fs.h:3053 [inline]
 f2fs_data_blkaddr fs/f2fs/f2fs.h:3058 [inline]
 f2fs_get_dnode_of_data+0x1a09/0x1c40 fs/f2fs/node.c:855
 f2fs_reserve_block+0x53/0x310 fs/f2fs/data.c:1195
 prepare_write_begin fs/f2fs/data.c:3395 [inline]
 f2fs_write_begin+0xf39/0x2190 fs/f2fs/data.c:3594
 generic_perform_write+0x2c7/0x910 mm/filemap.c:4112
 f2fs_buffered_write_iter fs/f2fs/file.c:4988 [inline]
 f2fs_file_write_iter+0x1ec8/0x2410 fs/f2fs/file.c:5216
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x546/0xa90 fs/read_write.c:686
 ksys_write+0x149/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x3d0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The root cause is in the corrupted image, there is a dnode has the same
node id w/ its inode, so during f2fs_get_dnode_of_data(), it tries to
access block address in dnode at offset 934, however it parses the dnode
as inode node, so that get_dnode_addr() returns 360, then it tries to
access page address from 360 + 934 * 4 = 4096 w/ 4 bytes.

To fix this issue, let's add sanity check for node id of all direct nodes
during f2fs_get_dnode_of_data().

Cc: stable@kernel.org
Reported-by: Jiaming Zhang <r772577952@gmail.com>
Closes: https://groups.google.com/g/syzkaller/c/-ZnaaOOfO3M
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4b3d9070e299..76aba1961b54 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -815,6 +815,16 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 	for (i = 1; i <= level; i++) {
 		bool done = false;
 
+		if (nids[i] && nids[i] == dn->inode->i_ino) {
+			err = -EFSCORRUPTED;
+			f2fs_err_ratelimited(sbi,
+				"inode mapping table is corrupted, run fsck to fix it, "
+				"ino:%lu, nid:%u, level:%d, offset:%d",
+				dn->inode->i_ino, nids[i], level, offset[level]);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			goto release_pages;
+		}
+
 		if (!nids[i] && mode == ALLOC_NODE) {
 			/* alloc new node */
 			if (!f2fs_alloc_nid(sbi, &(nids[i]))) {


