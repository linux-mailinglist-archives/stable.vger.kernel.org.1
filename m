Return-Path: <stable+bounces-6467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BA280F205
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 17:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889411C20D7E
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 16:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD4977658;
	Tue, 12 Dec 2023 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UZWSbbuB"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEF910B
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 08:12:13 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7b74bc536dbso24907539f.0
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 08:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702397532; x=1703002332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/5Os7Zf9xtGAEMMOdp6/zayB3XH/JTR+GaEqzNPOqhg=;
        b=UZWSbbuB2C4dgmPehTNncpzKzoXypuXLJkZP88cI0i6Q+mE5ucRmaAcNb5NCf4zLa+
         xYh7h/cYPieJqVYVO68PYDIRGeJJ5NQtkgPMgNudn3uLLkRB0JgyT4u6J80Dn6GA0E93
         R+SjhcqxZuIAsObqrLb1Q2VwD6lSaiDFfo87M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397532; x=1703002332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5Os7Zf9xtGAEMMOdp6/zayB3XH/JTR+GaEqzNPOqhg=;
        b=qbLhx04zowAwlV3sYVD/ortmM1gXqOwvsZuwkUixHVP/g99IFV5BXkY/crxJ0xOPTd
         541QskghfB9aFnPlEeyQDbmWGjJlkUhUEPk11CZaZMiQBykGHfK6q3lSYaw7NgWppmTp
         8t19LMRiAtK6eZ5Myyl6BMTVH8w+rBq23eeDQcP0ik92K6cAMrng6RrNM7Cz66prCRGB
         +yDFrMsuSpu8gaqT4zWdA397UQ6U5koWdTwruPRR253vsqOBGTvk8bVxKsFZni4Rah0i
         8QRDh70mkNoF6tREVv5scXZJkzHtvyhkldTlqq94TzkU0lkLao8FYcfEwHAP5UnLZoyD
         tAzw==
X-Gm-Message-State: AOJu0YyCiD60HQhEgqSNrXsgX7q7TBUylG6ehTN3Gepgo7HdZdok2H5Y
	d8EeQPTZqvDr7tLlGEieYYsq/g==
X-Google-Smtp-Source: AGHT+IFlSd4M4f9h4XhHCPxW99K3g5dTcdwVKKOFnFzgm3FWCU+oaqjyDCgmSCas/3F7i/lOzxlxIg==
X-Received: by 2002:a6b:fe09:0:b0:7b4:2e28:2343 with SMTP id x9-20020a6bfe09000000b007b42e282343mr10516554ioh.1.1702397532654;
        Tue, 12 Dec 2023 08:12:12 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id t1-20020a6b5f01000000b007a6816de789sm3012606iob.48.2023.12.12.08.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 08:12:12 -0800 (PST)
Message-ID: <8dd78791-bc0a-4aba-a205-003919164834@linuxfoundation.org>
Date: Tue, 12 Dec 2023 09:12:11 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/194] 6.1.68-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231211182036.606660304@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/23 11:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.68 release.
> There are 194 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.68-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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


