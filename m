Return-Path: <stable+bounces-152908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82853ADD16A
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5ADA188DA2C
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A96F1E8332;
	Tue, 17 Jun 2025 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PUyJqw3n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255702EF659;
	Tue, 17 Jun 2025 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174227; cv=none; b=Nm4YPJbNI+S49yVXfFbBsnNm3uWcHEPtNGoAwBziZc25ruzi76CpIAg0syWegvh7bMgPPKsg80qYVDPBjPV4dUguAI6MWVJYZjUwDAnsfNwhAyvzI6J22P6YtXm1mA9aHVqcF159rMcY1FaBqKCT5EEtemRNnBsVXcfbYU+zGvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174227; c=relaxed/simple;
	bh=RLklqTdERyTfXh07L1x56CuKJblHSogMiMwSnKVeHJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbB4Ocszm3HNfD+dh2GaKA5W4ncSHJrym8WQ9cCAoPyM1cDM5pizaAywjs1i4104ataiDR7KGEs2bh+RRTyYvWM3ICiU6dTzQV8Jly49M4A7YXF5jQdVfU0tHHIbqd8cGAqkjkcyiaDPBctp6pWeHmIgwtn9A5MHTQDfJjhMBx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PUyJqw3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C23C4CEE3;
	Tue, 17 Jun 2025 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750174226;
	bh=RLklqTdERyTfXh07L1x56CuKJblHSogMiMwSnKVeHJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PUyJqw3nWPo/be8Chcb9V/jryCuM/gfMPPastoTY0EjcMYp3nsBqKnspXTRvv/veI
	 EI1Jp+EIuEujK/OTORNywDzs8kFzoiTLUB26x48NwkciDM62Dq+kesZnJU6WK2O2Nt
	 psOxZSR4GRYgdzMjrsGOub/zp5ZaeINSsQku9v/0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qing Wang <wangqing7171@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 022/356] perf/core: Fix broken throttling when max_samples_per_tick=1
Date: Tue, 17 Jun 2025 17:22:17 +0200
Message-ID: <20250617152339.132105363@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qing Wang <wangqing7171@gmail.com>

[ Upstream commit f51972e6f8b9a737b2b3eb588069acb538fa72de ]

According to the throttling mechanism, the pmu interrupts number can not
exceed the max_samples_per_tick in one tick. But this mechanism is
ineffective when max_samples_per_tick=1, because the throttling check is
skipped during the first interrupt and only performed when the second
interrupt arrives.

Perhaps this bug may cause little influence in one tick, but if in a
larger time scale, the problem can not be underestimated.

When max_samples_per_tick = 1:
Allowed-interrupts-per-second max-samples-per-second  default-HZ  ARCH
200                           100                     100         X86
500                           250                     250         ARM64
...
Obviously, the pmu interrupt number far exceed the user's expect.

Fixes: e050e3f0a71b ("perf: Fix broken interrupt rate throttling")
Signed-off-by: Qing Wang <wangqing7171@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250405141635.243786-3-wangqing7171@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5dd6424e62fa8..6460f79280ed2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9553,14 +9553,14 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
 		hwc->interrupts = 1;
 	} else {
 		hwc->interrupts++;
-		if (unlikely(throttle &&
-			     hwc->interrupts > max_samples_per_tick)) {
-			__this_cpu_inc(perf_throttled_count);
-			tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
-			hwc->interrupts = MAX_INTERRUPTS;
-			perf_log_throttle(event, 0);
-			ret = 1;
-		}
+	}
+
+	if (unlikely(throttle && hwc->interrupts >= max_samples_per_tick)) {
+		__this_cpu_inc(perf_throttled_count);
+		tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
+		hwc->interrupts = MAX_INTERRUPTS;
+		perf_log_throttle(event, 0);
+		ret = 1;
 	}
 
 	if (event->attr.freq) {
-- 
2.39.5




