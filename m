Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DF67BDEE4
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376486AbjJINYU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376817AbjJINYE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:24:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD1194
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:24:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920A1C433C7;
        Mon,  9 Oct 2023 13:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857843;
        bh=tZ9maNSqMzJyVW0Ml0y4qXaLS9h3uqVuPs6DUz0OgFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1l6oETzGVVf/b4JnfCLeyYF05it/IBO/wY0gnJblkA7aWYkyxbnFgGPxwwE7fOh67
         kNVF+bsgoU1z6T6NNtOvAoEeCwIWojbngXbMD1nkGn5yTbcb6C3DjxWCI1ndERrqqE
         mv4eGaJADjkZwWdszsnFVkLJIBXd25ke1COwlP6Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 11/75] iommu/arm-smmu-v3: Set TTL invalidation hint better
Date:   Mon,  9 Oct 2023 15:01:33 +0200
Message-ID: <20231009130111.623359861@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.200710898@linuxfoundation.org>
References: <20231009130111.200710898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit 6833b8f2e19945a41e4d5efd8c6d9f4cae9a5b7d ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 340ef116d574a..67845f8e1df9f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1884,8 +1884,13 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
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
2.40.1



