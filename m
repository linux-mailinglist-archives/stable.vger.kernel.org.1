Return-Path: <stable+bounces-169982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E64FCB29F76
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FECC1960641
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DE3258EE7;
	Mon, 18 Aug 2025 10:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eth4GDGO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A232C2342
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514151; cv=none; b=Qnit6v76TOGRnlFUQ3PM5BwBrhW0Vj29FrZm5janzdgp9eRuZiLeS7cQV0zbyz1FCKL6QFmXpDh23Mm8cesu5EPQhMwPMuYlwJvjn4DXn49JKbn+6EYxA8o4FNDmdOI5GEhyZnRg5yf3MKZoQy0dYXLT37la+QELYU/L3FlsRxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514151; c=relaxed/simple;
	bh=n3jPSX3fPD05FlRSjvxd5PS1pK3QUJiitKYyCj7OU+4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OpbSyKN6k6MlzBouZkJct2+qw/XdwLaVIwOCrbFWSktq+worrQsW+UuxPckXp48IYuOUIS0OF8K1vgzW719Pppca1Wkcvw4omRhmgGG7Vb0vxgu9SOftcLDU6pwQRrRV5x9Hv/9utH13174Ba5Flz731QIRTGYFkGc1f8IuThfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eth4GDGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD48EC4CEEB;
	Mon, 18 Aug 2025 10:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755514151;
	bh=n3jPSX3fPD05FlRSjvxd5PS1pK3QUJiitKYyCj7OU+4=;
	h=Subject:To:Cc:From:Date:From;
	b=eth4GDGOkGDXy34YWWpopX8OhL8C2EW4MwvylNvoAxbwAaf05AvMMB/DFaTgZYk5l
	 T3YQqnUgwEJtLa90xTmPKeg5l2FLDLu9XcURZMXoMCOQA1eQNdPKOfLmAofeYLMM6F
	 iXqyCOVtPXuSOU03s5kxuFEnWyo1gp+5LBMc4JeA=
Subject: FAILED: patch "[PATCH] btrfs: always abort transaction on failure to add block group" failed to apply to 6.16-stable tree
To: fdmanana@suse.com,boris@bur.io,dsterba@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 12:49:08 +0200
Message-ID: <2025081808-unneeded-unstuffed-e294@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x 1f06c942aa709d397cf6bed577a0d10a61509667
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081808-unneeded-unstuffed-e294@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

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


