Return-Path: <stable+bounces-177955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D3FB46E01
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 15:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CAAA1894D15
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 13:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92992EDD7D;
	Sat,  6 Sep 2025 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhlMeLzz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B3D1527B4
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757164933; cv=none; b=RG+TN88oQqv/ykcepFqLUgvCw6zayM/rdvivUte2+V/VtxxE7W1gAYYSjY5kvaN8lmgriZeOqoWGV07BIN031TDj6mXFBHhzZ4gZLSt7SmIdeqHKQY4u7OvGPBlcbOSsPaNJ5kCjk9RvCsSk9yIfStQCZXbNS8yaQO344c+X87Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757164933; c=relaxed/simple;
	bh=aegBvUEfcOddN045APCoDtIfE8IfXSCjp1SZ4T8Kb+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4/41Bdh8zXH6XeK5ya16q7SADtSGCk9C0ZsCbFn5QoThzXhPOeoRA38WQmRSqfXln2skffW3Gz5oZbvSMT+ocXm+f5v1BnCPkhN7BNDsihNawyWOt15WDrgMuoviVtBKMiEl/yjW0Ko8w2Tb0et2iSe6XPMh1k4/yR0ftrlnlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhlMeLzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823B2C4CEE7;
	Sat,  6 Sep 2025 13:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757164933;
	bh=aegBvUEfcOddN045APCoDtIfE8IfXSCjp1SZ4T8Kb+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lhlMeLzz1bNrmduxeP4QKPAjN2/8ivcLKYjKoqz+Fu9cm0OqHendYWUj0Y6OEhCF7
	 g/XFwli8J3tAIQHc7pyZFRWU5Zo7bExqEKkeMZ4DVJeMEK84qnANKT2oS6HKijZX9v
	 CKvIYxdDeJBAoI9TV3X7Bp81ziIuaotiBATIBW6tjuk6bxaF74BjWXtymarwCa/uCI
	 1DbUYdGdg0JhovXXjGFLIrOcdXvKPS6kgmBTl7IkIM2mB5rQhUMox+xmFIsgOqzefc
	 7uNfE4TlJJrxdXJabJ7o+G7/tnDu7eU/YPjKYKCS4VDHBAyR+aXsYNvedu12NySKO3
	 EcXBljR9cCt7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] cpufreq: intel_pstate: Revise global turbo disable check
Date: Sat,  6 Sep 2025 09:22:07 -0400
Message-ID: <20250906132210.3888723-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025050515-constrain-banter-97de@gregkh>
References: <2025050515-constrain-banter-97de@gregkh>
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
index ee676ae1bc488..15d0d498071f1 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -562,13 +562,9 @@ static void intel_pstate_hybrid_hwp_adjust(struct cpudata *cpu)
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
2.51.0


