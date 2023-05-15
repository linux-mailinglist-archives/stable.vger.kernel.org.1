Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D33470350E
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243152AbjEOQzU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243191AbjEOQzD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:55:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8607289
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:54:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD587629C0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A253CC433D2;
        Mon, 15 May 2023 16:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169692;
        bh=eKQTzNkDPlpFS0u0krFUxnshIYg0Iw4CLhcxanMiZrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ftzR97a8X8csDOHcqnjf6VpNeOEtiPMg/DsAjhRQNOp/PUAiKHR/tRl4wfjUjnD28
         6cc0ftp5YyfzUnK1++qwyYpDjeBYftV1kxH2BUhCmwQrYCdCpMdi83E4CQBgYqwVa6
         6x+iu60f4SmOfRIT0JSVMx+mLQARMNqmizEahqus=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vladimir Panteleev <git@vladimir.panteleev.md>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.3 139/246] btrfs: fix backref walking not returning all inode refs
Date:   Mon, 15 May 2023 18:25:51 +0200
Message-Id: <20230515161726.735769738@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

commit 0cad8f14d70cfeb5173dce93cafeba665a95430e upstream.

When using the logical to ino ioctl v2, if the flag to ignore offsets of
file extent items (BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET) is given, the
backref walking code ends up not returning references for all file offsets
of an inode that point to the given logical bytenr. This happens since
kernel 6.2, commit 6ce6ba534418 ("btrfs: use a single argument for extent
offset in backref walking functions") because:

1) It mistakenly skipped the search for file extent items in a leaf that
   point to the target extent if that flag is given. Instead it should
   only skip the filtering done by check_extent_in_eb() - that is, it
   should not avoid the calls to that function (or find_extent_in_eb(),
   which uses it).

2) It was also not building a list of inode extent elements (struct
   extent_inode_elem) if we have multiple inode references for an extent
   when the ignore offset flag is given to the logical to ino ioctl - it
   would leave a single element, only the last one that was found.

These stem from the confusing old interface for backref walking functions
where we had an extent item offset argument that was a pointer to a u64
and another boolean argument that indicated if the offset should be
ignored, but the pointer could be NULL. That NULL case is used by
relocation, qgroup extent accounting and fiemap, simply to avoid building
the inode extent list for each reference, as it's not necessary for those
use cases and therefore avoids memory allocations and some computations.

Fix this by adding a boolean argument to the backref walk context
structure to indicate that the inode extent list should not be built,
make relocation set that argument to true and fix the backref walking
logic to skip the calls to check_extent_in_eb() and find_extent_in_eb()
only if this new argument is true, instead of 'ignore_extent_item_pos'
being true.

A test case for fstests will be added soon, to provide cover not only
for these cases but to the logical to ino ioctl in general as well, as
currently we do not have a test case for it.

Reported-by: Vladimir Panteleev <git@vladimir.panteleev.md>
Link: https://lore.kernel.org/linux-btrfs/CAHhfkvwo=nmzrJSqZ2qMfF-rZB-ab6ahHnCD_sq9h4o8v+M7QQ@mail.gmail.com/
Fixes: 6ce6ba534418 ("btrfs: use a single argument for extent offset in backref walking functions")
CC: stable@vger.kernel.org # 6.2+
Tested-by: Vladimir Panteleev <git@vladimir.panteleev.md>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/backref.c    |   19 ++++++++++---------
 fs/btrfs/backref.h    |    6 ++++++
 fs/btrfs/relocation.c |    2 +-
 3 files changed, 17 insertions(+), 10 deletions(-)

--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -45,7 +45,8 @@ static int check_extent_in_eb(struct btr
 	int root_count;
 	bool cached;
 
-	if (!btrfs_file_extent_compression(eb, fi) &&
+	if (!ctx->ignore_extent_item_pos &&
+	    !btrfs_file_extent_compression(eb, fi) &&
 	    !btrfs_file_extent_encryption(eb, fi) &&
 	    !btrfs_file_extent_other_encoding(eb, fi)) {
 		u64 data_offset;
@@ -552,7 +553,7 @@ static int add_all_parents(struct btrfs_
 				count++;
 			else
 				goto next;
-			if (!ctx->ignore_extent_item_pos) {
+			if (!ctx->skip_inode_ref_list) {
 				ret = check_extent_in_eb(ctx, &key, eb, fi, &eie);
 				if (ret == BTRFS_ITERATE_EXTENT_INODES_STOP ||
 				    ret < 0)
@@ -564,7 +565,7 @@ static int add_all_parents(struct btrfs_
 						  eie, (void **)&old, GFP_NOFS);
 			if (ret < 0)
 				break;
-			if (!ret && !ctx->ignore_extent_item_pos) {
+			if (!ret && !ctx->skip_inode_ref_list) {
 				while (old->next)
 					old = old->next;
 				old->next = eie;
@@ -1606,7 +1607,7 @@ again:
 				goto out;
 		}
 		if (ref->count && ref->parent) {
-			if (!ctx->ignore_extent_item_pos && !ref->inode_list &&
+			if (!ctx->skip_inode_ref_list && !ref->inode_list &&
 			    ref->level == 0) {
 				struct btrfs_tree_parent_check check = { 0 };
 				struct extent_buffer *eb;
@@ -1647,7 +1648,7 @@ again:
 						  (void **)&eie, GFP_NOFS);
 			if (ret < 0)
 				goto out;
-			if (!ret && !ctx->ignore_extent_item_pos) {
+			if (!ret && !ctx->skip_inode_ref_list) {
 				/*
 				 * We've recorded that parent, so we must extend
 				 * its inode list here.
@@ -1743,7 +1744,7 @@ int btrfs_find_all_leafs(struct btrfs_ba
 static int btrfs_find_all_roots_safe(struct btrfs_backref_walk_ctx *ctx)
 {
 	const u64 orig_bytenr = ctx->bytenr;
-	const bool orig_ignore_extent_item_pos = ctx->ignore_extent_item_pos;
+	const bool orig_skip_inode_ref_list = ctx->skip_inode_ref_list;
 	bool roots_ulist_allocated = false;
 	struct ulist_iterator uiter;
 	int ret = 0;
@@ -1764,7 +1765,7 @@ static int btrfs_find_all_roots_safe(str
 		roots_ulist_allocated = true;
 	}
 
-	ctx->ignore_extent_item_pos = true;
+	ctx->skip_inode_ref_list = true;
 
 	ULIST_ITER_INIT(&uiter);
 	while (1) {
@@ -1789,7 +1790,7 @@ static int btrfs_find_all_roots_safe(str
 	ulist_free(ctx->refs);
 	ctx->refs = NULL;
 	ctx->bytenr = orig_bytenr;
-	ctx->ignore_extent_item_pos = orig_ignore_extent_item_pos;
+	ctx->skip_inode_ref_list = orig_skip_inode_ref_list;
 
 	return ret;
 }
@@ -1912,7 +1913,7 @@ int btrfs_is_data_extent_shared(struct b
 		goto out_trans;
 	}
 
-	walk_ctx.ignore_extent_item_pos = true;
+	walk_ctx.skip_inode_ref_list = true;
 	walk_ctx.trans = trans;
 	walk_ctx.fs_info = fs_info;
 	walk_ctx.refs = &ctx->refs;
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -60,6 +60,12 @@ struct btrfs_backref_walk_ctx {
 	 * @extent_item_pos is ignored.
 	 */
 	bool ignore_extent_item_pos;
+	/*
+	 * If true and bytenr corresponds to a data extent, then the inode list
+	 * (each member describing inode number, file offset and root) is not
+	 * added to each reference added to the @refs ulist.
+	 */
+	bool skip_inode_ref_list;
 	/* A valid transaction handle or NULL. */
 	struct btrfs_trans_handle *trans;
 	/*
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3422,7 +3422,7 @@ int add_data_references(struct reloc_con
 	btrfs_release_path(path);
 
 	ctx.bytenr = extent_key->objectid;
-	ctx.ignore_extent_item_pos = true;
+	ctx.skip_inode_ref_list = true;
 	ctx.fs_info = rc->extent_root->fs_info;
 
 	ret = btrfs_find_all_leafs(&ctx);


