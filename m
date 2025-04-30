Return-Path: <stable+bounces-139197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E08AA50F4
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 17:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0276D18877F1
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 15:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B929D2609EC;
	Wed, 30 Apr 2025 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U+OLe5QP"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA6F17C208
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746028593; cv=none; b=CkKa/o+DxPbr7CmR65Y/TyWCxsWwIIYO5bfyxxdlQdRFua/s28aSn6TSIB74FOqr9dKTwAcyF9mnf6GQg3drN3sp3clf9pmYNq5P0p2pA/iYomfiNNnVrxIfaCFca18+/7NC5tS+qy23extnyjqe/JRacFTqQXKmGQGw7HuTW/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746028593; c=relaxed/simple;
	bh=pA7CR67AeI1bkOqd63U+4Afv5eGza7jJuigYQSok1LA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ac9J+mhuxU5WHiuROtiuexrswMyAAOhficyoQwm68thtC5IzcaFBSf9iApZ952B74c3bc0i9KQWEGyveAqT+UzOwx6fZyjcg+Q4xSPpabNijtBWyNwGnh5e17XbJ42T8pX+MPw4PRAcnkmwpS1KyF/wmlNgPOK62O1/mqzHeHeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U+OLe5QP; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d96836c1bcso3200515ab.3
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 08:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746028591; x=1746633391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O3812M1CMfafLY/AjSDZ4rQrf9LGvmm52EF3l0G3ANU=;
        b=U+OLe5QPPMsP9e+ZsaxUupe5xpKVDgcSxpJEsfWn3s54mnqGkXnc90FTSDaZA4v6A4
         v1MjfxbAp83qEaRoop9llZ5VO6p+Ec5ij3bGr2u7g6XcMvzvEAg53oXhq+jHneXYTQfb
         BEnIYGh7PBSzZbQkey5mtlZDu61fbznPTYdM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746028591; x=1746633391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O3812M1CMfafLY/AjSDZ4rQrf9LGvmm52EF3l0G3ANU=;
        b=Cv78wA4NiUZN5ViyYsH+ZoEDd/p+etLBjuzS+yqdAKkRFeGx3vleWnEePyml14bXqx
         xJCXKkY1UvUGsWvFScH0FMU4gX+DQ+24Xx+Ouqcx3evFh8puef+qNQUc2j7uuSZENWsP
         7fruEptgi2DTffK6W1PNLh0SEO+Kg0wKnUziSIIDAHvU7l5rT209mkVMjsY7jLiPh95j
         jMs5fm9o5i8JrRpKk8+PODPwsp8aFBcQMj3mmXzTlSLnW9JVwl2Hy3HZtkQfnHJOWWJ+
         1/hrlzMMxb655bQ6LT04I6zlW4nujDi7zUt7hgx6Tnz+R7z40Ff76NrPHSPvX243bAS2
         O8lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXCK6qDBfBJop7o+fs8ffrDTKPkblqd7Qavi7XpuWaz52tcLVl7AnBGID73MKIceCQvQv5hng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrUKZT1+aBjAge28nSI6KwlXEFy+MOPjgqvOFJy79T+8nRc3cY
	x8S91zUZIBMNJGp3VpsNg04fPbD56GCwHM6uYkzrW+fpGrXtgx/q95JeANRDGyga7n9eQh/dgNC
	L
X-Gm-Gg: ASbGnctQvUhfJtB67x8Bi60D+46ummRn2fwFeBtjA5Gz3RMVMDuBygJF7f66fKTkffN
	myGmRV0x7SrgGWcjcGUT8vIsV6dHbrQryVgcnjZ9ARnG0z4LljuURzzbyyKMtt95WMAYNPG8FsM
	8TqGCnazimNMH4K6Y2TrBjJZXl7u+0RyitA29sQnu3mdsFULquP3jPjBppwj4baIwSPimOW30Cy
	4AMJJTsvo06LPgILlR8ic8gBwcsW3aA3jX3ss/qn1OROu6IhY9vkbv3k68o3oTVk3elNcB5cUEu
	5grmLd59ssY7OrIH4UqUz1trxbhftroWBSYWXFWN2o5qw1zv/97Tdh0BrRXNIg==
X-Google-Smtp-Source: AGHT+IHMjiMeFah9B5OAFcO3f5dp76g+Jm+Si6IcQcOXU2QHU5UbtHuX2e+Jro56r9zfGV6MceYJdQ==
X-Received: by 2002:a92:c24e:0:b0:3d8:1f87:9433 with SMTP id e9e14a558f8ab-3d9676d0ce3mr35554665ab.11.1746028591040;
        Wed, 30 Apr 2025 08:56:31 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d95f2b34c5sm8803235ab.21.2025.04.30.08.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 08:56:30 -0700 (PDT)
Message-ID: <49a90b7e-05ae-420c-8976-7fd1e43459dc@linuxfoundation.org>
Date: Wed, 30 Apr 2025 09:56:29 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/373] 5.15.181-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/25 10:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.181 release.
> There are 373 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 01 May 2025 16:10:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.181-rc1.gz
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

