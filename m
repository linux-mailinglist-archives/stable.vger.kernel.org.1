Return-Path: <stable+bounces-5327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDECC80CA39
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B8A1F217D4
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E473C064;
	Mon, 11 Dec 2023 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fwkgrvNi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF00F3BB2B
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 12:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B85C433CA;
	Mon, 11 Dec 2023 12:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702299014;
	bh=DjQaYJdvhacXS3heG04xLkvW2ccOwaNtdjclDVB/STg=;
	h=Subject:To:Cc:From:Date:From;
	b=fwkgrvNiP0sRLmUOjAdhuelX4vsRPz63yFBvSaijoyLFYk2gbHYRjq+vNTMbrFklZ
	 B9IA/Sj/gY3gVLMkIf/nwiM1Mp5ThjoMJQ/n2MxEzIC0i04BN8vfKnuok8i+nU9EKd
	 tFctBB79ws5gPiOVk/TRe0FmW//J15rRl3QeHwiA=
Subject: FAILED: patch "[PATCH] powerpc/ftrace: Fix stack teardown in ftrace_no_trace" failed to apply to 6.1-stable tree
To: naveen@kernel.org,mpe@ellerman.id.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 11 Dec 2023 13:50:12 +0100
Message-ID: <2023121112-image-dreadlock-4677@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4b3338aaa74d7d4ec5b6734dc298f0db94ec83d2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023121112-image-dreadlock-4677@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

4b3338aaa74d ("powerpc/ftrace: Fix stack teardown in ftrace_no_trace")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4b3338aaa74d7d4ec5b6734dc298f0db94ec83d2 Mon Sep 17 00:00:00 2001
From: Naveen N Rao <naveen@kernel.org>
Date: Thu, 30 Nov 2023 12:29:47 +0530
Subject: [PATCH] powerpc/ftrace: Fix stack teardown in ftrace_no_trace

Commit 41a506ef71eb ("powerpc/ftrace: Create a dummy stackframe to fix
stack unwind") added use of a new stack frame on ftrace entry to fix
stack unwind. However, the commit missed updating the offset used while
tearing down the ftrace stack when ftrace is disabled. Fix the same.

In addition, the commit missed saving the correct stack pointer in
pt_regs. Update the same.

Fixes: 41a506ef71eb ("powerpc/ftrace: Create a dummy stackframe to fix stack unwind")
Cc: stable@vger.kernel.org # v6.5+
Signed-off-by: Naveen N Rao <naveen@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231130065947.2188860-1-naveen@kernel.org

diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S b/arch/powerpc/kernel/trace/ftrace_entry.S
index 90701885762c..40677416d7b2 100644
--- a/arch/powerpc/kernel/trace/ftrace_entry.S
+++ b/arch/powerpc/kernel/trace/ftrace_entry.S
@@ -62,7 +62,7 @@
 	.endif
 
 	/* Save previous stack pointer (r1) */
-	addi	r8, r1, SWITCH_FRAME_SIZE
+	addi	r8, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
 	PPC_STL	r8, GPR1(r1)
 
 	.if \allregs == 1
@@ -182,7 +182,7 @@ ftrace_no_trace:
 	mflr	r3
 	mtctr	r3
 	REST_GPR(3, r1)
-	addi	r1, r1, SWITCH_FRAME_SIZE
+	addi	r1, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
 	mtlr	r0
 	bctr
 #endif


