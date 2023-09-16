Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C6D7A3022
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 14:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238935AbjIPMfA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 08:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239216AbjIPMec (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 08:34:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CFECED
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 05:34:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893B0C433C7;
        Sat, 16 Sep 2023 12:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694867666;
        bh=RZdNdlmFh/G6+gooM4ODA4mcWmzpMS1h/KVHN3LiPBw=;
        h=Subject:To:Cc:From:Date:From;
        b=fxpG4TlyYermBUzrHJCCLTQHT4j8hdB6F58AogacnmbfKhJASHZPdL04q9nfflqTd
         C3/m109eV+tRqxT/yA0QGB7iwuD5qZCGh2aNG23BAGPZVY0mAJVVMv45QcrzDOpBuY
         bpa99MjcHrUaOUVJG5VbcfJPHyhc76DOLsQM+bXc=
Subject: FAILED: patch "[PATCH] btrfs: fix start transaction qgroup rsv double free" failed to apply to 5.10-stable tree
To:     boris@bur.io, dsterba@suse.com, josef@toxicpanda.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 16 Sep 2023 14:31:14 +0200
Message-ID: <2023091614-retry-numbing-c815@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a6496849671a5bc9218ecec25a983253b34351b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091614-retry-numbing-c815@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

a6496849671a ("btrfs: fix start transaction qgroup rsv double free")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a6496849671a5bc9218ecec25a983253b34351b1 Mon Sep 17 00:00:00 2001
From: Boris Burkov <boris@bur.io>
Date: Fri, 21 Jul 2023 09:02:07 -0700
Subject: [PATCH] btrfs: fix start transaction qgroup rsv double free

btrfs_start_transaction reserves metadata space of the PERTRANS type
before it identifies a transaction to start/join. This allows flushing
when reserving that space without a deadlock. However, it results in a
race which temporarily breaks qgroup rsv accounting.

T1                                              T2
start_transaction
do_stuff
                                            start_transaction
                                                qgroup_reserve_meta_pertrans
commit_transaction
    qgroup_free_meta_all_pertrans
                                            hit an error starting txn
                                            goto reserve_fail
                                            qgroup_free_meta_pertrans (already freed!)

The basic issue is that there is nothing preventing another commit from
committing before start_transaction finishes (in fact sometimes we
intentionally wait for it) so any error path that frees the reserve is
at risk of this race.

While this exact space was getting freed anyway, and it's not a huge
deal to double free it (just a warning, the free code catches this), it
can result in incorrectly freeing some other pertrans reservation in
this same reservation, which could then lead to spuriously granting
reservations we might not have the space for. Therefore, I do believe it
is worth fixing.

To fix it, use the existing prealloc->pertrans conversion mechanism.
When we first reserve the space, we reserve prealloc space and only when
we are sure we have a transaction do we convert it to pertrans. This way
any racing commits do not blow away our reservation, but we still get a
pertrans reservation that is freed when _this_ transaction gets committed.

This issue can be reproduced by running generic/269 with either qgroups
or squotas enabled via mkfs on the scratch device.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
CC: stable@vger.kernel.org # 5.10+
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 4bb9716ad24a..815f61d6b506 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -591,8 +591,13 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 		u64 delayed_refs_bytes = 0;
 
 		qgroup_reserved = num_items * fs_info->nodesize;
-		ret = btrfs_qgroup_reserve_meta_pertrans(root, qgroup_reserved,
-				enforce_qgroups);
+		/*
+		 * Use prealloc for now, as there might be a currently running
+		 * transaction that could free this reserved space prematurely
+		 * by committing.
+		 */
+		ret = btrfs_qgroup_reserve_meta_prealloc(root, qgroup_reserved,
+							 enforce_qgroups, false);
 		if (ret)
 			return ERR_PTR(ret);
 
@@ -705,6 +710,14 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 		h->reloc_reserved = reloc_reserved;
 	}
 
+	/*
+	 * Now that we have found a transaction to be a part of, convert the
+	 * qgroup reservation from prealloc to pertrans. A different transaction
+	 * can't race in and free our pertrans out from under us.
+	 */
+	if (qgroup_reserved)
+		btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
+
 got_it:
 	if (!current->journal_info)
 		current->journal_info = h;
@@ -752,7 +765,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 		btrfs_block_rsv_release(fs_info, &fs_info->trans_block_rsv,
 					num_bytes, NULL);
 reserve_fail:
-	btrfs_qgroup_free_meta_pertrans(root, qgroup_reserved);
+	btrfs_qgroup_free_meta_prealloc(root, qgroup_reserved);
 	return ERR_PTR(ret);
 }
 

