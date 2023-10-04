Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0157B89F2
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244329AbjJDSao (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244317AbjJDSak (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:30:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719A198
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:30:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFEAC433C9;
        Wed,  4 Oct 2023 18:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444236;
        bh=Fv3DodC9OEDU9AdXPJaSOnhRLShBb1oBzc3Y4u1VrBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yw1vDTeu/0kjER+xtzYpO+PiBjPw7E3VqaYgBOL9RsE9GHfW1K3bmhZxB62iHUm6s
         AvmPBocXcACkhgODGY4LVL3+FccqEcWoOWJS+PNZAg3ek2f9oS2+S7c9P9Ca/Pa5rG
         b0axdKqoZ01F2/i0TZpMm7JuOxhZQ6ynAcAuLvx0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 177/321] btrfs: assert delayed node locked when removing delayed item
Date:   Wed,  4 Oct 2023 19:55:22 +0200
Message-ID: <20231004175237.445745432@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit a57c2d4e46f519b24558ae0752c17eec416ac72a ]

When removing a delayed item, or releasing which will remove it as well,
we will modify one of the delayed node's rbtrees and item counter if the
delayed item is in one of the rbtrees. This require having the delayed
node's mutex locked, otherwise we will race with other tasks modifying
the rbtrees and the counter.

This is motivated by a previous version of another patch actually calling
btrfs_release_delayed_item() after unlocking the delayed node's mutex and
against a delayed item that is in a rbtree.

So assert at __btrfs_remove_delayed_item() that the delayed node's mutex
is locked.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/delayed-inode.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index b5f684cb4e749..142e0a0f6a9fe 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -412,6 +412,7 @@ static void finish_one_item(struct btrfs_delayed_root *delayed_root)
 
 static void __btrfs_remove_delayed_item(struct btrfs_delayed_item *delayed_item)
 {
+	struct btrfs_delayed_node *delayed_node = delayed_item->delayed_node;
 	struct rb_root_cached *root;
 	struct btrfs_delayed_root *delayed_root;
 
@@ -419,18 +420,21 @@ static void __btrfs_remove_delayed_item(struct btrfs_delayed_item *delayed_item)
 	if (RB_EMPTY_NODE(&delayed_item->rb_node))
 		return;
 
-	delayed_root = delayed_item->delayed_node->root->fs_info->delayed_root;
+	/* If it's in a rbtree, then we need to have delayed node locked. */
+	lockdep_assert_held(&delayed_node->mutex);
+
+	delayed_root = delayed_node->root->fs_info->delayed_root;
 
 	BUG_ON(!delayed_root);
 
 	if (delayed_item->type == BTRFS_DELAYED_INSERTION_ITEM)
-		root = &delayed_item->delayed_node->ins_root;
+		root = &delayed_node->ins_root;
 	else
-		root = &delayed_item->delayed_node->del_root;
+		root = &delayed_node->del_root;
 
 	rb_erase_cached(&delayed_item->rb_node, root);
 	RB_CLEAR_NODE(&delayed_item->rb_node);
-	delayed_item->delayed_node->count--;
+	delayed_node->count--;
 
 	finish_one_item(delayed_root);
 }
-- 
2.40.1



