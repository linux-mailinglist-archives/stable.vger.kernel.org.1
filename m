Return-Path: <stable+bounces-128496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA4CA7D916
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 11:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4DEA7A389A
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 09:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F1D22FE13;
	Mon,  7 Apr 2025 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIQpAMkg"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DF022F177
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017103; cv=none; b=oiBmBe4GTttpmf+CTxg2lLuzh6uUWmMvtVBPgeMIXKz684I5ccdL0YBtAY/cZlrXsutl5BCcizs5VeawFKAXJ5PN+ZDk3EgHd7Ik0dnbr1aCWqUlwKUxJzl/qVvCKG+T3jTCJqO3AZjjcENBvm+TTaHBgXRLn1mOWmP/oqOURCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017103; c=relaxed/simple;
	bh=+/Idjao1xwvfu2KyKszwQ/i3wlDtyqx5u5HVRdO06Pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvRpy1OJopE7oWdgBxVVQe0NTApgQc5l6UHoAm67bhZxnKFHPKSsMOUtTz3ePLd8YwesGJB3CVK/GFYm0ShSRFu2lTzwRQ7qLRTYymMX3KfPE4IUZdDnKCQMowj1xizHidYRuiSR4CPENRdI69WUUWyIHgI2M04XK4C0OTT73ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IIQpAMkg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744017100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JSYTp8h3ydAk7fMbKTtdoLIqUCkUIcoI+tDF66GR53o=;
	b=IIQpAMkgEpX+R/Dm/scf+SScVjq62ON6h+I4gVLOf1kybggyShzWf6L8wTD4SegLagF9Wv
	qJBkCfEj7ieTQ4K5sZmuriTAS7PfRx1YH1HN1CgFwu79CuWkpnKMbnsKDbRhWSbSPWUSet
	FTJuMIpvVJlVvgxRqKpfJde6dvTx2wg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-iLkJItB_N2CJE7xE7bhDUg-1; Mon, 07 Apr 2025 05:11:37 -0400
X-MC-Unique: iLkJItB_N2CJE7xE7bhDUg-1
X-Mimecast-MFC-AGG-ID: iLkJItB_N2CJE7xE7bhDUg_1744017096
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so23147405e9.2
        for <Stable@vger.kernel.org>; Mon, 07 Apr 2025 02:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744017096; x=1744621896;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JSYTp8h3ydAk7fMbKTtdoLIqUCkUIcoI+tDF66GR53o=;
        b=JujK0zpBtLJIaWS3udoK9U/pAfp4oZ/TnDzbtqS27nQi/7IMTly6p62FCNeRVdiN1X
         XY96NPNRnhqo3qaB8acCrlmzSj9AQCOPeo8iTV4DozDnO27EhhRO2kSO1qxQeDxYcZz2
         NWKJxcTXE4xaaHOFF8JCRidy0pTP8wR3I5Dow9f7PksoGRklQ/+DadHijzXx6Rystlbd
         xItyyaZQ6o4kpiExU+e+KYKzePsfHRAG8hRREufo0hcfFGHhIfj0Ghs6CJmYFNVqvto1
         m3Jpg0kb6hsaQ9V1Hsckwjzg+9+6g9ztIfgjBfM7BgODAP63g/G4d2PeyfSjeXxvnnFY
         h+yA==
X-Forwarded-Encrypted: i=1; AJvYcCWmqqex8UUH9lq0jH2YRQHmyC++f+2emFr1WLycoe1Z46Zn+JOU4zctEPwq0tZgimVK2M6F7Ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdsVVNoPoyig38Cy7novdSbnEw7Zg21zIUMH+AzpussSRVIJZ2
	INwfQAgTefKTDVQMGu/V59K+X1uyGWP6wstzyaoKNrEJhw4Vk2vGh/+/VwKHnNAMuyrOH+w9X4h
	c20IjorDmO2VRALlRy/aC5eMcPA8AfNb/EullRnuuzAq2+P8n6DH8WA==
X-Gm-Gg: ASbGncuZvBcr6SNKD2tGeTg09io+x48agW75ZhuZ6NX1X8SEyuVUUPtRWKFhNa28CnP
	Iq03tsn4kS1uIpa50NMlW/tReYpq1KzEaR4qGwbWckaXxaPStM1RODLrUAFubmOVd0mb8rVB3Kw
	SDg7LJfHBv7zHC5dy6Ad8dIoOKK1uCaKApr4kckULAK36np4TGorG4PWXt3jUgQOVoLCDIf5fQ1
	iOTQOJVNYqgu4DwWoN1N2BSBJLZiTK5CjqXuiDooSJcJjv2Tst3k5N3TPGAYav7t30hDnPlCMQ8
	8Zl4zK5zWuWmrXv3LjRjv81tizU/XWtpzX7hYybk//66K3TS7FhSHui1lL1Ie/G4fHVLBTRnj6J
	U2LwF2SyY+k1AWJhmkRMAORPOP64y7gSjxVZRrCxjmeQ=
X-Received: by 2002:a05:600c:c12:b0:43d:94:2d1e with SMTP id 5b1f17b1804b1-43ee06644e7mr84053055e9.13.1744017096393;
        Mon, 07 Apr 2025 02:11:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmyHcU6FR9YBepEmOVbLGjvIK6wwO+UZPzUB+vT992KihStiEXcs+h3dTPaOZUy3fnYjoGGg==
X-Received: by 2002:a05:600c:c12:b0:43d:94:2d1e with SMTP id 5b1f17b1804b1-43ee06644e7mr84052805e9.13.1744017096071;
        Mon, 07 Apr 2025 02:11:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c738:3c00:8b01:4fd9:b833:e1e9? (p200300cbc7383c008b014fd9b833e1e9.dip0.t-ipconnect.de. [2003:cb:c738:3c00:8b01:4fd9:b833:e1e9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1630ddesm126845255e9.5.2025.04.07.02.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 02:11:35 -0700 (PDT)
Message-ID: <a86240bc-8417-48a6-bf13-01dd7ace5ae9@redhat.com>
Date: Mon, 7 Apr 2025 11:11:34 +0200
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
References: <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>
 <20250404160025.3ab56f60.pasic@linux.ibm.com>
 <6f548b8b-8c6e-4221-a5d5-8e7a9013f9c3@redhat.com>
 <20250404173910.6581706a.pasic@linux.ibm.com>
 <20250407034901-mutt-send-email-mst@kernel.org>
 <2b187710-329d-4d36-b2e7-158709ea60d6@redhat.com>
 <20250407042058-mutt-send-email-mst@kernel.org>
 <0c221abf-de20-4ce3-917d-0375c1ec9140@redhat.com>
 <20250407044743-mutt-send-email-mst@kernel.org>
 <b331a780-a9db-4d76-af7c-e9e8e7d1cc10@redhat.com>
 <20250407045456-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250407045456-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.04.25 10:58, Michael S. Tsirkin wrote:
> On Mon, Apr 07, 2025 at 10:54:00AM +0200, David Hildenbrand wrote:
>> On 07.04.25 10:49, Michael S. Tsirkin wrote:
>>> On Mon, Apr 07, 2025 at 10:44:21AM +0200, David Hildenbrand wrote:
>>>>>
>>>>>
>>>>>
>>>>>> Whoever adds new feat_X *must be aware* about all previous features,
>>>>>> otherwise we'd be reusing feature bits and everything falls to pieces.
>>>>>
>>>>>
>>>>> The knowledge is supposed be limited to which feature bit to use.
>>>>
>>>> I think we also have to know which virtqueue bits can be used, right?
>>>>
>>>
>>> what are virtqueue bits? vq number?
>>
>> Yes, sorry.
> 
> I got confused myself, it's vq index actually now, we made the spec
> consistent with that terminology. used to be number/index
> interchangeably.
> 
>> Assume cross-vm as an example. It would make use of virtqueue indexes 5+6
>> with their VIRTIO_BALLOON_F_WS_REPORTING.
> 
> 
> crossvm guys really should have reserved the feature bit even if they
> did not bother specifying it. Let's reserve it now at least?

Along with the virtqueue indices, right?

Note that there was

https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg02503.html

and

https://groups.oasis-open.org/communities/community-home/digestviewer/viewthread?GroupId=3973&MessageKey=afb07613-f56c-4d40-8981-2fad1c723998&CommunityKey=2f26be99-3aa1-48f6-93a5-018dce262226&hlmlt=VT

But it only was RFC, and as the QEMU implementation didn't materialize, 
nobody seemed to care ...

> 
> 
>> So whatever feature another device implements couldn't use this feature bit
>> or these virtqueue indexes.
>>
>> (as long the other device never intends to implement
>> VIRTIO_BALLOON_F_WS_REPORTING, the virtqueue indexes could be reused. But
>> the spec will also be a mess, because virtqueue indexes could also have
>> duplicate meanings ... ugh)
> 
> what do they do with vq indices btw?

See above links, they use the two for "s_vq and notification_vq".

-- 
Cheers,

David / dhildenb


