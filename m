Return-Path: <stable+bounces-260229-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EZSgG4XJIGqn7wAAu9opvQ
	(envelope-from <stable+bounces-260229-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 02:40:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EA263C12B
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 02:40:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=139.com header.s=dkim header.b=GluCW15X;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260229-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260229-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0210C301C6CC
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 00:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9C31A23A4;
	Thu,  4 Jun 2026 00:33:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A86192D8A
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 00:33:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780533234; cv=none; b=XL/3SHZzjAqSxu35Y/vVVdEp8ZWT8maPaTK4oXnwsIm38FbV9rZ5sWXrtJHBuH/+zIvkDWwLUUPlmSTKiB3I6BnGcV2GbsGStcgkHzPWsjIfBBtDRHxRiGIJZCRki1l6Rvjg8luRvgyWDJGyLcBFAis6PgGK3mxXR2NXf8gx17M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780533234; c=relaxed/simple;
	bh=n4z9j1CDtoKnK1j7JpbAJbHrI9j3UJh4OPIHKiAqhi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bAjr+84rmva488riA5dTLU1pc37njmSuzHH8i6buWRikFnlQ5F0VZb7HaSoLCQlYi/gi1nlTgYnd53J/W8gcaRzu8ifno1O4SKzR0QFK4m0xxqJrwScBKRWlfA1S+RfCcs2Dn45x/3zaqEkQ6bLZJsKOBM/sXRlIMCIj3mwEY9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=GluCW15X; arc=none smtp.client-ip=120.232.169.112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=GluCW15XnXYJz+TvHCOrMaaVDEK86Leav8v9UvqJ0Ly3Q0G8VBG9jdfLZ6Z20Dr0IxniJVP2o0voU
	 tENu9TEejAadMhklpmPplRaV9zCCtRJyT8783uxNpF+k1uJw1DbiD3KPI22hGxfQrcJjNn4e9Fyypi
	 IOQS757gc2+Xr3Fo=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[124.64.124.40])
	by rmsmtp-lg-appmail-19-12022 (RichMail) with SMTP id 2ef66a20c72787b-01898;
	Thu, 04 Jun 2026 08:30:39 +0800 (CST)
X-RM-TRANSID:2ef66a20c72787b-01898
From: Miles Wang <13621186580@139.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: nogikh@google.com,
	bp@alien8.de,
	dvyukov@google.com
Subject: [PATCH 6.6.y] x86/kexec: Disable KCOV instrumentation after load_segments()
Date: Thu,  4 Jun 2026 08:30:31 +0800
Message-ID: <20260604003031.561-1-13621186580@139.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [5.84 / 15.00];
	SEM_URIBL(3.50)[139.com:mid,139.com:from_mime,139.com:email];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260229-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[139.com];
	DMARC_NA(0.00)[139.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:nogikh@google.com,m:bp@alien8.de,m:dvyukov@google.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[13621186580@139.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[13621186580@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alien8.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,139.com:mid,139.com:from_mime,139.com:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1EA263C12B

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
---
 arch/x86/kernel/Makefile | 14 ++++++++++++++
 arch/x86/mm/Makefile     |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0000325ab98f..c1fe6c98d3f6 100644
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
index c80febc44cd2..dd78ec8758f1 100644
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
2.43.0



