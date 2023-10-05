Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF347BAA39
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 21:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjJETfc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 15:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjJETfc (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 15:35:32 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEB65DB
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 12:35:27 -0700 (PDT)
Received: from rrs24-12-35.corp.microsoft.com (unknown [131.107.1.224])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6A38820B74C3;
        Thu,  5 Oct 2023 12:35:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6A38820B74C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1696534527;
        bh=TdgzeK3/PxkwDFHTVp8AYAOqt9gSf9WpMJNQKP/WToU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uca9fEwlmvXsiGODj0cN8vJ/CvHHg4y35NBKhguyCDtYiZXGjsld7gSyVwDajco76
         FZTUORktcb1V+x2y7i4gnV8XxfnKSLbYGz4LjSmuQQl+Q7MD+FU5PAdzRmWxyD8mev
         XQSDkZgF47lEBe3jYRaad+G7QO52Borx+DVjAzbI=
From:   Easwar Hariharan <eahariha@linux.microsoft.com>
To:     stable@vger.kernel.org
Cc:     Robin Murphy <robin.murphy@arm.com>, Rui Zhu <zhurui3@huawei.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 5.15 2/2] iommu/arm-smmu-v3: Avoid constructing invalid range commands
Date:   Thu,  5 Oct 2023 19:35:20 +0000
Message-Id: <20231005193520.657277-3-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005193520.657277-1-eahariha@linux.microsoft.com>
References: <20231005193520.657277-1-eahariha@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

commit eb6c97647be227822c7ce23655482b05e348fba5 upstream

Although io-pgtable's non-leaf invalidations are always for full tables,
I missed that SVA also uses non-leaf invalidations, while being at the
mercy of whatever range the MMU notifier throws at it. This means it
definitely wants the previous TTL fix as well, since it also doesn't
know exactly which leaf level(s) may need invalidating, but it can also
give us less-aligned ranges wherein certain corners may lead to building
an invalid command where TTL, Num and Scale are all 0. It should be fine
to handle this by over-invalidating an extra page, since falling back to
a non-range command opens up a whole can of errata-flavoured worms.

Fixes: 6833b8f2e199 ("iommu/arm-smmu-v3: Set TTL invalidation hint better")
Reported-by: Rui Zhu <zhurui3@huawei.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/b99cfe71af2bd93a8a2930f20967fb2a4f7748dd.1694432734.git.robin.murphy@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 67845f8e1df9..761cb657f256 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1881,18 +1881,23 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 		/* Get the leaf page size */
 		tg = __ffs(smmu_domain->domain.pgsize_bitmap);
 
+		num_pages = size >> tg;
+
 		/* Convert page size of 12,14,16 (log2) to 1,2,3 */
 		cmd->tlbi.tg = (tg - 10) / 2;
 
 		/*
-		 * Determine what level the granule is at. For non-leaf, io-pgtable
-		 * assumes .tlb_flush_walk can invalidate multiple levels at once,
-		 * so ignore the nominal last-level granule and leave TTL=0.
+		 * Determine what level the granule is at. For non-leaf, both
+		 * io-pgtable and SVA pass a nominal last-level granule because
+		 * they don't know what level(s) actually apply, so ignore that
+		 * and leave TTL=0. However for various errata reasons we still
+		 * want to use a range command, so avoid the SVA corner case
+		 * where both scale and num could be 0 as well.
 		 */
 		if (cmd->tlbi.leaf)
 			cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
-
-		num_pages = size >> tg;
+		else if ((num_pages & CMDQ_TLBI_RANGE_NUM_MAX) == 1)
+			num_pages++;
 	}
 
 	cmds.num = 0;
-- 
2.34.1

