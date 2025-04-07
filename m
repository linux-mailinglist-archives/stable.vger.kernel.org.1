Return-Path: <stable+bounces-128495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43379A7D905
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 11:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D98F3AD151
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 09:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB9422E40F;
	Mon,  7 Apr 2025 09:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdX4okts"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5496D22A7EC
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016904; cv=none; b=uIFw9PrfUGU83nfJ95D6QPTDAm/Gh+si/m/rJqzpE6sypgMWdmHyX3RBB/NZTJeT4w1D2M4Ucqgkry8Xj1ILxQq24I3Y8mtmLE32WWfNKkaqnITXj0Ts2mRfVNdiNgRDvWC5s8e85XdpvtDPehL5RAAMzArNAL1KWrmCnADBzLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016904; c=relaxed/simple;
	bh=z2JPGGi1JdXXtDt3Q6OoGLGi+8RbWVAzAZBv7tfaXM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0Y9Vv6lqfj3J+pSGmnQDO+1BWsG8yyDmVV9Dof92HV2VMo+EcvxzyfOt0kuBX5BOViSS2UUKFfJkjI2zwP2ZvRtc+w8bRaKWPtQxvF2BZQQlg8Q9QEERxfOTQa5Os8i9xUWxiSFdGYQGHCuB8/InlJp8w/vavrDrOPYsNSmiFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OdX4okts; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744016901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oqCsSv+iJtk7+OhqzwBJLt1Sh9GFg3lG2Cm+2fguj9Q=;
	b=OdX4oktscSxHAHg9GYssGXPVfz6IhVQ/UU99nVSaA3YHFTgL9mknhcbwgW5E1rq2taDPJJ
	WR0PEQWQ3rddxBeGvr9YHtD0gjcygaN+5hsIj5xWV6FpW62Om60mJcjQriTfuMNTUYNhvQ
	s85sXFdlfdv7KSlh6aapM0cKJFkCo1I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-sbB_adu0PGOBAQo9mWDaVg-1; Mon, 07 Apr 2025 05:08:20 -0400
X-MC-Unique: sbB_adu0PGOBAQo9mWDaVg-1
X-Mimecast-MFC-AGG-ID: sbB_adu0PGOBAQo9mWDaVg_1744016900
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cec217977so26505485e9.0
        for <Stable@vger.kernel.org>; Mon, 07 Apr 2025 02:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744016899; x=1744621699;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oqCsSv+iJtk7+OhqzwBJLt1Sh9GFg3lG2Cm+2fguj9Q=;
        b=Xc+j09cY0jh4HCW/8ReaAiF8VzmWtrD7en3GRz3/TbbaN0fXpEs6F8WB+X+9aDVuPM
         lFvfTCvL8H4oxcb+imq+9fujaZGCEWyuF/+/2V0y/6ltPKZjLFrcynKgB8C2UT9U19/l
         Fa0yYdatchFgc0KRFrgbkuTDN8I2GujJ12v8vnCdRhaWbNwMNAd2B6gtg9V2SoZpuRk6
         CmP9SQAd9wCdZgtxuHMp79kHLqCdNrLKvf8Pqokr0tR1W7Mw2FL8k3DZTVh9CtLzOw11
         c/SNAu6WvqTB2EcbVu+mvRhbjUtM+f8mCflRtR7tRfEz/s0XJ7wE0m1/TRzE2+wKJCnp
         TAAg==
X-Forwarded-Encrypted: i=1; AJvYcCUAbaWxvBTNTPggurHt8pVqAFWCNJW8BHuh8i7Eg2jIQ1gxwZerS71Jqgz2xaMOMFOHIl2qnYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOiOSJ2zRx+uPwyoUqkMItY4gPP4yyvkAhfJSLvZTJ+BYgEOWK
	9o7UxBqdTv9luQUBnGEq0hy5+uROvIIQmZunADiI6YK9QxVAQJX+uab4rvrCmVHKFqCPac4AdOl
	LOcl5KZWtIB8zIvk/2SLdIoXXtF/EqxhfuSA28AAglWbwgLGHxX/e4A==
X-Gm-Gg: ASbGncuh1VjA86O5knl2wH4n5tNljyCYojy7u9pEs2AIo26WJAhGUusu/d9iWNMkyzr
	zYMq0g2rvfnhLt8xDUk7siQtQhdnwnxBvEQEq7sKuGYS+oscBvfGPylEYtT96Y4+ezLLPRPTBZa
	VVDuMzfTa8e1r9/rVQOzIr2sx6jl/7/v9F/A5qhrNR4ieqo0jdQ5guvL6MxlQOGOfPLbu39N9MC
	wU5iaeXevgbJ3RTM4EZoVjXBWYbyu2dCglygkiH34TcHFXN9SKehtVgItAIuc3rgjoD3FGIzRhf
	OLUcbryrKEEzf142gLQPUUGjq4i8zrY1ItWnJwK1bpSK0CjRPzw3aWCAtkTaytZQJy+/qjdjAtF
	pGCChTfPIefnjFgfmzgOytjEyOdQ9AKY0kbFG4OuoPAg=
X-Received: by 2002:a05:600c:35d6:b0:439:91dd:cf9c with SMTP id 5b1f17b1804b1-43ecf85db98mr128349675e9.10.1744016899566;
        Mon, 07 Apr 2025 02:08:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUeobmJZW+aR5r6kiPgmLWdDgjwcD1Ca/g4FxeTa+4iuCWe/OJahsY4Rz2UFEp1o4Y2qVjpA==
X-Received: by 2002:a05:600c:35d6:b0:439:91dd:cf9c with SMTP id 5b1f17b1804b1-43ecf85db98mr128349265e9.10.1744016899186;
        Mon, 07 Apr 2025 02:08:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c738:3c00:8b01:4fd9:b833:e1e9? (p200300cbc7383c008b014fd9b833e1e9.dip0.t-ipconnect.de. [2003:cb:c738:3c00:8b01:4fd9:b833:e1e9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a9da1sm11252452f8f.22.2025.04.07.02.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 02:08:18 -0700 (PDT)
Message-ID: <0fd4211e-8c4f-4712-a349-a0e95f4ce6c1@redhat.com>
Date: Mon, 7 Apr 2025 11:08:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, Chandra Merla <cmerla@redhat.com>,
 Stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Wei Wang <wei.w.wang@intel.com>
References: <20250402203621.940090-1-david@redhat.com>
 <20250403161836.7fe9fea5.pasic@linux.ibm.com>
 <e2936e2f-022c-44ee-bb04-f07045ee2114@redhat.com>
 <20250404063619.0fa60a41.pasic@linux.ibm.com>
 <4a33daa3-7415-411e-a491-07635e3cfdc4@redhat.com>
 <d54fbf56-b462-4eea-a86e-3a0defb6298b@redhat.com>
 <20250404153620.04d2df05.pasic@linux.ibm.com>
 <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>
 <20250406144025-mutt-send-email-mst@kernel.org>
 <4450ec71-8a8f-478c-a66e-b53d858beb02@redhat.com>
 <20250407045009-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250407045009-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.04.25 10:54, Michael S. Tsirkin wrote:
> On Mon, Apr 07, 2025 at 09:18:21AM +0200, David Hildenbrand wrote:
>>> Now I am beginning to think we should leave the spec alone
>>> and fix the drivers ... Ugh ....
>>
>> We could always say that starting with feature X, queue indexes are fixed
>> again. E.g., VIRTIO_BALLOON_F_X would have it's virtqueue fixed at index 5,
>> independent of the other (older) features where the virtqueue indexes are
>> determined like today.
>>
>> Won't make the implementation easier, though, I'm afraid.
>>
>> (I also thought about a way to query the virtqueue index for a feature, but
>> that's probably overengineering)
> 
> The best contract we have is the spec. Sometimes it is hopelessly broken
> and we have to fix it, but not in this case.
> 
> Let's do a theoretical excercise, assuming we want to fix the drivers,
> but we also want to have workarounds in place in qemu and in
> drivers to support existing ones. How would we go about it?

QEMU could likely be changed to always offer 
VIRTIO_BALLOON_F_FREE_PAGE_HINT, but not actually use it unless enabled 
for QEMU. That should work, because all action is initiated by the device.

That way, all virtqueue indexes would always be according to the spec.

We'll likely need compat machine handling ....


Regarding Linux, I'll have to think about it further ...

> Maybe we want a feature bit BALLOON_FIXED and ask everyone
> to negotiate it?  But if we go this way, we really need to fix
> the 48 bit limitation too.

I was thinking about the same, but it's all a mess ...

-- 
Cheers,

David / dhildenb


