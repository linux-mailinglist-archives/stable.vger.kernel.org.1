Return-Path: <stable+bounces-148463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE17ACA80B
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 03:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A2D3AB9F3
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 01:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625C4280CC8;
	Sun,  1 Jun 2025 23:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfyuLjqJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA6A259CA3;
	Sun,  1 Jun 2025 23:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820551; cv=none; b=CEaua4A+FDNxgcwbLYq+yLyv6kNlFNLalxJSa5J44E5v03LTC503ousaKx0YK0CRC3lE08VDGrMpw/fC0/zeJoxpS/eiTpV60tuFS2zzlS/Vqi7IScbYfystgCY8LbsWTViLJ8xhEvgSfs/cRcTA3QOCgwpryqIT+CNWkU63dVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820551; c=relaxed/simple;
	bh=6dNR0iwUkDUe+Z20gH8lTMPYmMWgLOdwIuunJo8fX5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUZTsvfar+BamB5X1yZ8vbQX8DUIDnST6nYWi2GsCmj7vYYPNQr2kkw/gMp+TkUVXCGfu4OiYQeuF519BTRWlnOD+oXQCbFq5e9Csw0Vty2gTi4RhvmcNhqAIlNrZxLJ30NFqFrL4eJKLZN6nwqPRkw8dTwR+dnKmwiwojIiohg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfyuLjqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01ADC4CEEE;
	Sun,  1 Jun 2025 23:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820551;
	bh=6dNR0iwUkDUe+Z20gH8lTMPYmMWgLOdwIuunJo8fX5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SfyuLjqJ26l1LC7yC+XRhtYwBDKBvK+KYvla2IXkKIz9odywgbnb5El1z+ojK0uDj
	 DtN2Z5SIy1F8i0OXpE7Vp09eyfTCKViSQ29nV/jACsLFTQQwqIBanMG44NpcUMcEpj
	 yzC4EIbhcQtCQf7iL4r2OJY93ZqSanVTaQQ6ELiC8fA1qf7L4jFdvkfn5KuHQBofGY
	 /0WOmHxR9NNccuSsvaxwXNR8odVLWH8bPmTR/Q8MjslbyNjPrx6frBajBYRxwfJnxd
	 lFHDa/mwfU+y0Brlh7zYKNEXuIWRcajhJKnbD02XpfAOwd6XLUIUNtdGIICB9ivOG6
	 PjIR18igawIkQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jstultz@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 097/110] clocksource: Fix the CPUs' choice in the watchdog per CPU verification
Date: Sun,  1 Jun 2025 19:24:19 -0400
Message-Id: <20250601232435.3507697-97-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601232435.3507697-1-sashal@kernel.org>
References: <20250601232435.3507697-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>

[ Upstream commit 08d7becc1a6b8c936e25d827becabfe3bff72a36 ]

Right now, if the clocksource watchdog detects a clocksource skew, it might
perform a per CPU check, for example in the TSC case on x86.  In other
words: supposing TSC is detected as unstable by the clocksource watchdog
running at CPU1, as part of marking TSC unstable the kernel will also run a
check of TSC readings on some CPUs to be sure it is synced between them
all.

But that check happens only on some CPUs, not all of them; this choice is
based on the parameter "verify_n_cpus" and in some random cpumask
calculation. So, the watchdog runs such per CPU checks on up to
"verify_n_cpus" random CPUs among all online CPUs, with the risk of
repeating CPUs (that aren't double checked) in the cpumask random
calculation.

But if "verify_n_cpus" > num_online_cpus(), it should skip the random
calculation and just go ahead and check the clocksource sync between
all online CPUs, without the risk of skipping some CPUs due to
duplicity in the random cpumask calculation.

Tests in a 4 CPU laptop with TSC skew detected led to some cases of the per
CPU verification skipping some CPU even with verify_n_cpus=8, due to the
duplicity on random cpumask generation. Skipping the randomization when the
number of online CPUs is smaller than verify_n_cpus, solves that.

Suggested-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/all/20250323173857.372390-1-gpiccoli@igalia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my detailed analysis: **Bug Fix Analysis:** The commit fixes a logical
flaw in the clocksource watchdog's per-CPU verification mechanism. The
issue occurs in the `clocksource_verify_choose_cpus()` function at
`/kernel/time/clocksource.c:313`. **The Problem:** The original
condition `if (n < 0)` only checked for negative values of
`verify_n_cpus`, but when `verify_n_cpus` (default 8) is greater than
the number of online CPUs, the code would still proceed with random CPU
selection. This could lead to: 1. **CPU duplication**: Random selection
could pick the same CPU multiple times 2. **Incomplete coverage**: Some
CPUs might never be tested due to duplicates 3. **Inefficient
verification**: Testing fewer unique CPUs than intended **The Fix:** The
change from: ```c if (n < 0) { ``` to: ```c if (n < 0 || n >=
num_online_cpus()) { ``` Now correctly handles the case where
`verify_n_cpus >= num_online_cpus()` by bypassing random selection and
testing ALL online CPUs instead. **Backport Suitability Criteria:** 1.
**Important Bug Fix**: ✅ Fixes incorrect CPU verification that could
miss clocksource synchronization issues 2. **Small and Contained**: ✅
Single line change with clear, minimal scope 3. **No Side Effects**: ✅
Only affects the CPU selection logic, doesn't change fundamental
behavior 4. **No Architectural Changes**: ✅ Simple conditional logic fix
5. **Critical Subsystem**: ✅ Clocksource watchdog is crucial for system
timing reliability 6. **Minimal Regression Risk**: ✅ The fix makes the
verification more thorough, not less **Similar Commit Patterns:** This
matches the pattern of similar commits marked "YES" like commit #2 and
#3, which were small, focused fixes to clocksource verification logic
that improved reliability without introducing risks. **Real-World
Impact:** The commit message specifically mentions testing on a 4-CPU
laptop where the bug caused CPU verification to skip CPUs even with
`verify_n_cpus=8`, demonstrating this is a real issue affecting actual
systems. This is exactly the type of targeted bug fix that stable trees
are designed to include - it fixes incorrect behavior, has minimal risk,
and improves system reliability.

 kernel/time/clocksource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index bb48498ebb5a8..6a8bc7da90626 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -310,7 +310,7 @@ static void clocksource_verify_choose_cpus(void)
 {
 	int cpu, i, n = verify_n_cpus;
 
-	if (n < 0) {
+	if (n < 0 || n >= num_online_cpus()) {
 		/* Check all of the CPUs. */
 		cpumask_copy(&cpus_chosen, cpu_online_mask);
 		cpumask_clear_cpu(smp_processor_id(), &cpus_chosen);
-- 
2.39.5


