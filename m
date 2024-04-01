Return-Path: <stable+bounces-34841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AFA894120
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818991F21B4D
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5EB43AD6;
	Mon,  1 Apr 2024 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AtvH7pMQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05B91C0DE7;
	Mon,  1 Apr 2024 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989477; cv=none; b=orgWtOsiO25SBwXQ+4z62nus0z3A2wbpPCrSyw9gdNdnkzRCV2K7DLioZFM/i7a2dEGepyhwZb78tfF9g5qgAOvMDKuknUgmVjurtyjX2ksdWvg6DYpcXPBtSsLaHkj+pRo1C/tfc1fKifD6Ne0iVwf+aTsXg5iXCTNyPyYAXGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989477; c=relaxed/simple;
	bh=cTtFE2VeyUs+zDXBmJ3nos83J8b1QQJR9Xnz4cxZ+fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Egd/0wviggTTMDyqdvSqqBp1petca73fQlgSCsIPRIAScTXoeoJa2F/zSeHOxAM496y6hxTg9jpiFmRik1mNKl4iC+6jdQcZXdaNkkY6CDw6sq2mNIVUSszxUJ/eNi4eGhdEXlq+nV9p98R16QQ0EqfZJmVCATkDN0ZoTr9GpKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AtvH7pMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4629BC433F1;
	Mon,  1 Apr 2024 16:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989477;
	bh=cTtFE2VeyUs+zDXBmJ3nos83J8b1QQJR9Xnz4cxZ+fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AtvH7pMQM52CKvN68e/yGMwbAneHn4ZXx7LeBtOc2sZOvrPPV1GDs4CIhcpV7YF30
	 CKPMo1ZltNBjLBT6xAGvnNJXd5XswyjS9X9A8lt2INXENWkNd83emNknnECUNMH07i
	 omQy/e+3CDdqALgXrpwiDwZjgZq2U215Lc/W/vWw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Rui <rui.zhang@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 032/396] powercap: intel_rapl: Fix locking in TPMI RAPL
Date: Mon,  1 Apr 2024 17:41:21 +0200
Message-ID: <20240401152548.883185500@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Rui <rui.zhang@intel.com>

[ Upstream commit 1aa09b9379a7a644cd2f75ae0bac82b8783df600 ]

The RAPL framework uses CPU hotplug locking to protect the rapl_packages
list and rp->lead_cpu to guarantee that

 1. the RAPL package device is not unprobed and freed
 2. the cached rp->lead_cpu is always valid

for operations like powercap sysfs accesses.

Current RAPL APIs assume being called from CPU hotplug callbacks which
hold the CPU hotplug lock, but TPMI RAPL driver invokes the APIs in the
driver's .probe() function without acquiring the CPU hotplug lock.

Fix the problem by providing both locked and lockless versions of RAPL
APIs.

Fixes: 9eef7f9da928 ("powercap: intel_rapl: Introduce RAPL TPMI interface driver")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Cc: 6.5+ <stable@vger.kernel.org> # 6.5+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/powercap/intel_rapl_common.c          | 29 +++++++++++++++++--
 drivers/powercap/intel_rapl_msr.c             |  8 ++---
 .../int340x_thermal/processor_thermal_rapl.c  |  8 ++---
 include/linux/intel_rapl.h                    |  6 ++++
 4 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 1a739afd47d96..9d3e102f1a76b 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -5,6 +5,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/cleanup.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/list.h>
@@ -1504,7 +1505,7 @@ static int rapl_detect_domains(struct rapl_package *rp)
 }
 
 /* called from CPU hotplug notifier, hotplug lock held */
-void rapl_remove_package(struct rapl_package *rp)
+void rapl_remove_package_cpuslocked(struct rapl_package *rp)
 {
 	struct rapl_domain *rd, *rd_package = NULL;
 
@@ -1533,10 +1534,18 @@ void rapl_remove_package(struct rapl_package *rp)
 	list_del(&rp->plist);
 	kfree(rp);
 }
+EXPORT_SYMBOL_GPL(rapl_remove_package_cpuslocked);
+
+void rapl_remove_package(struct rapl_package *rp)
+{
+	guard(cpus_read_lock)();
+	rapl_remove_package_cpuslocked(rp);
+}
 EXPORT_SYMBOL_GPL(rapl_remove_package);
 
 /* caller to ensure CPU hotplug lock is held */
-struct rapl_package *rapl_find_package_domain(int id, struct rapl_if_priv *priv, bool id_is_cpu)
+struct rapl_package *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_priv *priv,
+							 bool id_is_cpu)
 {
 	struct rapl_package *rp;
 	int uid;
@@ -1554,10 +1563,17 @@ struct rapl_package *rapl_find_package_domain(int id, struct rapl_if_priv *priv,
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(rapl_find_package_domain_cpuslocked);
+
+struct rapl_package *rapl_find_package_domain(int id, struct rapl_if_priv *priv, bool id_is_cpu)
+{
+	guard(cpus_read_lock)();
+	return rapl_find_package_domain_cpuslocked(id, priv, id_is_cpu);
+}
 EXPORT_SYMBOL_GPL(rapl_find_package_domain);
 
 /* called from CPU hotplug notifier, hotplug lock held */
-struct rapl_package *rapl_add_package(int id, struct rapl_if_priv *priv, bool id_is_cpu)
+struct rapl_package *rapl_add_package_cpuslocked(int id, struct rapl_if_priv *priv, bool id_is_cpu)
 {
 	struct rapl_package *rp;
 	int ret;
@@ -1603,6 +1619,13 @@ struct rapl_package *rapl_add_package(int id, struct rapl_if_priv *priv, bool id
 	kfree(rp);
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(rapl_add_package_cpuslocked);
+
+struct rapl_package *rapl_add_package(int id, struct rapl_if_priv *priv, bool id_is_cpu)
+{
+	guard(cpus_read_lock)();
+	return rapl_add_package_cpuslocked(id, priv, id_is_cpu);
+}
 EXPORT_SYMBOL_GPL(rapl_add_package);
 
 static void power_limit_state_save(void)
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 250bd41a588c7..b4b6930cacb0b 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -73,9 +73,9 @@ static int rapl_cpu_online(unsigned int cpu)
 {
 	struct rapl_package *rp;
 
-	rp = rapl_find_package_domain(cpu, rapl_msr_priv, true);
+	rp = rapl_find_package_domain_cpuslocked(cpu, rapl_msr_priv, true);
 	if (!rp) {
-		rp = rapl_add_package(cpu, rapl_msr_priv, true);
+		rp = rapl_add_package_cpuslocked(cpu, rapl_msr_priv, true);
 		if (IS_ERR(rp))
 			return PTR_ERR(rp);
 	}
@@ -88,14 +88,14 @@ static int rapl_cpu_down_prep(unsigned int cpu)
 	struct rapl_package *rp;
 	int lead_cpu;
 
-	rp = rapl_find_package_domain(cpu, rapl_msr_priv, true);
+	rp = rapl_find_package_domain_cpuslocked(cpu, rapl_msr_priv, true);
 	if (!rp)
 		return 0;
 
 	cpumask_clear_cpu(cpu, &rp->cpumask);
 	lead_cpu = cpumask_first(&rp->cpumask);
 	if (lead_cpu >= nr_cpu_ids)
-		rapl_remove_package(rp);
+		rapl_remove_package_cpuslocked(rp);
 	else if (rp->lead_cpu == cpu)
 		rp->lead_cpu = lead_cpu;
 	return 0;
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
index 2f00fc3bf274a..e964a9375722a 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
@@ -27,9 +27,9 @@ static int rapl_mmio_cpu_online(unsigned int cpu)
 	if (topology_physical_package_id(cpu))
 		return 0;
 
-	rp = rapl_find_package_domain(cpu, &rapl_mmio_priv, true);
+	rp = rapl_find_package_domain_cpuslocked(cpu, &rapl_mmio_priv, true);
 	if (!rp) {
-		rp = rapl_add_package(cpu, &rapl_mmio_priv, true);
+		rp = rapl_add_package_cpuslocked(cpu, &rapl_mmio_priv, true);
 		if (IS_ERR(rp))
 			return PTR_ERR(rp);
 	}
@@ -42,14 +42,14 @@ static int rapl_mmio_cpu_down_prep(unsigned int cpu)
 	struct rapl_package *rp;
 	int lead_cpu;
 
-	rp = rapl_find_package_domain(cpu, &rapl_mmio_priv, true);
+	rp = rapl_find_package_domain_cpuslocked(cpu, &rapl_mmio_priv, true);
 	if (!rp)
 		return 0;
 
 	cpumask_clear_cpu(cpu, &rp->cpumask);
 	lead_cpu = cpumask_first(&rp->cpumask);
 	if (lead_cpu >= nr_cpu_ids)
-		rapl_remove_package(rp);
+		rapl_remove_package_cpuslocked(rp);
 	else if (rp->lead_cpu == cpu)
 		rp->lead_cpu = lead_cpu;
 	return 0;
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index 33f21bd85dbf2..f3196f82fd8a1 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -178,6 +178,12 @@ struct rapl_package {
 	struct rapl_if_priv *priv;
 };
 
+struct rapl_package *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_priv *priv,
+						       bool id_is_cpu);
+struct rapl_package *rapl_add_package_cpuslocked(int id, struct rapl_if_priv *priv,
+						 bool id_is_cpu);
+void rapl_remove_package_cpuslocked(struct rapl_package *rp);
+
 struct rapl_package *rapl_find_package_domain(int id, struct rapl_if_priv *priv, bool id_is_cpu);
 struct rapl_package *rapl_add_package(int id, struct rapl_if_priv *priv, bool id_is_cpu);
 void rapl_remove_package(struct rapl_package *rp);
-- 
2.43.0




