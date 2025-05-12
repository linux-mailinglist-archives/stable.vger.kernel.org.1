Return-Path: <stable+bounces-143579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAFFAB408A
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E613C7B3A27
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E86296FC8;
	Mon, 12 May 2025 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zhj2t0a5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E333A295DAB;
	Mon, 12 May 2025 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072409; cv=none; b=c7j6tHrg/QbH7HGihmZBeMoGnY5/MaW2/9fnfqPZ2vFKoicDmKV0AeO7dyvLGdc/HwunZbfbZBJu0Ty3C2q4ExjCVrqj0H5G5TB6E6LX1guB1bTMP1hfQxEYvX8ZxzewzUDp+30kNnLoZ1xu1R8lvrk7jty0ZQGvDeQBiLrZAuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072409; c=relaxed/simple;
	bh=+R2dQmVc4kr/3y5BJ3lisKAynpu9r8E1JNY1P/9lKL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ltfzuq6jFFiq0Lim9KuOQy9rVHwAJrGGUAsmljbUgeethvkPQbOkckhLVjpnLC8ocGARHCQFWwB6keXwccUxqFDes13n7LQoglVALJKxdeQYX8iaUwFsDRIh/NwcHSfyxwaEKpHGfERRXfcxoFfpH6+d/zfj6QXFXEBRyQ5ZQno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zhj2t0a5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E5DC4CEE7;
	Mon, 12 May 2025 17:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747072408;
	bh=+R2dQmVc4kr/3y5BJ3lisKAynpu9r8E1JNY1P/9lKL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zhj2t0a5Ta9Uyd/4jAsdXSlXT04jlNTg6vHKvE/YW0UtDfBD1nHX4npEWGLCJ1us8
	 xu7KOETV4C8H/Qod/fngy5N7LBSvFfnWS5SX9uy297LOHqgLrzvOKLtY7nKEXzMLzt
	 ub9Vhxm81uiFOrEMrrvsjLJc2H5aHXaMLs0UVFzM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Rik van Riel <riel@surriel.com>,
	Stephen Dolan <sdolan@janestreet.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.1 32/92] x86/mm: Eliminate window where TLB flushes may be inadvertently skipped
Date: Mon, 12 May 2025 19:45:07 +0200
Message-ID: <20250512172024.444793053@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172023.126467649@linuxfoundation.org>
References: <20250512172023.126467649@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Hansen <dave.hansen@linux.intel.com>

commit fea4e317f9e7e1f449ce90dedc27a2d2a95bee5a upstream.

tl;dr: There is a window in the mm switching code where the new CR3 is
set and the CPU should be getting TLB flushes for the new mm.  But
should_flush_tlb() has a bug and suppresses the flush.  Fix it by
widening the window where should_flush_tlb() sends an IPI.

Long Version:

=== History ===

There were a few things leading up to this.

First, updating mm_cpumask() was observed to be too expensive, so it was
made lazier.  But being lazy caused too many unnecessary IPIs to CPUs
due to the now-lazy mm_cpumask().  So code was added to cull
mm_cpumask() periodically[2].  But that culling was a bit too aggressive
and skipped sending TLB flushes to CPUs that need them.  So here we are
again.

=== Problem ===

The too-aggressive code in should_flush_tlb() strikes in this window:

	// Turn on IPIs for this CPU/mm combination, but only
	// if should_flush_tlb() agrees:
	cpumask_set_cpu(cpu, mm_cpumask(next));

	next_tlb_gen = atomic64_read(&next->context.tlb_gen);
	choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
	load_new_mm_cr3(need_flush);
	// ^ After 'need_flush' is set to false, IPIs *MUST*
	// be sent to this CPU and not be ignored.

        this_cpu_write(cpu_tlbstate.loaded_mm, next);
	// ^ Not until this point does should_flush_tlb()
	// become true!

should_flush_tlb() will suppress TLB flushes between load_new_mm_cr3()
and writing to 'loaded_mm', which is a window where they should not be
suppressed.  Whoops.

=== Solution ===

Thankfully, the fuzzy "just about to write CR3" window is already marked
with loaded_mm==LOADED_MM_SWITCHING.  Simply checking for that state in
should_flush_tlb() is sufficient to ensure that the CPU is targeted with
an IPI.

This will cause more TLB flush IPIs.  But the window is relatively small
and I do not expect this to cause any kind of measurable performance
impact.

Update the comment where LOADED_MM_SWITCHING is written since it grew
yet another user.

Peter Z also raised a concern that should_flush_tlb() might not observe
'loaded_mm' and 'is_lazy' in the same order that switch_mm_irqs_off()
writes them.  Add a barrier to ensure that they are observed in the
order they are written.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Rik van Riel <riel@surriel.com>
Link: https://lore.kernel.org/oe-lkp/202411282207.6bd28eae-lkp@intel.com/ [1]
Fixes: 6db2526c1d69 ("x86/mm/tlb: Only trim the mm_cpumask once a second") [2]
Reported-by: Stephen Dolan <sdolan@janestreet.com>
Cc: stable@vger.kernel.org
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/mm/tlb.c |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -617,7 +617,11 @@ void switch_mm_irqs_off(struct mm_struct
 
 		choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
 
-		/* Let nmi_uaccess_okay() know that we're changing CR3. */
+		/*
+		 * Indicate that CR3 is about to change. nmi_uaccess_okay()
+		 * and others are sensitive to the window where mm_cpumask(),
+		 * CR3 and cpu_tlbstate.loaded_mm are not all in sync.
+ 		 */
 		this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
 		barrier();
 	}
@@ -880,8 +884,16 @@ done:
 
 static bool should_flush_tlb(int cpu, void *data)
 {
+	struct mm_struct *loaded_mm = per_cpu(cpu_tlbstate.loaded_mm, cpu);
 	struct flush_tlb_info *info = data;
 
+	/*
+	 * Order the 'loaded_mm' and 'is_lazy' against their
+	 * write ordering in switch_mm_irqs_off(). Ensure
+	 * 'is_lazy' is at least as new as 'loaded_mm'.
+	 */
+	smp_rmb();
+
 	/* Lazy TLB will get flushed at the next context switch. */
 	if (per_cpu(cpu_tlbstate_shared.is_lazy, cpu))
 		return false;
@@ -890,8 +902,15 @@ static bool should_flush_tlb(int cpu, vo
 	if (!info->mm)
 		return true;
 
+	/*
+	 * While switching, the remote CPU could have state from
+	 * either the prev or next mm. Assume the worst and flush.
+	 */
+	if (loaded_mm == LOADED_MM_SWITCHING)
+		return true;
+
 	/* The target mm is loaded, and the CPU is not lazy. */
-	if (per_cpu(cpu_tlbstate.loaded_mm, cpu) == info->mm)
+	if (loaded_mm == info->mm)
 		return true;
 
 	/* In cpumask, but not the loaded mm? Periodically remove by flushing. */



