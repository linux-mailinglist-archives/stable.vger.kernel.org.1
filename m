Return-Path: <stable+bounces-50510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A92906A9E
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38791C22E9C
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83B31428EF;
	Thu, 13 Jun 2024 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NKtqZVic"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8919214265F
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718276391; cv=none; b=G8ti5h++FMe2c6bODp5flT3r4bW1xgRWySnol4ed/bKU7wzeXE+Tms7ye1kZoatohI4180L0p5RHuWgAuNO3sFquD0GRQJRjmVqHaHbuYISGC846gd/gjOHiPtrBpEvN6IY/u1t343Lr2+srcCpxC9zVRb9V8bckd1tRsywJ5ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718276391; c=relaxed/simple;
	bh=8mc0vXWvpKtxh961NHWZlhLnRnqa+w9UJMAbCTrKs9c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UVtkTfxMs1dGrlpTBKQVY1HJlMZkclJcf8XEuob/RKIXf/nEwngg43VQ5nrLjMbyJztm7XNaQ3p7iPphppZU04OmoXYuFwbI0zM63BevTeXFgEv3I9h9ExVks28SIe+eEGkFxk9XNpcDbp5OqLLpg0FJYwOpxzKOcZuP9njx4vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NKtqZVic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137F8C2BBFC;
	Thu, 13 Jun 2024 10:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718276391;
	bh=8mc0vXWvpKtxh961NHWZlhLnRnqa+w9UJMAbCTrKs9c=;
	h=Subject:To:Cc:From:Date:From;
	b=NKtqZVicbV9I5z56NJ+cZleErwUsxwO1s/lae7LFL26UCKohogWVkb+kPwRWU2ILD
	 w42QKSo4kAMYM0WkoWFLxM45y9ObgmEKjQJDpTSbqw21xnyHvw3fwyoeFvMqiazL43
	 QZ9uZzkTnw7eBwLFFwUT+E6ABypXHktAo2WWzFrs=
Subject: FAILED: patch "[PATCH] nilfs2: fix nilfs_empty_dir() misjudgment and long loop on" failed to apply to 5.15-stable tree
To: konishi.ryusuke@gmail.com,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 12:59:37 +0200
Message-ID: <2024061337-eclair-moneywise-df20@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7373a51e7998b508af7136530f3a997b286ce81c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061337-eclair-moneywise-df20@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

7373a51e7998 ("nilfs2: fix nilfs_empty_dir() misjudgment and long loop on I/O errors")
09a46acb3697 ("nilfs2: return the mapped address from nilfs_get_page()")
79ea65563ad8 ("nilfs2: Remove check for PageError")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7373a51e7998b508af7136530f3a997b286ce81c Mon Sep 17 00:00:00 2001
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Tue, 4 Jun 2024 22:42:55 +0900
Subject: [PATCH] nilfs2: fix nilfs_empty_dir() misjudgment and long loop on
 I/O errors

The error handling in nilfs_empty_dir() when a directory folio/page read
fails is incorrect, as in the old ext2 implementation, and if the
folio/page cannot be read or nilfs_check_folio() fails, it will falsely
determine the directory as empty and corrupt the file system.

In addition, since nilfs_empty_dir() does not immediately return on a
failed folio/page read, but continues to loop, this can cause a long loop
with I/O if i_size of the directory's inode is also corrupted, causing the
log writer thread to wait and hang, as reported by syzbot.

Fix these issues by making nilfs_empty_dir() immediately return a false
value (0) if it fails to get a directory folio/page.

Link: https://lkml.kernel.org/r/20240604134255.7165-1-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+c8166c541d3971bf6c87@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c8166c541d3971bf6c87
Fixes: 2ba466d74ed7 ("nilfs2: directory entry operations")
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index a002a44ff161..52e50b1b7f22 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -607,7 +607,7 @@ int nilfs_empty_dir(struct inode *inode)
 
 		kaddr = nilfs_get_folio(inode, i, &folio);
 		if (IS_ERR(kaddr))
-			continue;
+			return 0;
 
 		de = (struct nilfs_dir_entry *)kaddr;
 		kaddr += nilfs_last_byte(inode, i) - NILFS_DIR_REC_LEN(1);


