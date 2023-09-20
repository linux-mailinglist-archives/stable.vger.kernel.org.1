Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F0D7A7858
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 11:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjITJ76 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 05:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbjITJ7v (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 05:59:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D7F8F
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 02:59:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743E5C433C8;
        Wed, 20 Sep 2023 09:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695203985;
        bh=RrQ3JRYilqbx6eIfGCEyAcNZEuY7p2cHq6iRRw5U8Zo=;
        h=Subject:To:Cc:From:Date:From;
        b=wMLEnRYRzhIOMdiA9PzM4CVhO18ue0W7KhcMJxlU/EEedBpKx6mF9iXT2xiV9x+KI
         BlO2B5wVni/NiG5PSoaNlUVMSbWVv05WVyz8uzZCQW7pXIMSY6+1BTEwucS3f4R/l5
         ABTzyZ6rCHoWpKHIUvT9HZ2/O0b99D07+IMiaDOc=
Subject: FAILED: patch "[PATCH] ext4: do not let fstrim block system suspend" failed to apply to 6.5-stable tree
To:     jack@suse.cz, david@fromorbit.com, lenb@kernel.org, tytso@mit.edu
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 20 Sep 2023 11:59:33 +0200
Message-ID: <2023092033-banker-expensive-aa8d@gregkh>
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


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 5229a658f6453362fbb9da6bf96872ef25a7097e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023092033-banker-expensive-aa8d@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

5229a658f645 ("ext4: do not let fstrim block system suspend")
45e4ab320c9b ("ext4: move setting of trimmed bit into ext4_try_to_trim_range()")
de8bf0e5ee74 ("ext4: replace the traditional ternary conditional operator with with max()/min()")

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

