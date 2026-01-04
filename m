Return-Path: <stable+bounces-204557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0F2CF0C1E
	for <lists+stable@lfdr.de>; Sun, 04 Jan 2026 09:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DF5830198C9
	for <lists+stable@lfdr.de>; Sun,  4 Jan 2026 08:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832942441A0;
	Sun,  4 Jan 2026 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NH5FqNkS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80546282EB
	for <stable@vger.kernel.org>; Sun,  4 Jan 2026 08:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767515716; cv=none; b=nfVbYlcEz0HVB1n+KYnn4prU2N/HEt33DG+V8ZA6/WhwNmVvMWkI/XvJ2W9Y/WlVHB3CVdmPbFElmjKDFndJbDPYpqje6pX11LHJcFWKKCz61OUAXl+kUknD87cQrDrxufgpkYlTX1aOicPzZhqvRgG/7D773wECF8YXVEp/V7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767515716; c=relaxed/simple;
	bh=eh/G7NXvMlnitQDBYTjGmYbYR7qvOpK6QBEB1BtFFZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APP8SJ2F9ZR4CG8xP3n1W72KlSxC3CFXEIPDI6KAtLDrp3Y70jEl7WJaxKN5NF7+KuY7CZ0vpo/QY5N+JwZp8rF9cdZvvXZ2/lrXlz2hGtYog26OE+lPSLf1kKVl0CaCJjTt6Iq8VIPfAg/iTyM5lQ8rKHJmW2gx391aAih3cEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NH5FqNkS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0ac29fca1so109768015ad.2
        for <stable@vger.kernel.org>; Sun, 04 Jan 2026 00:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767515713; x=1768120513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zYcNf5ruViQ0Bt7O6W4MTNR6Ck20+B4qnwscXLHJrJ4=;
        b=NH5FqNkSopY9ZyBmxALYz0wr7Y3pa6gCLfdjCgzhB6la3xEK25CYec2gwf+7J50/j5
         Zc+AsXEsyfFcfqcVH7Iz3zvWZTfyiFhS2imYdtO1b51cvwujJDEcDnqxBcmRmNrhKAXF
         404D2Y2lgCuEu2xfIyxEgAJ2j2biARUa3IXWjAiENAl/138FAEqLNGDlbvvRhwn+H28N
         u/UqB3UENBjjWVayxqfPITYUcIBeQYFhUHQ6tUfoWp7pGjx8mL6gj5L4x7/s26jRUTjn
         Eo64/vDsETVqzOxK2zAT62kk/EZFpuxZDMZNKoL3LXJ8RW7kIkld+OOjYqKQVhpRSfkY
         +yPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767515713; x=1768120513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYcNf5ruViQ0Bt7O6W4MTNR6Ck20+B4qnwscXLHJrJ4=;
        b=aUqCY7qLBZKqBgdl44m5iXdsUxKty+GA+Tv6xNTCA4gQEbqQHls0X8k7lOxxKSC487
         MD5CZLzg7tf3/G8mrSqdbVppc3v+K2/ulu6cs/LLcM9uUWuA6J4NFWXlKHZkxd3keodS
         yxNlO1wVyyx1bN2FL2ebpNK0p78bCAAanNd5itUux92jGvtxNAvPg6nBNfYgmXDEpqTR
         H5Nawqmi6A+Fi+048kGeg6dmSoy/wfixNfmsSiUYjxbWPGmqNSqgFEdH/4KlRfMkvqrl
         FWFTQ3pfykzDHPweJOSY8gYvxzur09+rH3hj8CKOHH2fgp9Yym8SziE/cvfXuELelBra
         ZBhw==
X-Forwarded-Encrypted: i=1; AJvYcCXRN6uMZ4iKgC6yRw0ljDv6nHumn4mm3arNykBsDh/7EAVNTzHbX7tzDq13JqqLchAPjpL4Pko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsF5gcdHeBfoqH54DZ6Pi5cS7yTgDExlT1upCEyNynNX5Dk3bk
	mraLR2NU5ufyRpo78qPYLF7ugSvkK+reO4mPIyoGCzO9ucppqs4n8RWG
X-Gm-Gg: AY/fxX6np6MCNn+qhXxy4kLfC0TaXV87Xt18Dqo0QKElE2eP18sFjF+PhRuL+MlZXTM
	kaK4ji/ixEZm9foQ/eAa9UHB/QJ34Qn03qrrPYhrTjwwLk5GkLbOnF7dGXg4KHe5TNtWs7bf/YW
	QqpWX5Uk76AP66v7RN6vLqvf7UfaqzFGpmIwgOtcZ66m9Oa6cHlBfTKR9jlRInKw9whvd+Upyot
	feOdGyT5i42syJ1/eWV3OgyDtCNybCxO4psEAUuZbaDx2PYVHoejkvc1bVP4X/udSVQzQ5wDR60
	2K2n7yxUkstN5xOL/tNYlk1zZ95TSG+Vzal1Ub9VN6HmKIMOFRdaE4KWkPxBarNYB1AD/txW6c8
	F6p1DyTyj0/9eZ9L0j/27WAjZNOiY2jb6s56oYocAA0Z9jk1Tp1DhV0bI2eb5VkKxl25Nkqb5wk
	cJkCtebeb1Oi+PTDH+IJ2D
X-Google-Smtp-Source: AGHT+IGONnUzqL7+hHcisSojq0N9wRnZKkoN8MPifLQrP1FZZCuWqkigoPO5dJvLiXoTCd9y6sg47Q==
X-Received: by 2002:a05:6a20:394a:b0:35c:dfd6:6acb with SMTP id adf61e73a8af0-376a7af5089mr41512918637.30.1767515712648;
        Sun, 04 Jan 2026 00:35:12 -0800 (PST)
Received: from [172.16.98.252] ([14.161.45.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f44ea585fsm2120401a91.0.2026.01.04.00.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 00:35:12 -0800 (PST)
Message-ID: <6bac1895-d4a3-4e98-8f39-358fa14102db@gmail.com>
Date: Sun, 4 Jan 2026 15:34:52 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/3] virtio-net: don't schedule delayed refill
 worker
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
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
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEs9wCM8s4_r1HCQGj9mUDdTF+BqkF0rse+dzB3USprhMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/4/26 13:09, Jason Wang wrote:
> On Fri, Jan 2, 2026 at 11:20 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> When we fail to refill the receive buffers, we schedule a delayed worker
>> to retry later. However, this worker creates some concurrency issues
>> such as races and deadlocks. To simplify the logic and avoid further
>> problems, we will instead retry refilling in the next NAPI poll.
>>
>> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
>> Cc: stable@vger.kernel.org
>> Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 55 ++++++++++++++++++++++------------------
>>   1 file changed, 30 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 1bb3aeca66c6..ac514c9383ae 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3035,7 +3035,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
>>   }
>>
>>   static int virtnet_receive(struct receive_queue *rq, int budget,
>> -                          unsigned int *xdp_xmit)
>> +                          unsigned int *xdp_xmit, bool *retry_refill)
>>   {
>>          struct virtnet_info *vi = rq->vq->vdev->priv;
>>          struct virtnet_rq_stats stats = {};
>> @@ -3047,12 +3047,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>>                  packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
>>
>>          if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
>> -               if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
>> -                       spin_lock(&vi->refill_lock);
>> -                       if (vi->refill_enabled)
>> -                               schedule_delayed_work(&vi->refill, 0);
>> -                       spin_unlock(&vi->refill_lock);
>> -               }
>> +               if (!try_fill_recv(vi, rq, GFP_ATOMIC))
>> +                       *retry_refill = true;
>>          }
>>
>>          u64_stats_set(&stats.packets, packets);
>> @@ -3129,18 +3125,18 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>>          struct send_queue *sq;
>>          unsigned int received;
>>          unsigned int xdp_xmit = 0;
>> -       bool napi_complete;
>> +       bool napi_complete, retry_refill = false;
>>
>>          virtnet_poll_cleantx(rq, budget);
>>
>> -       received = virtnet_receive(rq, budget, &xdp_xmit);
>> +       received = virtnet_receive(rq, budget, &xdp_xmit, &retry_refill);
> I think we can simply let virtnet_receive() to return the budget when
> reill fails.

That makes sense, I'll change it.

>
>>          rq->packets_in_napi += received;
>>
>>          if (xdp_xmit & VIRTIO_XDP_REDIR)
>>                  xdp_do_flush();
>>
>>          /* Out of packets? */
>> -       if (received < budget) {
>> +       if (received < budget && !retry_refill) {
>>                  napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
>>                  /* Intentionally not taking dim_lock here. This may result in a
>>                   * spurious net_dim call. But if that happens virtnet_rx_dim_work
>> @@ -3160,7 +3156,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>>                  virtnet_xdp_put_sq(vi, sq);
>>          }
>>
>> -       return received;
>> +       return retry_refill ? budget : received;
>>   }
>>
>>   static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
>> @@ -3230,9 +3226,11 @@ static int virtnet_open(struct net_device *dev)
>>
>>          for (i = 0; i < vi->max_queue_pairs; i++) {
>>                  if (i < vi->curr_queue_pairs)
>> -                       /* Make sure we have some buffers: if oom use wq. */
>> -                       if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
>> -                               schedule_delayed_work(&vi->refill, 0);
>> +                       /* If this fails, we will retry later in
>> +                        * NAPI poll, which is scheduled in the below
>> +                        * virtnet_enable_queue_pair
>> +                        */
>> +                       try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
> Consider NAPI will be eventually scheduled, I wonder if it's still
> worth to refill here.

With GFP_KERNEL here, I think it's more likely to succeed than 
GFP_ATOMIC in NAPI poll. Another small benefit is that the actual packet 
can happen earlier. In case the receive buffer is empty and we don't 
refill here, the #1 NAPI poll refill the buffer and the #2 NAPI poll can 
receive packets. The #2 NAPI poll is scheduled in the interrupt handler 
because the #1 NAPI poll will deschedule the NAPI and enable the device 
interrupt. In case we successfully refill here, the #1 NAPI poll can 
receive packets right away.


>
>>                  err = virtnet_enable_queue_pair(vi, i);
>>                  if (err < 0)
>> @@ -3473,15 +3471,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>>                                  bool refill)
>>   {
>>          bool running = netif_running(vi->dev);
>> -       bool schedule_refill = false;
>>
>> -       if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
>> -               schedule_refill = true;
>> +       if (refill)
>> +               /* If this fails, we will retry later in NAPI poll, which is
>> +                * scheduled in the below virtnet_napi_enable
>> +                */
>> +               try_fill_recv(vi, rq, GFP_KERNEL);
> and here.
>
>> +
>>          if (running)
>>                  virtnet_napi_enable(rq);
>> -
>> -       if (schedule_refill)
>> -               schedule_delayed_work(&vi->refill, 0);
>>   }
>>
>>   static void virtnet_rx_resume_all(struct virtnet_info *vi)
>> @@ -3777,6 +3775,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>          struct virtio_net_rss_config_trailer old_rss_trailer;
>>          struct net_device *dev = vi->dev;
>>          struct scatterlist sg;
>> +       int i;
>>
>>          if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
>>                  return 0;
>> @@ -3829,11 +3828,17 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>          }
>>   succ:
>>          vi->curr_queue_pairs = queue_pairs;
>> -       /* virtnet_open() will refill when device is going to up. */
>> -       spin_lock_bh(&vi->refill_lock);
>> -       if (dev->flags & IFF_UP && vi->refill_enabled)
>> -               schedule_delayed_work(&vi->refill, 0);
>> -       spin_unlock_bh(&vi->refill_lock);
>> +       if (dev->flags & IFF_UP) {
>> +               /* Let the NAPI poll refill the receive buffer for us. We can't
>> +                * safely call try_fill_recv() here because the NAPI might be
>> +                * enabled already.
>> +                */
>> +               local_bh_disable();
>> +               for (i = 0; i < vi->curr_queue_pairs; i++)
>> +                       virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
>> +
>> +               local_bh_enable();
>> +       }
>>
>>          return 0;
>>   }
>> --
>> 2.43.0
>>
> Thanks
>

Thanks,
Quang Minh.


