Return-Path: <stable+bounces-165976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD51B196F9
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 02:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E4217359E
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 00:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEDE12C544;
	Mon,  4 Aug 2025 00:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdKSlRVb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7787C29A2;
	Mon,  4 Aug 2025 00:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267037; cv=none; b=mkze3w6qyVHW+Qg3dq/lr53EcdF4XpaA2EastZmEsR+vAUbQwB74iAZ26YPpb6/K0UbFK03SDFvsnnXZ5jDiTLYfYiQ68SOez2v0ronfynEvrH3ahCBPa3SpEPALxNLEso771jXmWHeYOMPksu/NIZRtPSS/jpixuSrnKJQcvvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267037; c=relaxed/simple;
	bh=1I9GAslWDFr4Ffdpv1CfrDGTrDxjC9k2Mmwm+PgyJww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UblivtUjBdvocVDT9xYu5dM97FHLlMGgJoPskFM1KkaeoF8OzNpWHmHizrMnAOH6bGCJXTnha9/D+RGUbo3toofMLtzNigykVQ57hODej8N9uK7GsjZ29NJStkDRGUw+jgOaWaOrUzI3MnqgHP4bR/xTTKcGzr21phBJruB5vFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdKSlRVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29FAC4CEF0;
	Mon,  4 Aug 2025 00:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267037;
	bh=1I9GAslWDFr4Ffdpv1CfrDGTrDxjC9k2Mmwm+PgyJww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rdKSlRVb+kIO4kvgWZWj0IGQnBlakN+S8oq0wv1MY4Hr3lb/rIB0WdOsGYsXNJo5e
	 a8ckMk38bdqlQFCyts1UWMPyz6Oa9c2nBguN6YkxJQFZmH4pPCcyS5tcRi+0HMhF2z
	 lIAjPnAu+vklSa03ELMHw+3MGerWfQNPbY6lxJf+uOmWlx0d/ky9Wow3ULhsbos072
	 1uQqiFXKofARPwPAd1hdt0tty6tX5tfo7+VxhJwe59PQRnpGJYpcx7W1XDoe1xlGMs
	 EcK1uSOVpi4Ml3Z7pflYULsjXdgvJ6BvqB3+fHHQBCNn0tp9UkhrAAcJ2qQ3wOJ7SD
	 gBu4Nd0Kf5KiQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Prashant Malani <pmalani@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.16 05/85] cpufreq: CPPC: Mark driver with NEED_UPDATE_LIMITS flag
Date: Sun,  3 Aug 2025 20:22:14 -0400
Message-Id: <20250804002335.3613254-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804002335.3613254-1-sashal@kernel.org>
References: <20250804002335.3613254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.16
Content-Transfer-Encoding: 8bit

From: Prashant Malani <pmalani@google.com>

[ Upstream commit 0a1416a49e63c320f6e6c1c8d07e1b58c0d4a3f3 ]

AMU counters on certain CPPC-based platforms tend to yield inaccurate
delivered performance measurements on systems that are idle/mostly idle.
This results in an inaccurate frequency being stored by cpufreq in its
policy structure when the CPU is brought online. [1]

Consequently, if the userspace governor tries to set the frequency to a
new value, there is a possibility that it would be the erroneous value
stored earlier. In such a scenario, cpufreq would assume that the
requested frequency has already been set and return early, resulting in
the correct/new frequency request never making it to the hardware.

Since the operating frequency is liable to this sort of inconsistency,
mark the CPPC driver with CPUFREQ_NEED_UPDATE_LIMITS so that it is always
invoked when a target frequency update is requested.

Link: https://lore.kernel.org/linux-pm/20250619000925.415528-3-pmalani@google.com/ [1]
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Prashant Malani <pmalani@google.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://patch.msgid.link/20250722055611.130574-2-pmalani@google.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Code Change Analysis

The change is minimal and focused - it only adds the
`CPUFREQ_NEED_UPDATE_LIMITS` flag to the cppc_cpufreq_driver struct:

```c
- .flags = CPUFREQ_CONST_LOOPS,
+ .flags = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
```

This single-line change modifies the driver flags in
drivers/cpufreq/cppc_cpufreq.c:928.

## Bug Being Fixed

The commit addresses a real bug where:

1. **AMU counters on CPPC platforms provide inaccurate measurements**
   when systems are idle/mostly idle
2. **This causes cpufreq to store incorrect frequency values** in its
   policy structure during CPU online
3. **Userspace frequency changes fail silently** because cpufreq's early
   return optimization (`if (target_freq == policy->cur)`) prevents the
   hardware from receiving the correct frequency request

The bug manifests as userspace being unable to set CPU frequencies
correctly on affected CPPC platforms, which is a functional regression
that impacts power management and performance.

## Why This Qualifies for Stable

1. **Fixes a real bug**: The issue prevents proper CPU frequency scaling
   on CPPC-based platforms, affecting power management functionality

2. **Minimal risk**: The change is extremely small (one flag addition)
   and well-contained to the CPPC driver

3. **Clear fix semantics**: The `CPUFREQ_NEED_UPDATE_LIMITS` flag is an
   established mechanism (introduced in commit 1c534352f47f)
   specifically designed for this scenario where drivers need frequency
   updates even when target_freq == policy->cur

4. **Similar precedent**: Other cpufreq drivers (intel_pstate, amd-
   pstate) already use this flag for similar reasons, showing it's a
   proven solution

5. **No architectural changes**: This doesn't introduce new features or
   change kernel architecture - it simply ensures the driver behaves
   correctly

6. **Recent related fixes**: The git history shows ongoing work to fix
   CPPC feedback counter issues (e.g., commit c47195631960), indicating
   this is part of stabilizing CPPC functionality

## Impact Assessment

- **Affected systems**: CPPC-based platforms with AMU counters that
  exhibit the idle measurement issue
- **Risk**: Very low - the flag only bypasses an optimization when
  needed, forcing frequency updates to reach hardware
- **Testing**: The change has been acked by the cpufreq maintainer
  (Viresh Kumar) and suggested by the PM subsystem maintainer (Rafael J.
  Wysocki)

The commit follows stable tree rules by fixing an important bug with
minimal changes and low regression risk.

 drivers/cpufreq/cppc_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index b7c688a5659c..c8e63c7aa9a3 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -925,7 +925,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
 };
 
 static struct cpufreq_driver cppc_cpufreq_driver = {
-	.flags = CPUFREQ_CONST_LOOPS,
+	.flags = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify = cppc_verify_policy,
 	.target = cppc_cpufreq_set_target,
 	.get = cppc_cpufreq_get_rate,
-- 
2.39.5


