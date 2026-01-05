Return-Path: <stable+bounces-204763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AAACF3B47
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6DAD319F6AE
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 12:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52330346E4F;
	Mon,  5 Jan 2026 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lZFsbVRq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1244E346E4E
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767617925; cv=none; b=JDuLBd0UYgVLCUlfUd5N+oAwY8AbPzC6VekPDnHBqULldrFKD5nDhtM7YNdCosbVuHhvGiZ0nBb37/uAFBwkZxNm/+txFvMqhoy9HGZhPXsL+4uAbEhDQObiEa2buHSArDaaL7f/llxiZTfbKnmilOqERMnwlGo2Y9cKyGa3/OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767617925; c=relaxed/simple;
	bh=DzTcfkwhXpbwmxHp4wEp4hjassG7F+5eCb68ODAWiOc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rsan6wlFUYCKdzj5Lbond64vSDDdRcAOprHMmTQtdKgsvtY2t7HNC3H+8FwwZD5V2QHn4uuudjpeE3UDngjLNdR9KaWS5O57MnY9wfijVyqnNOZTlldOhVKcgNrcCI03f35e4SPvugfX8eRjA4suM6ILs8bDjPRdw5l0fdnWCAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lZFsbVRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17400C116D0;
	Mon,  5 Jan 2026 12:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767617924;
	bh=DzTcfkwhXpbwmxHp4wEp4hjassG7F+5eCb68ODAWiOc=;
	h=Subject:To:Cc:From:Date:From;
	b=lZFsbVRqkmtvwR3AcJDJPzYjECfpP588+tONWHt5L1A0mWCkAQDNZV01kZK8wAZbd
	 Hl/yyOx4sBOyXEblzZ3faXG+Im7QtCoaNK0xL7cziFdPhoBOvYFGv2hb8i2uE0HtdI
	 eokuVPOn4DisUqD+5RIHnfIo2bpSytvgcnIL+Q34=
Subject: FAILED: patch "[PATCH] LoongArch: Refactor register restoration in" failed to apply to 6.6-stable tree
To: duanchenghao@kylinos.cn,chenhuacai@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 13:58:41 +0100
Message-ID: <2026010541-varmint-tablet-f295@gregkh>
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
git cherry-pick -x 45cb47c628dfbd1994c619f3eac271a780602826
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010541-varmint-tablet-f295@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 45cb47c628dfbd1994c619f3eac271a780602826 Mon Sep 17 00:00:00 2001
From: Chenghao Duan <duanchenghao@kylinos.cn>
Date: Wed, 31 Dec 2025 15:19:20 +0800
Subject: [PATCH] LoongArch: Refactor register restoration in
 ftrace_common_return

Refactor the register restoration sequence in the ftrace_common_return
function to clearly distinguish between the logic of normal returns and
direct call returns in function tracing scenarios. The logic is as
follows:

1. In the case of a normal return, the execution flow returns to the
traced function, and ftrace must ensure that the register data is
consistent with the state when the function was entered.

ra = parent return address; t0 = traced function return address.

2. In the case of a direct call return, the execution flow jumps to the
custom trampoline function, and ftrace must ensure that the register
data is consistent with the state when ftrace was entered.

ra = traced function return address; t0 = parent return address.

Cc: stable@vger.kernel.org
Fixes: 9cdc3b6a299c ("LoongArch: ftrace: Add direct call support")
Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

diff --git a/arch/loongarch/kernel/mcount_dyn.S b/arch/loongarch/kernel/mcount_dyn.S
index d6b474ad1d5e..5729c20e5b8b 100644
--- a/arch/loongarch/kernel/mcount_dyn.S
+++ b/arch/loongarch/kernel/mcount_dyn.S
@@ -94,7 +94,6 @@ SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
  * at the callsite, so there is no need to restore the T series regs.
  */
 ftrace_common_return:
-	PTR_L		ra, sp, PT_R1
 	PTR_L		a0, sp, PT_R4
 	PTR_L		a1, sp, PT_R5
 	PTR_L		a2, sp, PT_R6
@@ -104,12 +103,17 @@ ftrace_common_return:
 	PTR_L		a6, sp, PT_R10
 	PTR_L		a7, sp, PT_R11
 	PTR_L		fp, sp, PT_R22
-	PTR_L		t0, sp, PT_ERA
 	PTR_L		t1, sp, PT_R13
-	PTR_ADDI	sp, sp, PT_SIZE
 	bnez		t1, .Ldirect
+
+	PTR_L		ra, sp, PT_R1
+	PTR_L		t0, sp, PT_ERA
+	PTR_ADDI	sp, sp, PT_SIZE
 	jr		t0
 .Ldirect:
+	PTR_L		t0, sp, PT_R1
+	PTR_L		ra, sp, PT_ERA
+	PTR_ADDI	sp, sp, PT_SIZE
 	jr		t1
 SYM_CODE_END(ftrace_common)
 
@@ -161,6 +165,8 @@ SYM_CODE_END(return_to_handler)
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 SYM_CODE_START(ftrace_stub_direct_tramp)
 	UNWIND_HINT_UNDEFINED
-	jr		t0
+	move		t1, ra
+	move		ra, t0
+	jr		t1
 SYM_CODE_END(ftrace_stub_direct_tramp)
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */


