Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163127BAA36
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 21:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjJETfO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 15:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjJETfN (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 15:35:13 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A561DB
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 12:35:11 -0700 (PDT)
Received: from rrs24-12-35.corp.microsoft.com (unknown [131.107.1.128])
        by linux.microsoft.com (Postfix) with ESMTPSA id CF77B20B74C3;
        Thu,  5 Oct 2023 12:35:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CF77B20B74C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1696534510;
        bh=Kic4VFAv48XKhysYyNiBWgAF46JvmXDZd0EU//vuFsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pBPbGXfBa3I2QQEaCi8Q7Ppf2mvX/2c971Bn1YewT96uXoUhogApPGzyoLDffZmIG
         fUuB3j6aElOai/cEW1evXmkRREaN5iUubKr0kDZYvHU8SePR7BTk3p8Ky3z14m8sKD
         tcrX3XT6Azp3HPTr4iLDEGW6tjrKyv5y9jOZlVHw=
From:   Easwar Hariharan <eahariha@linux.microsoft.com>
To:     stable@vger.kernel.org
Cc:     Robin Murphy <robin.murphy@arm.com>, Rui Zhu <zhurui3@huawei.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 6.1 2/2] iommu/arm-smmu-v3: Avoid constructing invalid range commands
Date:   Thu,  5 Oct 2023 19:35:02 +0000
Message-Id: <20231005193502.657149-3-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005193502.657149-1-eahariha@linux.microsoft.com>
References: <20231005193502.657149-1-eahariha@linux.microsoft.com>
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
index becf37c08877..8966f7d5aab6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1886,18 +1886,23 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
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

