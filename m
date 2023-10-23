Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D49B7D32C8
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbjJWLXq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbjJWLXi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:23:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBAD1705
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:23:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF9EC433CC;
        Mon, 23 Oct 2023 11:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060208;
        bh=SqwJ7NxjqhMMkRRFLayJYiGyMTLROxxXYJQ6/J9DCx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1gxBl1xJvi55wxE/hLw1Fm74RSdGuIVCt4vKrh+7xCFeH5aFRPj1UdllESHmwWWOW
         X6OuRXJ5SdDHU9RRnB8vyh6fSyJ0ih/l1YDT7e1WjHJGx6YcBYfENDSJlzQofYAOoW
         u//K/RS4aqXFgyf4UjCIn1vLXvjuJtXJyjaW3suk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 095/196] btrfs: return -EUCLEAN for delayed tree ref with a ref count not equals to 1
Date:   Mon, 23 Oct 2023 12:56:00 +0200
Message-ID: <20231023104831.216693729@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 1bf76df3fee56d6637718e267f7c34ed70d0c7dc ]

When running a delayed tree reference, if we find a ref count different
from 1, we return -EIO. This isn't an IO error, as it indicates either a
bug in the delayed refs code or a memory corruption, so change the error
code from -EIO to -EUCLEAN. Also tag the branch as 'unlikely' as this is
not expected to ever happen, and change the error message to print the
tree block's bytenr without the parenthesis (and there was a missing space
between the 'block' word and the opening parenthesis), for consistency as
that's the style we used everywhere else.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 08ff10a81cb90..2a7c9088fe1f8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1663,12 +1663,12 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		parent = ref->parent;
 	ref_root = ref->root;
 
-	if (node->ref_mod != 1) {
+	if (unlikely(node->ref_mod != 1)) {
 		btrfs_err(trans->fs_info,
-	"btree block(%llu) has %d references rather than 1: action %d ref_root %llu parent %llu",
+	"btree block %llu has %d references rather than 1: action %d ref_root %llu parent %llu",
 			  node->bytenr, node->ref_mod, node->action, ref_root,
 			  parent);
-		return -EIO;
+		return -EUCLEAN;
 	}
 	if (node->action == BTRFS_ADD_DELAYED_REF && insert_reserved) {
 		BUG_ON(!extent_op || !extent_op->update_flags);
-- 
2.40.1



