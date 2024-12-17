Return-Path: <stable+bounces-104498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C42AE9F4C00
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 14:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341DE178214
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 13:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7581E1F4E36;
	Tue, 17 Dec 2024 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jAZYWaZw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5gvWdi56"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CDE1F4263;
	Tue, 17 Dec 2024 13:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440999; cv=none; b=F+hqM9sNJ6cTOAUlfA/ax+u9iiOi7FvMSuIWHlFQNRY0Exqnz9rpc3YCDOUB0WW60MNFhaqupzy/mZj0qraoREpZZsHqFMUNhXVtSCoSUGsg8dmqTfb81UossBIrPvFCCHWPKHlDQ14os1aoJrUpGha1nXC7M9AuzL2iiwj0M7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440999; c=relaxed/simple;
	bh=cgvsMxYlUm341r3hrTMydeHDObjyzjEs7Sn9f5zqtVM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=N5aUwvRuYBjTcQOaxpM6trFVZp0McjjfYNCNg/8iGl6YxAko77Fb+A4H5NxIdeTPUkzQYefnb3QmwXtJSpk0PhAHfh5cmXLygySClz/++2H7xVgnBaMcl8Df6708sVxjjd3MgG+rncqoiCf4BHAG8fftCzoTSEANEZnyRrK3X/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jAZYWaZw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5gvWdi56; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Dec 2024 13:09:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734440995;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=41MvN9btwUR5UYatfG2r5w3WpfpcL0bYPrX5w1+/Cg8=;
	b=jAZYWaZw05/Tz3DUOtxgWTwuTFgELbT72wpVJaHNSVXqR9AazV0+L0+RiM4B1BmwIxgnsN
	6L/C1CkqkywmfsnMWTuOdhfrQAFA6E4YaC/ASZWY/y0vKKCMMQ7YVb2duTrRQqh6iCbaHY
	XcJeV1hyyV+u/5Ah4to63PHRjpAj5SwzJAdzPJEHduaFI2xvVPyOaIbPwiAWllMill1706
	hIZGSOw1LgQk6qNKLyZ7fyoeqXLTe8Io67PSY89UAVCKdY9WrTAx1xfR5b+S8eLrx5j5y6
	zLevJ+U2b9aVFh14mbj47SjtINnM7kp+0o4CAVXtKrDztTsA6ESJX9Q8mBES4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734440995;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=41MvN9btwUR5UYatfG2r5w3WpfpcL0bYPrX5w1+/Cg8=;
	b=5gvWdi56txrZueosho1olTWThdRpL2MfDKEKte1kTbFJy2hFtv9eq5lo+3fnGAMHhF2ddU
	3s+0ZT4XdrraimAw==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fred: Clear WFE in missing-ENDBRANCH #CPs
Cc: "Xin Li (Intel)" <xin@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173444099482.7135.8631452864658460320.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e8b345babf2ace50f6bf380af77ee8ae415d81f2
Gitweb:        https://git.kernel.org/tip/e8b345babf2ace50f6bf380af77ee8ae415d81f2
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Wed, 13 Nov 2024 09:59:34 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 16 Dec 2024 15:44:19 -08:00

x86/fred: Clear WFE in missing-ENDBRANCH #CPs

An indirect branch instruction sets the CPU indirect branch tracker
(IBT) into WAIT_FOR_ENDBRANCH (WFE) state and WFE stays asserted
across the instruction boundary.  When the decoder finds an
inappropriate instruction while WFE is set ENDBR, the CPU raises a #CP
fault.

For the "kernel IBT no ENDBR" selftest where #CPs are deliberately
triggered, the WFE state of the interrupted context needs to be
cleared to let execution continue.  Otherwise when the CPU resumes
from the instruction that just caused the previous #CP, another
missing-ENDBRANCH #CP is raised and the CPU enters a dead loop.

This is not a problem with IDT because it doesn't preserve WFE and
IRET doesn't set WFE.  But FRED provides space on the entry stack
(in an expanded CS area) to save and restore the WFE state, thus the
WFE state is no longer clobbered, so software must clear it.

Clear WFE to avoid dead looping in ibt_clear_fred_wfe() and the
!ibt_fatal code path when execution is allowed to continue.

Clobbering WFE in any other circumstance is a security-relevant bug.

[ dhansen: changelog rewording ]

Fixes: a5f6c2ace997 ("x86/shstk: Add user control-protection fault handler")
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20241113175934.3897541-1-xin%40zytor.com
---
 arch/x86/kernel/cet.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index d2c732a..303bf74 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -81,6 +81,34 @@ static void do_user_cp_fault(struct pt_regs *regs, unsigned long error_code)
 
 static __ro_after_init bool ibt_fatal = true;
 
+/*
+ * By definition, all missing-ENDBRANCH #CPs are a result of WFE && !ENDBR.
+ *
+ * For the kernel IBT no ENDBR selftest where #CPs are deliberately triggered,
+ * the WFE state of the interrupted context needs to be cleared to let execution
+ * continue.  Otherwise when the CPU resumes from the instruction that just
+ * caused the previous #CP, another missing-ENDBRANCH #CP is raised and the CPU
+ * enters a dead loop.
+ *
+ * This is not a problem with IDT because it doesn't preserve WFE and IRET doesn't
+ * set WFE.  But FRED provides space on the entry stack (in an expanded CS area)
+ * to save and restore the WFE state, thus the WFE state is no longer clobbered,
+ * so software must clear it.
+ */
+static void ibt_clear_fred_wfe(struct pt_regs *regs)
+{
+	/*
+	 * No need to do any FRED checks.
+	 *
+	 * For IDT event delivery, the high-order 48 bits of CS are pushed
+	 * as 0s into the stack, and later IRET ignores these bits.
+	 *
+	 * For FRED, a test to check if fred_cs.wfe is set would be dropped
+	 * by compilers.
+	 */
+	regs->fred_cs.wfe = 0;
+}
+
 static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
 {
 	if ((error_code & CP_EC) != CP_ENDBR) {
@@ -90,6 +118,7 @@ static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
 
 	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_noendbr)) {
 		regs->ax = 0;
+		ibt_clear_fred_wfe(regs);
 		return;
 	}
 
@@ -97,6 +126,7 @@ static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
 	if (!ibt_fatal) {
 		printk(KERN_DEFAULT CUT_HERE);
 		__warn(__FILE__, __LINE__, (void *)regs->ip, TAINT_WARN, regs, NULL);
+		ibt_clear_fred_wfe(regs);
 		return;
 	}
 	BUG();

