Return-Path: <stable+bounces-169983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D38C8B29F77
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E3616BFCF
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AEE2765F6;
	Mon, 18 Aug 2025 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AhJ6oXMk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046E7258EE7
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514158; cv=none; b=sHRvGltSNvjbSG9uliNde08zL3njutPBpCpb1QNjxezdsQxMHOf4/lh2rPbEbbCJ3Ai4vIqjvkkaKWw6oPIN1tOnXBHfnUMVWVWzlaok1m4yqlUoc2jlNj9tvAHiomq2b7ty1dic7Zm/jkjQeBuqvnPlcCbveGWyPVo9ccXchJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514158; c=relaxed/simple;
	bh=r8OSTpgzURUvDT9ex3adIPtiipWWTnkDjfPT3FymYDo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bp7np6ktonM8GcnMq9ApQUZwXQrwHw6hCpLSK5F1neQbvkuNAwTYZGKIG4m09YJVFiiGqryAOMcRviKg8zcIlKD5VjgXZ5nrnsLyYfxblLstX5phIJ7p6Mc7B052lMcfcB5aqavlOz+uPRqcrccG8YqX6oYOJ5NKr4FcstSiJCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AhJ6oXMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2F2C116B1;
	Mon, 18 Aug 2025 10:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755514157;
	bh=r8OSTpgzURUvDT9ex3adIPtiipWWTnkDjfPT3FymYDo=;
	h=Subject:To:Cc:From:Date:From;
	b=AhJ6oXMkyAQS7oMYYUbbOnUZCfQdeMI3Feeim4RYori2JAf0wbGDECHDiA8cR2kvM
	 hoTUt3cr/eqVyupFWrlTNbysmF0JqryPCkNpYYFQrVPMt9K2VgN+Y6OflLAi9FX6ID
	 pqlgj8eEtAba2My46p3uGQPfOZalhNpZGqUADEos=
Subject: FAILED: patch "[PATCH] btrfs: always abort transaction on failure to add block group" failed to apply to 6.15-stable tree
To: fdmanana@suse.com,boris@bur.io,dsterba@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 12:49:08 +0200
Message-ID: <2025081808-companion-arson-989c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1f06c942aa709d397cf6bed577a0d10a61509667
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081808-companion-arson-989c@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1f06c942aa709d397cf6bed577a0d10a61509667 Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Sat, 7 Jun 2025 19:44:03 +0100
Subject: [PATCH] btrfs: always abort transaction on failure to add block group
 to free space tree

Only one of the callers of __add_block_group_free_space() aborts the
transaction if the call fails, while the others don't do it and it's
either never done up the call chain or much higher in the call chain.

So make sure we abort the transaction at __add_block_group_free_space()
if it fails, which brings a couple benefits:

1) If some call chain never aborts the transaction, we avoid having some
   metadata inconsistency because BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE is
   cleared when we enter __add_block_group_free_space() and therefore
   __add_block_group_free_space() is never called again to add the block
   group items to the free space tree, since the function is only called
   when that flag is set in a block group;

2) If the call chain already aborts the transaction, then we get a better
   trace that points to the exact step from __add_block_group_free_space()
   which failed, which is better for analysis.

So abort the transaction at __add_block_group_free_space() if any of its
steps fails.

CC: stable@vger.kernel.org # 6.6+
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 9eb9858e8e99..af005fb4b676 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1431,12 +1431,17 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 	set_bit(BLOCK_GROUP_FLAG_FREE_SPACE_ADDED, &block_group->runtime_flags);
 
 	ret = add_new_free_space_info(trans, block_group, path);
-	if (ret)
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
 		return ret;
+	}
 
-	return __add_to_free_space_tree(trans, block_group, path,
-					block_group->start,
-					block_group->length);
+	ret = __add_to_free_space_tree(trans, block_group, path,
+				       block_group->start, block_group->length);
+	if (ret)
+		btrfs_abort_transaction(trans, ret);
+
+	return 0;
 }
 
 int add_block_group_free_space(struct btrfs_trans_handle *trans,
@@ -1461,9 +1466,6 @@ int add_block_group_free_space(struct btrfs_trans_handle *trans,
 	}
 
 	ret = __add_block_group_free_space(trans, block_group, path);
-	if (ret)
-		btrfs_abort_transaction(trans, ret);
-
 out:
 	btrfs_free_path(path);
 	mutex_unlock(&block_group->free_space_lock);


