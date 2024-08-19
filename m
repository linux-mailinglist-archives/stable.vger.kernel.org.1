Return-Path: <stable+bounces-69527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E6095679D
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3951282909
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8D415B55D;
	Mon, 19 Aug 2024 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fRtQCIat"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B2113B592
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061306; cv=none; b=Rtm48ho/iNbMtU+M/7BEArwDYTX2zhhSevMTjWqISnvJa23c1YoZ+Y4/+q/0JZUP3kGRj0S8yTLRvIE3nvxFfwnidtyS459N+Ar1d/yMyXDidf4AjwiGJoGKX4/jA1NH0ZNYjAbp/vY/78bBS8ETHleGcFTi9LEuyEC+tNKClVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061306; c=relaxed/simple;
	bh=NcH0IiUnIQSIQEUaZ68ZGmYh5k+zH+8mXXsyq6ETMgo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BMEb7igQSPmdswSfdho68pRrkUz47JPkfvmVVYUOqevul3Z6pfewBnDvHlx3mF6B0e4OaGHbZtaEVuFAe5eRdWfUnnHBWzEEIUUqF6Q+R+Vk/o3H6nhF78ecwnd+CnSWHZpkRZY1KqBoqnk6sCUVDRCjRPNM2A9hYg8JjYxWwo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fRtQCIat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7007C32782;
	Mon, 19 Aug 2024 09:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724061306;
	bh=NcH0IiUnIQSIQEUaZ68ZGmYh5k+zH+8mXXsyq6ETMgo=;
	h=Subject:To:Cc:From:Date:From;
	b=fRtQCIatuKPjepa7cVLRfLOV8btfZ2OHOm11S+/zKUXnHWF/hVdCqP5a4rq9xlgsD
	 VWpTMGGEho/efHfZevfN6BPK29hc2+tyUgvli/pWHkC1zDRLhz0zQ6XGwUzCEPNVFG
	 stfOD+i+i946P8Vn5E6zdLM0rvKER9NqGcEaIAvk=
Subject: FAILED: patch "[PATCH] btrfs: tree-checker: reject BTRFS_FT_UNKNOWN dir type" failed to apply to 5.10-stable tree
To: wqu@suse.com,dsterba@suse.com,nospam@kota.moe
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:54:53 +0200
Message-ID: <2024081953-calm-granola-8c1b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 31723c9542dba1681cc3720571fdf12ffe0eddd9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081953-calm-granola-8c1b@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

31723c9542db ("btrfs: tree-checker: reject BTRFS_FT_UNKNOWN dir type")
94a48aef49f2 ("btrfs: extend btrfs_dir_item type to store encryption status")
e43eec81c516 ("btrfs: use struct qstr instead of name and namelen pairs")
07e81dc94474 ("btrfs: move accessor helpers into accessors.h")
ad1ac5012c2b ("btrfs: move btrfs_map_token to accessors")
55e5cfd36da5 ("btrfs: remove fs_info::pending_changes and related code")
7966a6b5959b ("btrfs: move fs_info::flags enum to fs.h")
fc97a410bd78 ("btrfs: move mount option definitions to fs.h")
0d3a9cf8c306 ("btrfs: convert incompat and compat flag test helpers to macros")
ec8eb376e271 ("btrfs: move BTRFS_FS_STATE* definitions and helpers to fs.h")
9b569ea0be6f ("btrfs: move the printk helpers out of ctree.h")
e118578a8df7 ("btrfs: move assert helpers out of ctree.h")
c7f13d428ea1 ("btrfs: move fs wide helpers out of ctree.h")
63a7cb130718 ("btrfs: auto enable discard=async when possible")
7a66eda351ba ("btrfs: move the btrfs_verity_descriptor_item defs up in ctree.h")
956504a331a6 ("btrfs: move trans_handle_cachep out of ctree.h")
f1e5c6185ca1 ("btrfs: move flush related definitions to space-info.h")
ed4c491a3db2 ("btrfs: move BTRFS_MAX_MIRRORS into scrub.c")
4300c58f8090 ("btrfs: move btrfs on-disk definitions out of ctree.h")
d60d956eb41f ("btrfs: remove unused set/clear_pending_info helpers")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 31723c9542dba1681cc3720571fdf12ffe0eddd9 Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Mon, 12 Aug 2024 08:52:44 +0930
Subject: [PATCH] btrfs: tree-checker: reject BTRFS_FT_UNKNOWN dir type

[REPORT]
There is a bug report that kernel is rejecting a mismatching inode mode
and its dir item:

  [ 1881.553937] BTRFS critical (device dm-0): inode mode mismatch with
  dir: inode mode=040700 btrfs type=2 dir type=0

[CAUSE]
It looks like the inode mode is correct, while the dir item type
0 is BTRFS_FT_UNKNOWN, which should not be generated by btrfs at all.

This may be caused by a memory bit flip.

[ENHANCEMENT]
Although tree-checker is not able to do any cross-leaf verification, for
this particular case we can at least reject any dir type with
BTRFS_FT_UNKNOWN.

So here we enhance the dir type check from [0, BTRFS_FT_MAX), to
(0, BTRFS_FT_MAX).
Although the existing corruption can not be fixed just by such enhanced
checking, it should prevent the same 0x2->0x0 bitflip for dir type to
reach disk in the future.

Reported-by: Kota <nospam@kota.moe>
Link: https://lore.kernel.org/linux-btrfs/CACsxjPYnQF9ZF-0OhH16dAx50=BXXOcP74MxBc3BG+xae4vTTw@mail.gmail.com/
CC: stable@vger.kernel.org # 5.4+
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index a825fa598e3c..6f1e2f2215d9 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -569,9 +569,10 @@ static int check_dir_item(struct extent_buffer *leaf,
 
 		/* dir type check */
 		dir_type = btrfs_dir_ftype(leaf, di);
-		if (unlikely(dir_type >= BTRFS_FT_MAX)) {
+		if (unlikely(dir_type <= BTRFS_FT_UNKNOWN ||
+			     dir_type >= BTRFS_FT_MAX)) {
 			dir_item_err(leaf, slot,
-			"invalid dir item type, have %u expect [0, %u)",
+			"invalid dir item type, have %u expect (0, %u)",
 				dir_type, BTRFS_FT_MAX);
 			return -EUCLEAN;
 		}


