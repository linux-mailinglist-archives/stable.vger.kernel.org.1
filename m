Return-Path: <stable+bounces-77420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5BD985D13
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 748DA2818FC
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393B61D9335;
	Wed, 25 Sep 2024 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tc+VMhG9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4B21D9321;
	Wed, 25 Sep 2024 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265702; cv=none; b=YyVgWY6XR2o1Ba+8kHcLfkJ48WhxjkF/XS4/pP1F7dAHMzD69LSleQ7JKLSkxraLZ6cRML0JLP7WeILXA0008e+reI0mEs7t1cL6gxJQtANhkkoXuYSpNsTPn5d5lc5nLu1eliel+DMltahgsJjoz/jU+vkIAz4VQUZGT6BzG1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265702; c=relaxed/simple;
	bh=jp5RwJPG4dX6LvwrpYrkupTj/D0RLYc9evHQDiYRWwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJ7y+1QqXLrNmhHd/sTTPWYCF82WwC2RZBUR/LNa1XjUljcB3FKqNpQZeHRcL/pLETBy8K1+Pozb5O11KrvPHOsw7RTzIIWLJqQyyMogkQIdP9fxmnTz1nG6EbIYxzR0q5J773k8CbnucC0U8K/mqsPkPt6XE6mfIrUYHgCYpgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tc+VMhG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94D3C4CEC3;
	Wed, 25 Sep 2024 12:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265701;
	bh=jp5RwJPG4dX6LvwrpYrkupTj/D0RLYc9evHQDiYRWwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tc+VMhG9WyO7UqtZw6XAbtJNbzI423x6BFDup3XwZPqjhEgSabbOk5+2dAYFnjKIC
	 bk+r7ANWhxK6eiDOHOyzITKckZiLTJrAsQEC+dXaifAYxtgPksQ9wP92v22LFsSBU+
	 MKfVTERyGhKtM7Zx8ZBBnmhhyYbBlkX+k21GK0gzUrhMLy4UlyRr7qY1JmMdGiYCye
	 JUN1VD2gzgvbPCBMwZlj2VHdWlyWhgl9qXwbTuaz6RwEyVlH0OBq8D/kX3aJ4mWRbh
	 GSSrJ9xbrCPBHjEDhMFkYQ4zXgpKEySu5Tm4D3Z5A6KJDN5Vye2asDKREY1xBidILB
	 LsWAQArmK7qzQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Rob Newcater <rob@durendal.co.uk>,
	Christian Heusel <christian@heusel.eu>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	peterz@infradead.org,
	arjan@linux.intel.com,
	jacob.jun.pan@linux.intel.com,
	andrew.cooper3@citrix.com
Subject: [PATCH AUTOSEL 6.10 075/197] x86/apic: Remove logical destination mode for 64-bit
Date: Wed, 25 Sep 2024 07:51:34 -0400
Message-ID: <20240925115823.1303019-75-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 838ba7733e4e3a94a928e8d0a058de1811a58621 ]

Logical destination mode of the local APIC is used for systems with up to
8 CPUs. It has an advantage over physical destination mode as it allows to
target multiple CPUs at once with IPIs.

That advantage was definitely worth it when systems with up to 8 CPUs
were state of the art for servers and workstations, but that's history.

Aside of that there are systems which fail to work with logical destination
mode as the ACPI/DMI quirks show and there are AMD Zen1 systems out there
which fail when interrupt remapping is enabled as reported by Rob and
Christian. The latter problem can be cured by firmware updates, but not all
OEMs distribute the required changes.

Physical destination mode is guaranteed to work because it is the only way
to get a CPU up and running via the INIT/INIT/STARTUP sequence.

As the number of CPUs keeps increasing, logical destination mode becomes a
less used code path so there is no real good reason to keep it around.

Therefore remove logical destination mode support for 64-bit and default to
physical destination mode.

Reported-by: Rob Newcater <rob@durendal.co.uk>
Reported-by: Christian Heusel <christian@heusel.eu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Rob Newcater <rob@durendal.co.uk>
Link: https://lore.kernel.org/all/877cd5u671.ffs@tglx
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/apic.h         |   8 --
 arch/x86/kernel/apic/apic_flat_64.c | 119 ++--------------------------
 2 files changed, 7 insertions(+), 120 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 9327eb00e96d0..be2045a18e69b 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -345,20 +345,12 @@ extern struct apic *apic;
  * APIC drivers are probed based on how they are listed in the .apicdrivers
  * section. So the order is important and enforced by the ordering
  * of different apic driver files in the Makefile.
- *
- * For the files having two apic drivers, we use apic_drivers()
- * to enforce the order with in them.
  */
 #define apic_driver(sym)					\
 	static const struct apic *__apicdrivers_##sym __used		\
 	__aligned(sizeof(struct apic *))			\
 	__section(".apicdrivers") = { &sym }
 
-#define apic_drivers(sym1, sym2)					\
-	static struct apic *__apicdrivers_##sym1##sym2[2] __used	\
-	__aligned(sizeof(struct apic *))				\
-	__section(".apicdrivers") = { &sym1, &sym2 }
-
 extern struct apic *__apicdrivers[], *__apicdrivers_end[];
 
 /*
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index f37ad3392fec9..e0308d8c4e6c2 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -8,129 +8,25 @@
  * Martin Bligh, Andi Kleen, James Bottomley, John Stultz, and
  * James Cleverdon.
  */
-#include <linux/cpumask.h>
 #include <linux/export.h>
-#include <linux/acpi.h>
 
-#include <asm/jailhouse_para.h>
 #include <asm/apic.h>
 
 #include "local.h"
 
-static struct apic apic_physflat;
-static struct apic apic_flat;
-
-struct apic *apic __ro_after_init = &apic_flat;
-EXPORT_SYMBOL_GPL(apic);
-
-static int flat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
-{
-	return 1;
-}
-
-static void _flat_send_IPI_mask(unsigned long mask, int vector)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	__default_send_IPI_dest_field(mask, vector, APIC_DEST_LOGICAL);
-	local_irq_restore(flags);
-}
-
-static void flat_send_IPI_mask(const struct cpumask *cpumask, int vector)
-{
-	unsigned long mask = cpumask_bits(cpumask)[0];
-
-	_flat_send_IPI_mask(mask, vector);
-}
-
-static void
-flat_send_IPI_mask_allbutself(const struct cpumask *cpumask, int vector)
-{
-	unsigned long mask = cpumask_bits(cpumask)[0];
-	int cpu = smp_processor_id();
-
-	if (cpu < BITS_PER_LONG)
-		__clear_bit(cpu, &mask);
-
-	_flat_send_IPI_mask(mask, vector);
-}
-
-static u32 flat_get_apic_id(u32 x)
+static u32 physflat_get_apic_id(u32 x)
 {
 	return (x >> 24) & 0xFF;
 }
 
-static int flat_probe(void)
+static int physflat_probe(void)
 {
 	return 1;
 }
 
-static struct apic apic_flat __ro_after_init = {
-	.name				= "flat",
-	.probe				= flat_probe,
-	.acpi_madt_oem_check		= flat_acpi_madt_oem_check,
-
-	.dest_mode_logical		= true,
-
-	.disable_esr			= 0,
-
-	.init_apic_ldr			= default_init_apic_ldr,
-	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-
-	.max_apic_id			= 0xFE,
-	.get_apic_id			= flat_get_apic_id,
-
-	.calc_dest_apicid		= apic_flat_calc_apicid,
-
-	.send_IPI			= default_send_IPI_single,
-	.send_IPI_mask			= flat_send_IPI_mask,
-	.send_IPI_mask_allbutself	= flat_send_IPI_mask_allbutself,
-	.send_IPI_allbutself		= default_send_IPI_allbutself,
-	.send_IPI_all			= default_send_IPI_all,
-	.send_IPI_self			= default_send_IPI_self,
-	.nmi_to_offline_cpu		= true,
-
-	.read				= native_apic_mem_read,
-	.write				= native_apic_mem_write,
-	.eoi				= native_apic_mem_eoi,
-	.icr_read			= native_apic_icr_read,
-	.icr_write			= native_apic_icr_write,
-	.wait_icr_idle			= apic_mem_wait_icr_idle,
-	.safe_wait_icr_idle		= apic_mem_wait_icr_idle_timeout,
-};
-
-/*
- * Physflat mode is used when there are more than 8 CPUs on a system.
- * We cannot use logical delivery in this case because the mask
- * overflows, so use physical mode.
- */
 static int physflat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 {
-#ifdef CONFIG_ACPI
-	/*
-	 * Quirk: some x86_64 machines can only use physical APIC mode
-	 * regardless of how many processors are present (x86_64 ES7000
-	 * is an example).
-	 */
-	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID &&
-		(acpi_gbl_FADT.flags & ACPI_FADT_APIC_PHYSICAL)) {
-		printk(KERN_DEBUG "system APIC only can use physical flat");
-		return 1;
-	}
-
-	if (!strncmp(oem_id, "IBM", 3) && !strncmp(oem_table_id, "EXA", 3)) {
-		printk(KERN_DEBUG "IBM Summit detected, will use apic physical");
-		return 1;
-	}
-#endif
-
-	return 0;
-}
-
-static int physflat_probe(void)
-{
-	return apic == &apic_physflat || num_possible_cpus() > 8 || jailhouse_paravirt();
+	return 1;
 }
 
 static struct apic apic_physflat __ro_after_init = {
@@ -146,7 +42,7 @@ static struct apic apic_physflat __ro_after_init = {
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 
 	.max_apic_id			= 0xFE,
-	.get_apic_id			= flat_get_apic_id,
+	.get_apic_id			= physflat_get_apic_id,
 
 	.calc_dest_apicid		= apic_default_calc_apicid,
 
@@ -166,8 +62,7 @@ static struct apic apic_physflat __ro_after_init = {
 	.wait_icr_idle			= apic_mem_wait_icr_idle,
 	.safe_wait_icr_idle		= apic_mem_wait_icr_idle_timeout,
 };
+apic_driver(apic_physflat);
 
-/*
- * We need to check for physflat first, so this order is important.
- */
-apic_drivers(apic_physflat, apic_flat);
+struct apic *apic __ro_after_init = &apic_physflat;
+EXPORT_SYMBOL_GPL(apic);
-- 
2.43.0


