Return-Path: <stable+bounces-161972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB13DB05A60
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057F317CE41
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 12:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0452E0401;
	Tue, 15 Jul 2025 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDkqOVvv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F57F2E03E6
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583079; cv=none; b=NDXrpmTR2mtyJ66tGVoaa+kksokPPwKTFtSug566t4sBIDsXD18Ku/IGNubaDBqmCGOe0jla+F6p4ipuu1yU4GJLwYnwkMsRaQLtcudTKLLU+uIgbsLG42nBwKbOdMPf8B1UhoAbNz5PPPgS7C7uU3LjnqIUQW7X1yWMbZVhs9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583079; c=relaxed/simple;
	bh=3U8CioD//EHXa4TGtNQG4LsvdJb9pJ1awimIt098WcI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJ05T836ApxHJ5mph+naUYr/Prg3WX0Dcv22iOxf4GSF1mp6zTJsCj2Z9Ef4iDkE7ga4jFWtZOJr7hSX9+H+AvxdMyy0cRHITszzOtROPncmyxNYgJ2pTwbgzGL5kQqR1VE8V9BhMCoAVXrQrZ+4z6cc8gtKuKINKREru82wtRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDkqOVvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D7FC4CEF1;
	Tue, 15 Jul 2025 12:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752583078;
	bh=3U8CioD//EHXa4TGtNQG4LsvdJb9pJ1awimIt098WcI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MDkqOVvvsO11DKbJEW6Bu2hKw5bNQWnQMpbsVlxBN67llhuf6UasK0X/QTku9HoxI
	 zfZMXi0ztYDdDOnS8hAXRk7kP2mQX4tK09wl7tzPP4SplyclPJKWyOSMcklpa3xh8x
	 c7Cz99dXAD9UM4wBl2/yXJz2U9PcC6QQZU3u+ToP/BSN/Zq6vnJnke7gJHP1JuLCiC
	 L1GdVW0YqaOJERUk9lOTGmJ4KDAjFPIbrfyGgeoTwyIL8eP+rtXu/fkrClLBiRNUHJ
	 NKCkBNWBsxAf+cwmeNrwFJ760wEVL67pMdHMqVAlSrJrn5VZXDBm8QTtU4KGRSAXW2
	 Qb4QZAyZWCRhw==
From: Borislav Petkov <bp@kernel.org>
To: <stable@vger.kernel.org>
Subject: [PATCH 5/5] x86/process: Move the buffer clearing before MONITOR
Date: Tue, 15 Jul 2025 14:37:49 +0200
Message-ID: <20250715123749.4610-6-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715123749.4610-1-bp@kernel.org>
References: <20250715123749.4610-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Commit 8e786a85c0a3c0fffae6244733fb576eeabd9dec upstream.

Move the VERW clearing before the MONITOR so that VERW doesn't disarm it
and the machine never enters C1.

Original idea by Kim Phillips <kim.phillips@amd.com>.

Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/mwait.h | 16 +++++++++++-----
 arch/x86/kernel/process.c    | 15 ++++++++++++---
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 20b33e6370c3..2a2de4f3cb20 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -43,8 +43,6 @@ static inline void __monitorx(const void *eax, unsigned long ecx,
 
 static inline void __mwait(unsigned long eax, unsigned long ecx)
 {
-	x86_idle_clear_cpu_buffers();
-
 	/* "mwait %eax, %ecx;" */
 	asm volatile(".byte 0x0f, 0x01, 0xc9;"
 		     :: "a" (eax), "c" (ecx));
@@ -88,7 +86,6 @@ static inline void __mwaitx(unsigned long eax, unsigned long ebx,
 
 static inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 {
-	x86_idle_clear_cpu_buffers();
 
 	/* "mwait %eax, %ecx;" */
 	asm volatile("sti; .byte 0x0f, 0x01, 0xc9;"
@@ -107,6 +104,11 @@ static inline void __sti_mwait(unsigned long eax, unsigned long ecx)
  */
 static inline void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
 {
+	if (need_resched())
+		return;
+
+	x86_idle_clear_cpu_buffers();
+
 	if (static_cpu_has_bug(X86_BUG_MONITOR) || !current_set_polling_and_test()) {
 		if (static_cpu_has_bug(X86_BUG_CLFLUSH_MONITOR)) {
 			mb();
@@ -115,9 +117,13 @@ static inline void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
 		}
 
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
-		if (!need_resched())
-			__mwait(eax, ecx);
+		if (need_resched())
+			goto out;
+
+		__mwait(eax, ecx);
 	}
+
+out:
 	current_clr_polling();
 }
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 38c517a786f4..8f984b553590 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -819,6 +819,11 @@ static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
  */
 static __cpuidle void mwait_idle(void)
 {
+	if (need_resched())
+		return;
+
+	x86_idle_clear_cpu_buffers();
+
 	if (!current_set_polling_and_test()) {
 		if (this_cpu_has(X86_BUG_CLFLUSH_MONITOR)) {
 			mb(); /* quirk */
@@ -827,13 +832,17 @@ static __cpuidle void mwait_idle(void)
 		}
 
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
-		if (!need_resched())
-			__sti_mwait(0, 0);
-		else
+		if (need_resched()) {
 			raw_local_irq_enable();
+			goto out;
+		}
+
+		__sti_mwait(0, 0);
 	} else {
 		raw_local_irq_enable();
 	}
+
+out:
 	__current_clr_polling();
 }
 
-- 
2.43.0


