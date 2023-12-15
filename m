Return-Path: <stable+bounces-6804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0505081468D
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 12:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37ACB1C22DBB
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 11:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D495249EF;
	Fri, 15 Dec 2023 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAkSQ5tr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B431C292
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 11:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178F4C433C8;
	Fri, 15 Dec 2023 11:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702638944;
	bh=hd4e2lV5ChQziGpxO0vExderVTsEU3Yjco23mKtv63s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QAkSQ5tr+USy1TV1kiHotBKcYYQiTmT7FtKm2KEZO5/s2Tg3SwjtwlTmRdzmE6HqY
	 LrVvNTh9RDs8rAMRLjE8QW9XflE9t88fV5b7GGhIV2xTALGv+suqHy1IHbTIUtZp3l
	 G6gi8z99LcCkSwCTTG12zZhwpxhcQdeeH9B8dWTHqJJd5/X8vta1yehEzh7uvMsNoi
	 UV5yVubyHehOYtNo//XSVd+oeHha/n36znpVcDW7px3KUnhdf9d5g2fjdm9TvAz0VM
	 E19QyBabxj0VWjNOvjRyWenVvxr4aqZPZ5ibuqbGJ5F3WYxyu/Mf97Cyq2EUwOMnwW
	 G+0KHXnnpHwdA==
From: Naveen N Rao <naveen@kernel.org>
To: <stable@vger.kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.4.y 2/2] powerpc/ftrace: Fix stack teardown in ftrace_no_trace
Date: Fri, 15 Dec 2023 16:43:29 +0530
Message-ID: <20231215111329.2362254-2-naveen@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215111329.2362254-1-naveen@kernel.org>
References: <2023080737-guileless-magazine-d8dc@gregkh>
 <20231215111329.2362254-1-naveen@kernel.org>
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
index da2ca0c6c2c4..0bc39ff53233 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -55,7 +55,7 @@ _GLOBAL(ftrace_regs_caller)
 	SAVE_10GPRS(22, r1)
 
 	/* Save previous stack pointer (r1) */
-	addi	r8, r1, SWITCH_FRAME_SIZE
+	addi	r8, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
 	std	r8, GPR1(r1)
 
 	/* Load special regs for save below */
@@ -150,7 +150,7 @@ ftrace_no_trace:
 	mflr	r3
 	mtctr	r3
 	REST_GPR(3, r1)
-	addi	r1, r1, SWITCH_FRAME_SIZE
+	addi	r1, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
 	mtlr	r0
 	bctr
 
-- 
2.43.0


