Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711EE713884
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 09:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjE1Hsy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 03:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjE1Hsv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 03:48:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A32F3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 00:48:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C8CC60E09
        for <stable@vger.kernel.org>; Sun, 28 May 2023 07:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA70C433EF;
        Sun, 28 May 2023 07:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685260125;
        bh=xsCmIdtqxxJleDzBG4WU7d5nZGJ89YL/x7lusohgFT0=;
        h=Subject:To:Cc:From:Date:From;
        b=xWEjX76E98aN4DABUT6nZJcDcyhIaBPClOb37oiNH8gOPtiucWIK1ncaZo8XTpKt/
         bM+m4tSojY92qH+felD6kDzES67pKV9IendaJLHre3f91AE5xf94AQAMAZ34EVjd1J
         gBy+WZQ1p3H0aiuTD8ziJb82If0fkPbIzt26Dosc=
Subject: FAILED: patch "[PATCH] block: fix bio-cache for passthru IO" failed to apply to 6.1-stable tree
To:     anuj20.g@samsung.com, axboe@kernel.dk, joshi.k@samsung.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 08:48:42 +0100
Message-ID: <2023052842-facedown-sliceable-49ca@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
git cherry-pick -x 46930b7cc7727271c9c27aac1fdc97a8645e2d00
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052842-facedown-sliceable-49ca@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

46930b7cc772 ("block: fix bio-cache for passthru IO")
7e2e355dd9c9 ("block: extend bio-cache for non-polled requests")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 46930b7cc7727271c9c27aac1fdc97a8645e2d00 Mon Sep 17 00:00:00 2001
From: Anuj Gupta <anuj20.g@samsung.com>
Date: Tue, 23 May 2023 16:47:09 +0530
Subject: [PATCH] block: fix bio-cache for passthru IO

commit <8af870aa5b847> ("block: enable bio caching use for passthru IO")
introduced bio-cache for passthru IO. In case when nr_vecs are greater
than BIO_INLINE_VECS, bio and bvecs are allocated from mempool (instead
of percpu cache) and REQ_ALLOC_CACHE is cleared. This causes the side
effect of not freeing bio/bvecs into mempool on completion.

This patch lets the passthru IO fallback to allocation using bio_kmalloc
when nr_vecs are greater than BIO_INLINE_VECS. The corresponding bio
is freed during call to blk_mq_map_bio_put during completion.

Cc: stable@vger.kernel.org # 6.1
fixes <8af870aa5b847> ("block: enable bio caching use for passthru IO")

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Link: https://lore.kernel.org/r/20230523111709.145676-1-anuj20.g@samsung.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/blk-map.c b/block/blk-map.c
index 04c55f1c492e..46eed2e627c3 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -248,7 +248,7 @@ static struct bio *blk_rq_map_bio_alloc(struct request *rq,
 {
 	struct bio *bio;
 
-	if (rq->cmd_flags & REQ_ALLOC_CACHE) {
+	if (rq->cmd_flags & REQ_ALLOC_CACHE && (nr_vecs <= BIO_INLINE_VECS)) {
 		bio = bio_alloc_bioset(NULL, nr_vecs, rq->cmd_flags, gfp_mask,
 					&fs_bio_set);
 		if (!bio)

