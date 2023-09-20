Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201F87A799A
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 12:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjITKqt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 06:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbjITKq3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 06:46:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92501EC
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 03:46:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCABBC433C7;
        Wed, 20 Sep 2023 10:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695206764;
        bh=SvjsfUUivCXxHh/7MxWG/XRA9KjlIa1LtOb+t+Z/Xhc=;
        h=Subject:To:Cc:From:Date:From;
        b=1FvRxa/ClpGePiytqvqXdPSWzdF+CNk/Mzs4U50cpQxd9P+0KXsTEoYxLczXejSC2
         5+FKqrpg7xJnD8KjChZJ/aKtEh5GauVoVASQVugLI7Wp7weNVcO6loPEX5lA+S26z7
         461o3wh9lpV4ma5kOde+NXyXmGJrVJqdQRiN+tZY=
Subject: FAILED: patch "[PATCH] btrfs: check for BTRFS_FS_ERROR in pending ordered assert" failed to apply to 5.15-stable tree
To:     josef@toxicpanda.com, dsterba@suse.com, fdmanana@suse.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 20 Sep 2023 12:45:57 +0200
Message-ID: <2023092057-deceiving-jukebox-5350@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
git cherry-pick -x 4ca8e03cf2bfaeef7c85939fa1ea0c749cd116ab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023092057-deceiving-jukebox-5350@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

4ca8e03cf2bf ("btrfs: check for BTRFS_FS_ERROR in pending ordered assert")

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

