Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FFC723071
	for <lists+stable@lfdr.de>; Mon,  5 Jun 2023 21:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbjFETwW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 15:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236082AbjFETwF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Jun 2023 15:52:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182C210EF
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 12:51:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16A9E60F5A
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 19:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C54C433EF;
        Mon,  5 Jun 2023 19:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685994673;
        bh=ID3V/WiIyEXOmv/RbV7tswerEJFJEyopCDeBUO7DycE=;
        h=Subject:To:Cc:From:Date:From;
        b=fSE/O2vpZcxXCyg9GGjQj015WnICefvg3igWCs2DE41bQ4G03yi0gXCe+oz5D8aGB
         n2iSX7op+/OLknvuHr/ZB9VcRf6r4+c7QghjIx7x6duEAIOLi8csQM3P5JWJTL5UAe
         ch4RMa8R/OgcT30EsiY9+iJF5iPCYW7UscCKiY9Y=
Subject: FAILED: patch "[PATCH] btrfs: call btrfs_orig_bbio_end_io in btrfs_end_bio_work" failed to apply to 6.3-stable tree
To:     hch@lst.de, dsterba@suse.com, johannes.thumshirn@wdc.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 05 Jun 2023 21:51:10 +0200
Message-ID: <2023060510-euphemism-budget-adac@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
git checkout FETCH_HEAD
git cherry-pick -x 45c2f36871955b51b4ce083c447388d8c72d6b91
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023060510-euphemism-budget-adac@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..

Possible dependencies:

45c2f3687195 ("btrfs: call btrfs_orig_bbio_end_io in btrfs_end_bio_work")
4317ff0056be ("btrfs: introduce btrfs_bio::fs_info member")
2cef0c79bb81 ("btrfs: make btrfs_split_bio work on struct btrfs_bio")
b41bbd293e64 ("btrfs: return a btrfs_bio from btrfs_bio_alloc")
9dfde1b47b9d ("btrfs: store a pointer to a btrfs_bio in struct btrfs_bio_ctrl")
d733ea012db3 ("btrfs: simplify finding the inode in submit_one_bio")
690834e47cf7 ("btrfs: pass a btrfs_bio to btrfs_submit_compressed_read")
ae42a154ca89 ("btrfs: pass a btrfs_bio to btrfs_submit_bio")
34f888ce3a35 ("btrfs: cleanup main loop in btrfs_encoded_read_regular_fill_pages")
198bd49e5f0c ("btrfs: sink calc_bio_boundaries into its only caller")
24e6c8082208 ("btrfs: simplify main loop in submit_extent_page")
78a2ef1b7b33 ("btrfs: check for contiguity in submit_extent_page")
551733372fda ("btrfs: remove the submit_extent_page return value")
f8ed4852f3a9 ("btrfs: remove the compress_type argument to submit_extent_page")
a140453bf9fb ("btrfs: rename the this_bio_flag variable in btrfs_do_readpage")
c9bc621fb498 ("btrfs: move the compress_type check out of btrfs_bio_add_page")
72b505dc5757 ("btrfs: add a wbc pointer to struct btrfs_bio_ctrl")
794c26e214ab ("btrfs: remove the sync_io flag in struct btrfs_bio_ctrl")
c000bc04bad4 ("btrfs: store the bio opf in struct btrfs_bio_ctrl")
eb8d0c6d042f ("btrfs: remove the force_bio_submit to submit_extent_page")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 45c2f36871955b51b4ce083c447388d8c72d6b91 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 15 May 2023 11:18:21 +0200
Subject: [PATCH] btrfs: call btrfs_orig_bbio_end_io in btrfs_end_bio_work
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When I implemented the storage layer bio splitting, I was under the
assumption that we'll never split metadata bios.  But Qu reminded me that
this can actually happen with very old file systems with unaligned
metadata chunks and RAID0.

I still haven't seen such a case in practice, but we better handled this
case, especially as it is fairly easily to do not calling the ->end_іo
method directly in btrfs_end_io_work, and using the proper
btrfs_orig_bbio_end_io helper instead.

In addition to the old file system with unaligned metadata chunks case
documented in the commit log, the combination of the new scrub code
with Johannes pending raid-stripe-tree also triggers this case.  We
spent some time debugging it and found that this patch solves
the problem.

Fixes: 103c19723c80 ("btrfs: split the bio submission path into a separate file")
CC: stable@vger.kernel.org # 6.3+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 5379c4714905..35d34c731d72 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -330,7 +330,7 @@ static void btrfs_end_bio_work(struct work_struct *work)
 	if (bbio->inode && !(bbio->bio.bi_opf & REQ_META))
 		btrfs_check_read_bio(bbio, bbio->bio.bi_private);
 	else
-		bbio->end_io(bbio);
+		btrfs_orig_bbio_end_io(bbio);
 }
 
 static void btrfs_simple_end_io(struct bio *bio)

