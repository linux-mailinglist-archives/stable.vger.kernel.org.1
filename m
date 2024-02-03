Return-Path: <stable+bounces-18676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED478483AA
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16CBD1F25F00
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFAE55E6C;
	Sat,  3 Feb 2024 04:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e0LyPxnZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCAA55E5E;
	Sat,  3 Feb 2024 04:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933975; cv=none; b=HiQf7IdJge+LAfJNWEdpJAmZh7vXLDKg7es9WkaVUHBBYmfDyfC6L/RONQybWmxsl5ekKAC36yQTmMD/ErNqDkB82obUMDaCCYeTwnX47i4rgPXOmVL/pi4/wvw00yvsm5KzXIrBWxlKxMQsNxtWpZoD3oIh8tvnkSFQkCyZK+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933975; c=relaxed/simple;
	bh=ivQhcQ/4xe0DbkiR+7ILps5BzoP3knygD/RHbmGSDng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItF6HRH2Ka3qqXpbWADMq0WDULrRJqZZ+2LynFu/6OpQgJ3DRQef7SXE2jKNjGeF1Ohb4p3gF5sr6vOICsLrEh951CMsjUU8tLsKdhqE+5m2Qquc7OU3tZSJ+2azBzYoM2viQrbsqNM3ofzrbsupqVy7stNO79KVNjqDGpQbZxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e0LyPxnZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF54C43394;
	Sat,  3 Feb 2024 04:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933975;
	bh=ivQhcQ/4xe0DbkiR+7ILps5BzoP3knygD/RHbmGSDng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e0LyPxnZxb7yDc0eEX1GETIqHNrzRAhoxgjEcHOa6hG3HgtJ2R+aScWMVI5XPKmNW
	 wLCqzzmWiKtbP1ooFyt8lCLkRsX7VAVDjBt+W5ddU4874AXql83QZKUtNKQHw/2Ir3
	 5IO8E+7yewmRBTY7tsI+3q8D7DBc+KfkoGBqhzDE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	syzbot+93a9e8a3dea8d6085e12@syzkaller.appspotmail.com,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.7 349/353] mm, kmsan: fix infinite recursion due to RCU critical section
Date: Fri,  2 Feb 2024 20:07:47 -0800
Message-ID: <20240203035414.786862901@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
References: <20240203035403.657508530@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marco Elver <elver@google.com>

commit f6564fce256a3944aa1bc76cb3c40e792d97c1eb upstream.

Alexander Potapenko writes in [1]: "For every memory access in the code
instrumented by KMSAN we call kmsan_get_metadata() to obtain the metadata
for the memory being accessed.  For virtual memory the metadata pointers
are stored in the corresponding `struct page`, therefore we need to call
virt_to_page() to get them.

According to the comment in arch/x86/include/asm/page.h,
virt_to_page(kaddr) returns a valid pointer iff virt_addr_valid(kaddr) is
true, so KMSAN needs to call virt_addr_valid() as well.

To avoid recursion, kmsan_get_metadata() must not call instrumented code,
therefore ./arch/x86/include/asm/kmsan.h forks parts of
arch/x86/mm/physaddr.c to check whether a virtual address is valid or not.

But the introduction of rcu_read_lock() to pfn_valid() added instrumented
RCU API calls to virt_to_page_or_null(), which is called by
kmsan_get_metadata(), so there is an infinite recursion now.  I do not
think it is correct to stop that recursion by doing
kmsan_enter_runtime()/kmsan_exit_runtime() in kmsan_get_metadata(): that
would prevent instrumented functions called from within the runtime from
tracking the shadow values, which might introduce false positives."

Fix the issue by switching pfn_valid() to the _sched() variant of
rcu_read_lock/unlock(), which does not require calling into RCU.  Given
the critical section in pfn_valid() is very small, this is a reasonable
trade-off (with preemptible RCU).

KMSAN further needs to be careful to suppress calls into the scheduler,
which would be another source of recursion.  This can be done by wrapping
the call to pfn_valid() into preempt_disable/enable_no_resched().  The
downside is that this sacrifices breaking scheduling guarantees; however,
a kernel compiled with KMSAN has already given up any performance
guarantees due to being heavily instrumented.

Note, KMSAN code already disables tracing via Makefile, and since mmzone.h
is included, it is not necessary to use the notrace variant, which is
generally preferred in all other cases.

Link: https://lkml.kernel.org/r/20240115184430.2710652-1-glider@google.com [1]
Link: https://lkml.kernel.org/r/20240118110022.2538350-1-elver@google.com
Fixes: 5ec8e8ea8b77 ("mm/sparsemem: fix race in accessing memory_section->usage")
Signed-off-by: Marco Elver <elver@google.com>
Reported-by: Alexander Potapenko <glider@google.com>
Reported-by: syzbot+93a9e8a3dea8d6085e12@syzkaller.appspotmail.com
Reviewed-by: Alexander Potapenko <glider@google.com>
Tested-by: Alexander Potapenko <glider@google.com>
Cc: Charan Teja Kalla <quic_charante@quicinc.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/kmsan.h |   17 ++++++++++++++++-
 include/linux/mmzone.h       |    6 +++---
 2 files changed, 19 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/kmsan.h
+++ b/arch/x86/include/asm/kmsan.h
@@ -64,6 +64,7 @@ static inline bool kmsan_virt_addr_valid
 {
 	unsigned long x = (unsigned long)addr;
 	unsigned long y = x - __START_KERNEL_map;
+	bool ret;
 
 	/* use the carry flag to determine if x was < __START_KERNEL_map */
 	if (unlikely(x > y)) {
@@ -79,7 +80,21 @@ static inline bool kmsan_virt_addr_valid
 			return false;
 	}
 
-	return pfn_valid(x >> PAGE_SHIFT);
+	/*
+	 * pfn_valid() relies on RCU, and may call into the scheduler on exiting
+	 * the critical section. However, this would result in recursion with
+	 * KMSAN. Therefore, disable preemption here, and re-enable preemption
+	 * below while suppressing reschedules to avoid recursion.
+	 *
+	 * Note, this sacrifices occasionally breaking scheduling guarantees.
+	 * Although, a kernel compiled with KMSAN has already given up on any
+	 * performance guarantees due to being heavily instrumented.
+	 */
+	preempt_disable();
+	ret = pfn_valid(x >> PAGE_SHIFT);
+	preempt_enable_no_resched();
+
+	return ret;
 }
 
 #endif /* !MODULE */
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2025,9 +2025,9 @@ static inline int pfn_valid(unsigned lon
 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
 		return 0;
 	ms = __pfn_to_section(pfn);
-	rcu_read_lock();
+	rcu_read_lock_sched();
 	if (!valid_section(ms)) {
-		rcu_read_unlock();
+		rcu_read_unlock_sched();
 		return 0;
 	}
 	/*
@@ -2035,7 +2035,7 @@ static inline int pfn_valid(unsigned lon
 	 * the entire section-sized span.
 	 */
 	ret = early_section(ms) || pfn_section_valid(ms, pfn);
-	rcu_read_unlock();
+	rcu_read_unlock_sched();
 
 	return ret;
 }



