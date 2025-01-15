Return-Path: <stable+bounces-109177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD34A12E48
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 23:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2D63A682C
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 22:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944241DC9B0;
	Wed, 15 Jan 2025 22:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wqfbybd8"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FE31DAC9C
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736980219; cv=none; b=FeLGNKDaUQbci1lq+ZY0RAIPLhu9+H0CR6hpK9zZNN2robXukApfdfjZk8FwE7x817xAEv6UL6O88+2wbVmf++Xqf1vHUg14dJR7VIUiT+ccmcRzjrcMtLJM7I4B0yBw+eMu0U2VORWOrgg7x8bjSHHec0UnkqmdPS8IsZDPIn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736980219; c=relaxed/simple;
	bh=vx6wcL04Ydt7tNuVr3fr+dVyXTGGZ4LzHWKkj+ssP5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hXJ8PCp4QimN3Ge4iyzQrr3zpR2q7U18aw6h4rKNxALqFwGEXACbQFHIuo5kux2MBKlmujy9E+jTqBJGZ+o5335psOlHB6kwdHlav3drK24Y9aKO5qfuVJ34YBBc1u64kvnFgaLydwwM/SDpL+p3DZrUmE0uqoeSCVc6/Zmpdl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wqfbybd8; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a8160382d4so1005405ab.0
        for <stable@vger.kernel.org>; Wed, 15 Jan 2025 14:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736980217; x=1737585017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZDzLXjfPdjDlNmIBVryULcTBacgMofahEFhz1hfW49U=;
        b=Wqfbybd8pNd5nzQEwlGwtD1IoE7XKfe3i6mnvO/ZTmPQX4pGwtImLA34zWAwjWDKxn
         ArwubtcLBkQhnNOwDx4oObM6/HlqFhVRpk5PIZo8q5ODMdOerQ4zJu/MoC5tZ0N9Gvpz
         9HqzlVWc1+RPbuTqu0c7eOTD0jfoApVKi+XDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736980217; x=1737585017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDzLXjfPdjDlNmIBVryULcTBacgMofahEFhz1hfW49U=;
        b=XTH0M3XSlizTSjGJ0tzVGNVBboBbdRIAvuQlu8WAzUeHsXgKjpFFjYmxXwdE1xfjPp
         r9G+lsOEXU3BFPkqZP1uR7RH798nR5ZEpVprAE4X6z6X24IlIqEebONH0j8jW4f12AOm
         u8CBqU1GdaNorvvvfmqk16jUfI0kzFXvGSy1vZq3pgDanMMoCpgsq3BvnPPl9GC4RU/r
         cnQZN2IG1jBtNlUQ6dNmd0gnK2ngvhslGM2oKnEAgipQrcDlioYuCzHS3pZIRQuIlugU
         zffrzXKLEEJ3wy7FZUOwi9gp9pRsEJK9Vy+0Xex3KPNOHjvPSqjV8CeGcsAbJxJhtguB
         y6xg==
X-Forwarded-Encrypted: i=1; AJvYcCWYGY4ufXe2Kp3h7ZplzfqGP1ZddcY06G4eVGGllHpPTfeUaHgrSfLgEiUgJ9gVL5E5T3myvcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoTxgQ6NVzdpaTMOlSLIWOSXDDErRzKwF5LBRCSElkT1zS0xC4
	Mk70PppcdEsfX0TFEQjcbPpDtlbouQYMJlL1B0HgzY70azlrxJ2DguNUKg+h4NY=
X-Gm-Gg: ASbGnctAnI4dvuGdbUWhDMBTCRz37/LnDbCArmel4l3h4bWHmBFXYdg8Ul+UwU8Lx5B
	Qd93mkxWL9ZPd5n26ydGO8xVKO6yjOlnJVFyekCkDFXAExwoeJJQcg3H8TM7zOrFJvYX9WqpRY7
	ua98/Ci6R0gGtj6d04eaVvcE4G3InkQ44qZ+FnXKNmP3nYo/c0Dg/iKSoo6bNku/eflufRhM/Jg
	IwUZqjwx0HwFso1oTgQL1JWyNm0P9zsar3tPK5UdJusxa07fgxKOPuCYum9TBdFMYs=
X-Google-Smtp-Source: AGHT+IG2WwtUP/JJuLB77C/BDPZHNFfY8VRwYLryPnpSnDM0EUaOK4FaiQwxifegqpwHOzYfSllctg==
X-Received: by 2002:a05:6e02:188a:b0:3ce:8d4e:9c79 with SMTP id e9e14a558f8ab-3ce8d4ea151mr30799685ab.4.1736980216846;
        Wed, 15 Jan 2025 14:30:16 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b611829sm4387550173.33.2025.01.15.14.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 14:30:16 -0800 (PST)
Message-ID: <56bfd53f-6fbe-43a8-b565-131e47b92d59@linuxfoundation.org>
Date: Wed, 15 Jan 2025 15:30:15 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/129] 6.6.72-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250115103554.357917208@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250115103554.357917208@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/25 03:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.72 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Jan 2025 10:34:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.72-rc1.gz
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

