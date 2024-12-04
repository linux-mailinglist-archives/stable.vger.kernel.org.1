Return-Path: <stable+bounces-98306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C024C9E3E1D
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 16:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81581166283
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 15:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C14920CCC8;
	Wed,  4 Dec 2024 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNj5hXem"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2740720CCC7;
	Wed,  4 Dec 2024 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733325750; cv=none; b=Nt8G+lXtwDcUR956RbGO1Eg0R4l0wqEc2UW8GkRF0KCIP+TwGmFAIvT1Qg0TBsbkaxnaVPk+rOATA7qHM+2aK9O9UDX12wunAL1w97YuIgNgDODRrJ/whhBEg04ZxevppZdtUJK59eI6VZZ3Y/gtCV9ny0PmonVgT+Ixhy+5XZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733325750; c=relaxed/simple;
	bh=A8QKBxilDmxPa7rkbda6zcbE9W7eNHPT2bdz3YleFLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CkVAr+TKMBgMZRpzx8Ctg7YhleInPraAJ2sO1/P8bWnriIyMci6/uMALUoJ3hAmsDHS+CqxzHbKJiNLiH2ApOp9tQbhEsJoWsTIHPEQYacjjWllZl0ikzuE7eZA7gpEKbBh7qs3bq45cHVEI8WrF2QL4Q+sjVnr6tEwAhb5HPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNj5hXem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4F9C4CED2;
	Wed,  4 Dec 2024 15:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733325750;
	bh=A8QKBxilDmxPa7rkbda6zcbE9W7eNHPT2bdz3YleFLw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QNj5hXemT+0ygrwbrgagcUNKOZv7DgPtgEFPYb2ASRGxh801B9/Gxxd88fI+jbDvg
	 JXiP3zd1ThdTKB0crkPoFya/IKM/m0aBjYCv7N4DqXshIk17EBw3LMNPR4GsRxCWRd
	 ESiLrVPAn2oXczQspoZnSOFa0AY2xWyM1v7JTtEhAjUacMhtsC6mWdAaQXVg9U35Yf
	 a6VzE0jAv80ZkgP8JErM2iPhqJgas5NSOVaAUpJiQEyCY2rtg8TybLbu+iISNbPm5O
	 6o5ZWZ4UKPLGy180R+7AvMjUUAdpu3cn7mRDnYXxtfxpFwfzudscBcgI34+mNxa+S4
	 ZDhyxvNCXkzWQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 04 Dec 2024 15:20:51 +0000
Subject: [PATCH v2 3/6] arm64/ptrace: Zero FPMR on streaming mode
 entry/exit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-arm64-sme-reenable-v2-3-bae87728251d@kernel.org>
References: <20241204-arm64-sme-reenable-v2-0-bae87728251d@kernel.org>
In-Reply-To: <20241204-arm64-sme-reenable-v2-0-bae87728251d@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Dave Martin <Dave.Martin@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=2536; i=broonie@kernel.org;
 h=from:subject:message-id; bh=A8QKBxilDmxPa7rkbda6zcbE9W7eNHPT2bdz3YleFLw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnUHOqPfutP7bJSiz1k/7SJhcoIeMOBJXZS1GuIf38
 grLqUyCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ1BzqgAKCRAk1otyXVSH0K5oB/
 9g8XrD26deExaGvYbmtEB2rk9DdkgD0udiS0bq/MVMNeUZAP6wa0bz7mKAWRk9vEZ7UQ2XhBC+5JOU
 Y74TcXmBDAxrhN+kxiv/EwXqzTyvLBQ7dmz4sr6sfRUW2jIkzyawXKXPWByssW6Cqu0+Z+lCylgevf
 V9tCwn/IbrKcvHinej/SrO4Z1BvUjs4B+ea0iAmbCpTipdlARj8HTOESCozy38MrlHXpktcPv5Nzuh
 5Z6YyRTBGFWARBoyqqtAMrB4UKfclQrK1g4flJL01GNB5xki7imPM+Xdf+sclqpAKtOMX1ErxyGIQu
 ETIrsydK0mSkxcXkHB0+UfZC4CPCFD
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


