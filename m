Return-Path: <stable+bounces-187687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBCFBEB154
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 19:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D613935D6F0
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB6F3074B7;
	Fri, 17 Oct 2025 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNkpGXd7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CA230748A;
	Fri, 17 Oct 2025 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760722443; cv=none; b=LGytwC9uoMb+z90vX+P+50xOp3jTMuuLvxRXxlxeNFdhRvNEcNEcs6lAHLBL2phXCDPD28h0x+tYwr5emY5agsqphsy24YtOnwAmHPRqC8lhQvqmXy2goD2iTjErgnZDpvzi/vrNikvCaxip43ZUHxBmVISu4Q1kOGQUI375goc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760722443; c=relaxed/simple;
	bh=WhWp+CUHcgUnStNBnvrT1zJCZqYFLjpY5pSs8TsRqU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aqSFImC4rfv68jS7sFN4L5bIBk7lD1rzGQJVACUtkrubTvJCOBmtqZ8OmhP7YMZXxcjtdVgPa9CbkaYW9HJprs+n4KU8w8nbGOwoJLw4H/55GmJnWaoCRAUhPEf05hKWdF6KxyfGjhyX8YwcwwUUM9SR7GOlyfiNAfHvokABpR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNkpGXd7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C095EC116D0;
	Fri, 17 Oct 2025 17:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760722443;
	bh=WhWp+CUHcgUnStNBnvrT1zJCZqYFLjpY5pSs8TsRqU8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fNkpGXd7LzPNn6YWgCub9r6mc4mUmj6n3AZPP/CIwx0TBBrwCoxHxfJQub1Gn/0gT
	 d0KeJnmbmuO2CDR9Gw2T2rpONISns1CVmhikhXAc0NIxvkeHDnTMTyila511lY9sqJ
	 ZOpDG15vcPbTQbyE/Tfs7Q+DoBPclF5he371riQFoflgeZC0ODDV66GipoDI4YmAV6
	 GqzPh723kx1lq/3Zvw3BKD6qevEE6Vo/UxtOcTcj2L3r/B7AykWrEF/9zCJUZNg+O+
	 vG1NylZiLXtisg5NferMQYdeva33YDr1ErsBZh4QB2S9qC4v/2Yh+4fwcqHgtHzUEA
	 HU0270s2NAMBQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Oct 2025 19:33:42 +0200
Subject: [PATCH 5.4.y 5/5] kernel/profile.c: use cpumask_available to check
 for NULL cpumask
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-v5-4-gcc-15-v1-5-6d6367ee50a1@kernel.org>
References: <20251017-v5-4-gcc-15-v1-0-6d6367ee50a1@kernel.org>
In-Reply-To: <20251017-v5-4-gcc-15-v1-0-6d6367ee50a1@kernel.org>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Nathan Chancellor <natechancellor@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2695; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Nv28f9jDG/WKsxu892MmMF8tyULuMgUkd2J73jIspzI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI+1f5VkUj3/HvgWKDOtQPvu2bxH7nyu6NvY2fbsbZjh
 b8mVs3L6ShlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZiIrA3D/+q/K212CJ3ftjvU
 51dM+2bH/4vUwmr4EzLtWo3j4yUK4xgZ+hfkm8rZ+G/Vf3uNs+ajqp1FY6ye8nn+3Z4K4tHXBZ4
 yAQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Nathan Chancellor <natechancellor@gmail.com>

commit ef70eff9dea66f38f8c2c2dcc7fe4b7a2bbb4921 upstream.

When building with clang + -Wtautological-pointer-compare, these
instances pop up:

  kernel/profile.c:339:6: warning: comparison of array 'prof_cpu_mask' not equal to a null pointer is always true [-Wtautological-pointer-compare]
          if (prof_cpu_mask != NULL)
              ^~~~~~~~~~~~~    ~~~~
  kernel/profile.c:376:6: warning: comparison of array 'prof_cpu_mask' not equal to a null pointer is always true [-Wtautological-pointer-compare]
          if (prof_cpu_mask != NULL)
              ^~~~~~~~~~~~~    ~~~~
  kernel/profile.c:406:26: warning: comparison of array 'prof_cpu_mask' not equal to a null pointer is always true [-Wtautological-pointer-compare]
          if (!user_mode(regs) && prof_cpu_mask != NULL &&
                                ^~~~~~~~~~~~~    ~~~~
  3 warnings generated.

This can be addressed with the cpumask_available helper, introduced in
commit f7e30f01a9e2 ("cpumask: Add helper cpumask_available()") to fix
warnings like this while keeping the code the same.

Link: https://github.com/ClangBuiltLinux/linux/issues/747
Link: http://lkml.kernel.org/r/20191022191957.9554-1-natechancellor@gmail.com
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[ These warnings are also visible with recent GCC versions. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 kernel/profile.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/profile.c b/kernel/profile.c
index b5ce18b6f1b9..af3d5c34d051 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -344,7 +344,7 @@ static int profile_dead_cpu(unsigned int cpu)
 	struct page *page;
 	int i;
 
-	if (prof_cpu_mask != NULL)
+	if (cpumask_available(prof_cpu_mask))
 		cpumask_clear_cpu(cpu, prof_cpu_mask);
 
 	for (i = 0; i < 2; i++) {
@@ -381,7 +381,7 @@ static int profile_prepare_cpu(unsigned int cpu)
 
 static int profile_online_cpu(unsigned int cpu)
 {
-	if (prof_cpu_mask != NULL)
+	if (cpumask_available(prof_cpu_mask))
 		cpumask_set_cpu(cpu, prof_cpu_mask);
 
 	return 0;
@@ -411,7 +411,7 @@ void profile_tick(int type)
 {
 	struct pt_regs *regs = get_irq_regs();
 
-	if (!user_mode(regs) && prof_cpu_mask != NULL &&
+	if (!user_mode(regs) && cpumask_available(prof_cpu_mask) &&
 	    cpumask_test_cpu(smp_processor_id(), prof_cpu_mask))
 		profile_hit(type, (void *)profile_pc(regs));
 }

-- 
2.51.0


