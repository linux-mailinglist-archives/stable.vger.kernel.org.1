Return-Path: <stable+bounces-172809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D11B33987
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 10:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E431899DEC
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 08:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F259B28B7DA;
	Mon, 25 Aug 2025 08:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="H879jBmw"
X-Original-To: stable@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F04B2737FC
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110908; cv=none; b=Nba6JSq3ZjIsly1RhtM/bcYEViour1jbEEP/kjvh3yU18F+YLBZAndgBC1sh2zEcb4IZzxfo+L9Z2lRU/9Bq77PCq12Qlb5Z9e/oVbGez4QyjIsaY/5ZvYaO+plm1rGNB4fUdGV+iRjtKWGJ7+yLBpHVwkj1GAKgM+XEB2kNwYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110908; c=relaxed/simple;
	bh=ABYGEiEnQV5EkJYNuVVUds0AHxrXowezYYQAKmwdyvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cin2xAtK8QgPlExDEKZsYEPJXOUZzZTB6WSCggnCqUqoY4Zel66Wp0VZd2gTY/I8dNJiBec43u5E3zJ+7jXEtsjIt5pVvQXBM2C8js4IyiehuSRlAf6BIkOVYvhVkNZPGmldxJxVcMABh7nm3ITHv51cSSsatPS6gggiv7Ip2ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=H879jBmw; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756110904; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=K1NFs4hqkUfNERen8q+TQY0cRH5WARIu2GqUBfQABnQ=;
	b=H879jBmwaYEZOglKH59qemcVPBZ+QqupY/8T2eAuL0FSU70DSKX/sbloy+Lvsh8Iey2vH4g+sJc6qSAf0Utb6kcu5LwWcnXfp2Biwui3WtCtWKfUUEkvbdl7s41PTneuE+BFcF2Q4E5ki8xsRknoOzFuHUopNrwODwteyV+Disg=
Received: from x31l07246.sqa.na131.tbsite.net(mailfrom:tongweilin@linux.alibaba.com fp:SMTPD_---0WmTrBr0_1756110894 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 25 Aug 2025 16:35:03 +0800
From: Weilin Tong <tongweilin@linux.alibaba.com>
To: tongweilin@linux.alibaba.com
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	"6 . 8+" <stable@vger.kernel.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Yingbao Jia <yingbao.jia@intel.com>,
	Artie Ding <artie.ding@linux.alibaba.com>
Subject: [PATCH] intel_idle: fix ACPI _CST matching for newer Xeon platforms
Date: Mon, 25 Aug 2025 16:34:51 +0800
Message-ID: <20250825083451.1528820-1-tongweilin@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

ANBZ: #11599

commit 4c411cca33cf1c21946b710b2eb59aca9f646703 upstream.

Background
~~~~~~~~~~

The driver uses 'use_acpi = true' in C-state custom table for all Xeon
platforms. The meaning of this flag is as follows.

 1. If a C-state from the custom table is defined in ACPI _CST (matched
    by the mwait hint), then enable this C-state.

 2. Otherwise, disable this C-state, unless the C-sate definition in the
    custom table has the 'CPUIDLE_FLAG_ALWAYS_ENABLE' flag set, in which
    case enabled it.

The goal is to honor BIOS C6 settings - If BIOS disables C6, disable it
by default in the OS too (but it can be enabled via sysfs).

This works well on Xeons that expose only one flavor of C6. This are all
Xeons except for the newest Granite Rapids (GNR) and Sierra Forest (SRF).

The problem
~~~~~~~~~~~

GNR and SRF have 2 flavors of C6: C6/C6P on GNR, C6S/C6SP on SRF. The
the "P" flavor allows for the package C6, while the "non-P" flavor
allows only for core/module C6.

As far as this patch is concerned, both GNR and SRF platforms are
handled the same way. Therefore, further discussion is focused on GNR,
but it applies to SRF as well.

On Intel Xeon platforms, BIOS exposes only 2 ACPI C-states: C1 and C2.
Well, depending on BIOS settings, C2 may be named as C3. But there still
will be only 2 states - C1 and C3. But this is a non-essential detail,
so further discussion is focused on the ACPI C1 and C2 case.

On pre-GNR/SRF Xeon platforms, ACPI C1 is mapped to C1 or C1E, and ACPI
C2 is mapped to C6. The 'use_acpi' flag works just fine:

 * If ACPI C2 enabled, enable C6.
 * Otherwise, disable C6.

However, on GNR there are 2 flavors of C6, so BIOS maps ACPI C2 to
either C6 or C6P, depending on the user settings. As a result, due to
the 'use_acpi' flag, 'intel_idle' disables least one of the C6 flavors.

BIOS                   | OS                         | Verdict
----------------------------------------------------|---------
ACPI C2 disabled       | C6 disabled, C6P disabled  | OK
ACPI C2 mapped to C6   | C6 enabled,  C6P disabled  | Not OK
ACPI C2 mapped to C6P  | C6 disabled, C6P enabled   | Not OK

The goal of 'use_acpi' is to honor BIOS ACPI C2 disabled case, which
works fine. But if ACPI C2 is enabled, the goal is to enable all flavors
of C6, not just one of the flavors. This was overlooked when enabling
GNR/SRF platforms.

In other words, before GNR/SRF, the ACPI C2 status was binary - enabled
or disabled. But it is not binary on GNR/SRF, however the goal is to
continue treat it as binary.

The fix
~~~~~~~

Notice, that current algorithm matches ACPI and custom table C-states
by the mwait hint. However, mwait hint consists of the 'state' and
'sub-state' parts, and all C6 flavors have the same state value of 0x20,
but different sub-state values.

Introduce new C-state table flag - CPUIDLE_FLAG_PARTIAL_HINT_MATCH and
add it to both C6 flavors of the GNR/SRF platforms.

When matching ACPI _CST and custom table C-states, match only the start
part if the C-state has CPUIDLE_FLAG_PARTIAL_HINT_MATCH, other wise
match both state and sub-state parts (as before).

With this fix, GNR C-states enabled/disabled status looks like this.

BIOS                   | OS
----------------------------------------------------
ACPI C2 disabled       | C6 disabled, C6P disabled
ACPI C2 mapped to C6   | C6 enabled, C6P enabled
ACPI C2 mapped to C6P  | C6 enabled, C6P enabled

Possible alternative
~~~~~~~~~~~~~~~~~~~~

The alternative would be to remove 'use_acpi' flag for GNR and SRF.
This would be a simpler solution, but it would violate the principle of
least surprise - users of Xeon platforms are used to the fact that
intel_idle honors C6 enabled/disabled flag. It is more consistent user
experience if GNR/SRF continue doing so.

How tested
~~~~~~~~~~

Tested on GNR and SRF platform with all the 3 BIOS configurations: ACPI
C2 disabled, mapped to C6/C6S, mapped to C6P/C6SP.

Tested on Ice lake Xeon and Sapphire Rapids Xeon platforms with ACPI C2
enabled and disabled, just to verify that the patch does not break older
Xeons.

Intel-SIG: Intel-SIG: commit 4c411cca33cf intel_idle: fix ACPI _CST matching for newer Xeon platforms.
Backport intel_idle GNR and SRF fix

Fixes: 92813fd5b156 ("intel_idle: add Sierra Forest SoC support")
Fixes: 370406bf5738 ("intel_idle: add Granite Rapids Xeon support")
Cc: 6.8+ <stable@vger.kernel.org> # 6.8+
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Link: https://patch.msgid.link/20240913165143.4140073-1-dedekind1@gmail.com
[ rjw: Changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[ Yingbao Jia: amend commit log ]
Signed-off-by: Yingbao Jia <yingbao.jia@intel.com>
Reviewed-by: Artie Ding <artie.ding@linux.alibaba.com>
Link: https://gitee.com/anolis/cloud-kernel/pulls/4057
---
 drivers/idle/intel_idle.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 3f216160f19c..783545ff98af 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -120,6 +120,12 @@ static unsigned int mwait_substates __initdata;
  */
 #define CPUIDLE_FLAG_INIT_XSTATE	BIT(17)
 
+/*
+ * Ignore the sub-state when matching mwait hints between the ACPI _CST and
+ * custom tables.
+ */
+#define CPUIDLE_FLAG_PARTIAL_HINT_MATCH	BIT(18)
+
 /*
  * MWAIT takes an 8-bit "hint" in EAX "suggesting"
  * the C-state (top nibble) and sub-state (bottom nibble)
@@ -880,7 +886,8 @@ static struct cpuidle_state gnr_cstates[] __initdata = {
 		.name = "C6",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED |
-					   CPUIDLE_FLAG_INIT_XSTATE,
+					   CPUIDLE_FLAG_INIT_XSTATE |
+					   CPUIDLE_FLAG_PARTIAL_HINT_MATCH,
 		.exit_latency = 170,
 		.target_residency = 650,
 		.enter = &intel_idle,
@@ -889,7 +896,8 @@ static struct cpuidle_state gnr_cstates[] __initdata = {
 		.name = "C6P",
 		.desc = "MWAIT 0x21",
 		.flags = MWAIT2flg(0x21) | CPUIDLE_FLAG_TLB_FLUSHED |
-					   CPUIDLE_FLAG_INIT_XSTATE,
+					   CPUIDLE_FLAG_INIT_XSTATE |
+					   CPUIDLE_FLAG_PARTIAL_HINT_MATCH,
 		.exit_latency = 210,
 		.target_residency = 1000,
 		.enter = &intel_idle,
@@ -1162,7 +1170,8 @@ static struct cpuidle_state srf_cstates[] __initdata = {
 	{
 		.name = "C6S",
 		.desc = "MWAIT 0x22",
-		.flags = MWAIT2flg(0x22) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.flags = MWAIT2flg(0x22) | CPUIDLE_FLAG_TLB_FLUSHED |
+					   CPUIDLE_FLAG_PARTIAL_HINT_MATCH,
 		.exit_latency = 270,
 		.target_residency = 700,
 		.enter = &intel_idle,
@@ -1170,7 +1179,8 @@ static struct cpuidle_state srf_cstates[] __initdata = {
 	{
 		.name = "C6SP",
 		.desc = "MWAIT 0x23",
-		.flags = MWAIT2flg(0x23) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.flags = MWAIT2flg(0x23) | CPUIDLE_FLAG_TLB_FLUSHED |
+					   CPUIDLE_FLAG_PARTIAL_HINT_MATCH,
 		.exit_latency = 310,
 		.target_residency = 900,
 		.enter = &intel_idle,
@@ -1519,7 +1529,7 @@ static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
 	}
 }
 
-static bool __init intel_idle_off_by_default(u32 mwait_hint)
+static bool __init intel_idle_off_by_default(unsigned int flags, u32 mwait_hint)
 {
 	int cstate, limit;
 
@@ -1536,7 +1546,15 @@ static bool __init intel_idle_off_by_default(u32 mwait_hint)
 	 * the interesting states are ACPI_CSTATE_FFH.
 	 */
 	for (cstate = 1; cstate < limit; cstate++) {
-		if (acpi_state_table.states[cstate].address == mwait_hint)
+		u32 acpi_hint = acpi_state_table.states[cstate].address;
+		u32 table_hint = mwait_hint;
+
+		if (flags & CPUIDLE_FLAG_PARTIAL_HINT_MATCH) {
+			acpi_hint &= ~MWAIT_SUBSTATE_MASK;
+			table_hint &= ~MWAIT_SUBSTATE_MASK;
+		}
+
+		if (acpi_hint == table_hint)
 			return false;
 	}
 	return true;
@@ -1546,7 +1564,10 @@ static bool __init intel_idle_off_by_default(u32 mwait_hint)
 
 static inline bool intel_idle_acpi_cst_extract(void) { return false; }
 static inline void intel_idle_init_cstates_acpi(struct cpuidle_driver *drv) { }
-static inline bool intel_idle_off_by_default(u32 mwait_hint) { return false; }
+static inline bool intel_idle_off_by_default(unsigned int flags, u32 mwait_hint)
+{
+	return false;
+}
 #endif /* !CONFIG_ACPI_PROCESSOR_CSTATE */
 
 /**
@@ -1833,7 +1854,7 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 
 		if ((disabled_states_mask & BIT(drv->state_count)) ||
 		    ((icpu->use_acpi || force_use_acpi) &&
-		     intel_idle_off_by_default(mwait_hint) &&
+		     intel_idle_off_by_default(state->flags, mwait_hint) &&
 		     !(state->flags & CPUIDLE_FLAG_ALWAYS_ENABLE)))
 			state->flags |= CPUIDLE_FLAG_OFF;
 
-- 
2.43.5


