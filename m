Return-Path: <stable+bounces-52457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171AB90B001
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 15:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F21D1C21957
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 13:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237F51CB32F;
	Mon, 17 Jun 2024 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVh9Wvbc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EFC1CB327;
	Mon, 17 Jun 2024 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630652; cv=none; b=lL4mbjwGVH+lXqjN1go1Lr/IZZF9BDpO4KKJtvn65ACyyfRnxpyJHhFKWWFkDveYOMHtDQtsvfO1YEQ82PLoXsZ3sdYkQY1Kpuri9bf+oE4BrbrOnQbMJApKIMhxfRobKDqjadBOMo7WmmS+tHdNB9rxIASWrDUnzxAreuWgErY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630652; c=relaxed/simple;
	bh=nviM6bhDNEd4yNfGYvf45ThFRNd+LR9OFqQiivpetJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkohXMEXj2BFf86jB52eBpxcmf3MGuYVFH0FaBHZjCBcZxg6G1GA3hxgyipVGJGfOwse77NWDAc9hI3xjy6dVFePhdLzvnHT7Srho6gcCLpZOVvgN+25PFL2V0S4w3vDK9JRsKNBxNzTXWAlsZGD2JAcdiGJjw8mW7ZzYnLz0kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVh9Wvbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BE5C2BD10;
	Mon, 17 Jun 2024 13:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630652;
	bh=nviM6bhDNEd4yNfGYvf45ThFRNd+LR9OFqQiivpetJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FVh9Wvbcg2itz4vhLVF5nsdJX+lnTZlq6hdEEHfqgTE/jJWqIkNoGg8jnYlqrKGNI
	 rjMf0PmwYzweLQSMsH4G9wY42Ncm7/dXhaGFIrXbSj/2V/JiLXNOmIC+UbC2nmnTcj
	 AJcPKUDkjl4yNew1D0Cj3v8EBmrlYPu69i1DPgLEgoqTPMGiH0sarnsclCkuDb2EwH
	 RhMa7l2Gvkr218UQaaI1Bw+6Q3l4rnZx4Z7XsRYcKQHHcGSXfpRh7Bi8nfsX1jGzyH
	 ckL0EbrKXPUxGKJxFgRNB+q/2vYdqIMPbN/RFi0yTtPdGVyl7kJwhNhN9rlI/ikNz6
	 FGo5De1ZLzGlw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Anup Patel <apatel@ventanamicro.com>,
	Sasha Levin <sashal@kernel.org>,
	saravanak@google.com,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 25/35] of/irq: Factor out parsing of interrupt-map parent phandle+args from of_irq_parse_raw()
Date: Mon, 17 Jun 2024 09:22:23 -0400
Message-ID: <20240617132309.2588101-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132309.2588101-1-sashal@kernel.org>
References: <20240617132309.2588101-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.34
Content-Transfer-Encoding: 8bit

From: "Rob Herring (Arm)" <robh@kernel.org>

[ Upstream commit 935df1bd40d43c4ee91838c42a20e9af751885cc ]

Factor out the parsing of interrupt-map interrupt parent phandle and its
arg cells to a separate function, of_irq_parse_imap_parent(), so that it
can be used in other parsing scenarios (e.g. fw_devlink).

There was a refcount leak on non-matching entries when iterating thru
"interrupt-map" which is fixed.

Tested-by: Marc Zyngier <maz@kernel.org>
Tested-by: Anup Patel <apatel@ventanamicro.com>
Link: https://lore.kernel.org/r/20240529-dt-interrupt-map-fix-v2-1-ef86dc5bcd2a@kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/irq.c        | 125 ++++++++++++++++++++++++----------------
 drivers/of/of_private.h |   3 +
 2 files changed, 77 insertions(+), 51 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 174900072c18c..462375b293e47 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -25,6 +25,8 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 
+#include "of_private.h"
+
 /**
  * irq_of_parse_and_map - Parse and map an interrupt into linux virq space
  * @dev: Device node of the device whose interrupt is to be mapped
@@ -96,6 +98,57 @@ static const char * const of_irq_imap_abusers[] = {
 	NULL,
 };
 
+const __be32 *of_irq_parse_imap_parent(const __be32 *imap, int len, struct of_phandle_args *out_irq)
+{
+	u32 intsize, addrsize;
+	struct device_node *np;
+
+	/* Get the interrupt parent */
+	if (of_irq_workarounds & OF_IMAP_NO_PHANDLE)
+		np = of_node_get(of_irq_dflt_pic);
+	else
+		np = of_find_node_by_phandle(be32_to_cpup(imap));
+	imap++;
+
+	/* Check if not found */
+	if (!np) {
+		pr_debug(" -> imap parent not found !\n");
+		return NULL;
+	}
+
+	/* Get #interrupt-cells and #address-cells of new parent */
+	if (of_property_read_u32(np, "#interrupt-cells",
+					&intsize)) {
+		pr_debug(" -> parent lacks #interrupt-cells!\n");
+		of_node_put(np);
+		return NULL;
+	}
+	if (of_property_read_u32(np, "#address-cells",
+					&addrsize))
+		addrsize = 0;
+
+	pr_debug(" -> intsize=%d, addrsize=%d\n",
+		intsize, addrsize);
+
+	/* Check for malformed properties */
+	if (WARN_ON(addrsize + intsize > MAX_PHANDLE_ARGS)
+		|| (len < (addrsize + intsize))) {
+		of_node_put(np);
+		return NULL;
+	}
+
+	pr_debug(" -> imaplen=%d\n", len);
+
+	imap += addrsize + intsize;
+
+	out_irq->np = np;
+	for (int i = 0; i < intsize; i++)
+		out_irq->args[i] = be32_to_cpup(imap - intsize + i);
+	out_irq->args_count = intsize;
+
+	return imap;
+}
+
 /**
  * of_irq_parse_raw - Low level interrupt tree parsing
  * @addr:	address specifier (start of "reg" property of the device) in be32 format
@@ -112,12 +165,12 @@ static const char * const of_irq_imap_abusers[] = {
  */
 int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 {
-	struct device_node *ipar, *tnode, *old = NULL, *newpar = NULL;
+	struct device_node *ipar, *tnode, *old = NULL;
 	__be32 initial_match_array[MAX_PHANDLE_ARGS];
 	const __be32 *match_array = initial_match_array;
-	const __be32 *tmp, *imap, *imask, dummy_imask[] = { [0 ... MAX_PHANDLE_ARGS] = cpu_to_be32(~0) };
-	u32 intsize = 1, addrsize, newintsize = 0, newaddrsize = 0;
-	int imaplen, match, i, rc = -EINVAL;
+	const __be32 *tmp, dummy_imask[] = { [0 ... MAX_PHANDLE_ARGS] = cpu_to_be32(~0) };
+	u32 intsize = 1, addrsize;
+	int i, rc = -EINVAL;
 
 #ifdef DEBUG
 	of_print_phandle_args("of_irq_parse_raw: ", out_irq);
@@ -176,6 +229,9 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 
 	/* Now start the actual "proper" walk of the interrupt tree */
 	while (ipar != NULL) {
+		int imaplen, match;
+		const __be32 *imap, *oldimap, *imask;
+		struct device_node *newpar;
 		/*
 		 * Now check if cursor is an interrupt-controller and
 		 * if it is then we are done, unless there is an
@@ -216,7 +272,7 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 
 		/* Parse interrupt-map */
 		match = 0;
-		while (imaplen > (addrsize + intsize + 1) && !match) {
+		while (imaplen > (addrsize + intsize + 1)) {
 			/* Compare specifiers */
 			match = 1;
 			for (i = 0; i < (addrsize + intsize); i++, imaplen--)
@@ -224,48 +280,17 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 
 			pr_debug(" -> match=%d (imaplen=%d)\n", match, imaplen);
 
-			/* Get the interrupt parent */
-			if (of_irq_workarounds & OF_IMAP_NO_PHANDLE)
-				newpar = of_node_get(of_irq_dflt_pic);
-			else
-				newpar = of_find_node_by_phandle(be32_to_cpup(imap));
-			imap++;
-			--imaplen;
-
-			/* Check if not found */
-			if (newpar == NULL) {
-				pr_debug(" -> imap parent not found !\n");
-				goto fail;
-			}
-
-			if (!of_device_is_available(newpar))
-				match = 0;
-
-			/* Get #interrupt-cells and #address-cells of new
-			 * parent
-			 */
-			if (of_property_read_u32(newpar, "#interrupt-cells",
-						 &newintsize)) {
-				pr_debug(" -> parent lacks #interrupt-cells!\n");
-				goto fail;
-			}
-			if (of_property_read_u32(newpar, "#address-cells",
-						 &newaddrsize))
-				newaddrsize = 0;
-
-			pr_debug(" -> newintsize=%d, newaddrsize=%d\n",
-			    newintsize, newaddrsize);
-
-			/* Check for malformed properties */
-			if (WARN_ON(newaddrsize + newintsize > MAX_PHANDLE_ARGS)
-			    || (imaplen < (newaddrsize + newintsize))) {
-				rc = -EFAULT;
+			oldimap = imap;
+			imap = of_irq_parse_imap_parent(oldimap, imaplen, out_irq);
+			if (!imap)
 				goto fail;
-			}
 
-			imap += newaddrsize + newintsize;
-			imaplen -= newaddrsize + newintsize;
+			match &= of_device_is_available(out_irq->np);
+			if (match)
+				break;
 
+			of_node_put(out_irq->np);
+			imaplen -= imap - oldimap;
 			pr_debug(" -> imaplen=%d\n", imaplen);
 		}
 		if (!match) {
@@ -287,11 +312,11 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 		 * Successfully parsed an interrupt-map translation; copy new
 		 * interrupt specifier into the out_irq structure
 		 */
-		match_array = imap - newaddrsize - newintsize;
-		for (i = 0; i < newintsize; i++)
-			out_irq->args[i] = be32_to_cpup(imap - newintsize + i);
-		out_irq->args_count = intsize = newintsize;
-		addrsize = newaddrsize;
+		match_array = oldimap + 1;
+
+		newpar = out_irq->np;
+		intsize = out_irq->args_count;
+		addrsize = (imap - match_array) - intsize;
 
 		if (ipar == newpar) {
 			pr_debug("%pOF interrupt-map entry to self\n", ipar);
@@ -300,7 +325,6 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 
 	skiplevel:
 		/* Iterate again with new parent */
-		out_irq->np = newpar;
 		pr_debug(" -> new parent: %pOF\n", newpar);
 		of_node_put(ipar);
 		ipar = newpar;
@@ -310,7 +334,6 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 
  fail:
 	of_node_put(ipar);
-	of_node_put(newpar);
 
 	return rc;
 }
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index f38397c7b5824..21f8f5e80917d 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -158,6 +158,9 @@ extern void __of_sysfs_remove_bin_file(struct device_node *np,
 extern int of_bus_n_addr_cells(struct device_node *np);
 extern int of_bus_n_size_cells(struct device_node *np);
 
+const __be32 *of_irq_parse_imap_parent(const __be32 *imap, int len,
+				       struct of_phandle_args *out_irq);
+
 struct bus_dma_region;
 #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_HAS_DMA)
 int of_dma_get_range(struct device_node *np,
-- 
2.43.0


