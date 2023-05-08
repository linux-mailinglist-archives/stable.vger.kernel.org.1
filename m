Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DC46FA61D
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbjEHKQZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjEHKQY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:16:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B4B4BBD8
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:16:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD035624A0
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6E3C433EF;
        Mon,  8 May 2023 10:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540982;
        bh=s/4IFvHmrdFgEa+fsPc5RU1or03Qnzq1K//Nobhwkec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DfYl5X3NpgFcg0KVczqUsB67zzQciH856P2rx+7avHECbqN40nhvZabpCz4ygkNrg
         GrSDPKqzEBDQ8Oc+oe7tkG5Yzx1fr6KgR5ZTDe4yxZigh5tbyLFoPYh2tsuIixQnGF
         SgHKa+aliVUQmAFZt6r4v0Pd6mSnQAo/UgDN+kog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jan Kara <jack@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH 6.1 571/611] md/raid5: Improve performance for sequential IO
Date:   Mon,  8 May 2023 11:46:53 +0200
Message-Id: <20230508094440.502469095@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Jan Kara <jack@suse.cz>

commit fc05e06e6098ca2c28f7a10da0e00aeea20fa59e upstream.

Commit 7e55c60acfbb ("md/raid5: Pivot raid5_make_request()") changed the
order in which requests for underlying disks are created. Since for
large sequential IO adding of requests frequently races with md_raid5
thread submitting bios to underlying disks, this results in a change in
IO pattern because intermediate states of new order of request creation
result in more smaller discontiguous requests. For RAID5 on top of three
rotational disks our performance testing revealed this results in
regression in write throughput:

iozone -a -s 131072000 -y 4 -q 8 -i 0 -i 1 -R

before 7e55c60acfbb:
              KB  reclen   write rewrite    read    reread
       131072000       4  493670  525964   524575   513384
       131072000       8  540467  532880   512028   513703

after 7e55c60acfbb:
              KB  reclen   write rewrite    read    reread
       131072000       4  421785  456184   531278   509248
       131072000       8  459283  456354   528449   543834

To reduce the amount of discontiguous requests we can start generating
requests with the stripe with the lowest chunk offset as that has the
best chance of being adjacent to IO queued previously. This improves the
performance to:
              KB  reclen   write rewrite    read    reread
       131072000       4  497682  506317   518043   514559
       131072000       8  514048  501886   506453   504319

restoring big part of the regression.

Fixes: 7e55c60acfbb ("md/raid5: Pivot raid5_make_request()")
Cc: stable@vger.kernel.org # v6.0+
Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230417171537.17899-1-jack@suse.cz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid5.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 812a12e3e41a..4739ed891e75 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6079,6 +6079,38 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 	return ret;
 }
 
+/*
+ * If the bio covers multiple data disks, find sector within the bio that has
+ * the lowest chunk offset in the first chunk.
+ */
+static sector_t raid5_bio_lowest_chunk_sector(struct r5conf *conf,
+					      struct bio *bi)
+{
+	int sectors_per_chunk = conf->chunk_sectors;
+	int raid_disks = conf->raid_disks;
+	int dd_idx;
+	struct stripe_head sh;
+	unsigned int chunk_offset;
+	sector_t r_sector = bi->bi_iter.bi_sector & ~((sector_t)RAID5_STRIPE_SECTORS(conf)-1);
+	sector_t sector;
+
+	/* We pass in fake stripe_head to get back parity disk numbers */
+	sector = raid5_compute_sector(conf, r_sector, 0, &dd_idx, &sh);
+	chunk_offset = sector_div(sector, sectors_per_chunk);
+	if (sectors_per_chunk - chunk_offset >= bio_sectors(bi))
+		return r_sector;
+	/*
+	 * Bio crosses to the next data disk. Check whether it's in the same
+	 * chunk.
+	 */
+	dd_idx++;
+	while (dd_idx == sh.pd_idx || dd_idx == sh.qd_idx)
+		dd_idx++;
+	if (dd_idx >= raid_disks)
+		return r_sector;
+	return r_sector + sectors_per_chunk - chunk_offset;
+}
+
 static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 {
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
@@ -6150,6 +6182,17 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 	}
 	md_account_bio(mddev, &bi);
 
+	/*
+	 * Lets start with the stripe with the lowest chunk offset in the first
+	 * chunk. That has the best chances of creating IOs adjacent to
+	 * previous IOs in case of sequential IO and thus creates the most
+	 * sequential IO pattern. We don't bother with the optimization when
+	 * reshaping as the performance benefit is not worth the complexity.
+	 */
+	if (likely(conf->reshape_progress == MaxSector))
+		logical_sector = raid5_bio_lowest_chunk_sector(conf, bi);
+	s = (logical_sector - ctx.first_sector) >> RAID5_STRIPE_SHIFT(conf);
+
 	add_wait_queue(&conf->wait_for_overlap, &wait);
 	while (1) {
 		res = make_stripe_request(mddev, conf, &ctx, logical_sector,
@@ -6178,7 +6221,7 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 			continue;
 		}
 
-		s = find_first_bit(ctx.sectors_to_do, stripe_cnt);
+		s = find_next_bit_wrap(ctx.sectors_to_do, stripe_cnt, s);
 		if (s == stripe_cnt)
 			break;
 
-- 
2.40.1



