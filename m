Return-Path: <stable+bounces-89367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52909B6E1E
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 21:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A036A2810D2
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 20:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8058C2144CA;
	Wed, 30 Oct 2024 20:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3liUFqP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311E8213EF6;
	Wed, 30 Oct 2024 20:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321388; cv=none; b=mL1tSgu6GA9ZSHFGFgIwN0UNne7hMk5+kEuvtKSu7HF617VnBeALFHXrejYYW58sd9k4gPkiSdEhZ/TcrYMfOTdO2dmMlFS0rvxs5iaRwFsPsOHhW6MOGesKrH4qUBH3YhYmH0VVzbMy8HonKzP4+ZSmvi70bj7OesLAD09Ba/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321388; c=relaxed/simple;
	bh=dLqAw4xy5/KKmZNX6yrvJQT14/QmwjMru+J+jwCboHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dpEC6NtAoH6V3Z0PXSvSPou/YQRhCfvjBAPqACj32v5eeEI5S9tfta+IcNRLgrA+rTVFqbCS6lg91gEBK+uaRUm16ea1KPbGwRTHjLM7TG0rt9wejkq9CiGdFbljnzu/66xaGMoXRJlDqKVchnmxvHgm/Cc9KFFaD+JoAowqI0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3liUFqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F76C4CED1;
	Wed, 30 Oct 2024 20:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730321387;
	bh=dLqAw4xy5/KKmZNX6yrvJQT14/QmwjMru+J+jwCboHM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L3liUFqPA1FyGPmrsabDM7RM3yowwAs/TK5/9jJzyFy28OJVRxyIUqjPYZKPn4ZUz
	 3RUExHjQimbeOiymBXIpzpXPql8nYLS4cyZqcuiMdUJ09q0i20Q4j0X5d2KorWC6S4
	 cNkb1sT4Vr3OJStwGC7HQr48rWrj4Jbd1Ui3QbzTg2xH7VQBzM35KTVCZAVRd3DeNP
	 PhNMYGGIJXhsH8I75Jits6FqjnwrHcOppfVuP7mTGRmWlvY7Q+QTa2UCU4SF53Idlr
	 mZbNq/SXiVs+lYKImCLH9f8PBHrsyXS1s6MzHGX4qrI6UuWUtcWm6hd+zsuQwLJQ0f
	 JOE9Xl6P8csOA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 30 Oct 2024 20:23:50 +0000
Subject: [PATCH 1/2] arm64/sve: Flush foreign register state in
 sve_init_regs()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-arm64-fpsimd-foreign-flush-v1-1-bd7bd66905a2@kernel.org>
References: <20241030-arm64-fpsimd-foreign-flush-v1-0-bd7bd66905a2@kernel.org>
In-Reply-To: <20241030-arm64-fpsimd-foreign-flush-v1-0-bd7bd66905a2@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1381; i=broonie@kernel.org;
 h=from:subject:message-id; bh=dLqAw4xy5/KKmZNX6yrvJQT14/QmwjMru+J+jwCboHM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnIpvmTGqCbde0j16dyrk16BYTp5wddvqHWezRdera
 9Vfb+FyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyKb5gAKCRAk1otyXVSH0H4qB/
 9Yz+KS9YtbwvLFuU9RqjekMoIrPAkbHkjkUJCp/j9ZaBAf+7EZSNJogZcZXCuf2qUF7O1aV2sjaJ0j
 C5Pt+hdLBwe5keWkhhyfktLONox4y/Lxg6/6r4lr+mdLXXpl4Nd8mfPjxlvR/ZRXz7y8SVBKtEktXY
 nGjhnyAtXdxTLQJXaC/sEB67h0JSYbY0Tb0oul/FlC6ApE/qPfnPBmXaE8lLjCnHbkY8TJm6gjnsiO
 J+T336OyWGJxiNLiJhCT4U2MwGvi4JZm+aBKoP4c2wD+zmKP5F+d+dSw6j+q8pUaXGjyn5qGN20kzN
 0csdyvYKeag2vaLE4eZ6AeWKXTnlj9
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When we update the in memory register state in sve_init_regs() we neglect
to flush the task's CPU binding, meaning if the task is rescheduled to
the last CPU it ran on it is possible for the check for current state in
fpsimd_thread_switch() to falsely determine that up to date register
state is present on the CPU.  This results in it incorrectly clearing
TIF_FOREIGN_FPSTATE and suppress reloading.

This will also suppress the sve_user_enable() done in
fpsimd_bind_task_to_cpu() as part of return to userspace, causing
spurious SVE access traps.

Call fpsimd_flush_task_state() to invalidate the last loaded CPU
recorded in the task.

Fixes: cccb78ce89c4 ("arm64/sve: Rework SVE access trap to convert state in registers")
Reported-by: Mark Rutlamd <mark.rutland@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kernel/fpsimd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 77006df20a75aee7c991cf116b6d06bfe953d1a4..6d21971ae5594f32947480cfa168db400a69a283 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1367,6 +1367,7 @@ static void sve_init_regs(void)
 	} else {
 		fpsimd_to_sve(current);
 		current->thread.fp_type = FP_STATE_SVE;
+		fpsimd_flush_task_state(current);
 	}
 }
 

-- 
2.39.2


