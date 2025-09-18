Return-Path: <stable+bounces-166371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC9AB19950
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 02:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5DB18983BC
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 00:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36B01E1E1B;
	Mon,  4 Aug 2025 00:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9ayG9Jm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F487260B;
	Mon,  4 Aug 2025 00:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754268070; cv=none; b=J/eaejG0Fno+ayWBWy5ccLf3UgqquoSK7dElAXjc6l/Dj7x6+jh/Aymu81Y0xyveF0sTZfVXbLgt+JvXjH29Irz5ySE2Pu51J19pfK5vhxQxHVrQOceWi7RPT4/m7tSCtJhnra5SsLsQMID/rOLDh5VcaMSexku/TZTHojjrJEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754268070; c=relaxed/simple;
	bh=kEDFM1+saxL4i+9T7MBV1tuzA5+VObYzj4dtLR0QQbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mE8S7EDGzxeUJjf5Ko4Ae4wXcxhFph9QLaGF+tLc4/1V5+TrJZ1wdJXYv18DS72xO0/Xxv2tTjCxWPHnfEQfsbzj9sNs6c4AerpHiMuEs4OcjBZuoCiajQgRW/b6DnrNkorHuJZs7uJeIyR4hnWqoJsLmrGJjfQo3kfqXajvJNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9ayG9Jm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00808C4CEF8;
	Mon,  4 Aug 2025 00:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754268070;
	bh=kEDFM1+saxL4i+9T7MBV1tuzA5+VObYzj4dtLR0QQbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O9ayG9JmZI2AA3Ig0agVF934kGVHXRDeXFD69B/8BKThRsgIXjOexd94ICaar0c+V
	 XcbxxiWoJukfNt+rhcn2ombYlN4a+ZvQ/e7AGRcJoaV8/G2GtqgEpBkVkHUmKOLlFv
	 IaQt2kS5YtTsGrjCIAZJNG2pPEmcf7FXqyJQfLTBtfgEoDUwDDxvQNUDaBECfFag1n
	 PdJBK/gerOQW0abrhL5yRi2ms/miQ5/U+gfZtvL0INET+PpV0znpAyWEaoJnp4yIz2
	 ni6FpqCThNr5668NDAwc0Ikf1EwEoyr79oWyHh+so6tWmOmvNanlmGdfN6IphiqWe6
	 B0GHHmbsYvVQQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Alexander Kochetkov <al.kochet@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 11/39] ARM: rockchip: fix kernel hang during smp initialization
Date: Sun,  3 Aug 2025 20:40:13 -0400
Message-Id: <20250804004041.3628812-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804004041.3628812-1-sashal@kernel.org>
References: <20250804004041.3628812-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.240
Content-Transfer-Encoding: 8bit

From: Alexander Kochetkov <al.kochet@gmail.com>

[ Upstream commit 7cdb433bb44cdc87dc5260cdf15bf03cc1cd1814 ]

In order to bring up secondary CPUs main CPU write trampoline
code to SRAM. The trampoline code is written while secondary
CPUs are powered on (at least that true for RK3188 CPU).
Sometimes that leads to kernel hang. Probably because secondary
CPU execute trampoline code while kernel doesn't expect.

The patch moves SRAM initialization step to the point where all
secondary CPUs are powered down.

That fixes rarely hangs on RK3188:
[    0.091568] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.091996] rockchip_smp_prepare_cpus: ncores 4

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
Link: https://lore.kernel.org/r/20250703140453.1273027-1-al.kochet@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my analysis of the commit and the code context, here's my
determination:

**Backport Status: YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Fixes a real bug affecting users**: The commit explicitly mentions
   that it "fixes rarely hangs on RK3188" during SMP initialization.
   This is a critical boot-time issue that prevents the system from
   functioning properly.

2. **Small and contained fix**: The change is minimal - it only moves
   the SRAM initialization code (`rockchip_smp_prepare_sram()`) to
   execute after all secondary CPUs are powered down. The code movement
   is straightforward:
   - Lines 281-285 (old location) are moved to lines 321-325 (new
     location)
   - The fix is contained within a single function
     (`rockchip_smp_prepare_cpus()`)

3. **Clear root cause**: The commit message explains the race condition
   clearly - secondary CPUs may execute trampoline code while it's being
   written to SRAM, causing unpredictable behavior and hangs.

4. **No architectural changes**: This is purely a timing/ordering fix
   that doesn't introduce new features or change the architecture of the
   code.

5. **Critical subsystem**: SMP initialization is a critical kernel
   subsystem. A hang during boot makes the system unusable, which is a
   severe issue for affected users.

6. **Platform-specific fix**: The change only affects Rockchip ARM
   platforms (specifically those with Cortex-A9 CPUs like RK3188),
   limiting the scope of potential regressions.

7. **Follows stable tree rules**: The fix addresses an important bug
   (boot hang), is small and self-contained, has minimal risk of
   regression, and doesn't introduce new features.

The key insight from the code analysis is that the original code had a
clear race condition where:
1. Secondary CPUs were powered on (lines 287-288 in the original)
2. Trampoline code was written to SRAM (line 282 in the original)
3. Secondary CPUs could potentially execute incomplete/corrupted
   trampoline code

The fix ensures all secondary CPUs are powered down (lines 321-323)
before writing the trampoline code to SRAM (lines 321-325 in the new
version), eliminating the race condition.

 arch/arm/mach-rockchip/platsmp.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index d60856898d97..17aee4701e81 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -279,11 +279,6 @@ static void __init rockchip_smp_prepare_cpus(unsigned int max_cpus)
 	}
 
 	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9) {
-		if (rockchip_smp_prepare_sram(node)) {
-			of_node_put(node);
-			return;
-		}
-
 		/* enable the SCU power domain */
 		pmu_set_power_domain(PMU_PWRDN_SCU, true);
 
@@ -316,11 +311,19 @@ static void __init rockchip_smp_prepare_cpus(unsigned int max_cpus)
 		asm ("mrc p15, 1, %0, c9, c0, 2\n" : "=r" (l2ctlr));
 		ncores = ((l2ctlr >> 24) & 0x3) + 1;
 	}
-	of_node_put(node);
 
 	/* Make sure that all cores except the first are really off */
 	for (i = 1; i < ncores; i++)
 		pmu_set_power_domain(0 + i, false);
+
+	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9) {
+		if (rockchip_smp_prepare_sram(node)) {
+			of_node_put(node);
+			return;
+		}
+	}
+
+	of_node_put(node);
 }
 
 static void __init rk3036_smp_prepare_cpus(unsigned int max_cpus)
-- 
2.39.5


