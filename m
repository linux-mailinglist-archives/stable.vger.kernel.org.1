Return-Path: <stable+bounces-37913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE2389E6B4
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 02:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF58A1C213DC
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 00:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AB1A5F;
	Wed, 10 Apr 2024 00:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H+52ARJd"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCC519F
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 00:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712708414; cv=none; b=llGE1uzgCg4XgE2AWwOLkkmQ5DGD89u9Gglvdi681eGdV2Hzdj73kJpkrb78TkYaP6gOQCp+kjxhoKTVsrBxsGgJWsQqZiwVFAVfSk7FsvBI94bSYTzyjbh+waV9h7WPpvG791T/Av7kl3EjrGRatzqiEQzw1l5XL9Hh0iJ5yfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712708414; c=relaxed/simple;
	bh=5uXvHxjZzirfDvkIRhOsYYDI7XACucJRqQE4OGn03HA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AivxqCC2DEsSFsrUEJI/L5/z08ZTc1exv0qPjT4bt9NqNe5yNMOrjQ3YetCXWUTmyUMAW7h/6hjRzHN4rB6o6y2tJFjsWxiOxvnnhKg8xD0Ewnae4+deVn1RUC3N9/Gd1OwTEzp2RKAk5lEKRjr0ykfkVL4ZVInl78ZxaWrLduM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H+52ARJd; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso25445439f.1
        for <stable@vger.kernel.org>; Tue, 09 Apr 2024 17:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712708411; x=1713313211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8dH1sOx8AuuAIwyitTYp4fQEkYb8QaLWM8FC1wyKIYw=;
        b=H+52ARJdBNzEhm5cq6vTVyJN94TwjZFpDklDqt5HIZA32eu7vH0qSsm+St7QLT0EmF
         jVIR0dwk1UUct5RIVLkbbqmAMau/pwptoSsuWIqR1iGzphzeUmRwMvZDh4XIYMBVUaWQ
         1R9fpsdJz/Ne4eCZY1fOFONUBSEJKuGi520x0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712708411; x=1713313211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8dH1sOx8AuuAIwyitTYp4fQEkYb8QaLWM8FC1wyKIYw=;
        b=vl4V5CJZZ+AhZRYO6EJ6vUpln8lZwjLxI8mBllGRSleIkaRH/bfvlfCuTIXxvoLKLR
         2kOxMKDTPAKF/ilFnoV1tLPYnF3FCrdR1eFaIts2kivF/iqDRwDOzvLcXWP0GPiAwP4X
         M2tuILgRL2HoHEBwEhsxRWOIH+VcuG2/WcR+jlcXKTeFw+O7FK4/jQ4JgYNQ6l+XbVOE
         kmayv0/b71Am6bNAAy1heiZ4fujGoEs2ia++1fMNjA4zE0fQOpOj2z7MHlpbtumDrvQt
         +7QqSBjXTl6MDxnKOCkK6DLVOJ5JAqQ4vyCvAzg3V0TdqCdDeBm8Yppu59dkD7o4zeBt
         qWIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqCjircCJQuf78nm4pYN5zXMYuH8kRL4fmZWkvRRgU05wU7ybCgsZl1uujQpUHCkPtMO6Mb1PQ5nntUpgmf3/mQq7leyqB
X-Gm-Message-State: AOJu0YwMeBS62DfwEYIX0tr7RxKKp7tkmaGBn9Qi+vCMXAjNhxvRUlMw
	Uo1+HPChHQdv6MuKxTWvEPoFbMPtRfRo1eVPfC5nBS+b0UkcjiQ3L888zP6d8GY=
X-Google-Smtp-Source: AGHT+IHbvOdT7cqb6UgFwLcn1UkETQPFfzLOFngW91YpGcYtJrG5Zk7Dp6VMjSouo+2g5OCmxYqkyw==
X-Received: by 2002:a05:6e02:1fcb:b0:368:efa4:be12 with SMTP id dj11-20020a056e021fcb00b00368efa4be12mr1803875ilb.3.1712708411222;
        Tue, 09 Apr 2024 17:20:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id p11-20020a92d68b000000b00368c37480ffsm2854540iln.82.2024.04.09.17.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 17:20:10 -0700 (PDT)
Message-ID: <a07a6abd-47d4-4646-805b-ae170b0540a8@linuxfoundation.org>
Date: Tue, 9 Apr 2024 18:20:10 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/273] 6.8.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240408125309.280181634@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/24 06:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.5 release.
> There are 273 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
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

