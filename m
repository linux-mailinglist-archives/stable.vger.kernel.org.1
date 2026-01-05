Return-Path: <stable+bounces-204823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F1DCF450D
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 16:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA0E63075154
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 15:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B030D2EC083;
	Mon,  5 Jan 2026 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNpSJ4bD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C495C2D97BF
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767625414; cv=none; b=uT2eEIA516OM82kAO0YyGo4AQ1ZLssEEpNoxXIAnrH0NE2ldYdBOrYDSWMxInTCuJTBXoaAGfpZuhkZ5NDu/hRmuyS4ko1hjvrmEUa9jZ5g81DCWMp3POG2F4Y3oBPi2cNV3Ovxi6TqMhkJ4Fn+L11CfvMRD0kYRIOmUyDFx8cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767625414; c=relaxed/simple;
	bh=Bqc8kf7olJFNyZ85h9R2plDas33cpQ3lvfLxu48tc5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YyOkM2QbRq+DveujrOivYP/83npvsRZkb5lLLrWinIEw3TO/1KSPcvcNEB002qbA+TyIRxDO8gcBwOYm4Lox2uTatck/xEWq+CMJ+gkyDSjgTR9+1tIEgrVucd9OKVOea+YqapmLeuX+JvSJJAbvOkNTq3XGeGNzmmWXXgILasI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNpSJ4bD; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso1121285a91.1
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 07:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767625412; x=1768230212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pmPGbGv/+IEVWw4Vjf2YgHPxMHf7wirNG9XH5nP++64=;
        b=XNpSJ4bDUaEDYANWNOX2fPNJXTXoUC4HN3PV083iNOJQy4Tq7eon9M+ucEmWkKzBvT
         jdsYpSVLAMDIZ8SSoqJe88Z1GTN9iatVbhM8xc5+dKhnfBda0eljxYaWgyT1SwasgfLa
         RTThoF3GLCNX5FiZA2guQK1d54Q64GeWUeVBgMFNF+mlF0Oo7lUn9Fbpjnd4VsDcyALe
         KKDo9kSBcbBKDZYTXTmA5BC9qOWs3r8pKdTNkhrjzuQ5qeXNaU8b4ixHE9U+HB5C9HGC
         hcF4unnnl2pdwkCJe2UZDSEm5euTWNfr9YxFX5uUp6NsU3epa0pRLATTgKoMxSd4XIvT
         fq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767625412; x=1768230212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmPGbGv/+IEVWw4Vjf2YgHPxMHf7wirNG9XH5nP++64=;
        b=D/+KSJOoxhA1T7VNW4stYHVKmJpgRXKpssywV+aHawuhLAH/nvNRDEGlyBV+dXHZ5+
         5I/JRe5Z358BanW+RMV71/728HrTA3gSUfBVjodZeJwWBQbhg1s43kZ/hwoikGCDjPWl
         K9AQ9gcAEWEnkOMwvgz4Dn4N5AQjTIXaB/fGWw3zmacpCOFPl9TnEOHG9aTRVncc8jG/
         /8RZsqtNqnw8oA8PLApMLB/+HA2MVqs+2YcI7m7SwAYR/OJ6FPg8bcEeHluHTUl9FkIZ
         XW2/5toB8e070Kn7eGG3jCn+wRlHsQhgg0iebqDPPXijSgBIr+eyBFmbgHuHcyDzF8AI
         zBAw==
X-Forwarded-Encrypted: i=1; AJvYcCVC87EOV6EPQBQ4M0zPUvV3jrj5SMuzB+PxmrgFIlXgWBQ4KlHk+tA1sf3brXDAeqMSJ2CH3dA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqpeJ4DO1DzN+8MEcE+RC1Q0cY3jcHLdqn0ycTWiesEZRpU/ts
	IRkRhXt2NzzDkSozRqgkGIb5nHmxfNuXOxvlyy60wrYpFb2S3qggxYtw
X-Gm-Gg: AY/fxX43cnfhxKzX4WyeuEsup5VnTT4a5RRGs9daTXJyeWnF6NH8bGeBYUfUkilSWA6
	WCBZTyvi3N/aRxq+VFWVdavP/oo5Lh+Cz+LAyPGj8QCXTqN/Y8U03F7o4RUGCJN1UE4IKkxUiZp
	CDVFWXEvjMPzVLl5LyXvjSRey3GOKiQjKOL5c51eNRWjkVwepmD1oV9hGJt8BS6hKizYO65tus5
	dnnILxFXaJTMZZk66nM3KSfVCy1EXgWryg9lgG0BGzK0Hvm4EYTK09eDuz2qWBxxaLaw5G+mwqu
	Rd4LpxrxvLZi6jvdnt+vJJJD+5gqn2lKmx9T6xrHhuSKpmraDAW8J24xXtZZqV8xQI/x/865CnY
	UCSos244tV0FBzF/tRQB8pZDQ2oYKih6xbaJHUqfZKwMjraiPpI8e70fWSBV3KjPci/IzZyk3vN
	dBwQEs4r9TtSiQHcOPWH2o
X-Google-Smtp-Source: AGHT+IEmHx3Qjx6Si7MPV4gjFWQocc4zknKs2BVbHtxZjrunVw6izvZH0s+aJisvVpCKFRSjQtzbMg==
X-Received: by 2002:a17:90a:d883:b0:343:747e:2ca4 with SMTP id 98e67ed59e1d1-34f45399a2cmr5744005a91.9.1767625411847;
        Mon, 05 Jan 2026 07:03:31 -0800 (PST)
Received: from [192.168.0.118] ([14.187.47.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f4776dff1sm6489321a91.15.2026.01.05.07.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 07:03:30 -0800 (PST)
Message-ID: <a20950fe-455a-4c7b-b132-e8090e8d0c0f@gmail.com>
Date: Mon, 5 Jan 2026 22:03:22 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/3] virtio-net: don't schedule delayed refill
 worker
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20260102152023.10773-1-minhquangbui99@gmail.com>
 <20260102152023.10773-2-minhquangbui99@gmail.com>
 <CACGkMEs9wCM8s4_r1HCQGj9mUDdTF+BqkF0rse+dzB3USprhMA@mail.gmail.com>
 <6bac1895-d4a3-4e98-8f39-358fa14102db@gmail.com>
 <20260104085846-mutt-send-email-mst@kernel.org>
 <f4ac3940-d99c-4f63-bab3-cc68731fc9f1@gmail.com>
 <20260104100912-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20260104100912-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/4/26 22:12, Michael S. Tsirkin wrote:
> On Sun, Jan 04, 2026 at 09:54:30PM +0700, Bui Quang Minh wrote:
>> On 1/4/26 21:03, Michael S. Tsirkin wrote:
>>> On Sun, Jan 04, 2026 at 03:34:52PM +0700, Bui Quang Minh wrote:
>>>> On 1/4/26 13:09, Jason Wang wrote:
>>>>> On Fri, Jan 2, 2026 at 11:20 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>>>>>> When we fail to refill the receive buffers, we schedule a delayed worker
>>>>>> to retry later. However, this worker creates some concurrency issues
>>>>>> such as races and deadlocks. To simplify the logic and avoid further
>>>>>> problems, we will instead retry refilling in the next NAPI poll.
>>>>>>
>>>>>> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
>>>>>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>>>>>> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>>>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>>>>>> ---
>>>>>>     drivers/net/virtio_net.c | 55 ++++++++++++++++++++++------------------
>>>>>>     1 file changed, 30 insertions(+), 25 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>>>> index 1bb3aeca66c6..ac514c9383ae 100644
>>>>>> --- a/drivers/net/virtio_net.c
>>>>>> +++ b/drivers/net/virtio_net.c
>>>>>> @@ -3035,7 +3035,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
>>>>>>     }
>>>>>>
>>>>>>     static int virtnet_receive(struct receive_queue *rq, int budget,
>>>>>> -                          unsigned int *xdp_xmit)
>>>>>> +                          unsigned int *xdp_xmit, bool *retry_refill)
>>>>>>     {
>>>>>>            struct virtnet_info *vi = rq->vq->vdev->priv;
>>>>>>            struct virtnet_rq_stats stats = {};
>>>>>> @@ -3047,12 +3047,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>>>>>>                    packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
>>>>>>
>>>>>>            if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
>>>>>> -               if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
>>>>>> -                       spin_lock(&vi->refill_lock);
>>>>>> -                       if (vi->refill_enabled)
>>>>>> -                               schedule_delayed_work(&vi->refill, 0);
>>>>>> -                       spin_unlock(&vi->refill_lock);
>>>>>> -               }
>>>>>> +               if (!try_fill_recv(vi, rq, GFP_ATOMIC))
>>>>>> +                       *retry_refill = true;
>>>>>>            }
>>>>>>
>>>>>>            u64_stats_set(&stats.packets, packets);
>>>>>> @@ -3129,18 +3125,18 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>>>>>>            struct send_queue *sq;
>>>>>>            unsigned int received;
>>>>>>            unsigned int xdp_xmit = 0;
>>>>>> -       bool napi_complete;
>>>>>> +       bool napi_complete, retry_refill = false;
>>>>>>
>>>>>>            virtnet_poll_cleantx(rq, budget);
>>>>>>
>>>>>> -       received = virtnet_receive(rq, budget, &xdp_xmit);
>>>>>> +       received = virtnet_receive(rq, budget, &xdp_xmit, &retry_refill);
>>>>> I think we can simply let virtnet_receive() to return the budget when
>>>>> reill fails.
>>>> That makes sense, I'll change it.
>>>>
>>>>>>            rq->packets_in_napi += received;
>>>>>>
>>>>>>            if (xdp_xmit & VIRTIO_XDP_REDIR)
>>>>>>                    xdp_do_flush();
>>>>>>
>>>>>>            /* Out of packets? */
>>>>>> -       if (received < budget) {
>>>>>> +       if (received < budget && !retry_refill) {
>>>>>>                    napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
>>>>>>                    /* Intentionally not taking dim_lock here. This may result in a
>>>>>>                     * spurious net_dim call. But if that happens virtnet_rx_dim_work
>>>>>> @@ -3160,7 +3156,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>>>>>>                    virtnet_xdp_put_sq(vi, sq);
>>>>>>            }
>>>>>>
>>>>>> -       return received;
>>>>>> +       return retry_refill ? budget : received;
>>>>>>     }
>>>>>>
>>>>>>     static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
>>>>>> @@ -3230,9 +3226,11 @@ static int virtnet_open(struct net_device *dev)
>>>>>>
>>>>>>            for (i = 0; i < vi->max_queue_pairs; i++) {
>>>>>>                    if (i < vi->curr_queue_pairs)
>>>>>> -                       /* Make sure we have some buffers: if oom use wq. */
>>>>>> -                       if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
>>>>>> -                               schedule_delayed_work(&vi->refill, 0);
>>>>>> +                       /* If this fails, we will retry later in
>>>>>> +                        * NAPI poll, which is scheduled in the below
>>>>>> +                        * virtnet_enable_queue_pair
>>>>>> +                        */
>>>>>> +                       try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
>>>>> Consider NAPI will be eventually scheduled, I wonder if it's still
>>>>> worth to refill here.
>>>> With GFP_KERNEL here, I think it's more likely to succeed than GFP_ATOMIC in
>>>> NAPI poll. Another small benefit is that the actual packet can happen
>>>> earlier. In case the receive buffer is empty and we don't refill here, the
>>>> #1 NAPI poll refill the buffer and the #2 NAPI poll can receive packets. The
>>>> #2 NAPI poll is scheduled in the interrupt handler because the #1 NAPI poll
>>>> will deschedule the NAPI and enable the device interrupt. In case we
>>>> successfully refill here, the #1 NAPI poll can receive packets right away.
>>>>
>>> Right. But I think this is a part that needs elucidating, not
>>> error handling.
>>>
>>> /* Pre-fill rq agressively, to make sure we are ready to get packets
>>>    * immediately.
>>>    * */
>>>
>>>>>>                    err = virtnet_enable_queue_pair(vi, i);
>>>>>>                    if (err < 0)
>>>>>> @@ -3473,15 +3471,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>>>>>>                                    bool refill)
>>>>>>     {
>>>>>>            bool running = netif_running(vi->dev);
>>>>>> -       bool schedule_refill = false;
>>>>>>
>>>>>> -       if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
>>>>>> -               schedule_refill = true;
>>>>>> +       if (refill)
>>>>>> +               /* If this fails, we will retry later in NAPI poll, which is
>>>>>> +                * scheduled in the below virtnet_napi_enable
>>>>>> +                */
>>>>>> +               try_fill_recv(vi, rq, GFP_KERNEL);
>>>>> and here.
>>>>>
>>>>>> +
>>>>>>            if (running)
>>>>>>                    virtnet_napi_enable(rq);
>>> here the part that isn't clear is why are we refilling if !running
>>> and what handles failures in that case.
>> You are right, we should not refill when !running. I'll move the if (refill)
>> inside the if (running).
> Sounds like a helper that does refill+virtnet_napi_enable
> would be in order then?  fill_recv_aggressively(vi, rq) ?

I think the helper can make the code a little more complicated. In 
virtnet_open(), the RX NAPI is enabled in virtnet_enable_queue_pair() so 
we need to add a flag like enable_rx. Then change the virtnet_open() to

     for (i = 0; i < vi->max_queue_pairs; i++) {
         if (i < vi->curr_queue_pairs) {
             fill_recv_aggressively(vi, rq);
             err = virtnet_enable_queue_pair(..., enable_rx = false);
             if (err < 0)
                 goto err_enable_qp;
         } else {
             err = virtnet_enable_queue_pair(..., enable_rx = true);
             if (err < 0)
                 goto err_enable_qp;
         }

     }

>
>>>>>> -
>>>>>> -       if (schedule_refill)
>>>>>> -               schedule_delayed_work(&vi->refill, 0);
>>>>>>     }
>>>>>>
>>>>>>     static void virtnet_rx_resume_all(struct virtnet_info *vi)
>>>>>> @@ -3777,6 +3775,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>>>>>            struct virtio_net_rss_config_trailer old_rss_trailer;
>>>>>>            struct net_device *dev = vi->dev;
>>>>>>            struct scatterlist sg;
>>>>>> +       int i;
>>>>>>
>>>>>>            if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
>>>>>>                    return 0;
>>>>>> @@ -3829,11 +3828,17 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>>>>>            }
>>>>>>     succ:
>>>>>>            vi->curr_queue_pairs = queue_pairs;
>>>>>> -       /* virtnet_open() will refill when device is going to up. */
>>>>>> -       spin_lock_bh(&vi->refill_lock);
>>>>>> -       if (dev->flags & IFF_UP && vi->refill_enabled)
>>>>>> -               schedule_delayed_work(&vi->refill, 0);
>>>>>> -       spin_unlock_bh(&vi->refill_lock);
>>>>>> +       if (dev->flags & IFF_UP) {
>>>>>> +               /* Let the NAPI poll refill the receive buffer for us. We can't
>>>>>> +                * safely call try_fill_recv() here because the NAPI might be
>>>>>> +                * enabled already.
>>>>>> +                */
>>>>>> +               local_bh_disable();
>>>>>> +               for (i = 0; i < vi->curr_queue_pairs; i++)
>>>>>> +                       virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
>>>>>> +
>>>>>> +               local_bh_enable();
>>>>>> +       }
>>>>>>
>>>>>>            return 0;
>>>>>>     }
>>>>>> --
>>>>>> 2.43.0
>>>>>>
>>>>> Thanks
>>>>>
>>>> Thanks,
>>>> Quang Minh.


