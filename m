Return-Path: <stable+bounces-128341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3022A7C298
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 19:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E541B61241
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 17:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27F7220696;
	Fri,  4 Apr 2025 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVUkFl+B"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771B921930D
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743788197; cv=none; b=sYNOrEt3ENX01bIZ552SGZGGGyBSIqYXNuz6Txl+8ibOVumzDRcoYv6WhfT6RZGGKxWoJ/TPaJCpeF0pihsniDkRbpw6Q+latXN2cx8GrFBMF1APaxc23ubBur2dzwpF6CfSVX5KPfYiFHQZ0udd2wW5gsjzWW5NFJEwWF+C4Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743788197; c=relaxed/simple;
	bh=yunu/rgX6xlai49HhM2W0+0A+BpWAImHxQ/t3MoXx9U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UHJezMw+rOQVlUdAZWRqW+MRUJ441x29lxTk5bLToP0rlusyWbjfX0J5+z5Tk10Y2uHf6XOt9fEZ354QNEtOODvqIML5uTHtP/C860ztyTa2sSrRb4f0tLrPdcsoSJ2id8iP0Us6Q9O47fOkNjgQ2naGliUdcC7k5mAQ42YgTKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BVUkFl+B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743788194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=R4340KJrzxwLVivTpxZjpQyM7QjWjGmIJMe5TfbBu9c=;
	b=BVUkFl+B0pLxlo8GrG9GaMvBf+Mb3CbOly+0QVhOgyQssmwJGjxrU1BW1DnBTXypmhmWrI
	IQ5lqh5nqtzb3ZX8B5C4vrjNlaJnYS1WcMwoJaqu/sSRSaIZBAh9vAM6KY43qSUkA3rZAQ
	94K0bZcEjGbSOa4B2H1g6uCXBTmVk+I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-6xdQnAHgNQeh_xGrO8ESXw-1; Fri, 04 Apr 2025 13:36:33 -0400
X-MC-Unique: 6xdQnAHgNQeh_xGrO8ESXw-1
X-Mimecast-MFC-AGG-ID: 6xdQnAHgNQeh_xGrO8ESXw_1743788192
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d51bd9b41so19440675e9.3
        for <Stable@vger.kernel.org>; Fri, 04 Apr 2025 10:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743788192; x=1744392992;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R4340KJrzxwLVivTpxZjpQyM7QjWjGmIJMe5TfbBu9c=;
        b=h3l2XN5y6vyja7TxoHqRYCvoQdeyrfFRReW5p1JqN2uaqGGAZOpOKFvmR99s0hmatL
         6p84JAbYt+URk4Kf29RIlFC+Kv/wdx8etkrXH9fWYhuS1tu7gIDC3uJATQ67u3FNQklA
         6uqCu5kjMPkuvRA3CeO1X7j9rT3L88WcEpfSIxEYJsGVa8CEX+bCfM3JF7mYOxdjdfPD
         +wxi56WR33JLaASDSoGptfEctZfsgdhUhx8fJadByXSStpI0Mk74Lv86MfMmGYQfWYqS
         LgWI9ffjqNBa2z9N2sTOZjuHUwkLRJ7RnByQM0qLKU317Cf38q2iPzyiGtisrkAZEGH7
         eoIA==
X-Forwarded-Encrypted: i=1; AJvYcCUNLn8RKzUlwYKixXahmJnknZRWtEWJz0txTmsv1qbuOhdMxUC22hIKOcGUI1v9WLqCNRdHrws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxERmPfJ+yfzyPkEwFjqhmfBvzR7Lj+4xWPUIuQphrZWA+n+VV
	UNTHqGlq14vm9OcBTDDsCv23UFC7qmI5ag7IjLqSlD+/dE3DsuyguksCa6jJcO/H+8dACMBFQCy
	f1OmnX9gXMkxS72PBR4btnVDMRBvsOYfcJl2HgNE0YqRK/sWW/oBi3A==
X-Gm-Gg: ASbGnctepT3dIpxStze1JDA1ZCIG1vQtFHsM9CL142rJqHa9c4aszwc8cfW103U1BID
	r1gBrq2DVz+MJas6hHQw6SJ3w5nYGBWpNQEGHYwN0vxBVXnKYWP3wARoLmFomVfnGC6rYTIR62/
	g6UmgHf+1WKJHIfaoR+338UTn48hD7EcXqLnK/ZiVIg3dN8p0yy6pd4kb9Je1DyJj4sm3xgPPIw
	AR17JpCBm7Cng94ioVcBy9veJBmrddw2i5HxsEMfQV3IKQzxHOnCxcyiGnDgpgtNcyIF9FjT0wv
	ghPFmKY4POpOU3C/KMCLCVHNQlwLoe2x368brPffeIYp4s5+hvebYfUniCfgeONlky8lg2ohCkQ
	/00y4FNCF6M35VmUwYFThrmGChCuTWA1DT/yIrkoB7qc=
X-Received: by 2002:a05:600c:698c:b0:43c:fa0e:471a with SMTP id 5b1f17b1804b1-43ed6615862mr29577985e9.5.1743788192102;
        Fri, 04 Apr 2025 10:36:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETLcrbSlwBwxMnCyQo7ltsVM/FnStajCig+iEbNMtIKS+v6wnVbq4bZ0Gr1gVoSX8E8MsR+w==
X-Received: by 2002:a05:600c:698c:b0:43c:fa0e:471a with SMTP id 5b1f17b1804b1-43ed6615862mr29577735e9.5.1743788191756;
        Fri, 04 Apr 2025 10:36:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71b:7900:8752:fae3:f9c9:a07e? (p200300cbc71b79008752fae3f9c9a07e.dip0.t-ipconnect.de. [2003:cb:c71b:7900:8752:fae3:f9c9:a07e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1795081sm55936625e9.27.2025.04.04.10.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 10:36:30 -0700 (PDT)
Message-ID: <608773a9-535f-4f0c-aa0e-426dccb8ca0c@redhat.com>
Date: Fri, 4 Apr 2025 19:36:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
From: David Hildenbrand <david@redhat.com>
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
 <b30a0ff7-e885-462d-92d4-53f15accd1c0@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b30a0ff7-e885-462d-92d4-53f15accd1c0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.04.25 18:49, David Hildenbrand wrote:
> On 04.04.25 17:39, Halil Pasic wrote:
>> On Fri, 4 Apr 2025 16:17:14 +0200
>> David Hildenbrand <david@redhat.com> wrote:
>>
>>>> It is offered. And this is precisely why I'm so keen on having a
>>>> precise wording here.
>>>
>>> Yes, me too. The current phrasing in the spec is not clear.
>>>
>>> Linux similarly checks
>>> virtio_has_feature()->virtio_check_driver_offered_feature().
>>
>> Careful, that is a *driver* offered and not a *device* offered!
> 
> Right, I was pointing at the usage of the term "offered".
> virtio_check_driver_offered_feature(). (but was also confused about that
> function)
> 
> virtio_has_feature() is clearer: "helper to determine if this device has
> this feature."
> 
> The way it's currently implemented is that it's essentially "device has
> this feature and we know about it (->feature_table)"
> 
>>
>> We basically mandate that one can only check for a feature F with
>> virtio_has_feature() such that it is either in drv->feature_table or in
>> drv->feature_table_legacy.
>>
>> AFAICT *device_features* obtained via dev->config->get_features(dev)
>> isn't even saved but is only used for binary and-ing it with the
>> driver_features to obtain the negotiated features.
>>
>> That basically means that if I was, for the sake of fun do
>>
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -1197,7 +1197,6 @@ static unsigned int features[] = {
>>           VIRTIO_BALLOON_F_MUST_TELL_HOST,
>>           VIRTIO_BALLOON_F_STATS_VQ,
>>           VIRTIO_BALLOON_F_DEFLATE_ON_OOM,
>> -       VIRTIO_BALLOON_F_FREE_PAGE_HINT,
>>           VIRTIO_BALLOON_F_PAGE_POISON,
>>           VIRTIO_BALLOON_F_REPORTING,
>>    };
>>
>> I would end up with virtio_check_driver_offered_feature() calling
>> BUG().
>>
> 
> Right.
> 
>> That basically means that Linux mandates implementing all previous
>> features regardless whether does are supposed to be optional ones or
>> not. Namely if you put the feature into drv->feature_table it will
>> get negotiated.
>>
>> Which is not nice IMHO.
> 
> I think the validate() callbacks allows for fixing that up.
> 
> Like us unconditionally clearing VIRTIO_F_ACCESS_PLATFORM (I know,
> that's a transport feature and a bit different for this reason).
> 
> ... not that I think the current way of achieving that is nice :)

Thinking again, that won't work, because it would also make 
virtio_has_feature() say that the device does not have that feature.

So yeah, virtio_has_feature() is confusing and the documentation does 
not quite match.

Would need a change/cleanup to handle such features that we don't 
implement but still want to check if they are offered.

-- 
Cheers,

David / dhildenb


