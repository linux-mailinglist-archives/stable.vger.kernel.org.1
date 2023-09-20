Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A698F7A77FB
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 11:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbjITJxc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 05:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbjITJxb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 05:53:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8F48F
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 02:53:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8E5C433C8;
        Wed, 20 Sep 2023 09:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695203605;
        bh=a6HRbaFVOvQUqnh63nFAq3G7ri8/zmpd/jf3untMNnE=;
        h=Subject:To:Cc:From:Date:From;
        b=QNUr35fE38ROIhTTpt3nhsWd1oHs+fYha9UWBpxMXQWBPIrYO+bRlbJDHHMQcyJWw
         SVBvdvzC4B1apeTcyGNqpSvFt0Cvuc5X6oQoF3ezkXX8N8hhYLNEShbB/82xkuc/QI
         IOHyC4BUh2+7D33xxAxFcK3JtCSNGS7xXGJX5gl4=
Subject: FAILED: patch "[PATCH] btrfs: check for BTRFS_FS_ERROR in pending ordered assert" failed to apply to 4.14-stable tree
To:     josef@toxicpanda.com, dsterba@suse.com, fdmanana@suse.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 20 Sep 2023 11:53:13 +0200
Message-ID: <2023092013-slightly-hubcap-822b@gregkh>
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


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 4ca8e03cf2bfaeef7c85939fa1ea0c749cd116ab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023092013-slightly-hubcap-822b@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

4ca8e03cf2bf ("btrfs: check for BTRFS_FS_ERROR in pending ordered assert")
487781796d30 ("btrfs: make fast fsyncs wait only for writeback")
75b463d2b47a ("btrfs: do not commit logs and transactions during link and rename operations")
260db43cd2f5 ("btrfs: delete duplicated words + other fixes in comments")
3ef64143a796 ("btrfs: remove no longer used trans_list member of struct btrfs_ordered_extent")
cd8d39f4aeb3 ("btrfs: remove no longer used log_list member of struct btrfs_ordered_extent")
7af597433d43 ("btrfs: make full fsyncs always operate on the entire file again")
0a8068a3dd42 ("btrfs: make ranged full fsyncs more efficient")
da447009a256 ("btrfs: factor out inode items copy loop from btrfs_log_inode()")
a5eeb3d17b97 ("btrfs: add helper to get the end offset of a file extent item")
95418ed1d107 ("btrfs: fix missing file extent item for hole after ranged fsync")
3f1c64ce0438 ("btrfs: delete the ordered isize update code")
41a2ee75aab0 ("btrfs: introduce per-inode file extent tree")
236ebc20d9af ("btrfs: fix log context list corruption after rename whiteout error")
b5e4ff9d465d ("Btrfs: fix infinite loop during fsync after rename operations")
0e56315ca147 ("Btrfs: fix missing hole after hole punching and fsync when using NO_HOLES")
9c7d3a548331 ("btrfs: move extent_io_tree defs to their own header")
6f0d04f8e72e ("btrfs: separate out the extent io init function")
33ca832fefa5 ("btrfs: separate out the extent leak code")
afd7a71872f1 ("Merge tag 'for-5.4-rc7-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4ca8e03cf2bfaeef7c85939fa1ea0c749cd116ab Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 24 Aug 2023 16:59:04 -0400
Subject: [PATCH] btrfs: check for BTRFS_FS_ERROR in pending ordered assert

If we do fast tree logging we increment a counter on the current
transaction for every ordered extent we need to wait for.  This means we
expect the transaction to still be there when we clear pending on the
ordered extent.  However if we happen to abort the transaction and clean
it up, there could be no running transaction, and thus we'll trip the
"ASSERT(trans)" check.  This is obviously incorrect, and the code
properly deals with the case that the transaction doesn't exist.  Fix
this ASSERT() to only fire if there's no trans and we don't have
BTRFS_FS_ERROR() set on the file system.

CC: stable@vger.kernel.org # 4.14+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index b46ab348e8e5..345c449d588c 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -639,7 +639,7 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 			refcount_inc(&trans->use_count);
 		spin_unlock(&fs_info->trans_lock);
 
-		ASSERT(trans);
+		ASSERT(trans || BTRFS_FS_ERROR(fs_info));
 		if (trans) {
 			if (atomic_dec_and_test(&trans->pending_ordered))
 				wake_up(&trans->pending_wait);

