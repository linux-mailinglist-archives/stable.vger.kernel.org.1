Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161A87B88D1
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243767AbjJDSTv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbjJDSTv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:19:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B23102
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:19:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C02FC433C9;
        Wed,  4 Oct 2023 18:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443585;
        bh=I0tfk7TZ4biX25Jj1lvzp7tqOlzU4YcA7PhR3VQqpBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yYaYgyPTg3+RS/K9FDyMaKbIvd7U3bSPfh4vaoLxRgAz1cixeS0BP9At4CyfWoQ8S
         +8rw36H7DZDq56Caf1nu/8+8vNqgCkd+V9jUPxNiePtUoUZxh+o/OYYNHs+flcL63X
         J17IvJ5+ypMaLl1hPpFC0LqSH+YvLDb2Dj9xVg8U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nicolin Chen <nicolinc@nvidia.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 208/259] iommu/arm-smmu-v3: Fix soft lockup triggered by arm_smmu_mm_invalidate_range
Date:   Wed,  4 Oct 2023 19:56:21 +0200
Message-ID: <20231004175226.835819189@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolin Chen <nicolinc@nvidia.com>

commit d5afb4b47e13161b3f33904d45110f9e6463bad6 upstream.

When running an SVA case, the following soft lockup is triggered:
--------------------------------------------------------------------
watchdog: BUG: soft lockup - CPU#244 stuck for 26s!
pstate: 83400009 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : arm_smmu_cmdq_issue_cmdlist+0x178/0xa50
lr : arm_smmu_cmdq_issue_cmdlist+0x150/0xa50
sp : ffff8000d83ef290
x29: ffff8000d83ef290 x28: 000000003b9aca00 x27: 0000000000000000
x26: ffff8000d83ef3c0 x25: da86c0812194a0e8 x24: 0000000000000000
x23: 0000000000000040 x22: ffff8000d83ef340 x21: ffff0000c63980c0
x20: 0000000000000001 x19: ffff0000c6398080 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: ffff3000b4a3bbb0
x14: ffff3000b4a30888 x13: ffff3000b4a3cf60 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : ffffc08120e4d6bc
x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000048cfa
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 000000000000000a
x2 : 0000000080000000 x1 : 0000000000000000 x0 : 0000000000000001
Call trace:
 arm_smmu_cmdq_issue_cmdlist+0x178/0xa50
 __arm_smmu_tlb_inv_range+0x118/0x254
 arm_smmu_tlb_inv_range_asid+0x6c/0x130
 arm_smmu_mm_invalidate_range+0xa0/0xa4
 __mmu_notifier_invalidate_range_end+0x88/0x120
 unmap_vmas+0x194/0x1e0
 unmap_region+0xb4/0x144
 do_mas_align_munmap+0x290/0x490
 do_mas_munmap+0xbc/0x124
 __vm_munmap+0xa8/0x19c
 __arm64_sys_munmap+0x28/0x50
 invoke_syscall+0x78/0x11c
 el0_svc_common.constprop.0+0x58/0x1c0
 do_el0_svc+0x34/0x60
 el0_svc+0x2c/0xd4
 el0t_64_sync_handler+0x114/0x140
 el0t_64_sync+0x1a4/0x1a8
--------------------------------------------------------------------

The commit 06ff87bae8d3 ("arm64: mm: remove unused functions and variable
protoypes") fixed a similar lockup on the CPU MMU side. Yet, it can occur
to SMMU too since arm_smmu_mm_invalidate_range() is typically called next
to MMU tlb flush function, e.g.
	tlb_flush_mmu_tlbonly {
		tlb_flush {
			__flush_tlb_range {
				// check MAX_TLBI_OPS
			}
		}
		mmu_notifier_invalidate_range {
			arm_smmu_mm_invalidate_range {
				// does not check MAX_TLBI_OPS
			}
		}
	}

Clone a CMDQ_MAX_TLBI_OPS from the MAX_TLBI_OPS in tlbflush.h, since in an
SVA case SMMU uses the CPU page table, so it makes sense to align with the
tlbflush code. Then, replace per-page TLBI commands with a single per-asid
TLBI command, if the request size hits this threshold.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Link: https://lore.kernel.org/r/20230920052257.8615-1-nicolinc@nvidia.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 27 ++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 5968a568aae2a..ffba8ce93ff88 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -186,6 +186,15 @@ static void arm_smmu_free_shared_cd(struct arm_smmu_ctx_desc *cd)
 	}
 }
 
+/*
+ * Cloned from the MAX_TLBI_OPS in arch/arm64/include/asm/tlbflush.h, this
+ * is used as a threshold to replace per-page TLBI commands to issue in the
+ * command queue with an address-space TLBI command, when SMMU w/o a range
+ * invalidation feature handles too many per-page TLBI commands, which will
+ * otherwise result in a soft lockup.
+ */
+#define CMDQ_MAX_TLBI_OPS		(1 << (PAGE_SHIFT - 3))
+
 static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 					 struct mm_struct *mm,
 					 unsigned long start, unsigned long end)
@@ -200,10 +209,22 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 	 * range. So do a simple translation here by calculating size correctly.
 	 */
 	size = end - start;
+	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_RANGE_INV)) {
+		if (size >= CMDQ_MAX_TLBI_OPS * PAGE_SIZE)
+			size = 0;
+	}
+
+	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM)) {
+		if (!size)
+			arm_smmu_tlb_inv_asid(smmu_domain->smmu,
+					      smmu_mn->cd->asid);
+		else
+			arm_smmu_tlb_inv_range_asid(start, size,
+						    smmu_mn->cd->asid,
+						    PAGE_SIZE, false,
+						    smmu_domain);
+	}
 
-	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
-		arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
-					    PAGE_SIZE, false, smmu_domain);
 	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
 }
 
-- 
2.40.1



