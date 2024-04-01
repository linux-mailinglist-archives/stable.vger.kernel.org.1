Return-Path: <stable+bounces-33933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B885C893B7E
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 15:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 745B42821F4
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 13:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C993F9C1;
	Mon,  1 Apr 2024 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cB32UuKK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16104F9DF
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711978519; cv=none; b=aDpcswBGrIJjR0O+LRaiCc7rnNkTI8HqRBPWFZxzrFpSFfeeyxu2M/XMQH+QHSEv5pFByw0gB9+7p4PoKIvfrVrlO7hRTiDox+2XUCPGuegqNni09eL6tVE6YUbjchvXtyNJHkiDIYCTSkN/mXQ79MYiAwsMxSGFYM9tw3aw/AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711978519; c=relaxed/simple;
	bh=Z9uf9PQz8oxQOKREfYCSVr7/VUNw93XOjkCJLyK5hbE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WVGgKXKxeEsKMnmNjCck9E22uVFBFTfj7vVKiBK77SiS4agAGHnt3sFHuUvR9AFlbK25rSRUTShr8TZupsj0r9R+SZpU6zXEfVgLnJR0nIZwSJOD5K8YyH4iS4v9iCennL+mThxTA2kU02Nxo/un6/9Znt2rw6FBhnDb+wVnLsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cB32UuKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBABC433F1;
	Mon,  1 Apr 2024 13:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711978518;
	bh=Z9uf9PQz8oxQOKREfYCSVr7/VUNw93XOjkCJLyK5hbE=;
	h=Subject:To:Cc:From:Date:From;
	b=cB32UuKKn8fyTmyjOPNrHrlK4wNjbjdPvm8SMamHFPtkX6kX662/cPkBBQCaV2cIu
	 kSIqsdWIrtIBfgIezg0li8jBCWSn6gWmIE4NaM5Spi7NX9tR8pQOtDrb+NMhkN+vpX
	 LUhHwYYwy86qJuXTjbxg/bxtWsgiUSMgsLi+ZLqc=
Subject: FAILED: patch "[PATCH] perf/x86/amd/core: Update and fix stalled-cycles-* events for" failed to apply to 6.1-stable tree
To: sandipan.das@amd.com,irogers@google.com,mingo@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Apr 2024 15:35:15 +0200
Message-ID: <2024040114-diaper-unlovable-0dab@gregkh>
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
git cherry-pick -x c7b2edd8377be983442c1344cb940cd2ac21b601
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040114-diaper-unlovable-0dab@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


