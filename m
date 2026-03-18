Return-Path: <stable+bounces-227137-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBoLJzP0ummHdQIAu9opvQ
	(envelope-from <stable+bounces-227137-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 19:51:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC4D2C19E0
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 19:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01F1F301BED6
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 18:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E593BFE26;
	Wed, 18 Mar 2026 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fU8hgLOx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LWqH9T8f"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D302330EF75;
	Wed, 18 Mar 2026 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859876; cv=none; b=OgZKqhIOzwWGX1BjeXMKhJmSDSXdyKYsuOWmP+AfVoPUzWUZZ8ihEHleOIyvrJMgAboiiKZ13EQP/TItGPgL5p/5jpb6FEbPz5BUvS4xpx4Kcy/VkMWIcdpdj/Iwge+bZ/zgViM6e/XfmQsyFctuQgjBN6rhgHihY3GzStYsiy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859876; c=relaxed/simple;
	bh=wITPIJ5Y3Kpo7vchVrYCGSj9K8Rrc8g3df24D1AYZFg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U+AbXxEaoaI31PhwKS8YfcGdmXWIgJsXhCph4bgtYWcMNl3ovJstCQj1qr451hnNTlx7z73ZUxo1anjnt6WUuhASHfo6ZuRhtYDoIZCfSq7kRelweWFvHfjifEZAqTXpvrmt8LDuu2l+Xju//g6h1DkvKg0IuMAa+OLw7X+itMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fU8hgLOx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LWqH9T8f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Mar 2026 18:51:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773859873;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Ysy/qTGxCklcRCEDUZ8GYNyVXDqLMcRJCEjCnWUFoE=;
	b=fU8hgLOxNo6+IpICGD/pBfPOn7ZKQMEcafIIDLOfKzKDDqaT8qORDYu5cH0u5Qr0jXlQZO
	M3Cg+iTbnGr1cYYVprQusdn/dnUdsQZx234zN89rCXBKNMVhjUiMQNQTQuCgGAf9qlKJUd
	MbQua7VjTFCTM9Q8bnngEnK59Lk5hya6HRJX4PPazI0zo88iiFiL1l0D+tyIu5VYP/Qyk1
	W8XNKyrNS+xG17gkzQ7qNItZ0cDHFsz6cllDlrd7WBjEka3wLvzFQ0woXKgbuCkeMHc449
	Kt7RNxwu+O+E+6i+SDu6Ufhpi3sNtUVx4TmSc91HuwAMu5t941SRK5ex56pm9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773859873;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Ysy/qTGxCklcRCEDUZ8GYNyVXDqLMcRJCEjCnWUFoE=;
	b=LWqH9T8fTBM+1TZa1bcJyOwqldgZHLBHY6j1EELs88WBJTsUtlvU19qDNUb01Pn8kR44mf
	oXxcBK+S0ZtWceCg==
From: "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Enable FSGSBASE early in
 cpu_init_exception_handling()
Cc: Borislav Petkov <bp@alien8.de>, Sohil Mehta <sohil.mehta@intel.com>,
 Nikunj A Dadhania <nikunj@amd.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260318075654.1792916-2-nikunj@amd.com>
References: <20260318075654.1792916-2-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177385987216.1647592.5365553015724397432.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227137-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,msgid.link:url,vger.kernel.org:replyto,linutronix.de:dkim,alien8.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 3EC4D2C19E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     31e1e8c4eb7ff7fd8cb8a9d0b216c25d18ea37eb
Gitweb:        https://git.kernel.org/tip/31e1e8c4eb7ff7fd8cb8a9d0b216c25d18e=
a37eb
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Wed, 18 Mar 2026 07:56:52=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 18 Mar 2026 16:40:42 +01:00

x86/cpu: Enable FSGSBASE early in cpu_init_exception_handling()

Move FSGSBASE enablement from identify_cpu() to cpu_init_exception_handling()
to ensure it is enabled before any exceptions can occur on both boot and
secondary CPUs.

=3D=3D Background =3D=3D

Exception entry code (paranoid_entry()) uses ALTERNATIVE patching based on
X86_FEATURE_FSGSBASE to decide whether to use RDGSBASE/WRGSBASE instructions
or the slower RDMSR/SWAPGS sequence for saving/restoring GSBASE.

On boot CPU, ALTERNATIVE patching happens after enabling FSGSBASE in CR4.
When the feature is available, the code is permanently patched to use
RDGSBASE/WRGSBASE, which require CR4.FSGSBASE=3D1 to execute without triggeri=
ng

=3D=3D Boot Sequence =3D=3D

Boot CPU (with CR pinning enabled):
  trap_init()
    cpu_init()                   <- Uses unpatched code (RDMSR/SWAPGS)
      x2apic_setup()
  ...
  arch_cpu_finalize_init()
    identify_boot_cpu()
      identify_cpu()
        cr4_set_bits(X86_CR4_FSGSBASE)  # Enables the feature
	# This becomes part of cr4_pinned_bits
    ...
    alternative_instructions()   <- Patches code to use RDGSBASE/WRGSBASE

Secondary CPUs (with CR pinning enabled):
  start_secondary()
    cr4_init()                   <- Code already patched, CR4.FSGSBASE=3D1
                                    set implicitly via cr4_pinned_bits

    cpu_init()                   <- exceptions work because FSGSBASE is
                                    already enabled

Secondary CPU (with CR pinning disabled):
  start_secondary()
    cr4_init()                   <- Code already patched, CR4.FSGSBASE=3D0
    cpu_init()
      x2apic_setup()
        rdmsrq(MSR_IA32_APICBASE)  <- Triggers #VC in SNP guests
          exc_vmm_communication()
            paranoid_entry()       <- Uses RDGSBASE with CR4.FSGSBASE=3D0
                                      (patched code)
    ...
    ap_starting()
      identify_secondary_cpu()
        identify_cpu()
	  cr4_set_bits(X86_CR4_FSGSBASE)  <- Enables the feature, which is
                                             too late

=3D=3D CR Pinning =3D=3D

Currently, for secondary CPUs, CR4.FSGSBASE is set implicitly through
CR-pinning: the boot CPU sets it during identify_cpu(), it becomes part of
cr4_pinned_bits, and cr4_init() applies those pinned bits to secondary CPUs.
This works but creates an undocumented dependency between cr4_init() and the
pinning mechanism.

=3D=3D Problem =3D=3D

Secondary CPUs boot after alternatives have been applied globally. They
execute already-patched paranoid_entry() code that uses RDGSBASE/WRGSBASE
instructions, which require CR4.FSGSBASE=3D1. Upcoming changes to CR pinning
behavior will break the implicit dependency, causing secondary CPUs to
generate #UD.

This issue manifests itself on AMD SEV-SNP guests, where the rdmsrq() in
x2apic_setup() triggers a #VC exception early during cpu_init(). The #VC
handler (exc_vmm_communication()) executes the patched paranoid_entry() path.
Without CR4.FSGSBASE enabled, RDGSBASE instructions trigger #UD.

=3D=3D Fix =3D=3D

Enable FSGSBASE explicitly in cpu_init_exception_handling() before loading
exception handlers. This makes the dependency explicit and ensures both
boot and secondary CPUs have FSGSBASE enabled before paranoid_entry()
executes.

Fixes: c82965f9e530 ("x86/entry/64: Handle FSGSBASE enabled paranoid entry/ex=
it")
Reported-by: Borislav Petkov <bp@alien8.de>
Suggested-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260318075654.1792916-2-nikunj@amd.com
---
 arch/x86/kernel/cpu/common.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a8ff437..7840b22 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2050,12 +2050,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	setup_umip(c);
 	setup_lass(c);
=20
-	/* Enable FSGSBASE instructions if available. */
-	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
-		cr4_set_bits(X86_CR4_FSGSBASE);
-		elf_hwcap2 |=3D HWCAP2_FSGSBASE;
-	}
-
 	/*
 	 * The vendor-specific functions might have changed features.
 	 * Now we do "generic changes."
@@ -2416,6 +2410,18 @@ void cpu_init_exception_handling(bool boot_cpu)
 	/* GHCB needs to be setup to handle #VC. */
 	setup_ghcb();
=20
+	/*
+	 * On CPUs with FSGSBASE support, paranoid_entry() uses
+	 * ALTERNATIVE-patched RDGSBASE/WRGSBASE instructions. Secondary CPUs
+	 * boot after alternatives are patched globally, so early exceptions
+	 * execute patched code that depends on FSGSBASE. Enable the feature
+	 * before any exceptions occur.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_FSGSBASE)) {
+		cr4_set_bits(X86_CR4_FSGSBASE);
+		elf_hwcap2 |=3D HWCAP2_FSGSBASE;
+	}
+
 	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
 		/* The boot CPU has enabled FRED during early boot */
 		if (!boot_cpu)

