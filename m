Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B717A7859
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 11:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbjITJ76 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 05:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbjITJ7y (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 05:59:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9CDAB
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 02:59:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1364DC433C7;
        Wed, 20 Sep 2023 09:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695203988;
        bh=hOp1x9VbzUs9t7DQeWA38FHcjooQYxzxnJzPj/OvgEI=;
        h=Subject:To:Cc:From:Date:From;
        b=yU+wys2Ir/Yw7/elFbsmflLZi4GWN1EQDZfrlcp+iP9khACSVBpo5fDwqY+ZHOTw4
         OeUFhuVrfd9zE3zB9QdxAwDVZVHUjMacUKxQjOCbbcF+522O+xYAJODQsXzE06jb+6
         EyCNuZyI1hRrz9d9dT8jyKtDFptAaUUu/ilr0i7U=
Subject: FAILED: patch "[PATCH] ext4: do not let fstrim block system suspend" failed to apply to 5.15-stable tree
To:     jack@suse.cz, david@fromorbit.com, lenb@kernel.org, tytso@mit.edu
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 20 Sep 2023 11:59:34 +0200
Message-ID: <2023092034-campsite-isolated-53bf@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5229a658f6453362fbb9da6bf96872ef25a7097e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023092034-campsite-isolated-53bf@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

5229a658f645 ("ext4: do not let fstrim block system suspend")
45e4ab320c9b ("ext4: move setting of trimmed bit into ext4_try_to_trim_range()")
de8bf0e5ee74 ("ext4: replace the traditional ternary conditional operator with with max()/min()")
d63c00ea435a ("ext4: mark group as trimmed only if it was fully scanned")
2327fb2e2341 ("ext4: change s_last_trim_minblks type to unsigned long")
173b6e383d2a ("ext4: avoid trim error on fs with small groups")
afcc4e32f606 ("ext4: scope ret locally in ext4_try_to_trim_range()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5229a658f6453362fbb9da6bf96872ef25a7097e Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 13 Sep 2023 17:04:55 +0200
Subject: [PATCH] ext4: do not let fstrim block system suspend

Len Brown has reported that system suspend sometimes fail due to
inability to freeze a task working in ext4_trim_fs() for one minute.
Trimming a large filesystem on a disk that slowly processes discard
requests can indeed take a long time. Since discard is just an advisory
call, it is perfectly fine to interrupt it at any time and the return
number of discarded blocks until that moment. Do that when we detect the
task is being frozen.

Cc: stable@kernel.org
Reported-by: Len Brown <lenb@kernel.org>
Suggested-by: Dave Chinner <david@fromorbit.com>
References: https://bugzilla.kernel.org/show_bug.cgi?id=216322
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230913150504.9054-2-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 09091adfde64..1e599305d85f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/nospec.h>
 #include <linux/backing-dev.h>
+#include <linux/freezer.h>
 #include <trace/events/ext4.h>
 
 /*
@@ -6916,6 +6917,11 @@ static ext4_grpblk_t ext4_last_grp_cluster(struct super_block *sb,
 					EXT4_CLUSTER_BITS(sb);
 }
 
+static bool ext4_trim_interrupted(void)
+{
+	return fatal_signal_pending(current) || freezing(current);
+}
+
 static int ext4_try_to_trim_range(struct super_block *sb,
 		struct ext4_buddy *e4b, ext4_grpblk_t start,
 		ext4_grpblk_t max, ext4_grpblk_t minblocks)
@@ -6949,8 +6955,8 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 		free_count += next - start;
 		start = next + 1;
 
-		if (fatal_signal_pending(current))
-			return -ERESTARTSYS;
+		if (ext4_trim_interrupted())
+			return count;
 
 		if (need_resched()) {
 			ext4_unlock_group(sb, e4b->bd_group);
@@ -7072,6 +7078,8 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 	end = EXT4_CLUSTERS_PER_GROUP(sb) - 1;
 
 	for (group = first_group; group <= last_group; group++) {
+		if (ext4_trim_interrupted())
+			break;
 		grp = ext4_get_group_info(sb, group);
 		if (!grp)
 			continue;

