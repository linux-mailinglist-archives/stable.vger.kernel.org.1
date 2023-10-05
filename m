Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB897BAA35
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 21:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjJETfO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 15:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjJETfN (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 15:35:13 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 287EDCE
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 12:35:11 -0700 (PDT)
Received: from rrs24-12-35.corp.microsoft.com (unknown [131.107.1.128])
        by linux.microsoft.com (Postfix) with ESMTPSA id AF83920B74C2;
        Thu,  5 Oct 2023 12:35:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AF83920B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1696534510;
        bh=0rLftGJJjoX9NTEGfIp0gy1k+7vcQlfs++YbS5qPELA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KlXkItxkzQ+hpbt6eB8BMZRAZMOl74wiCQQ1zZ6+Tf9lkZ2Y6KeN9sR2+rkQs3ysO
         +hVCtQaesCwhVtPMGDd4cYFcGaEyLvD2mWz2DVtFvCHfbeNAZCTImT5AIF+qvl4dQ4
         V8M39JF0HjhpRsxoZax/HeOXr466S4CeNTS+Yuiw=
From:   Easwar Hariharan <eahariha@linux.microsoft.com>
To:     stable@vger.kernel.org
Cc:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 6.1 1/2] iommu/arm-smmu-v3: Set TTL invalidation hint better
Date:   Thu,  5 Oct 2023 19:35:01 +0000
Message-Id: <20231005193502.657149-2-eahariha@linux.microsoft.com>
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

commit 6833b8f2e19945a41e4d5efd8c6d9f4cae9a5b7d upstream

When io-pgtable unmaps a whole table, rather than waste time walking it
to find the leaf entries to invalidate exactly, it simply expects
.tlb_flush_walk with nominal last-level granularity to invalidate any
leaf entries at higher intermediate levels as well. This works fine with
page-based invalidation, but with range commands we need to be careful
with the TTL hint - unconditionally setting it based on the given level
3 granule means that an invalidation for a level 1 table would strictly
not be required to affect level 2 block entries. It's easy to comply
with the expected behaviour by simply not setting the TTL hint for
non-leaf invalidations, so let's do that.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/b409d9a17c52dc0db51faee91d92737bb7975f5b.1685637456.git.robin.murphy@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index db33dc87f69e..becf37c08877 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1889,8 +1889,13 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 		/* Convert page size of 12,14,16 (log2) to 1,2,3 */
 		cmd->tlbi.tg = (tg - 10) / 2;
 
-		/* Determine what level the granule is at */
-		cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
+		/*
+		 * Determine what level the granule is at. For non-leaf, io-pgtable
+		 * assumes .tlb_flush_walk can invalidate multiple levels at once,
+		 * so ignore the nominal last-level granule and leave TTL=0.
+		 */
+		if (cmd->tlbi.leaf)
+			cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
 
 		num_pages = size >> tg;
 	}
-- 
2.34.1

