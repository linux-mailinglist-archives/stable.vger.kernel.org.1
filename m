Return-Path: <stable+bounces-3137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 375A67FD36F
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 11:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB88D283002
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 10:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEE01945B;
	Wed, 29 Nov 2023 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3EBED1AD;
	Wed, 29 Nov 2023 02:02:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3236D1FB;
	Wed, 29 Nov 2023 02:03:20 -0800 (PST)
Received: from [10.57.73.180] (unknown [10.57.73.180])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F8E53F5A1;
	Wed, 29 Nov 2023 02:02:31 -0800 (PST)
Message-ID: <bdf739ae-5e45-4192-b682-81f05982c220@arm.com>
Date: Wed, 29 Nov 2023 10:02:29 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "dm delay: for short delays, use kthread instead of timers
 and wq" has been added to the 6.6-stable tree
To: Mikulas Patocka <mpatocka@redhat.com>, Sasha Levin <sashal@kernel.org>
Cc: stable-commits@vger.kernel.org, stable@vger.kernel.org,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 dm-devel@lists.linux.dev
References: <20231129025441.892320-1-sashal@kernel.org>
 <cac7f5be-454c-5ae1-e025-9ad1d84999fc@redhat.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <cac7f5be-454c-5ae1-e025-9ad1d84999fc@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mikulas,
Agreed and thanks for fixing.
Has this been selected for stable because of:
6fc45b6ed921 ("dm-delay: fix a race between delay_presuspend and delay_bio")
If so, I would volunteer do the backports for that for you at least.

BR,
Christian

On 29/11/2023 08:28, Mikulas Patocka wrote:
> Hi
> 
> This patch doesn't fix any bug (and introduces several serious bugs), so 
> it shouldn't be backported at all.
> 
> Mikulas
> 
> 
> On Tue, 28 Nov 2023, Sasha Levin wrote:
> 
>> This is a note to let you know that I've just added the patch titled
>>
>>     dm delay: for short delays, use kthread instead of timers and wq
>>
>> to the 6.6-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      dm-delay-for-short-delays-use-kthread-instead-of-tim.patch
>> and it can be found in the queue-6.6 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
>>
>>
>> commit 976fd593415e170a8ed5db68683b280d5876982d
>> Author: Christian Loehle <christian.loehle@arm.com>
>> Date:   Fri Oct 20 12:46:05 2023 +0100
>>
>>     dm delay: for short delays, use kthread instead of timers and wq
>>     
>>     [ Upstream commit 70bbeb29fab09d6ea6cfe64109db60a97d84d739 ]
>>     
>>     DM delay's current design of using timers and wq to realize the delays
>>     is insufficient for delays below ~50ms.
>>     
>>     This commit enhances the design to use a kthread to flush the expired
>>     delays, trading some CPU time (in some cases) for better delay
>>     accuracy and delays closer to what the user requested for smaller
>>     delays. The new design is chosen as long as all the delays are below
>>     50ms.
>>     
>>     Since bios can't be completed in interrupt context using a kthread
>>     is probably the most reasonable way to approach this.
>>     
>>     Testing with
>>     echo "0 2097152 zero" | dmsetup create dm-zeros
>>     for i in $(seq 0 20);
>>     do
>>       echo "0 2097152 delay /dev/mapper/dm-zeros 0 $i" | dmsetup create dm-delay-${i}ms;
>>     done
>>     
>>     Some performance numbers for comparison, on beaglebone black (single
>>     core) CONFIG_HZ_1000=y:
>>     
>>     fio --name=1msread --rw=randread --bs=4k --runtime=60 --time_based \
>>         --filename=/dev/mapper/dm-delay-1ms
>>     Theoretical maximum: 1000 IOPS
>>     Previous: 250 IOPS
>>     Kthread: 500 IOPS
>>     
>>     fio --name=10msread --rw=randread --bs=4k --runtime=60 --time_based \
>>         --filename=/dev/mapper/dm-delay-10ms
>>     Theoretical maximum: 100 IOPS
>>     Previous: 45 IOPS
>>     Kthread: 50 IOPS
>>     
>>     fio --name=1mswrite --rw=randwrite --direct=1 --bs=4k --runtime=60 \
>>         --time_based --filename=/dev/mapper/dm-delay-1ms
>>     Theoretical maximum: 1000 IOPS
>>     Previous: 498 IOPS
>>     Kthread: 1000 IOPS
>>     
>>     fio --name=10mswrite --rw=randwrite --direct=1 --bs=4k --runtime=60 \
>>         --time_based --filename=/dev/mapper/dm-delay-10ms
>>     Theoretical maximum: 100 IOPS
>>     Previous: 90 IOPS
>>     Kthread: 100 IOPS
>>     
>>     (This one is just to prove the new design isn't impacting throughput,
>>     not really about delays):
>>     fio --name=10mswriteasync --rw=randwrite --direct=1 --bs=4k \
>>         --runtime=60 --time_based --filename=/dev/mapper/dm-delay-10ms \
>>         --numjobs=32 --iodepth=64 --ioengine=libaio --group_reporting
>>     Previous: 13.3k IOPS
>>     Kthread: 13.3k IOPS
>>     
>>     Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>>     [Harshit: kthread_create error handling fix in delay_ctr]
>>     Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>>     Signed-off-by: Mike Snitzer <snitzer@kernel.org>
>>     Stable-dep-of: 6fc45b6ed921 ("dm-delay: fix a race between delay_presuspend and delay_bio")
>>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>>
>> diff --git a/drivers/md/dm-delay.c b/drivers/md/dm-delay.c
>> index 7433525e59856..efd510984e259 100644
>> --- a/drivers/md/dm-delay.c
>> +++ b/drivers/md/dm-delay.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/blkdev.h>
>>  #include <linux/bio.h>
>>  #include <linux/slab.h>
>> +#include <linux/kthread.h>
>>  
>>  #include <linux/device-mapper.h>
>>  
>> @@ -31,6 +32,7 @@ struct delay_c {
>>  	struct workqueue_struct *kdelayd_wq;
>>  	struct work_struct flush_expired_bios;
>>  	struct list_head delayed_bios;
>> +	struct task_struct *worker;
>>  	atomic_t may_delay;
>>  
>>  	struct delay_class read;
>> @@ -66,6 +68,44 @@ static void queue_timeout(struct delay_c *dc, unsigned long expires)
>>  	mutex_unlock(&dc->timer_lock);
>>  }
>>  
>> +static inline bool delay_is_fast(struct delay_c *dc)
>> +{
>> +	return !!dc->worker;
>> +}
>> +
>> +static void flush_delayed_bios_fast(struct delay_c *dc, bool flush_all)
>> +{
>> +	struct dm_delay_info *delayed, *next;
>> +
>> +	mutex_lock(&delayed_bios_lock);
>> +	list_for_each_entry_safe(delayed, next, &dc->delayed_bios, list) {
>> +		if (flush_all || time_after_eq(jiffies, delayed->expires)) {
>> +			struct bio *bio = dm_bio_from_per_bio_data(delayed,
>> +						sizeof(struct dm_delay_info));
>> +			list_del(&delayed->list);
>> +			dm_submit_bio_remap(bio, NULL);
>> +			delayed->class->ops--;
>> +		}
>> +	}
>> +	mutex_unlock(&delayed_bios_lock);
>> +}
>> +
>> +static int flush_worker_fn(void *data)
>> +{
>> +	struct delay_c *dc = data;
>> +
>> +	while (1) {
>> +		flush_delayed_bios_fast(dc, false);
>> +		if (unlikely(list_empty(&dc->delayed_bios))) {
>> +			set_current_state(TASK_INTERRUPTIBLE);
>> +			schedule();
>> +		} else
>> +			cond_resched();
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static void flush_bios(struct bio *bio)
>>  {
>>  	struct bio *n;
>> @@ -78,7 +118,7 @@ static void flush_bios(struct bio *bio)
>>  	}
>>  }
>>  
>> -static struct bio *flush_delayed_bios(struct delay_c *dc, int flush_all)
>> +static struct bio *flush_delayed_bios(struct delay_c *dc, bool flush_all)
>>  {
>>  	struct dm_delay_info *delayed, *next;
>>  	unsigned long next_expires = 0;
>> @@ -115,7 +155,10 @@ static void flush_expired_bios(struct work_struct *work)
>>  	struct delay_c *dc;
>>  
>>  	dc = container_of(work, struct delay_c, flush_expired_bios);
>> -	flush_bios(flush_delayed_bios(dc, 0));
>> +	if (delay_is_fast(dc))
>> +		flush_delayed_bios_fast(dc, false);
>> +	else
>> +		flush_bios(flush_delayed_bios(dc, false));
>>  }
>>  
>>  static void delay_dtr(struct dm_target *ti)
>> @@ -131,8 +174,11 @@ static void delay_dtr(struct dm_target *ti)
>>  		dm_put_device(ti, dc->write.dev);
>>  	if (dc->flush.dev)
>>  		dm_put_device(ti, dc->flush.dev);
>> +	if (dc->worker)
>> +		kthread_stop(dc->worker);
>>  
>> -	mutex_destroy(&dc->timer_lock);
>> +	if (!delay_is_fast(dc))
>> +		mutex_destroy(&dc->timer_lock);
>>  
>>  	kfree(dc);
>>  }
>> @@ -175,6 +221,7 @@ static int delay_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>>  {
>>  	struct delay_c *dc;
>>  	int ret;
>> +	unsigned int max_delay;
>>  
>>  	if (argc != 3 && argc != 6 && argc != 9) {
>>  		ti->error = "Requires exactly 3, 6 or 9 arguments";
>> @@ -188,16 +235,14 @@ static int delay_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>>  	}
>>  
>>  	ti->private = dc;
>> -	timer_setup(&dc->delay_timer, handle_delayed_timer, 0);
>> -	INIT_WORK(&dc->flush_expired_bios, flush_expired_bios);
>>  	INIT_LIST_HEAD(&dc->delayed_bios);
>> -	mutex_init(&dc->timer_lock);
>>  	atomic_set(&dc->may_delay, 1);
>>  	dc->argc = argc;
>>  
>>  	ret = delay_class_ctr(ti, &dc->read, argv);
>>  	if (ret)
>>  		goto bad;
>> +	max_delay = dc->read.delay;
>>  
>>  	if (argc == 3) {
>>  		ret = delay_class_ctr(ti, &dc->write, argv);
>> @@ -206,6 +251,8 @@ static int delay_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>>  		ret = delay_class_ctr(ti, &dc->flush, argv);
>>  		if (ret)
>>  			goto bad;
>> +		max_delay = max(max_delay, dc->write.delay);
>> +		max_delay = max(max_delay, dc->flush.delay);
>>  		goto out;
>>  	}
>>  
>> @@ -216,19 +263,37 @@ static int delay_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>>  		ret = delay_class_ctr(ti, &dc->flush, argv + 3);
>>  		if (ret)
>>  			goto bad;
>> +		max_delay = max(max_delay, dc->flush.delay);
>>  		goto out;
>>  	}
>>  
>>  	ret = delay_class_ctr(ti, &dc->flush, argv + 6);
>>  	if (ret)
>>  		goto bad;
>> +	max_delay = max(max_delay, dc->flush.delay);
>>  
>>  out:
>> -	dc->kdelayd_wq = alloc_workqueue("kdelayd", WQ_MEM_RECLAIM, 0);
>> -	if (!dc->kdelayd_wq) {
>> -		ret = -EINVAL;
>> -		DMERR("Couldn't start kdelayd");
>> -		goto bad;
>> +	if (max_delay < 50) {
>> +		/*
>> +		 * In case of small requested delays, use kthread instead of
>> +		 * timers and workqueue to achieve better latency.
>> +		 */
>> +		dc->worker = kthread_create(&flush_worker_fn, dc,
>> +					    "dm-delay-flush-worker");
>> +		if (IS_ERR(dc->worker)) {
>> +			ret = PTR_ERR(dc->worker);
>> +			goto bad;
>> +		}
>> +	} else {
>> +		timer_setup(&dc->delay_timer, handle_delayed_timer, 0);
>> +		INIT_WORK(&dc->flush_expired_bios, flush_expired_bios);
>> +		mutex_init(&dc->timer_lock);
>> +		dc->kdelayd_wq = alloc_workqueue("kdelayd", WQ_MEM_RECLAIM, 0);
>> +		if (!dc->kdelayd_wq) {
>> +			ret = -EINVAL;
>> +			DMERR("Couldn't start kdelayd");
>> +			goto bad;
>> +		}
>>  	}
>>  
>>  	ti->num_flush_bios = 1;
>> @@ -260,7 +325,10 @@ static int delay_bio(struct delay_c *dc, struct delay_class *c, struct bio *bio)
>>  	list_add_tail(&delayed->list, &dc->delayed_bios);
>>  	mutex_unlock(&delayed_bios_lock);
>>  
>> -	queue_timeout(dc, expires);
>> +	if (delay_is_fast(dc))
>> +		wake_up_process(dc->worker);
>> +	else
>> +		queue_timeout(dc, expires);
>>  
>>  	return DM_MAPIO_SUBMITTED;
>>  }
>> @@ -270,8 +338,13 @@ static void delay_presuspend(struct dm_target *ti)
>>  	struct delay_c *dc = ti->private;
>>  
>>  	atomic_set(&dc->may_delay, 0);
>> -	del_timer_sync(&dc->delay_timer);
>> -	flush_bios(flush_delayed_bios(dc, 1));
>> +
>> +	if (delay_is_fast(dc))
>> +		flush_delayed_bios_fast(dc, true);
>> +	else {
>> +		del_timer_sync(&dc->delay_timer);
>> +		flush_bios(flush_delayed_bios(dc, true));
>> +	}
>>  }
>>  
>>  static void delay_resume(struct dm_target *ti)
>> @@ -356,7 +429,7 @@ static int delay_iterate_devices(struct dm_target *ti,
>>  
>>  static struct target_type delay_target = {
>>  	.name	     = "delay",
>> -	.version     = {1, 3, 0},
>> +	.version     = {1, 4, 0},
>>  	.features    = DM_TARGET_PASSES_INTEGRITY,
>>  	.module      = THIS_MODULE,
>>  	.ctr	     = delay_ctr,
>>
> 


