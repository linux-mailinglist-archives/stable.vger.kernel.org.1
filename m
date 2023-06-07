Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEC8726DCD
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbjFGUpa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbjFGUpQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:45:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADC12680
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:45:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFEE364653
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F421FC433EF;
        Wed,  7 Jun 2023 20:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170708;
        bh=ccY9kNcRCwAvdcz5NUVxfEw3Gr/8eP2fXagni27mMW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ypb7jlA0Y/Qh9+78ixWC2DqdfoVfd57uC0EJLYEUDb+zTq/XI2Rp7fwKe+Yh5QzVG
         v0bq3/Ctpc7Oj7UB0L2xRM+PVhfhnbulYmqSzMeeMnygwcl8rBfyQxmqYpWP/mFgfN
         v1lpVLmoD+ILbjjQoBgJHKneUll/NF8AF9SIKDww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>
Subject: [PATCH 6.1 159/225] md/raid5: fix miscalculation of end_sector in raid5_read_one_chunk()
Date:   Wed,  7 Jun 2023 22:15:52 +0200
Message-ID: <20230607200919.603401471@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

commit 8557dc27126949c702bd3aafe8a7e0b7e4fcb44c upstream.

'end_sector' is compared to 'rdev->recovery_offset', which is offset to
rdev, however, commit e82ed3a4fbb5 ("md/raid6: refactor
raid5_read_one_chunk") changes the calculation of 'end_sector' to offset
to the array. Fix this miscalculation.

Fixes: e82ed3a4fbb5 ("md/raid6: refactor raid5_read_one_chunk")
Cc: stable@vger.kernel.org # v5.12+
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230524014118.3172781-1-yukuai1@huaweicloud.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid5.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5516,7 +5516,7 @@ static int raid5_read_one_chunk(struct m
 
 	sector = raid5_compute_sector(conf, raid_bio->bi_iter.bi_sector, 0,
 				      &dd_idx, NULL);
-	end_sector = bio_end_sector(raid_bio);
+	end_sector = sector + bio_sectors(raid_bio);
 
 	rcu_read_lock();
 	if (r5c_big_stripe_cached(conf, sector))


