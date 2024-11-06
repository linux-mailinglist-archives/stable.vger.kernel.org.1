Return-Path: <stable+bounces-91732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F8D9BF9E1
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 00:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92F06B2283C
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 23:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A128520D4EB;
	Wed,  6 Nov 2024 23:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N22rTv7T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAE920CCFA;
	Wed,  6 Nov 2024 23:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730935275; cv=none; b=EQJr8DizO5pfEoouNoylLFz/iSF+eZiOAoNQgCl6vX84QWjDwBtnl50bnLt2qoXtE+4/ea+OkOJX9FTqri7/6FVUTA3O6btuaecRs3scyRTg/v7oCJiVmW65xC1jfH8PJYxGZN5gNWoaYyFAsf7HvzMv3ZDLgPSjc9odU26sisI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730935275; c=relaxed/simple;
	bh=v0JKX5IwqEZCely79v6+Qi7NArjB8yIgCjKT3A9QR1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=j7KNs/+mjsF9f5mhgvTgxluo003nol5LMKU08bcYQLNpd6j2ZBWqYZT4IKArvkvt3ZGTkRY8COVldQfSI/hqKR2x3A2nlNd0jxEL3Fujb0p4KvkLlkhrxcr5rav768JhA98mv7jPzmSgksBlZlFGuBD11NxRBPLoYW1LY2eAz04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N22rTv7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75ED4C4CEC6;
	Wed,  6 Nov 2024 23:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730935275;
	bh=v0JKX5IwqEZCely79v6+Qi7NArjB8yIgCjKT3A9QR1k=;
	h=From:Date:Subject:To:Cc:From;
	b=N22rTv7T/f4RrX2t/6HrlOb2N4tQnSUrWrVk5du6PWBKvzPkXPRDe37t1H9QObFFx
	 9EfFX629HsCAD3tgbqdJIRYQvG8KMP7Xa1hOhbiywzjVyMmjRwqa3+dazq9juoMPbm
	 evR50FHrXoQS/1XBPLLapkPjd7YHNaIebzcTQmzvkBdomrmO3QLT4EhcbkSlR7wOfN
	 IC8rE25y/VUOj/23gQB7942qUF9bXk+sJQUdyebJfSxuwoS+ngFDPWkINlXVQaI8xl
	 qHLO3N6BA6ZdMYfhjdwe6WFdUPTcqorbgCkDii9OFMFLKL86POKdMPtlhOEBqS8WG8
	 E5RW9fy5h6soQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 06 Nov 2024 23:20:51 +0000
Subject: [PATCH] arm64/ptrace: Zero FPMR on streaming mode entry/exit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-arm64-ptrace-fpmr-sm-v1-1-c28429da37d3@kernel.org>
X-B4-Tracking: v=1; b=H4sIANL5K2cC/x3MQQqAIBBA0avErBtQ06KuEi2kxpqFJWNEEN09a
 fkW/z+QSZgyDNUDQhdnPvYCXVcwb35fCXkpBqOM1Vq16CW2FtMpfiYMKQrmiNY1vQquN66zUNI
 kFPj+t+P0vh8eFvILZgAAAA==
X-Change-ID: 20241106-arm64-ptrace-fpmr-sm-45390f592574
To: Oleg Nesterov <oleg@redhat.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=2693; i=broonie@kernel.org;
 h=from:subject:message-id; bh=v0JKX5IwqEZCely79v6+Qi7NArjB8yIgCjKT3A9QR1k=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnK/noo9Br3v5fpH+eL1u9o3cQlJbT9iDlag0KwZOR
 R35tWkGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyv56AAKCRAk1otyXVSH0E4CB/
 4u6knMTpqMANM3wlZLlyF8m0EYBuUKsqbjIW1dOZvoyucLPD8RIJkp2R6i9yboXiF44MNw2IjzS7HT
 El/BRvtJ7W1dPFFpK+erZXzEuN5LI6jD069NUhbXicIuov/h+6fhn21j/Wrgih/2/iCVRdtLdsYAnU
 gfkN7602fme2WAoxTe6Yz8lO5mt+MSTR3fNl/4Ru8FKUMkDiam3SiauQ3fKMIj2XL1PowIbygRu5wQ
 N3L0DerTy9vBQlXQOrfY9/PXmzFE830FGtRtOdkxM8NiXecqUceyU1Sw/OkJYvD64hhPB3bI4v9ief
 OhI1R0cO03MFxOnjufdIXKygDddcee
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When FPMR and SME are both present then entering and exiting streaming mode
clears FPMR in the same manner as it clears the V/Z and P registers.
Since entering and exiting streaming mode via ptrace is expected to have
the same effect as doing so via SMSTART/SMSTOP it should clear FPMR too
but this was missed when FPMR support was added. Add the required reset
of FPMR.

Since changing the vector length resets SVCR a SME vector length change
implemented via a write to ZA can trigger an exit of streaming mode and
we need to check when writing to ZA as well.

Fixes: 4035c22ef7d4 ("arm64/ptrace: Expose FPMR via ptrace")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kernel/ptrace.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index b756578aeaeea1d3250276734520e3eaae8a671d..f242df53de2992bf8a3fd51710d6653fe82f7779 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -876,6 +876,7 @@ static int sve_set_common(struct task_struct *target,
 			  const void *kbuf, const void __user *ubuf,
 			  enum vec_type type)
 {
+	u64 old_svcr = target->thread.svcr;
 	int ret;
 	struct user_sve_header header;
 	unsigned int vq;
@@ -903,8 +904,6 @@ static int sve_set_common(struct task_struct *target,
 
 	/* Enter/exit streaming mode */
 	if (system_supports_sme()) {
-		u64 old_svcr = target->thread.svcr;
-
 		switch (type) {
 		case ARM64_VEC_SVE:
 			target->thread.svcr &= ~SVCR_SM_MASK;
@@ -1003,6 +1002,10 @@ static int sve_set_common(struct task_struct *target,
 				 start, end);
 
 out:
+	/* If we entered or exited streaming mode then reset FPMR */
+	if ((target->thread.svcr & SVCR_SM) != (old_svcr & SVCR_SM))
+		target->thread.uw.fpmr = 0;
+
 	fpsimd_flush_task_state(target);
 	return ret;
 }
@@ -1099,6 +1102,7 @@ static int za_set(struct task_struct *target,
 		  unsigned int pos, unsigned int count,
 		  const void *kbuf, const void __user *ubuf)
 {
+	u64 old_svcr = target->thread.svcr;
 	int ret;
 	struct user_za_header header;
 	unsigned int vq;
@@ -1175,6 +1179,10 @@ static int za_set(struct task_struct *target,
 	target->thread.svcr |= SVCR_ZA_MASK;
 
 out:
+	/* If we entered or exited streaming mode then reset FPMR */
+	if ((target->thread.svcr & SVCR_SM) != (old_svcr & SVCR_SM))
+		target->thread.uw.fpmr = 0;
+
 	fpsimd_flush_task_state(target);
 	return ret;
 }

---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241106-arm64-ptrace-fpmr-sm-45390f592574

Best regards,
-- 
Mark Brown <broonie@kernel.org>


