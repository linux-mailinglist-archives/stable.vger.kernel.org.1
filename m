Return-Path: <stable+bounces-95391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A019D883D
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 15:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C7F166213
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 14:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAD61B0F29;
	Mon, 25 Nov 2024 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FiCnenI+"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F432746C
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732545688; cv=none; b=FK6h7x+IwshfGYN+JFtw+4P1GLTYmk46gLqFmDbt3EyE/nmFsLpn0wauzTMrSOs2pv0Dbtla68XXkahFzjix7QDfFJjZJombplwFOrOvW8Tao+KVYHS+Nf7HQFLjXs1nNP1NVMgkJcqcInV3bMNDqKXhm0AaFZBPeB+PjnOhjxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732545688; c=relaxed/simple;
	bh=A4tqqE9TYYpTDQ1yBJF0jtd7T8xYQvqX7uNCadsOf10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H78U1qIeeN6blXGqDOjT7dJhVn3/pu9/GwrVnVCrqMb5rRlmH3GMrAqrDzrZYVz1p+JOO2u5WjoFImyeSLgf5hOib1pxObbFd7SdMFasIl7OJ2iBz/4cWpOkbzMlZCQmqhWlVddRTBTtcUu0R4iOgOYtjMItzRyRNe6igAnxjfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FiCnenI+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732545685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b++0MX6Wmr92z5VxRHl+Opm+dLA6rF0EzyL2WL9uH/0=;
	b=FiCnenI+6PjKeOVjbraqfg0iMT1F44UbaWWYh2SrQJKsWU4/j44j2g2WNqOXWipqMbMu1a
	CIezWlUx9NCv1b5ARlzqREq7b7h1uX7lvVoM0TynsdCX4bpOMEsF1WuHuSM2xP2pSeA2Lt
	EFjLdL+rY22YkzxIPambeyCM0DDI5BI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-QratQ1BDOBSn3l-rB5YCYA-1; Mon, 25 Nov 2024 09:41:23 -0500
X-MC-Unique: QratQ1BDOBSn3l-rB5YCYA-1
X-Mimecast-MFC-AGG-ID: QratQ1BDOBSn3l-rB5YCYA
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa53d22f651so172949966b.1
        for <stable@vger.kernel.org>; Mon, 25 Nov 2024 06:41:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732545682; x=1733150482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b++0MX6Wmr92z5VxRHl+Opm+dLA6rF0EzyL2WL9uH/0=;
        b=Bl6Fz2RQ/5MpzTEyOp/bNhWi05O4x8vVfqQNE9/mg60Tv4ij31FgepedySJmvqnb5V
         0CysOsRUjnXTcDrPTZu/mEQwo01cNwiZ2JTpKVxG7ciYCoASWrAOpsMZMoajPfZuqLrP
         Du+IWl86dTUZReRzSK6JHe3tqzRVm3eeqlYqNIHFbqBvqufGEgBDoQyHsbtWqpxb57uH
         TTxQBe3ULZrceyFgepndlClbRNnQdR/SW73W94FqwhJf1zV23O4O8pNOl7cgJb4XNdyb
         HDHRIoJeblrIIk/zdQEoJ+Y3byupJIYukvpqJAtpapWRsybAGggZLf5IFHTbNFmT7ujR
         h+4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFIryhXeGO0e9kjhlDYMW3rUW8v3yyGdd6edEDQ6H4xSuKJlfmUGtAhobPD4gr84LqB2NEpa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ22ttKuyxLzM/Lth8/3oe6OAUhkzk+Wyn9OMzIZ1VkXqXqtsG
	3nB095/KX7rD8vu3iptwNqC6zdpP93ATJmQA3W7lTmRVwsulqjJvcQJTux3zve+l492InRW/iKR
	xGhH+wAowKy6mWHsjaWHYNRiP0ITw5T/wXrmyGzvdl47Nw3viqG3rRw==
X-Gm-Gg: ASbGncvwh2uYESbpqG7ocTq3+5HE/cDPk7HO+bmrcEPqjkMfS5zVlG47w9azJBNaAdF
	ckwyAaHfgXI0qF7JwkX9k+5Sa76OhQMoKaNxglc7M7pGm/PTCkIaKJjpq6wFGAi5uqc1EElt/ZE
	KV2rZ2ZEFA2I85X00YRRGW9hL/7o+UQa/5wIWhJQEraQKkPWCNF2MmxVh1HWtGjAv+89crcNH5Q
	m+OdR7lw9FeeyX8ozrdOP1KDnftgqnlGFAI/iu0Q9um9NiJDsc2Hu/wARaYaocu+Xy32/1FQmM7
	qvK3UvgBFtYQjsohfHPoSGseiLbUZ8mAji04FT72gWm4klQAXwo41Q2U/mnljXW39QAwjP0lIg0
	LJG27lW919Ur3D3pWElWA49Nx
X-Received: by 2002:a17:906:3293:b0:aa3:49b6:243 with SMTP id a640c23a62f3a-aa50990b336mr769673066b.9.1732545682589;
        Mon, 25 Nov 2024 06:41:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFObVHuPDOmNA/zI+qqU2wcnVGGuCbpyKlC/4sJzTa2N8A0lXteoh/Bj022Y2RTnPxHgr/zSw==
X-Received: by 2002:a17:906:3293:b0:aa3:49b6:243 with SMTP id a640c23a62f3a-aa50990b336mr769671366b.9.1732545682150;
        Mon, 25 Nov 2024 06:41:22 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fe50sm478303366b.102.2024.11.25.06.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 06:41:20 -0800 (PST)
Message-ID: <233eaf78-49f1-43c1-b320-c75cfc04103f@redhat.com>
Date: Mon, 25 Nov 2024 15:41:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] media: uvcvideo: Implement the Privacy GPIO as a
 evdev
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Armin Wolf <W_Armin@gmx.de>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 stable@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20241112-uvc-subdev-v3-0-0ea573d41a18@chromium.org>
 <bd68178f-1de9-491f-8209-f67065d29283@redhat.com>
 <CANiDSCtjpPG3XzaEOEeczZWO5gL-V_sj_Fv5=w82D6zKC9hnpw@mail.gmail.com>
 <20241114230630.GE31681@pendragon.ideasonboard.com>
 <CANiDSCt_bQ=E1fkpH1SAft1UXiHc2WYZgKDa8sr5fggrd7aiJg@mail.gmail.com>
 <d0dd293e-550b-4377-8a73-90bcfe8c2386@redhat.com>
 <CANiDSCvS1qEfS9oY=R05YhdRQJZmAjDCxVXxfVO4-=v4W1jTDg@mail.gmail.com>
 <5a199058-edab-4f9d-9e09-52305824f3bf@redhat.com>
 <20241125131428.GD32280@pendragon.ideasonboard.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241125131428.GD32280@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 25-Nov-24 2:14 PM, Laurent Pinchart wrote:
> On Mon, Nov 25, 2024 at 01:01:14PM +0100, Hans de Goede wrote:
>> On 18-Nov-24 5:47 PM, Ricardo Ribalda wrote:
>>> On Mon, 18 Nov 2024 at 16:43, Hans de Goede wrote:
>>>> On 15-Nov-24 9:20 AM, Ricardo Ribalda wrote:
>>>>> On Fri, 15 Nov 2024 at 00:06, Laurent Pinchart wrote:

<snip>

>>>>>> Is there any ACPI- or WMI-provided information that could assist with
>>>>>> associating a privacy GPIO with a camera ?
>>
>> I just realized I did not answer this question from Laurent
>> in my previous reply.
>>
>> No unfortunately there is no ACPI- or WMI-provided information that
>> could assist with associating ACPI/WMI camera privacy controls with
>> a specific camera. Note that these are typically not exposed as a GPIO,
>> but rather as some vendor firmware interface.
>>
>> Thinking more about this I'm starting to believe more and more
>> that the privacy-control stuff should be handled by libcamera
>> and then specifically by the pipeline-handler, with some helper
>> code to share functionality where possible.
>>
>> E.g. on IPU6 equipped Windows laptops there may be some ACPI/WMI
>> driver which provides a /dev/input/event# SW_CAMERA_LENS_COVER node.
> 
> Using an event device means that the user would need permissions to
> access it. Would distributions be able to tell the device apart from
> other event devices such as mouse/keyboard, where a logged user may not
> have permission to access all event devices in a multi-seat system ?

input events modaliases contain a lot of info, including what sort
of events they report, e.g. :

[hans@shalem uvc]$ cat /sys/class/input/input36/modalias 
input:b0003v046Dp405Ee0111-e0,1,2,3,4,11,14,k71,72,73,74,75,77,78,79,7A,7B,7C,7D,7E,7F,80,81,82,83,84,85,86,87,88,89,8A,8B,8C,8E,8F,90,96,98,9B,9C,9E,9F,A1,A3,A4,A5,A6,A7,A8,A9,AB,AC,AD,AE,B0,B1,B2,B3,B4,B5,B6,B7,B8,B9,BA,BB,BC,BD,BE,BF,C0,C1,C2,CC,CE,CF,D0,D1,D2,D4,D8,D9,DB,DF,E0,E1,E4,E5,E6,E7,E8,E9,EA,EB,F0,F1,F4,100,110,111,112,113,114,115,116,117,118,119,11A,11B,11C,11D,11E,11F,161,162,166,16A,16E,172,174,176,177,178,179,17A,17B,17C,17D,17F,180,182,183,185,188,189,18C,18D,18E,18F,190,191,192,193,195,197,198,199,19A,19C,1A0,1A1,1A2,1A3,1A4,1A5,1A6,1A7,1A8,1A9,1AA,1AB,1AC,1AD,1AE,1AF,1B0,1B1,1B7,1BA,240,241,242,243,244,245,246,247,248,249,24A,24B,24C,24D,250,251,260,261,262,263,264,265,r0,1,6,8,B,C,a20,m4,l0,1,2,3,4,sfw

So I believe that we can create a udev rule which matches on input
devices with SW_CAMERA_LENS_COVER functionality and set a uaccess
tag on those just like it is done for /dev/video# nodes.

Or we can just use a specific input-device-name (sub) string
and match on that.

This may require using a separate input_device with just
the SW_CAMERA_LENS_COVER functionality in some of the laptop
ACPI / WMI drivers, but that is an acceptable compromise IMHO.

(we don't want to report privacy sensitive input events on
these nodes to avoid keylogging).

> Would compositors be able to ignore the device to let libcamera handle
> it ?

input devices can be opened multiple times and we want the compositor
to also open it to show camera on/off OSD icons / messages.

If opened multiple times all listeners will get the events.

>>>>>> We could include the evdev in the MC graph. That will of course only be
>>>>>> possible if the kernel knows about that association in the first place.
>>>>>> At least the 1st category of devices would benefit from this.
>>>>
>>>> Yes I was thinking about adding a link to the MC graph for this too.
>>>>
>>>> Ricardo I notice that in this v3 series you still create a v4l2-subdev
>>>> for the GPIO handling and then add an ancillary link for the GPIO subdev
>>>> to the mc-graph. But I'm not sure how that is helpful. Userspace would
>>>> still need to do parent matching, but then match the evdev parent to
>>>> the subdev after getting the subdev from the mc. In that case it might
>>>> as well look at the physical (USB-interface) parent of the MC/video
>>>> node and do parent matching on that avoiding the need to go through
>>>> the MC at all.
>>>>
>>>> I think using the MC could still be useful by adding a new type of
>>>> ancillary link to the MC API which provides a file-path as info to
>>>> userspace rather then a mc-link and then just directly provide
>>>> the /dev/input/event# path through this new API?
> 
> I don't think we need that. MC can model any type of entity and report
> the device major:minor. That plus ancillary links should give us most of
> what we need, the only required addition should be a new MC entity
> function.

Ah interesting yes that should work nicely.

Regards,

Hans


