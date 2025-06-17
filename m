Return-Path: <stable+bounces-152893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDB1ADD156
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE4797A5404
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1AC2EB5AD;
	Tue, 17 Jun 2025 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TghcRuTR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2762EBDC7;
	Tue, 17 Jun 2025 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174121; cv=none; b=UWRqDCtqWph+JdHVr7ZZI5Mc6D+nHUitCoBVmCLLHB4UTGpeUSv3XRAsK19T6//vz7Cr1KcnTG/lnAA78u4Xc8htmt7CtVMi70ePX6AKn2wAHGKfw75S+lLwGZOj7PSWHeYEzx3SayvwXxwzpLtgeTK/gcWdrwHTvdRsRPb6sBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174121; c=relaxed/simple;
	bh=OkNwazgR1FTUl6j/uJxmGgRLDkpDqAvH7sTAhw81n7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pi0+9YJWLztk6bSbw8dYeVW/TAr1jDImvRebbvs73S4QNkjqz+pKUPQYEyFYNfrQG6pOrKFCG5I7Q8nKDJsPD2Kf4P6VgdCRkM6QwOkhP5gysfU5WaxCtbq8pcfeFPvMXRV8rilF6fAWZbeRAL//U7UtGS4pvzR2u4q1/XYoRHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TghcRuTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C2EC4CEE7;
	Tue, 17 Jun 2025 15:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750174120;
	bh=OkNwazgR1FTUl6j/uJxmGgRLDkpDqAvH7sTAhw81n7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TghcRuTRCqbLzl9AYn6hEghlY5qa1uRKY4xAqG1vvQD1AnCDBrdWQ+DItJNegtGHP
	 tpkKsFhvWjViGoJRbur6LJdA/sn6s3k1Iz+6/8WO+91NtdBJyC48nuL5JMrf1IxGQ4
	 liTOgPsacwqbBIQurzNwCfbjitCEK7Ga9iC+9p+c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Juergen Gross <jgross@suse.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 002/512] x86/idle: Remove MFENCEs for X86_BUG_CLFLUSH_MONITOR in mwait_idle_with_hints() and prefer_mwait_c1_over_halt()
Date: Tue, 17 Jun 2025 17:19:28 +0200
Message-ID: <20250617152419.622968266@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Cooper <andrew.cooper3@citrix.com>

[ Upstream commit 1f13c60d84e880df6698441026e64f84c7110c49 ]

The following commit, 12 years ago:

  7e98b7192046 ("x86, idle: Use static_cpu_has() for CLFLUSH workaround, add barriers")

added barriers around the CLFLUSH in mwait_idle_with_hints(), justified with:

  ... and add memory barriers around it since the documentation is explicit
  that CLFLUSH is only ordered with respect to MFENCE.

This also triggered, 11 years ago, the same adjustment in:

  f8e617f45829 ("sched/idle/x86: Optimize unnecessary mwait_idle() resched IPIs")

during development, although it failed to get the static_cpu_has_bug() treatment.

X86_BUG_CLFLUSH_MONITOR (a.k.a the AAI65 errata) is specific to Intel CPUs,
and the SDM currently states:

  Executions of the CLFLUSH instruction are ordered with respect to each
  other and with respect to writes, locked read-modify-write instructions,
  and fence instructions[1].

With footnote 1 reading:

  Earlier versions of this manual specified that executions of the CLFLUSH
  instruction were ordered only by the MFENCE instruction.  All processors
  implementing the CLFLUSH instruction also order it relative to the other
  operations enumerated above.

i.e. The SDM was incorrect at the time, and barriers should not have been
inserted.  Double checking the original AAI65 errata (not available from
intel.com any more) shows no mention of barriers either.

Note: If this were a general codepath, the MFENCEs would be needed, because
      AMD CPUs of the same vintage do sport otherwise-unordered CLFLUSHs.

Remove the unnecessary barriers. Furthermore, use a plain alternative(),
rather than static_cpu_has_bug() and/or no optimisation.  The workaround
is a single instruction.

Use an explicit %rax pointer rather than a general memory operand, because
MONITOR takes the pointer implicitly in the same way.

[ mingo: Cleaned up the commit a bit. ]

Fixes: 7e98b7192046 ("x86, idle: Use static_cpu_has() for CLFLUSH workaround, add barriers")
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20250402172458.1378112-1-andrew.cooper3@citrix.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/mwait.h | 9 +++------
 arch/x86/kernel/process.c    | 9 +++------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 920426d691ce7..3e4e85f71a6ad 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -117,13 +117,10 @@ static __always_inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
 {
 	if (static_cpu_has_bug(X86_BUG_MONITOR) || !current_set_polling_and_test()) {
-		if (static_cpu_has_bug(X86_BUG_CLFLUSH_MONITOR)) {
-			mb();
-			clflush((void *)&current_thread_info()->flags);
-			mb();
-		}
+		const void *addr = &current_thread_info()->flags;
 
-		__monitor((void *)&current_thread_info()->flags, 0, 0);
+		alternative_input("", "clflush (%[addr])", X86_BUG_CLFLUSH_MONITOR, [addr] "a" (addr));
+		__monitor(addr, 0, 0);
 
 		if (!need_resched()) {
 			if (ecx & 1) {
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index c7ce3655b7078..8a9ddc4adf51b 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -906,13 +906,10 @@ static __init bool prefer_mwait_c1_over_halt(void)
 static __cpuidle void mwait_idle(void)
 {
 	if (!current_set_polling_and_test()) {
-		if (this_cpu_has(X86_BUG_CLFLUSH_MONITOR)) {
-			mb(); /* quirk */
-			clflush((void *)&current_thread_info()->flags);
-			mb(); /* quirk */
-		}
+		const void *addr = &current_thread_info()->flags;
 
-		__monitor((void *)&current_thread_info()->flags, 0, 0);
+		alternative_input("", "clflush (%[addr])", X86_BUG_CLFLUSH_MONITOR, [addr] "a" (addr));
+		__monitor(addr, 0, 0);
 		if (!need_resched()) {
 			__sti_mwait(0, 0);
 			raw_local_irq_disable();
-- 
2.39.5




