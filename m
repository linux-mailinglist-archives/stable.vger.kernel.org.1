Return-Path: <stable+bounces-106254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 941CF9FE3BB
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 09:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B843A1F19
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 08:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A891A0730;
	Mon, 30 Dec 2024 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e12XRndJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9A119F430
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735547726; cv=none; b=cHRv2mvQg2sUDAsze7hHXwMkEyrV2td49h2GRj3+KNlIg3ocHaSeh8Rgz5aD6Z87aQe2lShMYY0A7wZIhtJ2p9hC9pDGP/Ys5qjbe6nYqdS8Jdb17rNko2zq/yPAeVC5OTO/vTJhNIUlph2WcMIeMJYrpvpxFhY+RK8TVTjRANM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735547726; c=relaxed/simple;
	bh=RUp63lGfFvpGF4FoRqGJcQ/h2QQL9Idal0Gq2hYMBZA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VrJ9+tzIfbSdtEMMQu0mo5mwgT0tVhHm70viIoDr5qQlRD3KED4yZOOqxJkQlwiirRuy/fSh4D1jiLgBSIyptPh5IsweRfMASkAKeVelZRFf8cJxWw3i7T3FoV5OKy3BGS33u5p+mIQY58/9ZyzV4nbW6vkqSc16AfLWyBCI4tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e12XRndJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E6FC4CED0;
	Mon, 30 Dec 2024 08:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735547726;
	bh=RUp63lGfFvpGF4FoRqGJcQ/h2QQL9Idal0Gq2hYMBZA=;
	h=Subject:To:Cc:From:Date:From;
	b=e12XRndJedS2Bx8xILAoT6FM5Hl9ij3kPjWRqK8YnAeyXEEM9fQDyvZo6StVs9eos
	 EFZi+KC8kRwsW0+2D2p7flJAyiHIOiWm258CvU6WXZJhrUz8/BCIZnuz/QSAeai59V
	 hU1abPtVDuKU7UrGlv0LOglWzek234Jh0WGwvCcM=
Subject: FAILED: patch "[PATCH] x86/fred: Clear WFE in missing-ENDBRANCH #CPs" failed to apply to 6.6-stable tree
To: xin@zytor.com,dave.hansen@linux.intel.com,mingo@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Dec 2024 09:35:23 +0100
Message-ID: <2024123023-arise-undercook-60f9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x dc81e556f2a017d681251ace21bf06c126d5a192
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024123023-arise-undercook-60f9@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dc81e556f2a017d681251ace21bf06c126d5a192 Mon Sep 17 00:00:00 2001
From: "Xin Li (Intel)" <xin@zytor.com>
Date: Wed, 13 Nov 2024 09:59:34 -0800
Subject: [PATCH] x86/fred: Clear WFE in missing-ENDBRANCH #CPs

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20241113175934.3897541-1-xin%40zytor.com

diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index d2c732a34e5d..303bf74d175b 100644
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


