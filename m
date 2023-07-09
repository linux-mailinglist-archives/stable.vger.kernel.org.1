Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A7074C3C2
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjGILf7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjGILf6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:35:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599E018F
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:35:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC92860BC0
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:35:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEC6C433C8;
        Sun,  9 Jul 2023 11:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902556;
        bh=mpspB9rfoyg8ylOJB46bfMOntOZXSsma2ISlCKwX9CM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uPoT5SVIjPsLgPyslMdnw2Ll7yPpHgDgYxQsZfjCaGtxNwByuvSUiCyQb81itM6GP
         lqgfblqZw4dCFQKJWOk9oqCNyHKuKW+7pwHCEEtXLC1fSt85ljrZ1I6RpPSjo7wJVs
         5fQMAmadF8GDuBi8Xh8qzArnw+Gtc/T2Y2WYqqXI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 418/431] cxl/region: Move cache invalidation before region teardown, and before setup
Date:   Sun,  9 Jul 2023 13:16:06 +0200
Message-ID: <20230709111500.987262143@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

[ Upstream commit d1257d098a5a38753a0736a50db0a26a62377ad7 ]

Vikram raised a concern with the theoretical case of a CPU sending
MemClnEvict to a device that is not prepared to receive. MemClnEvict is
a message that is sent after a CPU has taken ownership of a cacheline
from accelerator memory (HDM-DB). In the case of hotplug or HDM decoder
reconfiguration it is possible that the CPU is holding old contents for
a new device that has taken over the physical address range being cached
by the CPU.

To avoid this scenario, invalidate caches prior to tearing down an HDM
decoder configuration.

Now, this poses another problem that it is possible for something to
speculate into that space while the decode configuration is still up, so
to close that gap also invalidate prior to establish new contents behind
a given physical address range.

With this change the cache invalidation is now explicit and need not be
checked in cxl_region_probe(), and that obviates the need for
CXL_REGION_F_INCOHERENT.

Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Fixes: d18bc74aced6 ("cxl/region: Manage CPU caches relative to DPA invalidation events")
Reported-by: Vikram Sethi <vsethi@nvidia.com>
Closes: http://lore.kernel.org/r/BYAPR12MB33364B5EB908BF7239BB996BBD53A@BYAPR12MB3336.namprd12.prod.outlook.com
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/168696506886.3590522.4597053660991916591.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/region.c | 66 ++++++++++++++++++++++-----------------
 drivers/cxl/cxl.h         |  8 +----
 2 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b2fd67fcebfb5..3b3bbd98e99d5 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -125,10 +125,38 @@ static struct cxl_region_ref *cxl_rr_load(struct cxl_port *port,
 	return xa_load(&port->regions, (unsigned long)cxlr);
 }
 
+static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
+{
+	if (!cpu_cache_has_invalidate_memregion()) {
+		if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
+			dev_warn_once(
+				&cxlr->dev,
+				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
+			return 0;
+		} else {
+			dev_err(&cxlr->dev,
+				"Failed to synchronize CPU cache state\n");
+			return -ENXIO;
+		}
+	}
+
+	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
+	return 0;
+}
+
 static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
 {
 	struct cxl_region_params *p = &cxlr->params;
-	int i;
+	int i, rc = 0;
+
+	/*
+	 * Before region teardown attempt to flush, and if the flush
+	 * fails cancel the region teardown for data consistency
+	 * concerns
+	 */
+	rc = cxl_region_invalidate_memregion(cxlr);
+	if (rc)
+		return rc;
 
 	for (i = count - 1; i >= 0; i--) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
@@ -136,7 +164,6 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
 		struct cxl_port *iter = cxled_to_port(cxled);
 		struct cxl_dev_state *cxlds = cxlmd->cxlds;
 		struct cxl_ep *ep;
-		int rc = 0;
 
 		if (cxlds->rcd)
 			goto endpoint_reset;
@@ -256,6 +283,14 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
 		goto out;
 	}
 
+	/*
+	 * Invalidate caches before region setup to drop any speculative
+	 * consumption of this address space
+	 */
+	rc = cxl_region_invalidate_memregion(cxlr);
+	if (rc)
+		return rc;
+
 	if (commit)
 		rc = cxl_region_decode_commit(cxlr);
 	else {
@@ -1674,7 +1709,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		if (rc)
 			goto err_decrement;
 		p->state = CXL_CONFIG_ACTIVE;
-		set_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
 	}
 
 	cxled->cxld.interleave_ways = p->interleave_ways;
@@ -2679,30 +2713,6 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, CXL);
 
-static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
-{
-	if (!test_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags))
-		return 0;
-
-	if (!cpu_cache_has_invalidate_memregion()) {
-		if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
-			dev_warn_once(
-				&cxlr->dev,
-				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
-			clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
-			return 0;
-		} else {
-			dev_err(&cxlr->dev,
-				"Failed to synchronize CPU cache state\n");
-			return -ENXIO;
-		}
-	}
-
-	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
-	clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
-	return 0;
-}
-
 static int is_system_ram(struct resource *res, void *arg)
 {
 	struct cxl_region *cxlr = arg;
@@ -2730,8 +2740,6 @@ static int cxl_region_probe(struct device *dev)
 		goto out;
 	}
 
-	rc = cxl_region_invalidate_memregion(cxlr);
-
 	/*
 	 * From this point on any path that changes the region's state away from
 	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 044a92d9813e2..70ab8fcd0377c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -462,18 +462,12 @@ struct cxl_region_params {
 	int nr_targets;
 };
 
-/*
- * Flag whether this region needs to have its HPA span synchronized with
- * CPU cache state at region activation time.
- */
-#define CXL_REGION_F_INCOHERENT 0
-
 /*
  * Indicate whether this region has been assembled by autodetection or
  * userspace assembly. Prevent endpoint decoders outside of automatic
  * detection from being added to the region.
  */
-#define CXL_REGION_F_AUTO 1
+#define CXL_REGION_F_AUTO 0
 
 /**
  * struct cxl_region - CXL region
-- 
2.39.2



