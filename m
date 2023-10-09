Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208997BE1AF
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377424AbjJINw6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377484AbjJINw4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:52:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714D6B9
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:52:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCCEC433C7;
        Mon,  9 Oct 2023 13:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859573;
        bh=ZVxJpCRkHy/FzuRpcTeFze+NOa1cFKxq2ual7u3fAUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XMH13Tk0dZtD8J/J623BYC0uZFVVTJLcyJ3BjHGgXQKiXRJ98TL+lHAzL2AiuEps4
         nI/0Cmu9AP14sbgE1Vae/7JhSg9My0zczRwdAkbU9QMigVpcX/2MtIZ7bNNn9I0cj+
         XuRwNcZ0Co7OE5cEIW5oV2jjnLyWfVL1XrOWPBYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ben Hutchings <ben@decadent.org.uk>,
        Joe Perches <joe@perches.com>,
        Brennan Lamoreaux <blamoreaux@vmware.com>
Subject: [PATCH 4.19 63/91] Revert "drivers core: Use sysfs_emit and sysfs_emit_at for show(device *...) functions"
Date:   Mon,  9 Oct 2023 15:06:35 +0200
Message-ID: <20231009130113.684903434@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.518916887@linuxfoundation.org>
References: <20231009130111.518916887@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 3ce2cd63e8ee037644db0cbea65e6c40ab6cc178 which is
commit aa838896d87af561a33ecefea1caa4c15a68bc47 upstream.

Ben writes:
	When I looked into the referenced security issue, it seemed to only be
	exploitable through wakelock names, and in the upstream kernel only
	after commit c8377adfa781 "PM / wakeup: Show wakeup sources stats in
	sysfs" (first included in 5.4).  So I would be interested to know if
	and why a fix was needed for 4.19.

	More importantly, this backported version uniformly converts to
	sysfs_emit(), but there are 3 places sysfs_emit_at() must be used
	instead:

Reported-by: Ben Hutchings <ben@decadent.org.uk>
Link: https://lore.kernel.org/r/95831df76c41a53bc3e1ac8ece64915dd63763a1.camel@decadent.org.uk
Cc: Joe Perches <joe@perches.com>
Cc: Brennan Lamoreaux <blamoreaux@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/arch_topology.c            |    2 -
 drivers/base/cacheinfo.c                |   18 +++++------
 drivers/base/core.c                     |    8 ++---
 drivers/base/cpu.c                      |   34 ++++++++++-----------
 drivers/base/firmware_loader/fallback.c |    2 -
 drivers/base/memory.c                   |   24 +++++++--------
 drivers/base/node.c                     |   34 ++++++++++-----------
 drivers/base/platform.c                 |    2 -
 drivers/base/power/sysfs.c              |   50 ++++++++++++++++----------------
 drivers/base/soc.c                      |    8 ++---
 10 files changed, 91 insertions(+), 91 deletions(-)

--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -44,7 +44,7 @@ static ssize_t cpu_capacity_show(struct
 {
 	struct cpu *cpu = container_of(dev, struct cpu, dev);
 
-	return sysfs_emit(buf, "%lu\n", topology_get_cpu_scale(NULL, cpu->dev.id));
+	return sprintf(buf, "%lu\n", topology_get_cpu_scale(NULL, cpu->dev.id));
 }
 
 static ssize_t cpu_capacity_store(struct device *dev,
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -372,7 +372,7 @@ static ssize_t size_show(struct device *
 {
 	struct cacheinfo *this_leaf = dev_get_drvdata(dev);
 
-	return sysfs_emit(buf, "%uK\n", this_leaf->size >> 10);
+	return sprintf(buf, "%uK\n", this_leaf->size >> 10);
 }
 
 static ssize_t shared_cpumap_show_func(struct device *dev, bool list, char *buf)
@@ -402,11 +402,11 @@ static ssize_t type_show(struct device *
 
 	switch (this_leaf->type) {
 	case CACHE_TYPE_DATA:
-		return sysfs_emit(buf, "Data\n");
+		return sprintf(buf, "Data\n");
 	case CACHE_TYPE_INST:
-		return sysfs_emit(buf, "Instruction\n");
+		return sprintf(buf, "Instruction\n");
 	case CACHE_TYPE_UNIFIED:
-		return sysfs_emit(buf, "Unified\n");
+		return sprintf(buf, "Unified\n");
 	default:
 		return -EINVAL;
 	}
@@ -420,11 +420,11 @@ static ssize_t allocation_policy_show(st
 	int n = 0;
 
 	if ((ci_attr & CACHE_READ_ALLOCATE) && (ci_attr & CACHE_WRITE_ALLOCATE))
-		n = sysfs_emit(buf, "ReadWriteAllocate\n");
+		n = sprintf(buf, "ReadWriteAllocate\n");
 	else if (ci_attr & CACHE_READ_ALLOCATE)
-		n = sysfs_emit(buf, "ReadAllocate\n");
+		n = sprintf(buf, "ReadAllocate\n");
 	else if (ci_attr & CACHE_WRITE_ALLOCATE)
-		n = sysfs_emit(buf, "WriteAllocate\n");
+		n = sprintf(buf, "WriteAllocate\n");
 	return n;
 }
 
@@ -436,9 +436,9 @@ static ssize_t write_policy_show(struct
 	int n = 0;
 
 	if (ci_attr & CACHE_WRITE_THROUGH)
-		n = sysfs_emit(buf, "WriteThrough\n");
+		n = sprintf(buf, "WriteThrough\n");
 	else if (ci_attr & CACHE_WRITE_BACK)
-		n = sysfs_emit(buf, "WriteBack\n");
+		n = sprintf(buf, "WriteBack\n");
 	return n;
 }
 
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -994,7 +994,7 @@ ssize_t device_show_ulong(struct device
 			  char *buf)
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
-	return sysfs_emit(buf, "%lx\n", *(unsigned long *)(ea->var));
+	return snprintf(buf, PAGE_SIZE, "%lx\n", *(unsigned long *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_ulong);
 
@@ -1019,7 +1019,7 @@ ssize_t device_show_int(struct device *d
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
 
-	return sysfs_emit(buf, "%d\n", *(int *)(ea->var));
+	return snprintf(buf, PAGE_SIZE, "%d\n", *(int *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_int);
 
@@ -1040,7 +1040,7 @@ ssize_t device_show_bool(struct device *
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
 
-	return sysfs_emit(buf, "%d\n", *(bool *)(ea->var));
+	return snprintf(buf, PAGE_SIZE, "%d\n", *(bool *)(ea->var));
 }
 EXPORT_SYMBOL_GPL(device_show_bool);
 
@@ -1273,7 +1273,7 @@ static ssize_t online_show(struct device
 	device_lock(dev);
 	val = !dev->offline;
 	device_unlock(dev);
-	return sysfs_emit(buf, "%u\n", val);
+	return sprintf(buf, "%u\n", val);
 }
 
 static ssize_t online_store(struct device *dev, struct device_attribute *attr,
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -156,7 +156,7 @@ static ssize_t show_crash_notes(struct d
 	 * operation should be safe. No locking required.
 	 */
 	addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpunum));
-	rc = sysfs_emit(buf, "%Lx\n", addr);
+	rc = sprintf(buf, "%Lx\n", addr);
 	return rc;
 }
 static DEVICE_ATTR(crash_notes, 0400, show_crash_notes, NULL);
@@ -167,7 +167,7 @@ static ssize_t show_crash_notes_size(str
 {
 	ssize_t rc;
 
-	rc = sysfs_emit(buf, "%zu\n", sizeof(note_buf_t));
+	rc = sprintf(buf, "%zu\n", sizeof(note_buf_t));
 	return rc;
 }
 static DEVICE_ATTR(crash_notes_size, 0400, show_crash_notes_size, NULL);
@@ -264,7 +264,7 @@ static ssize_t print_cpus_offline(struct
 						      nr_cpu_ids, total_cpus-1);
 	}
 
-	n += sysfs_emit(&buf[n], "\n");
+	n += snprintf(&buf[n], len - n, "\n");
 	return n;
 }
 static DEVICE_ATTR(offline, 0444, print_cpus_offline, NULL);
@@ -272,7 +272,7 @@ static DEVICE_ATTR(offline, 0444, print_
 static ssize_t print_cpus_isolated(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	int n = 0;
+	int n = 0, len = PAGE_SIZE-2;
 	cpumask_var_t isolated;
 
 	if (!alloc_cpumask_var(&isolated, GFP_KERNEL))
@@ -280,7 +280,7 @@ static ssize_t print_cpus_isolated(struc
 
 	cpumask_andnot(isolated, cpu_possible_mask,
 		       housekeeping_cpumask(HK_FLAG_DOMAIN));
-	n = sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(isolated));
+	n = scnprintf(buf, len, "%*pbl\n", cpumask_pr_args(isolated));
 
 	free_cpumask_var(isolated);
 
@@ -292,9 +292,9 @@ static DEVICE_ATTR(isolated, 0444, print
 static ssize_t print_cpus_nohz_full(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	int n = 0;
+	int n = 0, len = PAGE_SIZE-2;
 
-	n = sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
+	n = scnprintf(buf, len, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
 
 	return n;
 }
@@ -328,7 +328,7 @@ static ssize_t print_cpu_modalias(struct
 	ssize_t n;
 	u32 i;
 
-	n = sysfs_emit(buf, "cpu:type:" CPU_FEATURE_TYPEFMT ":feature:",
+	n = sprintf(buf, "cpu:type:" CPU_FEATURE_TYPEFMT ":feature:",
 		    CPU_FEATURE_TYPEVAL);
 
 	for (i = 0; i < MAX_CPU_FEATURES; i++)
@@ -520,56 +520,56 @@ static void __init cpu_dev_register_gene
 ssize_t __weak cpu_show_meltdown(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "Not affected\n");
+	return sprintf(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_spectre_v1(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "Not affected\n");
+	return sprintf(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_spectre_v2(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "Not affected\n");
+	return sprintf(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_spec_store_bypass(struct device *dev,
 					  struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "Not affected\n");
+	return sprintf(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_l1tf(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "Not affected\n");
+	return sprintf(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_mds(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "Not affected\n");
+	return sprintf(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_tsx_async_abort(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	return sysfs_emit(buf, "Not affected\n");
+	return sprintf(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_itlb_multihit(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "Not affected\n");
+	return sprintf(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_srbds(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "Not affected\n");
+	return sprintf(buf, "Not affected\n");
 }
 
 ssize_t __weak cpu_show_mmio_stale_data(struct device *dev,
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -215,7 +215,7 @@ static ssize_t firmware_loading_show(str
 		loading = fw_sysfs_loading(fw_sysfs->fw_priv);
 	mutex_unlock(&fw_lock);
 
-	return sysfs_emit(buf, "%d\n", loading);
+	return sprintf(buf, "%d\n", loading);
 }
 
 /* one pages buffer should be mapped/unmapped only once */
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -121,7 +121,7 @@ static ssize_t show_mem_start_phys_index
 	unsigned long phys_index;
 
 	phys_index = mem->start_section_nr / sections_per_block;
-	return sysfs_emit(buf, "%08lx\n", phys_index);
+	return sprintf(buf, "%08lx\n", phys_index);
 }
 
 /*
@@ -145,7 +145,7 @@ static ssize_t show_mem_removable(struct
 	}
 
 out:
-	return sysfs_emit(buf, "%d\n", ret);
+	return sprintf(buf, "%d\n", ret);
 }
 
 /*
@@ -163,17 +163,17 @@ static ssize_t show_mem_state(struct dev
 	 */
 	switch (mem->state) {
 	case MEM_ONLINE:
-		len = sysfs_emit(buf, "online\n");
+		len = sprintf(buf, "online\n");
 		break;
 	case MEM_OFFLINE:
-		len = sysfs_emit(buf, "offline\n");
+		len = sprintf(buf, "offline\n");
 		break;
 	case MEM_GOING_OFFLINE:
-		len = sysfs_emit(buf, "going-offline\n");
+		len = sprintf(buf, "going-offline\n");
 		break;
 	default:
-		len = sysfs_emit(buf, "ERROR-UNKNOWN-%ld\n",
-				 mem->state);
+		len = sprintf(buf, "ERROR-UNKNOWN-%ld\n",
+				mem->state);
 		WARN_ON(1);
 		break;
 	}
@@ -384,7 +384,7 @@ static ssize_t show_phys_device(struct d
 				struct device_attribute *attr, char *buf)
 {
 	struct memory_block *mem = to_memory_block(dev);
-	return sysfs_emit(buf, "%d\n", mem->phys_device);
+	return sprintf(buf, "%d\n", mem->phys_device);
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
@@ -422,7 +422,7 @@ static ssize_t show_valid_zones(struct d
 		 */
 		if (!test_pages_in_a_zone(start_pfn, start_pfn + nr_pages,
 					  &valid_start_pfn, &valid_end_pfn))
-			return sysfs_emit(buf, "none\n");
+			return sprintf(buf, "none\n");
 		start_pfn = valid_start_pfn;
 		strcat(buf, page_zone(pfn_to_page(start_pfn))->name);
 		goto out;
@@ -456,7 +456,7 @@ static ssize_t
 print_block_size(struct device *dev, struct device_attribute *attr,
 		 char *buf)
 {
-	return sysfs_emit(buf, "%lx\n", get_memory_block_size());
+	return sprintf(buf, "%lx\n", get_memory_block_size());
 }
 
 static DEVICE_ATTR(block_size_bytes, 0444, print_block_size, NULL);
@@ -470,9 +470,9 @@ show_auto_online_blocks(struct device *d
 			char *buf)
 {
 	if (memhp_auto_online)
-		return sysfs_emit(buf, "online\n");
+		return sprintf(buf, "online\n");
 	else
-		return sysfs_emit(buf, "offline\n");
+		return sprintf(buf, "offline\n");
 }
 
 static ssize_t
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -69,7 +69,7 @@ static ssize_t node_read_meminfo(struct
 	struct sysinfo i;
 
 	si_meminfo_node(&i, nid);
-	n = sysfs_emit(buf,
+	n = sprintf(buf,
 		       "Node %d MemTotal:       %8lu kB\n"
 		       "Node %d MemFree:        %8lu kB\n"
 		       "Node %d MemUsed:        %8lu kB\n"
@@ -96,7 +96,7 @@ static ssize_t node_read_meminfo(struct
 		       nid, K(sum_zone_node_page_state(nid, NR_MLOCK)));
 
 #ifdef CONFIG_HIGHMEM
-	n += sysfs_emit(buf + n,
+	n += sprintf(buf + n,
 		       "Node %d HighTotal:      %8lu kB\n"
 		       "Node %d HighFree:       %8lu kB\n"
 		       "Node %d LowTotal:       %8lu kB\n"
@@ -106,7 +106,7 @@ static ssize_t node_read_meminfo(struct
 		       nid, K(i.totalram - i.totalhigh),
 		       nid, K(i.freeram - i.freehigh));
 #endif
-	n += sysfs_emit(buf + n,
+	n += sprintf(buf + n,
 		       "Node %d Dirty:          %8lu kB\n"
 		       "Node %d Writeback:      %8lu kB\n"
 		       "Node %d FilePages:      %8lu kB\n"
@@ -162,19 +162,19 @@ static DEVICE_ATTR(meminfo, S_IRUGO, nod
 static ssize_t node_read_numastat(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf,
-			  "numa_hit %lu\n"
-			  "numa_miss %lu\n"
-			  "numa_foreign %lu\n"
-			  "interleave_hit %lu\n"
-			  "local_node %lu\n"
-			  "other_node %lu\n",
-			  sum_zone_numa_state(dev->id, NUMA_HIT),
-			  sum_zone_numa_state(dev->id, NUMA_MISS),
-			  sum_zone_numa_state(dev->id, NUMA_FOREIGN),
-			  sum_zone_numa_state(dev->id, NUMA_INTERLEAVE_HIT),
-			  sum_zone_numa_state(dev->id, NUMA_LOCAL),
-			  sum_zone_numa_state(dev->id, NUMA_OTHER));
+	return sprintf(buf,
+		       "numa_hit %lu\n"
+		       "numa_miss %lu\n"
+		       "numa_foreign %lu\n"
+		       "interleave_hit %lu\n"
+		       "local_node %lu\n"
+		       "other_node %lu\n",
+		       sum_zone_numa_state(dev->id, NUMA_HIT),
+		       sum_zone_numa_state(dev->id, NUMA_MISS),
+		       sum_zone_numa_state(dev->id, NUMA_FOREIGN),
+		       sum_zone_numa_state(dev->id, NUMA_INTERLEAVE_HIT),
+		       sum_zone_numa_state(dev->id, NUMA_LOCAL),
+		       sum_zone_numa_state(dev->id, NUMA_OTHER));
 }
 static DEVICE_ATTR(numastat, S_IRUGO, node_read_numastat, NULL);
 
@@ -612,7 +612,7 @@ static ssize_t print_nodes_state(enum no
 {
 	int n;
 
-	n = sysfs_emit(buf, "%*pbl",
+	n = scnprintf(buf, PAGE_SIZE - 1, "%*pbl",
 		      nodemask_pr_args(&node_states[state]));
 	buf[n++] = '\n';
 	buf[n] = '\0';
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -927,7 +927,7 @@ static ssize_t driver_override_show(stru
 	ssize_t len;
 
 	device_lock(dev);
-	len = sysfs_emit(buf, "%s\n", pdev->driver_override);
+	len = sprintf(buf, "%s\n", pdev->driver_override);
 	device_unlock(dev);
 	return len;
 }
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -101,7 +101,7 @@ static const char ctrl_on[] = "on";
 static ssize_t control_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
-	return sysfs_emit(buf, "%s\n",
+	return sprintf(buf, "%s\n",
 				dev->power.runtime_auto ? ctrl_auto : ctrl_on);
 }
 
@@ -127,7 +127,7 @@ static ssize_t runtime_active_time_show(
 	int ret;
 	spin_lock_irq(&dev->power.lock);
 	update_pm_runtime_accounting(dev);
-	ret = sysfs_emit(buf, "%i\n", jiffies_to_msecs(dev->power.active_jiffies));
+	ret = sprintf(buf, "%i\n", jiffies_to_msecs(dev->power.active_jiffies));
 	spin_unlock_irq(&dev->power.lock);
 	return ret;
 }
@@ -140,7 +140,7 @@ static ssize_t runtime_suspended_time_sh
 	int ret;
 	spin_lock_irq(&dev->power.lock);
 	update_pm_runtime_accounting(dev);
-	ret = sysfs_emit(buf, "%i\n",
+	ret = sprintf(buf, "%i\n",
 		jiffies_to_msecs(dev->power.suspended_jiffies));
 	spin_unlock_irq(&dev->power.lock);
 	return ret;
@@ -175,7 +175,7 @@ static ssize_t runtime_status_show(struc
 			return -EIO;
 		}
 	}
-	return sysfs_emit(buf, p);
+	return sprintf(buf, p);
 }
 
 static DEVICE_ATTR_RO(runtime_status);
@@ -185,7 +185,7 @@ static ssize_t autosuspend_delay_ms_show
 {
 	if (!dev->power.use_autosuspend)
 		return -EIO;
-	return sysfs_emit(buf, "%d\n", dev->power.autosuspend_delay);
+	return sprintf(buf, "%d\n", dev->power.autosuspend_delay);
 }
 
 static ssize_t autosuspend_delay_ms_store(struct device *dev,
@@ -214,11 +214,11 @@ static ssize_t pm_qos_resume_latency_us_
 	s32 value = dev_pm_qos_requested_resume_latency(dev);
 
 	if (value == 0)
-		return sysfs_emit(buf, "n/a\n");
+		return sprintf(buf, "n/a\n");
 	if (value == PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
 		value = 0;
 
-	return sysfs_emit(buf, "%d\n", value);
+	return sprintf(buf, "%d\n", value);
 }
 
 static ssize_t pm_qos_resume_latency_us_store(struct device *dev,
@@ -258,11 +258,11 @@ static ssize_t pm_qos_latency_tolerance_
 	s32 value = dev_pm_qos_get_user_latency_tolerance(dev);
 
 	if (value < 0)
-		return sysfs_emit(buf, "auto\n");
+		return sprintf(buf, "auto\n");
 	if (value == PM_QOS_LATENCY_ANY)
-		return sysfs_emit(buf, "any\n");
+		return sprintf(buf, "any\n");
 
-	return sysfs_emit(buf, "%d\n", value);
+	return sprintf(buf, "%d\n", value);
 }
 
 static ssize_t pm_qos_latency_tolerance_us_store(struct device *dev,
@@ -294,8 +294,8 @@ static ssize_t pm_qos_no_power_off_show(
 					struct device_attribute *attr,
 					char *buf)
 {
-	return sysfs_emit(buf, "%d\n", !!(dev_pm_qos_requested_flags(dev)
-					  & PM_QOS_FLAG_NO_POWER_OFF));
+	return sprintf(buf, "%d\n", !!(dev_pm_qos_requested_flags(dev)
+					& PM_QOS_FLAG_NO_POWER_OFF));
 }
 
 static ssize_t pm_qos_no_power_off_store(struct device *dev,
@@ -323,9 +323,9 @@ static const char _disabled[] = "disable
 static ssize_t wakeup_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
-	return sysfs_emit(buf, "%s\n", device_can_wakeup(dev)
-			  ? (device_may_wakeup(dev) ? _enabled : _disabled)
-			  : "");
+	return sprintf(buf, "%s\n", device_can_wakeup(dev)
+		? (device_may_wakeup(dev) ? _enabled : _disabled)
+		: "");
 }
 
 static ssize_t wakeup_store(struct device *dev, struct device_attribute *attr,
@@ -511,7 +511,7 @@ static DEVICE_ATTR_RO(wakeup_prevent_sle
 static ssize_t runtime_usage_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", atomic_read(&dev->power.usage_count));
+	return sprintf(buf, "%d\n", atomic_read(&dev->power.usage_count));
 }
 static DEVICE_ATTR_RO(runtime_usage);
 
@@ -519,8 +519,8 @@ static ssize_t runtime_active_kids_show(
 					struct device_attribute *attr,
 					char *buf)
 {
-	return sysfs_emit(buf, "%d\n", dev->power.ignore_children ?
-			  0 : atomic_read(&dev->power.child_count));
+	return sprintf(buf, "%d\n", dev->power.ignore_children ?
+		0 : atomic_read(&dev->power.child_count));
 }
 static DEVICE_ATTR_RO(runtime_active_kids);
 
@@ -528,12 +528,12 @@ static ssize_t runtime_enabled_show(stru
 				    struct device_attribute *attr, char *buf)
 {
 	if (dev->power.disable_depth && (dev->power.runtime_auto == false))
-		return sysfs_emit(buf, "disabled & forbidden\n");
+		return sprintf(buf, "disabled & forbidden\n");
 	if (dev->power.disable_depth)
-		return sysfs_emit(buf, "disabled\n");
+		return sprintf(buf, "disabled\n");
 	if (dev->power.runtime_auto == false)
-		return sysfs_emit(buf, "forbidden\n");
-	return sysfs_emit(buf, "enabled\n");
+		return sprintf(buf, "forbidden\n");
+	return sprintf(buf, "enabled\n");
 }
 static DEVICE_ATTR_RO(runtime_enabled);
 
@@ -541,9 +541,9 @@ static DEVICE_ATTR_RO(runtime_enabled);
 static ssize_t async_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
-	return sysfs_emit(buf, "%s\n",
-			  device_async_suspend_enabled(dev) ?
-			  _enabled : _disabled);
+	return sprintf(buf, "%s\n",
+			device_async_suspend_enabled(dev) ?
+				_enabled : _disabled);
 }
 
 static ssize_t async_store(struct device *dev, struct device_attribute *attr,
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -72,13 +72,13 @@ static ssize_t soc_info_get(struct devic
 	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
 
 	if (attr == &dev_attr_machine)
-		return sysfs_emit(buf, "%s\n", soc_dev->attr->machine);
+		return sprintf(buf, "%s\n", soc_dev->attr->machine);
 	if (attr == &dev_attr_family)
-		return sysfs_emit(buf, "%s\n", soc_dev->attr->family);
+		return sprintf(buf, "%s\n", soc_dev->attr->family);
 	if (attr == &dev_attr_revision)
-		return sysfs_emit(buf, "%s\n", soc_dev->attr->revision);
+		return sprintf(buf, "%s\n", soc_dev->attr->revision);
 	if (attr == &dev_attr_soc_id)
-		return sysfs_emit(buf, "%s\n", soc_dev->attr->soc_id);
+		return sprintf(buf, "%s\n", soc_dev->attr->soc_id);
 
 	return -EINVAL;
 


