Return-Path: <stable+bounces-4848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B62807502
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 17:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D7E1C20E52
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 16:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DF3482C3;
	Wed,  6 Dec 2023 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EO0TCUu2"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8955FD47
	for <stable@vger.kernel.org>; Wed,  6 Dec 2023 08:31:50 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7b3867bfcc5so23803439f.0
        for <stable@vger.kernel.org>; Wed, 06 Dec 2023 08:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701880310; x=1702485110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iDgo2Cq9agN60fB44yQGuaAdYgge0fbUUX+iicw+JS4=;
        b=EO0TCUu2k9ZPhpSFMOjxsSWGzqsjwVouTSHtmb6Yz8wYNGhFgV+HdyAaoa9+1peVMG
         kWnquusDmHUsGuoMhQ25Yw37BHgYQ5ghXIaz+3m+yu5rt7gQRUkXBT61sDiPdOa5Dj7s
         wU05ygZd4Qraojv/kKoV7WQZjfnuZLjsy2RdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880310; x=1702485110;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iDgo2Cq9agN60fB44yQGuaAdYgge0fbUUX+iicw+JS4=;
        b=OQym2OWb/NAvDsxPrAJ9US01XvuqayXprmRc7hl3VhZ/CjF+0QfsjkO8HVAooMMfK9
         5rcNcBOtXR8zhCJtavjPWiKfoqg9ldWbLYDovwxwL7+wDMW56isZ8AUbUhivQDAD/4JO
         8bBifubBF/XTU4vhheiHX+0TGIx6BlIApL7IkOMc5kqu/nquBJJ9ltIAnGj1g8BnnJ2M
         s/qS4ped7ox0dV0DwzR/VtT9ASL0qIYAu8AAVCxJmKm5fRAUwMNjA6UugHkuABvHfugH
         N3NeNyUjeHgn0lRltNLEHQEJXFvQ8eyebiAQL2uK7SqOe2Mnnb94f4l8OZvdNKERtgc8
         u2Bg==
X-Gm-Message-State: AOJu0YwLQIz/Jo1RVYbolaeVM3NrRXXjd1qvldbNtxGMYBbKmfJIzLFo
	78TCoL1sCv0DMi8F6J1KjxkFmQ==
X-Google-Smtp-Source: AGHT+IFBeELv64/d8AuOa3xLLsK3PGlt938fjaP7VdvXIOnh5ODloxlxDxRzn4vnwtsAKO4aT+uOtA==
X-Received: by 2002:a5e:c30a:0:b0:7b3:58c4:b894 with SMTP id a10-20020a5ec30a000000b007b358c4b894mr2839717iok.1.1701880309819;
        Wed, 06 Dec 2023 08:31:49 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id a7-20020a5d9807000000b007b3e07371bbsm3970203iol.19.2023.12.06.08.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 08:31:49 -0800 (PST)
Message-ID: <fa221062-03b4-46d7-8708-9d3ce49961dd@linuxfoundation.org>
Date: Wed, 6 Dec 2023 09:31:48 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/131] 5.10.203-rc3 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231205183249.651714114@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231205183249.651714114@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/23 12:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.203 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.203-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled. Fails to boot up. Boot hangs during systemd init sequence.
I am debugging this and will update you.


thanks,
-- Shuah


