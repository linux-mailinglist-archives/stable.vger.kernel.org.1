Return-Path: <stable+bounces-71683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 216FC967028
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 09:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5481F23439
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 07:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37961175D3F;
	Sat, 31 Aug 2024 07:38:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC2916A94F;
	Sat, 31 Aug 2024 07:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725089884; cv=none; b=b1+uG78uiQMuhxnwpJGJibQ3+K7TmLDOAy1kXoAmzgRrHWnfe5GWIc/g8RgOx80nnrDBYtZq5tWuNchNzvKrk1tMRYisTIfuWddsF1nTzLw0spABlhrLm/BtTbcGUmizbri0H5ZOz4faEz4kgo91c9swLa3nJOsmxjBkD4ItaOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725089884; c=relaxed/simple;
	bh=j0XOpFyagEYUW9FYGaJGqvJddW77ivLx+Jdq21ViqPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m91fkWTJgDfz9BBz0fRHVo5hyoOloSCSipqIF6+ZjEzfmTzd4Nifp1Q0qQ8tqE8fu6cHa8pFc6DGNa6bFmf0edbkqxZYE8tfVmZSDfxAD3YqwpNsY8E0/rrOi5Mcna3ZUcPo6nC0VYPdcTOL1C3sZXUJZkQSKqicIrgBLp9CUJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wwn181Q8Dz4f3jZQ;
	Sat, 31 Aug 2024 15:37:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 499E11A0568;
	Sat, 31 Aug 2024 15:37:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP4 (Coremail) with SMTP id gCh0CgCXv4VQyNJmLLDdDA--.28814S6;
	Sat, 31 Aug 2024 15:37:58 +0800 (CST)
From: Luo Gengkun <luogengkun@huaweicloud.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	luogengkun@huaweicloud.com
Subject: [PATCH v5 2/2] perf/core: Fix incorrect time diff in tick adjust period
Date: Sat, 31 Aug 2024 07:43:16 +0000
Message-Id: <20240831074316.2106159-3-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240831074316.2106159-1-luogengkun@huaweicloud.com>
References: <20240831074316.2106159-1-luogengkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXv4VQyNJmLLDdDA--.28814S6
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4rXryDtF4kAr13XrW3GFg_yoW5WFy7pF
	Z8AF1aqFWkXw1F9w15C3Z2g345W3WkArsxWa45KrWfZw17trZ3XFsrWF15JF15AFZ7Za4a
	vwnFgryUC3yjqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUQXo7UUUUU=
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

Perf events has the notion of sampling frequency which is implemented in
software by dynamically adjusting the counter period so that samples occur
at approximately the target frequency.  Period adjustment is done in 2
places:
 - when the counter overflows (and a sample is recorded)
 - each timer tick, when the event is active
The later case is slightly flawed because it assumes that the time since
the last timer-tick period adjustment is 1 tick, whereas the event may not
have been active (e.g. for a task that is sleeping).

Fix by using jiffies to determine the elapsed time in that case.

Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1a8942277dda..d29b7cf971a1 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -265,6 +265,7 @@ struct hw_perf_event {
 	 * State for freq target events, see __perf_event_overflow() and
 	 * perf_adjust_freq_unthr_context().
 	 */
+	u64				freq_tick_stamp;
 	u64				freq_time_stamp;
 	u64				freq_count_stamp;
 #endif
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a9395bbfd4aa..183291e0d070 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -55,6 +55,7 @@
 #include <linux/pgtable.h>
 #include <linux/buildid.h>
 #include <linux/task_work.h>
+#include <linux/jiffies.h>
 
 #include "internal.h"
 
@@ -4120,9 +4121,11 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
 {
 	struct perf_event *event;
 	struct hw_perf_event *hwc;
-	u64 now, period = TICK_NSEC;
+	u64 now, period, tick_stamp;
 	s64 delta;
 
+	tick_stamp = jiffies64_to_nsecs(get_jiffies_64());
+
 	list_for_each_entry(event, event_list, active_list) {
 		if (event->state != PERF_EVENT_STATE_ACTIVE)
 			continue;
@@ -4148,6 +4151,9 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
 		 */
 		event->pmu->stop(event, PERF_EF_UPDATE);
 
+		period = tick_stamp - hwc->freq_tick_stamp;
+		hwc->freq_tick_stamp = tick_stamp;
+
 		now = local64_read(&event->count);
 		delta = now - hwc->freq_count_stamp;
 		hwc->freq_count_stamp = now;
@@ -4157,9 +4163,9 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
 		 * reload only if value has changed
 		 * we have stopped the event so tell that
 		 * to perf_adjust_period() to avoid stopping it
-		 * twice.
+		 * twice. And skip if it is the first tick adjust period.
 		 */
-		if (delta > 0)
+		if (delta > 0 && likely(period != tick_stamp))
 			perf_adjust_period(event, period, delta, false);
 
 		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
-- 
2.34.1


