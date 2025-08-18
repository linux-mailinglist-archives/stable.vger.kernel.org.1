Return-Path: <stable+bounces-169987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23694B29F7E
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD955E5C0D
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398D02C2342;
	Mon, 18 Aug 2025 10:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gTACyzce"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4012765FE
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514172; cv=none; b=pGjQZQ6l7AJ8Vyr7pAjAIilIc7Y3o9fVZuGTjlRdgtvg9+/7VtA0BlsGVo38mRYfnAWRO3vNOS5LvUy0kIx6/pYVxqohS/H9rzkzHtpZ+xmKHq5xW1k/3voNNUGzHyUzvQpH7/OjqeyWXNOeUyv9QpqdIPuIxdl6gAgGxWq3NLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514172; c=relaxed/simple;
	bh=LNnEhL1O/fEsGYvWX8nGkxn+fM5yV+l8pQ+hqUTsmcM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=u9G13n5z/KJztiwO6VyiVUdFj9kyHURBKueJSS4FgRzNVAUWP+oqhbzDXyluoXmxqbiM2h8R9OuBHu6QkR7Xa79PXrvWGeNYJx0xfjiA+bn5WgKGI1jlm/HSEn0CcbnVEyLnQGndwdT8XiCruOIop9yfJbrYj4kezK003A2QXWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gTACyzce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575DDC4CEEB;
	Mon, 18 Aug 2025 10:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755514171;
	bh=LNnEhL1O/fEsGYvWX8nGkxn+fM5yV+l8pQ+hqUTsmcM=;
	h=Subject:To:Cc:From:Date:From;
	b=gTACyzce9sLFC+KnQKPQ5JSfrdSVTLAadFEwOxqTHqNin4XgTiX4l7U9EQzssfwq2
	 9El5Ap8/bJS0puc6PXLan0UDBi9fyuih52dtaBLhZ1lGwpZ0DmHO6ym1qljXwnnzdC
	 4y3hdQlAOu6+cwm4Dqya/m42iDdEAFdrGbfR4+j8=
Subject: FAILED: patch "[PATCH] btrfs: abort transaction on unexpected eb generation at" failed to apply to 6.12-stable tree
To: fdmanana@suse.com,dsterba@suse.com,neelx@suse.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 12:49:15 +0200
Message-ID: <2025081815-strut-suspend-7a53@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 33e8f24b52d2796b8cfb28c19a1a7dd6476323a8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081815-strut-suspend-7a53@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 33e8f24b52d2796b8cfb28c19a1a7dd6476323a8 Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Mon, 19 May 2025 11:07:29 +0100
Subject: [PATCH] btrfs: abort transaction on unexpected eb generation at
 btrfs_copy_root()

If we find an unexpected generation for the extent buffer we are cloning
at btrfs_copy_root(), we just WARN_ON() and don't error out and abort the
transaction, meaning we allow to persist metadata with an unexpected
generation. Instead of warning only, abort the transaction and return
-EUCLEAN.

CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Daniel Vacek <neelx@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index ae6cd77282f5..a5ee6ce312cf 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -283,7 +283,14 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 
 	write_extent_buffer_fsid(cow, fs_info->fs_devices->metadata_uuid);
 
-	WARN_ON(btrfs_header_generation(buf) > trans->transid);
+	if (unlikely(btrfs_header_generation(buf) > trans->transid)) {
+		btrfs_tree_unlock(cow);
+		free_extent_buffer(cow);
+		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+
 	if (new_root_objectid == BTRFS_TREE_RELOC_OBJECTID) {
 		ret = btrfs_inc_ref(trans, root, cow, 1);
 		if (ret)


