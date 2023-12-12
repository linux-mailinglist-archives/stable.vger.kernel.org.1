Return-Path: <stable+bounces-6466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2FA80F200
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 17:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F2D1C20CE6
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 16:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D761077F05;
	Tue, 12 Dec 2023 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cWHyCx02"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EE4114
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 08:11:28 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7b720eb0ba3so34090239f.0
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 08:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702397488; x=1703002288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9A8ywdoqkvbMjsf35PJP+6DC/rgWj8HumDYD5a8MF5c=;
        b=cWHyCx02lIdcjl73AD8GM/HwQkyyJHO0sBfrhaQE4GUYV1t3XmYRUTC4al+/xiQrSM
         JVpieQRwKZr/5YYj5QiIdFFDeHPRzaLy4POA7CsexyMi57TZ8koHiF9dwAiiAdpJ0DPi
         mTcPeOSLjpJnrk87x53WZb38kUoGyqY5Rl3FM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397488; x=1703002288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9A8ywdoqkvbMjsf35PJP+6DC/rgWj8HumDYD5a8MF5c=;
        b=jRmd1LtIqCR+EZ9C33hfNN9g1qOvQAtlYwggD2jfDxoW5J88+M8R5f8E7OZ6zK1GrN
         Y1fMJIoio8bBFekQcR2asmnzi2iZedRVbNEex6FeDDk5eMEp9enlLmtmsH+ZyNF2njxi
         3PoXH0N3RRCkT0/K74kiFmvbqxt9DfZQXnURSw0x25mZVugxJRauw8Dl8cy1L0XUBX4K
         3k9h5sQ/he+fS3XFmAeAv6sEwerBIVLMGXBpaXEzYEDwMh5dlou3B8f2UP8NVlerJQ7+
         BQKVCnXRmMx0kz3j08747RvlHDS0yWQormT0SStbIlDUXulz/miSFkEZWqi+6heJn2ob
         TZiw==
X-Gm-Message-State: AOJu0YyaJmRCuTzIQGRfgfps9dHh1sx0jmriiAYoy+FKXwCdQcuGL6l/
	mwN7ajQEqbyB9SGfbROy+gpmOA==
X-Google-Smtp-Source: AGHT+IGIAN8f7DjQU3m3l7oGBzuemvs/+v1uNJrzjbiEiUXi2FlQ3CVHAZy8Zv3mOToQOcsKkLLw3g==
X-Received: by 2002:a05:6602:254e:b0:7b7:3ba4:8949 with SMTP id cg14-20020a056602254e00b007b73ba48949mr7112425iob.2.1702397487767;
        Tue, 12 Dec 2023 08:11:27 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id t1-20020a6b5f01000000b007a6816de789sm3012606iob.48.2023.12.12.08.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 08:11:27 -0800 (PST)
Message-ID: <86fb793f-f319-48c3-889b-ee9251371e23@linuxfoundation.org>
Date: Tue, 12 Dec 2023 09:11:26 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/244] 6.6.7-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231211182045.784881756@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/23 11:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.7 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.7-rc1.gz
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

