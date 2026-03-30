Return-Path: <stable+bounces-231068-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JVsCARFymm/7AUAu9opvQ
	(envelope-from <stable+bounces-231068-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:40:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C200358564
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94D4C303B4E7
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C89A3AC0FE;
	Mon, 30 Mar 2026 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YLQHVhIA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48882DC767
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863303; cv=none; b=m7hd9hPZMR7VL9Rc1MzyuDUWoksfQtFz89viL8xzDudbL+H4XQ2WcGcRcoqvR4HBzBHy4SKs6ix8mQPUAgjZbexy4579mxqgJZaQhBMK8v1j+Saxapi7TzKLC12ECpYeATXevW95PL5bxuHfVLms9f3KWml7049xH+4KSfRe3pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863303; c=relaxed/simple;
	bh=TcyBphokid8jLv4B8Rkv4xZMzLripxB0tgww3Trxl2o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dCfGKCFgdNjS4w82s9AcUtgrJhpMiTqdl5N5jt1040mm5O4R8FzfS+g08CQPrrpBYMtlv2I1x+20bwnRy6BqaLAi9obFs3fHO1ri9bTybVto/5E+qh0hTqf4KGLeYCLgLx4gNRP7lggOI0uYPXwDR6kzQwR98N/l9opbjALE334=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YLQHVhIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD5AC4CEF7;
	Mon, 30 Mar 2026 09:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774863303;
	bh=TcyBphokid8jLv4B8Rkv4xZMzLripxB0tgww3Trxl2o=;
	h=Subject:To:Cc:From:Date:From;
	b=YLQHVhIAxb/4E2337w1N+SX6aPHMXQvAbOUDfIyptE45wSQ8e6apOlv98/dioKEUl
	 9N0bVQnXMX9s6D7oDM+DsZxQVIfNLI+2XQTRx5oxohcKlARnF4c5IKC7FQRw8OH00g
	 bGDgRslnK1/m6Xc4rO4W3WI86NhTQne6BbhtnvY0=
Subject: FAILED: patch "[PATCH] x86/cpu: Enable FSGSBASE early in" failed to apply to 5.15-stable tree
To: nikunj@amd.com,bp@alien8.de,sohil.mehta@intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 11:35:00 +0200
Message-ID: <2026033059-stargazer-connected-2af4@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231068-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 4C200358564
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 05243d490bb7852a8acca7b5b5658019c7797a52
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033059-stargazer-connected-2af4@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


