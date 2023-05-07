Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0F46F97C9
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 10:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjEGIwz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 04:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEGIwy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 04:52:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6061614356
        for <stable@vger.kernel.org>; Sun,  7 May 2023 01:52:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD47861353
        for <stable@vger.kernel.org>; Sun,  7 May 2023 08:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4826C433EF;
        Sun,  7 May 2023 08:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683449572;
        bh=Zw/zPtq80zxsll3LwSi6d1qIBzVRiwKcvgYSNBCBA5M=;
        h=Subject:To:Cc:From:Date:From;
        b=2LvvcTkaN/g2SdiIFrVTqvvM0wGs+io2gFFf6Epkih5iYlBhOaCJtNFjzyJuPvy52
         RxSe4vnVQXgqfXwJqXwwyX5blyiqovyamanqvwmuez4g9Ntj4NKMdQaZiHveIwLfnC
         bZmxMH4Ac34m7hAypqRgy5IYtYm90cAQYeSotcRQ=
Subject: FAILED: patch "[PATCH] drbd: correctly submit flush bio on barrier" failed to apply to 4.14-stable tree
To:     christoph.boehmwalder@linbit.com, axboe@kernel.dk,
        hch@infradead.org, hch@lst.de, tv@lio96.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 07 May 2023 10:52:13 +0200
Message-ID: <2023050713-unshaved-harmonica-4f00@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 3899d94e3831ee07ea6821c032dc297aec80586a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050713-unshaved-harmonica-4f00@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

3899d94e3831 ("drbd: correctly submit flush bio on barrier")
07888c665b40 ("block: pass a block_device and opf to bio_alloc")
b77c88c2100c ("block: pass a block_device and opf to bio_alloc_kiocb")
609be1066731 ("block: pass a block_device and opf to bio_alloc_bioset")
0a3140ea0fae ("block: pass a block_device and opf to blk_next_bio")
3b005bf6acf0 ("block: move blk_next_bio to bio.c")
7d8d0c658d48 ("xen-blkback: bio_alloc can't fail if it is allow to sleep")
d7b78de2b155 ("rnbd-srv: remove struct rnbd_dev_blk_io")
1fe0640ff94f ("rnbd-srv: simplify bio mapping in process_rdma")
4b1dc86d1857 ("drbd: bio_alloc can't fail if it is allow to sleep")
3f868c09ea8f ("dm-crypt: remove clone_init")
53db984e004c ("dm: bio_alloc can't fail if it is allowed to sleep")
39146b6f66ba ("ntfs3: remove ntfs_alloc_bio")
5d2ca2132f88 ("nfs/blocklayout: remove bl_alloc_init_bio")
f0d911927b3c ("nilfs2: remove nilfs_alloc_seg_bio")
d5f68a42da7a ("fs: remove mpage_alloc")
ae4c81644e91 ("RDMA/rtrs-srv: Rename rtrs_srv_sess to rtrs_srv_path")
d9372794717f ("RDMA/rtrs: Rename rtrs_sess to rtrs_path")
512b7931ad05 ("Merge branch 'akpm' (patches from Andrew)")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3899d94e3831ee07ea6821c032dc297aec80586a Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?=
 <christoph.boehmwalder@linbit.com>
Date: Wed, 3 May 2023 14:19:37 +0200
Subject: [PATCH] drbd: correctly submit flush bio on barrier
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When we receive a flush command (or "barrier" in DRBD), we currently use
a REQ_OP_FLUSH with the REQ_PREFLUSH flag set.

The correct way to submit a flush bio is by using a REQ_OP_WRITE without
any data, and set the REQ_PREFLUSH flag.

Since commit b4a6bb3a67aa ("block: add a sanity check for non-write
flush/fua bios"), this triggers a warning in the block layer, but this
has been broken for quite some time before that.

So use the correct set of flags to actually make the flush happen.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: stable@vger.kernel.org
Fixes: f9ff0da56437 ("drbd: allow parallel flushes for multi-volume resources")
Reported-by: Thomas Voegtle <tv@lio96.de>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230503121937.17232-1-christoph.boehmwalder@linbit.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index e54404c632e7..34b112752ab1 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1283,7 +1283,7 @@ static void one_flush_endio(struct bio *bio)
 static void submit_one_flush(struct drbd_device *device, struct issue_flush_context *ctx)
 {
 	struct bio *bio = bio_alloc(device->ldev->backing_bdev, 0,
-				    REQ_OP_FLUSH | REQ_PREFLUSH, GFP_NOIO);
+				    REQ_OP_WRITE | REQ_PREFLUSH, GFP_NOIO);
 	struct one_flush_context *octx = kmalloc(sizeof(*octx), GFP_NOIO);
 
 	if (!octx) {

