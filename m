Return-Path: <stable+bounces-191653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58938C1BE08
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 16:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8111E5C7196
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 15:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2760533B975;
	Wed, 29 Oct 2025 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcoNs71L"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E50341678
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752943; cv=none; b=AmpuBAqFik7rlv+lEbrAYC2/qCECXMk7TldlaOMcp2pzisGmyKZiROFyqtxLQRq5uaoMhwolfAWHdWryfEYDtZqxEmO5UNwDfo4DyqaToH7tONBMlG1XxQe9XZDxupzygYZvjs9DnTgqqYgyNvBexTa4UyG3gcL8y9SiJYB42bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752943; c=relaxed/simple;
	bh=XZ/WZ9rOoWMMtJ/bPO8rxjjiFAaTwX+96Lqtx/dBKuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvyYvLz8zYkv6cN7YQovdepC0YvKUkZGsIdoow3J50fmsfzDT7vr9sNqUer0jG0IrPD7Rc/l2nOtRmCCCZRc+DpoeOZg5EwK7CR+65IlW8Xo1e1YiGffxu1Qv3qLxULUsP1KlGT0kFkB/grOfAhA3ChCjKS0n4yN9d7J9/IpcYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcoNs71L; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a28226dd13so54215b3a.3
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 08:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761752941; x=1762357741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xahGF8Qhu9liQEvN8Aw5ydRO2CUSEDKXLGDLGd1XDbA=;
        b=dcoNs71LtZdRr0olhCp26g57J9ARxxE3ux/vKMIRRN+bIJdRIDcNvqTLyzlZ3SG7fj
         zOhvvGAekGw+GLgy5BFBDJEB32TTjhFU8Xcgn7t1HCXzI4hKKP2e130F/tlwddH38hFN
         q6G3qQSZVDEQX5ys671Na76b2HFKE44MnF8wOr8eTdlvH+/bqq4vPgtiXOSrU2azXIgJ
         sfxfkyE8SqOLPgy8wYck44Gj4vNKZDhyGeA+GGvF778TDs9iyJ8+Cw7oAbrS7koFa4Hp
         SqNkfVDFLHYwYaylgpj1A7vtw/ApGlJCqSB9kdkSYom7YYRdS5ikeUVvLVOoiA6YQnJD
         p5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761752941; x=1762357741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xahGF8Qhu9liQEvN8Aw5ydRO2CUSEDKXLGDLGd1XDbA=;
        b=dEKrwpK/pIe4zyB5z1TlQEOW55CoVIfIjhXuSgVD4N98On3U0VbQG41kxuzDYu2n/H
         24WUEnq/5A9ngRILFFYnPFoCwr1V+X8Q8lmrX+GekIaHPt4IDyhbEjI0SFvoXaXDi71b
         8/DfWZ67SqgfmSjFXMLImZ0kcnyalS8qxxKVD4ysIPUCxFMzadpPmEmhsNipAcYJY9nD
         Rk8fpikzlZhhScc4nva+frDXufA0K7jnrdY4XQKDm/mIglz8mMWclY5eqMqmIXpnSmcS
         VvlDmLRoGK3CYSDR6cTYnNO/wNqPPeEbdTZ5MP4Pec+30LthUJ0z0N2X47voIYtJ3KVO
         94kw==
X-Forwarded-Encrypted: i=1; AJvYcCXVLdvMsxrZqYqeIJKc7EWDsmtUijWt7dLBCiljAKfyH4AZi8LbTDikq0C1cXLVIgEstRPm2hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLRN4DoDtlhA1lxjZis6dn2gDvHIYGpC/XdhlmKtxEl04knwRa
	GVSTbxm7b2cDSGrrXeED289ukG1hPboyug+70XJJEcuMkM95H3nqzPDM
X-Gm-Gg: ASbGncutrDzFfFdgPzTcBbBUBBtO+DepuvJ4wyBZGflBQJOYIPqf/aTqi5183NFAPR+
	kJCgb0Url0froIIU01UHXi/TDkyUYYevrrMC6oMCIvuRch1RIV54azktJex4WVIVTSW7i0Dztwp
	Up4+7FQP9CI5xI4D9xZIOIMnDLvBCGGRc9mUS+ZX65pB/E5+1cA5AC9qOelOoI5xzoOV11OPpU3
	VpAT2R4xfDZKBBojZWBTgfTLbBpURmigsusdgdcA46T6UWzJvBBCw4yxUk0hG1/COqWsUWbpZOD
	D8/zswFPWw9Abp+mIAQkgIMX46vBG1eTZfecgtERxKmdxjGdjRkfk2FttaQwEhd++ffZLIZ/HPC
	NY7JzbPN/zaaNy6XmHlWm4OMY+i+vyFkrwGsZK7/6l/B8MFQnw9rchy5zmhDDT9ErUAXFq8Zrlc
	1zt510+8KTwmJa84kt0pBWWsOn6mNmURFdushCL828FpoBzrkHY6aK8OHFazv1pQ==
X-Google-Smtp-Source: AGHT+IGnsqJ5B0aHdVMgMj8dRtDF3qsvm6zVbKD5CbjQ8u4utwV9uD5rLJD9GDDUfRzpmwKxrHtGAQ==
X-Received: by 2002:a05:6a00:2345:b0:781:556:f33 with SMTP id d2e1a72fcca58-7a4e2722946mr4181047b3a.5.1761752941460;
        Wed, 29 Oct 2025 08:49:01 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f4c:210:2e86:dcd2:19c2:4a7e? ([2001:ee0:4f4c:210:2e86:dcd2:19c2:4a7e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41409c703sm15596353b3a.70.2025.10.29.08.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 08:49:00 -0700 (PDT)
Message-ID: <a4081f8d-7d12-46f2-b7d8-4145003a0dac@gmail.com>
Date: Wed, 29 Oct 2025 22:48:53 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6] virtio-net: fix received length check in big
 packets
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251028143116.4532-1-minhquangbui99@gmail.com>
 <20251028104041-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20251028104041-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/25 21:41, Michael S. Tsirkin wrote:
> On Tue, Oct 28, 2025 at 09:31:16PM +0700, Bui Quang Minh wrote:
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
>> Changes in v6:
>> - Fix the length check
>> - Link to v5: https://lore.kernel.org/netdev/20251024150649.22906-1-minhquangbui99@gmail.com/
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
>> index a757cbcab87f..461ad1019c37 100644
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
> you mean "the size allocated in add_recvbuf_big"

Sorry, but they feels the same to me. But I'll fix it if it is clearer.

>
>> +	 */
>> +	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
>> +		pr_debug("%s: rx error: len %u exceeds allocate size %lu\n",
>
> allocated?

I'll fix it.

Thanks,
Quang Minh.

>
>> +			 dev->name, len,
>> +			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
>> +		goto err;
>> +	}
>>   
>> +	skb = page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
>>   	u64_stats_add(&stats->bytes, len - vi->hdr_len);
>>   	if (unlikely(!skb))
>>   		goto err;
>> -- 
>> 2.43.0


