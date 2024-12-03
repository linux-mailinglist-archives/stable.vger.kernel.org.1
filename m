Return-Path: <stable+bounces-96303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4219E1CB6
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 13:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471832835CD
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 12:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D4B1F426C;
	Tue,  3 Dec 2024 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YB1/JhVV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9CE1F4265;
	Tue,  3 Dec 2024 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733230094; cv=none; b=R3qKChsEeDZlIJi8UdtBimHIwNj3IrESVhWy98SpKmIPlDFuAzw/WXAwQsiis92rGDHvK7Kiyn4pkbp8WlCo9xdjfbrOYsbGJz1NwjO5k9IqSW4m9ffTxg424tyX0a6NBnHcomlyGRCYf0fr4fAP5ykVbXwZCuCn+AEL5pxBaQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733230094; c=relaxed/simple;
	bh=A8QKBxilDmxPa7rkbda6zcbE9W7eNHPT2bdz3YleFLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nwwGfcMUNxLMVvAqCE0gNJz831GzPYO84z40bXl1bSbvwoLlC75NhgRJ77YmNZgElTJkOc8WVgFxuUesZ5StL35QgrlcAFSw/JBiah2pXcKhQJRZU6cJtkDG8mGBy4dQDySaAcUcspBK798JIf0jZfXhCXMcyPfzMVQY0EcKpcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YB1/JhVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35ACEC4CEDA;
	Tue,  3 Dec 2024 12:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733230093;
	bh=A8QKBxilDmxPa7rkbda6zcbE9W7eNHPT2bdz3YleFLw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YB1/JhVVfVllWqpTIrk7/axmeR9qWo1CHsDZMaaZTOWJ29KPqtjV3kLB4Pk0GoN2V
	 AbbvlHTU1FZ+DHYwFi6AF3Yeu1TKtv9Yew9wF0o6u89WlZgOlzsLREFY46EmLl4PKE
	 gPF3qGGGtg59PCzJPDt1gkn684JMR/mBBVmy2MShSIbi26KebRhM7L9dA3FiXS6KUs
	 SwyBymbe+bDRIlhaoAYRn/ZBN5dHh2KzXQjr2m27ZIVUMpOTk8jlRJMmXw9f8XTI4k
	 58sA3Wu7c1Pc8ei4ezose9Kdwq05p9VvShFCdrxjTEdh93/RDQeITLthtHW2ol+mUm
	 HN/ENvn45KIsg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 03 Dec 2024 12:45:55 +0000
Subject: [PATCH 3/6] arm64/ptrace: Zero FPMR on streaming mode entry/exit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-arm64-sme-reenable-v1-3-d853479d1b77@kernel.org>
References: <20241203-arm64-sme-reenable-v1-0-d853479d1b77@kernel.org>
In-Reply-To: <20241203-arm64-sme-reenable-v1-0-d853479d1b77@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=2536; i=broonie@kernel.org;
 h=from:subject:message-id; bh=A8QKBxilDmxPa7rkbda6zcbE9W7eNHPT2bdz3YleFLw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnTv4CiOSW2bhpgcdgsYNhwD/Bim4F7ucOylhTitF5
 bNZ69KSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ07+AgAKCRAk1otyXVSH0LOrB/
 99y5btc73beTOcl314LKxYh6c8mPHO20HigFHyqQdH86SXdpieb5FJR5m4nRfAnosSZgvstgKONgTz
 XZqsLN/KGPd4tQ9DKCVEydJ3/qFG/nswfG8vbzrZjvHZJ/R27QaD+TrhV3stJvQ+vb9ExTbYHxLbly
 a2q+yRIYr7+UZg5twhsndT1luzc4kNgcnc3yyEiqUm/6CQZzYTl3hn7duGakQiQun0A5IFN4fo3+7W
 /RfIDT448OmJWNI/6atAEtDOSpHazBrW8YbYL2Hn8+vGSQmltJjnGmtktoMOAjED3od8W1fkRBQB9w
 gfO+/3RX68xQLyTKjlR4djCYJYqWcj
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
index e4437f62a2cda93734052c44b48886db83d75b3e..43a9397d5903ff87b608befdcaed3f9a7e48f976 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -877,6 +877,7 @@ static int sve_set_common(struct task_struct *target,
 			  const void *kbuf, const void __user *ubuf,
 			  enum vec_type type)
 {
+	u64 old_svcr = target->thread.svcr;
 	int ret;
 	struct user_sve_header header;
 	unsigned int vq;
@@ -908,8 +909,6 @@ static int sve_set_common(struct task_struct *target,
 
 	/* Enter/exit streaming mode */
 	if (system_supports_sme()) {
-		u64 old_svcr = target->thread.svcr;
-
 		switch (type) {
 		case ARM64_VEC_SVE:
 			target->thread.svcr &= ~SVCR_SM_MASK;
@@ -1008,6 +1007,10 @@ static int sve_set_common(struct task_struct *target,
 				 start, end);
 
 out:
+	/* If we entered or exited streaming mode then reset FPMR */
+	if ((target->thread.svcr & SVCR_SM) != (old_svcr & SVCR_SM))
+		target->thread.uw.fpmr = 0;
+
 	fpsimd_flush_task_state(target);
 	return ret;
 }
@@ -1104,6 +1107,7 @@ static int za_set(struct task_struct *target,
 		  unsigned int pos, unsigned int count,
 		  const void *kbuf, const void __user *ubuf)
 {
+	u64 old_svcr = target->thread.svcr;
 	int ret;
 	struct user_za_header header;
 	unsigned int vq;
@@ -1184,6 +1188,10 @@ static int za_set(struct task_struct *target,
 	target->thread.svcr |= SVCR_ZA_MASK;
 
 out:
+	/* If we entered or exited streaming mode then reset FPMR */
+	if ((target->thread.svcr & SVCR_SM) != (old_svcr & SVCR_SM))
+		target->thread.uw.fpmr = 0;
+
 	fpsimd_flush_task_state(target);
 	return ret;
 }

-- 
2.39.5


