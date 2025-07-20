Return-Path: <stable+bounces-163479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24099B0B961
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 01:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F003177CA0
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 23:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CBF1A23B6;
	Sun, 20 Jul 2025 23:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRhJScGa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A218BEE
	for <stable@vger.kernel.org>; Sun, 20 Jul 2025 23:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753055238; cv=none; b=avwK13RlsEvpDo7FkGypQ6Q5zqpELGGOT0E3EROI+4p4ljWHzUloFu6jL684iA9XndyFyC4b7FkGuhSyrqWSpYh6Wn4rs5GX8Gl6cHzOnGEeRqnXj0BFBFHdpX2xXpkkBgoFtxNsSA0edJVnS3rhxyVhwQRYX/3FdB/DjWY7ZWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753055238; c=relaxed/simple;
	bh=EiQAV48sC89up4OXrS3Ei453mWqT9G1s1oW0cPcy0v8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tclLu9iSFahOR1rrR/q1v1YvOuyCDde4scBGmIwhL7HBUKPC/pMJqE8wYCEbsfAG0UUhYy/Mz0XYfh96/rKiiZN3psIc64B9KRSRAejnTY3nN1r+2+mq6S9XEaqv9vs5SET1Qr+kpqS06VbFvCS2OvCxZeV2/w8kO5L0ifnwZJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRhJScGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D36C4CEE7;
	Sun, 20 Jul 2025 23:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753055237;
	bh=EiQAV48sC89up4OXrS3Ei453mWqT9G1s1oW0cPcy0v8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FRhJScGa5Oz3QnqIgunFaWdrUD3B/X7/ybgjvy3jh9H/kB+uYYABhVqOUEQC8tXsh
	 q9VRf9d2oxWyKGDHWLrqZX9l5g8TRsQxUWEqOfG7HrsNtc0tPOsMuidEHVnHbpReE4
	 bZ7RgTuRH6jtpaNN4QQB+VHRoX+fAuM44AFZJyspIXWI1AKBSHsQNj7Oh3oOIAZ3be
	 3yvW1O3XErEjcNsbA7XnJsYgIvKGgcJW4z1SrLqllA+2H9hWpCo+6d1Fo7KbiznLuL
	 SgLYA1xCnIkHpRVqMsEtiUFQ94ZVzJ0LBE442dtFiSRIv0Bj81KKjeri/9SOBwZdJQ
	 HeDH/VuNy6v6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Wang Wendy <wendy.wang@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/7] powercap: intel_rapl: Support per Interface rapl_defaults
Date: Sun, 20 Jul 2025 19:46:59 -0400
Message-Id: <20250720234705.764310-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025070817-quaintly-lend-80a3@gregkh>
References: <2025070817-quaintly-lend-80a3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

[ Upstream commit e8e28c2af16b279b6c37d533e1e73effb197cf2e ]

rapl_defaults is Interface specific.

Although current MSR and MMIO Interface share the same rapl_defaults,
new Interface like TPMI need its own rapl_defaults callbacks.

Save the rapl_defaults information in the Interface private structure.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 964209202ebe ("powercap: intel_rapl: Do not change CLAMPING bit if ENABLE bit cannot be changed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/powercap/intel_rapl_common.c | 46 ++++++++++++++++++++--------
 include/linux/intel_rapl.h           |  2 ++
 2 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 26d00b1853b42..6801eb2d299cc 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -115,6 +115,11 @@ struct rapl_defaults {
 };
 static struct rapl_defaults *rapl_defaults;
 
+static struct rapl_defaults *get_defaults(struct rapl_package *rp)
+{
+	return rp->priv->defaults;
+}
+
 /* Sideband MBI registers */
 #define IOSF_CPU_POWER_BUDGET_CTL_BYT (0x2)
 #define IOSF_CPU_POWER_BUDGET_CTL_TNG (0xdf)
@@ -227,14 +232,15 @@ static int find_nr_power_limit(struct rapl_domain *rd)
 static int set_domain_enable(struct powercap_zone *power_zone, bool mode)
 {
 	struct rapl_domain *rd = power_zone_to_rapl_domain(power_zone);
+	struct rapl_defaults *defaults = get_defaults(rd->rp);
 
 	if (rd->state & DOMAIN_STATE_BIOS_LOCKED)
 		return -EACCES;
 
 	cpus_read_lock();
 	rapl_write_data_raw(rd, PL1_ENABLE, mode);
-	if (rapl_defaults->set_floor_freq)
-		rapl_defaults->set_floor_freq(rd, mode);
+	if (defaults->set_floor_freq)
+		defaults->set_floor_freq(rd, mode);
 	cpus_read_unlock();
 
 	return 0;
@@ -551,6 +557,7 @@ static void rapl_init_domains(struct rapl_package *rp)
 	enum rapl_domain_type i;
 	enum rapl_domain_reg_id j;
 	struct rapl_domain *rd = rp->domains;
+	struct rapl_defaults *defaults = get_defaults(rp);
 
 	for (i = 0; i < RAPL_DOMAIN_MAX; i++) {
 		unsigned int mask = rp->domain_map & (1 << i);
@@ -592,14 +599,14 @@ static void rapl_init_domains(struct rapl_package *rp)
 		switch (i) {
 		case RAPL_DOMAIN_DRAM:
 			rd->domain_energy_unit =
-			    rapl_defaults->dram_domain_energy_unit;
+			    defaults->dram_domain_energy_unit;
 			if (rd->domain_energy_unit)
 				pr_info("DRAM domain energy unit %dpj\n",
 					rd->domain_energy_unit);
 			break;
 		case RAPL_DOMAIN_PLATFORM:
 			rd->domain_energy_unit =
-			    rapl_defaults->psys_domain_energy_unit;
+			    defaults->psys_domain_energy_unit;
 			if (rd->domain_energy_unit)
 				pr_info("Platform domain energy unit %dpj\n",
 					rd->domain_energy_unit);
@@ -616,6 +623,7 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
 {
 	u64 units = 1;
 	struct rapl_package *rp = rd->rp;
+	struct rapl_defaults *defaults = get_defaults(rp);
 	u64 scale = 1;
 
 	switch (type) {
@@ -631,7 +639,7 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
 			units = rp->energy_unit;
 		break;
 	case TIME_UNIT:
-		return rapl_defaults->compute_time_window(rp, value, to_raw);
+		return defaults->compute_time_window(rp, value, to_raw);
 	case ARBITRARY_UNIT:
 	default:
 		return value;
@@ -702,10 +710,18 @@ static struct rapl_primitive_info rpi[] = {
 	{NULL, 0, 0, 0},
 };
 
+static int rapl_config(struct rapl_package *rp)
+{
+	rp->priv->defaults = (void *)rapl_defaults;
+	return 0;
+}
+
 static enum rapl_primitives
 prim_fixups(struct rapl_domain *rd, enum rapl_primitives prim)
 {
-	if (!rapl_defaults->spr_psys_bits)
+	struct rapl_defaults *defaults = get_defaults(rd->rp);
+
+	if (!defaults->spr_psys_bits)
 		return prim;
 
 	if (rd->id != RAPL_DOMAIN_PLATFORM)
@@ -960,16 +976,17 @@ static void set_floor_freq_default(struct rapl_domain *rd, bool mode)
 static void set_floor_freq_atom(struct rapl_domain *rd, bool enable)
 {
 	static u32 power_ctrl_orig_val;
+	struct rapl_defaults *defaults = get_defaults(rd->rp);
 	u32 mdata;
 
-	if (!rapl_defaults->floor_freq_reg_addr) {
+	if (!defaults->floor_freq_reg_addr) {
 		pr_err("Invalid floor frequency config register\n");
 		return;
 	}
 
 	if (!power_ctrl_orig_val)
 		iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_CR_READ,
-			      rapl_defaults->floor_freq_reg_addr,
+			      defaults->floor_freq_reg_addr,
 			      &power_ctrl_orig_val);
 	mdata = power_ctrl_orig_val;
 	if (enable) {
@@ -977,7 +994,7 @@ static void set_floor_freq_atom(struct rapl_domain *rd, bool enable)
 		mdata |= 1 << 8;
 	}
 	iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_CR_WRITE,
-		       rapl_defaults->floor_freq_reg_addr, mdata);
+		       defaults->floor_freq_reg_addr, mdata);
 }
 
 static u64 rapl_compute_time_window_core(struct rapl_package *rp, u64 value,
@@ -1374,11 +1391,9 @@ struct rapl_package *rapl_add_package(int cpu, struct rapl_if_priv *priv)
 {
 	int id = topology_logical_die_id(cpu);
 	struct rapl_package *rp;
+	struct rapl_defaults *defaults;
 	int ret;
 
-	if (!rapl_defaults)
-		return ERR_PTR(-ENODEV);
-
 	rp = kzalloc(sizeof(struct rapl_package), GFP_KERNEL);
 	if (!rp)
 		return ERR_PTR(-ENOMEM);
@@ -1388,6 +1403,10 @@ struct rapl_package *rapl_add_package(int cpu, struct rapl_if_priv *priv)
 	rp->lead_cpu = cpu;
 	rp->priv = priv;
 
+	ret = rapl_config(rp);
+	if (ret)
+		goto err_free_package;
+
 	if (topology_max_die_per_package() > 1)
 		snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH,
 			 "package-%d-die-%d",
@@ -1396,8 +1415,9 @@ struct rapl_package *rapl_add_package(int cpu, struct rapl_if_priv *priv)
 		snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH, "package-%d",
 			 topology_physical_package_id(cpu));
 
+	defaults = get_defaults(rp);
 	/* check if the package contains valid domains */
-	if (rapl_detect_domains(rp, cpu) || rapl_defaults->check_unit(rp, cpu)) {
+	if (rapl_detect_domains(rp, cpu) || defaults->check_unit(rp, cpu)) {
 		ret = -ENODEV;
 		goto err_free_package;
 	}
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index 9f4b6f5b822f6..bc698f260796e 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -121,6 +121,7 @@ struct reg_action {
  *				registers.
  * @write_raw:			Callback for writing RAPL interface specific
  *				registers.
+ * @defaults:			internal pointer to interface default settings
  */
 struct rapl_if_priv {
 	struct powercap_control_type *control_type;
@@ -131,6 +132,7 @@ struct rapl_if_priv {
 	int limits[RAPL_DOMAIN_MAX];
 	int (*read_raw)(int cpu, struct reg_action *ra);
 	int (*write_raw)(int cpu, struct reg_action *ra);
+	void *defaults;
 };
 
 /* maximum rapl package domain name: package-%d-die-%d */
-- 
2.39.5


