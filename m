Return-Path: <stable+bounces-127024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8704BA75B41
	for <lists+stable@lfdr.de>; Sun, 30 Mar 2025 19:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4D13AA565
	for <lists+stable@lfdr.de>; Sun, 30 Mar 2025 17:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C761DC992;
	Sun, 30 Mar 2025 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFcc0sv8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76001DDA39
	for <stable@vger.kernel.org>; Sun, 30 Mar 2025 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743354282; cv=none; b=kZH6X28poetWR5CthAxgW3GlOuI2kOFhUHM31PGtv2nhATxWeOJgV/4EMb8fIUMdOXCh/1A3twOeZHQQsIHwYAkRLbYoK4khV6PaCfN1jQR5gM42RYJgyyyYRRH1IOpzY/EjkY5SncRtWT9WGIuayM6iN7tcNomKl/aWEHOEt34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743354282; c=relaxed/simple;
	bh=BAKEzZA40sOcQ7n1AVHKwLRUlfebLm+j0ppIiCYiXFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdPpEuz0Mog3JWQY/odw0Uc3efL8mQhjJ4yRSwM1FMnZAd43Kb9jY6np3QEzGYQMCLPTcGM+3DrzFIk4+tGbr77PPpsyre4xm/LNTQJ0bY5lQFhEwvfu9ypPyJjyKnbOuSKUzu5INZDEV3RzQHcLKsOL6MRgUGdRcv6B9tsGJn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFcc0sv8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so34660925e9.0
        for <stable@vger.kernel.org>; Sun, 30 Mar 2025 10:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743354279; x=1743959079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2t8U1apyWfkYadxNh+ZCNH1xZAalJJ/Z/eiVcfGrYbI=;
        b=QFcc0sv8V4Vepx0UnPgH25Geq5ATRCfVsGyDSF4Ssp8PelrmvTA2y7SPDlbHcJlUi+
         ArWpuGOGkk4T5t0msJLKMTWNCBadmKQTiufWpQlEGeOLyRS+ezuPMXIi2FPECJrP3Dn5
         nsmnmqIyDkIEaOGMa/IcPVYbRu0iGo0U3eVWwdgDiDek438+y4YApuhN0QiUkIao43Zy
         s3GjS+8hgvKvJ82dTceU6ksZpxKn53gMtLYr5YklV7Cwwa2Uu4B6iMb0AUB5INyIU6RL
         WsUYHx730nO0hiA7yQg2xVrXg+ZTZCOxcTBkP10gn+WuT7h4s0OwQXjt1mBFLGgZ0T5D
         //6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743354279; x=1743959079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2t8U1apyWfkYadxNh+ZCNH1xZAalJJ/Z/eiVcfGrYbI=;
        b=ih7qNEYTBgRXpJ3Thlxm2TrNSg8I88ILU8BKVWCZ/rb0xk50s3ts0NQXsHv9ZFnPAZ
         x7NUHIEbvBhpPL8JzG2uwOymSXJdus/aChgngB4SOqoBqQnN7RyaMXNUItC4ZYXi6GaN
         7AstA63+k5AMrVdsn9TyI2Z6P/lN26lVaVhOFY7Llq/RDi0dh55S6ZGiiXKZjrj899u5
         wih6MukA71g+Kk4iwdCHJ059djyTGXT7a1dBVNOFEla2LzUisRCRRz3fhn35JCDPiZhc
         85Q9uDRCZsNDmRcTC1RAY0dusN6BDI+qvhdsoSwdhqsbV20e1b2fqiNvfa3KrkdlVPyP
         2RKw==
X-Gm-Message-State: AOJu0YzXZ0oH2N8+KHM8FLTHr4QlRq4nAgivCc5sda4q/SwRQAApwyBZ
	ryjhfdqIslcLKfqnne7FqvXp5iSTvDl3IOsf5fvtxcU/BVM7ICts
X-Gm-Gg: ASbGncvB+JEJejqWrj/j7jD48GHp3wyR/RrH7KqOjgG8hGJEUvDpOdTYn2G6Ee4XC3d
	fWfaQubbaZ2H2J20Xvr6VTXFRTDY1kS7Jap5SGLH2BZbFJkjwPaIHndu6+8OcBR1UxIhrxbn1Es
	+/E2h5WjAUjl7rmYZU1WDADpaALqo0H3h+NGxYOzcgxoC6akO3OB5d08yG+sySEJnyQRNIcIzov
	TYSJVyUIxhf7Jhtkfd67+rvlEbUR3deoOITliANThnM0eATdDLSwtlOenQteWor8twyza3FPWK8
	eee3gXp9De9Hatn1XXoRsjLaStgaxHiLOSJwT7JXgKMW8mpf7/aJI1Ba5xj/L8ZzbkBmdWERGr0
	585jXp09dY7Z0Ncpe+DsqklGBohg=
X-Google-Smtp-Source: AGHT+IGWRHzVCWEmkKNQbY3li1FH4smSEgKYfZNlQnBS52KWB4DBmN6gENIyoIOkvQziVGmRka0Rjg==
X-Received: by 2002:a05:600c:34d3:b0:439:9424:1b70 with SMTP id 5b1f17b1804b1-43db8526487mr69463315e9.30.1743354278683;
        Sun, 30 Mar 2025 10:04:38 -0700 (PDT)
Received: from [192.168.10.195] (net-188-216-175-96.cust.vodafonedsl.it. [188.216.175.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d830f59d0sm138759595e9.28.2025.03.30.10.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Mar 2025 10:04:38 -0700 (PDT)
Message-ID: <4537905b-a1bb-4597-ad25-17f95ecd3b1d@gmail.com>
Date: Sun, 30 Mar 2025 19:04:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: mt7921e unable to change power state from d3cold to
 d0 - 6.12.x broken, past LTS 6.6.x works
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Linux Regressions <regressions@lists.linux.dev>
References: <415e7c31-1e8d-499b-911e-33569c29ebe0@gmail.com>
 <2025031923-rocklike-unbitten-9e90@gregkh>
Content-Language: en-US, it-IT
From: Sergio Callegari <sergio.callegari@gmail.com>
In-Reply-To: <2025031923-rocklike-unbitten-9e90@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 20/03/2025 00:54, Greg KH wrote:
> On Wed, Mar 19, 2025 at 08:38:52PM +0100, Sergio Callegari wrote:
>> There is a nasty regression wrt mt7921e in the last LTS series (6.12). If
>> your computer crashes or fails to get out of hibernation, then at the next
>> boot the mt7921e wifi does not work, with dmesg reporting that it is unable
>> to change power state from d3cold to d0.
>>
>> The issue is nasty, because rebooting won't help.
> 
> Can you do a 'git bisect' to track down the issue?  Also, maybe letting
> the network driver authors know about this would be good.

Bisecting is extra painful, because the issue seems to systematically 
happen only when freezing on restore from hibernation, which in turn 
seems to happen only when I get in hibernation through the 
suspend-then-hibernate path. Because this is my main machine, I need to 
desperately try to avoid these freezes/crashes, since I am afraid of 
data loss (I have already broken a filesystem once this way, and I don't 
want to repeat the experience).

However, in the meantime I have found confirmation for the issue. See:

- https://bbs.archlinux.org/viewtopic.php?id=301985
- https://forum.manjaro.org/t/wi-fi-mt7921e-stopped-working/175867

I would not totally trust the second link where it says that 6.12.4 was OK.

The general wisdom seems to be that with recent kernels you need to 
disable ASPM for mt7921e. Now I wonder if 6.6 was maybe not activating 
aspm for that device...

There is also:

- https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2059744

 From which I get that the problem was already present in 6.8 and that, 
removing the mt7921e kernel module before shutdown and suspend may work 
around the issue.

Sergio




> 
> thanks,
> 
> greg k-h


