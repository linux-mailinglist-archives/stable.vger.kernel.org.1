Return-Path: <stable+bounces-50500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C629C906A89
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAF871C242B9
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED2F14265C;
	Thu, 13 Jun 2024 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ppRxzId9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9CBDDB1
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718276221; cv=none; b=Bd6LBC3eDB+1F4IuZ4bO9t14Q2uJsjGU8CjCIWPmCO6kLJpbjEANZxaaI4PZzuTKeuVg3QLrOQSvmokfCMTu+jcFW7JjOMl8CakqDN2t26rStu7tneMeKG+yVM9GdnU/VtMZ7T/zv66JBsGB6o42NWQWi+5mIGRpTjKwNOUXFyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718276221; c=relaxed/simple;
	bh=s7brZgv9dwAMxQjZc+FoRXDNseGl31ipKZwFXKBTz/E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VHvomsCEj2Jsbs/52lBxbo/sKOrEKavp1DsrswBdxhGBtExw76aUKEFg7GZJ+cjrJC5nFohkc6X8SzBjDW5C8ztJGaVY76bA+TaGFpBZcN9wFi4aYnaqcI/gURyTCAoARnA0/fxp7NNxgxmXFwnWpn5UxZ27faCKQYa+Zo5rNuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ppRxzId9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A9DC2BBFC;
	Thu, 13 Jun 2024 10:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718276220;
	bh=s7brZgv9dwAMxQjZc+FoRXDNseGl31ipKZwFXKBTz/E=;
	h=Subject:To:Cc:From:Date:From;
	b=ppRxzId9IB+KkoVX4UWtbU7Uq/vRxnLkdrQp72VRIAUzFKQMfGW2NwXfAIhg23aDF
	 fwIOTGO+5jLB+f1kkdZLQ4htxqX1A3njuOZM+WSLIv5cWLusSSW8rMs/aM3yXqMRuG
	 2GJlzrr3ep3hYzdOHvjv+4g9ISkjkuLtkEg8BTJY=
Subject: FAILED: patch "[PATCH] btrfs: fix leak of qgroup extent records after transaction" failed to apply to 6.1-stable tree
To: fdmanana@suse.com,dsterba@suse.com,josef@toxicpanda.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 12:56:58 +0200
Message-ID: <2024061357-december-gaming-f1a1@gregkh>
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
git cherry-pick -x fb33eb2ef0d88e75564983ef057b44c5b7e4fded
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061357-december-gaming-f1a1@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

fb33eb2ef0d8 ("btrfs: fix leak of qgroup extent records after transaction abort")
99f09ce309b8 ("btrfs: make btrfs_destroy_delayed_refs() return void")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fb33eb2ef0d88e75564983ef057b44c5b7e4fded Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Mon, 3 Jun 2024 12:49:08 +0100
Subject: [PATCH] btrfs: fix leak of qgroup extent records after transaction
 abort

Qgroup extent records are created when delayed ref heads are created and
then released after accounting extents at btrfs_qgroup_account_extents(),
called during the transaction commit path.

If a transaction is aborted we free the qgroup records by calling
btrfs_qgroup_destroy_extent_records() at btrfs_destroy_delayed_refs(),
unless we don't have delayed references. We are incorrectly assuming
that no delayed references means we don't have qgroup extents records.

We can currently have no delayed references because we ran them all
during a transaction commit and the transaction was aborted after that
due to some error in the commit path.

So fix this by ensuring we btrfs_qgroup_destroy_extent_records() at
btrfs_destroy_delayed_refs() even if we don't have any delayed references.

Reported-by: syzbot+0fecc032fa134afd49df@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/0000000000004e7f980619f91835@google.com/
Fixes: 81f7eb00ff5b ("btrfs: destroy qgroup extent records on transaction abort")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a91a8056758a..242ada7e47b4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4538,18 +4538,10 @@ static void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 				       struct btrfs_fs_info *fs_info)
 {
 	struct rb_node *node;
-	struct btrfs_delayed_ref_root *delayed_refs;
+	struct btrfs_delayed_ref_root *delayed_refs = &trans->delayed_refs;
 	struct btrfs_delayed_ref_node *ref;
 
-	delayed_refs = &trans->delayed_refs;
-
 	spin_lock(&delayed_refs->lock);
-	if (atomic_read(&delayed_refs->num_entries) == 0) {
-		spin_unlock(&delayed_refs->lock);
-		btrfs_debug(fs_info, "delayed_refs has NO entry");
-		return;
-	}
-
 	while ((node = rb_first_cached(&delayed_refs->href_root)) != NULL) {
 		struct btrfs_delayed_ref_head *head;
 		struct rb_node *n;


