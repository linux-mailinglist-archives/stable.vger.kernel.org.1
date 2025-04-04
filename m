Return-Path: <stable+bounces-128339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B28AA7C1C0
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 18:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C152189DB58
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 16:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BF820D4E4;
	Fri,  4 Apr 2025 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4/gF7VX"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DB91D5CC4
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743785355; cv=none; b=GfUUke9cM38xhUzC7kYhsyMpoFDD1woeyGjaX4CfM78Dmjjjxs3UhwZRxU4cfHqkfGzW4fu3wnI7nj5LV9VlKZMLI52Q4RkGnQQhtE7ltVn4SLHE+m/CF2riZF8QjThvV5LvxrdSuhsHVm+gFVjd5BXkThSFVRCEQbaCtRNaIEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743785355; c=relaxed/simple;
	bh=PYNaU9lNwh0QL80kukIz0Ezcn5YI0WJC/oBVbZDs7CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkoTqnCinqoT4ThWjWafBBMvmkObCtoaqmXkJ3ErgIYuWMNDjF9Kw8MQ3CyiEZjmf70Oa77whYaK4kBC/8JX87Y+TqqUfbLFn7x/MW8pmllFhyYpHNsb2aA2r0tpImFaDpuZEzIQYTflx+fKYOiQBbLbsFkCzJOFSVzQoO233yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D4/gF7VX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743785352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UOZ43bBKMC//JtK0X3dZk7WsbqEz50U4BfU4WlfUSoc=;
	b=D4/gF7VX7dDqVEimYewPi3q8vFjXW+uF5R8aFFBPFkwG2XgYod9coX2yT4Sd+kZKvrFePN
	4ipazGwQum2M3TBu4ckAJ7+vBtQ17IDVvbB0eh7AKUV7T0SsUExnKBGgG29wfd9mszy/7x
	FA25GGI68fXwicCFmleadViAKEuudgw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-pPjdxC4TNJCTVguDkQmgFw-1; Fri, 04 Apr 2025 12:49:10 -0400
X-MC-Unique: pPjdxC4TNJCTVguDkQmgFw-1
X-Mimecast-MFC-AGG-ID: pPjdxC4TNJCTVguDkQmgFw_1743785349
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf327e9a2so18994155e9.3
        for <Stable@vger.kernel.org>; Fri, 04 Apr 2025 09:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743785349; x=1744390149;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOZ43bBKMC//JtK0X3dZk7WsbqEz50U4BfU4WlfUSoc=;
        b=JQA9VAigRYberBAR44VXRODXy5sWfyAe5I9oZgVeQoiYAPB+TM9C4/x22RoD1fgtUx
         xEaqHzDtrLK77xlxyT95PBoCaF4HDieSNMpwLE9sXJIUNbGitcRsG7b42X31qZHWg6Rj
         cZPfY+HNP0esXVca5fXdp1rHqGZCBn2H3Wg+4DehfQ9+I6TCOcf/hNOteJObHl8cGW6s
         lkmpy3019PyXdMPglB+4aAJVMu1QMhJB0voZqhBJRYZep2iSd/1k8LEup+tdvUb6x9dC
         x9HJ3JiHxEGQ42MEX9u05i5aRGUeD4v5ZRlEk8gnzEzo5ZMf/kWDqLCwjcBs9NVntff6
         Fnvw==
X-Forwarded-Encrypted: i=1; AJvYcCUXt7ez3PRmKB2zKJPQVJ60P9sHLv5BU7iF0Peyy0zrxNLerkahgZbMgMAWz41Shzu9QpIsIqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt1KRrTSzlypjtROnprq++rhYeh8gEzw+I0wsvGDScQ6AFXo3i
	WiXkIZFdsGXX5yXuYRCmyLJd4Qq+tpkWGhAAztT7+3uFA4w7whXyScmEDlzWlinFFFplJ2QnoPz
	GDLqkU0SChpPwjSUVlMVK9wvrYxfuoYanBTkqXcxw6eHuQPMJ8L9u8g==
X-Gm-Gg: ASbGncuO9H7kRYUWmEXiR7J5vBKRcPW/CtnRM+tqzeiZQSayny2nxECH38bh6WbQ9OO
	piy75fkTrnW2CgvFZn/Itg0WXchQX/maO5j0Vxy1GyrcEXaY3fQXmKbXI7dSxHpWVMFTHc3Hv/9
	Ynd4exXwVQSlgRz6/LScuPSA0Fa/La7amCxXsrlk3tVDyhb2ODrUW43sjp3Ml1hPexPPDq6aOpw
	jScJq6WNfnadk9ZZj0ADD4s+nVUz67Ts17vWiAFC+MJAxImMDO6bRi3m6zlp0pB58iLDTJXv9Gb
	xkFZ78fOGw9v8RaF5/HT3OP0qCNWp/NZshIOyK2N+Ez2WuY15kAJCr0g4tMLPx438c/osRGFs2z
	Kcmi7qoIT/G/MOWJqp11/r6ILzJUuVezCe0mthal+lxc=
X-Received: by 2002:a05:600c:5117:b0:43d:40b0:5b with SMTP id 5b1f17b1804b1-43ee076924bmr1492165e9.25.1743785349435;
        Fri, 04 Apr 2025 09:49:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1GRfHkFTJWrFhSjeHpBspaUl1rM/3LxWWUNyF4GOrAnX6k7onjQMMhVScWt01nnZ/ucUY1Q==
X-Received: by 2002:a05:600c:5117:b0:43d:40b0:5b with SMTP id 5b1f17b1804b1-43ee076924bmr1491965e9.25.1743785349001;
        Fri, 04 Apr 2025 09:49:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71b:7900:8752:fae3:f9c9:a07e? (p200300cbc71b79008752fae3f9c9a07e.dip0.t-ipconnect.de. [2003:cb:c71b:7900:8752:fae3:f9c9:a07e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1794e94sm54808185e9.31.2025.04.04.09.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 09:49:08 -0700 (PDT)
Message-ID: <b30a0ff7-e885-462d-92d4-53f15accd1c0@redhat.com>
Date: Fri, 4 Apr 2025 18:49:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
Content-Language: en-US
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 Chandra Merla <cmerla@redhat.com>, Stable@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>
References: <20250402203621.940090-1-david@redhat.com>
 <20250403161836.7fe9fea5.pasic@linux.ibm.com>
 <e2936e2f-022c-44ee-bb04-f07045ee2114@redhat.com>
 <20250404063619.0fa60a41.pasic@linux.ibm.com>
 <4a33daa3-7415-411e-a491-07635e3cfdc4@redhat.com>
 <d54fbf56-b462-4eea-a86e-3a0defb6298b@redhat.com>
 <20250404153620.04d2df05.pasic@linux.ibm.com>
 <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>
 <20250404160025.3ab56f60.pasic@linux.ibm.com>
 <6f548b8b-8c6e-4221-a5d5-8e7a9013f9c3@redhat.com>
 <20250404173910.6581706a.pasic@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250404173910.6581706a.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.04.25 17:39, Halil Pasic wrote:
> On Fri, 4 Apr 2025 16:17:14 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>>> It is offered. And this is precisely why I'm so keen on having a
>>> precise wording here.
>>
>> Yes, me too. The current phrasing in the spec is not clear.
>>
>> Linux similarly checks
>> virtio_has_feature()->virtio_check_driver_offered_feature().
> 
> Careful, that is a *driver* offered and not a *device* offered!

Right, I was pointing at the usage of the term "offered". 
virtio_check_driver_offered_feature(). (but was also confused about that 
function)

virtio_has_feature() is clearer: "helper to determine if this device has 
this feature."

The way it's currently implemented is that it's essentially "device has 
this feature and we know about it (->feature_table)"

> 
> We basically mandate that one can only check for a feature F with
> virtio_has_feature() such that it is either in drv->feature_table or in
> drv->feature_table_legacy.
> 
> AFAICT *device_features* obtained via dev->config->get_features(dev)
> isn't even saved but is only used for binary and-ing it with the
> driver_features to obtain the negotiated features.
> 
> That basically means that if I was, for the sake of fun do
> 
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -1197,7 +1197,6 @@ static unsigned int features[] = {
>          VIRTIO_BALLOON_F_MUST_TELL_HOST,
>          VIRTIO_BALLOON_F_STATS_VQ,
>          VIRTIO_BALLOON_F_DEFLATE_ON_OOM,
> -       VIRTIO_BALLOON_F_FREE_PAGE_HINT,
>          VIRTIO_BALLOON_F_PAGE_POISON,
>          VIRTIO_BALLOON_F_REPORTING,
>   };
> 
> I would end up with virtio_check_driver_offered_feature() calling
> BUG().
> 

Right.

> That basically means that Linux mandates implementing all previous
> features regardless whether does are supposed to be optional ones or
> not. Namely if you put the feature into drv->feature_table it will
> get negotiated.
> 
> Which is not nice IMHO.

I think the validate() callbacks allows for fixing that up.

Like us unconditionally clearing VIRTIO_F_ACCESS_PLATFORM (I know, 
that's a transport feature and a bit different for this reason).

... not that I think the current way of achieving that is nice :)

> 
>>
>>>
>>> Usually for compatibility one needs negotiated. Because the feature
>>> negotiation is mostly about compatibility. I.e. the driver should be
>>> able to say, hey I don't know about that feature, and get compatible
>>> behavior. If for example VIRTIO_BALLOON_F_FREE_PAGE_HINT and
>>> VIRTIO_BALLOON_F_PAGE_REPORTING are both offered but only
>>> VIRTIO_BALLOON_F_PAGE_REPORTING is negotiated. That would make
>>> reporting_vq jump to +1 compared to the case where
>>> VIRTIO_BALLOON_F_FREE_PAGE_HINT is not offered. Which is IMHO no
>>> good, because for the features that the driver is going to reject in
>>> most of the cases it should not matter if it was offered or not.
>>
>> Yes. The key part is that we may only add new features to the tail of
>> our feature list; maybe we should document that as well.
>>
>> I agree that a driver that implements VIRTIO_BALLOON_F_PAGE_REPORTING
>> *must* be aware that VIRTIO_BALLOON_F_FREE_PAGE_HINT exists. So queue
>> existence is not about feature negotiation but about features being
>> offered from the device.
>>
>> ... which is a bit the same behavior as with fixed-assigned numbers a
>> bit. VIRTIO_BALLOON_F_PAGE_REPORTING was documented as "4" because
>> VIRTIO_BALLOON_F_FREE_PAGE_HINT was documented to be "3" -- IOW, it
>> already existed in the spec.
> 
> I don't agree with the comparison.  One obviously needs to avoid fatal
> collisions when extending the spec, and has to consider prior art.

Agreed. But IMHO it's similar to two out-of-spec driver starting to use 
"queue index 5" in a fix-assigned world. It cannot work.

> 
> But ideally not implemented  or fenced optional features A should have no
> impact to implemented optional or not optional features B -- unless the
> features are actually interdependent, but then the spec would prohibit
> the combo of having B but not A. And IMHO exactly this would have been
> the advantage of fixed-assigned numbers: you may not care if the other
> queueues exist or not.
> 
> Also like cloud-hypervisor has decided that they are going only to
> support VIRTIO_BALLOON_F_REPORTING some weird OS could in theory
> decide that they only care about VIRTIO_BALLOON_F_REPORTING. In that
> setting having to look at VIRTIO_BALLOON_F_STATS_VQ and
> VIRTIO_BALLOON_F_FREE_PAGE_HINT are offered is weird. But that is all water
> under the bridge. We have to respect what is out there in the field.

Yes, they would have to do the math based on offered features. 
Definitely not nice, but as you say, that ship has sailed.

[...]

>>
>> (as Linux supports all these features, it's easy. A driver that only
>> supports some features has to calculate the queue index manually based
>> on the offered features)
> 
> As I've tried to explain above, not implementing/accepting optional
> features and then implementing/accepting a newer feature is problematic
> with the current code. Supporting some features would work only as
> supporting all features up to X.

See above regarding validate().

Again, doesn't win a beauty contest ... I'll send an improved 
virtio-spec update next week, thanks!

-- 
Cheers,

David / dhildenb


