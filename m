Return-Path: <stable+bounces-139587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3351AAA8C0E
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 08:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710AE168B6A
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 06:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164981AA79C;
	Mon,  5 May 2025 06:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tcqcsD45"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C930DEEBA
	for <stable@vger.kernel.org>; Mon,  5 May 2025 06:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746425189; cv=none; b=nE3MmrLG8xk0Riw9bncpXLWJ2ddbHo/rTwZPyrsvhvU7O2a0IJwiHaYmzs6pAf6i/hy7YkCJ/uI07ecNDx+P8NCXDbWdXyiAoxryfnhUnnp6D4Hx69puX5/wONGsZDNi4GeNWKwVAuLWU8H65Mqv6xVxgUeBnot8S1NMTqT63xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746425189; c=relaxed/simple;
	bh=32TA8e5bPtMwAf49vZpMVNF+y3107NtjCwoixFW/fYs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mlrTOLrf3fjBzHQBw6YOHGHChrUOIQlfxjZHn7UWKDV6pq0uqH8XL9sbbrjSf/ziMVqqNMfzfwa+qvoCnSvDQEbaYYCaODdlEljF+iQmO+0IFhn6bj4nB4o4/fpeHfrf1n7yCuAQxliVqxgG3qTmkqyXNP9iMmhP3/XMt8eDqjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tcqcsD45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3471CC4CEE4;
	Mon,  5 May 2025 06:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746425189;
	bh=32TA8e5bPtMwAf49vZpMVNF+y3107NtjCwoixFW/fYs=;
	h=Subject:To:Cc:From:Date:From;
	b=tcqcsD459Z/pas+OsYNrlauv/TGdpsKdzEGJ5u3f8O3QBhb0lTTY4Q9jCqerdgBB+
	 cYcWTX4RaI5oQWU/hKiPHVhzNOX9I/sC38VGNit1nHWhCxWoUAjAbqPwi8Ag+whJeH
	 JUyxmq9KcemI5IKorZGNkufiqjr06U5/wjQWb1js=
Subject: FAILED: patch "[PATCH] cpufreq: intel_pstate: Unchecked MSR aceess in legacy mode" failed to apply to 5.4-stable tree
To: srinivas.pandruvada@linux.intel.com,rafael.j.wysocki@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 May 2025 08:06:20 +0200
Message-ID: <2025050520-deprecate-skinny-0232@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x ac4e04d9e378f5aa826c2406ad7871ae1b6a6fb9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050520-deprecate-skinny-0232@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


