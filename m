Return-Path: <stable+bounces-42406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8414D8B72DF
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1BCC1F215A9
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D7012D1FC;
	Tue, 30 Apr 2024 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n2rMjcoU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207DD12CDAE;
	Tue, 30 Apr 2024 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475563; cv=none; b=dgRKb3JLx15hN73S58X8WWUgIpN3LkeQkKn3kp9xHg4hYQ6dwIUoJ/nG5oTSFh7aDQ1E2YFXqW9rSianxc03aX/EZkf6vcZbg9boWvZPh4LNKCOKaM2bjJiY8XrNp0mLa0aLzrBFy6xa3eS3xK7FDYaryg2gBi/zreKB8TVstzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475563; c=relaxed/simple;
	bh=XvHnYHMHPzIKItCKjMfRnEhq17KP9yd7a9A7hp6kVPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZsZRSZS4FheurlbudOk5Iw15EjvuZ0Qpg6+Am7/zLCWnLlx4aIFPOvootWFL56klY290Mcx8e5+Cky+CEGVj1KGWz/MdBoNMICI6LIqPTE53tJ1DEBFlxFyx+J/BVS05hK2Fz6dcnO0sy3Q2fT2bhqWooXJJvpXZwpm125rIkyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n2rMjcoU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D44C2BBFC;
	Tue, 30 Apr 2024 11:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475562;
	bh=XvHnYHMHPzIKItCKjMfRnEhq17KP9yd7a9A7hp6kVPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n2rMjcoUQajGKd23S4oS0Uf5tpg9bZzV74rknUfhoqAt1WoYJz+E2ozszb0Iq3YCd
	 Ym1VfqryI+jDrrpNuhRtOm7keI+Y/VkAMeQ6CD8HUWB9rqMh/W2KuBjDW5GqrMhlm5
	 XCmPTwUO+UnyojlDbraE68y3rrV6bfDglngjTEfU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Sean Christopherson <seanjc@google.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 6.6 135/186] cpu: Re-enable CPU mitigations by default for !X86 architectures
Date: Tue, 30 Apr 2024 12:39:47 +0200
Message-ID: <20240430103101.951962770@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103058.010791820@linuxfoundation.org>
References: <20240430103058.010791820@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

commit fe42754b94a42d08cf9501790afc25c4f6a5f631 upstream.

Rename x86's to CPU_MITIGATIONS, define it in generic code, and force it
on for all architectures exception x86.  A recent commit to turn
mitigations off by default if SPECULATION_MITIGATIONS=n kinda sorta
missed that "cpu_mitigations" is completely generic, whereas
SPECULATION_MITIGATIONS is x86-specific.

Rename x86's SPECULATIVE_MITIGATIONS instead of keeping both and have it
select CPU_MITIGATIONS, as having two configs for the same thing is
unnecessary and confusing.  This will also allow x86 to use the knob to
manage mitigations that aren't strictly related to speculative
execution.

Use another Kconfig to communicate to common code that CPU_MITIGATIONS
is already defined instead of having x86's menu depend on the common
CPU_MITIGATIONS.  This allows keeping a single point of contact for all
of x86's mitigations, and it's not clear that other architectures *want*
to allow disabling mitigations at compile-time.

Fixes: f337a6a21e2f ("x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n")
Closes: https://lkml.kernel.org/r/20240413115324.53303a68%40canb.auug.org.au
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240420000556.2645001-2-seanjc@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/Kconfig     |    8 ++++++++
 arch/x86/Kconfig |   11 ++++++-----
 kernel/cpu.c     |    4 ++--
 3 files changed, 16 insertions(+), 7 deletions(-)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -9,6 +9,14 @@
 #
 source "arch/$(SRCARCH)/Kconfig"
 
+config ARCH_CONFIGURES_CPU_MITIGATIONS
+	bool
+
+if !ARCH_CONFIGURES_CPU_MITIGATIONS
+config CPU_MITIGATIONS
+	def_bool y
+endif
+
 menu "General architecture-dependent options"
 
 config ARCH_HAS_SUBPAGE_FAULTS
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -62,6 +62,7 @@ config X86
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_INIT
+	select ARCH_CONFIGURES_CPU_MITIGATIONS
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if X86_64 && HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_MEMORY_HOTPLUG if X86_64
@@ -2421,17 +2422,17 @@ config PREFIX_SYMBOLS
 	def_bool y
 	depends on CALL_PADDING && !CFI_CLANG
 
-menuconfig SPECULATION_MITIGATIONS
-	bool "Mitigations for speculative execution vulnerabilities"
+menuconfig CPU_MITIGATIONS
+	bool "Mitigations for CPU vulnerabilities"
 	default y
 	help
-	  Say Y here to enable options which enable mitigations for
-	  speculative execution hardware vulnerabilities.
+	  Say Y here to enable options which enable mitigations for hardware
+	  vulnerabilities (usually related to speculative execution).
 
 	  If you say N, all mitigations will be disabled. You really
 	  should know what you are doing to say so.
 
-if SPECULATION_MITIGATIONS
+if CPU_MITIGATIONS
 
 config PAGE_TABLE_ISOLATION
 	bool "Remove the kernel mapping in user mode"
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3208,8 +3208,8 @@ enum cpu_mitigations {
 };
 
 static enum cpu_mitigations cpu_mitigations __ro_after_init =
-	IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
-						     CPU_MITIGATIONS_OFF;
+	IS_ENABLED(CONFIG_CPU_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
+					     CPU_MITIGATIONS_OFF;
 
 static int __init mitigations_parse_cmdline(char *arg)
 {



