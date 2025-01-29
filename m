Return-Path: <stable+bounces-111241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88176A226E8
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 00:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9433F3A59DE
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 23:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675141E32A3;
	Wed, 29 Jan 2025 23:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JekBYmnx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6EC1E32BD
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 23:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738193149; cv=none; b=XKr76MNKaRcWpV9KzXzAtLp7bOtEgW5atsLqwu2qowgCmrnx3LPgw9n8LOVmyxjR/vL6qM8wwIWsqzIOzK2hQbTUuXIuppKaagrSSGa21UNjmU1G94P44P0AlhLurQhXhf5EDLYp4vFiT0+GMvtGUnqREMSkFTf3QUH8Ia8Pq7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738193149; c=relaxed/simple;
	bh=JjbcMePIC+hlZCNawCe1+J+sCso+kA3lGDjHaZMDKS8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WWrJ2ScuL5An8WmNFzJcMz3xAIx6XM7pcYYloRS9ukeKvyBzFrt+i+LN7C6weybHIcC9ns35teuZdwo7zdEC0KV9jD6/aD5OeZIm3gRtYzguUliqcGD5aUGozguKuzylYsaIJnjtEHGJHgLb+w7D7uIh4t0jILUxAy2lqwnNoCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JekBYmnx; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2166855029eso3641095ad.0
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 15:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738193147; x=1738797947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+/fthEx4KMs/q0D1UGwguZKMvJf4w33wNyq8hJ7/c7s=;
        b=JekBYmnxSrygfH54gJK6Vo35lFw7vOpqPzZKfo9BmC7C6lHeULt/Cr34s5YcnMOXTK
         bLejNnBXyxDGxXW6XIjtZ1eFPiTDl1rsjBpT1pTTYv2DGsoWkLGvzGiZYwYgU9UnEnK8
         68YqBRkSzxc4glnZrMW2wBVrZpyJaQaDLmtBqureIbfGN+6Agkp5Fpwl5JjfGmzqlAEv
         xROkmhb5L1j9+oI7fEFjiySZlmCn8r9r5N3lPxegL40Uq4SXIiALb2Fzwu/zulrp285e
         MM/AWrLO2pumqV57794x9OI/Xxsdurp7b8VtpRZVqiaZyjr5mYT74oimO10pE9XkMu2n
         XyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738193147; x=1738797947;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+/fthEx4KMs/q0D1UGwguZKMvJf4w33wNyq8hJ7/c7s=;
        b=OBwcUxsnP/zv/AEAkDe05PcbriMhJV126NpKdEk0B526Oob7RUj69XhteK+kqkDYR6
         u0S1rdI0rkcwMPzp1ndnhlMBPnQE7GRt3wJgpNCCmj12Suhxn+ew3axbTgjcWqtoR7C6
         OYPgi/RYDRP8jbcjm+eefCgk/cSi9VE+I/RLP6FE1T2JRl1sVUP9kMf6lg5kekGmpFg7
         Y9VxzYVUJ1GfLle1Y73sMbSPXvOFs9LN0H12FwM32CVtvXR/07G/vbwu3RXBsINZyj6I
         1oOcXZDFT26RIjSrnujH16QgiqrDKiElPMWD/GigIrKWLIxbYFO2zOuTkN2BVSQLggn3
         J/dA==
X-Forwarded-Encrypted: i=1; AJvYcCWYkAlgL/XApfVcr3suiRkdyVK23bDOY4Mvf5cBD92jjgK/APAxXONJc3N/ADE7+mj98eIBrck=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtl5jD467SmCdH6Nv0hZFH43fV78liOAJZz6Tp8SFir+T2a1cj
	85BuFSg1/t5lCmlrc0vkwjhAON6rQ4p/bgUSvZ7kJRqoj9O9vgnYDWeBw4NKFexC0vajUWHKHRo
	6rQZP8Qwt5e0javXlOg==
X-Google-Smtp-Source: AGHT+IHexmbpUDvlMg4R8Trr0bmnsZ4sOx1FLPifoDvY2PfbnQVguwP/mPYXCV1cqP06I4Mnpa9vzmRMXprPn/49
X-Received: from pgbgb1.prod.google.com ([2002:a05:6a02:4b41:b0:a87:a3b9:db3d])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:78c:b0:1ea:df1a:f8db with SMTP id adf61e73a8af0-1ed7a6236bdmr8181402637.37.1738193146832;
 Wed, 29 Jan 2025 15:25:46 -0800 (PST)
Date: Wed, 29 Jan 2025 23:25:25 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250129232525.3519586-1-vannapurve@google.com>
Subject: [PATCH V2 1/1] x86/tdx: Route safe halt execution via tdx_safe_halt()
From: Vishal Annapurve <vannapurve@google.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	pgonda@google.com, kirill@shutemov.name, dave.hansen@linux.intel.com, 
	linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, Vishal Annapurve <vannapurve@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Direct HLT instruction execution causes #VEs for TDX VMs which is routed
to hypervisor via tdvmcall. This process renders HLT instruction
execution inatomic, so any preceding instructions like STI/MOV SS will
end up enabling interrupts before the HLT instruction is routed to the
hypervisor. This creates scenarios where interrupts could land during
HLT instruction emulation without aborting halt operation leading to
idefinite halt wait times.

Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests") already
upgraded x86_idle() to invoke tdvmcall to avoid such scenarios, but
it didn't cover pv_native_safe_halt() which can be invoked using
raw_safe_halt() from call sites like acpi_safe_halt().

raw_safe_halt() also returns with interrupts enabled so upgrade
tdx_safe_halt() to enable interrupts by default and ensure that paravirt
safe_halt() executions invoke tdx_safe_halt(). Earlier x86_idle() is now
handled via tdx_idle() which simply invokes tdvmcall while preserving
irq state.

To avoid future call sites which cause HLT instruction emulation with
irqs enabled, add a warn and fail the HLT instruction emulation.

Cc: stable@vger.kernel.org
Fixes: bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
Changes since V1:
1) Addressed comments from Dave H
   - Comment regarding adding a check for TDX VMs in halt path is not
     resolved in v2, would like feedback around better place to do so,
     maybe in pv_native_safe_halt (?).
2) Added a new version of tdx_safe_halt() that will enable interrupts.
3) Previous tdx_safe_halt() implementation is moved to newly introduced
tdx_idle().

V1: https://lore.kernel.org/lkml/Z5l6L3Hen9_Y3SGC@google.com/T/

 arch/x86/coco/tdx/tdx.c    | 23 ++++++++++++++++++++++-
 arch/x86/include/asm/tdx.h |  2 +-
 arch/x86/kernel/process.c  |  2 +-
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 0d9b090b4880..cc2a637dca15 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -14,6 +14,7 @@
 #include <asm/ia32.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
+#include <asm/paravirt_types.h>
 #include <asm/pgtable.h>
 #include <asm/set_memory.h>
 #include <asm/traps.h>
@@ -380,13 +381,18 @@ static int handle_halt(struct ve_info *ve)
 {
 	const bool irq_disabled = irqs_disabled();
 
+	if (!irq_disabled) {
+		WARN_ONCE(1, "HLT instruction emulation unsafe with irqs enabled\n");
+		return -EIO;
+	}
+
 	if (__halt(irq_disabled))
 		return -EIO;
 
 	return ve_instr_len(ve);
 }
 
-void __cpuidle tdx_safe_halt(void)
+void __cpuidle tdx_idle(void)
 {
 	const bool irq_disabled = false;
 
@@ -397,6 +403,12 @@ void __cpuidle tdx_safe_halt(void)
 		WARN_ONCE(1, "HLT instruction emulation failed\n");
 }
 
+static void __cpuidle tdx_safe_halt(void)
+{
+	tdx_idle();
+	raw_local_irq_enable();
+}
+
 static int read_msr(struct pt_regs *regs, struct ve_info *ve)
 {
 	struct tdx_module_args args = {
@@ -1083,6 +1095,15 @@ void __init tdx_early_init(void)
 	x86_platform.guest.enc_kexec_begin	     = tdx_kexec_begin;
 	x86_platform.guest.enc_kexec_finish	     = tdx_kexec_finish;
 
+#ifdef CONFIG_PARAVIRT_XXL
+	/*
+	 * halt instruction execution is not atomic for TDX VMs as it generates
+	 * #VEs, so otherwise "safe" halt invocations which cause interrupts to
+	 * get enabled right after halt instruction don't work for TDX VMs.
+	 */
+	pv_ops.irq.safe_halt = tdx_safe_halt;
+#endif
+
 	/*
 	 * TDX intercepts the RDMSR to read the X2APIC ID in the parallel
 	 * bringup low level code. That raises #VE which cannot be handled
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index eba178996d84..dd386500ab1c 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -58,7 +58,7 @@ void tdx_get_ve_info(struct ve_info *ve);
 
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
 
-void tdx_safe_halt(void);
+void tdx_idle(void);
 
 bool tdx_early_handle_ve(struct pt_regs *regs);
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index f63f8fd00a91..4083838fe4a0 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -933,7 +933,7 @@ void __init select_idle_routine(void)
 		static_call_update(x86_idle, mwait_idle);
 	} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
 		pr_info("using TDX aware idle routine\n");
-		static_call_update(x86_idle, tdx_safe_halt);
+		static_call_update(x86_idle, tdx_idle);
 	} else {
 		static_call_update(x86_idle, default_idle);
 	}
-- 
2.48.1.262.g85cc9f2d1e-goog


