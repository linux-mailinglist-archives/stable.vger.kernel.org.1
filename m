Return-Path: <stable+bounces-177951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6062B46D8C
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 15:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D957C652B
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 13:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33452EFD88;
	Sat,  6 Sep 2025 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyKJC91q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739E12EFD86
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757164349; cv=none; b=cWK2G1BBO3YEoU2SLmw7QQUAX6wgc7ajb4Anrdh3Srd990mf/dlhLXpB2RNiJ8kWhi96nlZGXCEB/PqlQDWxKM9REttUddrC2sk1kLIhl+P5RqGZwEDrTjgYTNsmNRtGI0qKVe4CIc+FA+/o6MorsM7tvmbCdmqbdtOPmr9mXJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757164349; c=relaxed/simple;
	bh=ET+A6zhmEpeh+uZfXth9/TDLo7J3/7ZOU0DFc9lMiiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQivgoSS4Rycd5ut4sxMH4Snqq3G26UNENFbNKgZZ1OC4IgEWUxdKZGZiVeLDJr8XkWXQ9eLkskDRzKtUCG2djR0hEKJT3YcvVx9gIVXw+Yc8u8a6SJ/mSLJPxUntPZC/ka1N/GuRaanh691oqiA3uHk+osL3MoQ7iQ9TQP1aO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyKJC91q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11C0C4CEF9;
	Sat,  6 Sep 2025 13:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757164349;
	bh=ET+A6zhmEpeh+uZfXth9/TDLo7J3/7ZOU0DFc9lMiiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oyKJC91qysNYRiqyAfjzXMwg1CNxBgwuydkIcJbXiOvW7nfhNzHpdf6USt3Cllg9q
	 pkWXV0mDOf7oooBehRr+/xwenzowJMnuEcUpWVFcye1sKULzfVjJS+XiHdaacRhXYG
	 IC0jHpGpi5Xfj92a9e7B4NCn2cIJo24st06uc4rIqEsHNPuYVzIFNAp2HlE7mHxyoy
	 5ku2ynKpot5V4mCNFAC/LSiaq9ZQBNT8Ki/UWyv8KjQyqvw+KGXM3uaWhK91p8wSd+
	 dGrAAblKdkdCoReAUSKKfgGSSBvmP03uWCus8TgFS1UvulvjkelLEoq6tfayK56kiI
	 4yOrUa0XCzlSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] cpufreq: intel_pstate: Unchecked MSR aceess in legacy mode
Date: Sat,  6 Sep 2025 09:12:24 -0400
Message-ID: <20250906131224.3883544-4-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250906131224.3883544-1-sashal@kernel.org>
References: <2025050513-urchin-estranged-d31c@gregkh>
 <20250906131224.3883544-1-sashal@kernel.org>
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
index 0e8568a488847..abba45b1bcf2b 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -594,6 +594,9 @@ static bool turbo_is_disabled(void)
 {
 	u64 misc_en;
 
+	if (!cpu_feature_enabled(X86_FEATURE_IDA))
+		return true;
+
 	rdmsrl(MSR_IA32_MISC_ENABLE, misc_en);
 
 	return !!(misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
-- 
2.50.1


