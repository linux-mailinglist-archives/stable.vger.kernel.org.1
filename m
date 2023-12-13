Return-Path: <stable+bounces-5953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC21680D805
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF341F20FEB
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8A451C2E;
	Mon, 11 Dec 2023 18:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PRjNmCyC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79E51D696;
	Mon, 11 Dec 2023 18:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAB5C433C7;
	Mon, 11 Dec 2023 18:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320112;
	bh=qofyb2HQFnTqX/Fj5m3KJI9QxJ4SwKsQ8miayq51oxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PRjNmCyCx/MgWxQsj0m8yiUx/CYqgRUYGSpbHvYMl2v/XczrCLS9sDL4sVyZS2OhK
	 5V7xR0xqlwLGPE+m13Ch1UT67MV2dJsMbFXQklE/W3RQPjHz0Kk8NdZcqUCINkqLPF
	 vqSUswXfmpLBCqLUHpCGnEC2goa+vuRevChFa97A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Joerg Roedel <jroedel@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 10/67] of/iommu: Make of_map_rid() PCI agnostic
Date: Mon, 11 Dec 2023 19:21:54 +0100
Message-ID: <20231211182015.523558653@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182015.049134368@linuxfoundation.org>
References: <20231211182015.049134368@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

[ Upstream commit 746a71d02b5d15817fcb13c956ba999a87773952 ]

There is nothing PCI specific (other than the RID - requester ID)
in the of_map_rid() implementation, so the same function can be
reused for input/output IDs mapping for other busses just as well.

Rename the RID instances/names to a generic "id" tag.

No functionality change intended.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Joerg Roedel <jroedel@suse.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200619082013.13661-7-lorenzo.pieralisi@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Stable-dep-of: d79972789d17 ("of: dynamic: Fix of_reconfig_get_state_change() return value documentation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/of_iommu.c |  4 ++--
 drivers/of/base.c        | 42 ++++++++++++++++++++--------------------
 drivers/of/irq.c         |  2 +-
 include/linux/of.h       |  4 ++--
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 614a93aa5305a..656939ed842e7 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -121,7 +121,7 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	struct of_phandle_args iommu_spec = { .args_count = 1 };
 	int err;
 
-	err = of_map_rid(info->np, alias, "iommu-map", "iommu-map-mask",
+	err = of_map_id(info->np, alias, "iommu-map", "iommu-map-mask",
 			 &iommu_spec.np, iommu_spec.args);
 	if (err)
 		return err == -ENODEV ? NO_IOMMU : err;
@@ -137,7 +137,7 @@ static int of_fsl_mc_iommu_init(struct fsl_mc_device *mc_dev,
 	struct of_phandle_args iommu_spec = { .args_count = 1 };
 	int err;
 
-	err = of_map_rid(master_np, mc_dev->icid, "iommu-map",
+	err = of_map_id(master_np, mc_dev->icid, "iommu-map",
 			 "iommu-map-mask", &iommu_spec.np,
 			 iommu_spec.args);
 	if (err)
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 3f13b982e8b53..5c97366628b13 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2280,15 +2280,15 @@ int of_find_last_cache_level(unsigned int cpu)
 }
 
 /**
- * of_map_rid - Translate a requester ID through a downstream mapping.
+ * of_map_id - Translate an ID through a downstream mapping.
  * @np: root complex device node.
- * @rid: device requester ID to map.
+ * @id: device ID to map.
  * @map_name: property name of the map to use.
  * @map_mask_name: optional property name of the mask to use.
  * @target: optional pointer to a target device node.
  * @id_out: optional pointer to receive the translated ID.
  *
- * Given a device requester ID, look up the appropriate implementation-defined
+ * Given a device ID, look up the appropriate implementation-defined
  * platform ID and/or the target device which receives transactions on that
  * ID, as per the "iommu-map" and "msi-map" bindings. Either of @target or
  * @id_out may be NULL if only the other is required. If @target points to
@@ -2298,11 +2298,11 @@ int of_find_last_cache_level(unsigned int cpu)
  *
  * Return: 0 on success or a standard error code on failure.
  */
-int of_map_rid(struct device_node *np, u32 rid,
+int of_map_id(struct device_node *np, u32 id,
 	       const char *map_name, const char *map_mask_name,
 	       struct device_node **target, u32 *id_out)
 {
-	u32 map_mask, masked_rid;
+	u32 map_mask, masked_id;
 	int map_len;
 	const __be32 *map = NULL;
 
@@ -2314,7 +2314,7 @@ int of_map_rid(struct device_node *np, u32 rid,
 		if (target)
 			return -ENODEV;
 		/* Otherwise, no map implies no translation */
-		*id_out = rid;
+		*id_out = id;
 		return 0;
 	}
 
@@ -2334,22 +2334,22 @@ int of_map_rid(struct device_node *np, u32 rid,
 	if (map_mask_name)
 		of_property_read_u32(np, map_mask_name, &map_mask);
 
-	masked_rid = map_mask & rid;
+	masked_id = map_mask & id;
 	for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
 		struct device_node *phandle_node;
-		u32 rid_base = be32_to_cpup(map + 0);
+		u32 id_base = be32_to_cpup(map + 0);
 		u32 phandle = be32_to_cpup(map + 1);
 		u32 out_base = be32_to_cpup(map + 2);
-		u32 rid_len = be32_to_cpup(map + 3);
+		u32 id_len = be32_to_cpup(map + 3);
 
-		if (rid_base & ~map_mask) {
-			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores rid-base (0x%x)\n",
+		if (id_base & ~map_mask) {
+			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores id-base (0x%x)\n",
 				np, map_name, map_name,
-				map_mask, rid_base);
+				map_mask, id_base);
 			return -EFAULT;
 		}
 
-		if (masked_rid < rid_base || masked_rid >= rid_base + rid_len)
+		if (masked_id < id_base || masked_id >= id_base + id_len)
 			continue;
 
 		phandle_node = of_find_node_by_phandle(phandle);
@@ -2367,20 +2367,20 @@ int of_map_rid(struct device_node *np, u32 rid,
 		}
 
 		if (id_out)
-			*id_out = masked_rid - rid_base + out_base;
+			*id_out = masked_id - id_base + out_base;
 
-		pr_debug("%pOF: %s, using mask %08x, rid-base: %08x, out-base: %08x, length: %08x, rid: %08x -> %08x\n",
-			np, map_name, map_mask, rid_base, out_base,
-			rid_len, rid, masked_rid - rid_base + out_base);
+		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
+			np, map_name, map_mask, id_base, out_base,
+			id_len, id, masked_id - id_base + out_base);
 		return 0;
 	}
 
-	pr_info("%pOF: no %s translation for rid 0x%x on %pOF\n", np, map_name,
-		rid, target && *target ? *target : NULL);
+	pr_info("%pOF: no %s translation for id 0x%x on %pOF\n", np, map_name,
+		id, target && *target ? *target : NULL);
 
 	/* Bypasses translation */
 	if (id_out)
-		*id_out = rid;
+		*id_out = id;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(of_map_rid);
+EXPORT_SYMBOL_GPL(of_map_id);
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index a296eaf52a5b2..d632bc5b3a2de 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -587,7 +587,7 @@ static u32 __of_msi_map_rid(struct device *dev, struct device_node **np,
 	 * "msi-map" property.
 	 */
 	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent)
-		if (!of_map_rid(parent_dev->of_node, rid_in, "msi-map",
+		if (!of_map_id(parent_dev->of_node, rid_in, "msi-map",
 				"msi-map-mask", np, &rid_out))
 			break;
 	return rid_out;
diff --git a/include/linux/of.h b/include/linux/of.h
index e29b341598e99..e070c5ed62a09 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -554,7 +554,7 @@ bool of_console_check(struct device_node *dn, char *name, int index);
 
 extern int of_cpu_node_to_id(struct device_node *np);
 
-int of_map_rid(struct device_node *np, u32 rid,
+int of_map_id(struct device_node *np, u32 id,
 	       const char *map_name, const char *map_mask_name,
 	       struct device_node **target, u32 *id_out);
 
@@ -978,7 +978,7 @@ static inline int of_cpu_node_to_id(struct device_node *np)
 	return -ENODEV;
 }
 
-static inline int of_map_rid(struct device_node *np, u32 rid,
+static inline int of_map_id(struct device_node *np, u32 id,
 			     const char *map_name, const char *map_mask_name,
 			     struct device_node **target, u32 *id_out)
 {
-- 
2.42.0




