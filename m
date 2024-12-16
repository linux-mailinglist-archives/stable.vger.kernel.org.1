Return-Path: <stable+bounces-104379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A10C49F3610
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 17:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E527A452F
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 16:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E25207A3E;
	Mon, 16 Dec 2024 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhrAvTmL"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43808207A3F;
	Mon, 16 Dec 2024 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366573; cv=none; b=G4//5CaF/hT0uYEw1y0yO+HSfuzLGbCO2+6gt8OjC59V4U4xNjsFx4xKwQnptNf243iZ/uWfcjIBCASqNCsbn8Yzcugp4Xth5QCWabq42GI+1UL6zLYUV6csPQsgVO94AprwNX9iOB2BOdJ/922xy5U9BOjf/DLkioyJEdNy9bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366573; c=relaxed/simple;
	bh=3IgqwoNYpiR6zExU54Z7G93tBLU19c3FRBCun6uurE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVphmisXOL0FBSejJ22BeQ6RHm3PmDkNMsSbh8/7fxG2a5UOjIS+gxSyHqn2aIpUmz1QGcjygsPi3gWNJ3irzcHQgfWqLKak0OcOpXET2pWbBOPlBGFs6U1UTbWzc9Kdr5DBlIcLnKOAz4846p7SYxo/2lvRrvagrSisljbmVEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhrAvTmL; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dcdd9a3e54so16225516d6.3;
        Mon, 16 Dec 2024 08:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734366570; x=1734971370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IPu0EcOKfFbh2kllqSkRuNhepsvNsyULuW0PTLnpl+0=;
        b=EhrAvTmLQzHwQ0K38nYegMcDFe0kcvj9wnX6BnN/I0LQWFQaMHHA/OhtMf4IuNKfNX
         jqQ1tcb3WjHcRo9Uj03FtGm0c2YX76EHLGHdKNbIG65v8eGVKMH7gw3GnZuqZMCm34af
         oVwEUQScpTov3aSS5oR70KKDze6fVbzY+CzRMqvjwy0rw+GhOL9n8EvZoVf8xWSYEUYO
         na7/38/fGMI0U0CvYkYBYtYUkBpu2rDGHKcyrDQmc+ELjcXJz+vLxrTqNVqnlyDK3sfP
         hVXbrkGIwlEzfxpdFVa9WQk+bqdHlw1HMtW9a7rd0gRlUT3XjhvtYN5PurSDNvBM0F9M
         5Svw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734366570; x=1734971370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPu0EcOKfFbh2kllqSkRuNhepsvNsyULuW0PTLnpl+0=;
        b=CINe51jxr2u+QRGjRcIt+6IJuJ1UmCWoHuBP7WFT51mtqdIVEVBAtjJEgcRNp+RWd9
         wrk5McuBDB5THmkxbq5ig2CYjPYyJizERs6pSBZYIznXl9Xv3OYa68iosNJYqm3pzL/d
         asc9qBYPS27nJQnZPA1TIUHR4FBSCGWCmj1nKJgGE0vnw9dzsVvH/4ELR6BPbsdidyW9
         yQ6rqbq4c4tBvJ9cgr6I2YRqknvc1WyH+SvikVXnIZfSVmcKtP4tCeDrM1fufTkTRTRq
         D9PTS60zNZ40F+EEAtxu6MMpWZ86awJUj+OSWR56H+rGf619tUySFahYP778eziLohNE
         QQIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVjKddP9iX0TvvHBgf5foGSHwvP4pPUA4AA3/8RUuEuN7l+UbrDJSwPEZGfqlqIP8QUxdN2ynJ@vger.kernel.org, AJvYcCXjGUrYOLzVcSdaiaNxkHfWWWpyYWrnTq95nwDuXU3dF6ga73/llaT26SUXnwTNkL0lFeyfymmp4rVudGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSCS1k/2AKa8QCb7eZrqSx0UJuLrK3uxRcEz47mqMeLzeIkBvS
	KOfocmAvY10h6pJnEO+otVk0knpZQpKb3hZz0+0+vFgIGjnMOThjLbr4k5Sa
X-Gm-Gg: ASbGncsqhlCWGtbAItGdFSTCVJSDebJLrp1gVDu/dbOeiQCCZC6UnwgOnv9puB2HKpv
	NX5v0SjPRrI0vL66vlGpff+294PzRnfvuKgF/S4mUPRYCJtXivvepO6+DuGPCFJ+Moqde70C2Ti
	oPJHpmQP7YHuZYaEf29JJoIP7ETRjqZLyboJR/KUzILoqP37J0SfmSCCfpFm+YAFKXUZW54VGYn
	NQlSC9x//5D9C3Fft1QiSoRR/w7oInCNhCYSAs14uOCl6EfhhZZ40mGMIvvP327seA+mAagEd85
	7VItGYRUj10oQCj6Bdk=
X-Google-Smtp-Source: AGHT+IFV8sPRfUhMtyh23vClNMX38LuCZ8JifAGK0CyBawV3sKJgg+OuHPfb+jmLwSAUZYZTLnLeFg==
X-Received: by 2002:a05:6214:623:b0:6d1:7433:3670 with SMTP id 6a1803df08f44-6dc8356d131mr210440206d6.4.1734366569883;
        Mon, 16 Dec 2024 08:29:29 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd26e45esm28844236d6.68.2024.12.16.08.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 08:29:28 -0800 (PST)
Message-ID: <4be52a15-b0d6-4b5b-8b76-795bc04461cf@gmail.com>
Date: Mon, 16 Dec 2024 08:29:26 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/316] 5.4.287-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241213145847.112340475@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20241213145847.112340475@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/2024 7:03 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.287 release.
> There are 316 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Dec 2024 14:57:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.287-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


