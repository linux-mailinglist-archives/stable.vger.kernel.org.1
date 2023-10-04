Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCFE7B87EC
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243907AbjJDSK4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243911AbjJDSKz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:10:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D31EBF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:10:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44DCC433C9;
        Wed,  4 Oct 2023 18:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443051;
        bh=twpDG6Jk4Br9J4yZyNyOyB28QxQveNjd3mBbBaTGeY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GZMGfR5dmtaF6npR66ueE4ryeAMdhgxYgH5NU5zk8N3Do8QidpuXJDhowDo8T4Tlk
         zfDyEAzTYCB56pxFYPrGsMgdVdTZWfhG/VjJ+4Ragha1IBKgP+SrgLTMVD+v6OGyeR
         9BG8h0NbAvBDSdRR8JmPQRO3CtToVQb2D3TXfyno=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Len Brown <lenb@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 019/259] ext4: do not let fstrim block system suspend
Date:   Wed,  4 Oct 2023 19:53:12 +0200
Message-ID: <20231004175218.306215827@linuxfoundation.org>
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

From: Jan Kara <jack@suse.cz>

[ Upstream commit 5229a658f6453362fbb9da6bf96872ef25a7097e ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 41f0385f85d38..3c8300e08f412 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/nospec.h>
 #include <linux/backing-dev.h>
+#include <linux/freezer.h>
 #include <trace/events/ext4.h>
 
 /*
@@ -6430,6 +6431,11 @@ static ext4_grpblk_t ext4_last_grp_cluster(struct super_block *sb,
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
@@ -6463,8 +6469,8 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 		free_count += next - start;
 		start = next + 1;
 
-		if (fatal_signal_pending(current))
-			return -ERESTARTSYS;
+		if (ext4_trim_interrupted())
+			return count;
 
 		if (need_resched()) {
 			ext4_unlock_group(sb, e4b->bd_group);
@@ -6586,6 +6592,8 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 	end = EXT4_CLUSTERS_PER_GROUP(sb) - 1;
 
 	for (group = first_group; group <= last_group; group++) {
+		if (ext4_trim_interrupted())
+			break;
 		grp = ext4_get_group_info(sb, group);
 		if (!grp)
 			continue;
-- 
2.40.1



