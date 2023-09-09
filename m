Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E74799B5F
	for <lists+stable@lfdr.de>; Sat,  9 Sep 2023 23:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbjIIVY3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 9 Sep 2023 17:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjIIVY3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 9 Sep 2023 17:24:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEAE197
        for <stable@vger.kernel.org>; Sat,  9 Sep 2023 14:24:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7981FC433C7;
        Sat,  9 Sep 2023 21:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694294664;
        bh=9GYmJtGH27+lkdjPSM53OHUalESkrsEMXoYtRxGsmOc=;
        h=Subject:To:Cc:From:Date:From;
        b=Tw5SVLPtnrHqtU1FlMTl7vkLLia24SqmywERX05AUrt4IGxdcB8LJcx4ZMN870M8O
         ij9lOlpGIw9x/3DrNRMXKoT1z5NndZM2Xy5xKieuHbiuF7dm0YtPBajzgUxhMK3EYc
         sYstpg3x9tqdAz/kuL2CMS8OsuVX5VR0TlUarUTA=
Subject: FAILED: patch "[PATCH] block: fix pin count management when merging same-page" failed to apply to 6.1-stable tree
To:     hch@lst.de, axboe@kernel.dk, dlemoal@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 09 Sep 2023 22:24:17 +0100
Message-ID: <2023090916-icon-refute-e9fe@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5905afc2c7bb713d52c7c7585565feecbb686b44
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023090916-icon-refute-e9fe@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

5905afc2c7bb ("block: fix pin count management when merging same-page segments")
403b6fb8dac1 ("block: convert bio_map_user_iov to use iov_iter_extract_pages")
f62e52d1276b ("iov_iter: Define flags to qualify page extraction.")
7ee4ccf57484 ("block: set FOLL_PCI_P2PDMA in bio_map_user_iov()")
5e3e3f2e15df ("block: set FOLL_PCI_P2PDMA in __bio_iov_iter_get_pages()")
d82076403cef ("iov_iter: introduce iov_iter_get_pages_[alloc_]flags()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5905afc2c7bb713d52c7c7585565feecbb686b44 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Tue, 5 Sep 2023 14:47:31 +0200
Subject: [PATCH] block: fix pin count management when merging same-page
 segments

There is no need to unpin the added page when adding it to the bio fails
as that is done by the loop below.  Instead we want to unpin it when adding
a single page to the bio more than once as bio_release_pages will only
unpin it once.

Fixes: d1916c86ccdc ("block: move same page handling from __bio_add_pc_page to the callers")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://lore.kernel.org/r/20230905124731.328255-1-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/blk-map.c b/block/blk-map.c
index 44d74a30ddac..8584babf3ea0 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -315,12 +315,11 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 					n = bytes;
 
 				if (!bio_add_hw_page(rq->q, bio, page, n, offs,
-						     max_sectors, &same_page)) {
-					if (same_page)
-						bio_release_page(bio, page);
+						     max_sectors, &same_page))
 					break;
-				}
 
+				if (same_page)
+					bio_release_page(bio, page);
 				bytes -= n;
 				offs = 0;
 			}

