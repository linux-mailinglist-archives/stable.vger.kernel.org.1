Return-Path: <stable+bounces-94108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E64F19D38B7
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 11:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67C0EB2599B
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 10:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CA419E7F8;
	Wed, 20 Nov 2024 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rebi75Md"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E25C15B135
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732099824; cv=none; b=aFYW3eI6vlXmm49WqZwhsZzveSld7puZFqtlgUfitTnkKXoUGcpXt4Uh/v1LkFwvOSy9bCjwGSsoWqcK6+lQncFDHzaWdbhnrwHEr4tliKiHHXS69mld7xEUiIlPpyZ/BNIcub+ml5Uy4Jfe2F9tNIAEY/7uAWjaaHWiZEvyVLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732099824; c=relaxed/simple;
	bh=kO1U3BT65jua0ZsywdvyoGAMeb2O7DDyzfbd9EZGb8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qWZcm0ytCvX3GHqAhaKTn/Fzyj5saD767lFKWerRQhMzvyiQVFnU9AuewpcJ46foL2AmhlzCUH0RtwblkmCiYAqiisXJkB90tm3arA0jUIBFmd0OAV6a0Cm31B81CiqSO+GDCAYCPW4x85mRKumyS1nkIYoy84XwT0Bd+SHrc4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rebi75Md; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732099821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7D+mhy7Tj29J0M0R40nbo3auU/AhUpgR2B53cAKVnF0=;
	b=Rebi75MdGmuxuQ3PtUVBOJaGB5tuyT5UPDnxhV8SRfBzAOKesncuzSBdiBYRF05g0g0Uwd
	Vz/iXPItcfy9Zm6DhyMRzHHWfejPg7oyHPGzN0hMy4dVgEZ6DihkiRKvmgREEHAGoknMZO
	TavVDO0eZ4xSMdFe0n8SEGFqu2ETr7Q=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-_P7Ja-mFPAeipWZTFm21_A-1; Wed, 20 Nov 2024 05:50:18 -0500
X-MC-Unique: _P7Ja-mFPAeipWZTFm21_A-1
X-Mimecast-MFC-AGG-ID: _P7Ja-mFPAeipWZTFm21_A
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a9a22a62e80so138386366b.1
        for <stable@vger.kernel.org>; Wed, 20 Nov 2024 02:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732099817; x=1732704617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7D+mhy7Tj29J0M0R40nbo3auU/AhUpgR2B53cAKVnF0=;
        b=OB6pZNk0W4VCmmsOuh/TkY0HRW0MsejAAHXDiHUacGTFxItcIQq+xaJO6TjbPk19Ho
         dhTmvP7K0esGL49s4vj84oZSB1HTFEC9zD6X1smwXrh+XCro3mEsqiopWcbWGHEKchKF
         cEjNo07rusecB2Qxhe6bBbsa4jVnT4Xw9AMwtxHd9h2/Rtrcg+0M/0C4ILJ2EZLovHGc
         HJzNr3SedAFA4CU8/UWe0nb1mVGGwMZwskcI8BJltDbIdRvQJ9AEY1aGH34ncacTnMh3
         rdgbLAJGaJmfgSTBwsXEOGxaAODcDnLwkSMoFsNdGuTmDrCvXMS9QHQlLQidfjB3dhmy
         ZISQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXbiAPb4r1YWekGCtycsw1vQnsZMNODZwQ/GvLPKZxvcRXWYkHXgy5RrkmN8KNJ+dkyNKhAJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyozLh0fTvRUSxT58AQKxQb5NMznnH4zD+RYju8baBkANHKwsgd
	1zfw7a5HUzqz3MeC+OKI/e059Qr9K3Gty0w1AeEAKn7NvUYuMUP2LYprdLQyGQdat8CSwA09tVU
	xnlTJEFC70mXbiZQ5AlZRKNPQGTM9hwXZzbOEX55c42tYVaSQ0U0m+g==
X-Received: by 2002:a17:907:31ce:b0:a9a:4d1:c628 with SMTP id a640c23a62f3a-aa4dd70b9d9mr191467066b.45.1732099817203;
        Wed, 20 Nov 2024 02:50:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFk1yC0Ns3T5y/UZgbMj46GxicQ8tECBzR0v+GMQYedev4cEL5EaOkSVWh+6wtbvS0VzRWbQw==
X-Received: by 2002:a17:907:31ce:b0:a9a:4d1:c628 with SMTP id a640c23a62f3a-aa4dd70b9d9mr191465266b.45.1732099816830;
        Wed, 20 Nov 2024 02:50:16 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dffba13sm750631766b.95.2024.11.20.02.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 02:50:15 -0800 (PST)
Message-ID: <845fd4ee-dcf7-4657-beb6-6936d5ef04cc@redhat.com>
Date: Wed, 20 Nov 2024 11:50:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] media: uvcvideo: Support partial control reads
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>,
 stable@vger.kernel.org
References: <20241008-uvc-readless-v2-0-04d9d51aee56@chromium.org>
 <20241008-uvc-readless-v2-1-04d9d51aee56@chromium.org>
 <5a5de76c-31a4-47af-bd31-b3a09b411663@redhat.com>
 <CANiDSCtXfdCT=-56m9crxW6hmVjuqBKvRE3NRQBf7nftW=OpNg@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CANiDSCtXfdCT=-56m9crxW6hmVjuqBKvRE3NRQBf7nftW=OpNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo,

On 18-Nov-24 5:57 PM, Ricardo Ribalda wrote:
> On Mon, 18 Nov 2024 at 17:41, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Ricardo,
>>
>> Thank you for your patch.
>>
>> On 8-Oct-24 5:00 PM, Ricardo Ribalda wrote:
>>> Some cameras, like the ELMO MX-P3, do not return all the bytes
>>> requested from a control if it can fit in less bytes.
>>> Eg: Returning 0xab instead of 0x00ab.
>>> usb 3-9: Failed to query (GET_DEF) UVC control 3 on unit 2: 1 (exp. 2).
>>>
>>> Extend the returned value from the camera and return it.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: a763b9fb58be ("media: uvcvideo: Do not return positive errors in uvc_query_ctrl()")
>>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>>> ---
>>>  drivers/media/usb/uvc/uvc_video.c | 19 +++++++++++++++++--
>>>  1 file changed, 17 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
>>> index cd9c29532fb0..f125b3ba50f2 100644
>>> --- a/drivers/media/usb/uvc/uvc_video.c
>>> +++ b/drivers/media/usb/uvc/uvc_video.c
>>> @@ -76,14 +76,29 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
>>>
>>>       ret = __uvc_query_ctrl(dev, query, unit, intfnum, cs, data, size,
>>>                               UVC_CTRL_CONTROL_TIMEOUT);
>>> -     if (likely(ret == size))
>>> +     if (ret > 0) {
>>> +             if (size == ret)
>>> +                     return 0;
>>> +
>>> +             /*
>>> +              * In UVC the data is represented in little-endian by default.
>>> +              * Some devices return shorter control packages that expected
>>> +              * for GET_DEF/MAX/MIN if the return value can fit in less
>>> +              * bytes.
>>
>> What about GET_CUR/GET_RES ? are those not affected?
>>
>> And if it is not affected should we limit this special handling to
>> GET_DEF/MAX/MIN ?
> 
> I have only seen it with GET_DEF, but I would not be surprised if it
> happens for all of them.
> 
> before:
> a763b9fb58be ("media: uvcvideo: Do not return positive errors in
> uvc_query_ctrl()")
> We were applying the quirk to all the call types, so I'd rather keep
> the old behaviour.
> 
> The extra logging will help us find bugs (if any).
> 
> Let me fix the doc.
> 
>>
>>
>>> +              * Zero all the bytes that the device have not written.
>>> +              */
>>> +             memset(data + ret, 0, size - ret);
>>
>> So your new work around automatically applies to all UVC devices which
>> gives us a short return. I think that is both good and bad at the same
>> time. Good because it avoids the need to add quirks. Bad because what
>> if we get a short return for another reason.
>>
>> You do warn on the short return. So if we get bugs due to hitting the short
>> return for another reason the warning will be i the logs.
>>
>> So all in all think the good outways the bad.
>>
>> So yes this seems like a good solution.
>>
>>> +             dev_warn(&dev->udev->dev,
>>> +                      "UVC non compliance: %s control %u on unit %u returned %d bytes when we expected %u.\n",
>>> +                      uvc_query_name(query), cs, unit, ret, size);
>>
>> I do wonder if we need to use dev_warn_ratelimited()
>> or dev_warn_once() here though.
>>
>> If this only impacts GET_DEF/MAX/MIN we will only hit this
>> once per ctrl, after which the cache will be populated.
>>
>> But if GET_CUR is also affected then userspace can trigger
>> this warning. So in that case I think we really should use
>> dev_warn_once() or have a flag per ctrl to track this
>> and only warn once per ctrl if we want to know which
>> ctrls exactly are buggy.
> 
> Let me use dev_warn_once()

Great, thank you.

Re-reading this I think what would be best here is to combine
dev_warn_once() with a dev_dbg logging the same thing.

This way if we want the more fine grained messages for all
controls / all of GET_* and not just the first call we can
still get them by enabling the debug messages with dyndbg.

This combination is used for similar reasons in other places
of the kernel.

Not sure what Laurent thinks of this though, Laurent ?

I wonder if we need some sort of helper for this:

dev_warn_once_and_debug(...(

Regards,

Hans





> 
>>
>> What we really do not want is userspace repeatedly calling
>> VIDIOC_G_CTRL / VIDIOC_G_EXT_CTRLS resulting in a message
>> in dmesg every call.
>>
>>>               return 0;
>>> +     }
>>>
>>>       if (ret != -EPIPE) {
>>>               dev_err(&dev->udev->dev,
>>>                       "Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
>>>                       uvc_query_name(query), cs, unit, ret, size);
>>> -             return ret < 0 ? ret : -EPIPE;
>>> +             return ret ? ret : -EPIPE;
>>
>> It took me a minute to wrap my brain around this and even
>> though I now understand this change I do not like it.
>>
>> There is no need to optimize an error-handling path like this
>> and IMHO the original code is much easier to read:
>>
>>                 return ret < 0 ? ret : -ESOMETHING;
>>
>> is a well known pattern to check results from functions which
>> return a negative errno, or the amount of bytes read, combined
>> with an earlier success check for ret == amount-expected .
>>
>> By changing this to:
>>
>>                 return ret ? ret : -EPIPE;
>>
>> You are breaking the pattern recognition people familiar with
>> this kinda code have and IMHO this is not necessary.
>>
>> Also not changing this reduces the patch-size / avoids code-churn
>> which also is a good thing.
>>
>> Please drop this part of the patch.
> ack
>>
>> Regards,
>>
>> Hans
>>
>>
> 
> 


