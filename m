Return-Path: <stable+bounces-160127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FB4AF8328
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 00:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021D01C2747A
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 22:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A78F298CA4;
	Thu,  3 Jul 2025 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WK4dItlE"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B8D2BD5B4
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751580870; cv=none; b=XXqHQX75JNI6A9571+faqD1TZ1F6J3y5XlqfR1fDtnrwzJgWZAxR/x4DqhBbwzFf2Tv2N2ExpHFdZt2040sVf5vCN1xsye18DZdRdK3RzMoDgAwwxCnUd7V1RbTytn+djSkXhIlpLEwMhx9c8JX5Zx8TksUujgl03VMPxwyanVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751580870; c=relaxed/simple;
	bh=Q0g2Zhkq4WLWccNiTfJX8qbXkS51qMJT0rZHNTxXi1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b72bnJr+EhSZEUvF/3lg0unWvLXQRoJDCHlLPznH8B9y3eEm3vaAEprekAKG/z+XiKvytkastVe5h2KTn0txI40rQKiHlp+hGPFcdeuttfJ6FT70xOVBOPkyIu2BhMNjgc1OpTgacA1cQ/GsYr7aBTV+DeLxwMEoCNYKiHYOYW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WK4dItlE; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e058c64a76so2388815ab.0
        for <stable@vger.kernel.org>; Thu, 03 Jul 2025 15:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751580867; x=1752185667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EMHiazTRC4iQAueFQNRIE7L4iJerZdQRrKQ3VEF49ZU=;
        b=WK4dItlEsfGJ22l1QIEJnTEbEOSsVJQHA9rUjfbPoZmLjWlhMyGVafER3Q2Hg+l5l0
         k+kou1tAnTQhIgJ2KWpJ4SDReifi6D+1aUfAyz/FNhlZ7CM2pzP4mZA6Ao4PnqKV2pWe
         oBGTmI5tzfysZTrruOz5rOROEmjM4xmf+jpXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751580867; x=1752185667;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMHiazTRC4iQAueFQNRIE7L4iJerZdQRrKQ3VEF49ZU=;
        b=T4Q7R+Hah3eQoLl3x8oze7fxQziuB6MJUQFgkz2ylds7+ksNCgabcX6axphE6DXer/
         y+w68c/NujVaZZekPxyKlok+r5te0AZjX4RkfU8MdfyYOPIhq5evvguUEzHNKpn+T8ZC
         QtHNIZYFc+9pZsKSYoYtyXW5DS5vN9vo+kB7DIR+9iLLDMbmRtVM5acB4ncO/18UQQYT
         VAzE3i8K9UZa5tb6eONulnBLCoZ/6S7la9e7x+rq1PuXNxvx60bVIM5wvxvy1eGzo1+c
         HheXZ1IZ3Upcatd3ww7Cnvkz7WCJq9Opsh2GKFdgchAAo1l4E2l+h8Jxja0BJ9rAjIK9
         YWnA==
X-Forwarded-Encrypted: i=1; AJvYcCXZZpMZ7e63xBatA3DaImx9wdiphlPRKUHuxte5E7tFQRdglKfV0i2pid4IY+MrFHpVnVeyMQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz8YfBLvVb2aX23tcEGf+y0kpViixNj7VRchKxh5L9kHEinVvs
	2ItRD5Se0CduUpfqs48BvFLtj2qhzKjgMc/lbl+YblS979xniN+zHsCYjMeoQUXzhNQ=
X-Gm-Gg: ASbGncuOxHqfxYunvdgUnCkRcyKLCkomUR+t8cGW+NfmC0tZy1JDuoZ/OD0TyfU/4Oh
	x09AUIdlwA/I9gmRTQsaphYkRt7wwPhot3TXhDBgce92kXtv4jp3VGsYBajLCschk+EpEW68eFc
	Y+79pYVdcPBA8Yl4dpDrBcFiA99jrvqQQQLq48HmFfqjZYluPWVSEEcclUZBn9zU/hOIm7/gSD6
	GXHXDXYFAiU80aiEuErdMfELdPWBBsl+1trsrs2yt8fA+zwtKPe7MYlBze6IQmNq1G7L8RAstPo
	8zxdbsLpWgO4NVTBdGYZqEzFi4SgrQ9yabpC16HZjJONcZ5Yz989LQ5vuysXn03wIijZv5gleA=
	=
X-Google-Smtp-Source: AGHT+IGKLsYwNxaeU1iL2zR7dYli0csm1SLeIM5zBOhqUdaib/shcWJHmANH9UBvLtxtMQRqBqR0DA==
X-Received: by 2002:a92:c248:0:b0:3df:49b4:8cd6 with SMTP id e9e14a558f8ab-3e1354fff90mr2023985ab.7.1751580867397;
        Thu, 03 Jul 2025 15:14:27 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e1004ceafesm2134355ab.61.2025.07.03.15.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 15:14:27 -0700 (PDT)
Message-ID: <b6644009-7494-44d9-8480-5042bca1b952@linuxfoundation.org>
Date: Thu, 3 Jul 2025 16:14:26 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/218] 6.12.36-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250703143955.956569535@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250703143955.956569535@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/25 08:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.36 release.
> There are 218 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 05 Jul 2025 14:39:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.36-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

