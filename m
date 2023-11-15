Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8A47ECEF6
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbjKOTpZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbjKOTpX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:45:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0062B1AB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:45:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D957C433C7;
        Wed, 15 Nov 2023 19:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077519;
        bh=IF4xra8U/kAhKnIj0yO4gD7owuMIbIUnEt8dGSg8AJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uNq7duWCd1s3aK0tSbFa0mkA6c4HhnR22lMvuPmb6QAOVTaMLX3czIU1bRmkc3anK
         PVeQdMKK1dDfBYRDt1+zdSVEZoN3bb9LWIiZPefC5ZkCNTsQUOqaPie83PfqX2q3Oz
         pFyj50UffQ0tG6ZQr4w+KGaOb7tDWmMShwymdwRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 327/603] iommufd: Add iopt_area_alloc()
Date:   Wed, 15 Nov 2023 14:14:32 -0500
Message-ID: <20231115191636.133389308@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit 361d744ddd61de065fbeb042aaed590d32dd92ec ]

We never initialize the two interval tree nodes, and zero fill is not the
same as RB_CLEAR_NODE. This can hide issues where we missed adding the
area to the trees. Factor out the allocation and clear the two nodes.

Fixes: 51fe6141f0f6 ("iommufd: Data structure to provide IOVA to PFN mapping")
Link: https://lore.kernel.org/r/20231030145035.GG691768@ziepe.ca
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommufd/io_pagetable.c | 18 +++++++++++++++---
 drivers/iommu/iommufd/pages.c        |  2 ++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 3a598182b7619..a4da1817e19dd 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -221,6 +221,18 @@ static int iopt_insert_area(struct io_pagetable *iopt, struct iopt_area *area,
 	return 0;
 }
 
+static struct iopt_area *iopt_area_alloc(void)
+{
+	struct iopt_area *area;
+
+	area = kzalloc(sizeof(*area), GFP_KERNEL_ACCOUNT);
+	if (!area)
+		return NULL;
+	RB_CLEAR_NODE(&area->node.rb);
+	RB_CLEAR_NODE(&area->pages_node.rb);
+	return area;
+}
+
 static int iopt_alloc_area_pages(struct io_pagetable *iopt,
 				 struct list_head *pages_list,
 				 unsigned long length, unsigned long *dst_iova,
@@ -231,7 +243,7 @@ static int iopt_alloc_area_pages(struct io_pagetable *iopt,
 	int rc = 0;
 
 	list_for_each_entry(elm, pages_list, next) {
-		elm->area = kzalloc(sizeof(*elm->area), GFP_KERNEL_ACCOUNT);
+		elm->area = iopt_area_alloc();
 		if (!elm->area)
 			return -ENOMEM;
 	}
@@ -1005,11 +1017,11 @@ static int iopt_area_split(struct iopt_area *area, unsigned long iova)
 	    iopt_area_start_byte(area, new_start) & (alignment - 1))
 		return -EINVAL;
 
-	lhs = kzalloc(sizeof(*area), GFP_KERNEL_ACCOUNT);
+	lhs = iopt_area_alloc();
 	if (!lhs)
 		return -ENOMEM;
 
-	rhs = kzalloc(sizeof(*area), GFP_KERNEL_ACCOUNT);
+	rhs = iopt_area_alloc();
 	if (!rhs) {
 		rc = -ENOMEM;
 		goto err_free_lhs;
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 8d9aa297c117e..528f356238b34 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1507,6 +1507,8 @@ void iopt_area_unfill_domains(struct iopt_area *area, struct iopt_pages *pages)
 				area, domain, iopt_area_index(area),
 				iopt_area_last_index(area));
 
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+		WARN_ON(RB_EMPTY_NODE(&area->pages_node.rb));
 	interval_tree_remove(&area->pages_node, &pages->domains_itree);
 	iopt_area_unfill_domain(area, pages, area->storage_domain);
 	area->storage_domain = NULL;
-- 
2.42.0



