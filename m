Return-Path: <stable+bounces-231227-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHCvHvCDymkW9gUAu9opvQ
	(envelope-from <stable+bounces-231227-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:08:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E194635C974
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66A313037F25
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 14:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3416A3D6486;
	Mon, 30 Mar 2026 14:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BlW9K1qL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bIq6w7vn"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F83023D7F0;
	Mon, 30 Mar 2026 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774879410; cv=none; b=nUdUWn/xwKOTOAoMxBNfF7/bQQscU+Uz+mHLSvCr1ber1qm8BYNF9uvBtQecrtuGqOjLE5hOkd/+mOGRHWKl9bVqXGpDO2bIC+NdzTGgA7wGC4z1PcXBFLNJDoCH7pvsQSNUolbwczNocVAIweCAto2+4tAg2Sa+Vl1cnjEz+RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774879410; c=relaxed/simple;
	bh=2d3KFuvkYm46XPB3XQ0dd8W9aFwPOJ1zvw02FFrnSVY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rYxQSRLzC3K6YKDqce1A3RZqk9akwsyGMT9914KLDeusGNJ7p8P2fQWj6AzPpFwWCF3HAvaLid2+/k1yqR6MjGEQCdet6Evthg85Wpdioez4losCb2HkDT4Kck+D9XtikNKpaxygDzRavrNBbeoFijxt2vblpjXYuxAl1cvM7Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BlW9K1qL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bIq6w7vn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Mar 2026 14:03:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774879406;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWq1EeodLoB1UPJsVRculGoO6luKkatl+v8LfoaeqyU=;
	b=BlW9K1qLvaALWan+HS0P3grbo39XfkIldJlqZvlBHKN+Epqx6CmKP/FZGdG1UiFo99cjZW
	oH/oKsM5AK8Q99+YZKfNJCvZBqxRjPBqNwIkrELkozK5nixyfIF5qgc62fFYNgH76wcS4e
	30DoQMZETe516D1Nt/mEoyEo4AmRo8OTWppWrW5WRX0iN+Q10+BK6QiSwotjW5UlDRDEwG
	+udnVIHTGiRLgTeUVyEq+K8WdXWklgp2Y0SHI7drud2ocWgI0SOIxzkEeR5kyq+U3pNmhs
	Sp22hHxlPnxCRjmCpAXeUtVszvd+9WjwldLZsVcr7wVnUiymlIPRPAGeNajYKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774879406;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWq1EeodLoB1UPJsVRculGoO6luKkatl+v8LfoaeqyU=;
	b=bIq6w7vnkoQ0Rx5gbIHiTh6FshMMOhx32JPOtHKbVcIjDkgxOZLupkDkHc+YordgEqszp/
	IZ7d/IgrYB6iBrCA==
From: "tip-bot2 for Aleksandr Nogikh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/kexec: Disable KCOV instrumentation after
 load_segments()
Cc: Aleksandr Nogikh <nogikh@google.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Dmitry Vyukov <dvyukov@google.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260325154825.551191-1-nogikh@google.com>
References: <20260325154825.551191-1-nogikh@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177487940458.1647592.7635215973023987099.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231227-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alien8.de:email,vger.kernel.org:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: E194635C974
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     917e3ad3321e75ca0223d5ccf26ceda116aa51e1
Gitweb:        https://git.kernel.org/tip/917e3ad3321e75ca0223d5ccf26ceda116a=
a51e1
Author:        Aleksandr Nogikh <nogikh@google.com>
AuthorDate:    Wed, 25 Mar 2026 16:48:24 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 30 Mar 2026 14:15:25 +02:00

x86/kexec: Disable KCOV instrumentation after load_segments()

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

Fixes: 0d345996e4cb ("x86/kernel: increase kcov coverage under arch/x86/kerne=
l folder")
Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260325154825.551191-1-nogikh@google.com
---
 arch/x86/kernel/Makefile | 14 ++++++++++++++
 arch/x86/mm/Makefile     |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index e9aeeea..47a32f5 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -44,6 +44,20 @@ KCOV_INSTRUMENT_unwind_orc.o				:=3D n
 KCOV_INSTRUMENT_unwind_frame.o				:=3D n
 KCOV_INSTRUMENT_unwind_guess.o				:=3D n
=20
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
+KCOV_INSTRUMENT_machine_kexec_64.o			:=3D n
+
 CFLAGS_head32.o :=3D -fno-stack-protector
 CFLAGS_head64.o :=3D -fno-stack-protector
 CFLAGS_irq.o :=3D -I $(src)/../include/asm/trace
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 5b9908f..3a53648 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -4,6 +4,8 @@ KCOV_INSTRUMENT_tlb.o			:=3D n
 KCOV_INSTRUMENT_mem_encrypt.o		:=3D n
 KCOV_INSTRUMENT_mem_encrypt_amd.o	:=3D n
 KCOV_INSTRUMENT_pgprot.o		:=3D n
+# See the "Disable KCOV" comment in arch/x86/kernel/Makefile.
+KCOV_INSTRUMENT_physaddr.o		:=3D n
=20
 KASAN_SANITIZE_mem_encrypt.o		:=3D n
 KASAN_SANITIZE_mem_encrypt_amd.o	:=3D n

