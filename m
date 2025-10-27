Return-Path: <stable+bounces-190003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C07C0E872
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CFAB467456
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD30309EF3;
	Mon, 27 Oct 2025 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0bSv9LS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9242C11FB
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575857; cv=none; b=HuCrYDHhSXdIFKRVxv0X7zxwGiCsmtjidBXfHTxXhx6VZUJXhEQLzh8S7OplY0YZfic60bNY3u9Q0iPo0akdxRY6OkN3MoiU0LVrGKFfDCfCtd/WlG1iXsYTf/EVQ3Xvs1YBU4Qe92OOCZ7VbTPjBGm8yM+g9fTfOx8Ni5sCBQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575857; c=relaxed/simple;
	bh=adn7NhSXM4F+uMTSsRmO9V9GvUSLky72zBSuV3U4ELM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4ccmeIFgmEg3S7oOODMYMBGqqcvVLFxxrk87vWNnlDZtLohBoHHL14/1A3kJINwZoZTKnWa9Xod2xNeoEwslrKc0rUq8h48dAoMprJr3LXcDvWhiSR930MoUnzoCEt34eYRyQ2GJO5uZgTZWBFYS35zEBlgJ36UObSG7m/eojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0bSv9LS; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a27ab05a2dso3991861b3a.2
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 07:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761575854; x=1762180654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4B2eLu4llGXCU4gdWSthJqBowpW96zatbh6aox0b+bY=;
        b=e0bSv9LSMLGnUeVspq1SLeSkr751kmjCy2clTjBW7kOYOko7npqJfCEHVKqhoJ2N3n
         znpD9EBNgOSTUzCNmcEJ5vf74Oi6sqshROnLL9bRoPDzeQplihCKvUX2KbmVyPzLY4MR
         7fMdsZn3oPCvWQhJDlNJZhSx583KCFrH9yBlio/8FE1OT1s+B6BDMB18VUy1/B8c49b2
         UgST7igncY1DlvPoKPrX6YUZ4oRq19MUkrasDH3LodHdRbCyx1FjmG3YYxaJaoKNX+LQ
         dRFp8sky/Tn7VgowolRlhGeR+K7AHlVLp96s/R88rt2lcL5AnUHm1M+z1ascOi+ZMaK1
         13yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761575854; x=1762180654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4B2eLu4llGXCU4gdWSthJqBowpW96zatbh6aox0b+bY=;
        b=tMAYuSbdOZHpsPGxD5xmxt7xIKXBSdQ055feSEE9gb5s1YE+5FiWEP3/rJ6gykDHQY
         JHqp74PvZPV1azoYpnnmj+h1NUi3Iv01tRXaKg7Kc7bBNCxGDqfAdW/J0kvSOS78bgwC
         /CAKNYNz7LKyWMZn1bIW/1N1oNTY86URSdBUM2KXonQnuX+JYQHaYpKrgVxQQQj1r63/
         EczbBCx5xiyvXEN136rIyNhRb7SLz5f7k3jM/9f3H3AanKYhVWciRPqfR4VZMVEr4MYL
         bz6cLLqGmluxeIZ9Dd2el3LrDretddSKdOhdw7yZ7NABQ7lmLYmZED9Qu5XBqDxwL4Hr
         SRyA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ1IHSOXtluGz6osDb9ClfCaAVtcXz5V1HxN0ILXoo2nG72px7vLDi4FBechIiyL6uQGENAck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5fFlJ6/RHgPGj61y4eXTMYd7O+ZzE6YHTQK1utbw14C/u6kyV
	V6wEt72SckupZsKzV46OcSUeoY5QfJsgPXZ/VH9OLati9sdQjSYWrMMs
X-Gm-Gg: ASbGncugJ1EWYKmYEwTWCh/ak3gKBduARRz8+sRPdPYLwByFfzkCFg5A53agdRuJZi7
	7LqhWU5ZTfg8UZUFPiFBTAvKcyt+zRtcHI8KjDHwjs0uUBjC1WDYCDl8tJbN+6TjzfOEdNtC819
	t0HS4JCfngP6Y4mBgk2JRRc6I2uAhdt03W7Npa2Zy/t98SFIJo5om6fAZDpdjn2HJwlrS9J+ZGG
	btBpBap95uh3uFh80FuY9lMHFnO0+5N/pbtYzlqrqqG5qQ9nyk3NEeAqSPSbrEIwbuyL1aNd4Sp
	XwJs63iwd+mklzimAvqLWFS/BIyFTPd9RCA4GqQsf7x7AUyQZHmHJmQGzazbpi5ATlBHOEh5t6u
	BvBwCpECiemUWcya8NCsCz82ahKtiOseBbqrr+/z2l1tctzdTKXPeNq2Le7Pe3LKN0e9+9v0nDB
	V44MnSNCMv0AIAPZUDi1vIxEp8vpyNONbw8Fr+Wpb4JFAc+9AmQzHhiqaWtQdNoOHjVI2OBcfb
X-Google-Smtp-Source: AGHT+IGTA/k5UQ2FNEr9mRS1Wz3fIDbx1lAqcpQR27aZ9cZE/UvwNhDm/mbd//iNK1nFji1/GqjjHQ==
X-Received: by 2002:a05:6a20:72a3:b0:334:79cd:fb13 with SMTP id adf61e73a8af0-334a85047abmr48082035637.4.1761575853948;
        Mon, 27 Oct 2025 07:37:33 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f4c:210:d7dc:fc1f:94d0:3318? ([2001:ee0:4f4c:210:d7dc:fc1f:94d0:3318])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414087cdbsm8438806b3a.64.2025.10.27.07.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 07:37:33 -0700 (PDT)
Message-ID: <b74b46e7-63e9-4330-b330-09d14d45fe9b@gmail.com>
Date: Mon, 27 Oct 2025 21:37:24 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5] virtio-net: fix received length check in big
 packets
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, netdev@vger.kernel.org
References: <20251024150649.22906-1-minhquangbui99@gmail.com>
 <1761527437.6478114-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <1761527437.6478114-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 08:10, Xuan Zhuo wrote:
> On Fri, 24 Oct 2025 22:06:49 +0700, Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
>> for big packets"), when guest gso is off, the allocated size for big
>> packets is not MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on
>> negotiated MTU. The number of allocated frags for big packets is stored
>> in vi->big_packets_num_skbfrags.
>>
>> Because the host announced buffer length can be malicious (e.g. the host
>> vhost_net driver's get_rx_bufs is modified to announce incorrect
>> length), we need a check in virtio_net receive path. Currently, the
>> check is not adapted to the new change which can lead to NULL page
>> pointer dereference in the below while loop when receiving length that
>> is larger than the allocated one.
>>
>> This commit fixes the received length check corresponding to the new
>> change.
>>
>> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>> Changes in v5:
>> - Move the length check to receive_big
>> - Link to v4: https://lore.kernel.org/netdev/20251022160623.51191-1-minhquangbui99@gmail.com/
>> Changes in v4:
>> - Remove unrelated changes, add more comments
>> - Link to v3: https://lore.kernel.org/netdev/20251021154534.53045-1-minhquangbui99@gmail.com/
>> Changes in v3:
>> - Convert BUG_ON to WARN_ON_ONCE
>> - Link to v2: https://lore.kernel.org/netdev/20250708144206.95091-1-minhquangbui99@gmail.com/
>> Changes in v2:
>> - Remove incorrect give_pages call
>> - Link to v1: https://lore.kernel.org/netdev/20250706141150.25344-1-minhquangbui99@gmail.com/
>> ---
>>   drivers/net/virtio_net.c | 25 ++++++++++++-------------
>>   1 file changed, 12 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index a757cbcab87f..2c3f544add5e 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -910,17 +910,6 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
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
>> -		net_dbg_ratelimited("%s: too much data\n", skb->dev->name);
>> -		dev_kfree_skb(skb);
>> -		return NULL;
>> -	}
>>   	BUG_ON(offset >= PAGE_SIZE);
>>   	while (len) {
>>   		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
>> @@ -2107,9 +2096,19 @@ static struct sk_buff *receive_big(struct net_device *dev,
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
>
> I think should be:
>
> 	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
>
> Thanks

Sorry, my mistake. I'll fix it.

Thanks,
Quang Minh.

>
>
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
>>


