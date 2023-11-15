Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99A67ECD55
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbjKOTf4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbjKOTf4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:35:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A58A1A5
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:35:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDE2C433C8;
        Wed, 15 Nov 2023 19:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076951;
        bh=YuRJE311OlmkI4oDtd5cpZ+WU+yrw219MyTkDL+BtrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NbbPxuv1uc9Yb2ikz8VSVBhstOVHaqjy2c9a4Cqk0+1dvp0tLa2O+5VtZtdVhcmY5
         mJ42j4Q87UB8NCfIvUfihbsIFbVNHqu88/KarbetcCmM+j7N0YvoOVpua1zvRK2+4g
         Ujp817jqcbeAf+PQimvL7hkKBLgeSl3fx90Q4CMQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 465/550] cxl/core/regs: Rename @dev to @host in struct cxl_register_map
Date:   Wed, 15 Nov 2023 14:17:29 -0500
Message-ID: <20231115191633.105791781@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Richter <rrichter@amd.com>

[ Upstream commit dd22581f89537163f065e8ef7c125ce0fddf62cc ]

The primary role of @dev is to host the mappings for devm operations.
@dev is too ambiguous as a name. I.e. when does @dev refer to the
'struct device *' instance that the registers belong, and when does
@dev refer to the 'struct device *' instance hosting the mapping for
devm operations?

Clarify the role of @dev in cxl_register_map by renaming it to @host.
Also, rename local variables to 'host' where map->host is used.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://lore.kernel.org/r/20231018171713.1883517-3-rrichter@amd.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Stable-dep-of: 33d9c987bf8f ("cxl/port: Fix @host confusion in cxl_dport_setup_regs()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/hdm.c  |  2 +-
 drivers/cxl/core/port.c |  4 ++--
 drivers/cxl/core/regs.c | 28 ++++++++++++++--------------
 drivers/cxl/cxl.h       |  4 ++--
 drivers/cxl/pci.c       |  2 +-
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 506c9e14cdf98..3ad0d39d3d3fa 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -85,7 +85,7 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
 				struct cxl_component_regs *regs)
 {
 	struct cxl_register_map map = {
-		.dev = &port->dev,
+		.host = &port->dev,
 		.resource = port->component_reg_phys,
 		.base = crb,
 		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 5ba606c6e03ff..c24cfe2271948 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -697,14 +697,14 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 	return ERR_PTR(rc);
 }
 
-static int cxl_setup_comp_regs(struct device *dev, struct cxl_register_map *map,
+static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map,
 			       resource_size_t component_reg_phys)
 {
 	if (component_reg_phys == CXL_RESOURCE_NONE)
 		return 0;
 
 	*map = (struct cxl_register_map) {
-		.dev = dev,
+		.host = host,
 		.reg_type = CXL_REGLOC_RBI_COMPONENT,
 		.resource = component_reg_phys,
 		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 6281127b3e9d9..e0fbe964f6f0a 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -204,7 +204,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
 			   unsigned long map_mask)
 {
-	struct device *dev = map->dev;
+	struct device *host = map->host;
 	struct mapinfo {
 		const struct cxl_reg_map *rmap;
 		void __iomem **addr;
@@ -225,7 +225,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 			continue;
 		phys_addr = map->resource + mi->rmap->offset;
 		length = mi->rmap->size;
-		*(mi->addr) = devm_cxl_iomap_block(dev, phys_addr, length);
+		*(mi->addr) = devm_cxl_iomap_block(host, phys_addr, length);
 		if (!*(mi->addr))
 			return -ENOMEM;
 	}
@@ -237,7 +237,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_map_component_regs, CXL);
 int cxl_map_device_regs(const struct cxl_register_map *map,
 			struct cxl_device_regs *regs)
 {
-	struct device *dev = map->dev;
+	struct device *host = map->host;
 	resource_size_t phys_addr = map->resource;
 	struct mapinfo {
 		const struct cxl_reg_map *rmap;
@@ -259,7 +259,7 @@ int cxl_map_device_regs(const struct cxl_register_map *map,
 
 		addr = phys_addr + mi->rmap->offset;
 		length = mi->rmap->size;
-		*(mi->addr) = devm_cxl_iomap_block(dev, addr, length);
+		*(mi->addr) = devm_cxl_iomap_block(host, addr, length);
 		if (!*(mi->addr))
 			return -ENOMEM;
 	}
@@ -309,7 +309,7 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
 	int regloc, i;
 
 	*map = (struct cxl_register_map) {
-		.dev = &pdev->dev,
+		.host = &pdev->dev,
 		.resource = CXL_RESOURCE_NONE,
 	};
 
@@ -403,15 +403,15 @@ EXPORT_SYMBOL_NS_GPL(cxl_map_pmu_regs, CXL);
 
 static int cxl_map_regblock(struct cxl_register_map *map)
 {
-	struct device *dev = map->dev;
+	struct device *host = map->host;
 
 	map->base = ioremap(map->resource, map->max_size);
 	if (!map->base) {
-		dev_err(dev, "failed to map registers\n");
+		dev_err(host, "failed to map registers\n");
 		return -ENOMEM;
 	}
 
-	dev_dbg(dev, "Mapped CXL Memory Device resource %pa\n", &map->resource);
+	dev_dbg(host, "Mapped CXL Memory Device resource %pa\n", &map->resource);
 	return 0;
 }
 
@@ -425,28 +425,28 @@ static int cxl_probe_regs(struct cxl_register_map *map)
 {
 	struct cxl_component_reg_map *comp_map;
 	struct cxl_device_reg_map *dev_map;
-	struct device *dev = map->dev;
+	struct device *host = map->host;
 	void __iomem *base = map->base;
 
 	switch (map->reg_type) {
 	case CXL_REGLOC_RBI_COMPONENT:
 		comp_map = &map->component_map;
-		cxl_probe_component_regs(dev, base, comp_map);
-		dev_dbg(dev, "Set up component registers\n");
+		cxl_probe_component_regs(host, base, comp_map);
+		dev_dbg(host, "Set up component registers\n");
 		break;
 	case CXL_REGLOC_RBI_MEMDEV:
 		dev_map = &map->device_map;
-		cxl_probe_device_regs(dev, base, dev_map);
+		cxl_probe_device_regs(host, base, dev_map);
 		if (!dev_map->status.valid || !dev_map->mbox.valid ||
 		    !dev_map->memdev.valid) {
-			dev_err(dev, "registers not found: %s%s%s\n",
+			dev_err(host, "registers not found: %s%s%s\n",
 				!dev_map->status.valid ? "status " : "",
 				!dev_map->mbox.valid ? "mbox " : "",
 				!dev_map->memdev.valid ? "memdev " : "");
 			return -ENXIO;
 		}
 
-		dev_dbg(dev, "Probing device registers...\n");
+		dev_dbg(host, "Probing device registers...\n");
 		break;
 	default:
 		break;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 76d92561af294..b5b015b661eae 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -247,7 +247,7 @@ struct cxl_pmu_reg_map {
 
 /**
  * struct cxl_register_map - DVSEC harvested register block mapping parameters
- * @dev: device for devm operations and logging
+ * @host: device for devm operations and logging
  * @base: virtual base of the register-block-BAR + @block_offset
  * @resource: physical resource base of the register block
  * @max_size: maximum mapping size to perform register search
@@ -257,7 +257,7 @@ struct cxl_pmu_reg_map {
  * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
  */
 struct cxl_register_map {
-	struct device *dev;
+	struct device *host;
 	void __iomem *base;
 	resource_size_t resource;
 	resource_size_t max_size;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0ecd339b5b8e9..bb37e76ef5a68 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -474,7 +474,7 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
 	resource_size_t component_reg_phys;
 
 	*map = (struct cxl_register_map) {
-		.dev = &pdev->dev,
+		.host = &pdev->dev,
 		.resource = CXL_RESOURCE_NONE,
 	};
 
-- 
2.42.0



