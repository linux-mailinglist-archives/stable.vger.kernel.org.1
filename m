Return-Path: <stable+bounces-190007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8D6C0E9CC
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED80719C1BE9
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AF6302772;
	Mon, 27 Oct 2025 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HI8waqTL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C55F2D12EB
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576564; cv=none; b=fgKhVlWJB9Af2jIG/A2AKLy7VcQkLSDh6OJwSbFL6ixCEJxvgtsLsQ0g0OEO7ayHbVgih9Vsa/ml9sOLShpsd83v/Pgb+71abPiDohHqTz9rXi2Crkos4nZRJtnagOgbxnXbQaUS3rik+Y6IFDdQTYMvJUIbe7E4Wm5+SewCXf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576564; c=relaxed/simple;
	bh=CjrEwSgjiwD336OKAJb8KSdBV5+gSPyH1P76ISzvG+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JpyLioU9JGk0xUvr6fgBir4M5474aQ9tu7u1x3h5Qk8PeOd10sURlMmDmQec5F9IF8B7cliluz3Yr2LJWEQCTBli7SAqk097xsBa9dh4xj1HoP2mrOglpma+YXADZ6wIaZXz3q+LWIUGwM+vd7JVClXJk+CSDfHxqmgfU0/cIa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HI8waqTL; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a27bf4fbcbso3890068b3a.1
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 07:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761576561; x=1762181361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ANPsngXgMHjdKcxNVoXIy4m28dyqI6/YbqpsmZo++8U=;
        b=HI8waqTLhB4yO1BlEIScE6/b/tGbhUbEWqPon8IRHL41cRfg5uYCZzs3r4psVQ8Z4k
         EqoZr+38+smJj6URfxM+e82+ba7sL1veQ969/KcLhJ+gKxu2NjLeV1rBu4HUCbRZkmcD
         YsHukIr0keyd+G0pG2CJXSiZWsMVXDDsE/o9f8EpmYJ00tHzrzWYzfOTxrx7pVlSjIbZ
         Ru4CiEMD76ashBloC4Wu0J9bYCXcDIfxaxgElGECmq0pdVCd92uir1hsq/jKc3+6qyh+
         tCIQaHuebNmwU9p+MUgXIbQhjuz4jCmHPjmjdqbZSdHK3Cg4LAuWQ5yMYPQwlUZy9yLS
         SVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761576561; x=1762181361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANPsngXgMHjdKcxNVoXIy4m28dyqI6/YbqpsmZo++8U=;
        b=gI1JFSEPUyjpVO73ZI/uRgnPIsnH2+XXk+huI/ZWjnBQs9VlCSl8Xyf/o5I1u8yw9F
         Iws38BQ1bzwD9CN0urTG6Vumjya4Fy2Z2kV8R6d8w4VFvE1WQ+ms/8NXz4muvV7DCcrX
         0D2+i8V7TWEbj6z1hDxkeRlw/qPWL5DMcSOqxLqptojchP9Ot+xf8LutLyHGhgRd5Dsl
         g0kDBEwn8TNX0cMMinmvjHJo0q21meks8+rqZs5CNxX2REPSNG3Iqw4Pxa13tjUmlP49
         g7ShHxwlWuoOQS4p77qevYdGGWpY+PgroO/ux2QZ60Fg750RBnIN/J3y1ziGqrlK1vsh
         B+4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNFHZTDtWnDtSiQYWUtLlEmelPHa6c3SN1lUdNPmu4cHrZC8tRLhLNwhsrihKdu1L2PCCVe1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YydIAIESBcdIUuEDMKKMSInS8QRjxRqHoco5q/HtZ+hk750GPD0
	dT20zGE0+z1mbSQMXB2vhb65reFbpTQA2K/9wsA/VDtTCphKtJm9nyXb
X-Gm-Gg: ASbGncu6vDDgOSERraD6kYoGJ5wxhIkSJSdslIJKC40U2qbvZMo1y86ctt8poXoaG5x
	u9UjR56nVL2z/kBpDjClyeWKWo7fZO9kXN3vScrZ3yWIAytNmIkQewukLdCCq4Dzr17dLmpBgOx
	5WTOILYz9lykfWv0v2i9LscuijLOE5uMmH/vWPCKYBXw/jaAGybVors5KZu2hmCASKgZdIAR64a
	tlyJWNWOYp1HVcevswAeUrZn1i+rAQPjr8Zgb6nZVHN5DNTsdZMJ6L9Wqc8M282DhjuTDX+oGE4
	iTm+BHHFJIuBJ7X31dNuw9uWHdd1a7T24er5vkw9JAvyv2CirXpuIPd6tWtOQvc5IVeFB9ZPFhg
	vxaiT0nBQXrvuhWHo4J6FFaY+9prOcfoYi+0PJEOwS2mMFRj0cofDw2HkH1s0raA/cOBNhbSwHd
	QLCjeUAKDWGFNdP4jK9ABObWc7S2jsUypg/HTQdg8Ka7fT6e88qMLOCzGGbyJWlQ==
X-Google-Smtp-Source: AGHT+IEok/bzITDTCab03QqNwX8lBfkK7cWFMLgw94U0uFNw9rZow3hQZEVr+kA8L+xnK5EFRYIn1Q==
X-Received: by 2002:a05:6a00:188b:b0:7a2:8343:1b1 with SMTP id d2e1a72fcca58-7a441c2edefmr272995b3a.17.1761576560215;
        Mon, 27 Oct 2025 07:49:20 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f4c:210:d7dc:fc1f:94d0:3318? ([2001:ee0:4f4c:210:d7dc:fc1f:94d0:3318])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41404987esm8217502b3a.36.2025.10.27.07.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 07:49:19 -0700 (PDT)
Message-ID: <8e2b6a66-787b-4a03-aa74-a00430b85236@gmail.com>
Date: Mon, 27 Oct 2025 21:49:12 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5] virtio-net: fix received length check in big
 packets
To: Parav Pandit <parav@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Minggang(Gavin) Li" <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20251024150649.22906-1-minhquangbui99@gmail.com>
 <CY8PR12MB71951A2ADD74508A9FC60956DCFEA@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CY8PR12MB71951A2ADD74508A9FC60956DCFEA@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/25 14:11, Parav Pandit wrote:
>> From: Bui Quang Minh <minhquangbui99@gmail.com>
>> Sent: 24 October 2025 08:37 PM
>>
>> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big
>> packets"), when guest gso is off, the allocated size for big packets is not
>> MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
>> number of allocated frags for big packets is stored in vi-
>>> big_packets_num_skbfrags.
>> Because the host announced buffer length can be malicious (e.g. the host
>> vhost_net driver's get_rx_bufs is modified to announce incorrect length), we
>> need a check in virtio_net receive path. Currently, the check is not adapted to
>> the new change which can lead to NULL page pointer dereference in the below
>> while loop when receiving length that is larger than the allocated one.
>>
> This looks wrong.
> A device DMAed N bytes, and it reports N + M bytes in the completion?
> Such devices should be fixed.
>
> If driver allocated X bytes, and device copied X + Y bytes on receive packet, it will crash the driver host anyway.
>
> The fixes tag in this patch is incorrect because this is not a driver bug.
> It is just adding resiliency in driver for broken device. So driver cannot have fixes tag here.

Yes, I agree that the check is a protection against broken device.

The check is already there before this commit, but it is not correct 
since the changes in commit 4959aebba8c0 ("virtio-net: use mtu size as 
buffer length for big packets"). So this patch fixes the check 
corresponding to the new change. I think this is a valid use of Fixes tag.

Thanks,
Quang Minh.

>
>> This commit fixes the received length check corresponding to the new change.
>>
>> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big
>> packets")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>> Changes in v5:
>> - Move the length check to receive_big
>> - Link to v4: https://lore.kernel.org/netdev/20251022160623.51191-1-
>> minhquangbui99@gmail.com/
>> Changes in v4:
>> - Remove unrelated changes, add more comments
>> - Link to v3: https://lore.kernel.org/netdev/20251021154534.53045-1-
>> minhquangbui99@gmail.com/
>> Changes in v3:
>> - Convert BUG_ON to WARN_ON_ONCE
>> - Link to v2: https://lore.kernel.org/netdev/20250708144206.95091-1-
>> minhquangbui99@gmail.com/
>> Changes in v2:
>> - Remove incorrect give_pages call
>> - Link to v1: https://lore.kernel.org/netdev/20250706141150.25344-1-
>> minhquangbui99@gmail.com/
>> ---
>>   drivers/net/virtio_net.c | 25 ++++++++++++-------------
>>   1 file changed, 12 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
>> a757cbcab87f..2c3f544add5e 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -910,17 +910,6 @@ static struct sk_buff *page_to_skb(struct
>> virtnet_info *vi,
>>   		goto ok;
>>   	}
>>
>> -	/*
>> -	 * Verify that we can indeed put this data into a skb.
>> -	 * This is here to handle cases when the device erroneously
>> -	 * tries to receive more than is possible. This is usually
>> -	 * the case of a broken device.
>> -	 */
>> -	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
>> -		net_dbg_ratelimited("%s: too much data\n", skb->dev-
>>> name);
>> -		dev_kfree_skb(skb);
>> -		return NULL;
>> -	}
>>   	BUG_ON(offset >= PAGE_SIZE);
>>   	while (len) {
>>   		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset,
>> len); @@ -2107,9 +2096,19 @@ static struct sk_buff *receive_big(struct
>> net_device *dev,
>>   				   struct virtnet_rq_stats *stats)
>>   {
>>   	struct page *page = buf;
>> -	struct sk_buff *skb =
>> -		page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
>> +	struct sk_buff *skb;
>> +
>> +	/* Make sure that len does not exceed the allocated size in
>> +	 * add_recvbuf_big.
>> +	 */
>> +	if (unlikely(len > vi->big_packets_num_skbfrags * PAGE_SIZE)) {
>> +		pr_debug("%s: rx error: len %u exceeds allocate size %lu\n",
>> +			 dev->name, len,
>> +			 vi->big_packets_num_skbfrags * PAGE_SIZE);
>> +		goto err;
>> +	}
>>
>> +	skb = page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
>>   	u64_stats_add(&stats->bytes, len - vi->hdr_len);
>>   	if (unlikely(!skb))
>>   		goto err;
>> --
>> 2.43.0


