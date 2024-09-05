Return-Path: <stable+bounces-73130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B530E96CF7B
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 08:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AF1EB22F1E
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 06:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E9318BC02;
	Thu,  5 Sep 2024 06:38:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7D318950D;
	Thu,  5 Sep 2024 06:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518300; cv=none; b=H4CV3WvY0XZVrNczhn2YQePfO5NV+UVzs3c77bUCcBgYnS0P3Vn7sfnTPAzF4SMZrxx8JZomDf3SxxIwgqDY7BoWHKyfLfiAlmXNHDzm17tcoKAfZTEhMqpg9SCfarc9TbcAXV3VcYdU+RHj6QLb+V0M5Ye2h/dFuWCh26pjpHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518300; c=relaxed/simple;
	bh=7zB2IUb6fIamtfkCm1HDrghKHlQBMF4TBsQrkt4ArLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PEi6yGDDBk1JpTvEkbyY8rhd//VzjhipNR0ADY/OxfsWeM5PkaVtWED39VlDCFztuQHlCIzpBjiOGxzE0glsxQ1oi2cRdOgP3eFzIhAtQ2AzMbOd60OrnYuxgUoRZFTDET59nt7mQqAMCu9RN93YSN3vXLlVOdSsnEepl5NP7sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WzqRn0kDYz4f3jYJ;
	Thu,  5 Sep 2024 14:37:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2706B1A018D;
	Thu,  5 Sep 2024 14:38:12 +0800 (CST)
Received: from [10.67.108.244] (unknown [10.67.108.244])
	by APP4 (Coremail) with SMTP id gCh0CgD3KsfSUdlmfivGAQ--.6895S3;
	Thu, 05 Sep 2024 14:38:11 +0800 (CST)
Message-ID: <38ceaabe-0a2c-43f2-8f04-b93215f1f94c@huaweicloud.com>
Date: Thu, 5 Sep 2024 14:38:10 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] perf/core: Fix incorrect time diff in tick adjust
 period
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240831074316.2106159-1-luogengkun@huaweicloud.com>
 <20240831074316.2106159-3-luogengkun@huaweicloud.com>
 <20240902095054.GD4723@noisy.programming.kicks-ass.net>
From: Luo Gengkun <luogengkun@huaweicloud.com>
In-Reply-To: <20240902095054.GD4723@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3KsfSUdlmfivGAQ--.6895S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr1Dur4DCw1kCF4DCr4UJwb_yoWxAw4Upr
	4kAFnxtrW8Jr1kXw15J3WDJ34UGw1kJw4DWF1UGF18Aw1UXrZFqF1UXryjgr15Jrs7JFy7
	Jw1jqr1UZ3yUtFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/


On 2024/9/2 17:50, Peter Zijlstra wrote:
> On Sat, Aug 31, 2024 at 07:43:16AM +0000, Luo Gengkun wrote:
>> Perf events has the notion of sampling frequency which is implemented in
>> software by dynamically adjusting the counter period so that samples occur
>> at approximately the target frequency.  Period adjustment is done in 2
>> places:
>>   - when the counter overflows (and a sample is recorded)
>>   - each timer tick, when the event is active
>> The later case is slightly flawed because it assumes that the time since
>> the last timer-tick period adjustment is 1 tick, whereas the event may not
>> have been active (e.g. for a task that is sleeping).
>>
>> Fix by using jiffies to determine the elapsed time in that case.
>>
>> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
>> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>   include/linux/perf_event.h |  1 +
>>   kernel/events/core.c       | 12 +++++++++---
>>   2 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 1a8942277dda..d29b7cf971a1 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -265,6 +265,7 @@ struct hw_perf_event {
>>   	 * State for freq target events, see __perf_event_overflow() and
>>   	 * perf_adjust_freq_unthr_context().
>>   	 */
>> +	u64				freq_tick_stamp;
>>   	u64				freq_time_stamp;
>>   	u64				freq_count_stamp;
>>   #endif
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index a9395bbfd4aa..183291e0d070 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -55,6 +55,7 @@
>>   #include <linux/pgtable.h>
>>   #include <linux/buildid.h>
>>   #include <linux/task_work.h>
>> +#include <linux/jiffies.h>
>>   
>>   #include "internal.h"
>>   
>> @@ -4120,9 +4121,11 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>>   {
>>   	struct perf_event *event;
>>   	struct hw_perf_event *hwc;
>> -	u64 now, period = TICK_NSEC;
>> +	u64 now, period, tick_stamp;
>>   	s64 delta;
>>   
>> +	tick_stamp = jiffies64_to_nsecs(get_jiffies_64());
>> +
>>   	list_for_each_entry(event, event_list, active_list) {
>>   		if (event->state != PERF_EVENT_STATE_ACTIVE)
>>   			continue;
>> @@ -4148,6 +4151,9 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>>   		 */
>>   		event->pmu->stop(event, PERF_EF_UPDATE);
>>   
>> +		period = tick_stamp - hwc->freq_tick_stamp;
>> +		hwc->freq_tick_stamp = tick_stamp;
>> +
>>   		now = local64_read(&event->count);
>>   		delta = now - hwc->freq_count_stamp;
>>   		hwc->freq_count_stamp = now;
>> @@ -4157,9 +4163,9 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>>   		 * reload only if value has changed
>>   		 * we have stopped the event so tell that
>>   		 * to perf_adjust_period() to avoid stopping it
>> -		 * twice.
>> +		 * twice. And skip if it is the first tick adjust period.
>>   		 */
>> -		if (delta > 0)
>> +		if (delta > 0 && likely(period != tick_stamp))
>>   			perf_adjust_period(event, period, delta, false);
>>   
>>   		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
> This one I'm less happy with.. that condition 'period != tick_stamp'
> doesn't make sense to me. That's only false if hwc->freq_tick_stamp ==
> 0, which it will only be once after event creation. Even through the
> Changelog babbles about event scheduling.
>
> Also, that all should then be written something like:
>
> 	if (delta > 0 && ...) {
> 		perf_adjust_period(...);
> 		adjusted = true;
> 	}
>
> 	event->pmu->start(event, adjusted ? PERF_EF_RELOAD : 0);

Thank for your review! That is a good point.

If freq_tick_stamp is initialized when an event is created

or enabled, the additional condition can be removed as follows:

+static bool is_freq_event(struct perf_event *event)
+{
+       return event->attr.freq && event->attr.sample_freq;
+}
+
  static void
  perf_event_set_state(struct perf_event *event, enum perf_event_state 
state)
  {
@@ -665,6 +670,12 @@ perf_event_set_state(struct perf_event *event, enum 
perf_event_state state)
          */
         if ((event->state < 0) ^ (state < 0))
                 perf_event_update_sibling_time(event);
+       /*
+        * Update freq_tick_stamp for freq event just enabled
+        */
+       if (is_freq_event(event) && state == PERF_EVENT_STATE_INACTIVE &&
+                                   event->state < 
PERF_EVENT_STATE_INACTIVE)
+               event->hw.freq_tick_stamp = 
jiffies64_to_nsecs(get_jiffies_64());

         WRITE_ONCE(event->state, state);
  }
@@ -4165,7 +4176,7 @@ static void perf_adjust_freq_unthr_events(struct 
list_head *event_list)
                  * to perf_adjust_period() to avoid stopping it
                  * twice. And skip if it is the first tick adjust period.
                  */
-               if (delta > 0 && likely(period != tick_stamp))
+               if (delta > 0)
                         perf_adjust_period(event, period, delta, false);

                 event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
@@ -12061,8 +12072,11 @@ perf_event_alloc(struct perf_event_attr *attr, 
int cpu,

         hwc = &event->hw;
         hwc->sample_period = attr->sample_period;
-       if (attr->freq && attr->sample_freq)
+       if (is_freq_event(event)) {
                 hwc->sample_period = 1;
+               if (event->state == PERF_EVENT_STATE_INACTIVE)
+                       event->hw.freq_tick_stamp = 
jiffies64_to_nsecs(get_jiffies_64());
+       }


And  I'm wondering if we also need to update freq_count_stamp when

the freq event is enabled for the reason to keep they on the same "period".

+       if (is_freq_event(event) && state == PERF_EVENT_STATE_INACTIVE &&
+                                   event->state < 
PERF_EVENT_STATE_INACTIVE) {
+               event->hw.freq_tick_stamp = 
jiffies64_to_nsecs(get_jiffies_64());
+               event->hw.freq_count_stamp = local64_read(&event->count);
+       }

Looking for your reply!

Thanks.


