Return-Path: <stable+bounces-99081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B9B9E6FE3
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17618168A26
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B3C207E13;
	Fri,  6 Dec 2024 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdiaeFFX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A0A1FCCFB
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733494399; cv=none; b=lE0yZj9glrtdsz7ZBbnC52N1SR6YlMqDHyRqAsG99eZZoXpkYLB1990jL3LffBYf/cLX2cf3XlPg6N/yJ0BBylxSVqqQFIYc9EpCWIZP9lJmEDNUjZL18qqaViHsK/me00jMTsk3uyCxW4XokQzDzINQwLYq+SPPCZbU8jIs16U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733494399; c=relaxed/simple;
	bh=jvTDeik4aBjulx/mzVsWSYvRmvzyEo28Ba9b7m3Oflw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TKYYCArywAVmI+rNpYbkgkZSnLI6LOmU+oLSd/Dvs5OjzrCKRcZlUueYj8Bno98PiTLIKI0xHAss0tISz28fbu7pxxEAZGoopzoJPrEGe4dePEPuOENl1cGNWi1xX8j7M+UMgSVlnd+iGq79woZnhDFdQ15JkNQH2fmOx3SsQwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdiaeFFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF70C4CEDC;
	Fri,  6 Dec 2024 14:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733494398;
	bh=jvTDeik4aBjulx/mzVsWSYvRmvzyEo28Ba9b7m3Oflw=;
	h=From:To:Cc:Subject:Date:From;
	b=NdiaeFFXu3N6c+JAYkDp41FM5n4PDR3ZmYF3/UTh1rCisAMbupxNyhyph20Rq/XVM
	 f8hceM+RCeoK8o4rACv4JVmJwcCD8GEOCwlqUsZjkRkk93j23Zv9uSjiftYzoUapom
	 sgmF9tjtYCQFQ0Jnnaa9i8FNM9myIYI/wK2PvKVEeT0cvoj+kTMe6hOoGuuFKcs64U
	 w04M8uExFkoh4Bxy4J8Bw+GEy4aopvt0BFwqdgPzYHr1KDR6rQ/nhPdG2hPcG8l5ng
	 yn3/RuIg4vjWv1TTmZ8o/4JEea/8SFXNEWfssHYfezvwqFbP6KEyI+LvRdCusZav18
	 9QlmNKfDnVvEg==
From: Mark Brown <broonie@kernel.org>
To: stable@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 5.15] arm64/sve: Discard stale CPU state when handling SVE traps
Date: Fri,  6 Dec 2024 14:11:19 +0000
Message-Id: <20241206141119.203712-1-broonie@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3494; i=broonie@kernel.org; h=from:subject; bh=jvTDeik4aBjulx/mzVsWSYvRmvzyEo28Ba9b7m3Oflw=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnUwYGpdXDDmEspwj29fBJd3Z0VbY0XV57UVefuLMa lXMoT8GJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ1MGBgAKCRAk1otyXVSH0BeLCA CCB3oNfgPNx/8P91ak70l1H9A4afPkg3yG+l6faKzlJH1PuxGmcnZ7zGNgrTtUBBZxtitbWRIbTr0H dcvsCPCIJVlo36Ybs9pB6c+StTHz7ooisj+y6yQ2Z/CrDAp4qMzhWf50g8hq55p2sg4sx7lpB0oEuu 2I11UxfsI5at32B5LDru2Ts1IfwnZaTIc65JbKLDMFzqRkMssyFtfbeBmcAZMNxakgDAsN7euSHXgG E+Pm2BjBH0p+06KIQagxv/VfXnAfybZkzcDQfFodPh1eFSBViz+BUWywNmAmr7zLMw6ZkscNaMWR88 26zvDKKW+IwEMmZ56iMlZQZinKcZwO
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit

The logic for handling SVE traps manipulates saved FPSIMD/SVE state
incorrectly, and a race with preemption can result in a task having
TIF_SVE set and TIF_FOREIGN_FPSTATE clear even though the live CPU state
is stale (e.g. with SVE traps enabled). This has been observed to result
in warnings from do_sve_acc() where SVE traps are not expected while
TIF_SVE is set:

|         if (test_and_set_thread_flag(TIF_SVE))
|                 WARN_ON(1); /* SVE access shouldn't have trapped */

Warnings of this form have been reported intermittently, e.g.

  https://lore.kernel.org/linux-arm-kernel/CA+G9fYtEGe_DhY2Ms7+L7NKsLYUomGsgqpdBj+QwDLeSg=JhGg@mail.gmail.com/
  https://lore.kernel.org/linux-arm-kernel/000000000000511e9a060ce5a45c@google.com/

The race can occur when the SVE trap handler is preempted before and
after manipulating the saved FPSIMD/SVE state, starting and ending on
the same CPU, e.g.

| void do_sve_acc(unsigned long esr, struct pt_regs *regs)
| {
|         // Trap on CPU 0 with TIF_SVE clear, SVE traps enabled
|         // task->fpsimd_cpu is 0.
|         // per_cpu_ptr(&fpsimd_last_state, 0) is task.
|
|         ...
|
|         // Preempted; migrated from CPU 0 to CPU 1.
|         // TIF_FOREIGN_FPSTATE is set.
|
|         get_cpu_fpsimd_context();
|
|         if (test_and_set_thread_flag(TIF_SVE))
|                 WARN_ON(1); /* SVE access shouldn't have trapped */
|
|         sve_init_regs() {
|                 if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
|                         ...
|                 } else {
|                         fpsimd_to_sve(current);
|                         current->thread.fp_type = FP_STATE_SVE;
|                 }
|         }
|
|         put_cpu_fpsimd_context();
|
|         // Preempted; migrated from CPU 1 to CPU 0.
|         // task->fpsimd_cpu is still 0
|         // If per_cpu_ptr(&fpsimd_last_state, 0) is still task then:
|         // - Stale HW state is reused (with SVE traps enabled)
|         // - TIF_FOREIGN_FPSTATE is cleared
|         // - A return to userspace skips HW state restore
| }

Fix the case where the state is not live and TIF_FOREIGN_FPSTATE is set
by calling fpsimd_flush_task_state() to detach from the saved CPU
state. This ensures that a subsequent context switch will not reuse the
stale CPU state, and will instead set TIF_FOREIGN_FPSTATE, forcing the
new state to be reloaded from memory prior to a return to userspace.

Fixes: cccb78ce89c4 ("arm64/sve: Rework SVE access trap to convert state in registers")
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20241030-arm64-fpsimd-foreign-flush-v1-1-bd7bd66905a2@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
[Backported to 5.15 -- broonie]
(cherry picked from commit 751ecf6afd6568adc98f2a6052315552c0483d18)
---
 arch/arm64/kernel/fpsimd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 7a3fcf21b18a..e22571e57ae1 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -964,6 +964,7 @@ void do_sve_acc(unsigned long esr, struct pt_regs *regs)
 		fpsimd_bind_task_to_cpu();
 	} else {
 		fpsimd_to_sve(current);
+		fpsimd_flush_task_state(current);
 	}
 
 	put_cpu_fpsimd_context();
-- 
2.39.5


