Return-Path: <stable+bounces-188214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2660DBF2BCC
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 19:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C0EC4F99A9
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B39B3321BD;
	Mon, 20 Oct 2025 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pP7XuQww"
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FC2331A6E
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981824; cv=none; b=SekVgyu5cAPEKKJn1/5up0wF63VAJtwbYsys8feXUWzFxJQ9Cyrg+7u8AUydqyA4aXsVh44c6/UVPN4BfXohUVfeSfPUK0TKn2Zep+t3fBPVsW/KGOTQeSr203X+Cunx3PAjinljVmFfctnLmyZbVHp7Z1wZWkjy+QArb1vLrUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981824; c=relaxed/simple;
	bh=Tdkb6slTtWmYZtiQa1tIK6dRUEk475Bv1lqXHv64uNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GQNphFcC9fXyAvVTSi+Ds56tbiFRlqY82g6uydqoMNGTREYKR43E8ndkFXOBkzWt/fIHdaodOc2Pu186Nuxuw0vlTTN//Q4syGT/z36Db6MEy7oW99pgiZ74OmEpyHhgdMQpvcSfuwEsSohXyda0jqg00q1YOHzFOvzmKaNHMOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pP7XuQww; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760981819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3HwimWFndZuSJnwb+BgdzNzt73JwPHkgy7Obtgsnz3E=;
	b=pP7XuQww7Rp4pgeeP+f1Y+HegYuOyc3bnepsuGNQwhdJSbFag5MXsAUbh14pc6Pum50+30
	VwtuK582R9Pb7A4bK2+KJnDbp1jfreuKrg8/afwYyWayb18DGQ+ORl7Mmy741wuBi9k+Sp
	rVtv/2HjKdlx8R5QH+met0reVzcI9Tc=
From: Wen Yang <wen.yang@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jon Hunter <jonathanh@nvidia.com>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <pierre.gondois@arm.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 6.1 01/10] cacheinfo: Use RISC-V's init_cache_level() as generic OF implementation
Date: Tue, 21 Oct 2025 01:36:15 +0800
Message-Id: <20251020173624.20228-2-wen.yang@linux.dev>
In-Reply-To: <20251020173624.20228-1-wen.yang@linux.dev>
References: <20251020173624.20228-1-wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Pierre Gondois <pierre.gondois@arm.com>

[ Upstream commit c3719bd9eeb2edf84bd263d662e36ca0ba262a23 ]

RISC-V's implementation of init_of_cache_level() is following
the Devicetree Specification v0.3 regarding caches, cf.:
- s3.7.3 'Internal (L1) Cache Properties'
- s3.8 'Multi-level and Shared Cache Nodes'

Allow reusing the implementation by moving it.

Also make 'levels', 'leaves' and 'level' unsigned int.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Link: https://lore.kernel.org/r/20230104183033.755668-2-pierre.gondois@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 arch/riscv/kernel/cacheinfo.c | 39 +------------------------------
 drivers/base/cacheinfo.c      | 44 +++++++++++++++++++++++++++++++++++
 include/linux/cacheinfo.h     |  1 +
 3 files changed, 46 insertions(+), 38 deletions(-)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 90deabfe63ea..440a3df5944c 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -115,44 +115,7 @@ static void fill_cacheinfo(struct cacheinfo **this_leaf,
 
 int init_cache_level(unsigned int cpu)
 {
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-	struct device_node *np = of_cpu_device_node_get(cpu);
-	struct device_node *prev = NULL;
-	int levels = 0, leaves = 0, level;
-
-	if (of_property_read_bool(np, "cache-size"))
-		++leaves;
-	if (of_property_read_bool(np, "i-cache-size"))
-		++leaves;
-	if (of_property_read_bool(np, "d-cache-size"))
-		++leaves;
-	if (leaves > 0)
-		levels = 1;
-
-	prev = np;
-	while ((np = of_find_next_cache_node(np))) {
-		of_node_put(prev);
-		prev = np;
-		if (!of_device_is_compatible(np, "cache"))
-			break;
-		if (of_property_read_u32(np, "cache-level", &level))
-			break;
-		if (level <= levels)
-			break;
-		if (of_property_read_bool(np, "cache-size"))
-			++leaves;
-		if (of_property_read_bool(np, "i-cache-size"))
-			++leaves;
-		if (of_property_read_bool(np, "d-cache-size"))
-			++leaves;
-		levels = level;
-	}
-
-	of_node_put(np);
-	this_cpu_ci->num_levels = levels;
-	this_cpu_ci->num_leaves = leaves;
-
-	return 0;
+	return init_of_cache_level(cpu);
 }
 
 int populate_cache_leaves(unsigned int cpu)
diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 26e13887aba4..7663eaddd168 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -223,8 +223,52 @@ static int cache_setup_of_node(unsigned int cpu)
 
 	return 0;
 }
+
+int init_of_cache_level(unsigned int cpu)
+{
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	struct device_node *np = of_cpu_device_node_get(cpu);
+	struct device_node *prev = NULL;
+	unsigned int levels = 0, leaves = 0, level;
+
+	if (of_property_read_bool(np, "cache-size"))
+		++leaves;
+	if (of_property_read_bool(np, "i-cache-size"))
+		++leaves;
+	if (of_property_read_bool(np, "d-cache-size"))
+		++leaves;
+	if (leaves > 0)
+		levels = 1;
+
+	prev = np;
+	while ((np = of_find_next_cache_node(np))) {
+		of_node_put(prev);
+		prev = np;
+		if (!of_device_is_compatible(np, "cache"))
+			break;
+		if (of_property_read_u32(np, "cache-level", &level))
+			break;
+		if (level <= levels)
+			break;
+		if (of_property_read_bool(np, "cache-size"))
+			++leaves;
+		if (of_property_read_bool(np, "i-cache-size"))
+			++leaves;
+		if (of_property_read_bool(np, "d-cache-size"))
+			++leaves;
+		levels = level;
+	}
+
+	of_node_put(np);
+	this_cpu_ci->num_levels = levels;
+	this_cpu_ci->num_leaves = leaves;
+
+	return 0;
+}
+
 #else
 static inline int cache_setup_of_node(unsigned int cpu) { return 0; }
+int init_of_cache_level(unsigned int cpu) { return 0; }
 #endif
 
 int __weak cache_setup_acpi(unsigned int cpu)
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 00b7a6ae8617..ff0328f3fbb0 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -80,6 +80,7 @@ struct cpu_cacheinfo {
 
 struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
 int init_cache_level(unsigned int cpu);
+int init_of_cache_level(unsigned int cpu);
 int populate_cache_leaves(unsigned int cpu);
 int cache_setup_acpi(unsigned int cpu);
 bool last_level_cache_is_valid(unsigned int cpu);
-- 
2.25.1


