Return-Path: <stable+bounces-127021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7B9A75AF1
	for <lists+stable@lfdr.de>; Sun, 30 Mar 2025 18:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9D4188B5E4
	for <lists+stable@lfdr.de>; Sun, 30 Mar 2025 16:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691471D63E2;
	Sun, 30 Mar 2025 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4I2+t77"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2209461
	for <stable@vger.kernel.org>; Sun, 30 Mar 2025 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743352548; cv=none; b=ZNoTdBL+lRvliw4HQxc+G3BbzaxGssBaaUSPpV61sTSU00G7XA8v478TMab26mqN8JJ303oC6axQ6IB7xif/vqcgJB5IRzbPuCam3PiB2DKeqXMLGVieJ+pktYaLaBHi3gsEGZuzlAdFGxlZuWjyqSpqgobOInOou3IrbzHnmBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743352548; c=relaxed/simple;
	bh=S4RODy1Q/hZZxDPN61Kt7DmGQaqQa/2RGDWfOBPMSdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5cUgzcRvNcnlcy6f1PA8TNrWyISZOBXSayTGeEMx91LhtkEqJ6ehlbK6uqbokEUMljWQ2ddArU+HbRQamao7vpAJMtXy7zbCjlKWCGKoXqztqBhIwgUsKW/Sp3LwCACoZbvDd6uuso4ASJ+C27b0EzsO2vzoWw7KliNSGAs/WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4I2+t77; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c0dfba946so1211524f8f.3
        for <stable@vger.kernel.org>; Sun, 30 Mar 2025 09:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743352544; x=1743957344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uuOuqty0i2CYwtRK3Rp+qfQDE4owvRyeSN1m7kjYXkQ=;
        b=Z4I2+t77iRIBfFPsR4F0wH+gnCqwev44fcKdRvlPOX/+kgkWakRFIoJyUaRkuAYqxD
         ZfhgnigukavmaJJKIOdHtAdrAYau49cdT0aDbjvOZ9vhl1EOYuErqC9s+n7kthSDeqoM
         pZt1e/PcZScUMxWhBMFsSERpsIHGmOjqHd9Jue4s8BTqDLsELHbCQPLEaWSnlm+itTl9
         cxLcpuCBLdcC6FLptDEZXpKbdL8+255vKuPRNghY+3GoIxlxEuoUvPkKGdC9AiXO7mdm
         QqDWDMlvdmJmEUCdlOjRBQMn2b/3kLho1UjGDh8Loz2CB0nRY/8QHPpq1XV7MUoMt3FS
         5P/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743352544; x=1743957344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuOuqty0i2CYwtRK3Rp+qfQDE4owvRyeSN1m7kjYXkQ=;
        b=dvkI1zEPwnjCDnqNFC9tIf7tNfiuBPoxhvijfVWd2UyETCGUkydPr2at9vd/H0du08
         dwwJi/GT+Y0RJGQe+Qb+ab0YBADOuxYIo80TTZdafPGcELZRdeTm+9DDKaOzP/YGddYR
         I6xi671lWYJwOwn8xYU7zrMeTF5ZlDLdzg22QLbXzCaonjG939BA4X4e+X1dxlZeWl4F
         S6Cw6dW+PNk3oTRra91+m9Lyyezk44PN7y/hXOBw4u5d9BGLQAYt4gX+IVr4PJaTSMCJ
         BrzRrzUS4Z4hHeEvI+50dA+7f76E/7LV0yIL7+cAE8chHgNuWk87JUQHOexC9oXYDeY0
         b2pA==
X-Forwarded-Encrypted: i=1; AJvYcCWXTZzR40Vxrf9hkchifA6y75Jgd5F0O4GpPFhs82EGBINhyZJxCb0vfPm1ZfQpL/VmAkLEyXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRopBiySgEJyOwQtA5i58n5YLR151VunaRLsewgoaNp/HLwLQ9
	MOYa7oS2leGkSy/1ngMwRecvN/dP32allkB/TI4gk+S6dMZGC4g2Yr4yacNl
X-Gm-Gg: ASbGnct1MrNA0d0ijlVDqZ3oPo7v9PyQGKa4qMJ2LkfnwVuz2dmZGJjyCX7AAIchY8E
	WHf7nVYySGo8oD60sVdoQtH8M29JACvQVpvhdFviDepgW2IMZEFQSuVUzLWxLkyegrYhndpxAtM
	kekJ02OgYlsSvnZLCXe5KzgEQ0RoWlXiwJ2Ku2iqxv1J0aql069oWSglboXc408zh0kukOgPWvB
	BgcN9erz+PEPJDz9Afd+lD+N0b3IYnYy1Pf9ZlBfXzmgpy0bWnfZIbVY6z1s+VZ5ZgJARGEo+5J
	ZeHPdjkKilSadMARTle9osaJZ3GsXssQp29OfwqIL8dlWyKY6BgnJo6ozhdBMWzHMXX/HEVlD/B
	x/RbR5+7/dmExnFoJJUAx3DS3pO4=
X-Google-Smtp-Source: AGHT+IHoyEbJ5/v1QJFBuWxBOsgt/kiZQGVTRtOGc8h5L9u1NHxhfrrZbHC8fyaTQD6E9ugMTRFeLg==
X-Received: by 2002:a05:6000:2b03:b0:391:4674:b10f with SMTP id ffacd0b85a97d-39c121188demr3552253f8f.36.1743352544412;
        Sun, 30 Mar 2025 09:35:44 -0700 (PDT)
Received: from [192.168.10.195] (net-188-216-175-96.cust.vodafonedsl.it. [188.216.175.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b6627bfsm8820607f8f.25.2025.03.30.09.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Mar 2025 09:35:43 -0700 (PDT)
Message-ID: <efde5e18-672f-484f-90c3-d23d673daa18@gmail.com>
Date: Sun, 30 Mar 2025 18:35:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: mt7921e unable to change power state from d3cold to
 d0 - 6.12.x broken, past LTS 6.6.x works
To: Christian Heusel <christian@heusel.eu>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Linux Regressions <regressions@lists.linux.dev>
References: <415e7c31-1e8d-499b-911e-33569c29ebe0@gmail.com>
 <2025031923-rocklike-unbitten-9e90@gregkh>
 <5e260035-1f1b-4444-b3b8-1b5757e5ed08@gmail.com>
 <38658f1a-216b-470d-99a2-13d66f075c77@heusel.eu>
Content-Language: en-US, it-IT
From: Sergio Callegari <sergio.callegari@gmail.com>
In-Reply-To: <38658f1a-216b-470d-99a2-13d66f075c77@heusel.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian,

Thanks for your nice offer, details below:

On 20/03/2025 11:05, Christian Heusel wrote:
> Hey Sergio,
> 
> On 25/03/20 08:49AM, Sergio Callegari wrote:
>> Might be able to test on the distro built kernels that basically trace the
>> releases and stable point releases. This should start helping bracketing the
>> problem a bit better as a starter. But it is going to take a lot of time,
>> since the issue happens when the machine fails to get out of hibernation,
>> that is not always, and obvioulsy I need to try avoiding this situation as
>> much as possible.
> 
> Which linux distro are you using? If you're on Arch Linux I can provide
> you with prebuilt images for the bisection :)

I am on manjaro, where the kernel follows slightly different naming 
conventions, but the arch kernels should be OK. So thank you very much 
for the nice offer. The thing is possibly a bit premature, in that I 
would like to identify first what is the kernel RC or point release 
where the issue started to appear, because I have these kernels 
available for my distro which makes things easier. Unfortunately, I am 
still in the dark even wrt this.

The issue is nasty, because it only happens when you crash on restore 
from hibernation, which is something that I am desperately trying to 
avoid because this is my work machine and I really don't want to risk 
data loss.

The big problem with this bug is that you remain with the impression 
that your hardware is bricked. On the web I read that booting windows 
immediately gives you back the wifi device on pcie, but I really cannot 
say, as I have no windows to try. What I can say is that the 6.6 LTS 
kernel also lets you recover the WIFI, while 6.12 LTS does not.

As a stopgap, would be great to know if there is anything that can be 
done while on 6.12 to fully reset the pcie (or the pcie device, I still 
don't know what is the culprit), so you don't need to boot an older kernel.

Thanks again,
Sergio

> 
>>
>> Incidentally, the machine seems to hibernate-resume just fine. It is when I
>> suspend-then-hibernate that I get the failures.
>>
>> Before contacting the network driver authors, I just wanted to query whether
>> the issue is likely in it or in the power-management or pcie subsystems.
>>
>> Thanks,
>> Sergio
> 
> Cheers,
> Chris
> 
>>
>> On 20/03/2025 00:54, Greg KH wrote:
>>> On Wed, Mar 19, 2025 at 08:38:52PM +0100, Sergio Callegari wrote:
>>>> There is a nasty regression wrt mt7921e in the last LTS series (6.12). If
>>>> your computer crashes or fails to get out of hibernation, then at the next
>>>> boot the mt7921e wifi does not work, with dmesg reporting that it is unable
>>>> to change power state from d3cold to d0.
>>>>
>>>> The issue is nasty, because rebooting won't help.
>>>
>>> Can you do a 'git bisect' to track down the issue?  Also, maybe letting
>>> the network driver authors know about this would be good.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>>


