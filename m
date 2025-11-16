Return-Path: <stable+bounces-194887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D27E1C61C16
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 21:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 628D93557A0
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 20:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2E425A33A;
	Sun, 16 Nov 2025 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="waUvOs0M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xRoKJyvC"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51E63B7A8;
	Sun, 16 Nov 2025 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763323367; cv=none; b=odOOqVzpR6rRa73Oz5C/z4SpXycz1QTOFS1rDd0FBohHWT4K8yO19w+n0hrRHRh0lgkf071n3mtMmsJOs/1sq1QdRy4h8LD00gSmVSOMPwPningmdQtVusri+gEUEtxnTHVp7PDttMyLLAfof3Me29DdotZENI7CJGH2pWU8+QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763323367; c=relaxed/simple;
	bh=sJWPLYu71bYKZKWZ6uHsEI4Gk/E+Abnm11ws5i8Ycq8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=oDjiZVy7zvIk+AU5007W6G6fKdTdLlRFunfCDz9ELN9an3UHh4/j2NwvJ724oSDC0tvgpbNLJeHxU/Q/KT73JBYhEtqBW0HzUm2vc+/a4m2hR+5BtOv9dlCAfYNbsIVup8vb8kYXjNhRxjTu9xHxW2vke5KGn7n+kxW3LWy6TUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=waUvOs0M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xRoKJyvC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 16 Nov 2025 20:02:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763323363;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=UK3zXOA9hV2AlKaXzz0D8TijsIIjGfBtuIgvEAyYVC4=;
	b=waUvOs0MWbtUPMLMaha9K1I6qB4d8fwi1tpvs47ZfuN64qBh+YYRV5KCBy433myieQBJPB
	YjtoSYQazW7o7EfONWPskD7TGXMMtJRUBJBhzxKK201wbqdK1PujYkgeG6EtzRWrBNffjm
	7/NHII38i5wRNv071uU4bvgNi0ejpIxEDkwwh3Kl/byU1bUS2OJfoKPiHaRy8HbLWaNhVx
	bCwGP8aNTGddxaE15gRgxz0v8XaMhtalso6EEN4qJvTmYfF+Cig/I+v9yeYqY9zzjjJP2i
	fkVNRcA2HPk81kocGBCLDzhLhPIX5PrV973b5sA1N38eK+7batN4XzZzJNCVZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763323363;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=UK3zXOA9hV2AlKaXzz0D8TijsIIjGfBtuIgvEAyYVC4=;
	b=xRoKJyvCyLMD5sW08ikDlRq6EZ/zJx2+apy+DSRhpqDSVSqXqh1B5LshLsF4oFsg0S4YBq
	csATnvLU1sp0FYCg==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/acpi/boot: Correct acpi_is_processor_usable() check again
Cc: Michal Pecio <michal.pecio@gmail.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176332335363.498.13711756532958271983.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     845ed7e04d9ae0146d5e003a5defd90eb95535fc
Gitweb:        https://git.kernel.org/tip/845ed7e04d9ae0146d5e003a5defd90eb95=
535fc
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 11 Nov 2025 14:53:57=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 16 Nov 2025 21:00:02 +01:00

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
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
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

