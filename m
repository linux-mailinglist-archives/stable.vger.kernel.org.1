Return-Path: <stable+bounces-194822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A36D2C5F30A
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 21:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95A2F4E15AE
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 20:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B716342CBA;
	Fri, 14 Nov 2025 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qNKaygui";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="soYgQqS5"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AD02DC78E;
	Fri, 14 Nov 2025 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763151211; cv=none; b=p2KhctNBfPqfoOg2VpLPguyOyNH9dT9G4fjjcHBZawTcsefZvhs84Xm85ixYu5qdJif9ROWloepeoQpTWdFHL/KGVXWAb9lgj3IskCCaZadbcjvrKX1omUiy7BvUDEGUKeqoo6bpxQcMyGzrIULVU6PNjhBZ8V/w4G84nwvizEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763151211; c=relaxed/simple;
	bh=GC7zogF5cd1VloXmU2AbQOqL7X1Llw55bSZZzQy0czU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=oSxqN0HGAFB+osuiasXfx7i6bpNwl7Df+DqiOfBffxUZvKwixwbedhHj/F9r/GVI7/ib4qckr2C/H8I1cIg+ILXyZiF2l1R7I3+v2Ie9YRwCZxoMwGw48oBFhP6MeNFwJXycOiTd48xJymsPJcRm6w3F1TLZeQanLqdmCUjuqnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qNKaygui; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=soYgQqS5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 20:13:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763151207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=FYDM7mtqZUPI7/sKPJPQfbQf5ts+wlR06a/MOj1T46M=;
	b=qNKayguiDjn6lZrrLopLFvk04KMCy583GHG7Opb47ln5hwOoa0M1rHmwL1OGGyZ4Y2N2hG
	lgv2c6CsFBOPHuqa63vOtrcW7IYgvXiGbzUY0lE2w0JUyH1NicAP7JTcVXhkhFIM8slWr6
	oveB/J6YJOpddrqly/ZvBePes8Ea2STV8m/PzQObVXGCZEzXtW9z0YARbQsDWsNwLdr4u0
	iaHo1cwErCoZqwrd1uZtnLyBCP5KRz8CwvgecmSnuMzvp9Lk+r+wI8ncZsi8DDmA+QjTFu
	h4EaT29Yd/fKNIjhp/o3hPAIHz2aVYPf3s7rJ+1sruMPAKZU/H8UUzlueA9eiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763151207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=FYDM7mtqZUPI7/sKPJPQfbQf5ts+wlR06a/MOj1T46M=;
	b=soYgQqS5TPQC/SetHiCyVfvcz8cGCNsRq8TPWp39N9ZA8WFkdUFI9CzhUTcXah/W6x96dU
	Ci4NrY7JQc+DjFDQ==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/acpi/boot: Correct acpi_is_processor_usable() check again
Cc: Michal Pecio <michal.pecio@gmail.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176315120547.498.15916722133977289071.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     1c7ac68c05bc0327d725dd10aa05f5120f868250
Gitweb:        https://git.kernel.org/tip/1c7ac68c05bc0327d725dd10aa05f5120f8=
68250
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 11 Nov 2025 14:53:57=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 14 Nov 2025 21:00:26 +01:00

x86/acpi/boot: Correct acpi_is_processor_usable() check again

ACPI v6.3 defined a new "Online Capable" MADT LAPIC flag. This bit is
used in conjunction with the "Enabled" MADT LAPIC flag to determine if
a CPU can be enabled/hotplugged by the OS after boot.

Before the new bit was defined, the "Enabled" bit was explicitly
described like this (ACPI v6.0 wording provided):

  "If zero, this processor is unusable, and the operating system
  support will not attempt to use it"

This means that CPU hotplug (based on MADT) is not possible. Many BIOS
implementations follow this guidance. They may include LAPIC entries in
MADT for unavailable CPUs, but since these entries are marked with
"Enabled=3D0" it is expected that the OS will completely ignore these
entries.

However, QEMU will do the same (include entries with "Enabled=3D0") for
the purpose of allowing CPU hotplug within the guest.

Comment from QEMU function pc_madt_cpu_entry():

  /* ACPI spec says that LAPIC entry for non present
   * CPU may be omitted from MADT or it must be marked
   * as disabled. However omitting non present CPU from
   * MADT breaks hotplug on linux. So possible CPUs
   * should be put in MADT but kept disabled.
   */

Recent Linux topology changes broke the QEMU use case. A following fix
for the QEMU use case broke bare metal topology enumeration.

Rework the Linux MADT LAPIC flags check to allow the QEMU use case only
for guests and to maintain the ACPI spec behavior for bare metal.

Remove an unnecessary check added to fix a bare metal case introduced by
the QEMU "fix".

  [ bp: Change logic as Michal suggested. ]

Fixes: fed8d8773b8e ("x86/acpi/boot: Correct acpi_is_processor_usable() check=
")
Fixes: f0551af02130 ("x86/topology: Ignore non-present APIC IDs in a present =
package")
Closes: https://lore.kernel.org/r/20251024204658.3da9bf3f.michal.pecio@gmail.=
com
Reported-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Tested-by: Michal Pecio <michal.pecio@gmail.com>
Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20251111145357.4031846-1-yazen.ghannam@amd.com
---
 arch/x86/kernel/acpi/boot.c    | 12 ++++++++----
 arch/x86/kernel/cpu/topology.c | 15 ---------------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 9fa321a..d6138b2 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -35,6 +35,7 @@
 #include <asm/smp.h>
 #include <asm/i8259.h>
 #include <asm/setup.h>
+#include <asm/hypervisor.h>
=20
 #include "sleep.h" /* To include x86_acpi_suspend_lowlevel */
 static int __initdata acpi_force =3D 0;
@@ -164,11 +165,14 @@ static bool __init acpi_is_processor_usable(u32 lapic_f=
lags)
 	if (lapic_flags & ACPI_MADT_ENABLED)
 		return true;
=20
-	if (!acpi_support_online_capable ||
-	    (lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
-		return true;
+	if (acpi_support_online_capable)
+		return lapic_flags & ACPI_MADT_ONLINE_CAPABLE;
=20
-	return false;
+	/*
+	 * QEMU expects legacy "Enabled=3D0" LAPIC entries to be counted as usable
+	 * in order to support CPU hotplug in guests.
+	 */
+	return !hypervisor_is_type(X86_HYPER_NATIVE);
 }
=20
 static int __init
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 6073a16..425404e 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -27,7 +27,6 @@
 #include <xen/xen.h>
=20
 #include <asm/apic.h>
-#include <asm/hypervisor.h>
 #include <asm/io_apic.h>
 #include <asm/mpspec.h>
 #include <asm/msr.h>
@@ -240,20 +239,6 @@ static __init void topo_register_apic(u32 apic_id, u32 a=
cpi_id, bool present)
 		cpuid_to_apicid[cpu] =3D apic_id;
 		topo_set_cpuids(cpu, apic_id, acpi_id);
 	} else {
-		u32 pkgid =3D topo_apicid(apic_id, TOPO_PKG_DOMAIN);
-
-		/*
-		 * Check for present APICs in the same package when running
-		 * on bare metal. Allow the bogosity in a guest.
-		 */
-		if (hypervisor_is_type(X86_HYPER_NATIVE) &&
-		    topo_unit_count(pkgid, TOPO_PKG_DOMAIN, phys_cpu_present_map)) {
-			pr_info_once("Ignoring hot-pluggable APIC ID %x in present package.\n",
-				     apic_id);
-			topo_info.nr_rejected_cpus++;
-			return;
-		}
-
 		topo_info.nr_disabled_cpus++;
 	}
=20

