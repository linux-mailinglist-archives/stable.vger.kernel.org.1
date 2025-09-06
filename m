Return-Path: <stable+bounces-177958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D3DB46E00
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 15:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91CFF18950B5
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 13:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C522F069F;
	Sat,  6 Sep 2025 13:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kplC5QbV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0352F068C
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757164937; cv=none; b=o6DEpK5JQr4X0Z/73Nj1ImgwvvGgbLvOZJwzkoiP8pQ9o2X5qsKUPyLcAJzK6cyAgGSOfg1leff2AkTPw0K5zqBSCZ+vPDVfOVTgBfXRSY+ysd9gHJL6Ssj7Fp8iYCbOzNvLQ477Rq23aSxAmL5d+UYL0tK6nCttk2GpHv0FiWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757164937; c=relaxed/simple;
	bh=Ryh00HzG/QXTqpBA3b8W6GV9y3N8qfSfIEGeLOo9y3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbarsUZqo0onA2/mjr3YIouKNUmYk7DKWZyiDUc5aC3Dfmz/8tJ9/hAGqL3d3k9hjhDm7JX0tXhGLinAqwK99M8sqj8+UNeJXoXreg8+SSPDqZ68mo8lGG8qqRSjrAW3Cp3aH2AEIqpVsqCdw6dU2Ls0Bu/h7jzlGYmAYbQucAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kplC5QbV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E761C4CEF7;
	Sat,  6 Sep 2025 13:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757164935;
	bh=Ryh00HzG/QXTqpBA3b8W6GV9y3N8qfSfIEGeLOo9y3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kplC5QbVP2+puWjwkaShhh05rRKswrIiNMERJHsSN+w8Cac/KBH7jOaiLUoMVhQuu
	 8rI/R9Bm9mU746K6cQyywSIgjdgRukE0Jhm/HGkddIrRgLoH3G4AdHR++uqgtU1pjH
	 wRH9oRV0CPRjAG0gDSilG/Z4RWdT79B0dOfUPn6yzguRJyiXHQxHUsYV3rvRW+OLnW
	 z0tEUcDYkigGlFK66WqZcLXed+cIh5ejp4J5Y4joiRqWgIEpUeAeSKHFpHcWtR/85E
	 MgAS4QEEwCIZxEcgQ3W93kHUwF/ubaNJcDdI6liL+ecpeg7L7E3bQsfiAb0puXD3o/
	 I0lIfqcwAKazA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] cpufreq: intel_pstate: Unchecked MSR aceess in legacy mode
Date: Sat,  6 Sep 2025 09:22:10 -0400
Message-ID: <20250906132210.3888723-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250906132210.3888723-1-sashal@kernel.org>
References: <2025050515-constrain-banter-97de@gregkh>
 <20250906132210.3888723-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit ac4e04d9e378f5aa826c2406ad7871ae1b6a6fb9 ]

When turbo mode is unavailable on a Skylake-X system, executing the
command:

 # echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo

results in an unchecked MSR access error:

 WRMSR to 0x199 (attempted to write 0x0000000100001300).

This issue was reproduced on an OEM (Original Equipment Manufacturer)
system and is not a common problem across all Skylake-X systems.

This error occurs because the MSR 0x199 Turbo Engage Bit (bit 32) is set
when turbo mode is disabled. The issue arises when intel_pstate fails to
detect that turbo mode is disabled. Here intel_pstate relies on
MSR_IA32_MISC_ENABLE bit 38 to determine the status of turbo mode.
However, on this system, bit 38 is not set even when turbo mode is
disabled.

According to the Intel Software Developer's Manual (SDM), the BIOS sets
this bit during platform initialization to enable or disable
opportunistic processor performance operations. Logically, this bit
should be set in such cases. However, the SDM also specifies that "OS
and applications must use CPUID leaf 06H to detect processors with
opportunistic processor performance operations enabled."

Therefore, in addition to checking MSR_IA32_MISC_ENABLE bit 38, verify
that CPUID.06H:EAX[1] is 0 to accurately determine if turbo mode is
disabled.

Fixes: 4521e1a0ce17 ("cpufreq: intel_pstate: Reflect current no_turbo state correctly")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/intel_pstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1918cceca6cea..7d28bf7548cfa 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -561,6 +561,9 @@ static bool turbo_is_disabled(void)
 {
 	u64 misc_en;
 
+	if (!cpu_feature_enabled(X86_FEATURE_IDA))
+		return true;
+
 	rdmsrl(MSR_IA32_MISC_ENABLE, misc_en);
 
 	return !!(misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
-- 
2.51.0


