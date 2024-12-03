Return-Path: <stable+bounces-96585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC50C9E2229
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF1E8B84BB8
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC38C1F75A6;
	Tue,  3 Dec 2024 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fAlb4zCm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFAB1DE2A1;
	Tue,  3 Dec 2024 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237998; cv=none; b=i+3QSKOfZI5Q1ag+qoyOpZY0t66ps3MR+OzMyJoTTiuSF6p1xc2sbDs8Gnzk3DrGonogovxuSFG7PcNn7Gu/Ladn+VZLjYjDEc6e9QbNfCagRGFwT1szDxJeIhI1MmJM0AiYvEW7/9v8WKZZ5nPfj6SApduFGhJ4z3CIDay/B5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237998; c=relaxed/simple;
	bh=VhuDwqelEkOV2OqeC6lA4u9IjC72MT/6SC/vXA2ycNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDKYHwdzZL0x2dVvA/mvrlbrGM1Yg7XcnKVqs01RIwdAEYJcNdSDDK+3Il68U4gftmCGy999UFeoHu6+OzBRf2rAwZvF702Zbx67mQxJt8R/WDgwqEVoOqDAxPiK5xok3OGlM6/1iZJlivSOnHHPCuS4mXCjX7yxRbRkU0S3ybs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fAlb4zCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD663C4CECF;
	Tue,  3 Dec 2024 14:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733237998;
	bh=VhuDwqelEkOV2OqeC6lA4u9IjC72MT/6SC/vXA2ycNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fAlb4zCmAZkKRhD0C6G4m9usaA0NSiNjzgLdNz34Iv1IazOCNpBhKN00q8vaSVfu7
	 64Xj8dKLqGC2BNqW3x1ltZYGsf2MFzLmn+8suERUS9eY7W3xtOujQe9coDAHcTzKZp
	 3+8AsbeAW32MLFiaTg3142B6u6l87zwZiIrAAvVw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zheng Yejian <zhengyejian@huaweicloud.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 129/817] x86/unwind/orc: Fix unwind for newly forked tasks
Date: Tue,  3 Dec 2024 15:35:01 +0100
Message-ID: <20241203144000.755448985@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zheng Yejian <zhengyejian@huaweicloud.com>

[ Upstream commit 3bf19a0fb690022ec22ce87a5afeb1030cbcb56c ]

When arch_stack_walk_reliable() is called to unwind for newly forked
tasks, the return value is negative which means the call stack is
unreliable. This obviously does not meet expectations.

The root cause is that after commit 3aec4ecb3d1f ("x86: Rewrite
 ret_from_fork() in C"), the 'ret_addr' of newly forked task is changed
to 'ret_from_fork_asm' (see copy_thread()), then at the start of the
unwind, it is incorrectly interprets not as a "signal" one because
'ret_from_fork' is still used to determine the initial "signal" (see
__unwind_start()). Then the address gets incorrectly decremented in the
call to orc_find() (see unwind_next_frame()) and resulting in the
incorrect ORC data.

To fix it, check 'ret_from_fork_asm' rather than 'ret_from_fork' in
__unwind_start().

Fixes: 3aec4ecb3d1f ("x86: Rewrite ret_from_fork() in C")
Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/unwind_orc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index d00c28aaa5be4..d4705a348a804 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -723,7 +723,7 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 		state->sp = task->thread.sp + sizeof(*frame);
 		state->bp = READ_ONCE_NOCHECK(frame->bp);
 		state->ip = READ_ONCE_NOCHECK(frame->ret_addr);
-		state->signal = (void *)state->ip == ret_from_fork;
+		state->signal = (void *)state->ip == ret_from_fork_asm;
 	}
 
 	if (get_stack_info((unsigned long *)state->sp, state->task,
-- 
2.43.0




