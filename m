Return-Path: <stable+bounces-6800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 486A6814689
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 12:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEA3CB224FE
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 11:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466DA208BD;
	Fri, 15 Dec 2023 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zq5z3rR6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8E124A15
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 11:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF6FC433C8;
	Fri, 15 Dec 2023 11:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702638925;
	bh=cB+fXHTW9zNtXvpk3mkm3iJL6ascYsGsc/hROd0YjMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zq5z3rR64dmuT+ZmmdOKQqqvkoHHID1Rcyzt7BFYGa33oeaz9advg8VhBiUVq5Lf5
	 JBEYJ16iDxxFX2G+R5Q2LZGVkJ9yJDGIFPU6CtRy9Vg3QQNb/VAxmY6n3Dlf8vjB5f
	 dyJ8qUDETwpWTQzfyOpPSHoBlzV2BoK2wuMqA6AHORdDeyBNqnYmJAwZqyzG7IUlqp
	 CTzGK/62e/GE6FQ0+nqp4twoeUsM5A7yoDC5f5UixRDYhvk/rjlWHb27UElNZxtzYa
	 5m5wVBLNeiEvka6dILuxYRdYhqgYjD3gMxpnqtO05WdAvIbDruksGb/0M+rS+a4iKs
	 9K4VW/23yHpPQ==
From: Naveen N Rao <naveen@kernel.org>
To: <stable@vger.kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14.y 2/2] powerpc/ftrace: Fix stack teardown in ftrace_no_trace
Date: Fri, 15 Dec 2023 16:41:22 +0530
Message-ID: <20231215111122.2361478-2-naveen@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215111122.2361478-1-naveen@kernel.org>
References: <2023080741-polka-twice-b0df@gregkh>
 <20231215111122.2361478-1-naveen@kernel.org>
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
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index ee66f4877042..b77949c8e031 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -54,7 +54,7 @@ _GLOBAL(ftrace_caller)
 	SAVE_10GPRS(22, r1)
 
 	/* Save previous stack pointer (r1) */
-	addi	r8, r1, SWITCH_FRAME_SIZE
+	addi	r8, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
 	std	r8, GPR1(r1)
 
 	/* Load special regs for save below */
-- 
2.43.0


