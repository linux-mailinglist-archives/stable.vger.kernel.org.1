Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C4A754E4E
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 12:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjGPKSw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 06:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjGPKSo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 06:18:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BE0E47
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 03:18:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24DDF60C7D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 10:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3249FC433C7;
        Sun, 16 Jul 2023 10:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689502722;
        bh=3I+utvbNcHGs5+I2xll0wGDWyjYLIbkd05WLCe8HOKs=;
        h=Subject:To:Cc:From:Date:From;
        b=sj2RQ7cEUt6nQ0AWR4fKO9Nnpqw2HX0Iqmr3QA/drwgf/lYggJZzlyOZKYKODbwsd
         uRhLgvWiqyw7aw2tGGAP9Y7jIDLdxOGU9LntYYY71as7muBHK85P3tupRQwWEcj5Kv
         nvqjF66BpcOAMOzPgL5fJd0wVLdqignN6c3xjAkQ=
Subject: FAILED: patch "[PATCH] btrfs: add missing error handling when logging operation" failed to apply to 5.4-stable tree
To:     fdmanana@suse.com, dsterba@suse.com, wqu@suse.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 16 Jul 2023 12:18:34 +0200
Message-ID: <2023071633-bless-cola-21d7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x d09c51521f22f9cbdfb1cf63e5c456077c622c84
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071633-bless-cola-21d7@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

d09c51521f22 ("btrfs: add missing error handling when logging operation while COWing extent buffer")
33cff222faff ("btrfs: remove gfp_t flag from btrfs_tree_mod_log_insert_key()")
879b22219831 ("btrfs: switch GFP_ATOMIC to GFP_NOFS when fixing up low keys")
f3a84ccd28d0 ("btrfs: move the tree mod log code into its own file")
dbcc7d57bffc ("btrfs: fix race when cloning extent buffer during rewind of an old root")
cac06d843f25 ("btrfs: introduce the skeleton of btrfs_subpage structure")
1b7ec85ef490 ("btrfs: pass root owner to read_tree_block")
bfb484d922a3 ("btrfs: cleanup extent buffer readahead")
ac5887c8e013 ("btrfs: locking: remove all the blocking helpers")
196d59ab9ccc ("btrfs: switch extent buffer tree lock to rw_semaphore")
bf77467a93bd ("btrfs: introduce BTRFS_NESTING_LEFT/BTRFS_NESTING_RIGHT")
9631e4cc1a03 ("btrfs: introduce BTRFS_NESTING_COW for cow'ing blocks")
fd7ba1c1202d ("btrfs: add nesting tags to the locking helpers")
51899412dd95 ("btrfs: introduce btrfs_path::recurse")
329ced799be8 ("btrfs: rename extent_buffer::lock_nested to extent_buffer::lock_recursed")
d16c702fe4f2 ("btrfs: ctree: check key order before merging tree blocks")
d3beaa253fd6 ("btrfs: set the lockdep class for log tree extent buffers")
ad24466588ab ("btrfs: set the correct lockdep class for new nodes")
d85327b1d8b7 ("btrfs: prefetch chunk tree leaves at mount")
49e5fb46211d ("btrfs: qgroup: export qgroups in sysfs")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d09c51521f22f9cbdfb1cf63e5c456077c622c84 Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Thu, 8 Jun 2023 11:27:37 +0100
Subject: [PATCH] btrfs: add missing error handling when logging operation
 while COWing extent buffer

When COWing an extent buffer that is not the root node, we need to log in
the tree mod log that we replaced a pointer in the parent node, otherwise
a tree mod log user doing a search on the b+tree can return incorrect
results (that miss something). We are doing the call to
btrfs_tree_mod_log_insert_key() but we totally ignore its return value.

So fix this by adding the missing error handling, resulting in a
transaction abort and freeing the COWed extent buffer.

Fixes: f230475e62f7 ("Btrfs: put all block modifications into the tree mod log")
CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 385524224037..7f7f13965fe9 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -595,8 +595,14 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 		add_root_to_dirty_list(root);
 	} else {
 		WARN_ON(trans->transid != btrfs_header_generation(parent));
-		btrfs_tree_mod_log_insert_key(parent, parent_slot,
-					      BTRFS_MOD_LOG_KEY_REPLACE);
+		ret = btrfs_tree_mod_log_insert_key(parent, parent_slot,
+						    BTRFS_MOD_LOG_KEY_REPLACE);
+		if (ret) {
+			btrfs_tree_unlock(cow);
+			free_extent_buffer(cow);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 		btrfs_set_node_blockptr(parent, parent_slot,
 					cow->start);
 		btrfs_set_node_ptr_generation(parent, parent_slot,

