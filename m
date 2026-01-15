Return-Path: <stable+bounces-209963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C34D28EDB
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 23:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74CAF301786A
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 22:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A88E328605;
	Thu, 15 Jan 2026 22:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUlRsi5B"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93062307AF2
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 22:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768514704; cv=none; b=NH9b9FDEy2CV9w98giX3PIADGLGk5Hr7MFj6p2zAO/7C3L34tYAsWZPemDX/hIoo+D9D6AyhTD208FiJJM44mpYNOu+5oAtYmhoB8zLxqLz4h+KjZQeCQU3W+OK+dTNghqgZDqrxnjQB7M+A2GsZa3qQ3ye5MpG4388f5VK6vEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768514704; c=relaxed/simple;
	bh=R0b8VCHSbkBtpdh8j5P0vV10qmB5MBVPUur32MQ3be0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6w0yz3kNwE1GLHfsuxapmYBGGkn4Ul/NIDbP2Urjphh1HTUAdUyRWuKess4f4Fk9V/1ZCvVV93AVAuKWVNYML5zwFRFM/xJRf46L9XWAiL0BiEDlRfJ7d26SUlF4idoVac+w3f7DVofuvRY4rLxdfBlLr7VcCLZo5tN+CYbIZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUlRsi5B; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12332910300so3466591c88.0
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 14:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768514702; x=1769119502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hMhG1LPQ13v4M6oficiJe15IjRoHXbIMZN4u43rTwMA=;
        b=bUlRsi5BPSbbQDHrxZGci7yQ4TPYeN8egbXma1SUBEBg2f6uRsgjWHK8wG4aOnfzHD
         rzsFkhydx1iwhEJd0bil72KgBWumyU9P920Y81FdCleqa9Yv/8Dshl/jb4X1xYyQCAYw
         Hsr0cGH/IgT9aqdzFIBX9R2IgnYFAUuOaeOiOlPVpBMUFL4Y2ehtK3yjYcyHHysy2yAs
         rGtPHD8Ndm/LwWo/p2JCUO4zMP0snSv37U+Wv3qVexwN0ULgUhgOONRqMXICIFucVnSE
         CurpNqeINZFIOTl+1mcnay4lksvBnsB+5J1xdNuLaSczFu5elGek5BqT/HGsJoJHIa6g
         Cxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768514702; x=1769119502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMhG1LPQ13v4M6oficiJe15IjRoHXbIMZN4u43rTwMA=;
        b=NGCPm+zSB8equk3kSM7Cj398RBvNp+9YNlxuwuOC+7Q0uwhhchVD46tKjRoXkNR+G0
         FSGPXSIoDgJhO9SOPh7z2t/HM7vGlpBae1U2joSMt9+GEWWuo6vUkLCAZ8lOsKR3NtX5
         6ltWslXDbtiMEH/MMVwKn6Hez/u5lY6zMdo8M9gd8H7bei3kjTvNiVbiqL5C/EnCCdkH
         H50njABF2hbrm3QA5lL6x9pVqnU8E/tgG7CUgGypj2TbaxSNgLRSYYbYDrsn7eA3tZ+X
         LFdFsR+49v1Ad3O86DuSdFX+Z95sAC+D8vgSjLlA6mYjimf8PrPZbKyWkKns0NXj9aa4
         nFAg==
X-Forwarded-Encrypted: i=1; AJvYcCV67KdG5ad11emhSOd8c7euSFu+T8I8miaHUSh3P0ELeBu9dEFEXEnrPaiRiTnVnwI8409wewU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQDx04pXwM5KfgBGqFM+khsEDW7JaKCh15/Gm8IAXE7XIKsHPi
	rUbsdVFQ07WAd25ol6ARqOtcnXYWEhINuTZOZoaxOqPjIB21VXIIpToe
X-Gm-Gg: AY/fxX6dTHV/EquaHrkV6q/abHqwqLOfi5CKRRnk9aw4xjfDLwfZnMcySwTr68RVgdD
	W4GGJoLjN4gCqSoaYiASUepesdwyAaRL0ilVVcQiilpFL6WUf68W3GKKNOZh6+PWwjZj39DSVY2
	WsKGXG20lDmN8256EIFxTjFXZ5NNcbA3c9okIlSnzLAn5fcsINXmBm18uT4cAEgXLAI8CxKhi6J
	ZfekKWUJGzfKT1juIBUDjO2gz5/EbpXij788Flos9+QpP4XTWMjpimui5KkO72z+eYNndlmtcb/
	rBOA8kHooxLyk2YzBLaRvwoif9FYmk2jlKmaboB+KpFDHBnzNZ25FpoAHhdgCzyAf4J9b7LCb5y
	pFPB8HUoX1DOueF25UL55dR1sk2p5H34o0prlyb31o2Hx+DYh1rQ8sCM9b4SQEFa5xKEtC1Fr9D
	strhjBtd9q1oKBtTLKORvkgFyxl7bExvn+otRMpQ==
X-Received: by 2002:a05:7022:4581:b0:11d:f464:5c97 with SMTP id a92af1059eb24-1244a769945mr1456056c88.39.1768514701546;
        Thu, 15 Jan 2026 14:05:01 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac58140sm638426c88.4.2026.01.15.14.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 14:05:00 -0800 (PST)
Message-ID: <7945785e-93c0-468d-af89-94473c7f6186@gmail.com>
Date: Thu, 15 Jan 2026 14:04:58 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/554] 5.15.198-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260115164246.225995385@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260115164246.225995385@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/26 08:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.198 release.
> There are 554 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Jan 2026 16:41:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.198-rc1.gz
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

