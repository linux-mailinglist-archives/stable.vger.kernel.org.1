Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A1A7611AC
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGYKyi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjGYKxq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:53:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400CD3C2D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:52:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD9A961681
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AF1C433C7;
        Tue, 25 Jul 2023 10:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282327;
        bh=UGZNxAi0mkTEbho6xJzTAYFYpXuw3NADS3Ic0xURk0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qBkvs4itvpJLkO39dT82PVSq6u/+dXmoqQBfBmX93yALD7yeo0bYplPyhv/zn1vKb
         pT11pntjKsAp1QMP/89jgT9rFYKWVvBOVZrpUIC2pz5KLVv10HLtDTvimZWLPW0UaH
         kfUDOGnOleVWrfwKrsm5P6eHe5Xjjg8s7VRoSo00=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 089/227] md/raid10: prevent soft lockup while flush writes
Date:   Tue, 25 Jul 2023 12:44:16 +0200
Message-ID: <20230725104518.418646628@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 010444623e7f4da6b4a4dd603a7da7469981e293 ]

Currently, there is no limit for raid1/raid10 plugged bio. While flushing
writes, raid1 has cond_resched() while raid10 doesn't, and too many
writes can cause soft lockup.

Follow up soft lockup can be triggered easily with writeback test for
raid10 with ramdisks:

watchdog: BUG: soft lockup - CPU#10 stuck for 27s! [md0_raid10:1293]
Call Trace:
 <TASK>
 call_rcu+0x16/0x20
 put_object+0x41/0x80
 __delete_object+0x50/0x90
 delete_object_full+0x2b/0x40
 kmemleak_free+0x46/0xa0
 slab_free_freelist_hook.constprop.0+0xed/0x1a0
 kmem_cache_free+0xfd/0x300
 mempool_free_slab+0x1f/0x30
 mempool_free+0x3a/0x100
 bio_free+0x59/0x80
 bio_put+0xcf/0x2c0
 free_r10bio+0xbf/0xf0
 raid_end_bio_io+0x78/0xb0
 one_write_done+0x8a/0xa0
 raid10_end_write_request+0x1b4/0x430
 bio_endio+0x175/0x320
 brd_submit_bio+0x3b9/0x9b7 [brd]
 __submit_bio+0x69/0xe0
 submit_bio_noacct_nocheck+0x1e6/0x5a0
 submit_bio_noacct+0x38c/0x7e0
 flush_pending_writes+0xf0/0x240
 raid10d+0xac/0x1ed0

Fix the problem by adding cond_resched() to raid10 like what raid1 did.

Note that unlimited plugged bio still need to be optimized, for example,
in the case of lots of dirty pages writeback, this will take lots of
memory and io will spend a long time in plug, hence io latency is bad.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230529131106.2123367-2-yukuai1@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid10.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 9d23963496194..ee75b058438f3 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -920,6 +920,7 @@ static void flush_pending_writes(struct r10conf *conf)
 
 			raid1_submit_write(bio);
 			bio = next;
+			cond_resched();
 		}
 		blk_finish_plug(&plug);
 	} else
@@ -1132,6 +1133,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 
 		raid1_submit_write(bio);
 		bio = next;
+		cond_resched();
 	}
 	kfree(plug);
 }
-- 
2.39.2



