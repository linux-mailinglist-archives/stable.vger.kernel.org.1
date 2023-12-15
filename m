Return-Path: <stable+bounces-6802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F57B81468B
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 12:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E831F23AC9
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 11:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8FD249EF;
	Fri, 15 Dec 2023 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0y4gHNh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5937E182DA
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 11:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6824C433C7;
	Fri, 15 Dec 2023 11:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702638935;
	bh=QSNT01E74INUO3XKAiZ1mUN0f5tnC4wCPhE7206tvkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l0y4gHNhc+2+R9H4DB/JAI6ucOIgOrwo3jnu2DpWq1Vsu7RFf3SEcoLKYLG4gtgyr
	 EqA6LlF2EuCABpu+0kE4/0J5GMPjYsEjK7S9p+sarnrLNcoXs6SgtL2PCZu4OMerO7
	 cY2Vk7wbcLwHoRxbCOSe3q0Hp2VUcXAYK5cLt89GsBvMQm8PWyYyfVwYD3QuY/0+7N
	 Y7rUE3DVJUCC7cHVXvw7AjBLPFvJxW4XSQiRnclf25N/eAhGUj7iGxKLhzigw0lmzb
	 kYOkzye2TOnUzAtPCXeE9Bn4SNOedteopvPtpYTmMNRc213IOCe+DekGLo9WPl7Hj0
	 sprWdX2rQE3oQ==
From: Naveen N Rao <naveen@kernel.org>
To: <stable@vger.kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.19.y 2/2] powerpc/ftrace: Fix stack teardown in ftrace_no_trace
Date: Fri, 15 Dec 2023 16:42:39 +0530
Message-ID: <20231215111239.2361924-2-naveen@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215111239.2361924-1-naveen@kernel.org>
References: <2023080739-bonehead-overexert-ce34@gregkh>
 <20231215111239.2361924-1-naveen@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 4b3338aaa74d7d4ec5b6734dc298f0db94ec83d2 upstream.

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
---
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index 12e19625d6c2..6802cc2592d5 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -59,7 +59,7 @@ _GLOBAL(ftrace_regs_caller)
 	SAVE_10GPRS(22, r1)
 
 	/* Save previous stack pointer (r1) */
-	addi	r8, r1, SWITCH_FRAME_SIZE
+	addi	r8, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
 	std	r8, GPR1(r1)
 
 	/* Load special regs for save below */
@@ -154,7 +154,7 @@ ftrace_no_trace:
 	mflr	r3
 	mtctr	r3
 	REST_GPR(3, r1)
-	addi	r1, r1, SWITCH_FRAME_SIZE
+	addi	r1, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
 	mtlr	r0
 	bctr
 
-- 
2.43.0


