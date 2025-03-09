Return-Path: <stable+bounces-121630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1FCA588AD
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 22:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9B1188DBBF
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 21:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F950219A74;
	Sun,  9 Mar 2025 21:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvdp6uGf"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1EF1EF368;
	Sun,  9 Mar 2025 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741557446; cv=none; b=HT2L0EEeorfWFIpTQC2Rp7DTR3IgRi0zSTt6swFHY4r7Xpbtt6FdcpKLp8PKpEo3cjF0hlgDwh89osUCT1EAaPSb2A4nx5pJpK0tF7MozHZBb/C7OHdlKssbOu3CWvPzKn43SoMuidm7ORatZagXbY0QRDL21mAqEsDTManN6Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741557446; c=relaxed/simple;
	bh=Pn56n8GBE8UCxvs12+4IV/Um/R07UV7tjGPzLbAQ+OQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dyNRkNVoKgcMN7fMzR3xFRXaAMmU91x1tcUBvEz/vno7i3142L8zwRb6VyDWCHcD8B/KqDAkVlSoJg3wiBE8AeVx6xm662RXwpNfX5AA6hq/UGA+LczVmSEOoPLjlg9/c92cSJrbHFLN0fKbrkO8meynEnD846Tz1+SMfVcyhLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvdp6uGf; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso9182f8f.2;
        Sun, 09 Mar 2025 14:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741557443; x=1742162243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NSfpy4/Aj1B+p0UMwIBKpz+PCflfZnDM7kqd3UIKSwE=;
        b=jvdp6uGfPrmf1+UBFcYqGC1lmWW++7AyWkvbkbCmp2yxFym/4Xal2JT9Lu2uiWRvyf
         T60/iKLr8PdAvWE09oEmEHQI2yovnJwHTN8Ry9Eq39O6KIOT5iAe0BQCUb6Ry3P5Jipi
         KeRQEnfaqRL9fE7oMj89JpAREYInEO0woZryvCRUAFR5sxOgreIhyhea2G89n3n5NKWT
         +6Iusm4UISGcjaqOK42X14YBWb5Nlr/1mS1qUaOhIlFhCRaHzyd6YCgbL6aWmlvpG3Ru
         pW/xQpi/pG0Wos5xxsGLNkIFjTjcIO86Axi/muwJsC8V9kymec6x876cQUp8iaDvJtXm
         vBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741557443; x=1742162243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NSfpy4/Aj1B+p0UMwIBKpz+PCflfZnDM7kqd3UIKSwE=;
        b=lBpm1bBR8IjM5LcmFShmjqjT5ZOVOrw8jsRqCf+Xic2o3J8sHEDyX7BiHBjYqji045
         30a25ZR+rfRetYrOiSU1DYwJKqF+x8hhRGi9jDGG2agMau4hFFVBBW8udAngaLPMOiH7
         e3L5LuuOmJR1j8r4sH1XE72C94fLVte8muNfhR0+BJISmxFs1BSwn5Rl9ne1lJq7nMWH
         fcM+4u1jxJe5nuqilzg7+l7Q7yOc9wSUQH7jlUGP/4tXFqVxpJcQcE3G2A6KDWQlX9eg
         +MRWvFLmtJ1LXNw7igDU4b6r/UOGFeRwvRrsRONNC9bUlaV2X0i4+c8HCzy9yBoRNoF1
         tRRw==
X-Forwarded-Encrypted: i=1; AJvYcCUVUBJqT+7ulBNhWvrVNbFAVup//vwoD7aPSEJc8o2WLhjJtZilT8SBv00N34/9ZJLEbBS/8T9CxaZw@vger.kernel.org, AJvYcCWlOEe7FNe6+VmWR4mY8YgdawwYOMCjg6pm8iFNAaRFgnRaFv7UMkOeToWnXrV7BwFdUjlss9Tr@vger.kernel.org, AJvYcCX7DmFHk4b4pSQgUOCYPL65XpqJ9y+epI8M1jQnagrcQYdWQrgtzfwXIy//pkr5PQK9yUI+ThbL9v1zDeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiiTV3Uo97XEgnidfDnlTU86EeHeu8AmGXUwvKZ7Wv90SLqwnb
	I248VQV5fmZf4beYndW6H89oEboGF3u7ftN/hKj8meh7pCMQV91l
X-Gm-Gg: ASbGnctOjbmMXrOkuYg1gmA2cqk0AenA8tMvZyDYv5n8YlOrJ8aqTMJugvpKfqwNfyy
	YBOe1fm7aLYOEzV+/75sH47ddU9U6X3LxnD0yz14VZP0TNGUfIO2Dh7Ig6EePog2n8ndga/iELe
	7W4z5YtkQaMr7ZfBzGpDVY5ZB+GIPawhVZfvFAjgT5m4t05YUTPS8eHrpAdOTqnI90HBGAhdKam
	Ts0Lq9XF+FvAzt/HIhDi+0q29119vB7VcLfnX96wa+doFBs+kYlZIk4skaCJyT7lpZEmsi/aowa
	Oq8yqxpjyze6uToGM1dBOMaHVRTjTIVzkc3GlkhQVTIs4RVaZf12DpsW5eNJ8rieODYlU0aYYNA
	o9SyK4ihdmuT//HA10Ws7Aw==
X-Google-Smtp-Source: AGHT+IHlFjNw4bjS7AfhnTSwAFcFZZVIoiG6l6ku1hA+7wcsMiJQFaX7fACndu509scn+6IFClWZYA==
X-Received: by 2002:a05:6000:1a87:b0:391:2391:2f79 with SMTP id ffacd0b85a97d-39132d98a8emr7605490f8f.43.1741557442749;
        Sun, 09 Mar 2025 14:57:22 -0700 (PDT)
Received: from [192.168.0.66] (host-89-241-216-251.as13285.net. [89.241.216.251])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912c0193bfsm13121734f8f.55.2025.03.09.14.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 14:57:22 -0700 (PDT)
Message-ID: <dc8894f5-8960-4e0f-93ff-47f305cd902e@gmail.com>
Date: Sun, 9 Mar 2025 21:57:21 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v1] usb: core: fix pipe creation for get_bMaxPacketSize0
To: Alan Stern <stern@rowland.harvard.edu>
Cc: eichest@gmail.com, francesco.dolcini@toradex.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, stable@vger.kernel.org,
 stefan.eichenberger@toradex.com
References: <Z6HxHXrmeEuTzE-c@eichest-laptop>
 <857c8982-f09f-4788-b547-1face254946d@gmail.com>
 <1005263f-0a07-4dae-b74f-28e6ae3952bf@rowland.harvard.edu>
 <cf6c9693-49ae-4511-8f16-30168567f877@gmail.com>
 <04cb3076-6e34-432f-9400-0df84c054e5c@rowland.harvard.edu>
 <bf0fda83-d97d-4a50-94d6-a2d70607a917@gmail.com>
 <73963187-6dcb-480d-ae35-2cee11001834@rowland.harvard.edu>
Content-Language: en-US
From: Colin Evans <colin.evans.parkstone@gmail.com>
In-Reply-To: <73963187-6dcb-480d-ae35-2cee11001834@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/03/2025 21:01, Alan Stern wrote:
> On Sat, Mar 08, 2025 at 11:19:22PM +0000, Colin Evans wrote:
>> I believe I have the information requested. The output of usbmon for the "problem" scenario is
>> large, I hope it doesn't exceed any email attachment limits, but if it does I will have to work
>> out another way to share it.
>>
>> It may be that 30s of data is more than is needed. If that's the case I can easily run a shorter
>> usbmon cycle.
> It is a lot more than needed, but that's okay.
>
>> Additional Observations
>> -----------------------
>> It appears that having pretty much any external device plugged into a motherboard port connected
>> to the _problem_ controller is enough to suppress the stream of "usb usb2-port4: Cannot enable.
>> Maybe the USB cable is bad?" dmesg errors.
>>
>> For these tests the results named "working" had a USB2.0 memory stick plugged
>   into one
>> of the top 4 USB ports on the motherboard, while the "problem" results didn't.
>>
>> For info- the older machine that exhibits this problem ("machine 1") also shows device manager
>> errors if booted into Windows 10, suggesting that machine may in fact have a motherboard
>> hardware fault.
>>
>> However "machine 2" (which is less than 2 weeks old), shows no errors when booted into Windows.
> Well, I have no idea what Windows is doing on that machine.
>
> The usbmon trace shows that port 4 on bus 2 generates a continual
> stream of link-state-change events, constantly interrupting the system
> and consuming computational resources.  That's why the performance
> goes way down.
>
> I can't tell what's causing those link-state changes.  It _looks_ like
> what you would get if there was an intermittent electrical connection
> causing random voltage fluctuations.  Whatever the cause is, plugging
> in the memory stick does seem to suppress those changes; they don't
> show up at all in the "working" trace.
>
> In theory, turning off power to port 4 might stop all the events from
> being reported.  You can try this to see if it works:
>
> 	echo 1 >/sys/bus/usb/devices/2-0:1.0/usb2-port4/disable
>
> Alan Stern

Thank you, that is very helpful, for a couple of reasons.

"Machine 2" is a new build, so if (as it sounds) the motherboard has a 
hardware problem, then I need to
look into returning it.

BTW- it seems I spoke too soon about the USB stick suppressing the 
error. After a couple of reboots with
it in place the problem re-occurred. It does seem that connecting a hub 
(switch) is the  only way
to reliably stop the error. The switch has a bunch of wiring connected 
to USB peripherals and other
machines. I would have guessed that might make the likelihood of picking 
up electrical noise
actually worse, but that seems not to be the case here.

"Machine 1" is several years old, it's actually the guts of the same PC 
that was upgraded to make M/c 2.
It's not usable, or sellable, with this performance hit happening. I 
have tried all the external USB ports
on this machine and not found the failing controller, my guess is it's 
going to be one that supports
some of the on-board USB headers.

I had been looking on the web for a way to shut down the problem port, 
or worst case the whole hub,
however all the Linux examples I found worked by either-

a) Preventing the loading of the driver for the chipset, by type. 
However that would kill all ports supported by
     the same type of controller, and this motherboard has multiple 
controllers of the same type onboard.

b) Shutting down a port by searching for the connected device 
identifier. However in these cases there
     _are_ no connected devlces, the fault happens when the controller 
is not connected to anything.

Hopefully the command you recommended will do the trick, I will let you 
know.

Would I be correct in thinking this would need to be run at every boot, 
some time after device enumeration,
or would it need to be run after every re-enumeration of devices after a 
USB device is connected /
disconnected? Not sure how to achieve that.

I very much appreciate your help in identifying the fault. Thank you.

Regards: C Evans

-- 

*Mr. C. J. Evans
Parkstone
Davis Street
Hurst
RG10 0TH

Tel: 0118 9340297
Mob: 07434 491984
*

