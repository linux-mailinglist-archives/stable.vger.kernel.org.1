Return-Path: <stable+bounces-128534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF14A7DEE5
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 15:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A636E16F6B3
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 13:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B17253F15;
	Mon,  7 Apr 2025 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LvSKfWGW"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BA1253B5D
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031871; cv=none; b=jnwiNucC21exiP6K7XLu+D9pOnZ2MTZUWkessY91yQzyu34kOh4DnmvtBZzoguc1yR7qVnd0aHy4d8Lf9VLl93WVwQbXYH6ROAyUQcaeEmNQYTSJGd/8+82BFza1qpI+kXDGNBnbwpX2GSQLHTKLRAVsEFUa+U/6d9OXXWV8ZqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031871; c=relaxed/simple;
	bh=S4DZHGQjVJb+4A4qFaXbHEcAUW8Cb8hEE4RunNXnZPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ix195Ajd9y/6nK1inmer0tRbemx6OWmcOafzWjXToyrKpFn0Ae+i9oEoHL8ul6M6nzHRkTolEhrAlIfbxzBZuDcTRDcuF071U1ggjx4LEd4sB2iGXQ0fZ4JN2VCOTRBGx4LnI0tzCo23aBdl31o2Cw1tk33OMXy2gZ+Lv3/Qgjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LvSKfWGW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744031868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BDwPW9pE1ppSBFgbdeMQcAvVIbhGoy40D70IGcXEs5w=;
	b=LvSKfWGWChZkCfC4i4BQUJH3+XgrjVcGn5Q5+aWsHqEwvwOPCsURfIAVjngRIZptwyzXlN
	SXTGH1Ri/CSubdQdtheEDlU+Pu9/qsaV5CU4yr8Eu1hUtki9aAewC0erG4YQSZeEYkVw5M
	3kuZ/Wrn4x8migq/snVHkGr11KebBGc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-Ur1Z8q5CPl6x4gJj8RjT2A-1; Mon, 07 Apr 2025 09:17:47 -0400
X-MC-Unique: Ur1Z8q5CPl6x4gJj8RjT2A-1
X-Mimecast-MFC-AGG-ID: Ur1Z8q5CPl6x4gJj8RjT2A_1744031866
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so38259575e9.1
        for <Stable@vger.kernel.org>; Mon, 07 Apr 2025 06:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744031866; x=1744636666;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BDwPW9pE1ppSBFgbdeMQcAvVIbhGoy40D70IGcXEs5w=;
        b=Pb1S0qKNjt1CZPk9sjPwfv8Q/TfKKfw7owWO6XFvHaDX1ge+6a/8scJaQJ24IEFCeh
         R9vobeSnRD+pCyVzug+9mAIlEcaegpfPiVL3QvybVGQKt4Al7e+ButM4T8XAV0SXwyYH
         djg1jDdzr7iSmCbNAKyy1Mwy7/gHCduqf8lSQEkazE7fgc6OhmYGt+a9Cw9ERUE48uqF
         oESowxObYpuAZj5uqEs3NfhxCIqRydUdqmWWul61AmfpERsW6rpl4HzOHWLjwh7eQquy
         E1T797jiT7/pklK9G0bXmzOzUZG+Ucoegh72Qyhr4LLTCS4neI1krAExJQxdQihQMYOq
         mU8g==
X-Forwarded-Encrypted: i=1; AJvYcCVXeyHcV6z6PGkN3fxDWdjdmjC2Ci04z9o9AcJ3C4eSr8ovrRqOr4RsiF+LbcQtgBlOSPy6bi4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw50PvU031FQNEkQxlRcw4AD7bx6FHa00JC42DNUaT17csdet7F
	kKuzWoy4Hw2GpTAHbbUCDS0eOsnx9Vu3NN49TYPVqcEdA2jkbqxTfW1GxZ49PPytngAaMlG9aMR
	TnVI5aczAuR37qwbkxEQx0jfKeLfQsaFi2yKXwZ4WVvjuCrxxmK19Cg==
X-Gm-Gg: ASbGncs71z7tgIjaLTOVfPE9ZJl+YFnqXvNuoTaOmJiivYiSSHlx3oiQb3uF0W3ZzrI
	W1BHXr2oQocB/LVjW/hd84ZJqNhnMa4b+ivjLn1tVYPNMvSHcU6+RyGgBuZYdNf8ORz5J/B7YF5
	ftPEpbfLL4RhFUqj/0DE4BOGkanZO/7CMouOnjYNC/JSAcV3MOhtQTeONV9lm8pzM1D488jj+tN
	5+w6iutlKLw8dS+bGGJjnpprcnvTP5Cgr0vvax5zR4VYa2J/uCkoED7M+BPqE0retFaLoAD+qMg
	iBLKdm3TA/9SvzMpvBRRumd9BxmMVV0mkVsdz2Gml2xauMYAjw5MHH2vSjWkcm94xNBfJau/BFU
	+7KQibz4OFyoJRmHXu8izpxVwGiqgNZcoURVloncW8Ow=
X-Received: by 2002:a05:600c:1d88:b0:43c:ea40:ae4a with SMTP id 5b1f17b1804b1-43ee0783f84mr91002405e9.31.1744031866255;
        Mon, 07 Apr 2025 06:17:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJDoHH+S74Q3s4YfYRMtY1QKAiLrupUYEmKs8h7WdQfIUm62OfLdBHe1bCgK7GIfw3yihrvQ==
X-Received: by 2002:a05:600c:1d88:b0:43c:ea40:ae4a with SMTP id 5b1f17b1804b1-43ee0783f84mr91002085e9.31.1744031865876;
        Mon, 07 Apr 2025 06:17:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c738:3c00:8b01:4fd9:b833:e1e9? (p200300cbc7383c008b014fd9b833e1e9.dip0.t-ipconnect.de. [2003:cb:c738:3c00:8b01:4fd9:b833:e1e9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec366a88csm127570905e9.37.2025.04.07.06.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 06:17:45 -0700 (PDT)
Message-ID: <9126bfbf-9461-4959-bd38-1d7bc36d7701@redhat.com>
Date: Mon, 7 Apr 2025 15:17:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
To: Halil Pasic <pasic@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 Chandra Merla <cmerla@redhat.com>, Stable@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Wei Wang <wei.w.wang@intel.com>
References: <20250404063619.0fa60a41.pasic@linux.ibm.com>
 <4a33daa3-7415-411e-a491-07635e3cfdc4@redhat.com>
 <d54fbf56-b462-4eea-a86e-3a0defb6298b@redhat.com>
 <20250404153620.04d2df05.pasic@linux.ibm.com>
 <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>
 <20250404160025.3ab56f60.pasic@linux.ibm.com>
 <6f548b8b-8c6e-4221-a5d5-8e7a9013f9c3@redhat.com>
 <20250404173910.6581706a.pasic@linux.ibm.com>
 <20250407034901-mutt-send-email-mst@kernel.org>
 <2b187710-329d-4d36-b2e7-158709ea60d6@redhat.com>
 <20250407042058-mutt-send-email-mst@kernel.org>
 <20250407151249.7fe1e418.pasic@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250407151249.7fe1e418.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.04.25 15:12, Halil Pasic wrote:
> On Mon, 7 Apr 2025 04:34:29 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
>> On Mon, Apr 07, 2025 at 10:17:10AM +0200, David Hildenbrand wrote:
>>> On 07.04.25 09:52, Michael S. Tsirkin wrote:
>>>> On Fri, Apr 04, 2025 at 05:39:10PM +0200, Halil Pasic wrote:
>>>>>>
>>>>>> Not perfect, but AFAIKS, not horrible.
>>>>>
>>>>> It is like it is. QEMU does queue exist if the corresponding feature
>>>>> is offered by the device, and that is what we have to live with.
>>>>
>>>> I don't think we can live with this properly though.
>>>> It means a guest that does not know about some features
>>>> does not know where to find things.
>>>
>>> Please describe a real scenario, I'm missing the point.
>>
>>
>> OK so.
>>
>> Device has VIRTIO_BALLOON_F_FREE_PAGE_HINT and VIRTIO_BALLOON_F_REPORTING
>> Driver only knows about VIRTIO_BALLOON_F_REPORTING so
>> it does not know what does VIRTIO_BALLOON_F_FREE_PAGE_HINT do.
>> How does it know which vq to use for reporting?
>> It will try to use the free page hint one.
> 
> First, sorry for not catching up again with the discussion earlier.
> 
> I think David's point is based on the assumption that by the time feature
> with the feature bit N+1 is specified and allocates a queue Q, all
> queues with indexes smaller than Q are allocated and possibly associated
> with features that were previously specified (and probably have feature
> bits smaller than N+1).
> 
> I.e. that we can mandate, even if you don't want to care about other
> optional features, you have to, because we say so, for the matter of
> virtqueue existence. And anything in the future, you don't have to care
> about because the queue index associated with future features is larger
> than Q, so it does not affect our position.
> 
> I think that argument can fall a part if:
> * future features reference optional queues defined in the past
> * somebody managed to introduce a limbo where a feature is reserved, and
>    they can not decide if they want a queue or not, or make the existence
>    of the queue depend on something else than a feature bit.

Staring at the cross-vmm, including the adding+removing of features and 
queues that are not in the spec, I am wondering if (in a world with 
fixed virtqueues)

1) Feature bits must be reserved before used.

2) Queue indices must be reserved before used.

It all smells like a problem similar to device IDs ...

-- 
Cheers,

David / dhildenb


