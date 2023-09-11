Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2112E79BFC0
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbjIKVKQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239288AbjIKOQl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:16:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EDEDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:16:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6894FC433C7;
        Mon, 11 Sep 2023 14:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441796;
        bh=tQA/G8/GCFZTwxNQonlssuelAucNG4eTjpEESAJhKCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qg3nSCbCMklhYhXTfjc6zKdHs3mML8HfTq7XTIvQ6F8UeG2+6yjTG4Qk4Y/uKmg/M
         wMP9c7ftD8qX+Vo518fGjC1eZfqmfBvqcHgHYS23teNaqdpoQijjG1qAKvnzd9P8uh
         4pg/+3bGig2X5Uz/9J2flCGBvtTYfC2oHlDrWpAU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        Yanfei Xu <yanfei.xu@intel.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 522/739] iommu/vt-d: Fix to flush cache of PASID directory table
Date:   Mon, 11 Sep 2023 15:45:21 +0200
Message-ID: <20230911134705.693220497@linuxfoundation.org>
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

From: Yanfei Xu <yanfei.xu@intel.com>

[ Upstream commit 8a3b8e63f8371c1247b7aa24ff9c5312f1a6948b ]

Even the PCI devices don't support pasid capability, PASID table is
mandatory for a PCI device in scalable mode. However flushing cache
of pasid directory table for these devices are not taken after pasid
table is allocated as the "size" of table is zero. Fix it by
calculating the size by page order.

Found this when reading the code, no real problem encountered for now.

Fixes: 194b3348bdbb ("iommu/vt-d: Fix PASID directory pointer coherency")
Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
Link: https://lore.kernel.org/r/20230616081045.721873-1-yanfei.xu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel/pasid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c5d479770e12e..49fc5a038a145 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -129,7 +129,7 @@ int intel_pasid_alloc_table(struct device *dev)
 	info->pasid_table = pasid_table;
 
 	if (!ecap_coherent(info->iommu->ecap))
-		clflush_cache_range(pasid_table->table, size);
+		clflush_cache_range(pasid_table->table, (1 << order) * PAGE_SIZE);
 
 	return 0;
 }
-- 
2.40.1



