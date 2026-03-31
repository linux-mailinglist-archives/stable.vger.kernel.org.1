Return-Path: <stable+bounces-231437-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBS/EPHcy2lHMAYAu9opvQ
	(envelope-from <stable+bounces-231437-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:40:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9945A36B172
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F243E3019B88
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 14:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65F53FD153;
	Tue, 31 Mar 2026 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Umnn0F+T";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghtyVj9+"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE5D3FBEB2
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967950; cv=none; b=bhq7aswAI8ldvOG51aOpPPii2J7mckOe01c4X3F6XNwdroaEU04CtUypLFC62FUkmC1e6U5phwgdU633HH1kqQIz4Ztcem40Mv5Lr4zM4KTTDHXDjWavHPNxUZ5P8z/4japz1ZIDFduJjnFEogx4temJ79k0b4/0oPADghfgKYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967950; c=relaxed/simple;
	bh=GMrCPecVJzvTJhOOu1MZMFhbqWBNWNi0pDSzmWI0JSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WURhDPAQn7htWl0T+wkQjqhXBC0l/ztqEEJP6x+btdgGXWhynopO5wqSk4adaIBQydBzmzLlxysW11cdPqmMZ+LUNvueczQe4bEtlDmrasbKNkFFxpcVG9fQWEhAY+BKvKN/Untk8CTDEmI0LyBLOngmwiFRg4QHWM6ntg/CEtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Umnn0F+T; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ghtyVj9+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774967948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPCR3PMvQkWFspGuikt51070xkjVMXE9QsAUDQr8XCM=;
	b=Umnn0F+TKhZiRRzva+GfGhHrZH2QjsSmja5QYpBYWwDlKcmsDMSCtmsGQmQtk6W4vUvhIN
	OAdovxii0+KW0Km6RkscAVNF7tGVyq1eFnTwXBb9DoCIzPOTzZQmnkNSW8UKwufDd2U/VF
	ONR5gmpAiuUFSMMZf4BVNHjvPv2DaN8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-0U4jpJhsO3KVn1j3InEzaA-1; Tue, 31 Mar 2026 10:39:07 -0400
X-MC-Unique: 0U4jpJhsO3KVn1j3InEzaA-1
X-Mimecast-MFC-AGG-ID: 0U4jpJhsO3KVn1j3InEzaA_1774967946
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-486fe36cf73so41315995e9.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774967946; x=1775572746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tPCR3PMvQkWFspGuikt51070xkjVMXE9QsAUDQr8XCM=;
        b=ghtyVj9+qcLpBzaYn5NrbRlA+y+Gt/S9UZgb0EpdS8cgYRotJVNCl5zSbt/xbzC8YQ
         uxicJtlGf74mok+E0QBFt6g8CCiX5sfVwfnfxW8wCEQEuLplHekqZQ79D1+SeUeFhvXu
         X8BR//TiBSk5xUWf/pPb5f4rowCIz/7FYtl/4DLSs/QNO/+xFTOmmml6Ci0wdX1lVrf5
         y9PZ7ZY0ISld1vW3YIlKK9YTh5qy+BaXvoX04kRx9XNuM5XnqXtKFm+o4Jp41Ymak7Kg
         kywJyR9zFE+G63ljT5bpKBenYABXm1VO988qzdOUFjkM7IuEzDcUet0UdfABFvmrzF03
         eiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774967946; x=1775572746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tPCR3PMvQkWFspGuikt51070xkjVMXE9QsAUDQr8XCM=;
        b=HpYg+Dzlk9pEbkAnvZOC1VINfhA8j7YuCB6YqR0PIH4z2we4vrWVQX1CKmJzZaVPxg
         TLYlM5rsZ9aL2yFjY/aJt4R1C59KA9WUoVrzT2VClb5opdisbFc4ke4ivERYz+KklOc6
         y6Qd4SSkaXjeEJpkW1V09jkSpQ7MxqSCTUEtNtJLn/GOiRj7Jr5SJ1/KTaWSkUMFT+SH
         vf+gUqhr7PuYaqh/lPbx88yGiq40vXeZW1bzO8ktxqpcsZkc+UNzPANAKXotiQujjwNP
         2CE7Yhb9GO2W9+UMdDnHOmyJykEgw4G6jd0xe0Pvz6iYCAD8zYmDa/zDn0A+QyzC1a1I
         HELg==
X-Forwarded-Encrypted: i=1; AJvYcCUj+Edx1VJkeEDbjWdKz/3keLRgs8YrjDtJL3R7xbwR0KDMf3uAIJP3rNX0belHLRaEuguNxQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza6AyNkmKA2nzXiwkqZ6FopZN5tAocCxX2J8w16vHS/pTxTWlW
	6N0/Bz4LGCf3D47k8fVbVxN4fH89Gz+F4LZ8VA0o0vhyOiasONXs5dpZOsYvMQPAvBnZamq0zFT
	PYqEex5b3XcG2LqZVoG48es4khbAaO/bmjldojL4BsyaXcmSFOPWVj2NHUA==
X-Gm-Gg: ATEYQzw5ufmUfHw2qgBXRGIZT3MQsK5VkmJfoHWX7eW1JlSHOyNiVh/5DYK+hW3h2M8
	I17qUkchetirM1UHO+wXLWPC7ncYdzyMAPL0sWH+jPjqFCwkRCtKu+VZ7j426LLXLjDZ8Z5wfeO
	m4z2t4sBiV2cySdbbcotTkKZmizoG54VEFP88J/ngUvOkRK1RKKHpp54ZmrqPS7tfgVIMpx0giP
	G+nCpbbMaPutSt3EcNHxf8mVBdDmPEZDP3nv0kC98E7au9JgMcacK6zjPOT2AWyJCQEl6tVdWAQ
	SkeZHWkLZ4Aw20QFONsVk59uQiJ2lHediJITwJ63PLpcPxfVUMDVLuxG+aL5ni3l1wh69dQWC/3
	v5lFcE9p1okHNIHS9Lb73eDDZQs/mJ7TFixqq2dgyKXpUkFPgEPP5S10k
X-Received: by 2002:a05:600c:4744:b0:485:4278:2558 with SMTP id 5b1f17b1804b1-48727d5a313mr286613215e9.6.1774967945552;
        Tue, 31 Mar 2026 07:39:05 -0700 (PDT)
X-Received: by 2002:a05:600c:4744:b0:485:4278:2558 with SMTP id 5b1f17b1804b1-48727d5a313mr286612585e9.6.1774967945001;
        Tue, 31 Mar 2026 07:39:05 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e265fsm28987415f8f.1.2026.03.31.07.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 07:39:04 -0700 (PDT)
Message-ID: <68ca0a8c-27f9-45f1-94cc-7e3c7936181f@redhat.com>
Date: Tue, 31 Mar 2026 16:39:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH net,v5] virtio_net: clamp rss_max_key_size
 to NETDEV_RSS_KEY_LEN
To: Srujana Challa <schalla@marvell.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
 Shiva Shankar Kommula <kshankar@marvell.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260326142344.1171317-1-schalla@marvell.com>
 <ba027306-e5e0-4d4d-8357-f6080441167d@redhat.com>
 <CH3PR18MB6379D39BA068565667CF2B06A053A@CH3PR18MB6379.namprd18.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CH3PR18MB6379D39BA068565667CF2B06A053A@CH3PR18MB6379.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-231437-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Queue-Id: 9945A36B172
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 3:29 PM, Srujana Challa wrote:
>> On 3/26/26 3:23 PM, Srujana Challa wrote:
>>> rss_max_key_size in the virtio spec is the maximum key size supported
>>> by the device, not a mandatory size the driver must use. Also the
>>> value 40 is a spec minimum, not a spec maximum.
>>>
>>> The current code rejects RSS and can fail probe when the device
>>> reports a larger rss_max_key_size than the driver buffer limit.
>>> Instead, clamp the effective key length to min(device
>>> rss_max_key_size, NETDEV_RSS_KEY_LEN) and keep RSS enabled.
>>>
>>> This keeps probe working on devices that advertise larger maximum key
>>> sizes while respecting the netdev RSS key buffer size limit.
>>>
>>> Fixes: 3f7d9c1964fc ("virtio_net: Add hash_key_length check")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Srujana Challa <schalla@marvell.com>
>>> ---
>>> v3:
>>> - Moved RSS key validation checks to virtnet_validate.
>>> - Add fixes: tag and CC -stable
>>> v4:
>>> - Use NETDEV_RSS_KEY_LEN instead of type_max for the maximum rss key
>> size.
>>> v5:
>>> - Interpret rss_max_key_size as a maximum and clamp it to
>> NETDEV_RSS_KEY_LEN.
>>> - Do not disable RSS/HASH_REPORT when device rss_max_key_size exceeds
>> NETDEV_RSS_KEY_LEN.
>>> - Drop the separate patch that replaced the runtime check with
>> BUILD_BUG_ON.
>>>
>>>  drivers/net/virtio_net.c | 20 +++++++++-----------
>>>  1 file changed, 9 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
>>> 022f60728721..b241c8dbb4e1 100644
>>> --- a/drivers/net/virtio_net.c
>>> +++ b/drivers/net/virtio_net.c
>>> @@ -373,8 +373,6 @@ struct receive_queue {
>>>  	struct xdp_buff **xsk_buffs;
>>>  };
>>>
>>> -#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
>>> -
>>>  /* Control VQ buffers: protected by the rtnl lock */  struct
>>> control_buf {
>>>  	struct virtio_net_ctrl_hdr hdr;
>>> @@ -478,7 +476,7 @@ struct virtnet_info {
>>>
>>>  	/* Must be last as it ends in a flexible-array member. */
>>>  	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer,
>> hash_key_data,
>>> -		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
>>> +		u8 rss_hash_key_data[NETDEV_RSS_KEY_LEN];
>>>  	);
>>>  };
>>>  static_assert(offsetof(struct virtnet_info,
>>> rss_trailer.hash_key_data) == @@ -6717,6 +6715,7 @@ static int
>> virtnet_probe(struct virtio_device *vdev)
>>>  	struct virtnet_info *vi;
>>>  	u16 max_queue_pairs;
>>>  	int mtu = 0;
>>> +	u16 key_sz;
>>>
>>>  	/* Find if host supports multiqueue/rss virtio_net device */
>>>  	max_queue_pairs = 1;
>>> @@ -6851,14 +6850,13 @@ static int virtnet_probe(struct virtio_device
>> *vdev)
>>>  	}
>>>
>>>  	if (vi->has_rss || vi->has_rss_hash_report) {
>>> -		vi->rss_key_size =
>>> -			virtio_cread8(vdev, offsetof(struct virtio_net_config,
>> rss_max_key_size));
>>> -		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
>>> -			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds
>> the limit %u.\n",
>>> -				vi->rss_key_size,
>> VIRTIO_NET_RSS_MAX_KEY_SIZE);
>>> -			err = -EINVAL;
>>> -			goto free;
>>> -		}
>>> +		key_sz = virtio_cread8(vdev, offsetof(struct virtio_net_config,
>>> +rss_max_key_size));
>>> +
>>> +		vi->rss_key_size = min_t(u16, key_sz, NETDEV_RSS_KEY_LEN);
>>> +		if (key_sz > vi->rss_key_size)
>>> +			dev_warn(&vdev->dev,
>>> +				 "rss_max_key_size=%u exceeds driver limit
>> %u, clamping\n",
>>> +				 key_sz, vi->rss_key_size);
>>
>> NETDEV_RSS_KEY_LEN is 256 and virtio_cread8() returns a u8. The check is
>> not needed, and the warning will never be printed. I think that the
>> BUILD_BUG_ON() you used in v4 would be better than the above chunk.
>>
> Thank you for the feedback. In net-next, NETDEV_RSS_KEY_LEN is 256. This fix is
> also intended for stable kernels, where NETDEV_RSS_KEY_LEN is 52, and
> I added the message to make clamping visible in that case.
> I will remove the check and send the next version.  

I'm sorry, I haven't looked at the historical context when I wrote my
previous reply.

IMHO the additional check does not make sense in the current net tree.
On the flip side stable trees will need it. I suggest:

- dropping the check for the 'net' patch
- also dropping CC: stable tag
- explicitly sending to stable the fix variant including the size check.

@Michael: WDYT?

/P


