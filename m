Return-Path: <stable+bounces-207944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A494D0D30B
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 09:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE5F3300B347
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 08:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598102C3259;
	Sat, 10 Jan 2026 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLU6NtvQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047AD1624D5
	for <stable@vger.kernel.org>; Sat, 10 Jan 2026 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768033426; cv=none; b=Ee7ckeBRn4sNr5CS/sZqPsTokXzDQC2MktrL2kp/M5pomhweMAv2gwwUt7Uhc8+yH9fszCky+uAc09MsJGBQw6x945CCVxK92M99uH9sRhkgVc8GphGMvgUVycl816jD3CIP1kpQ/l0fTbh1XUs+26UBJRSJ+SA7F92quSObL34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768033426; c=relaxed/simple;
	bh=r2eEmiwIMswi/KIcQchbLwESKW9bSNI5Wwpf6dmjcII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GmpWxyrcsl2pGmoLP1Az2leggmR7frJnrUN15ts7zPtb5GNmSthJsvmkGVKY2YlzqDpg1IzyIMpHi8IhY9US00m9JTDotDa+GOIOYTQl/n3bU9cgYEn9VeR8Iaxif1RI2nOO6uAMDt9l7qQkBD1G/H+2/uuQuvx9tCe0qXT+oHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLU6NtvQ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-81f3c14027cso197999b3a.1
        for <stable@vger.kernel.org>; Sat, 10 Jan 2026 00:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768033423; x=1768638223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85VZqRS0HMw6ZG3sDTQxV/1q2B5Gy6mG+8xTLfX4fdI=;
        b=FLU6NtvQSEyFeGG3CbYbqL7ZaTyX1mp4m2V/FTg4f1xpFhbdo21oEe3C/8+hTVxfgV
         xfn0v+U0+Up08EN3ThEKl/M0iQihwcwVoJ8ycUcVJHTi5cT+jxcv8xS+yy0EivL2P05Q
         sSA9IptdIx8X1i1ZJOLu+lgvNo6qDvHAFPi6+ZtWMjzXhsYu16SW5YsC2plpqqfZCORn
         i8jROlAQlf7On7HxjwgvjdpvNmV3pyZYOaB/dnCQfxdk4vdbUfCdxGovfBE17edbF8n/
         14gBXJVUYjRccRlLX+eW8accS5DW5ENty+1HkuAuNWhoADhYEQPC+2u821+WZ3dm0WFM
         auFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768033423; x=1768638223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85VZqRS0HMw6ZG3sDTQxV/1q2B5Gy6mG+8xTLfX4fdI=;
        b=nRGOL+xhCcxe5o7VOMPotdeAPA7ez+dLwvZQf+26EKfTQmF0FqBtpVS8Y/Q0Lvq0ot
         wbhBWVjoBMuYMn0tJnvIg3wqSvWO/lBbLN29k9l7y6ARnK2Kr8Su1RWWFPn267kB0hix
         0+xDiiE16qZ3V951hXWVq1k8ddvwX/h1SIzj7fX3lMmYHI46F3Sh6Y61kbRl5b27v96K
         dxNS/ngmNvEDseiw5+BhcM0ykMF58tWmv/4t1TRNb0BfqEzHg3CFgfYhnkqVsVTlQXaR
         SBNvmZQ5hIK915hx8zn8bG2IoLUXE5/IYp86rJCFyOgHRAHFUtCd3IOBeMm5ah69mvYU
         8ZfA==
X-Forwarded-Encrypted: i=1; AJvYcCXMJQs7BZrTkJNKZdQUgux9HvB1O9LF58NiyNJU6y5H3Rer/1phOwnh/fTDHyFsYK+c0Yr+Oeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlAQicmAsNfzQHIY6hSyXjxCzUyyDi650Lmc5tVOqY99hN9geG
	soF7TIslhb0/LQWqRU0grExIzQJRsqXYldUztlcN3lojd/zh89S2nbru
X-Gm-Gg: AY/fxX7IJq18yH/IyBoC/J48t11riBpnRN6FH7KDAocET7bqbzFlAmR53+SjwX3Cr3d
	8AsjxTMpOGEyldE4RnIkz/FpPaPr+M1czI8DJ5AHAZEtbsp9lL3dSQjuihCoyymMCsdut6bPgiZ
	CNsSr8PA5rSfPKw+GVlBD8gGG7kEVHVLK/7vhyOm0ws5vGfs9A+JtxXMRG2QiO3OZVQhBd1ce44
	eVmTERP8P4qngODw5OCWoLPeLlIH4SA7XxAdVY+8yPL2Qta06BxeSH+0AnAGX1TD9Rxhb81BDRP
	JEHNA9h5Bo2ymovVJg2B5KaGvb07Be4LvJTEaRcr+epHCCLLkBCAbEQ8OaNVijM+l8PFfA6Myv0
	ZZ4afErX5rv9r2+a+MTvn1m9sq85o2sPyU7YScbi/HHoDvOdO065yaolL2fGYrJo96D7gIBMFsD
	c+T8fpvHrVe+pb+ArzBnRAxtGF8VL3JdixrSAnWDG4f4HvIRSbTw/zBc/EhLJ4G6g=
X-Google-Smtp-Source: AGHT+IHoygcVcBOXZTvHirg+fAWu4JoVecE6IMiVQAjqDcaQfChsGHo9TIym3L2ijvCSLqJ0rzIU0g==
X-Received: by 2002:a05:6a00:ae02:b0:81a:a5cc:da16 with SMTP id d2e1a72fcca58-81aa5ccdc92mr11900544b3a.32.1768033423234;
        Sat, 10 Jan 2026 00:23:43 -0800 (PST)
Received: from ?IPV6:2402:800:63b5:c9e8:e91e:c1cc:2faf:cf91? ([2402:800:63b5:c9e8:e91e:c1cc:2faf:cf91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e7c16sm12245985b3a.53.2026.01.10.00.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 00:23:42 -0800 (PST)
Message-ID: <2542db74-0e72-421d-932a-b1667fb16e56@gmail.com>
Date: Sat, 10 Jan 2026 15:23:36 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] virtio-net: don't schedule delayed refill
 worker
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20260106150438.7425-1-minhquangbui99@gmail.com>
 <20260106150438.7425-2-minhquangbui99@gmail.com>
 <20260109181239.1c272f88@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20260109181239.1c272f88@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/10/26 09:12, Jakub Kicinski wrote:
> On Tue,  6 Jan 2026 22:04:36 +0700 Bui Quang Minh wrote:
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
> Happy to see this go FWIW. If it causes issues we should consider
> adding some retry logic in the core (NAPI) rather than locally in
> the driver..
>
>> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
> The Closes should probably point to Paolo's report. We'll wipe these CI
> logs sooner or later but the lore archive will stick around.

I'll fix it in the next version.

>
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
> We should enforce _some_ minimal fill level at the time of open().
> If the ring is completely empty no traffic will ever flow, right?
> Perhaps I missed scheduling the NAPI somewhere..

The NAPI is enabled and scheduled in virtnet_napi_enable(). The code 
path is like this

virtnet_enable_queue_pair
-> virtnet_napi_enable
   -> virtnet_napi_do_enable
     -> virtqueue_napi_schedule

The same happens in __virtnet_rx_resume().

>
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
> Similar thing here? Tho not sure we can fail here..
>
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
> nit: spurious new line

I'll delete it in the next version.

>
>> +		local_bh_enable();
>> +	}
>>   
>>   	return 0;
>>   }


