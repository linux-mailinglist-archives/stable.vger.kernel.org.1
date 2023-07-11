Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A88774F914
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 22:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjGKUcC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 16:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjGKUcB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 16:32:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F8F1AE
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 13:31:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30283615E4
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 20:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC28C433C7;
        Tue, 11 Jul 2023 20:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689107518;
        bh=DuYMUoTe6EzfFEzlJsfzgq298NsCNKcdxUUDx5bG3PA=;
        h=Subject:To:Cc:From:Date:From;
        b=xZkiEgt4q+oQwj8BK7A9+JIZvUaq1lFmWWVstLruPRxSf58rRtwqlRDFRAQCHGbzz
         iVkbgvcvQt0C/LtQTmfpxQE7dgUQtdm3b8f1tDMKp9/6N+hahKLZRDEWCSmx7Gw039
         aH6k9C6ehAB7064yjEZ17/3T6DrQ83CHCyVf18fs=
Subject: FAILED: patch "[PATCH] btrfs: do not BUG_ON() on tree mod log failure at" failed to apply to 5.15-stable tree
To:     fdmanana@suse.com, dsterba@suse.com, wqu@suse.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 11 Jul 2023 22:31:51 +0200
Message-ID: <2023071150-unlisted-vest-1c92@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 39020d8abc7ec62c4de9b260e3d10d4a1c2478ce
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071150-unlisted-vest-1c92@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 39020d8abc7ec62c4de9b260e3d10d4a1c2478ce Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Thu, 8 Jun 2023 11:27:41 +0100
Subject: [PATCH] btrfs: do not BUG_ON() on tree mod log failure at
 balance_level()

At balance_level(), instead of doing a BUG_ON() in case we fail to record
tree mod log operations, do a transaction abort and return the error to
the callers. There's really no need for the BUG_ON() as we can release
all resources in this context, and we have to abort because other future
tree searches that use the tree mod log (btrfs_search_old_slot()) may get
inconsistent results if other operations modify the tree after that
failure and before the tree mod log based search.

CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index d6c29564ce49..d60b28c6bd1b 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1054,7 +1054,12 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		}
 
 		ret = btrfs_tree_mod_log_insert_root(root->node, child, true);
-		BUG_ON(ret < 0);
+		if (ret < 0) {
+			btrfs_tree_unlock(child);
+			free_extent_buffer(child);
+			btrfs_abort_transaction(trans, ret);
+			goto enospc;
+		}
 		rcu_assign_pointer(root->node, child);
 
 		add_root_to_dirty_list(root);
@@ -1142,7 +1147,10 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 			btrfs_node_key(right, &right_key, 0);
 			ret = btrfs_tree_mod_log_insert_key(parent, pslot + 1,
 					BTRFS_MOD_LOG_KEY_REPLACE);
-			BUG_ON(ret < 0);
+			if (ret < 0) {
+				btrfs_abort_transaction(trans, ret);
+				goto enospc;
+			}
 			btrfs_set_node_key(parent, &right_key, pslot + 1);
 			btrfs_mark_buffer_dirty(parent);
 		}
@@ -1188,7 +1196,10 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		btrfs_node_key(mid, &mid_key, 0);
 		ret = btrfs_tree_mod_log_insert_key(parent, pslot,
 						    BTRFS_MOD_LOG_KEY_REPLACE);
-		BUG_ON(ret < 0);
+		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
+			goto enospc;
+		}
 		btrfs_set_node_key(parent, &mid_key, pslot);
 		btrfs_mark_buffer_dirty(parent);
 	}

