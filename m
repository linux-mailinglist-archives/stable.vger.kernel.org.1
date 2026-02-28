Return-Path: <stable+bounces-220583-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DmhBGM/o2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220583-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:17:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 675891C6CC3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1D583292914
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC5D3DF2C0;
	Sat, 28 Feb 2026 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxT1YWKP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC6D3DE166;
	Sat, 28 Feb 2026 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300465; cv=none; b=MkJILXwzapw9U171zxbC9h24NqmJfjhUhmi0/pPep0kMhuj4oH61niF0vJYg4owDt6x/NUC7MXiVncJY0IjW9izuipyf68i0ON8ohn6v6Fj6/izPmlqbpyQhbDA7YusJK3lJC+GT2nhcUWVelpxafb7zemGJ9qzhhcTPjR+KVgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300465; c=relaxed/simple;
	bh=VszvAGQGexyAPXulfykvBTiopVRWbgzyGHF2T03Iu68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svYjhNtrBdmgpjWy4t3EExwNsQn4Oyt74IlrqVBKJmBtEG9IpyRc51daztbawXOuJXXUvQkhGe/C2vMrdEeIsRadRg7cmbT9OotqwoZy1F6sBK2Adf8bbGiRdt+ANpMvHECJEkKNTgcHr/EDFTDLc7DZWD2IffWyzbpS+AJf7Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxT1YWKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8295C19425;
	Sat, 28 Feb 2026 17:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300465;
	bh=VszvAGQGexyAPXulfykvBTiopVRWbgzyGHF2T03Iu68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gxT1YWKPxatP8aT+MXaHrJc8XL8Rno9q6GcVZ90mkZ5wOkeCTwlvo9faVkgEgubhA
	 M5DwBSuPV94TAi1kMOkfZATum9rqaD8IgLQeugR4aes7DDll184HAigJ7PIRkR+3Vq
	 6DYYhGuqgl3vSUtLZvanD3f9voaaZWJSaVb6f9hJ43fBB9Z9eIdgD9sGFJiSzZ1yBf
	 tSGdslOuuRsuQoIggBccAfdRfJlyqKJLVSj2Hy7G7gGvcIc8HolmXAzpnNXJdgIZ+A
	 BoGAl+B7BvoHyzuf0G5PA/Z0g8vyZpk1op4c/XAB5DobLTXltAceWGhLj4B/2C9t/n
	 OWkwcFLYEg2rw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	Michal Pecio <michal.pecio@gmail.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 504/844] x86/acpi/boot: Correct acpi_is_processor_usable() check again
Date: Sat, 28 Feb 2026 12:26:57 -0500
Message-ID: <20260228173244.1509663-505-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,alien8.de,kernel.org,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220583-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,alien8.de:email]
X-Rspamd-Queue-Id: 675891C6CC3
X-Rspamd-Action: no action

From: Yazen Ghannam <yazen.ghannam@amd.com>

[ Upstream commit adbf61cc47cb72b102682e690ad323e1eda652c2 ]

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
"Enabled=0" it is expected that the OS will completely ignore these
entries.

However, QEMU will do the same (include entries with "Enabled=0") for
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
  [ mingo: Removed misapplied -stable tag. ]

Fixes: fed8d8773b8e ("x86/acpi/boot: Correct acpi_is_processor_usable() check")
Fixes: f0551af02130 ("x86/topology: Ignore non-present APIC IDs in a present package")
Closes: https://lore.kernel.org/r/20251024204658.3da9bf3f.michal.pecio@gmail.com
Reported-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Michal Pecio <michal.pecio@gmail.com>
Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Link: https://lore.kernel.org/20251111145357.4031846-1-yazen.ghannam@amd.com
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/acpi/boot.c    | 12 ++++++++----
 arch/x86/kernel/cpu/topology.c | 15 ---------------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 9fa321a95eb33..d6138b2b633a3 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -35,6 +35,7 @@
 #include <asm/smp.h>
 #include <asm/i8259.h>
 #include <asm/setup.h>
+#include <asm/hypervisor.h>
 
 #include "sleep.h" /* To include x86_acpi_suspend_lowlevel */
 static int __initdata acpi_force = 0;
@@ -164,11 +165,14 @@ static bool __init acpi_is_processor_usable(u32 lapic_flags)
 	if (lapic_flags & ACPI_MADT_ENABLED)
 		return true;
 
-	if (!acpi_support_online_capable ||
-	    (lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
-		return true;
+	if (acpi_support_online_capable)
+		return lapic_flags & ACPI_MADT_ONLINE_CAPABLE;
 
-	return false;
+	/*
+	 * QEMU expects legacy "Enabled=0" LAPIC entries to be counted as usable
+	 * in order to support CPU hotplug in guests.
+	 */
+	return !hypervisor_is_type(X86_HYPER_NATIVE);
 }
 
 static int __init
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index f55ea3cdbf88e..23190a786d310 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -27,7 +27,6 @@
 #include <xen/xen.h>
 
 #include <asm/apic.h>
-#include <asm/hypervisor.h>
 #include <asm/io_apic.h>
 #include <asm/mpspec.h>
 #include <asm/msr.h>
@@ -236,20 +235,6 @@ static __init void topo_register_apic(u32 apic_id, u32 acpi_id, bool present)
 		cpuid_to_apicid[cpu] = apic_id;
 		topo_set_cpuids(cpu, apic_id, acpi_id);
 	} else {
-		u32 pkgid = topo_apicid(apic_id, TOPO_PKG_DOMAIN);
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
 
-- 
2.51.0


