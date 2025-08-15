Return-Path: <stable+bounces-169809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E243B285C0
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 20:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22DF81CE19FA
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 18:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364921FECB1;
	Fri, 15 Aug 2025 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="jnCHDIZ2"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E943176E2
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755282042; cv=none; b=sMwYwuA9uwE9nagcjXibqZeVdl4HYQIH8nUUWCsk9CPvgRhsCF6WOnZiQNHAx3niWLz0G+OtCnaS1wdaddQ9IxqzqyGREFOpTsio8j80nbtGyLOYF3VF2KlgLZ+Y8eOZK6fpl8tNtjv8bZJxwKoyuye2ahuLkGGAqAtVg5rbY4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755282042; c=relaxed/simple;
	bh=HqohQCwt3xLc/CMe7PYR6lypylFDRPWWrMsq+bOTKsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DWzAJ/R6M3hRmCeyTTyuXnedw8YvADUmAkPspdJfeo1ahyUi/alHVADh/n12oG/Rh7S+tlXZ58Nyl6OYwKPnDz07jw628O4F7VX/2J5ciNumWEhgHWxBCXUHidKnixJumrDQVrrxhieGCDhjTUUS76DIKzjf7ATZAiqxtBZJHJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=jnCHDIZ2; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1755281983;
	bh=PpCN0f0lsi9ZWXm+hnZjEbsW+nUv4/MLzLlHh270FDc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=jnCHDIZ2A7aLwIbmYOUXiDmTJVJ8asTINj1uYNQeQgAg2hXsADNM0n5fEyOYFWr+N
	 YNCX5Nmaes24/EQHnMyyZ55Ij/YJyCHaQo03ToYdc2y8Ll7roCinGXZ13qi/J3JzVH
	 g4SzfnixDzWCc+LIz/jHQrAhRtlAtbZoNzTZHvG8=
X-QQ-mid: esmtpgz10t1755281980td168dc7f
X-QQ-Originating-IP: 4BaviN8c/DwhLORTADhp/L8tDA6dzc3Bka7nKKuICHM=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 16 Aug 2025 02:19:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3804792068296659635
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Wyes Karny <wkarny@gmail.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 6.6 8/8] sched/fair: Fix frequency selection for non-invariant case
Date: Sat, 16 Aug 2025 02:16:18 +0800
Message-Id: <20250815181618.3199442-9-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250815181618.3199442-1-guanwentao@uniontech.com>
References: <20250815181618.3199442-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: MR1JPzpp6mYtmGU7Q7FAz3UTPaHe5fCdWCYoeiivsZoLM9YqKgOnf0uU
	8t8Rm2Kvz3jjkxi0RX9KZ4AbZiV0vJcwTQs9iGrm+ZQFkbp5UqKQL1fSbFUSDoqyamIV4NO
	RdhfsvJwnqOBc/LTV/5s4x+EfevPKj10DnVC7c8eN8eHd2zEH/TvWmdN2LtauHnUPIRC9st
	wOXsfQtsVIw2g//hWogg+Ftc3NHWsDUkpP61pDHWphcP9wnPmmltmVjWhDrfCTI051YU+1I
	8Jw0OgT84GxTvufXdm+8qVcX2OpFHV2TBbgRr3pOPU9TpkqQQlTfHj3e1sYtyQhhCm5zTlb
	R3Rc8VSXUX7coXYK7Cxidf97+U7r3uTlMiDPJFDM5xh22Z01bPjjLujc5MlQsa6GQIZI3ta
	TMTd2yYoCZx2wDyN/ZSNW/aZwnDZxgCtfUnl0HRY9l8FdbUrGOwNm4Qx92zSV7lY4H3szEK
	zB8aK1hm1yqD7FIqrXPe/sLT5xr+o2kRF0quWTicQ/0HlikRC0k6oKhMToNjXVmvB59j0c1
	eLEnZIc+Vve6QjHoZX50W0S9AF1SXMSj6f2tEdwqViNYKjP0xw73Nty/wvxFMlUE0m9bcAq
	m4f1rAA6f1YFT2RcwS8qPYKAiy3DSfmeWTNNVW92xzKiI1Lfg/htCLJacganve138RyJeWj
	q7IpqwJ1gWY2WlmplhEgGgK0WXm8fKE8V8M5Nf+IVkWPAz/JGJnJAPJLEHa+PDnFQ75rilf
	d0hXIhmYcmAQ18ta8Ur9/BlRNfsE1xmNxeyu6qFTwz+zamky5XeSrGcRhoFoWdX0gs9TSGy
	BH2nbGAHsvMiev7CjMeMrVMTLgGq/t9Cy3BauJtQLVibZK6mqzFMXWdqLGkS2OwuGNXjD23
	TrX32rZpODg4GCMl84nBtbt/oskEbFfhw8/OT7BxZ7TD/HpDViiIDuQzSnv3Sd1UcYiBwHv
	f593JjhGErnLOvAGpWFa4WomDagWXmQ4j+11aUWKd3wS3v1xdYU7l7l68EDCEW4yUt5UNTh
	Cj6iJ+v+vYLh0pyntTEoftr4GMLv1DVQuDKdVNEDZbHHavCT98JxshHolCL6nlXZ0nvkNW8
	r61ktdPBc16O5pCarzRHrHQUeZlInlu7fPeqq2ZJJ+l
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

From: Vincent Guittot <vincent.guittot@linaro.org>

Linus reported a ~50% performance regression on single-threaded
workloads on his AMD Ryzen system, and bisected it to:

  9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor performance estimation")

When frequency invariance is not enabled, get_capacity_ref_freq(policy)
is supposed to return the current frequency and the performance margin
applied by map_util_perf(), enabling the utilization to go above the
maximum compute capacity and to select a higher frequency than the current one.

After the changes in 9c0b4bb7f630, the performance margin was applied
earlier in the path to take into account utilization clampings and
we couldn't get a utilization higher than the maximum compute capacity,
and the CPU remained 'stuck' at lower frequencies.

To fix this, we must use a frequency above the current frequency to
get a chance to select a higher OPP when the current one becomes fully used.
Apply the same margin and return a frequency 25% higher than the current
one in order to switch to the next OPP before we fully use the CPU
at the current one.

[ mingo: Clarified the changelog. ]

Fixes: 9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor performance estimation")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Bisected-by: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Wyes Karny <wkarny@gmail.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Wyes Karny <wkarny@gmail.com>
Link: https://lore.kernel.org/r/20240114183600.135316-1-vincent.guittot@linaro.org
(cherry picked from commit e37617c8e53a1f7fcba6d5e1041f4fd8a2425c27)
---
 kernel/sched/cpufreq_schedutil.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index cfe7c625d2ad..819ec1ccc08c 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -156,7 +156,11 @@ unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
 	if (arch_scale_freq_invariant())
 		return policy->cpuinfo.max_freq;
 
-	return policy->cur;
+	/*
+	 * Apply a 25% margin so that we select a higher frequency than
+	 * the current one before the CPU is fully busy:
+	 */
+	return policy->cur + (policy->cur >> 2);
 }
 
 /**
-- 
2.20.1


