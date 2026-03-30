Return-Path: <stable+bounces-231066-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4M9FMtFEymky7AUAu9opvQ
	(envelope-from <stable+bounces-231066-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:39:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 361CA358521
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B45C30305F0
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979D13B27E2;
	Mon, 30 Mar 2026 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZkkAYVVD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2FF3AC0EE
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863281; cv=none; b=aWF8HqXU7lHxWV5HiwJmRV5TY59GEp7kpNdf2QpC/LuXxvUnSQtZOk18D5vw7a/EDLSoxUYWv1j8Q/17v/jRq+CszzLYPLznIXSrCk+H6+0Hv01ulcI+dppSQH18UT4N+xGYQqZiihGLphTHwI5ERCVusUBfMPNJgJD5IWPc70Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863281; c=relaxed/simple;
	bh=W/OOZCLD8pqHch1Z3rMmIJrQPAsV2e5cFKbeQNl5J+s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DevweKNL12jggLzcsrwuzz4leaRleAmaKfyYJqIJG/32MioSJK69+/eHaAAYZk4AI0qEKB9p2sBvPBtrzLyFoaibcuyQBx6Bw71kpNL9Whk9GVI63MI3NGgSJnsYCqn1oZJOiB/N1CScui6Cb8T1owS+RvqjYwV1oc66FG5ylsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZkkAYVVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B06C4CEF7;
	Mon, 30 Mar 2026 09:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774863281;
	bh=W/OOZCLD8pqHch1Z3rMmIJrQPAsV2e5cFKbeQNl5J+s=;
	h=Subject:To:Cc:From:Date:From;
	b=ZkkAYVVDeszO00qK5jfIcKWTeYUuX5CoE8vZ1kW5KKEbNL4kcQZm57Y4crge2zv7E
	 MhV5HE2bXC2nDL0Jyue+z5BqQG6VJ17IroikI1xiD8tHLBlxMpvzqaDhP1FlpqchjX
	 cXkg2AoN/gmzR0jb8Lp3a/L3AUIeBfIjGBzRRciY=
Subject: FAILED: patch "[PATCH] x86/cpu: Enable FSGSBASE early in" failed to apply to 6.6-stable tree
To: nikunj@amd.com,bp@alien8.de,sohil.mehta@intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 11:34:32 +0200
Message-ID: <2026033032-sprout-chapter-cbc5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231066-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 361CA358521
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 05243d490bb7852a8acca7b5b5658019c7797a52
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033032-sprout-chapter-cbc5@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 05243d490bb7852a8acca7b5b5658019c7797a52 Mon Sep 17 00:00:00 2001
From: Nikunj A Dadhania <nikunj@amd.com>
Date: Wed, 18 Mar 2026 07:56:52 +0000
Subject: [PATCH] x86/cpu: Enable FSGSBASE early in
 cpu_init_exception_handling()

Move FSGSBASE enablement from identify_cpu() to cpu_init_exception_handling()
to ensure it is enabled before any exceptions can occur on both boot and
secondary CPUs.

== Background ==

Exception entry code (paranoid_entry()) uses ALTERNATIVE patching based on
X86_FEATURE_FSGSBASE to decide whether to use RDGSBASE/WRGSBASE instructions
or the slower RDMSR/SWAPGS sequence for saving/restoring GSBASE.

On boot CPU, ALTERNATIVE patching happens after enabling FSGSBASE in CR4.
When the feature is available, the code is permanently patched to use
RDGSBASE/WRGSBASE, which require CR4.FSGSBASE=1 to execute without triggering

== Boot Sequence ==

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
    cr4_init()                   <- Code already patched, CR4.FSGSBASE=1
                                    set implicitly via cr4_pinned_bits

    cpu_init()                   <- exceptions work because FSGSBASE is
                                    already enabled

Secondary CPU (with CR pinning disabled):
  start_secondary()
    cr4_init()                   <- Code already patched, CR4.FSGSBASE=0
    cpu_init()
      x2apic_setup()
        rdmsrq(MSR_IA32_APICBASE)  <- Triggers #VC in SNP guests
          exc_vmm_communication()
            paranoid_entry()       <- Uses RDGSBASE with CR4.FSGSBASE=0
                                      (patched code)
    ...
    ap_starting()
      identify_secondary_cpu()
        identify_cpu()
	  cr4_set_bits(X86_CR4_FSGSBASE)  <- Enables the feature, which is
                                             too late

== CR Pinning ==

Currently, for secondary CPUs, CR4.FSGSBASE is set implicitly through
CR-pinning: the boot CPU sets it during identify_cpu(), it becomes part of
cr4_pinned_bits, and cr4_init() applies those pinned bits to secondary CPUs.
This works but creates an undocumented dependency between cr4_init() and the
pinning mechanism.

== Problem ==

Secondary CPUs boot after alternatives have been applied globally. They
execute already-patched paranoid_entry() code that uses RDGSBASE/WRGSBASE
instructions, which require CR4.FSGSBASE=1. Upcoming changes to CR pinning
behavior will break the implicit dependency, causing secondary CPUs to
generate #UD.

This issue manifests itself on AMD SEV-SNP guests, where the rdmsrq() in
x2apic_setup() triggers a #VC exception early during cpu_init(). The #VC
handler (exc_vmm_communication()) executes the patched paranoid_entry() path.
Without CR4.FSGSBASE enabled, RDGSBASE instructions trigger #UD.

== Fix ==

Enable FSGSBASE explicitly in cpu_init_exception_handling() before loading
exception handlers. This makes the dependency explicit and ensures both
boot and secondary CPUs have FSGSBASE enabled before paranoid_entry()
executes.

Fixes: c82965f9e530 ("x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit")
Reported-by: Borislav Petkov <bp@alien8.de>
Suggested-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Cc: <stable@kernel.org>
Link: https://patch.msgid.link/20260318075654.1792916-2-nikunj@amd.com

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a8ff4376c286..7840b224d6a7 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2050,12 +2050,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	setup_umip(c);
 	setup_lass(c);
 
-	/* Enable FSGSBASE instructions if available. */
-	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
-		cr4_set_bits(X86_CR4_FSGSBASE);
-		elf_hwcap2 |= HWCAP2_FSGSBASE;
-	}
-
 	/*
 	 * The vendor-specific functions might have changed features.
 	 * Now we do "generic changes."
@@ -2416,6 +2410,18 @@ void cpu_init_exception_handling(bool boot_cpu)
 	/* GHCB needs to be setup to handle #VC. */
 	setup_ghcb();
 
+	/*
+	 * On CPUs with FSGSBASE support, paranoid_entry() uses
+	 * ALTERNATIVE-patched RDGSBASE/WRGSBASE instructions. Secondary CPUs
+	 * boot after alternatives are patched globally, so early exceptions
+	 * execute patched code that depends on FSGSBASE. Enable the feature
+	 * before any exceptions occur.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_FSGSBASE)) {
+		cr4_set_bits(X86_CR4_FSGSBASE);
+		elf_hwcap2 |= HWCAP2_FSGSBASE;
+	}
+
 	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
 		/* The boot CPU has enabled FRED during early boot */
 		if (!boot_cpu)


