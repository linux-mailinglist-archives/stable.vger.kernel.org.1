Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EFC7014A0
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 08:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjEMGdc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 02:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMGdb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 02:33:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504962D4F
        for <stable@vger.kernel.org>; Fri, 12 May 2023 23:33:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E201E60A0A
        for <stable@vger.kernel.org>; Sat, 13 May 2023 06:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75483C433EF;
        Sat, 13 May 2023 06:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683959609;
        bh=AoI/fgSTic7yl+NxtddfGFbEoucCgUvqhQTHm+k8bws=;
        h=Subject:To:Cc:From:Date:From;
        b=jLwUuKHs3qvak/ss3/DL23lMNwPZO1vtThkG3gnQmgyj3TKwvAld+jJwg3PyVUZlS
         AG0CgrABSmNb3R9p6BNbFdB11t1Lmkz1JoPDuYl2sBEtYbR4RhO3IQvGi5Hxo2Cnco
         Ptqmp/6uELhplp2cGvjWoh/AdN27TGq90MWl/NbE=
Subject: FAILED: patch "[PATCH] btrfs: fix space cache inconsistency after error loading it" failed to apply to 4.19-stable tree
To:     fdmanana@suse.com, anand.jain@oracle.com, dsterba@suse.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 13 May 2023 15:33:06 +0900
Message-ID: <2023051306-unwound-clapping-ac11@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 0004ff15ea26015a0a3a6182dca3b9d1df32e2b7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051306-unwound-clapping-ac11@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

0004ff15ea26 ("btrfs: fix space cache inconsistency after error loading it from disk")
fa598b069640 ("btrfs: remove recalc_thresholds from free space ops")
cd79909bc7cd ("btrfs: load free space cache into a temporary ctl")
6b7304af62d0 ("btrfs: rename member 'trimming' of block group to a more generic name")
2473d24f2b77 ("btrfs: fix a race between scrub and block group removal/allocation")
5d90c5c75711 ("btrfs: increase the metadata allowance for the free_space_cache")
7fe6d45e4009 ("btrfs: have multiple discard lists")
19b2a2c71979 ("btrfs: make max async discard size tunable")
4aa9ad520398 ("btrfs: limit max discard size for async discard")
e93591bb6ecf ("btrfs: add kbps discard rate limit for async discard")
a23093008412 ("btrfs: calculate discard delay based on number of extents")
5dc7c10b8747 ("btrfs: keep track of discardable_bytes for async discard")
dfb79ddb130e ("btrfs: track discardable extents for async discard")
e4faab844a55 ("btrfs: sysfs: add UUID/debug/discard directory")
93945cb43ead ("btrfs: sysfs: make UUID/debug have its own kobject")
71e8978eb456 ("btrfs: sysfs: add removal calls for debug/")
2bee7eb8bb81 ("btrfs: discard one region at a time in async discard")
6e80d4f8c422 ("btrfs: handle empty block_group removal for async discard")
b0643e59cfa6 ("btrfs: add the beginning of async discard, discard workqueue")
da080fe1bad4 ("btrfs: keep track of free space bitmap trim status cleanliness")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0004ff15ea26015a0a3a6182dca3b9d1df32e2b7 Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Thu, 4 May 2023 12:04:18 +0100
Subject: [PATCH] btrfs: fix space cache inconsistency after error loading it
 from disk

When loading a free space cache from disk, at __load_free_space_cache(),
if we fail to insert a bitmap entry, we still increment the number of
total bitmaps in the btrfs_free_space_ctl structure, which is incorrect
since we failed to add the bitmap entry. On error we then empty the
cache by calling __btrfs_remove_free_space_cache(), which will result
in getting the total bitmaps counter set to 1.

A failure to load a free space cache is not critical, so if a failure
happens we just rebuild the cache by scanning the extent tree, which
happens at block-group.c:caching_thread(). Yet the failure will result
in having the total bitmaps of the btrfs_free_space_ctl always bigger
by 1 then the number of bitmap entries we have. So fix this by having
the total bitmaps counter be incremented only if we successfully added
the bitmap entry.

Fixes: a67509c30079 ("Btrfs: add a io_ctl struct and helpers for dealing with the space cache")
Reviewed-by: Anand Jain <anand.jain@oracle.com>
CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index d84cef89cdff..cf98a3c05480 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -870,15 +870,16 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 			}
 			spin_lock(&ctl->tree_lock);
 			ret = link_free_space(ctl, e);
-			ctl->total_bitmaps++;
-			recalculate_thresholds(ctl);
-			spin_unlock(&ctl->tree_lock);
 			if (ret) {
+				spin_unlock(&ctl->tree_lock);
 				btrfs_err(fs_info,
 					"Duplicate entries in free space cache, dumping");
 				kmem_cache_free(btrfs_free_space_cachep, e);
 				goto free_cache;
 			}
+			ctl->total_bitmaps++;
+			recalculate_thresholds(ctl);
+			spin_unlock(&ctl->tree_lock);
 			list_add_tail(&e->list, &bitmaps);
 		}
 

