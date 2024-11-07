Return-Path: <stable+bounces-91747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EF89BFCC0
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 03:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498FD1F227F9
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 02:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0592242A97;
	Thu,  7 Nov 2024 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PLr7tDj1"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233A2DDA9
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 02:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730947835; cv=none; b=uaUU8gdGxxthnnTb5k4NXF9MrWxgTQglWthwhj7Z3ha0GwTkoov9ojxsyigOshmwgXgkpPotEytiJesXBaKiP1YOaCd0nTiG4SB/W/kUkSSbpf2fne15wD6hRK+AvWpYqRcNuI+GBD0dRAuI1in02T9ScdPurWc5sIfzFEOlbNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730947835; c=relaxed/simple;
	bh=iU8Yq5U1yq8Ri6s5bvf1TqjnMP7Fji6Q8Voe/HqPewE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9Uprh0Xtrueei48R7MQZ/LcIU1SczKs6Zheo2ixPX+S2IRVwXy/Nn7OV6oYhYRd5yfDVJOJape7ChPv+D9mzVf4U59W/gb3Ky5zoGDay9ZOrVW77xf/1Hglmj3eoOkCXrsFK6xBQDzKTdRV+9tWdiLlsfEAdgVOdlhysefdUEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PLr7tDj1; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-83abe4524ccso20295339f.1
        for <stable@vger.kernel.org>; Wed, 06 Nov 2024 18:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730947833; x=1731552633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gDxrDipU5XMaVDAVRRPsfjldbqgDYPtJ2JLlKFXqBUE=;
        b=PLr7tDj1LnKdUusMwuKbudym6fEGBiyeNoHIrwwYCdu1ol7JP0aQIeBQvbTbzybQeM
         G1vMyXY40oHscOwiRtS3qFdBvt9z12snRpngi/tc4859iD4ZrVVcrPHFp03cRqF/P/2/
         taNQ7akAU6IgziFKz7i25MK9L7XzksBtigKe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730947833; x=1731552633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDxrDipU5XMaVDAVRRPsfjldbqgDYPtJ2JLlKFXqBUE=;
        b=GjQxuzAtKFPxCYvVW6++bsW6Vri7yrVUrA0e5OBhW1JwR+IxYauv76Om3AHeM3gTUh
         lvSrXKBjPzfrntyusrkXiG5URq+XVEATmXNBq3w73tamEHHtBYrwgOGrBRmfrdzFUSUy
         sptip1kocbzsRYxotUElUEaOEoeI1yKswMJ9UQuR431V0iorpB7Y+Wn2z4m3lARwBdSd
         A9NLKyusc8YLZyHZVBTFiu2Wb7tJ4FMiPzcVKz/Px2KnSag0FxLJOb4Gdupols7jvnpr
         iNmFiDPNx1VfXJ4fkiRuhVyWGLZqs//MWUEre4Uh9GgjumCyiX5z2gjc0yY21N01ho0U
         Cdgg==
X-Forwarded-Encrypted: i=1; AJvYcCWjs5FJT0mDaaB56yETDwsdtMm0xtkapKZZQjxqTixTiJ7PqkhoDh27erY1GJbLZFXUOdKWdLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjUtXk1SHMtzoTHwWmnA2i5GOtZpOAGBAf2zM7dCqt1uoBnSi2
	TGLIU+fXT6egGAttbGQKvebnrZ/S7y2+H/0QX4S51ztLdCuQVu/niSfW7zowAy4=
X-Google-Smtp-Source: AGHT+IGBvf28hdnALdep5DYPaLK3n1z+yemXA42Tqufg2eRrgyLynA7ZBGCqASfmXtRd3eDSpLE6dg==
X-Received: by 2002:a05:6602:489:b0:837:7f69:eac2 with SMTP id ca18e2360f4ac-83df57bedd0mr71429339f.1.1730947833196;
        Wed, 06 Nov 2024 18:50:33 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83df50fbb74sm10662239f.47.2024.11.06.18.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 18:50:32 -0800 (PST)
Message-ID: <d70c2c3f-aadc-4fe8-8816-00eeb25e59f2@linuxfoundation.org>
Date: Wed, 6 Nov 2024 19:50:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/73] 5.15.171-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241106120259.955073160@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241106120259.955073160@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 05:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.171 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.171-rc1.gz
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

