Return-Path: <stable+bounces-206129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C33CFD831
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 12:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC2A5303D69E
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 11:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB023128BA;
	Wed,  7 Jan 2026 11:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=Richa.Bharti@siemens.com header.b="E+qsmL/K"
X-Original-To: stable@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4106C312837
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767786709; cv=none; b=K8m9MNpJPH4dpih0lUJDbu8T27CkXiSKENIQCToJtlNa115hYi0xWpNDHUix0ckK4ExYpv3JtB/tmUwgSZRmaeaeLF0IqkBeYBAeidCijn+O/2IpQsiGkFJ+KrXPeI1wKBMvG8E6gEbMUJuXctYJIvmXKZOIBGpkBY+P1ADffoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767786709; c=relaxed/simple;
	bh=rHMi3XeR87UXDD+RjhBbU2SrTE09ZC8y2TFyQl2GILA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cgVKEeSj6Ra9Mstjp+NVLnqLKg+zZic1vtJIF3iGxq0VxDTufiIlgdevLflJjQWdzWZBpYqTbpC0bHlHPHgioxxcjjJbg7y2vTFRVWqpg9BTxIdJYIzvQwvDoPfFkCcawop+9E/2S1BHKdK9ReWVFCYNMAKn6hQoSxGf2wFEKvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=Richa.Bharti@siemens.com header.b=E+qsmL/K; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260107115124eb92d18f4300020734
        for <stable@vger.kernel.org>;
        Wed, 07 Jan 2026 12:51:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Richa.Bharti@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=YtX0aVTbv0g97nvkbe6SgQL1fwdN432o8qw7Qm08lSg=;
 b=E+qsmL/KI3Mt66VhxqD8u+J63v4Ml9GzqC5tsDDESZ0ysIeKZ080xA55Sd+9W9KdAq0L8D
 T+rreu3F4RU471xT+FhRg0/gLeOqLomWUHhI6fVaP/dr5dLjna88yxXwyZgJ97FNxUqTNw7t
 QUKE/g2B3zIePAgMOYxhcW6B7dnsaKdzTcj8tk+Nbcka/Z2cXC3hdHn4fN4HfjqKHxvwHdqr
 /XkyjtdxaalkSFSa/vJoAadRh/TqoZqToXBmdcCexv6OKczHlv1n0/6kB56fuKGANZAM/Nsz
 q+jwMjc39Zn2WABTD2pJHRBx5GzL9fIo8aKwPrSU74ki3Tly4jxa+KGA==;
From: Richa Bharti <Richa.Bharti@siemens.com>
To: stable@vger.kernel.org
Cc: srikanth.krishnakar@siemens.com,
	Richa Bharti <richa.bharti@siemens.com>,
	Aaron Rainbolt <arainbolt@kfocus.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH stable 6.12.y] cpufreq: intel_pstate: Check IDA only before MSR_IA32_PERF_CTL writes
Date: Wed,  7 Jan 2026 17:19:38 +0530
Message-Id: <20260107114938.1680855-1-Richa.Bharti@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1331316:519-21489:flowmailer

From: Richa Bharti <richa.bharti@siemens.com>

[ Upstream commit 4b747cc628d8f500d56cf1338280eacc66362ff3 ]

Commit ac4e04d9e378 ("cpufreq: intel_pstate: Unchecked MSR aceess in
legacy mode") introduced a check for feature X86_FEATURE_IDA to verify
turbo mode support. Although this is the correct way to check for turbo
mode support, it causes issues on some platforms that disable turbo
during OS boot, but enable it later [1]. Before adding this feature
check, users were able to get turbo mode frequencies by writing 0 to
/sys/devices/system/cpu/intel_pstate/no_turbo post-boot.

To restore the old behavior on the affected systems while still
addressing the unchecked MSR issue on some Skylake-X systems, check
X86_FEATURE_IDA only immediately before updates of MSR_IA32_PERF_CTL
that may involve setting the Turbo Engage Bit (bit 32).

Fixes: ac4e04d9e378 ("cpufreq: intel_pstate: Unchecked MSR aceess in legacy mode")
Reported-by: Aaron Rainbolt <arainbolt@kfocus.org>
Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2122531 [1]
Tested-by: Aaron Rainbolt <arainbolt@kfocus.org>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
[ rjw: Subject adjustment, changelog edits ]
Link: https://patch.msgid.link/20251111010840.141490-1-srinivas.pandruvada@linux.intel.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[ richa: Backport to 6.12.y with context adjustments ]
Signed-off-by: Richa Bharti <richa.bharti@siemens.com>
---
 drivers/cpufreq/intel_pstate.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index d0f4f7c2ae4d..9d8cb44c26c7 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -600,9 +600,6 @@ static bool turbo_is_disabled(void)
 {
 	u64 misc_en;
 
-	if (!cpu_feature_enabled(X86_FEATURE_IDA))
-		return true;
-
 	rdmsrl(MSR_IA32_MISC_ENABLE, misc_en);
 
 	return !!(misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
@@ -2018,7 +2015,8 @@ static u64 atom_get_val(struct cpudata *cpudata, int pstate)
 	u32 vid;
 
 	val = (u64)pstate << 8;
-	if (READ_ONCE(global.no_turbo) && !READ_ONCE(global.turbo_disabled))
+	if (READ_ONCE(global.no_turbo) && !READ_ONCE(global.turbo_disabled) &&
+	    cpu_feature_enabled(X86_FEATURE_IDA))
 		val |= (u64)1 << 32;
 
 	vid_fp = cpudata->vid.min + mul_fp(
@@ -2183,7 +2181,8 @@ static u64 core_get_val(struct cpudata *cpudata, int pstate)
 	u64 val;
 
 	val = (u64)pstate << 8;
-	if (READ_ONCE(global.no_turbo) && !READ_ONCE(global.turbo_disabled))
+	if (READ_ONCE(global.no_turbo) && !READ_ONCE(global.turbo_disabled) &&
+	    cpu_feature_enabled(X86_FEATURE_IDA))
 		val |= (u64)1 << 32;
 
 	return val;
-- 
2.39.5


