Return-Path: <stable+bounces-139584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 577E3AA8C0B
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 08:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51BF31893537
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 06:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AE61885B4;
	Mon,  5 May 2025 06:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EeJaGqtL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BB83C463
	for <stable@vger.kernel.org>; Mon,  5 May 2025 06:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746425180; cv=none; b=JeWjrTvdU8atpMlJjZ8oXFcOcIiV5lt2fZwipYqmnMMGq27K7IJd9liLI0fzJPH86i1n57wRRvkc4cq/H6dvVa144O19lEPln/3guPVTGEvG/HC0KmpBPKwBVAKW7Nur+cxSZI5sXDSrRwBsDG86cHbfJmA00gneKrnpGNCtExI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746425180; c=relaxed/simple;
	bh=9qEcKQOwI06IPCCac/cieJ7HUI5EnDuwAA2DR7v7KGU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IbkEn53dwzUoyupeiwwe/bZEOeYi3FAdSLr9dCotxV32uio93SAbKcsngvjrmLV4J+vGYkHsF//BBj14sKiTRnlugl5HXzFRCqoAeGmzJuCg/iyF3S14d2Lo9ffEXtEJW++N9xpZ6Prv/2hFPnAhLHBFBCULpyzC7Y2n6eV0Yfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EeJaGqtL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9662C4CEE4;
	Mon,  5 May 2025 06:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746425180;
	bh=9qEcKQOwI06IPCCac/cieJ7HUI5EnDuwAA2DR7v7KGU=;
	h=Subject:To:Cc:From:Date:From;
	b=EeJaGqtLvd5tk+aG4bZ7CzxhcGqocOz55/di0rN3LI+fOkYBb5fXNV8J/hvSKqOh/
	 rHmmfU4jVT5EAAspGYSTRk3FKsyMK6F1vNBFGBM3Y8ZX/q0I466LtLJqD76Lf56JIO
	 3MdJkLnsNteBe5Ge9eie2Rr/vdBOEmTZtXOYPoP8=
Subject: FAILED: patch "[PATCH] cpufreq: intel_pstate: Unchecked MSR aceess in legacy mode" failed to apply to 6.1-stable tree
To: srinivas.pandruvada@linux.intel.com,rafael.j.wysocki@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 May 2025 08:06:15 +0200
Message-ID: <2025050515-constrain-banter-97de@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ac4e04d9e378f5aa826c2406ad7871ae1b6a6fb9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050515-constrain-banter-97de@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ac4e04d9e378f5aa826c2406ad7871ae1b6a6fb9 Mon Sep 17 00:00:00 2001
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Tue, 29 Apr 2025 14:07:11 -0700
Subject: [PATCH] cpufreq: intel_pstate: Unchecked MSR aceess in legacy mode

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

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index f41ed0b9e610..ba9bf06f1c77 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -598,6 +598,9 @@ static bool turbo_is_disabled(void)
 {
 	u64 misc_en;
 
+	if (!cpu_feature_enabled(X86_FEATURE_IDA))
+		return true;
+
 	rdmsrl(MSR_IA32_MISC_ENABLE, misc_en);
 
 	return !!(misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);


