Return-Path: <stable+bounces-177948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF56B46D8A
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 15:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6121D7C663D
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 13:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D9D2ED161;
	Sat,  6 Sep 2025 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmoOrjC2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A281F131E2D
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757164347; cv=none; b=Snz3xL5yOxS/Msi26Lfw1rLbRFmTZ1wHpXeV2KKh1IiOt3Q8etlTdTsnAr7rTXjPwl5ID9qtfMP2NnRX8rAzdefQU+4JT7cwOBrHWLuM+rd6G7bNs9z3qXiwBMu4DhVKc1mX0BSNJGsVVydokY6Vy9hNVWt8aDrAqZlaf/FUjKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757164347; c=relaxed/simple;
	bh=iNYwn3y6pYDfxMgHpyPa9i35L13FBpMRj+bl0N1clKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6Dza5kskZZpq7jiV5BPsWQnh/TpwWsTXlGYPj+UzvXvpt14/vvC1KukQeH6PO/nFdjQrjvuWclHd6uDJO5a/CxVbgBV7CEaiv0vVX2fJhdVwyuu6u2hf/FaY04sNaym+/4LT/LmNN98LDn5M8RC7TVRLK4Wsx/39dpeh6hptgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmoOrjC2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03B1C4CEE7;
	Sat,  6 Sep 2025 13:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757164347;
	bh=iNYwn3y6pYDfxMgHpyPa9i35L13FBpMRj+bl0N1clKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lmoOrjC2un0K1od7p3RJ+pPWO52ZHCfinZ3xyfwBYw5dKIw/iZLbxTLEBjfUidYmV
	 LFVj+iyQib1+i4pfQ1mFxuGNq7RCngDycXZ1vFUJiLfr7H+U48UPL7Q4cFYlrOpA5a
	 lzvAk56NvMHrHSphZCTR7kHz8hJs/FyMn4aOFZC+XTVNbT3Oi3rS7vFXqfGX06CYaY
	 ZP54gYlzyJnwleAarrenyThtYPAz8uJjBzDC186MwqBFaKA4RnnnAvMTMCtG8UNSEz
	 HENrpHjbcQnMA5eGPYU++C/heLokxaflvGfBU+TgF3Yr4IXP+k/AXkUYMSCUkHOy4s
	 9NwgKtU39ReoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] cpufreq: intel_pstate: Revise global turbo disable check
Date: Sat,  6 Sep 2025 09:12:21 -0400
Message-ID: <20250906131224.3883544-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025050513-urchin-estranged-d31c@gregkh>
References: <2025050513-urchin-estranged-d31c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 37b6ddba967c601479bea418a7ac6ff16b6232b7 ]

Setting global turbo flag based on CPU 0 P-state limits is problematic
as it limits max P-state request on every CPU on the system just based
on its P-state limits.

There are two cases in which global.turbo_disabled flag is set:
- When the MSR_IA32_MISC_ENABLE_TURBO_DISABLE bit is set to 1
in the MSR MSR_IA32_MISC_ENABLE. This bit can be only changed by
the system BIOS before power up.
- When the max non turbo P-state is same as max turbo P-state for CPU 0.

The second check is not a valid to decide global turbo state based on
the CPU 0. CPU 0 max turbo P-state can be same as max non turbo P-state,
but for other CPUs this may not be true.

There is no guarantee that max P-state limits are same for every CPU. This
is possible that during fusing max P-state for a CPU is constrained. Also
with the Intel Speed Select performance profile, CPU 0 may not be present
in all profiles. In this case the max non turbo and turbo P-state can be
set to the lowest possible P-state by the hardware when switched to
such profile. Since max non turbo and turbo P-state is same,
global.turbo_disabled flag will be set.

Once global.turbo_disabled is set, any scaling max and min frequency
update for any CPU will result in its max P-state constrained to the max
non turbo P-state.

Hence remove the check of max non turbo P-state equal to max turbo P-state
of CPU 0 to set global turbo disabled flag.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
[ rjw: Subject edit ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: ac4e04d9e378 ("cpufreq: intel_pstate: Unchecked MSR aceess in legacy mode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/intel_pstate.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 4f1206ff0a10e..b2da03cd8ebd9 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -595,13 +595,9 @@ static void intel_pstate_hybrid_hwp_adjust(struct cpudata *cpu)
 static inline void update_turbo_state(void)
 {
 	u64 misc_en;
-	struct cpudata *cpu;
 
-	cpu = all_cpu_data[0];
 	rdmsrl(MSR_IA32_MISC_ENABLE, misc_en);
-	global.turbo_disabled =
-		(misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE ||
-		 cpu->pstate.max_pstate == cpu->pstate.turbo_pstate);
+	global.turbo_disabled = misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE;
 }
 
 static int min_perf_pct_min(void)
-- 
2.50.1


