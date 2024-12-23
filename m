Return-Path: <stable+bounces-106027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7332E9FB740
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 23:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7C61648A9
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 22:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BA01C5F31;
	Mon, 23 Dec 2024 22:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CuSI4Jvd"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B294F18E35D
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 22:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734993706; cv=none; b=izZupuiuD83UPvOo4QOPJFk5+34NdyT+z554u3g4WwdBr3CwoQzcN8tmq4P+xHSyCRUFPuBKcW3tA69At7cQi5EIKzuMOvLKJcM2CQPa5SqLkxzLsk4pMlMrT0j/09hrI+Tx6/n7y+k2NDriADvEBAtLO7E3ekKI4sU6+t+xrzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734993706; c=relaxed/simple;
	bh=PWgG1LVspxAzFLHY/42aqwmCKRJpGNPJ7aFKCzRPR+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQJREozAJZNlPg+/v6q5ZF+78KOwAPAsLzBCBD7SZ8zTZOlMLGoHdsDogei4Ajsk9Ms/7uwtepQ7BFRXrqyHgKxQdCm63DDGAaiJNBV+F7yiTJWTuDB4RgVwq9OApGG5YcpfbBPNK0cWKOj8BZhjFaYTC6kCpsBcIZP2vKxP6Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CuSI4Jvd; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a9c9f2a569so35254835ab.0
        for <stable@vger.kernel.org>; Mon, 23 Dec 2024 14:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734993703; x=1735598503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xxQ/0rVJwsXrpBpC8qULH3JqbRbkKBPMeZOo81XXfVg=;
        b=CuSI4JvdDf0v/it7Aj/GlkrGSHO8JASf4bFdvdhdnxa6FKuopCWXMkcvBzr3pD8a3U
         LLiaFkSSmcUyTlVIJwhupLaWJQTzJn+5AFbFPANAiOk6f61HwiBkKuOIH3dX07yeq5Jj
         xecPuMG0MOLu3SHo78m5H7lZ6gfF9GzbAaBjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734993703; x=1735598503;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxQ/0rVJwsXrpBpC8qULH3JqbRbkKBPMeZOo81XXfVg=;
        b=brekDRPK1gCWqMp3ekeAeL2ndGbi9zTTwMAPuhVxtkXvvrGQF7q9WURTi2tc6xO7qY
         viYJXv1kh/R0rRpKjsFHfVE5pv13ZrI9XekQ6sv1qvmkhzPOxji259Pd3SKLHXYTqotb
         pBmdHc5GiO78R8IYeZ4gn2Newc+/l4eY/EIe8ytsg5kBPFVGPf1buIdnaD4utWHjKYbs
         RLfuKwJJx8cWvpK9aP7xgyBitNZt5TdaCKLYyN2odpMmCHk8d5eMkL4QpywCHgfZ2vDu
         4SL5du/ib6Ad9+ypEXJze5OFs8aeEXrx3aBRM1Oi9xYVGA5uY+VONkYr8ALUHzgn2S2l
         UKkA==
X-Forwarded-Encrypted: i=1; AJvYcCWe00GnVnHb2IkGO4qE2sQxBqXSRM5/W/BoGNxWtT64mEzvYzCYJL4TBy+zkojUBNiTEMw1FIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhKqlvcp6mcb2gZ93ulw7fzqsI3aKT1yXkLU/4N5mOL1iujbkm
	ce+Fyi1pJzGaVbrG2yV7FqH9hhSpINFUKYAbeFBeIPYxRjoaailyj7+yrYlcjUM=
X-Gm-Gg: ASbGncvBhXbk5dHUc7ceezBdRNE/9dYw/nu5S/Egb4TwonGdkFZPNfadmb8mShDDXER
	woC5Qa79JaKmunSg9iiPC4bWq+N57Gqz8bA9LozbvGSAPAwgAVyymlI5F2Bp+akLOUe2Fl5N6Ft
	RtX7xezUXTznu4KefrvdKk81tD8MdF2L8R21hVbaZCUxkknr43Xdy4DLQFS1VVvIjDUPhBIeZ+7
	ZgB03UkNl/zweqzxrjySw40PEK9Se9wx4gcMUk+TnGdAK6QdpsfUqT4x2jEeYrnn+35
X-Google-Smtp-Source: AGHT+IHDu36v3Qn3aWq/3rSXibFxSwNgar+s0Ye8l0hxH+V0OdCHe1e0mhddmap1WiO6DQF+OzQpxw==
X-Received: by 2002:a05:6e02:1aaa:b0:3a7:e01b:6410 with SMTP id e9e14a558f8ab-3c2d5151684mr141631985ab.18.1734993702796;
        Mon, 23 Dec 2024 14:41:42 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf66f5esm2416544173.46.2024.12.23.14.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2024 14:41:42 -0800 (PST)
Message-ID: <d8a84e10-e440-4f13-b5b8-90b5c3fc847c@linuxfoundation.org>
Date: Mon, 23 Dec 2024 15:41:41 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/116] 6.6.68-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241223155359.534468176@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241223155359.534468176@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/23/24 08:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.68 release.
> There are 116 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 27 Dec 2024 15:53:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.68-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


