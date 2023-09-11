Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E75F79B095
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357987AbjIKWHJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238869AbjIKOGx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:06:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E59CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:06:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D5AC433C8;
        Mon, 11 Sep 2023 14:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441208;
        bh=zrBDYdO/6kyML09neElMp5WiecKii5AbFg9BrJquGi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uZXbRjQLIpseAqr4Dj583FDkUP4g6Y2D9v3Yfnp60w8Y9xt3Rd/ZHIvlse3NYJyiB
         /9yZrtqO5Hjt2SV4Z/coqEPtk+7fJzC//FYrwxtTUeJiTsVkIdhMlDPftBhQQDEdIm
         AxqMLwBg3+Uqe7bGmphv25YW+Dj8+IyeYu2G+lqE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 332/739] bio-integrity: create multi-page bvecs in bio_integrity_add_page()
Date:   Mon, 11 Sep 2023 15:42:11 +0200
Message-ID: <20230911134700.366193903@linuxfoundation.org>
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

From: Jinyoung Choi <j-young.choi@samsung.com>

[ Upstream commit 0ece1d649b6dd615925a72bc1824d6b9fa5b998a ]

In general, the bvec data structure consists of one for physically
continuous pages. But, in the bvec configuration for bip, physically
continuous integrity pages are composed of each bvec.

Allow bio_integrity_add_page() to create multi-page bvecs, just like
the bio payloads. This simplifies adding larger payloads, and fixes
support for non-tiny workloads with nvme, which stopped using
scatterlist for metadata a while ago.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Fixes: 783b94bd9250 ("nvme-pci: do not build a scatterlist to map metadata")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
Tested-by: "Martin K. Petersen" <martin.petersen@oracle.com>
Reviewed-by: "Martin K. Petersen" <martin.petersen@oracle.com>
Link: https://lore.kernel.org/r/20230803025202epcms2p82f57cbfe32195da38c776377b55aed59@epcms2p8
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio-integrity.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 4533eb4916610..6f81c10757fb9 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -123,17 +123,34 @@ void bio_integrity_free(struct bio *bio)
 int bio_integrity_add_page(struct bio *bio, struct page *page,
 			   unsigned int len, unsigned int offset)
 {
+	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 
-	if (bip->bip_vcnt >= bip->bip_max_vcnt) {
-		printk(KERN_ERR "%s: bip_vec full\n", __func__);
+	if (((bip->bip_iter.bi_size + len) >> SECTOR_SHIFT) >
+	    queue_max_hw_sectors(q))
 		return 0;
-	}
 
-	if (bip->bip_vcnt &&
-	    bvec_gap_to_prev(&bdev_get_queue(bio->bi_bdev)->limits,
-			     &bip->bip_vec[bip->bip_vcnt - 1], offset))
-		return 0;
+	if (bip->bip_vcnt > 0) {
+		struct bio_vec *bv = &bip->bip_vec[bip->bip_vcnt - 1];
+		bool same_page = false;
+
+		if (bvec_try_merge_hw_page(q, bv, page, len, offset,
+					   &same_page)) {
+			bip->bip_iter.bi_size += len;
+			return len;
+		}
+
+		if (bip->bip_vcnt >=
+		    min(bip->bip_max_vcnt, queue_max_integrity_segments(q)))
+			return 0;
+
+		/*
+		 * If the queue doesn't support SG gaps and adding this segment
+		 * would create a gap, disallow it.
+		 */
+		if (bvec_gap_to_prev(&q->limits, bv, offset))
+			return 0;
+	}
 
 	bvec_set_page(&bip->bip_vec[bip->bip_vcnt], page, len, offset);
 	bip->bip_vcnt++;
-- 
2.40.1



