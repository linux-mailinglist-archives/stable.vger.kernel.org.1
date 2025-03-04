Return-Path: <stable+bounces-120278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC12A4E727
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8FB919C535F
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 16:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B8229CB2F;
	Tue,  4 Mar 2025 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LOhTXcm7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5CF29CB23
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105827; cv=none; b=hfSv4KYNfQEwoo7MiUSOzCGVzbwsqTThiFaJr7oFpqWs49Vje15sUMQFdmroxRNc+Tm6MjovgxXtUzjl36TXJVjyYefF3emE1T84uplvlHWkYJT0c+Qfrh60bsHVu1crJ5mx+BPoAa66TcpK7LUnL3ObpQx7NnoNDt2K4e01gec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105827; c=relaxed/simple;
	bh=fvdpdJrbq0ZBVf+2wFy7Qmu84VVseLS5bmH8pqFyhWA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Xm1zlXOa7H9Fz1u2DGj2NayrXfoUHnVAwvyKBN8Q2HpAYmb22j9SlK0PbKNOkoBv/k+lS9QofATIl3zlpRi+qfnT0C7ypYeU0GviXST7lK5mZM19G8hsYwNBiionlcnU2+eqUgFs2za+vQISjfgAAYI+FjIvJc7Jfw628L3/DuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LOhTXcm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C65C4CEE5;
	Tue,  4 Mar 2025 16:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741105827;
	bh=fvdpdJrbq0ZBVf+2wFy7Qmu84VVseLS5bmH8pqFyhWA=;
	h=Subject:To:Cc:From:Date:From;
	b=LOhTXcm7Wkrz7rrBjfFDIAioepI+IMUO5SlKUcWg6PlQO9xY5IBWuDEpCB693/lRy
	 L9kL27RewXkw3L1Teany1qvc6WgoCUP6Ier/4JkqhM+vtBqyvYSDEo0LxcWxDlxpWf
	 jIBJHsyzLghU9eAW01o8UC24CA1QmqgYojdTZtFY=
Subject: FAILED: patch "[PATCH] perf/x86: Fix low freqency setting issue" failed to apply to 5.15-stable tree
To: kan.liang@linux.intel.com,mingo@kernel.org,peterz@infradead.org,ravi.bangoria@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:30:24 +0100
Message-ID: <2025030424-striking-boxing-7eb2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 88ec7eedbbd21cad38707620ad6c48a4e9a87c18
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030424-striking-boxing-7eb2@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 88ec7eedbbd21cad38707620ad6c48a4e9a87c18 Mon Sep 17 00:00:00 2001
From: Kan Liang <kan.liang@linux.intel.com>
Date: Fri, 17 Jan 2025 07:19:11 -0800
Subject: [PATCH] perf/x86: Fix low freqency setting issue

Perf doesn't work at low frequencies:

  $ perf record -e cpu_core/instructions/ppp -F 120
  Error:
  The sys_perf_event_open() syscall returned with 22 (Invalid argument)
  for event (cpu_core/instructions/ppp).
  "dmesg | grep -i perf" may provide additional information.

The limit_period() check avoids a low sampling period on a counter. It
doesn't intend to limit the frequency.

The check in the x86_pmu_hw_config() should be limited to non-freq mode.
The attr.sample_period and attr.sample_freq are union. The
attr.sample_period should not be used to indicate the frequency mode.

Fixes: c46e665f0377 ("perf/x86: Add INST_RETIRED.ALL workarounds")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250117151913.3043942-1-kan.liang@linux.intel.com
Closes: https://lore.kernel.org/lkml/20250115154949.3147-1-ravi.bangoria@amd.com/

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8f218ac0d445..2092d615333d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -628,7 +628,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 	if (event->attr.type == event->pmu->type)
 		event->hw.config |= x86_pmu_get_event_config(event);
 
-	if (event->attr.sample_period && x86_pmu.limit_period) {
+	if (!event->attr.freq && x86_pmu.limit_period) {
 		s64 left = event->attr.sample_period;
 		x86_pmu.limit_period(event, &left);
 		if (left > event->attr.sample_period)


