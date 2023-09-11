Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4CF79BC0A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350667AbjIKVkb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238938AbjIKOH4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:07:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971A4CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:07:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAE1C433CB;
        Mon, 11 Sep 2023 14:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441271;
        bh=e4nYY/j5VtaYznp+g1N0zPH+EB+nkKcBbqV/8iRoZJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oLydnQiCG6hRssPWWMdhCGDAOAdrP7Shm8q0pidIbRKrm5vB8CaoKCUt/7Q7308VP
         Qucfg1pGXxrUeuaCiYBjIc6DcBW7m2lgqyx3ffP9k+61wYm66A4Ses3U7ttufJEzw9
         cvM02PryDVz/YTNaeE0Dsctwb5B9maBfNxXt8drk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Corey Hickey <bugfood-ml@fatooh.org>
Subject: [PATCH 6.5 355/739] md/raid5-cache: fix null-ptr-deref for r5l_flush_stripe_to_raid()
Date:   Mon, 11 Sep 2023 15:42:34 +0200
Message-ID: <20230911134701.048708684@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 0d0bd28c500173bfca78aa840f8f36d261ef1765 ]

r5l_flush_stripe_to_raid() will check if the list 'flushing_ios' is
empty, and then submit 'flush_bio', however, r5l_log_flush_endio()
is clearing the list first and then clear the bio, which will cause
null-ptr-deref:

T1: submit flush io
raid5d
 handle_active_stripes
  r5l_flush_stripe_to_raid
   // list is empty
   // add 'io_end_ios' to the list
   bio_init
   submit_bio
   // io1

T2: io1 is done
r5l_log_flush_endio
 list_splice_tail_init
 // clear the list
			T3: submit new flush io
			...
			r5l_flush_stripe_to_raid
			 // list is empty
			 // add 'io_end_ios' to the list
			 bio_init
 bio_uninit
 // clear bio->bi_blkg
			 submit_bio
			 // null-ptr-deref

Fix this problem by clearing bio before clearing the list in
r5l_log_flush_endio().

Fixes: 0dd00cba99c3 ("raid5-cache: fully initialize flush_bio when needed")
Reported-and-tested-by: Corey Hickey <bugfood-ml@fatooh.org>
Closes: https://lore.kernel.org/all/cddd7213-3dfd-4ab7-a3ac-edd54d74a626@fatooh.org/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid5-cache.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 2eac4a50d99bd..8b3fc484fd758 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1260,14 +1260,13 @@ static void r5l_log_flush_endio(struct bio *bio)
 
 	if (bio->bi_status)
 		md_error(log->rdev->mddev, log->rdev);
+	bio_uninit(bio);
 
 	spin_lock_irqsave(&log->io_list_lock, flags);
 	list_for_each_entry(io, &log->flushing_ios, log_sibling)
 		r5l_io_run_stripes(io);
 	list_splice_tail_init(&log->flushing_ios, &log->finished_ios);
 	spin_unlock_irqrestore(&log->io_list_lock, flags);
-
-	bio_uninit(bio);
 }
 
 /*
-- 
2.40.1



