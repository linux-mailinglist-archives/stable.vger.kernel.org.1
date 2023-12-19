Return-Path: <stable+bounces-7840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B41F817E51
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 01:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814CF1C22D00
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 00:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B1B79CF;
	Tue, 19 Dec 2023 00:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bcjfhu0W"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CCE53B4
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 00:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-35faacfc938so1935115ab.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 16:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702944056; x=1703548856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AcElKjkDPO0dV10cWP2L6pU0RVFW2OtHmlKmzqcZ7is=;
        b=Bcjfhu0WCRw5kwKqyuTnYG5uBaP22Z7sGkT1ephyTtG0LGfu+wv8bGplMJlG68ROEX
         HbXaIjhf5vNZvKJIgacJVRgs6P+en5pUSHc0UtIWCgAHgCZePQKxezO0DZK8griDxT+b
         +tQaD1s9416AazhAPPgWOeRrqXwWFde9pzHsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702944056; x=1703548856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AcElKjkDPO0dV10cWP2L6pU0RVFW2OtHmlKmzqcZ7is=;
        b=X9HzzR8FVudg4EooRdSGky6sL5J88hEgiBojQX1ra5pb4FAjAZPd1WytRuO9MrG4q0
         jSH2C3Q6AdaEXWSIagjUddjuGwVmJXhFHV57E1w5G2E8Zwkp5UmhU3WftYAkRUvJPFE1
         /Zo1Gw1garkVZPvZsdAieBBTHUVb8eynvreNAzggzPG/TZCKVFHxbA+FS9FoW3t+E57I
         J4AS+z2ibN/oslQ2kmIVENwbOeK7cUvZvIXJmnaufiuLQE5P2IC5HC4yZDLnvOhUNL9/
         0+/4Mdf2Q5IgumuY8H8RZ+FOWpI3K1yH1yKDUfvz+Vxgp5pLyLcJaEdLaq2z6n/MKey9
         ofVw==
X-Gm-Message-State: AOJu0YyfPWvG56hMj3eOvWb6BeZmu1AbxqiuneG+oYP4VoYc+DUxMXyL
	bBfzgnxcCKPJy4Pmi/tL0sQ9bA==
X-Google-Smtp-Source: AGHT+IHxpbtOB5tqCVef208T3slzQmA4nO/IZY2v9kdtJaGI54Sj07Z57g2cbuxe2QkkmJziqwcMlQ==
X-Received: by 2002:a6b:a0d:0:b0:7b6:f0b4:92aa with SMTP id z13-20020a6b0a0d000000b007b6f0b492aamr29016897ioi.0.1702944056457;
        Mon, 18 Dec 2023 16:00:56 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id w12-20020a056602034c00b007b45c1015b6sm5990878iou.31.2023.12.18.16.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 16:00:56 -0800 (PST)
Message-ID: <f76015fc-94a1-4cc3-9780-6f0b9e8c9d42@linuxfoundation.org>
Date: Mon, 18 Dec 2023 17:00:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/83] 5.15.144-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231218135049.738602288@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231218135049.738602288@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/23 06:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.144 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.144-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

