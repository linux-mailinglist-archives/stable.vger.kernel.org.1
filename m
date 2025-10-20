Return-Path: <stable+bounces-188218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD47EBF2C05
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 19:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCD5465F04
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABEB3321D8;
	Mon, 20 Oct 2025 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iSUkgQ84"
X-Original-To: stable@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D598A2561AE
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981855; cv=none; b=r2qv0l7CV3UCkFC7bDSYROu111MTwposZod8hfs6UufBG4nBZef+f+oSWz49Hb2n3jVjdls9k+Iyl84h0IFTWPVdlu+wrm6Jrwk7fZujmnWW0yHMW0omaB20b2AUdent3DQv5xvYcmBkPp1gA+f5EI7vXKEfBdXdwkISf1SZ9xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981855; c=relaxed/simple;
	bh=LZ24XCdv7P4y0+8TfEYg34q02tAaNgo/N1Rn5ypGnHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ho7n3h6yYzG42R+cx7I2q7+6deDo37kidDfqzsKFhKK/ujBCy2CIEX/FKapxO+4zZha1MfOOrPkbZXkLMzalCcOCjofT/En1mcIYpgB/JKwz4MxR0TrCgzZ/Z49wEdc5EL5/FiG05T4sWyEUBn+MTHUl7XiubdVz8wgCqyeXOEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iSUkgQ84; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760981848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2BnGY7IyGg6PIgbBeqRuOWud75fqziwSVTBMrV8aDaA=;
	b=iSUkgQ84KfdBf98nY6QgLIayd3KP9S4LDZ+SSpi75zkLZDVsNZMmBbfsFt4BfF8sKjjDiN
	8H5o5y2jKJVnmQYwEpgYXGqSJq7SDKCmDIOlXmVGuple2EM8HsAI16ShXxAAOgy74qSYsy
	YPfKmX+waRNxVNhBnXoZGO7XdpXO0w0=
From: Wen Yang <wen.yang@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jon Hunter <jonathanh@nvidia.com>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <pierre.gondois@arm.com>,
	Jeremy Linton <jeremy.linton@arm.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 6.1 05/10] ACPI: PPTT: Update acpi_find_last_cache_level() to acpi_get_cache_info()
Date: Tue, 21 Oct 2025 01:36:19 +0800
Message-Id: <20251020173624.20228-6-wen.yang@linux.dev>
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

[ Upstream commit bd500361a937c03a3da57178287ce543c8f3681b ]

acpi_find_last_cache_level() allows to find the last level of cache
for a given CPU. The function is only called on arm64 ACPI based
platforms to check for cache information that would be missing in
the CLIDR_EL1 register.
To allow populating (struct cpu_cacheinfo).num_leaves by only parsing
a PPTT, update acpi_find_last_cache_level() to get the 'split_levels',
i.e. the number of cache levels being split in data/instruction
caches.

It is assumed that there will not be data/instruction caches above a
unified cache.
If a split level consist of one data cache and no instruction cache
(or opposite), then the missing cache will still be populated
by default with minimal cache information, and maximal cpumask
(all non-existing caches have the same fw_token).

Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
Acked-by: Rafael J. Wysocki  <rafael.j.wysocki@intel.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Link: https://lore.kernel.org/r/20230104183033.755668-6-pierre.gondois@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 arch/arm64/kernel/cacheinfo.c | 11 +++--
 drivers/acpi/pptt.c           | 76 +++++++++++++++++++++++------------
 include/linux/cacheinfo.h     |  9 +++--
 3 files changed, 63 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
index 1510f457b615..a565e8dc9c15 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -46,7 +46,7 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 int init_cache_level(unsigned int cpu)
 {
 	unsigned int ctype, level, leaves;
-	int fw_level;
+	int fw_level, ret;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 
 	for (level = 1, leaves = 0; level <= MAX_CACHE_LEVEL; level++) {
@@ -59,10 +59,13 @@ int init_cache_level(unsigned int cpu)
 		leaves += (ctype == CACHE_TYPE_SEPARATE) ? 2 : 1;
 	}
 
-	if (acpi_disabled)
+	if (acpi_disabled) {
 		fw_level = of_find_last_cache_level(cpu);
-	else
-		fw_level = acpi_find_last_cache_level(cpu);
+	} else {
+		ret = acpi_get_cache_info(cpu, &fw_level, NULL);
+		if (ret < 0)
+			return ret;
+	}
 
 	if (fw_level < 0)
 		return fw_level;
diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 01aae0f203b0..54676e3d82dd 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -81,6 +81,7 @@ static inline bool acpi_pptt_match_type(int table_type, int type)
  * acpi_pptt_walk_cache() - Attempt to find the requested acpi_pptt_cache
  * @table_hdr: Pointer to the head of the PPTT table
  * @local_level: passed res reflects this cache level
+ * @split_levels: Number of split cache levels (data/instruction).
  * @res: cache resource in the PPTT we want to walk
  * @found: returns a pointer to the requested level if found
  * @level: the requested cache level
@@ -100,6 +101,7 @@ static inline bool acpi_pptt_match_type(int table_type, int type)
  */
 static unsigned int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
 					 unsigned int local_level,
+					 unsigned int *split_levels,
 					 struct acpi_subtable_header *res,
 					 struct acpi_pptt_cache **found,
 					 unsigned int level, int type)
@@ -113,8 +115,17 @@ static unsigned int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
 	while (cache) {
 		local_level++;
 
+		if (!(cache->flags & ACPI_PPTT_CACHE_TYPE_VALID)) {
+			cache = fetch_pptt_cache(table_hdr, cache->next_level_of_cache);
+			continue;
+		}
+
+		if (split_levels &&
+		    (acpi_pptt_match_type(cache->attributes, ACPI_PPTT_CACHE_TYPE_DATA) ||
+		     acpi_pptt_match_type(cache->attributes, ACPI_PPTT_CACHE_TYPE_INSTR)))
+			*split_levels = local_level;
+
 		if (local_level == level &&
-		    cache->flags & ACPI_PPTT_CACHE_TYPE_VALID &&
 		    acpi_pptt_match_type(cache->attributes, type)) {
 			if (*found != NULL && cache != *found)
 				pr_warn("Found duplicate cache level/type unable to determine uniqueness\n");
@@ -135,8 +146,8 @@ static unsigned int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
 static struct acpi_pptt_cache *
 acpi_find_cache_level(struct acpi_table_header *table_hdr,
 		      struct acpi_pptt_processor *cpu_node,
-		      unsigned int *starting_level, unsigned int level,
-		      int type)
+		      unsigned int *starting_level, unsigned int *split_levels,
+		      unsigned int level, int type)
 {
 	struct acpi_subtable_header *res;
 	unsigned int number_of_levels = *starting_level;
@@ -149,7 +160,8 @@ acpi_find_cache_level(struct acpi_table_header *table_hdr,
 		resource++;
 
 		local_level = acpi_pptt_walk_cache(table_hdr, *starting_level,
-						   res, &ret, level, type);
+						   split_levels, res, &ret,
+						   level, type);
 		/*
 		 * we are looking for the max depth. Since its potentially
 		 * possible for a given node to have resources with differing
@@ -165,29 +177,29 @@ acpi_find_cache_level(struct acpi_table_header *table_hdr,
 }
 
 /**
- * acpi_count_levels() - Given a PPTT table, and a CPU node, count the caches
+ * acpi_count_levels() - Given a PPTT table, and a CPU node, count the cache
+ * levels and split cache levels (data/instruction).
  * @table_hdr: Pointer to the head of the PPTT table
  * @cpu_node: processor node we wish to count caches for
+ * @levels: Number of levels if success.
+ * @split_levels:	Number of split cache levels (data/instruction) if
+ *			success. Can by NULL.
  *
  * Given a processor node containing a processing unit, walk into it and count
  * how many levels exist solely for it, and then walk up each level until we hit
  * the root node (ignore the package level because it may be possible to have
- * caches that exist across packages). Count the number of cache levels that
- * exist at each level on the way up.
- *
- * Return: Total number of levels found.
+ * caches that exist across packages). Count the number of cache levels and
+ * split cache levels (data/instruction) that exist at each level on the way
+ * up.
  */
-static int acpi_count_levels(struct acpi_table_header *table_hdr,
-			     struct acpi_pptt_processor *cpu_node)
+static void acpi_count_levels(struct acpi_table_header *table_hdr,
+			      struct acpi_pptt_processor *cpu_node,
+			      unsigned int *levels, unsigned int *split_levels)
 {
-	int total_levels = 0;
-
 	do {
-		acpi_find_cache_level(table_hdr, cpu_node, &total_levels, 0, 0);
+		acpi_find_cache_level(table_hdr, cpu_node, levels, split_levels, 0, 0);
 		cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
 	} while (cpu_node);
-
-	return total_levels;
 }
 
 /**
@@ -326,7 +338,7 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
 
 	while (cpu_node && !found) {
 		found = acpi_find_cache_level(table_hdr, cpu_node,
-					      &total_levels, level, acpi_type);
+					      &total_levels, NULL, level, acpi_type);
 		*node = cpu_node;
 		cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
 	}
@@ -597,36 +609,48 @@ static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)
 }
 
 /**
- * acpi_find_last_cache_level() - Determines the number of cache levels for a PE
+ * acpi_get_cache_info() - Determine the number of cache levels and
+ * split cache levels (data/instruction) and for a PE.
  * @cpu: Kernel logical CPU number
+ * @levels: Number of levels if success.
+ * @split_levels:	Number of levels being split (i.e. data/instruction)
+ *			if success. Can by NULL.
  *
  * Given a logical CPU number, returns the number of levels of cache represented
  * in the PPTT. Errors caused by lack of a PPTT table, or otherwise, return 0
  * indicating we didn't find any cache levels.
  *
- * Return: Cache levels visible to this core.
+ * Return: -ENOENT if no PPTT table or no PPTT processor struct found.
+ *	   0 on success.
  */
-int acpi_find_last_cache_level(unsigned int cpu)
+int acpi_get_cache_info(unsigned int cpu, unsigned int *levels,
+			unsigned int *split_levels)
 {
 	struct acpi_pptt_processor *cpu_node;
 	struct acpi_table_header *table;
-	int number_of_levels = 0;
 	u32 acpi_cpu_id;
 
+	*levels = 0;
+	if (split_levels)
+		*split_levels = 0;
+
 	table = acpi_get_pptt();
 	if (!table)
 		return -ENOENT;
 
-	pr_debug("Cache Setup find last level CPU=%d\n", cpu);
+	pr_debug("Cache Setup: find cache levels for CPU=%d\n", cpu);
 
 	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
 	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
-	if (cpu_node)
-		number_of_levels = acpi_count_levels(table, cpu_node);
+	if (!cpu_node)
+		return -ENOENT;
 
-	pr_debug("Cache Setup find last level level=%d\n", number_of_levels);
+	acpi_count_levels(table, cpu_node, levels, split_levels);
 
-	return number_of_levels;
+	pr_debug("Cache Setup: last_level=%d split_levels=%d\n",
+		 *levels, split_levels ? *split_levels : -1);
+
+	return 0;
 }
 
 /**
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index ff0328f3fbb0..00d8e7f9d1c6 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -88,19 +88,22 @@ bool last_level_cache_is_shared(unsigned int cpu_x, unsigned int cpu_y);
 int detect_cache_attributes(unsigned int cpu);
 #ifndef CONFIG_ACPI_PPTT
 /*
- * acpi_find_last_cache_level is only called on ACPI enabled
+ * acpi_get_cache_info() is only called on ACPI enabled
  * platforms using the PPTT for topology. This means that if
  * the platform supports other firmware configuration methods
  * we need to stub out the call when ACPI is disabled.
  * ACPI enabled platforms not using PPTT won't be making calls
  * to this function so we need not worry about them.
  */
-static inline int acpi_find_last_cache_level(unsigned int cpu)
+static inline
+int acpi_get_cache_info(unsigned int cpu,
+			unsigned int *levels, unsigned int *split_levels)
 {
 	return 0;
 }
 #else
-int acpi_find_last_cache_level(unsigned int cpu);
+int acpi_get_cache_info(unsigned int cpu,
+			unsigned int *levels, unsigned int *split_levels);
 #endif
 
 const struct attribute_group *cache_get_priv_group(struct cacheinfo *this_leaf);
-- 
2.25.1


