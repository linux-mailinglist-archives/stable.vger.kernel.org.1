Return-Path: <stable+bounces-133051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFC7A91AEE
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978C5173C14
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDD48460;
	Thu, 17 Apr 2025 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RFPBnWrP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A914522DFBC
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744889430; cv=none; b=ltVwoEUn4EIJp9VwEnndxChMnp5m/U7pBTjvqhMZKa6lCl8XkdVkjEYxy9e+KnJRoNe9pY3kWy+b0HLzSkU0RRZkZ6GF87bE1HQQWk09FMD3AcqDYYlHxJPr6enQEG0N1dGFndvEUyxPTa8kCmki1IUgxW5wIYAU3sBkjsUMdDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744889430; c=relaxed/simple;
	bh=gyNnueSZ6TWNUlZrjvcFpynj7BM/6RbnlaTqEfwfnhw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IKHIKapZMqOsYqSzsZCORltQPsjAFYxv63WdzbU2LaT5XrIMCCKIJz1ijSfjUvNrVXPDSttiqFYoYtTRomuGGu2ydfrtBhnp71krRCwDAN0VD4qoa8i75JoEoVF8uM51R9MUxR4m4vrqXWej1hKrJ0276xjOYlApxsC9xzTHA4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RFPBnWrP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EA8C4CEE4;
	Thu, 17 Apr 2025 11:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744889430;
	bh=gyNnueSZ6TWNUlZrjvcFpynj7BM/6RbnlaTqEfwfnhw=;
	h=Subject:To:Cc:From:Date:From;
	b=RFPBnWrP3ITF7Rf+ZeEOnT3yW13Lz4HIKrlHoxi5eLNIMJmeJiMFMO3ZMggA3BeLA
	 5fzNbNMBELnGj00O4DMVChJDKyH1sNCMt8Qs6BVGUMAv/GJiwE3NkPAlyk7eRDlG7x
	 LpMP6EQD9R2U+mvD+cq5dEW9zwhsZIxKf2LlgXbQ=
Subject: FAILED: patch "[PATCH] btrfs: fix non-empty delayed iputs list on unmount due to" failed to apply to 5.15-stable tree
To: fdmanana@suse.com,dsterba@suse.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 13:26:54 +0200
Message-ID: <2025041754-violet-fetal-3db1@gregkh>
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
git cherry-pick -x 4c782247b89376a83fa132f7d45d6977edae0629
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041754-violet-fetal-3db1@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4c782247b89376a83fa132f7d45d6977edae0629 Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Wed, 5 Mar 2025 16:52:26 +0000
Subject: [PATCH] btrfs: fix non-empty delayed iputs list on unmount due to
 compressed write workers

At close_ctree() after we have ran delayed iputs either through explicitly
calling btrfs_run_delayed_iputs() or later during the call to
btrfs_commit_super() or btrfs_error_commit_super(), we assert that the
delayed iputs list is empty.

When we have compressed writes this assertion may fail because delayed
iputs may have been added to the list after we last ran delayed iputs.
This happens like this:

1) We have a compressed write bio executing;

2) We enter close_ctree() and flush the fs_info->endio_write_workers
   queue which is the queue used for running ordered extent completion;

3) The compressed write bio finishes and enters
   btrfs_finish_compressed_write_work(), where it calls
   btrfs_finish_ordered_extent() which in turn calls
   btrfs_queue_ordered_fn(), which queues a work item in the
   fs_info->endio_write_workers queue that we have flushed before;

4) At close_ctree() we proceed, run all existing delayed iputs and
   call btrfs_commit_super() (which also runs delayed iputs), but before
   we run the following assertion below:

      ASSERT(list_empty(&fs_info->delayed_iputs))

   A delayed iput is added by the step below...

5) The ordered extent completion job queued in step 3 runs and results in
   creating a delayed iput when dropping the last reference of the ordered
   extent (a call to btrfs_put_ordered_extent() made from
   btrfs_finish_one_ordered());

6) At this point the delayed iputs list is not empty, so the assertion at
   close_ctree() fails.

Fix this by flushing the fs_info->compressed_write_workers queue at
close_ctree() before flushing the fs_info->endio_write_workers queue,
respecting the queue dependency as the later is responsible for the
execution of ordered extent completion.

CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d96ea974ef73..b0f125d8efa0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4340,6 +4340,18 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	 */
 	btrfs_flush_workqueue(fs_info->delalloc_workers);
 
+	/*
+	 * When finishing a compressed write bio we schedule a work queue item
+	 * to finish an ordered extent - btrfs_finish_compressed_write_work()
+	 * calls btrfs_finish_ordered_extent() which in turns does a call to
+	 * btrfs_queue_ordered_fn(), and that queues the ordered extent
+	 * completion either in the endio_write_workers work queue or in the
+	 * fs_info->endio_freespace_worker work queue. We flush those queues
+	 * below, so before we flush them we must flush this queue for the
+	 * workers of compressed writes.
+	 */
+	flush_workqueue(fs_info->compressed_write_workers);
+
 	/*
 	 * After we parked the cleaner kthread, ordered extents may have
 	 * completed and created new delayed iputs. If one of the async reclaim


