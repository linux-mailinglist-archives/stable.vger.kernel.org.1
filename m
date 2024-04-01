Return-Path: <stable+bounces-33934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FE1893B80
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 15:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525D41C21342
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 13:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13823F9C5;
	Mon,  1 Apr 2024 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l0dIQ4UZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB123F9C1
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711978564; cv=none; b=tzTwzUMZB9AAG6S1mLjF710MyMZ1aZMCJlTWLeTYBb0h6D39Zb6DvI5TCFqE4JNYyL/29IzycE/ZrMRGczjj0uEE7lx4aakkSPj0MXC4eN5WLolJlXJFxbwG7OY/U9HWV6APYtJ9fDQF990RPJxvhV5cQbfQ1Q3Fx4RZbR0qQTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711978564; c=relaxed/simple;
	bh=ZsN43sGZs1icEJndfTVyk86uO3AGX0JOlCtdNJZFhJw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WaVWqOJgCIajICcPuJiyKvjSf21/FOtNL2drPtyAsvPth1309yokKTCSc7/kv72lJ+Euc1NG0+TMktvEeM8ZvgiPF1uBehWINH0lAd0GeBYw0I18RNYNfSPZOILkgWXjlBVRD4aIUdX+53rLRwn0G6t+0GolgSA4twNsGdkvbXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l0dIQ4UZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2868C433F1;
	Mon,  1 Apr 2024 13:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711978564;
	bh=ZsN43sGZs1icEJndfTVyk86uO3AGX0JOlCtdNJZFhJw=;
	h=Subject:To:Cc:From:Date:From;
	b=l0dIQ4UZFh7RX6RF06kUII+71LrkT4tfxHxzZy2X5A/qKqr2Yaikh6DArTry99jPG
	 n4TBTvX3M/+V/oR3kMN2Q8NA9rQSI0E/21NOowWwkFBeqfvCusPA9rdGHJCTVKB2Y7
	 dhArcrbO/gePjqO0nwtHcIOv3eKyd2N7OwyJaWFI=
Subject: FAILED: patch "[PATCH] perf/x86/amd/core: Update and fix stalled-cycles-* events for" failed to apply to 6.6-stable tree
To: sandipan.das@amd.com,irogers@google.com,mingo@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Apr 2024 15:36:00 +0200
Message-ID: <2024040100-clinking-stylized-0888@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c7b2edd8377be983442c1344cb940cd2ac21b601
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040100-clinking-stylized-0888@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

c7b2edd8377b ("perf/x86/amd/core: Update and fix stalled-cycles-* events for Zen 2 and later")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c7b2edd8377be983442c1344cb940cd2ac21b601 Mon Sep 17 00:00:00 2001
From: Sandipan Das <sandipan.das@amd.com>
Date: Mon, 25 Mar 2024 13:17:53 +0530
Subject: [PATCH] perf/x86/amd/core: Update and fix stalled-cycles-* events for
 Zen 2 and later

AMD processors based on Zen 2 and later microarchitectures do not
support PMCx087 (instruction pipe stalls) which is used as the backing
event for "stalled-cycles-frontend" and "stalled-cycles-backend".

Use PMCx0A9 (cycles where micro-op queue is empty) instead to count
frontend stalls and remove the entry for backend stalls since there
is no direct replacement.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Fixes: 3fe3331bb285 ("perf/x86/amd: Add event map for AMD Family 17h")
Link: https://lore.kernel.org/r/03d7fc8fa2a28f9be732116009025bdec1b3ec97.1711352180.git.sandipan.das@amd.com

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 5692e827afef..af8add6c11ea 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -250,7 +250,7 @@ static const u64 amd_perfmon_event_map[PERF_COUNT_HW_MAX] =
 /*
  * AMD Performance Monitor Family 17h and later:
  */
-static const u64 amd_f17h_perfmon_event_map[PERF_COUNT_HW_MAX] =
+static const u64 amd_zen1_perfmon_event_map[PERF_COUNT_HW_MAX] =
 {
 	[PERF_COUNT_HW_CPU_CYCLES]		= 0x0076,
 	[PERF_COUNT_HW_INSTRUCTIONS]		= 0x00c0,
@@ -262,10 +262,24 @@ static const u64 amd_f17h_perfmon_event_map[PERF_COUNT_HW_MAX] =
 	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= 0x0187,
 };
 
+static const u64 amd_zen2_perfmon_event_map[PERF_COUNT_HW_MAX] =
+{
+	[PERF_COUNT_HW_CPU_CYCLES]		= 0x0076,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= 0x00c0,
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= 0xff60,
+	[PERF_COUNT_HW_CACHE_MISSES]		= 0x0964,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= 0x00c2,
+	[PERF_COUNT_HW_BRANCH_MISSES]		= 0x00c3,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= 0x00a9,
+};
+
 static u64 amd_pmu_event_map(int hw_event)
 {
-	if (boot_cpu_data.x86 >= 0x17)
-		return amd_f17h_perfmon_event_map[hw_event];
+	if (cpu_feature_enabled(X86_FEATURE_ZEN2) || boot_cpu_data.x86 >= 0x19)
+		return amd_zen2_perfmon_event_map[hw_event];
+
+	if (cpu_feature_enabled(X86_FEATURE_ZEN1))
+		return amd_zen1_perfmon_event_map[hw_event];
 
 	return amd_perfmon_event_map[hw_event];
 }


