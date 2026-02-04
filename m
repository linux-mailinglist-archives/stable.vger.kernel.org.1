Return-Path: <stable+bounces-214243-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCbvM0dvg2lqmwMAu9opvQ
	(envelope-from <stable+bounces-214243-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:09:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAB3E9F1D
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65053308AAE6
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F89B28853E;
	Wed,  4 Feb 2026 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QcjipWgt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51CA1C5D57;
	Wed,  4 Feb 2026 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219041; cv=none; b=IVADMyBz7sSLn/HL6y3uqv0FnwRrm3j2VmfVzR/RQJWptS/We5UbOpqm6XALdhFF7kDV9EUXYCInNbY27Gm6Wu4vLVxGzbe4wwVpFrnfUHx37A378vF1oCvC73Ii5OHoOpKMlj3WF8Jc716jzlsDh9DnQkVAi+wXNgcwg4buG5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219041; c=relaxed/simple;
	bh=NFsW97xm08R33e7ILfOyWa2uDch/OAa27jpNnFoJAcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oU4zhrY2mh9P9p+mz98DdZIYSy+sWxqwgkDsWsKQSaHJfdYfCWhVHkV+7OH0EW+gK1Fypwmc0PQOKR1IhO//DCmpMUafq9C5DpNWMLaGfTRySoQM92N5X8DZE0QvYvRIseTUdAHNowK9jqu0NOtER0O7Oark1aZjplxBm19GVtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QcjipWgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50185C4CEF7;
	Wed,  4 Feb 2026 15:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770219040;
	bh=NFsW97xm08R33e7ILfOyWa2uDch/OAa27jpNnFoJAcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QcjipWgtLhIvzqtstuwqfUR3VHxkTTkInm7hYlU0Iq+R46xGNo/pg8U3oj1fPpqLL
	 /Y71JIJd1LEJ65nLQtY6SCMCZjQ0DKN1IiHgEsGpFFwKnuG0ykiaJg3tHTITgTI8hW
	 Ccx6NQF9jhOFs06R1ghxBGKNNXW/QJpaG2vwF/yQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>,
	Joy Zou <joy.zou@nxp.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 049/122] of: reserved_mem: Allow reserved_mem framework detect "cma=" kernel param
Date: Wed,  4 Feb 2026 15:40:31 +0100
Message-ID: <20260204143853.621663286@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214243-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,qualcomm.com:email]
X-Rspamd-Queue-Id: EFAB3E9F1D
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>

[ Upstream commit 0fd17e5983337231dc655e9ca0095d2ca3f47405 ]

When initializing the default cma region, the "cma=" kernel parameter
takes priority over a DT defined linux,cma-default region. Hence, give
the reserved_mem framework the ability to detect this so that the DT
defined cma region can skip initialization accordingly.

Signed-off-by: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
Tested-by: Joy Zou <joy.zou@nxp.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved memory regions are processed")
Fixes: 2c223f7239f3 ("of: reserved_mem: Restructure call site for dma_contiguous_early_fixup()")
Link: https://lore.kernel.org/r/20251210002027.1171519-1-oreoluwa.babatunde@oss.qualcomm.com
[mszyprow: rebased onto v6.19-rc1, added fixes tags, added a stub for
 cma_skip_dt_default_reserved_mem() if no CONFIG_DMA_CMA is set]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/of_reserved_mem.c | 19 +++++++++++++++++--
 include/linux/cma.h          |  9 +++++++++
 kernel/dma/contiguous.c      | 16 ++++++++++------
 3 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index e5ea4f1e5eff7..fe111d1ea7397 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -158,7 +158,7 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 	phys_addr_t base, size;
 	int len;
 	const __be32 *prop;
-	bool nomap;
+	bool nomap, default_cma;
 
 	prop = of_get_flat_dt_prop(node, "reg", &len);
 	if (!prop)
@@ -171,6 +171,12 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 	}
 
 	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
+	default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
+
+	if (default_cma && cma_skip_dt_default_reserved_mem()) {
+		pr_err("Skipping dt linux,cma-default for \"cma=\" kernel param.\n");
+		return -EINVAL;
+	}
 
 	while (len >= t_len) {
 		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
@@ -253,10 +259,13 @@ void __init fdt_scan_reserved_mem_reg_nodes(void)
 
 	fdt_for_each_subnode(child, fdt, node) {
 		const char *uname;
+		bool default_cma = of_get_flat_dt_prop(child, "linux,cma-default", NULL);
 		u64 b, s;
 
 		if (!of_fdt_device_is_available(fdt, child))
 			continue;
+		if (default_cma && cma_skip_dt_default_reserved_mem())
+			continue;
 
 		if (!of_flat_dt_get_addr_size(child, "reg", &b, &s))
 			continue;
@@ -395,7 +404,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 	phys_addr_t base = 0, align = 0, size;
 	int len;
 	const __be32 *prop;
-	bool nomap;
+	bool nomap, default_cma;
 	int ret;
 
 	prop = of_get_flat_dt_prop(node, "size", &len);
@@ -419,6 +428,12 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 	}
 
 	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
+	default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
+
+	if (default_cma && cma_skip_dt_default_reserved_mem()) {
+		pr_err("Skipping dt linux,cma-default for \"cma=\" kernel param.\n");
+		return -EINVAL;
+	}
 
 	/* Need adjust the alignment to satisfy the CMA requirement */
 	if (IS_ENABLED(CONFIG_CMA)
diff --git a/include/linux/cma.h b/include/linux/cma.h
index 62d9c1cf63265..2e6931735880b 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -57,6 +57,15 @@ extern bool cma_intersects(struct cma *cma, unsigned long start, unsigned long e
 
 extern void cma_reserve_pages_on_error(struct cma *cma);
 
+#ifdef CONFIG_DMA_CMA
+extern bool cma_skip_dt_default_reserved_mem(void);
+#else
+static inline bool cma_skip_dt_default_reserved_mem(void)
+{
+	return false;
+}
+#endif
+
 #ifdef CONFIG_CMA
 struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp);
 bool cma_free_folio(struct cma *cma, const struct folio *folio);
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index d9b9dcba6ff7c..9071c08650e3a 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -90,6 +90,16 @@ static int __init early_cma(char *p)
 }
 early_param("cma", early_cma);
 
+/*
+ * cma_skip_dt_default_reserved_mem - This is called from the
+ * reserved_mem framework to detect if the default cma region is being
+ * set by the "cma=" kernel parameter.
+ */
+bool __init cma_skip_dt_default_reserved_mem(void)
+{
+	return size_cmdline != -1;
+}
+
 #ifdef CONFIG_DMA_NUMA_CMA
 
 static struct cma *dma_contiguous_numa_area[MAX_NUMNODES];
@@ -463,12 +473,6 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 	struct cma *cma;
 	int err;
 
-	if (size_cmdline != -1 && default_cma) {
-		pr_info("Reserved memory: bypass %s node, using cmdline CMA params instead\n",
-			rmem->name);
-		return -EBUSY;
-	}
-
 	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
 	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
-- 
2.51.0




