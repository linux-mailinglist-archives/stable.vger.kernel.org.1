Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC28A77AC63
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjHMVcc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjHMVcb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:32:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C6410DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:32:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33F3962BD7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25974C433C7;
        Sun, 13 Aug 2023 21:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962352;
        bh=l0+mI2gbfrg3yVM5mk2EVIPZzOyoFKEDU34FGa0s0fE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iq5zA6nCYtQWRgDTHFkF6LeMNAYQhcYrJXgpdZEG1sVZjlpbybEHlbO7IHKpbQX9l
         3DWKkwCD2O0uGFU4Xyi1xgjP+hat3ITQX8ONUWAEZJ2T2KqdBvGJJb0j7OIDdSB4Kx
         +a4vQp6vl4qTrEfM0NXiTuKOHaETD7niPIserlvA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com,
        Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.4 187/206] btrfs: reject invalid reloc tree root keys with stack dump
Date:   Sun, 13 Aug 2023 23:19:17 +0200
Message-ID: <20230813211730.374396276@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

commit 6ebcd021c92b8e4b904552e4d87283032100796d upstream.

[BUG]
Syzbot reported a crash that an ASSERT() got triggered inside
prepare_to_merge().

That ASSERT() makes sure the reloc tree is properly pointed back by its
subvolume tree.

[CAUSE]
After more debugging output, it turns out we had an invalid reloc tree:

  BTRFS error (device loop1): reloc tree mismatch, root 8 has no reloc root, expect reloc root key (-8, 132, 8) gen 17

Note the above root key is (TREE_RELOC_OBJECTID, ROOT_ITEM,
QUOTA_TREE_OBJECTID), meaning it's a reloc tree for quota tree.

But reloc trees can only exist for subvolumes, as for non-subvolume
trees, we just COW the involved tree block, no need to create a reloc
tree since those tree blocks won't be shared with other trees.

Only subvolumes tree can share tree blocks with other trees (thus they
have BTRFS_ROOT_SHAREABLE flag).

Thus this new debug output proves my previous assumption that corrupted
on-disk data can trigger that ASSERT().

[FIX]
Besides the dedicated fix and the graceful exit, also let tree-checker to
check such root keys, to make sure reloc trees can only exist for subvolumes.

CC: stable@vger.kernel.org # 5.15+
Reported-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/disk-io.c      |    3 ++-
 fs/btrfs/tree-checker.c |   14 ++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1351,7 +1351,8 @@ static int btrfs_init_fs_root(struct btr
 	btrfs_drew_lock_init(&root->snapshot_lock);
 
 	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID &&
-	    !btrfs_is_data_reloc_root(root)) {
+	    !btrfs_is_data_reloc_root(root) &&
+	    is_fstree(root->root_key.objectid)) {
 		set_bit(BTRFS_ROOT_SHAREABLE, &root->state);
 		btrfs_check_and_init_root_item(&root->root_item);
 	}
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -446,6 +446,20 @@ static int check_root_key(struct extent_
 	btrfs_item_key_to_cpu(leaf, &item_key, slot);
 	is_root_item = (item_key.type == BTRFS_ROOT_ITEM_KEY);
 
+	/*
+	 * Bad rootid for reloc trees.
+	 *
+	 * Reloc trees are only for subvolume trees, other trees only need
+	 * to be COWed to be relocated.
+	 */
+	if (unlikely(is_root_item && key->objectid == BTRFS_TREE_RELOC_OBJECTID &&
+		     !is_fstree(key->offset))) {
+		generic_err(leaf, slot,
+		"invalid reloc tree for root %lld, root id is not a subvolume tree",
+			    key->offset);
+		return -EUCLEAN;
+	}
+
 	/* No such tree id */
 	if (unlikely(key->objectid == 0)) {
 		if (is_root_item)


