Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F47A703726
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243880AbjEORRS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243934AbjEORQ6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:16:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31CBA5C1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:15:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D391B62BDB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:15:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC1EC433D2;
        Mon, 15 May 2023 17:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170940;
        bh=ZfuOEwzso9eUrzVpijLnAEZz+BpJGGdeeAj+TpbY8EA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y3ForZBTEsDkJJe/docrTQHGj6l/Z5vaXmY/lK4+FZaHXX7Bk/dIl+JIKkksWK5hN
         EGTLd17spEMPlqQgJfowl5AqqOF0p0Mt+IDmlhTyBZL6HEZHtaPwPibOpeZ88BTOML
         R2QlzeMF3+WV/r7RrV9Mkxl4P6qPfhxd6zGoWEG4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xiangfei Ma <xiangfeix.ma@intel.com>,
        Farrah Chen <farrah.chen@intel.com>,
        Tao Su <tao1.su@linux.intel.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH 6.2 050/242] block: Skip destroyed blkg when restart in blkg_destroy_all()
Date:   Mon, 15 May 2023 18:26:16 +0200
Message-Id: <20230515161723.413933635@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

From: Tao Su <tao1.su@linux.intel.com>

[ Upstream commit 8176080d59e6d4ff9fc97ae534063073b4f7a715 ]

Kernel hang in blkg_destroy_all() when total blkg greater than
BLKG_DESTROY_BATCH_SIZE, because of not removing destroyed blkg in
blkg_list. So the size of blkg_list is same after destroying a
batch of blkg, and the infinite 'restart' occurs.

Since blkg should stay on the queue list until blkg_free_workfn(),
skip destroyed blkg when restart a new round, which will solve this
kernel hang issue and satisfy the previous will to restart.

Reported-by: Xiangfei Ma <xiangfeix.ma@intel.com>
Tested-by: Xiangfei Ma <xiangfeix.ma@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
Suggested-and-reviewed-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20230428045149.1310073-1-tao1.su@linux.intel.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-cgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 9ac1efb053e08..2d8a28e4e22f7 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -501,6 +501,9 @@ static void blkg_destroy_all(struct gendisk *disk)
 	list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
 
+		if (hlist_unhashed(&blkg->blkcg_node))
+			continue;
+
 		spin_lock(&blkcg->lock);
 		blkg_destroy(blkg);
 		spin_unlock(&blkcg->lock);
-- 
2.39.2



