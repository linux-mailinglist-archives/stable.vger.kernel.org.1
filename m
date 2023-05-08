Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299266FAA35
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbjEHLAl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbjEHLAS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:00:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D8330451
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:58:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BBD762A04
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC67CC433D2;
        Mon,  8 May 2023 10:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543526;
        bh=Ys2zBhD7Wqow+QQ7ZBSq0/2bwRlGXtzRXFIZfd4Ojn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gs9ZQNrHPpeRkelo8PIAhGkVtwFHwT4/+hzfPrjacHvzK/Kbuhl1hYEjUXL0LCmAh
         wjj55mHCF0k9v8Lpu7lKE944rAX7ofgUdEjHGCK8bVwI88josoQ+rCd9aaspDWrFER
         9xY8krijsEG1VGTCUuX1BRh4cj/mn4AkGl8p/nOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tanmay Shah <tanmay.shah@amd.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 6.3 119/694] drivers: remoteproc: xilinx: Fix carveout names
Date:   Mon,  8 May 2023 11:39:14 +0200
Message-Id: <20230508094436.338315855@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tanmay Shah <tanmay.shah@amd.com>

commit 81c18e08a609706c5c2887f267135fa0dece4119 upstream.

If the unit address is appended to node name of memory-region,
then adding rproc carveouts fails as node name and unit-address
both are passed as carveout name (i.e. vdev0vring0@xxxxxxxx). However,
only node name is expected by remoteproc framework. This patch moves
memory-region node parsing from driver probe to prepare and
only passes node-name and not unit-address

Fixes: 6b291e8020a8 ("drivers: remoteproc: Add Xilinx r5 remoteproc driver")
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230311012407.1292118-5-tanmay.shah@amd.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/remoteproc/xlnx_r5_remoteproc.c |   90 +++++++-------------------------
 1 file changed, 20 insertions(+), 70 deletions(-)

--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -61,8 +61,6 @@ static const struct mem_bank_data zynqmp
  * @np: device node of RPU instance
  * @tcm_bank_count: number TCM banks accessible to this RPU
  * @tcm_banks: array of each TCM bank data
- * @rmem_count: Number of reserved mem regions
- * @rmem: reserved memory region nodes from device tree
  * @rproc: rproc handle
  * @pm_domain_id: RPU CPU power domain id
  */
@@ -71,8 +69,6 @@ struct zynqmp_r5_core {
 	struct device_node *np;
 	int tcm_bank_count;
 	struct mem_bank_data **tcm_banks;
-	int rmem_count;
-	struct reserved_mem **rmem;
 	struct rproc *rproc;
 	u32 pm_domain_id;
 };
@@ -239,21 +235,29 @@ static int add_mem_regions_carveout(stru
 {
 	struct rproc_mem_entry *rproc_mem;
 	struct zynqmp_r5_core *r5_core;
+	struct of_phandle_iterator it;
 	struct reserved_mem *rmem;
-	int i, num_mem_regions;
+	int i = 0;
 
 	r5_core = (struct zynqmp_r5_core *)rproc->priv;
-	num_mem_regions = r5_core->rmem_count;
 
-	for (i = 0; i < num_mem_regions; i++) {
-		rmem = r5_core->rmem[i];
+	/* Register associated reserved memory regions */
+	of_phandle_iterator_init(&it, r5_core->np, "memory-region", NULL, 0);
 
-		if (!strncmp(rmem->name, "vdev0buffer", strlen("vdev0buffer"))) {
+	while (of_phandle_iterator_next(&it) == 0) {
+		rmem = of_reserved_mem_lookup(it.node);
+		if (!rmem) {
+			of_node_put(it.node);
+			dev_err(&rproc->dev, "unable to acquire memory-region\n");
+			return -EINVAL;
+		}
+
+		if (!strcmp(it.node->name, "vdev0buffer")) {
 			/* Init reserved memory for vdev buffer */
 			rproc_mem = rproc_of_resm_mem_entry_init(&rproc->dev, i,
 								 rmem->size,
 								 rmem->base,
-								 rmem->name);
+								 it.node->name);
 		} else {
 			/* Register associated reserved memory regions */
 			rproc_mem = rproc_mem_entry_init(&rproc->dev, NULL,
@@ -261,16 +265,19 @@ static int add_mem_regions_carveout(stru
 							 rmem->size, rmem->base,
 							 zynqmp_r5_mem_region_map,
 							 zynqmp_r5_mem_region_unmap,
-							 rmem->name);
+							 it.node->name);
 		}
 
-		if (!rproc_mem)
+		if (!rproc_mem) {
+			of_node_put(it.node);
 			return -ENOMEM;
+		}
 
 		rproc_add_carveout(rproc, rproc_mem);
 
 		dev_dbg(&rproc->dev, "reserved mem carveout %s addr=%llx, size=0x%llx",
-			rmem->name, rmem->base, rmem->size);
+			it.node->name, rmem->base, rmem->size);
+		i++;
 	}
 
 	return 0;
@@ -726,59 +733,6 @@ static int zynqmp_r5_get_tcm_node(struct
 	return 0;
 }
 
-/**
- * zynqmp_r5_get_mem_region_node()
- * parse memory-region property and get reserved mem regions
- *
- * @r5_core: pointer to zynqmp_r5_core type object
- *
- * Return: 0 for success and error code for failure.
- */
-static int zynqmp_r5_get_mem_region_node(struct zynqmp_r5_core *r5_core)
-{
-	struct device_node *np, *rmem_np;
-	struct reserved_mem **rmem;
-	int res_mem_count, i;
-	struct device *dev;
-
-	dev = r5_core->dev;
-	np = r5_core->np;
-
-	res_mem_count = of_property_count_elems_of_size(np, "memory-region",
-							sizeof(phandle));
-	if (res_mem_count <= 0) {
-		dev_warn(dev, "failed to get memory-region property %d\n",
-			 res_mem_count);
-		return 0;
-	}
-
-	rmem = devm_kcalloc(dev, res_mem_count,
-			    sizeof(struct reserved_mem *), GFP_KERNEL);
-	if (!rmem)
-		return -ENOMEM;
-
-	for (i = 0; i < res_mem_count; i++) {
-		rmem_np = of_parse_phandle(np, "memory-region", i);
-		if (!rmem_np)
-			goto release_rmem;
-
-		rmem[i] = of_reserved_mem_lookup(rmem_np);
-		if (!rmem[i]) {
-			of_node_put(rmem_np);
-			goto release_rmem;
-		}
-
-		of_node_put(rmem_np);
-	}
-
-	r5_core->rmem_count = res_mem_count;
-	r5_core->rmem = rmem;
-	return 0;
-
-release_rmem:
-	return -EINVAL;
-}
-
 /*
  * zynqmp_r5_core_init()
  * Create and initialize zynqmp_r5_core type object
@@ -806,10 +760,6 @@ static int zynqmp_r5_core_init(struct zy
 	for (i = 0; i < cluster->core_count; i++) {
 		r5_core = cluster->r5_cores[i];
 
-		ret = zynqmp_r5_get_mem_region_node(r5_core);
-		if (ret)
-			dev_warn(dev, "memory-region prop failed %d\n", ret);
-
 		/* Initialize r5 cores with power-domains parsed from dts */
 		ret = of_property_read_u32_index(r5_core->np, "power-domains",
 						 1, &r5_core->pm_domain_id);


