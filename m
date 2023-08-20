Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06A2781F34
	for <lists+stable@lfdr.de>; Sun, 20 Aug 2023 20:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjHTSQs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 20 Aug 2023 14:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjHTSQo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 20 Aug 2023 14:16:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9963180
        for <stable@vger.kernel.org>; Sun, 20 Aug 2023 11:12:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66D9B61ACE
        for <stable@vger.kernel.org>; Sun, 20 Aug 2023 18:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E03C433C8;
        Sun, 20 Aug 2023 18:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692555127;
        bh=r+Tg4N4QQfKAq8AtZJmhibIT5hX5HZi2TncT99hgcdw=;
        h=Subject:To:Cc:From:Date:From;
        b=z8MZqjOda5lUORp3u45pouCbEPcaAvojyxsxQYuJJi9uX01gKiu2DKmx8G81cTM+l
         l+2V7tlhMg5PcjQKFO5DGWQy5/nwbTx2guCoJaY+HQs6f1VsoT1E3E0zMdKWZjTnpv
         NxnjfOS8g0dQsQsuxnQFVdi/W0ootJW3jdbLPDpY=
Subject: FAILED: patch "[PATCH] btrfs: fix incorrect splitting in btrfs_drop_extent_map_range" failed to apply to 4.19-stable tree
To:     josef@toxicpanda.com, dsterba@suse.com, fdmanana@suse.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 20 Aug 2023 20:12:00 +0200
Message-ID: <2023082000-sincerity-outsource-e807@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x c962098ca4af146f2625ed64399926a098752c9c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082000-sincerity-outsource-e807@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

c962098ca4af ("btrfs: fix incorrect splitting in btrfs_drop_extent_map_range")
db21370bffbc ("btrfs: drop extent map range more efficiently")
f3109e33bb0a ("btrfs: use extent_map_end() at btrfs_drop_extent_map_range()")
4c0c8cfc8433 ("btrfs: move btrfs_drop_extent_cache() to extent_map.c")
cef7820d6abf ("btrfs: fix missed extent on fsync after dropping extent maps")
570eb97bace8 ("btrfs: unify the lock/unlock extent variants")
dbbf49928f2e ("btrfs: remove the wake argument from clear_extent_bits")
e3974c669472 ("btrfs: move core extent_io_tree functions to extent-io-tree.c")
38830018387e ("btrfs: move a few exported extent_io_tree helpers to extent-io-tree.c")
04eba8932392 ("btrfs: temporarily export and then move extent state helpers")
91af24e48474 ("btrfs: temporarily export and move core extent_io_tree tree functions")
6962541e964f ("btrfs: move btrfs_debug_check_extent_io_range into extent-io-tree.c")
ec39e39bbf97 ("btrfs: export wait_extent_bit")
a66318872c41 ("btrfs: move simple extent bit helpers out of extent_io.c")
ad795329574c ("btrfs: convert BUG_ON(EXTENT_BIT_LOCKED) checks to ASSERT's")
83cf709a89fb ("btrfs: move extent state init and alloc functions to their own file")
c45379a20fbc ("btrfs: temporarily export alloc_extent_state helpers")
a40246e8afc0 ("btrfs: separate out the eb and extent state leak helpers")
a62a3bd9546b ("btrfs: separate out the extent state and extent buffer init code")
87c11705cc94 ("btrfs: convert the io_failure_tree to a plain rb_tree")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c962098ca4af146f2625ed64399926a098752c9c Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 17 Aug 2023 16:57:30 -0400
Subject: [PATCH] btrfs: fix incorrect splitting in btrfs_drop_extent_map_range

In production we were seeing a variety of WARN_ON()'s in the extent_map
code, specifically in btrfs_drop_extent_map_range() when we have to call
add_extent_mapping() for our second split.

Consider the following extent map layout

	PINNED
	[0 16K)  [32K, 48K)

and then we call btrfs_drop_extent_map_range for [0, 36K), with
skip_pinned == true.  The initial loop will have

	start = 0
	end = 36K
	len = 36K

we will find the [0, 16k) extent, but since we are pinned we will skip
it, which has this code

	start = em_end;
	if (end != (u64)-1)
		len = start + len - em_end;

em_end here is 16K, so now the values are

	start = 16K
	len = 16K + 36K - 16K = 36K

len should instead be 20K.  This is a problem when we find the next
extent at [32K, 48K), we need to split this extent to leave [36K, 48k),
however the code for the split looks like this

	split->start = start + len;
	split->len = em_end - (start + len);

In this case we have

	em_end = 48K
	split->start = 16K + 36K       // this should be 16K + 20K
	split->len = 48K - (16K + 36K) // this overflows as 16K + 36K is 52K

and now we have an invalid extent_map in the tree that potentially
overlaps other entries in the extent map.  Even in the non-overlapping
case we will have split->start set improperly, which will cause problems
with any block related calculations.

We don't actually need len in this loop, we can simply use end as our
end point, and only adjust start up when we find a pinned extent we need
to skip.

Adjust the logic to do this, which keeps us from inserting an invalid
extent map.

We only skip_pinned in the relocation case, so this is relatively rare,
except in the case where you are running relocation a lot, which can
happen with auto relocation on.

Fixes: 55ef68990029 ("Btrfs: Fix btrfs_drop_extent_cache for skip pinned case")
CC: stable@vger.kernel.org # 4.14+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 0cdb3e86f29b..a6d8368ed0ed 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -760,8 +760,6 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 
 		if (skip_pinned && test_bit(EXTENT_FLAG_PINNED, &em->flags)) {
 			start = em_end;
-			if (end != (u64)-1)
-				len = start + len - em_end;
 			goto next;
 		}
 
@@ -829,8 +827,8 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 				if (!split)
 					goto remove_em;
 			}
-			split->start = start + len;
-			split->len = em_end - (start + len);
+			split->start = end;
+			split->len = em_end - end;
 			split->block_start = em->block_start;
 			split->flags = flags;
 			split->compress_type = em->compress_type;

