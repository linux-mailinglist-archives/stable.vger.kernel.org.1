Return-Path: <stable+bounces-131926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67913A82305
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 13:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6DEB887867
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 11:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4113255E27;
	Wed,  9 Apr 2025 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKPxKrdj"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF61EC5
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 11:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744196544; cv=none; b=ImnWHWzCfze8l3aA07FN2TTQXfCHOKx+S/132WrYXppk9k0WfImY8FPQ/0CIV5TzEsPQsQ7l0IRmvoUU9YJN8kj6SnL9jn4eTuehvs410S2Cp2xQoDW+FKn+VlMrx2Elo6K5baewUMH9EaBIgOD2UpXqGS1SUjj/gKY4ZBRYqZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744196544; c=relaxed/simple;
	bh=vFccTBifcMr4w0wAbFpruMpJxwc2CS5iCTeeVE95v9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBMt2PqwuZHrAnkbJf3Lu5xJvBQ3H/HdizkS0ZaVRabcqmzOeeuozrm7HNy3cqMi6o0zbJLBxE0zLwL5iLbMZPhsXWI3EKh0xyVJQMfzhYiP7ZQzZeYHTPtnUYdJx+M1qgU8japQjKH9Gl48f7Fezl/dpF3JUIvcLySsLZAvpgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cKPxKrdj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744196541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EZOvVaEoZInhqpXJxnrIlSWuUXWiFfIJgLdhkS7C9vI=;
	b=cKPxKrdjUeA1Hsn0q30BQql50os3bvIdVl3ZPooKRapr1WdUHJCRso+tHfSU2/zyfqF2ud
	C22edHtAfv27xSdFT/5mJ69Ro9So3QLTUFxoaAaS/ddfOWgeFTqtgu8ysEBvuKh4ehJvJ7
	CQLdTzTqsUG4gYIKZUTsTlseIlaL76k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-uFBG0OjeN2SIKP-pZ0a37A-1; Wed, 09 Apr 2025 07:02:19 -0400
X-MC-Unique: uFBG0OjeN2SIKP-pZ0a37A-1
X-Mimecast-MFC-AGG-ID: uFBG0OjeN2SIKP-pZ0a37A_1744196538
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-391492acb59so3755686f8f.3
        for <Stable@vger.kernel.org>; Wed, 09 Apr 2025 04:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744196538; x=1744801338;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EZOvVaEoZInhqpXJxnrIlSWuUXWiFfIJgLdhkS7C9vI=;
        b=ZZ5SFexVfxOuzDPfuB36qItIKzTmc46AknG9a/QNBTmjJJDkFkbE4Yo/K18rmTZam8
         dG5srIiEk0ji35/95QEJiHt9byzuGkX7Bcxni1V1jfNK7yNL34S6yHWrSuXiTVndt2Lu
         SKY3NbhvL+ImAW1C6hezyi3gtQYa8QqsYaUdykZHN49pYflGnbhk0iSw9d1LcbAwvM1O
         NjTv7/kNcdadGbTXDZFXldfTB5a+2b41YVMj7pyJqTQIpHlXCf/mvujeELfzu6TXHDoA
         qpt8q3feagnTLq7yGxSf97csTh69MqA02eEEvNSjOS/chtZoXW1YHzcn2BuKAo15YTG/
         dkmw==
X-Forwarded-Encrypted: i=1; AJvYcCW/3PEudVxtIGm+KZ0V+AUytNpcyufkY4n7fe8BKL+3rZ0JItlRHcDESbgGO3CJQqrZue+Z7Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQxBJzas/vn4iCZZPYZzTIWC5cymJHNVDkjgEkjrgHmguqDYW1
	PgkUw+CTVvUUxO2c7+C5Bk3YdWYicxSQkhcqiSzxV2t+hVRdKg8Y3yBnL0bb1+XqAmhqJkZyXMP
	8/Sms3TN38PLitXHJH3vz7nHcHGEsp7RjQvLZSiv0tXDBhf1xIFFYyg==
X-Gm-Gg: ASbGnct2/02Ogz5TPa5uwtRJxSFOT6ZzjOkjfdVqIHR5OrqPmlb3sKsgoRLxXa8JpNU
	7coPDTZBFIkhGDVTbOLtU25zrXrDVqsr316Dkb9ZggsuV+t/oHmkTRgZ+UXINOAjQaV9PbvDrSO
	3ovzULXcn8JVpe4f+69mgHct9VLsp2NHShMbPskehIm4XBi/yCeiovFI+jpn/PHwGDr6JVsS1Yk
	bhrxvsChgrt4YUy9hGN5g8hd4HG7Jr66g4YJebhYXu0woZMPclTh1nwEr2MhbKqsGgZePdHIZ/S
	o97iPJBGXYl6Yd9MoxbWG4Wb4Y3PVFqZzJWA13q57MJZBqwCu+nfeCo6aDgmjNeld19Jjxloq4F
	J6DFAozpTgkE/hV7eZXI7NNyhMcukqxFoOw==
X-Received: by 2002:a5d:64e6:0:b0:391:1923:5a91 with SMTP id ffacd0b85a97d-39d87cde0b9mr2236400f8f.55.1744196537648;
        Wed, 09 Apr 2025 04:02:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0yBYVj5sgCYfXRlJOj5ovufewuK7JcWT/I+AT3kZEv8OkYtJmZ/uTZ0a33bImrRVMti8zDw==
X-Received: by 2002:a5d:64e6:0:b0:391:1923:5a91 with SMTP id ffacd0b85a97d-39d87cde0b9mr2236355f8f.55.1744196537163;
        Wed, 09 Apr 2025 04:02:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:8400:ed9b:a3a:88e5:c6a? (p200300cbc70d8400ed9b0a3a88e50c6a.dip0.t-ipconnect.de. [2003:cb:c70d:8400:ed9b:a3a:88e5:c6a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d8938b414sm1348203f8f.56.2025.04.09.04.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 04:02:16 -0700 (PDT)
Message-ID: <13f42e6a-e20b-490c-a75b-a32b5e6c5553@redhat.com>
Date: Wed, 9 Apr 2025 13:02:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 Chandra Merla <cmerla@redhat.com>, Stable@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
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
 <a86240bc-8417-48a6-bf13-01dd7ace5ae9@redhat.com>
 <33def1b0-d9d5-46f1-9b61-b0269753ecce@redhat.com>
 <88d8f2d2-7b8a-458f-8fc4-c31964996817@redhat.com>
 <CABVzXAmMEsw70Tftg4ZNi0G4d8j9pGTyrNqOFMjzHwEpy0JqyA@mail.gmail.com>
 <3bbad51d-d7d8-46f7-a28c-11cc3af6ef76@redhat.com>
 <CABVzXAnLjNeTYFvBBXyvB=h63b-rkjncBMzkV=+PY-Mi5fvi3g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CABVzXAnLjNeTYFvBBXyvB=h63b-rkjncBMzkV=+PY-Mi5fvi3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.04.25 23:09, Daniel Verkamp wrote:
> On Mon, Apr 7, 2025 at 11:47 AM David Hildenbrand <david@redhat.com> wrote:
>>
>>>>> Heh, but that one said:
>>>>>
>>>>> +\item[ VIRTIO_BALLOON_F_WS_REPORTING(6) ] The device has support for
>>>>> Working Set
>>>>>
>>>>> Which does not seem to reflect reality ...
>>>
>>> Please feel free to disregard these features and reuse their bits and
>>> queue indexes; as far as I know, they are not actually enabled
>>> anywhere currently and the corresponding guest patches were only
>>> applied to some (no-longer-used) ChromeOS kernel trees, so the
>>> compatibility impact should be minimal. I will also try to clean up
>>> the leftover bits on the crosvm side just to clear things up.
>>
>> Thanks for your reply, and thanks for clarifying+cleaning it up.
>>
> [...]
>>>> IIRC, in that commit they switched to the "spec" behavior.
>>>>
>>>> That's when they started hard-coding the queue indexes.
>>>>
>>>> CCing Daniel. All Linux versions should be incompatible with cross-vmm regarding free page reporting.
>>>> How is that handled?
>>>
>>> In practice, it only works because nobody calls crosvm with
>>> --balloon-page-reporting (it's off by default), so the balloon device
>>> does not advertise the VIRTIO_BALLOON_F_PAGE_REPORTING feature.
>>>
>>> (I just went searching now, and it does seem like there is actually
>>> one user in Android that does try to enable page reporting[1], which
>>> I'll have to look into...)
>>>
>>> In my opinion, it makes the most sense to keep the spec as it is and
>>> change QEMU and the kernel to match, but obviously that's not trivial
>>> to do in a way that doesn't break existing devices and drivers.
>>
>> If only it would be limited to QEMU and Linux ... :)
>>
>> Out of curiosity, assuming we'd make the spec match the current
>> QEMU/Linux implementation at least for the 3 involved features only,
>> would there be a way to adjust crossvm without any disruption?
>>
>> I still have the feeling that it will be rather hard to get that all
>> implementations match the spec ... For new features+queues it will be
>> easy to force the usage of fixed virtqueue numbers, but for
>> free-page-hinting and reporting, it's a mess :(
> 
> If the spec is changed, we can certainly update crosvm to match it; I
> think this only really affects a few devices (balloon and technically
> filesystem, but see below), only affects features that are generally
> not turned on, and in many cases, the guest kernel is updated
> simultaneously with the crosvm binary. I'm not opposed to changing the
> spec to match reality, although that feels like a bad move from a
> spec-integrity perspective.

Right. We didn't pay attention that the spec would reflect reality, and 
the reality was a bad decision :)

> 
> Regardless of the chosen path, I think the spec should be clarified -
> the meaning of "queue only exists if <feature> is set" leaves the
> reader with too many questions:

Right, that's what we've been discussing.

> - What does "if <feature> is set" mean? If it's advertised by the
> device? If it's acked by the driver? (To me, "set" definitely hints at
> the latter, but it should be explicit.)

Currently it's "feature is offered by the device".

> - What does it mean for a virtqueue to "exist"? Does that queue index
> disappear from the numbering if it does not exist, sliding all of the
> later queues down?

Currently it's like that, yes.

> If so, the spec should really not have the static
> queue numbers listed for the later queues, since they are only correct
> if all previous feature-dependent queues were also "set", whatever
> that means.

Yes, that's also what we've been discussing. And that started restarted 
the whole "can we fix device/drivers instead" :)

> 
> The way crosvm interpreted this was:
> - "if <feature> is set" means "if the device advertised <feature>
> *and* driver acknowledged <feature>"
> - "queue only exists" means "if <feature> was not acked, the
> corresponding virtqueue cannot be enabled by the driver" (attempting
> to set queue_enable = 1 has no effect).
> - Any later virtqueues are unaffected and still have the same queue indexes.

Yes, that matches my understanding.

> 
> The way QEMU interpeted this (I think, just skimming the code and
> working from memory here):
> - "if <feature> is set" means "if the device advertised <feature>" (it
> is checking host_features, not guest_features)

Right, "offered features".

> - "queue only exists" means "if <feature> was not offered by the
> device, all later virtqueues are shifted down one index"

Exactly.

> 
> ---
> 
> The spec for the filesystem device has a similar issue to the balloon device:
> - Queue 0 (hiprio) is always available regardless of features.
> - Queue 1 (notification queue) has a note that "The notification queue
> only exists if VIRTIO_FS_F_NOTIFICATION is set."
> - Queue 2..n are supposed to be the request queues per the numbering
> in the spec.
> 
> This is how it has been specified since virtio 1.2 when the fs device
> was originally added. However, the Linux driver (and probably all
> existing device implementations - at least virtiofsd and crosvm's fs
> device) don't support VIRTIO_FS_F_NOTIFICATION and use queue 1 as a
> request queue, which matches the QEMU/Linux interpretation but means
> the spec doesn't match reality again.

Yes, these are the two known cases we have to sort out.

Thanks for the information on crossvm, and that whatever we decide to 
do, adjusting crossvm should not be a big problem (at least for now :) ).

-- 
Cheers,

David / dhildenb


