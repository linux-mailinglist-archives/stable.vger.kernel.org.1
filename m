Return-Path: <stable+bounces-163480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A54B0B962
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 01:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72BC1784D9
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 23:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BC88BEE;
	Sun, 20 Jul 2025 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkRWqPKv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1AE1E5B6D
	for <stable@vger.kernel.org>; Sun, 20 Jul 2025 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753055241; cv=none; b=NSpVs1NRKeUKLzfKe2KUKDCUTzpy7I5a8agLPoCJ7VCMTODSDLwoG3yQedgY8Kb6iFzGozOtJSjMSJHXTKg+XcJn9jhvzlhlaKFrkr3TIJKtfu1q+ecd7ZChMZMo7VJEslT/O0mDrxkxTVFJFeGKr74GLgnKT5rKUF4omhuVD+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753055241; c=relaxed/simple;
	bh=3KXRKA3gawX3wOrg2LRRKJW54Myl/UKrTW4xq+zgxrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eVH/CJyKlPwJ9oxOz1ZEFVdskdrQd3ucyG+1XwI3w0TekLMjUpiYxN/W7Y/ra6GihE/S/PNkZKQjZ4gkzJ3hxjjAvj9ima+SMl0vP9q4vGbXpCQP67EVrEAcvgCoQ31zBTg/eRuAdSxE1REaHFjPuvh0GTqbfkCtHaBxvJFoSFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkRWqPKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507EDC4CEED;
	Sun, 20 Jul 2025 23:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753055239;
	bh=3KXRKA3gawX3wOrg2LRRKJW54Myl/UKrTW4xq+zgxrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BkRWqPKv7rXE8x++xBmzhs7aB6BUPqJHaKhwHxxWo7al8bduAF0bBaKgK3cvdXL+s
	 zWzSgNHVjh3KJr5vlWDMGPOhOpCAEAOhzApGqGi/kByKpZlZncZvi9STUn4An421up
	 P3LdqtI9UC2EhPRTrSxc7J/kFpjpMpS+ZmcCWlyqCZxFL4LQgmBLgJG0p+884O/Jys
	 HiZC6nZB5lXddfvdWPoZK6KUi1JCOuqtSygNF4beEmlSVKHvySWFPX07QKMToBKiY9
	 LPW4ATuVOV6mt13fQ0Bo75+RJCKfCcmU5HbcsowV1HdqjSwH/TeJltrWqMmHdQKWQ7
	 8Kv/Tu7nVFlWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Wang Wendy <wendy.wang@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/7] powercap: intel_rapl: Support per Interface primitive information
Date: Sun, 20 Jul 2025 19:47:00 -0400
Message-Id: <20250720234705.764310-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250720234705.764310-1-sashal@kernel.org>
References: <2025070817-quaintly-lend-80a3@gregkh>
 <20250720234705.764310-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

[ Upstream commit 98ff639a7289067247b3ef9dd5d1e922361e7365 ]

RAPL primitive information is Interface specific.

Although current MSR and MMIO Interface share the same RAPL primitives,
new Interface like TPMI has its own RAPL primitive information.

Save the primitive information in the Interface private structure.

Plus, using variant name "rp" for struct rapl_primitive_info is
confusing because "rp" is also used for struct rapl_package.
Use "rpi" as the variant name for struct rapl_primitive_info, and rename
the previous rpi[] array to avoid conflict.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 964209202ebe ("powercap: intel_rapl: Do not change CLAMPING bit if ENABLE bit cannot be changed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/powercap/intel_rapl_common.c | 50 ++++++++++++++++++----------
 include/linux/intel_rapl.h           |  2 ++
 2 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 6801eb2d299cc..e99905ca271da 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -654,7 +654,7 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
 }
 
 /* in the order of enum rapl_primitives */
-static struct rapl_primitive_info rpi[] = {
+static struct rapl_primitive_info rpi_default[] = {
 	/* name, mask, shift, msr index, unit divisor */
 	PRIMITIVE_INFO_INIT(ENERGY_COUNTER, ENERGY_STATUS_MASK, 0,
 			    RAPL_DOMAIN_REG_STATUS, ENERGY_UNIT, 0),
@@ -710,9 +710,20 @@ static struct rapl_primitive_info rpi[] = {
 	{NULL, 0, 0, 0},
 };
 
+static struct rapl_primitive_info *get_rpi(struct rapl_package *rp, int prim)
+{
+	struct rapl_primitive_info *rpi = rp->priv->rpi;
+
+	if (prim < 0 || prim > NR_RAPL_PRIMITIVES || !rpi)
+		return NULL;
+
+	return &rpi[prim];
+}
+
 static int rapl_config(struct rapl_package *rp)
 {
 	rp->priv->defaults = (void *)rapl_defaults;
+	rp->priv->rpi = (void *)rpi_default;
 	return 0;
 }
 
@@ -763,14 +774,14 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 {
 	u64 value;
 	enum rapl_primitives prim_fixed = prim_fixups(rd, prim);
-	struct rapl_primitive_info *rp = &rpi[prim_fixed];
+	struct rapl_primitive_info *rpi = get_rpi(rd->rp, prim_fixed);
 	struct reg_action ra;
 	int cpu;
 
-	if (!rp->name || rp->flag & RAPL_PRIMITIVE_DUMMY)
+	if (!rpi || !rpi->name || rpi->flag & RAPL_PRIMITIVE_DUMMY)
 		return -EINVAL;
 
-	ra.reg = rd->regs[rp->id];
+	ra.reg = rd->regs[rpi->id];
 	if (!ra.reg)
 		return -EINVAL;
 
@@ -778,26 +789,26 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 
 	/* domain with 2 limits has different bit */
 	if (prim == FW_LOCK && rd->rp->priv->limits[rd->id] == 2) {
-		rp->mask = POWER_HIGH_LOCK;
-		rp->shift = 63;
+		rpi->mask = POWER_HIGH_LOCK;
+		rpi->shift = 63;
 	}
 	/* non-hardware data are collected by the polling thread */
-	if (rp->flag & RAPL_PRIMITIVE_DERIVED) {
+	if (rpi->flag & RAPL_PRIMITIVE_DERIVED) {
 		*data = rd->rdd.primitives[prim];
 		return 0;
 	}
 
-	ra.mask = rp->mask;
+	ra.mask = rpi->mask;
 
 	if (rd->rp->priv->read_raw(cpu, &ra)) {
 		pr_debug("failed to read reg 0x%llx on cpu %d\n", ra.reg, cpu);
 		return -EIO;
 	}
 
-	value = ra.value >> rp->shift;
+	value = ra.value >> rpi->shift;
 
 	if (xlate)
-		*data = rapl_unit_xlate(rd, rp->unit, value, 0);
+		*data = rapl_unit_xlate(rd, rpi->unit, value, 0);
 	else
 		*data = value;
 
@@ -810,21 +821,24 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
 			       unsigned long long value)
 {
 	enum rapl_primitives prim_fixed = prim_fixups(rd, prim);
-	struct rapl_primitive_info *rp = &rpi[prim_fixed];
+	struct rapl_primitive_info *rpi = get_rpi(rd->rp, prim_fixed);
 	int cpu;
 	u64 bits;
 	struct reg_action ra;
 	int ret;
 
+	if (!rpi || !rpi->name || rpi->flag & RAPL_PRIMITIVE_DUMMY)
+		return -EINVAL;
+
 	cpu = rd->rp->lead_cpu;
-	bits = rapl_unit_xlate(rd, rp->unit, value, 1);
-	bits <<= rp->shift;
-	bits &= rp->mask;
+	bits = rapl_unit_xlate(rd, rpi->unit, value, 1);
+	bits <<= rpi->shift;
+	bits &= rpi->mask;
 
 	memset(&ra, 0, sizeof(ra));
 
-	ra.reg = rd->regs[rp->id];
-	ra.mask = rp->mask;
+	ra.reg = rd->regs[rpi->id];
+	ra.mask = rpi->mask;
 	ra.value = bits;
 
 	ret = rd->rp->priv->write_raw(cpu, &ra);
@@ -1165,8 +1179,10 @@ static void rapl_update_domain_data(struct rapl_package *rp)
 			 rp->domains[dmn].name);
 		/* exclude non-raw primitives */
 		for (prim = 0; prim < NR_RAW_PRIMITIVES; prim++) {
+			struct rapl_primitive_info *rpi = get_rpi(rp, prim);
+
 			if (!rapl_read_data_raw(&rp->domains[dmn], prim,
-						rpi[prim].unit, &val))
+						rpi->unit, &val))
 				rp->domains[dmn].rdd.primitives[prim] = val;
 		}
 	}
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index bc698f260796e..b2456d97995ba 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -122,6 +122,7 @@ struct reg_action {
  * @write_raw:			Callback for writing RAPL interface specific
  *				registers.
  * @defaults:			internal pointer to interface default settings
+ * @rpi:			internal pointer to interface primitive info
  */
 struct rapl_if_priv {
 	struct powercap_control_type *control_type;
@@ -133,6 +134,7 @@ struct rapl_if_priv {
 	int (*read_raw)(int cpu, struct reg_action *ra);
 	int (*write_raw)(int cpu, struct reg_action *ra);
 	void *defaults;
+	void *rpi;
 };
 
 /* maximum rapl package domain name: package-%d-die-%d */
-- 
2.39.5


