Return-Path: <stable+bounces-42251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AA98B7219
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EAE61F221E4
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCAC12C530;
	Tue, 30 Apr 2024 11:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JxBLemn9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D001212C47A;
	Tue, 30 Apr 2024 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475056; cv=none; b=i1BVoICPVcOmQhdYdave8mrk1NtMm8GQhHy0jTNK5mjjgXtClluEu0O1vYIPMLacw2jC9TcCzQIM0e2Oa05w5YwIJhw+IeRBsDwg6lBl6SAdqH4NawtBeFYIDIs064TEWpIEgLYw3RBhjsxhqfi8zAtac7Zk03AeNp5oYy9M+dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475056; c=relaxed/simple;
	bh=c2by9POiN2whPrrk8/vtnpiHyF0jr0fQSkvn4rL3JCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKgPlxpfvHUIf7ApQ8taEAQRSHBMXDuwEMLrwYN24Qj4u53u8S5E+OSajNhQMauMYN6XADWQ5bdS1AjNnUdAHwVkXyPjdVCqCLKufVThji5Q1IoaF25FVDhZVC4i9UXEyfwywDiOQ1Hp6N3HNxoqnZnlYPwiANsfBPh2w+kdkuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JxBLemn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AE2C2BBFC;
	Tue, 30 Apr 2024 11:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475056;
	bh=c2by9POiN2whPrrk8/vtnpiHyF0jr0fQSkvn4rL3JCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JxBLemn9nDZmKXgsGTWJQUPVO7lMW0A5MCXHlpu+JYtmcWy7jWgPkgx8nxC8cMXSY
	 Q20vH/M8F3KeNqPTohBNoPl6eNg0Zpo49KDNoIxSsINMGg8n5JydNJlgwXhWzqU/lV
	 n0SUOzYCce1lY1vaUoeEr10QJD8Ck9XccHxj/1s8=
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
Subject: [PATCH 5.10 117/138] cpu: Re-enable CPU mitigations by default for !X86 architectures
Date: Tue, 30 Apr 2024 12:40:02 +0200
Message-ID: <20240430103052.851867109@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103049.422035273@linuxfoundation.org>
References: <20240430103049.422035273@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
 
 config CRASH_CORE
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -57,6 +57,7 @@ config X86
 	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ARCH_32BIT_OFF_T			if X86_32
+	select ARCH_CONFIGURES_CPU_MITIGATIONS
 	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_CPU_FINALIZE_INIT
@@ -2408,17 +2409,17 @@ config CC_HAS_SLS
 config CC_HAS_RETURN_THUNK
 	def_bool $(cc-option,-mfunction-return=thunk-extern)
 
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
@@ -2600,8 +2600,8 @@ enum cpu_mitigations {
 };
 
 static enum cpu_mitigations cpu_mitigations __ro_after_init =
-	IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
-						     CPU_MITIGATIONS_OFF;
+	IS_ENABLED(CONFIG_CPU_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
+					     CPU_MITIGATIONS_OFF;
 
 static int __init mitigations_parse_cmdline(char *arg)
 {



