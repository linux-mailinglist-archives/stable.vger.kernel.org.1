Return-Path: <stable+bounces-45508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D2B8CAED0
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 15:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA85EB220E5
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 13:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BF174C1B;
	Tue, 21 May 2024 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RWVVMyNZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jzOG9bhU"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F331E48B;
	Tue, 21 May 2024 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296657; cv=none; b=g4buZS8OLXpmMKScUWW5vqIpYkXXeRcvZo12XI/0xZLqjTRjTS32zJK7gboycIV6mPb9JQ+fyHMCY9LwGFx4yB07+BULzlZ9Aejcsf03aZHJUuzFnGoJBiIYkF9Bm0ex/pMEXFvY8LTAuzdn3tKI8nRh0Ssex+VROB29fj7mVCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296657; c=relaxed/simple;
	bh=vwHfsvgjzbLzRecVm6LdMSMEjNnboRxXPQyX6cIb1/E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Y1XM0wY/eoPZlq9MVvX3BoTeG2Fqpe4LsHAmT0b7tmbxgjh9sL8XL2fXCJUm2+aY5L9K1BGV5IJrkceJzJcOyAluOgWvFHv0/VCDspQwH7ODB3cJZg149hWhA51/92gYyJD75o9VACrscH6ZXuF27LDms9kQG29JtenMO6rtPOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RWVVMyNZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jzOG9bhU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 21 May 2024 13:04:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716296652;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=beGMZHUSz3A0CZk48/UyRVR7jbhwRb/Z/9EOHk+yFjA=;
	b=RWVVMyNZwGoYBC4BUJpVIppk4LKHdGHX0y8FR5NpCiPI7/cDokNlfsN14eP8NLIIShayVL
	UfCNVEAbOEIKTjM0QhNfhMT9d5Px8aH0fbTEIYigoNqv4KjlIjWN0fj+cyywF4nht4s9ja
	KRytyEPY9KTTAiJgG91D3jBHDr41lkIWW0wVzN6d/1Cp447PTtTpz8ZuGIxIwm2llT8Ts+
	FF2Zl/48+Y2gMTK0dUPck3gkYmP3/t02W7AfC6h5K0u2iDE+iQQb6n3Rd/AL0G+RUl6CWo
	hQWr2Jjjh5GfUNv6f8GzA7ZF8i2z/KtGLHFTrQhZZLfKAjFUjuMC6iINN2h0lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716296652;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=beGMZHUSz3A0CZk48/UyRVR7jbhwRb/Z/9EOHk+yFjA=;
	b=jzOG9bhULiE+sD2kJq061YIevFE9R2xBckwGc96LotpFdmU0pj8yjsH8oCc8nvHQG3An5d
	WeiEpJz4Yh7eKEBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/topology: Handle bogus ACPI tables correctly
Cc: Carsten Tolkmit <ctolkmit@ennit.de>, Thomas Gleixner <tglx@linutronix.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87le48jycb.ffs@tglx>
References: <87le48jycb.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171629665158.10875.17651940971003547815.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     9d22c96316ac59ed38e80920c698fed38717b91b
Gitweb:        https://git.kernel.org/tip/9d22c96316ac59ed38e80920c698fed38717b91b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 17 May 2024 16:40:36 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 21 May 2024 14:52:35 +02:00

x86/topology: Handle bogus ACPI tables correctly

The ACPI specification clearly states how the processors should be
enumerated in the MADT:

 "To ensure that the boot processor is supported post initialization,
  two guidelines should be followed. The first is that OSPM should
  initialize processors in the order that they appear in the MADT. The
  second is that platform firmware should list the boot processor as the
  first processor entry in the MADT.
  ...
  Failure of OSPM implementations and platform firmware to abide by
  these guidelines can result in both unpredictable and non optimal
  platform operation."

The kernel relies on that ordering to detect the real BSP on crash kernels
which is important to avoid sending a INIT IPI to it as that would cause a
full machine reset.

On a Dell XPS 16 9640 the BIOS ignores this rule and enumerates the CPUs in
the wrong order. As a consequence the kernel falsely detects a crash kernel
and disables the corresponding CPU.

Prevent this by checking the IA32_APICBASE MSR for the BSP bit on the boot
CPU. If that bit is set, then the MADT based BSP detection can be safely
ignored. If the kernel detects a mismatch between the BSP bit and the first
enumerated MADT entry then emit a firmware bug message.

This obviously also has to be taken into account when the boot APIC ID and
the first enumerated APIC ID match. If the boot CPU does not have the BSP
bit set in the APICBASE MSR then there is no way for the boot CPU to
determine which of the CPUs is the real BSP. Sending an INIT to the real
BSP would reset the machine so the only sane way to deal with that is to
limit the number of CPUs to one and emit a corresponding warning message.

Fixes: 5c5682b9f87a ("x86/cpu: Detect real BSP on crash kernels")
Reported-by: Carsten Tolkmit <ctolkmit@ennit.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Carsten Tolkmit <ctolkmit@ennit.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/87le48jycb.ffs@tglx
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218837
---
 arch/x86/kernel/cpu/topology.c | 53 +++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index d17c9b7..621a151 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -128,6 +128,9 @@ static void topo_set_cpuids(unsigned int cpu, u32 apic_id, u32 acpi_id)
 
 static __init bool check_for_real_bsp(u32 apic_id)
 {
+	bool is_bsp = false, has_apic_base = boot_cpu_data.x86 >= 6;
+	u64 msr;
+
 	/*
 	 * There is no real good way to detect whether this a kdump()
 	 * kernel, but except on the Voyager SMP monstrosity which is not
@@ -144,17 +147,61 @@ static __init bool check_for_real_bsp(u32 apic_id)
 	if (topo_info.real_bsp_apic_id != BAD_APICID)
 		return false;
 
+	/*
+	 * Check whether the enumeration order is broken by evaluating the
+	 * BSP bit in the APICBASE MSR. If the CPU does not have the
+	 * APICBASE MSR then the BSP detection is not possible and the
+	 * kernel must rely on the firmware enumeration order.
+	 */
+	if (has_apic_base) {
+		rdmsrl(MSR_IA32_APICBASE, msr);
+		is_bsp = !!(msr & MSR_IA32_APICBASE_BSP);
+	}
+
 	if (apic_id == topo_info.boot_cpu_apic_id) {
-		topo_info.real_bsp_apic_id = apic_id;
-		return false;
+		/*
+		 * If the boot CPU has the APIC BSP bit set then the
+		 * firmware enumeration is agreeing. If the CPU does not
+		 * have the APICBASE MSR then the only choice is to trust
+		 * the enumeration order.
+		 */
+		if (is_bsp || !has_apic_base) {
+			topo_info.real_bsp_apic_id = apic_id;
+			return false;
+		}
+		/*
+		 * If the boot APIC is enumerated first, but the APICBASE
+		 * MSR does not have the BSP bit set, then there is no way
+		 * to discover the real BSP here. Assume a crash kernel and
+		 * limit the number of CPUs to 1 as an INIT to the real BSP
+		 * would reset the machine.
+		 */
+		pr_warn("Enumerated BSP APIC %x is not marked in APICBASE MSR\n", apic_id);
+		pr_warn("Assuming crash kernel. Limiting to one CPU to prevent machine INIT\n");
+		set_nr_cpu_ids(1);
+		goto fwbug;
 	}
 
-	pr_warn("Boot CPU APIC ID not the first enumerated APIC ID: %x > %x\n",
+	pr_warn("Boot CPU APIC ID not the first enumerated APIC ID: %x != %x\n",
 		topo_info.boot_cpu_apic_id, apic_id);
+
+	if (is_bsp) {
+		/*
+		 * The boot CPU has the APIC BSP bit set. Use it and complain
+		 * about the broken firmware enumeration.
+		 */
+		topo_info.real_bsp_apic_id = topo_info.boot_cpu_apic_id;
+		goto fwbug;
+	}
+
 	pr_warn("Crash kernel detected. Disabling real BSP to prevent machine INIT\n");
 
 	topo_info.real_bsp_apic_id = apic_id;
 	return true;
+
+fwbug:
+	pr_warn(FW_BUG "APIC enumeration order not specification compliant\n");
+	return false;
 }
 
 static unsigned int topo_unit_count(u32 lvlid, enum x86_topology_domains at_level,

