Return-Path: <stable+bounces-60487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A089343B1
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 23:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2DEA1C22070
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 21:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669083B784;
	Wed, 17 Jul 2024 21:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhTccMxn"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34141849C6;
	Wed, 17 Jul 2024 21:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250823; cv=none; b=hoIaDFSB8JbOt4OQRl+C+WfOePIWr1yoLV+YggcUa/3rQEu6sXC2vWGyuwM2R4UMQMXHQTWfYvevu9iVeg24Rb+Wm+Xt1uDc4mSPfUO4NzxjD7S+gmwU33bG98+cmn5PNaYNjN1tlseatypGddqsbcXPWoqZzdf18ADRQFgBY1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250823; c=relaxed/simple;
	bh=OqbYl0EtPsiIJ/JzofPEfZYdPS9B1E0efqPwuhHn66c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OdMbyl6Bkjh8UmKOMijxmmyHqXCLC2EkRGrtSPlkC/W+fdN+heHO8MEazOUnJVwYi1HAbX8HOcHFPR6jrD86qFaO0QQ+gKl/+cTS3dW0eAYeJZQndpjVarLaScbXHVy5JKKJON+cwPd3FnaDir6DjyBbPdDqi8arNESEi3OiCOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhTccMxn; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4ef2006dcdbso48316e0c.3;
        Wed, 17 Jul 2024 14:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721250820; x=1721855620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NW5Oy/Lbqu1bOuochGW5ItalKB23NYf6u9CW0Wpg6Og=;
        b=DhTccMxn7Lgx+HOGlo4YA5lxKTDZwDaSLyz2W5UKkqnICo38yDaH9ylCL2yTWcdGhC
         PLwcKakg9AWFNTIzEsDMcEFJ7YxKR3BK0n596rATeM99lTXnZXUHK/W2zb7fBCTbiH1H
         AY4hUVM08/gsIM1xcvY/nuPOYXi54X7ewgN7rsCI5aKiZJyeDrqxuDi6S+uw33XRAmp7
         yGfwxxpgH9KBdXgWUb4PX6f7CsV9oIfJNgX3WdK29HfR0dFDa+HCt1tMJX2ajBUgh8wm
         DRHVaH/xX2qPBEczTKw17pq/4QI3hdwm9BP4L0aTkrF6PSpraqLd8E276gox/rBTB3IN
         b7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250820; x=1721855620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NW5Oy/Lbqu1bOuochGW5ItalKB23NYf6u9CW0Wpg6Og=;
        b=bLpCUREw0qg1riD6UmnxfBYrds8qYf51w0I7AeN16nLd8n7zb0DTpCc6o4lWLOZFLL
         I1jf3+MC+OI8MwcJZe2oWGxxWpElzGRe9AaNlPOf0ItfGbpbobcNYqWrpnMgeU7JeUCn
         P0KFjtJGuMjctED7ljGN+rz4XYCnF6GyMhmaIPzFh7g5agXMShXr0HaDr50Ck2BZwf77
         nTY/sEanP+G88scdRucdwyL062Vp43nIsNhtAYSjUJW6tJjIEoRdJOcWG+ZRoslbZKwS
         v6Xbez+mHKaLmPp7CCABe1Tt/lE6QUT1i+DhlrteC9IBV4rKBjZ3xJZc6r2ETQaH51X6
         82Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWvmM55SVCXpwltRZHMxYNLyOElpLHqCEUGV6RsrJiq44qv2UVfn9KPqkpjDi7cobi+eFTgX0cGe2UPFqV9/5qucxM7DFc4hdzhaU71UMkF8O7fTf6Tj+nMiF2FcH1RKcEl1sqU
X-Gm-Message-State: AOJu0Ywj+lv317NHss+7U+uCITZ6V/tDnXZlj4rPYL+zGGVjiBcilfCi
	opr7mPPQySNi5lMTg9sh0xNZP8fOAgL++n9Vf4iHaf/VQ5MLpb1H
X-Google-Smtp-Source: AGHT+IGHKRMif/y/hLTvwZ/qd61SwN/RQ4C8vEoiFYk45phc3gS5NgJsZUDsoMGJaXBZt1ntEj14bA==
X-Received: by 2002:a05:6122:a25:b0:4ec:f9ad:d21a with SMTP id 71dfb90a1353d-4f4df89f3e2mr3802053e0c.10.1721250820583;
        Wed, 17 Jul 2024 14:13:40 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6b79c4f5f71sm2341066d6.41.2024.07.17.14.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 14:13:39 -0700 (PDT)
Message-ID: <5cd42936-191d-4f82-bf70-2bda0fe2d12d@gmail.com>
Date: Wed, 17 Jul 2024 14:13:36 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/145] 5.15.163-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240717063804.076815489@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240717063804.076815489@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 23:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.163 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 19 Jul 2024 06:37:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.163-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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


