Return-Path: <stable+bounces-205114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3567CF922B
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 16:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 429D8301D0DF
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 15:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F001344052;
	Tue,  6 Jan 2026 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6vpMjOZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF547344038
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713959; cv=none; b=fdYetcO5aZ1yosyhZaqUqPphv6CYhg0tc3Q3aWPBcCdJf0dskgOTI9+9eEVy5qP5cKfNr6R2Am/0Ptkg9hYNGa33GfeUfUKGXgV8MuPlgo8OC6+hDt6Si9cLi60fU9Mcp8QNoSrdEBN9Blcc3TtSjtZkb5cPBubRqt+AX07VGsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713959; c=relaxed/simple;
	bh=D4XuZS2ZZKPSGLViie1fG90SrMO9FTV7FKRiDM5R9zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ryq/TjI2IqJAE3/doeMFc1dOyQCDQWwWogg00GT+27SaomdiDFXdobMJ6lqI6iT5p9KvU76tiLii2BcSLHyOsuG4h6Yju75mRGu8Q0pLQ9xIbZPJVQVI2QyP7OOO3kwlqS7fPwuskr3Q6VUsUZ8/fAmOCFn+tX++Qesc+vOerP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6vpMjOZ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c0bccb8037eso770432a12.1
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 07:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767713957; x=1768318757; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+nev3k8GrDkYwcfroMD2vo+UrG57sb0fdXcs5RtCMf0=;
        b=S6vpMjOZRqWdca3LDKcQDvfDsyo1UOKeorJcDUGSQzlM5emg7xtexu2X15h7m0qSeD
         Ibr57JuQu1xDKDfH7LbgoDYFdnyF9gQ8EjaDJbLIH2kmKFbH9eJLqQcIRgEd6CHGMdnf
         A/ArzBzGE753QkfZBGAAcNlDGwkSn7epFRCza2uhfJWjjLA5mdXHy4NdA4gw8ddZpDyx
         hAQZ69HfR4qfZaUY1M90NyELCql/nhKUztseYnNk13lMfvdq4doLX5BUnE2yLP5C/T2k
         mLs1glPgGlW2r/SOMMYa0z1tuMKkd/vTRkkKyePtz7WoZtlzEhUUhlPurlV0O7VPC1Lf
         OHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767713957; x=1768318757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nev3k8GrDkYwcfroMD2vo+UrG57sb0fdXcs5RtCMf0=;
        b=ISW9Zt3h3U5fKoTEIaSB6DH6+zk1fIqVycNzpwDbTJuufOF7P7SSvAYn4b4xmaZZzS
         7EanxoBH3LerqNcrQhzImnD43riZlxmluMSbErU9ehaNLNI7x0QAky3idpf29fOqaKuA
         cxZsx4uUEiEwic7J5wtmbR8no0Fmu7no4qaNrdsm1ZWHT/x1GedlIFZ8AJUdg0btxWOJ
         bo7NjyQ9TmHhL62IskF6J8D4BcCzSe+PwqzURPFAWJPvTuHwdM7ek3MG3/M+0TwIx/I2
         Ck6yGaOEGbF6EYEYzz03wfsdZJIkOOB20OkLooYkzFl/6gzRVWrXgO/QM7ZN8e92Exjw
         2TYw==
X-Forwarded-Encrypted: i=1; AJvYcCUeQpuIsaYhOj1VInb8FdpOw6WQ4LVX9YbQnuSAFX6p5Pcl6Wat+GYrPOCZ0OSOCi7cUFlQh8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBHud0KTSmWvSqf7BC8IN4IhCVHcVjluIBktFkkL99z9MzfM/y
	jw/HT+bjTg+6JgUAKpI8EFbPKYFxPfoY2IVe2VANKzjN0PU00blEv9W7
X-Gm-Gg: AY/fxX7MRHKEfqQ9vLl50B1+AlhMbIp8jAmAi1drvCWVf6SpWWCK2Lb99rphRVTHSQy
	60Q3lKcCUVctFYnkmzrjBy7WEhbY5vXNIXGi5RIky6YGXpjqzaeeKeboZ85xNeVz+o/E7gi4Y2d
	TC9k9o/FCebVM4FOJ0GBqpO5xgARia76y+tvf90Hbu1OinDqa1WDj2wXZbOz4mEzc30z8zl495n
	vqO9MzvbNs8Th0aWgnHa0uFTl7FfIjhbDfKhdt0INAWeC8aoWPfVWoGUW/nkmMY243t+ZYuQIuq
	AMm6cYURvAMZaDvkW0BQLXeJWbbLdYeN8xTBgudsY/V3E7fjqtZEeiGlxJfTn9bNGSXTCSB+8eg
	v58LrkvJBmP7g8d2iHrz6TkYce+SnxUyLdX2ASe05cmGTjeMvS8kdNGtqJSIQYoxVm/jKkUsAO0
	x/aq+ySMlQxGqnI3+MnqEX
X-Google-Smtp-Source: AGHT+IF0mZFbkjRBIubqLKVOfr698jKaejtisA/43GyJJji0AoxWu2L/C2JuZyOyvdKgIUNJcZv0HA==
X-Received: by 2002:a05:6a21:6da1:b0:366:584c:62ef with SMTP id adf61e73a8af0-389823c3f46mr3343295637.65.1767713956663;
        Tue, 06 Jan 2026 07:39:16 -0800 (PST)
Received: from [192.168.0.118] ([14.187.47.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc95d5f10sm2712050a12.26.2026.01.06.07.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 07:39:16 -0800 (PST)
Message-ID: <e8db28a3-61ae-4988-9ac6-ba67926056ab@gmail.com>
Date: Tue, 6 Jan 2026 22:39:09 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] virtio-net: don't schedule delayed refill
 worker
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20260106150438.7425-1-minhquangbui99@gmail.com>
 <20260106150438.7425-2-minhquangbui99@gmail.com>
 <20260106100959-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20260106100959-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/26 22:29, Michael S. Tsirkin wrote:
> On Tue, Jan 06, 2026 at 10:04:36PM +0700, Bui Quang Minh wrote:
>> When we fail to refill the receive buffers, we schedule a delayed worker
>> to retry later. However, this worker creates some concurrency issues.
>> For example, when the worker runs concurrently with virtnet_xdp_set,
>> both need to temporarily disable queue's NAPI before enabling again.
>> Without proper synchronization, a deadlock can happen when
>> napi_disable() is called on an already disabled NAPI. That
>> napi_disable() call will be stuck and so will the subsequent
>> napi_enable() call.
>>
>> To simplify the logic and avoid further problems, we will instead retry
>> refilling in the next NAPI poll.
>>
>> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
>> Cc: stable@vger.kernel.org
>> Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> and CC stable I think. Can you do that pls?

I've added Cc stable already.

Thanks for you review.

>
>> ---
>>   drivers/net/virtio_net.c | 48 +++++++++++++++++++++-------------------
>>   1 file changed, 25 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 1bb3aeca66c6..f986abf0c236 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3046,16 +3046,16 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>>   	else
>>   		packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
>>   
>> +	u64_stats_set(&stats.packets, packets);
>>   	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
>> -		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
>> -			spin_lock(&vi->refill_lock);
>> -			if (vi->refill_enabled)
>> -				schedule_delayed_work(&vi->refill, 0);
>> -			spin_unlock(&vi->refill_lock);
>> -		}
>> +		if (!try_fill_recv(vi, rq, GFP_ATOMIC))
>> +			/* We need to retry refilling in the next NAPI poll so
>> +			 * we must return budget to make sure the NAPI is
>> +			 * repolled.
>> +			 */
>> +			packets = budget;
>>   	}
>>   
>> -	u64_stats_set(&stats.packets, packets);
>>   	u64_stats_update_begin(&rq->stats.syncp);
>>   	for (i = 0; i < ARRAY_SIZE(virtnet_rq_stats_desc); i++) {
>>   		size_t offset = virtnet_rq_stats_desc[i].offset;
>> @@ -3230,9 +3230,10 @@ static int virtnet_open(struct net_device *dev)
>>   
>>   	for (i = 0; i < vi->max_queue_pairs; i++) {
>>   		if (i < vi->curr_queue_pairs)
>> -			/* Make sure we have some buffers: if oom use wq. */
>> -			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
>> -				schedule_delayed_work(&vi->refill, 0);
>> +			/* Pre-fill rq agressively, to make sure we are ready to
>> +			 * get packets immediately.
>> +			 */
>> +			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
>>   
>>   		err = virtnet_enable_queue_pair(vi, i);
>>   		if (err < 0)
>> @@ -3472,16 +3473,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>>   				struct receive_queue *rq,
>>   				bool refill)
>>   {
>> -	bool running = netif_running(vi->dev);
>> -	bool schedule_refill = false;
>> +	if (netif_running(vi->dev)) {
>> +		/* Pre-fill rq agressively, to make sure we are ready to get
>> +		 * packets immediately.
>> +		 */
>> +		if (refill)
>> +			try_fill_recv(vi, rq, GFP_KERNEL);
>>   
>> -	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
>> -		schedule_refill = true;
>> -	if (running)
>>   		virtnet_napi_enable(rq);
>> -
>> -	if (schedule_refill)
>> -		schedule_delayed_work(&vi->refill, 0);
>> +	}
>>   }
>>   
>>   static void virtnet_rx_resume_all(struct virtnet_info *vi)
>> @@ -3829,11 +3829,13 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>   	}
>>   succ:
>>   	vi->curr_queue_pairs = queue_pairs;
>> -	/* virtnet_open() will refill when device is going to up. */
>> -	spin_lock_bh(&vi->refill_lock);
>> -	if (dev->flags & IFF_UP && vi->refill_enabled)
>> -		schedule_delayed_work(&vi->refill, 0);
>> -	spin_unlock_bh(&vi->refill_lock);
>> +	if (dev->flags & IFF_UP) {
>> +		local_bh_disable();
>> +		for (int i = 0; i < vi->curr_queue_pairs; ++i)
>> +			virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
>> +
>> +		local_bh_enable();
>> +	}
>>   
>>   	return 0;
>>   }
>> -- 
>> 2.43.0


