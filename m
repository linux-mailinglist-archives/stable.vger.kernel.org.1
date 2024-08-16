Return-Path: <stable+bounces-69369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5689553C2
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 01:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D29B1F22425
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 23:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697F7146017;
	Fri, 16 Aug 2024 23:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcU9TquP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45E812F38B;
	Fri, 16 Aug 2024 23:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723850510; cv=none; b=mQF1Vsi6naa/y++sYx6GAAsfEQtHW+v8ZLHe7EHQ84HKTW1eEqqK9fnHFpU56UB23sKQYRKjPwZUBVZ7W5hEa3V4fa7VscHi2uLWdB3NZRmDTbW17TElQNOdWnqHkm1Xx90iDQ6YPiaN2gC/Dlnwc9fyKxQByze+U9q5NPN2iXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723850510; c=relaxed/simple;
	bh=CV81POIClX3X7qXJ1I3KNNNkLr1iIaGW9RjKBi9Ck9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lsly6BQHWvSCmT9DtItVf3oxcYPE3jfRV5biVbNFdDmdVJNuFRr80ShmMM7s2XRcMBea9lLLdXAJ5279B5AbPWZu4ad6/x+efH07sBHagSlXhfUPl8fff0tmXVx4zuibJIf0777Zjwir6FmecPQhF8hfmyKh9zz7oNOdREWE+Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcU9TquP; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-201d5af11a4so24511585ad.3;
        Fri, 16 Aug 2024 16:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723850508; x=1724455308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=48ywkouBR9NsndbOhMMuHbOigPSzj4CFV9KRr4U5zl8=;
        b=HcU9TquPitOlUZwvRpg9eU7+bMztSk/FJzZ2RBWxyMTR3ohpcYRwgXNrvz/w6B4J3o
         wbuRiWsR/77gjk0jPYCS/kQsP67hTnumHNl5PH5X85ppwI1d63SwflzFruy5NBXkMQHb
         R7GAiYbEy6lpcr34i0zDbaR3Jqtx58AsetDNirjSLAPK513uVRCANsruwhp7m5KF+OYb
         2dGI6ziTjh1X3QVHcLwAkM0PhsMsXh1gRwOH0fFF++wjlrQ73mKtmGEY6OsyVynXfG9J
         nMddBB7GEZlWe7UWYcc0nl37Eeiizv/g6xqJfxab2RtuNb8XCqX7x3g1xz9t+7N5s9kI
         jbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723850508; x=1724455308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=48ywkouBR9NsndbOhMMuHbOigPSzj4CFV9KRr4U5zl8=;
        b=wuDw1ULFyanZkfHMNHjRB8hGlmSmQ3jE+pxzYjPRe1+Mm5IrlXBJU4qsgX55fSvuSu
         bcfWf2gJCCA/gBrNt50+2Xz73Pncude00irAZrb6vH0LjtdQwmfyOM3qapB/3ckv8uHk
         XBPwdZC0IzA0bFzSeXmNixo8CzL/sYNNmErxkTit5OWKQd+rXakJqhA0+T7J50YqtgHh
         ynM80dFcyUIE8fy5k/YA1TbHrBVNubPzfOA8SY3FAMuENlosHO/kz9hRaVtn1lOdWPqj
         hvMdpFAmR5VaAm9TS1Xb74KfCLDA9qt69Lfp7KDFvUWWM4S4GkgyG68hTdD1HyA75F70
         /DiA==
X-Forwarded-Encrypted: i=1; AJvYcCX9encavH0dZmwkfsiteJiUDEJ1TGq+zT6SGE540YKTGxfJ/HRXEgOwYGtICHNK8273iYmeRkfT2uLcI1aYWk43F5a0eWfOeg9wT7EQaPTgeQcy98emUYX8ou/zYBsDu5QEf7Yu
X-Gm-Message-State: AOJu0YxWUoCfD4IjEWS2qW1awkVZrvFtHeADQGbEls5VakOu2tGyD2+L
	4qgKxT/c4dAkjb/0DKMUxlVqpA0p1M2LBIFVUiTjf+g24DoUYDtz
X-Google-Smtp-Source: AGHT+IEAmpTN/Fa9RR6HbKj+WSlzjlqus8SmI9QThmBB4T+MCfCyKQb9JtxHo+IzbcOKcR4Na/scuw==
X-Received: by 2002:a17:903:41d2:b0:202:19a0:fcba with SMTP id d9443c01a7336-20219a0fe95mr9245695ad.41.1723850508145;
        Fri, 16 Aug 2024 16:21:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f039ef06sm30290985ad.249.2024.08.16.16.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 16:21:47 -0700 (PDT)
Message-ID: <92617a85-3a29-4783-af76-6e75740cbc05@gmail.com>
Date: Fri, 16 Aug 2024 16:21:45 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/483] 5.15.165-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240816101524.478149768@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240816101524.478149768@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/16/24 03:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.165 release.
> There are 483 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 18 Aug 2024 10:14:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.165-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernel, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


