Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC317B87E8
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243856AbjJDSKo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243878AbjJDSKn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:10:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DE7A6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:10:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A83C433C8;
        Wed,  4 Oct 2023 18:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443040;
        bh=AU3YEf5FAn9ClojwdDTWH11yMdRnUZ+Qs0BFJW2AwIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GxvvvgLziexbmRehn4gYGdeOfjYm19uW1z9rGduzm7xKRTsJ+lWHdP5zSgZ5K+pXO
         SQIfgMGDKOhNwiZ1kRZW8iLl6Imnc7dwrdDYlSG39cgPKJ08AFWlJn6BfvMhn8vsjE
         5pHUYPTMOeGsxVf3Y76t6q/LtA+NgyLrwt0IH4VQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 015/259] btrfs: improve error message after failure to add delayed dir index item
Date:   Wed,  4 Oct 2023 19:53:08 +0200
Message-ID: <20231004175218.123414102@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 91bfe3104b8db0310f76f2dcb6aacef24c889366 ]

If we fail to add a delayed dir index item because there's already another
item with the same index number, we print an error message (and then BUG).
However that message isn't very helpful to debug anything because we don't
know what's the index number and what are the values of index counters in
the inode and its delayed inode (index_cnt fields of struct btrfs_inode
and struct btrfs_delayed_node).

So update the error message to include the index number and counters.

We actually had a recent case where this issue was hit by a syzbot report
(see the link below).

Link: https://lore.kernel.org/linux-btrfs/00000000000036e1290603e097e0@google.com/
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 2c58c3931ede ("btrfs: remove BUG() after failure to insert delayed dir index item")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/delayed-inode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index d2cbb7733c7d6..34e843460e4db 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1506,9 +1506,10 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 	ret = __btrfs_add_delayed_item(delayed_node, delayed_item);
 	if (unlikely(ret)) {
 		btrfs_err(trans->fs_info,
-			  "err add delayed dir index item(name: %.*s) into the insertion tree of the delayed node(root id: %llu, inode id: %llu, errno: %d)",
-			  name_len, name, delayed_node->root->root_key.objectid,
-			  delayed_node->inode_id, ret);
+"error adding delayed dir index item, name: %.*s, index: %llu, root: %llu, dir: %llu, dir->index_cnt: %llu, delayed_node->index_cnt: %llu, error: %d",
+			  name_len, name, index, btrfs_root_id(delayed_node->root),
+			  delayed_node->inode_id, dir->index_cnt,
+			  delayed_node->index_cnt, ret);
 		BUG();
 	}
 	mutex_unlock(&delayed_node->mutex);
-- 
2.40.1



