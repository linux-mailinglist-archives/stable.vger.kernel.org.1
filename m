Return-Path: <stable+bounces-99078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 363899E6F4B
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA5A1881B34
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7905207DE6;
	Fri,  6 Dec 2024 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiiszYJG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DF2207669
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491744; cv=none; b=XR4M0dzjZV/nHf9Xp5tsriXFhtg7YOb4qeEL1XFsALyI28DUOBidMvIaq1tDiq2b4JidBp5iHF2aaehuYgaEww5cknflUFledLyDWKA4uKUcaIK+rlRWhru3DRgjEqOq9+31M8G28z2TdYK9ivu0nptUZnp7aiQeSmqZQUnuAqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491744; c=relaxed/simple;
	bh=XbC8FRHP+O8yy/P3elssPaQw8xFP43KC/4aBlGkwsU8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OdAjwlCi/l2ZOyVRRVpfmhzeQS7EHjL4BHgYM7SErQnmqXOj3NrEWcfxqNmkeVlnNHfAOihXQencGCaDP8ye9Qxf4+IeZWMoDDStBv1QbLWwqzhL4bWcRS/J8qeVBCdqSqWAnHGK7IKKxtW150soXk5JaCT9rsNoagDjgMQIdUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiiszYJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDCAC4CEDE;
	Fri,  6 Dec 2024 13:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733491744;
	bh=XbC8FRHP+O8yy/P3elssPaQw8xFP43KC/4aBlGkwsU8=;
	h=From:To:Cc:Subject:Date:From;
	b=EiiszYJGvYa9/xIbKg4D9fDiQt7U89FSIYXnpYG0JOWsxfYo7xrBC9VEt/PN+Jlrp
	 G+rnEnaw7L+g83QW7No8Rmz0K7dO+x0IX+uKxgN+ozi3HkBNFr+drtL0ozCuhdN1Z5
	 Kk3HKT++8DmazyLUV+JsJ6SgBmwZoeEF8o6GDcvlV0bAeguhe2dgw8TTHeJmtpizx9
	 R4HbJpiIEhHFEHYhQ2zGyyXwGOpBGcRDPAmhm1s2TSTxxkIlvN2QY0a6P2HD30f4g1
	 xE1yCmPX+7lyd95/cnmu/cfLXHjw7Sdd9JkJ25INgvsB+7QRBfTbE5L+EhbRwLbXS7
	 jP6+tHZdI+/tg==
From: Mark Brown <broonie@kernel.org>
To: stable@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 6.1] arm64/sve: Discard stale CPU state when handling SVE traps
Date: Fri,  6 Dec 2024 13:22:06 +0000
Message-Id: <20241206132206.143543-1-broonie@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3445; i=broonie@kernel.org; h=from:subject; bh=XbC8FRHP+O8yy/P3elssPaQw8xFP43KC/4aBlGkwsU8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnUvp9WNi/yOBZaup5A2DOMorEYpPLy/MM9tLChKS6 HiMJ57OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ1L6fQAKCRAk1otyXVSH0LsICA CA/87GsBylkHP59E5DCatZqaxsKbcQwPUI9PwDl4wayDIh/FT6q7IeCn7qaWo28ypznh1g61JDnme5 oi6PHcOaWY+cDhmSVwufHdWCAHQBm3xEuh1SyG7fo4NrIjR17KWz3jrnUDh8K5zDMb2ZgY3dvuH67X y/yulTfGuLwKhNi315Xwn+YStxDilnQHOmH6ySINBAMKRchDrCG0uL1TETuDUVSaBIii9P+s4pNvnE 2wLj1MMu7GWdb9AINVveSjorVeilw6t8STvbtkbfMM60NCuNhYKbOG6IYteNyfHQKqNz4IcAxbBIFC 0CWiXh1sa1N+gMxfTF19dgp6a96rls
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
[Backported to 6.1 -- broonie]
(cherry picked from commit 751ecf6afd6568adc98f2a6052315552c0483d18)
---
 arch/arm64/kernel/fpsimd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 59b5a16bab5d..43afe07c74fd 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1383,6 +1383,7 @@ static void sve_init_regs(void)
 		fpsimd_bind_task_to_cpu();
 	} else {
 		fpsimd_to_sve(current);
+		fpsimd_flush_task_state(current);
 	}
 }
 
-- 
2.39.5


