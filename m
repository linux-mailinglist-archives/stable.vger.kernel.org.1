Return-Path: <stable+bounces-264990-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4vIgK7yAMWpLlAUAu9opvQ
	(envelope-from <stable+bounces-264990-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:58:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 742486929FE
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:58:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=evPE5wJN;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264990-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264990-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03715303D749
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EB633A9EB;
	Tue, 16 Jun 2026 16:55:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01DD35AC3E;
	Tue, 16 Jun 2026 16:55:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628950; cv=none; b=lfIgf3pc/LR/X1B4vjRcZ3c7DCC1AzSY4M9jjcZCX5uK/GGPpYAPgOyKLIM72+PwMUXWrTYiVdgK0f1C1JRXKU1VG7obuECzMvj+vXWO2cdYXa1QJtv+xkyqUeEv7cuedjQv3m0zl9S4HPUHP/R3jOVe6puemll84whKvyS97aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628950; c=relaxed/simple;
	bh=0sbPwU43gkaJDxZfLBM7C65gPvCDJuSeQq2L2/JTyR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kktjVnT+A341kNR0aZzkFCHqSITa2ZP2m63tagymHNH2Sc0nwN5mCBhoOi4nRsci1Mw9lJ3rqQYYy3RZo7QZFVzgIsFy2J5ueZIFXpJhI9diZaCQVDFukgpNGo3qZnIL3L7XNt/WWq9YKcsrohH875rOEmGzt1o2MbgZ4CCuOqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=evPE5wJN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F071F000E9;
	Tue, 16 Jun 2026 16:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781628949;
	bh=/seAmBIyQoxLdVN0uQzhvbZCy8pnh+Nec9ivfQtHkKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=evPE5wJNt2+UQKAY+bwi/A01Jb92XJ71C146wjbTYItUJeF2JvGgTt52wpzLFY16r
	 d1qwYlwUWUnlzIj2AdD5Sa4Z6nzCjOSSwh0Yd8szfTfR8iqvTVzdZkcIW8eTHV9n7w
	 M0HOgHCAegcsxuuEmOqVs19eUB4mhjw1hEtL5/f4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksandr Nogikh <nogikh@google.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Dmitry Vyukov <dvyukov@google.com>,
	Miles Wang <13621186580@139.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 193/452] x86/kexec: Disable KCOV instrumentation after load_segments()
Date: Tue, 16 Jun 2026 20:27:00 +0530
Message-ID: <20260616145127.970656450@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[139.com:email];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_ALLOW(0.00)[linuxfoundation.org:s=korg];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264990-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:nogikh@google.com,m:bp@alien8.de,m:dvyukov@google.com,m:13621186580@139.com,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,google.com,alien8.de,139.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,139.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 742486929FE

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksandr Nogikh <nogikh@google.com>

[ Upstream commit 917e3ad3321e75ca0223d5ccf26ceda116aa51e1 ]

The load_segments() function changes segment registers, invalidating GS base
(which KCOV relies on for per-cpu data). When CONFIG_KCOV is enabled, any
subsequent instrumented C code call (e.g. native_gdt_invalidate()) begins
crashing the kernel in an endless loop.

To reproduce the problem, it's sufficient to do kexec on a KCOV-instrumented
kernel:

  $ kexec -l /boot/otherKernel
  $ kexec -e

The real-world context for this problem is enabling crash dump collection in
syzkaller. For this, the tool loads a panic kernel before fuzzing and then
calls makedumpfile after the panic. This workflow requires both CONFIG_KEXEC
and CONFIG_KCOV to be enabled simultaneously.

Adding safeguards directly to the KCOV fast-path (__sanitizer_cov_trace_pc())
is also undesirable as it would introduce an extra performance overhead.

Disabling instrumentation for the individual functions would be too fragile,
so disable KCOV instrumentation for the entire machine_kexec_64.c and
physaddr.c. If coverage-guided fuzzing ever needs these components in the
future, other approaches should be considered.

The problem is not relevant for 32 bit kernels as CONFIG_KCOV is not supported
there.

  [ bp: Space out comment for better readability. ]

Fixes: 0d345996e4cb ("x86/kernel: increase kcov coverage under arch/x86/kernel folder")
Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260325154825.551191-1-nogikh@google.com
Signed-off-by: Miles Wang <13621186580@139.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/Makefile | 14 ++++++++++++++
 arch/x86/mm/Makefile     |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0000325ab98f4d..c1fe6c98d3f6e0 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -39,6 +39,20 @@ KMSAN_SANITIZE_nmi.o					:= n
 KCOV_INSTRUMENT_head$(BITS).o				:= n
 KCOV_INSTRUMENT_sev.o					:= n
 
+# Disable KCOV to prevent crashes during kexec: load_segments() invalidates
+# the GS base, which KCOV relies on for per-CPU data.
+#
+# As KCOV and KEXEC compatibility should be preserved (e.g. syzkaller is
+# using it to collect crash dumps during kernel fuzzing), disabling
+# KCOV for KEXEC kernels is not an option. Selectively disabling KCOV
+# instrumentation for individual affected functions can be fragile, while
+# adding more checks to KCOV would slow it down.
+#
+# As a compromise solution, disable KCOV instrumentation for the whole
+# source code file. If its coverage is ever needed, other approaches
+# should be considered.
+KCOV_INSTRUMENT_machine_kexec_64.o			:= n
+
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
 obj-y			+= head_$(BITS).o
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index c80febc44cd2fe..dd78ec8758f17e 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -5,6 +5,8 @@ KCOV_INSTRUMENT_mem_encrypt.o		:= n
 KCOV_INSTRUMENT_mem_encrypt_amd.o	:= n
 KCOV_INSTRUMENT_mem_encrypt_identity.o	:= n
 KCOV_INSTRUMENT_pgprot.o		:= n
+# See the "Disable KCOV" comment in arch/x86/kernel/Makefile.
+KCOV_INSTRUMENT_physaddr.o		:= n
 
 KASAN_SANITIZE_mem_encrypt.o		:= n
 KASAN_SANITIZE_mem_encrypt_amd.o	:= n
-- 
2.53.0




