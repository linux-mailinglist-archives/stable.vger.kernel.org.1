Return-Path: <stable+bounces-160621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27946AFD106
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2099318941F0
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4312D2DEA78;
	Tue,  8 Jul 2025 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZSKrxXxe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FAB176ADB;
	Tue,  8 Jul 2025 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992196; cv=none; b=jEu9ZIVq41/rKlXDH1ZicTxgDk+VWkPr0k8g39tw5SusRoPBtWgJOSKMvwe1QiZS9ekG70NpZEXIJ+Sc/UFg8rq7kAp0/fpVzJHAn3nt4GRidu+SbeZdbN1ybGzgiH6Xp7QANTUX1G9C7e0KC1JUDfmOTf/Z7H/zE8e/AqlEwlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992196; c=relaxed/simple;
	bh=nY7GvBKAcf2dHHCfLWBfXS0EFOt7CA9zYkXsRqLeWyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d76Mm0kZV8Fho32zziSL3jXjRsbCGRX0cANcSoCNAj5G66T+MUT6rArjzXxlit+nwgpXky3cH9O8c8aVOsI00OM/mpKMBRlGgRiEXo7hn4z0lBqqtR76fwm0kp+OQKSukBHHTQM9xQAftXcA8rIuFTGSJPiJrbIYJifAdt3SUOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZSKrxXxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F6FC4CEED;
	Tue,  8 Jul 2025 16:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992195;
	bh=nY7GvBKAcf2dHHCfLWBfXS0EFOt7CA9zYkXsRqLeWyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZSKrxXxeOP2kxcCp8bpc5H/XiRC2smcsdrkgnoUQN72Lrnv5RB0tcFpjkCSjc5Lak
	 xaLlb6c006nsKHM4mBwb1tLG8kQ2+JN6yE+E0l0zumjTJOduslHGpwVTv7IltmWSXA
	 Mj0qRJJLWDysROQWdPAfp3ZiPguuj5H1I6zWxu4k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.1 81/81] x86/process: Move the buffer clearing before MONITOR
Date: Tue,  8 Jul 2025 18:24:13 +0200
Message-ID: <20250708162227.496631045@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162224.795155912@linuxfoundation.org>
References: <20250708162224.795155912@linuxfoundation.org>
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

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Commit 8e786a85c0a3c0fffae6244733fb576eeabd9dec upstream.

Move the VERW clearing before the MONITOR so that VERW doesn't disarm it
and the machine never enters C1.

Original idea by Kim Phillips <kim.phillips@amd.com>.

Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/mwait.h |   16 +++++++++++-----
 arch/x86/kernel/process.c    |   15 ++++++++++++---
 2 files changed, 23 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -44,8 +44,6 @@ static inline void __monitorx(const void
 
 static inline void __mwait(unsigned long eax, unsigned long ecx)
 {
-	x86_idle_clear_cpu_buffers();
-
 	/* "mwait %eax, %ecx;" */
 	asm volatile(".byte 0x0f, 0x01, 0xc9;"
 		     :: "a" (eax), "c" (ecx));
@@ -89,7 +87,6 @@ static inline void __mwaitx(unsigned lon
 
 static inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 {
-	x86_idle_clear_cpu_buffers();
 
 	/* "mwait %eax, %ecx;" */
 	asm volatile("sti; .byte 0x0f, 0x01, 0xc9;"
@@ -108,6 +105,11 @@ static inline void __sti_mwait(unsigned
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
@@ -116,9 +118,13 @@ static inline void mwait_idle_with_hints
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
 
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -887,6 +887,11 @@ static int prefer_mwait_c1_over_halt(con
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
@@ -895,13 +900,17 @@ static __cpuidle void mwait_idle(void)
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
 



