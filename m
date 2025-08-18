Return-Path: <stable+bounces-169988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED5CB29F87
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C7EE7A946E
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DE8278779;
	Mon, 18 Aug 2025 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vjx6N+QB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E6D258ED3
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514175; cv=none; b=lBtBqX1H7I130hhycdJfodxSdm9lIBCzYt+ytd/QTwp0C0G5VgVg7WpRBXXqQbK4ZL2FyB+PgKuI2wlb3cU3tFxSE+f2/8z7H9Oss+PoolKLq3PUXsvq6WJiU4mrvJ1USe9UARweC9af7JcnqH78Flu1+83dJSADuVJ1eRzUo6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514175; c=relaxed/simple;
	bh=PU3sZaXypB19j4lpp5B0596iGPt44qDtg4Fyuo+PgsU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=u/L2wkMhDnmhiTesO5mzWxNUo9FVwK2zxE9ILGhR0Pfw3nmHH/GYaINp+fZXdEdQrwynZ/p8ravfxEGiRNK3zqk3mz5DFlzg8CLXkdkDvvBEGpgX4Ipm7FoikB+iy5IiT+Saq5KvzGbxtE+a1Y3kO1p8tB2BFJ3+v8eBC8L2DB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vjx6N+QB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0B9C4CEEB;
	Mon, 18 Aug 2025 10:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755514175;
	bh=PU3sZaXypB19j4lpp5B0596iGPt44qDtg4Fyuo+PgsU=;
	h=Subject:To:Cc:From:Date:From;
	b=Vjx6N+QBKdoQMoQz8YL0XVrb9jPjsZQwOWWehOF1slz9bO5altVxebjdfUDxhs4uo
	 Ixy3Mjf9Y8Yp05gwWDpXB0tXyvVzHlVh0UGJMb8u/4sLY/T8LagB3paYN1xOwPhD9D
	 xgaXRniu7dR3c2vwTT28AD50mGSwv32oooRa1zSE=
Subject: FAILED: patch "[PATCH] btrfs: abort transaction on unexpected eb generation at" failed to apply to 6.15-stable tree
To: fdmanana@suse.com,dsterba@suse.com,neelx@suse.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 12:49:15 +0200
Message-ID: <2025081815-mothproof-embody-49e3@gregkh>
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
git cherry-pick -x 33e8f24b52d2796b8cfb28c19a1a7dd6476323a8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081815-mothproof-embody-49e3@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

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


