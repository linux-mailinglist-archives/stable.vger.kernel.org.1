Return-Path: <stable+bounces-203045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCC0CCE7B8
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 06:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDBF7301130D
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 05:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5792C0298;
	Fri, 19 Dec 2025 05:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iyer4/7Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC17122688C
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 05:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766120620; cv=none; b=oJVm614MspBssMeQVWAlREPIDhrbwfczM6Sekfarw+JpUuh2Rfre+tUlw/7Dz8HKMBn+BapGBb+4XgNDJA8anNo4P6dvPWzJMtin1yXGOMWJHIYsa1dh1nICZZNxQc2S4LPeUpqJxfV2J4cfhn4BwvR8sHcUkupu5ocnvzKYnwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766120620; c=relaxed/simple;
	bh=kaURwmhdJjY8j91/nuYsMJxS/M+9Ly7tIAquBQJLkUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFJE7Sl/7lYfgE+ZW0AFnFClO3IagGGKoNgQ/4vF1x6S0STUO5dDIwLfILtNEQUvpnYB5L3qohsrlzJZ+TdzIjSUlyLsp/honKHQK4DtTvgtz4PzitTKUfYjAuIwuADgrbsdJpR/g0GPuHaK9mXsM8Q+PyY/U4d+9tW+bM8BL4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iyer4/7Z; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29f1bc40b35so24812365ad.2
        for <stable@vger.kernel.org>; Thu, 18 Dec 2025 21:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766120617; x=1766725417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZTCvbTwNrP8p42X+dpd7k1dFq41aRyw/GMHSDy5acE=;
        b=Iyer4/7ZW4Hy69dmR5GPqwHheqkmQR8/thVF17jlwpulr6jvINxSl1/A6a25uIhehg
         /cI68wYritWKGcpHIAg8KIz20aieDnO7mfIxrj1txYe/Yz+aMRCeV9dgK4FVUBDU9b4S
         xHvwhp7i/Z4M9r3gC0nrNUDjCEeTFGK6hWVNV+K1KkFqNpWV6g6IiPkJHd91AGlMqlXe
         F9M2CRwSp3gMDbwoYJ2YJomLhLXxNgcTYISg5IWqHrlkbVYZX/ZRVpKSp+xdUcMVQ+9Q
         ry7PR3yeVOt2GLMN5txlY4SlO90ZF2b6m2QCpaBn8Zl9N57ABQs/tZM+cT9WGDRWZFTq
         5iRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766120617; x=1766725417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZTCvbTwNrP8p42X+dpd7k1dFq41aRyw/GMHSDy5acE=;
        b=FE0g7MY2LSQbR46HUO7795PVIpX1sZfc9lIXOztOKDDKkCC9RYBf4qMKJdnXV+fPzy
         f10LbtN1A7P0xM+L4W1sYpPA2bgz4rWq7ECfIOJvINBEpzcSis9A2eke01rxQ0hwaByg
         PoowGB5csTqEvCe1VBoEY5aA2q01oQc5H9d/Kv5e9a4XnIDfS9dfHVW2B80bc/mf/6dv
         1imv10xivVmXE6yZzZ/wPbhZC27nVyiRX3l8Xpf+BSQUi+WRDY/XjbbyXJ19yqK/jOCN
         kiePYzPDQ/xvlCYkbGMJp9ebzzsqxmGKHJEIPA0iybP/8xpwakX4y3Y5mMpBVd3sffoO
         xFOw==
X-Forwarded-Encrypted: i=1; AJvYcCXxF7CfrLFbVtUzb7FpL0C/3MjOh3NzdKVrd2ra7nZZERXG1xcuWy+BhGYFNOCQkPswmK9Vi7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi9mxoy5Y5UV8gdW+bwZGidfQuuwyeOG1uRXkiYdImcxjkpMa9
	YM9gJpQssooj4th31Q0JSPQd5kfvLUSyjv9Z8T/gb2kDU/tgOlvI4Xeh
X-Gm-Gg: AY/fxX4ber2tv2Djv+pYh26IebJnA7xnfBuMdRlvlEInvB1Z79rmf1H5q4IiCEryn88
	kzm8iUtGqs7DfhfFKU8/G57S7ocIqvssUz8QEp5uq4BPgpnK1ul9qM3wW8JH597ZHgtxajoQw6b
	jy2IcMwrRxpeyGxpnsl2ZMSRP9XfID3ow1k0epww/HiIq1aM/8MMzwKJ0dX7hwJiH1F/GCADgk1
	yOApUkQ/8FF6mB6emSQW9NoeA/3s+Ryo74KFE0f+/QMmfhj4HORPZrtcmbEATKkvzuQas4x5qpQ
	wDOAFIYzGEuEI01AVI1h/fjv2VtSA5HOMTBDtmCNeSEo/0y4z3TJyzGWBTiJ3zFUL/RqEplOUpc
	j41vunrZLrquPXc9qrK3fofy7EFGlv98v5k09JIdNoYRcgNEVGhGfVmBKHpnCS6gZiFewzWNpJo
	UI/C98nGujiY4QarBTbMrlhEKMyDIvklitQXo5ck4jWIUijA5m5FDe/mO4jM4=
X-Google-Smtp-Source: AGHT+IEMNwtnT5HSACs7KJDQv87Ul7tb9qZwcx6898sXznsIUuzVEP7oMOI9Ae1p0oHl8YKCnExepA==
X-Received: by 2002:a17:902:e74c:b0:24b:270e:56c7 with SMTP id d9443c01a7336-2a2f22069e3mr16825885ad.7.1766120617119;
        Thu, 18 Dec 2025 21:03:37 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:2598:f3ef:512:c5a9? ([2001:ee0:4f4c:210:2598:f3ef:512:c5a9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d77451sm8994465ad.96.2025.12.18.21.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 21:03:36 -0800 (PST)
Message-ID: <5434a67e-dd6e-4cd1-870b-fdd32ad34a28@gmail.com>
Date: Fri, 19 Dec 2025 12:03:29 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] virtio-net: enable all napis before scheduling
 refill work
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
References: <20251212152741.11656-1-minhquangbui99@gmail.com>
 <CACGkMEtzXmfDhiQiq=5qPGXG+rJcxGkWk0CZ4X_2cnr2UVH+eQ@mail.gmail.com>
 <3f5613e9-ccd0-4096-afc3-67ee94f6f660@gmail.com>
 <CACGkMEs+Mse7nhPPiqbd2doeGtPD2QD3BM_cztr6e=VfuiobHQ@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEs+Mse7nhPPiqbd2doeGtPD2QD3BM_cztr6e=VfuiobHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/17/25 09:58, Jason Wang wrote:
> On Wed, Dec 17, 2025 at 12:23 AM Bui Quang Minh
> <minhquangbui99@gmail.com> wrote:
>> On 12/16/25 11:16, Jason Wang wrote:
>>> On Fri, Dec 12, 2025 at 11:28 PM Bui Quang Minh
>>> <minhquangbui99@gmail.com> wrote:
>>>> Calling napi_disable() on an already disabled napi can cause the
>>>> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
>>>> when pausing rx"), to avoid the deadlock, when pausing the RX in
>>>> virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
>>>> However, in the virtnet_rx_resume_all(), we enable the delayed refill
>>>> work too early before enabling all the receive queue napis.
>>>>
>>>> The deadlock can be reproduced by running
>>>> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
>>>> device and inserting a cond_resched() inside the for loop in
>>>> virtnet_rx_resume_all() to increase the success rate. Because the worker
>>>> processing the delayed refilled work runs on the same CPU as
>>>> virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
>>>> In real scenario, the contention on netdev_lock can cause the
>>>> reschedule.
>>>>
>>>> This fixes the deadlock by ensuring all receive queue's napis are
>>>> enabled before we enable the delayed refill work in
>>>> virtnet_rx_resume_all() and virtnet_open().
>>>>
>>>> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
>>>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>>>> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>>>> ---
>>>> Changes in v2:
>>>> - Move try_fill_recv() before rx napi_enable()
>>>> - Link to v1: https://lore.kernel.org/netdev/20251208153419.18196-1-minhquangbui99@gmail.com/
>>>> ---
>>>>    drivers/net/virtio_net.c | 71 +++++++++++++++++++++++++---------------
>>>>    1 file changed, 45 insertions(+), 26 deletions(-)
>>>>
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index 8e04adb57f52..4e08880a9467 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -3214,21 +3214,31 @@ static void virtnet_update_settings(struct virtnet_info *vi)
>>>>    static int virtnet_open(struct net_device *dev)
>>>>    {
>>>>           struct virtnet_info *vi = netdev_priv(dev);
>>>> +       bool schedule_refill = false;
>>>>           int i, err;
>>>>
>>>> -       enable_delayed_refill(vi);
>>>> -
>>>> +       /* - We must call try_fill_recv before enabling napi of the same receive
>>>> +        * queue so that it doesn't race with the call in virtnet_receive.
>>>> +        * - We must enable and schedule delayed refill work only when we have
>>>> +        * enabled all the receive queue's napi. Otherwise, in refill_work, we
>>>> +        * have a deadlock when calling napi_disable on an already disabled
>>>> +        * napi.
>>>> +        */
>>>>           for (i = 0; i < vi->max_queue_pairs; i++) {
>>>>                   if (i < vi->curr_queue_pairs)
>>>>                           /* Make sure we have some buffers: if oom use wq. */
>>>>                           if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
>>>> -                               schedule_delayed_work(&vi->refill, 0);
>>>> +                               schedule_refill = true;
>>>>
>>>>                   err = virtnet_enable_queue_pair(vi, i);
>>>>                   if (err < 0)
>>>>                           goto err_enable_qp;
>>>>           }
>>> So NAPI could be scheduled and it may want to refill but since refill
>>> is not enabled, there would be no refill work.
>>>
>>> Is this a problem?
>> You are right. It is indeed a problem.
>>
>> I think we can unconditionally schedule the delayed refill after
>> enabling all the RX NAPIs (don't check the boolean schedule_refill
>> anymore) to ensure that we will have refill work. We can still keep the
>> try_fill_recv here to fill the receive buffer earlier in normal case.
>> What do you think?
> Or we can have a reill_pending

Okay, let me implement this in the next version.

> but basically I think we need something
> that is much more simple. That is, using a per rq work instead of a
> global one?

I think we can leave this in a net-next patch later.

Thanks,
Quang Minh

>
> Thanks
>
>>>
>>>> +       enable_delayed_refill(vi);
>>>> +       if (schedule_refill)
>>>> +               schedule_delayed_work(&vi->refill, 0);
>>>> +
>>>>           if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
>>>>                   if (vi->status & VIRTIO_NET_S_LINK_UP)
>>>>                           netif_carrier_on(vi->dev);
>>>> @@ -3463,39 +3473,48 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>>>>           __virtnet_rx_pause(vi, rq);
>>>>    }
>>>>
>>> Thanks
>>>
>> Thanks,
>> Quang Minh.
>>


