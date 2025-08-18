Return-Path: <stable+bounces-169986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F41F0B29F7F
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89FA51885F0E
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A60E30DED2;
	Mon, 18 Aug 2025 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UyuaXtZ1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A429258ED3
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514168; cv=none; b=s1EgG6NqJEL/MQXallR4RSKBN/eSHRw/lGAdp6Wv0jvvcqJiNOczOkSE9gQ4oOYJT0PqYxnmKRC95Nf/KxkxxcxWltE/HYAt8ieOh64XJW2+SWg5BM43vnPdYX1fxjlmZyle666nX1jkb3eVyF3dsxH1p0j4TGz43CwDkQxOY8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514168; c=relaxed/simple;
	bh=DzcoGiBx821K6ifiX5MHfNtb3ilzzlFiLuFOeDkhWxE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ek04U57BaTdf5/tNmAo1Bo1JrmN3liikKVtkNzTbqoikOD4Ry98lx99gvhP/gfux9k8Qd09oeSXSjGrlybabZyY2X5cNA2+ZO2hwWMcw6YG9zPJLbTHgZObLX4CmWbdBhW3qzF0DWp3+OdTGTWxNO+oa1J4i/G6cLv/doknemJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UyuaXtZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E596C4CEF1;
	Mon, 18 Aug 2025 10:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755514167;
	bh=DzcoGiBx821K6ifiX5MHfNtb3ilzzlFiLuFOeDkhWxE=;
	h=Subject:To:Cc:From:Date:From;
	b=UyuaXtZ1VQe1NqLj4r4hGwQcoHwQw9xcniBrfpMBczA7zZjexYBRwdEm2Sa96xJyY
	 9g29VEgqfDoKBvCb4TR5lEjhHm1kCzv+2B4EPUf48d7TbuladTkMVE9xqNBIgEh7Nj
	 t0SCiQ0i80RT+nDr1NX9LaFj5xQD/fO/SqNZGklA=
Subject: FAILED: patch "[PATCH] btrfs: abort transaction on unexpected eb generation at" failed to apply to 6.16-stable tree
To: fdmanana@suse.com,dsterba@suse.com,neelx@suse.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 12:49:14 +0200
Message-ID: <2025081814-cotton-endpoint-c7b3@gregkh>
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
git cherry-pick -x 33e8f24b52d2796b8cfb28c19a1a7dd6476323a8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081814-cotton-endpoint-c7b3@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

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


