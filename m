Return-Path: <stable+bounces-150730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2C3ACCBBB
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 19:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 306BC168483
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 17:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6571C861B;
	Tue,  3 Jun 2025 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NrneMZlq"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F46C1A3172
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748970614; cv=none; b=BJyybfhGYaEuFNjID6BYv3rWnULmlJ5bQd9GajWL7AWqycUBG5RJ/lVSGfLAvjsMWNPy8xmzusqdA0CPXW5z1Met1f3Sv9HBB/R0wV9PMiwGTfkmObfbzyr29EQ9SfoiQESO9me60x3nZokVL2dXGNuUjRGLxRmWwlGq1M+a030=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748970614; c=relaxed/simple;
	bh=hOOfI2Dug98p149l++sUktgtwoAOQeQAHNLd9hV4PXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTQYok1wsdqLl8th2StS4g+9ZHCXvR9STOlU39IAvL8a5cq3BTkx2JR1Mo4hrAMDuz9XH4irh7hnfZ8nz46yB1qRHzNzvSm0OJhO7umtKAyoFdodMkn9A4pGKL80MUiMA0RMJw82n3DOl/kPQtW+U6AlNI7Qz+iMaNw0oUKhdZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NrneMZlq; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3da8e1259dfso45109695ab.3
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 10:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748970610; x=1749575410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+PTJ84mgFgcvQUel6fKqwS+aPNdc2Y0X4akYmU/33Y=;
        b=NrneMZlqdYZYQLFK7DWtdWfvtED9eB+5ei+lO6tsQfOb/ATzJt2xMz8nXIsaLQoR8o
         dllgQF62YoZKARrJsn4i3U1nszM/ZGzQNuXLzBc9b71C2iu2++5iJ50mQCumtGrT5Fws
         KNdtE0xzyXpcVMJ3gdEnBByZAyye3+RLSkcsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748970610; x=1749575410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+PTJ84mgFgcvQUel6fKqwS+aPNdc2Y0X4akYmU/33Y=;
        b=ZiKX8i4bEmCHlsV2i1tA2PyyJgXKQanEVtThM1lnu44Xk2DE7F4Zg+IFlPNgSZeojW
         oMdMRX/s7Jtkjs6HBKOk/iuYGUXtFYaOfN1lU7YTiQ4OGRdI5XyODNfHsd271MGO9aTz
         AN6T7JsTK+oVhhBOkvPO+WrLVWNYWtZBfW1MI6eDcYYhMMNyvlNqzrviLkLnS1NGjAne
         iMyRDUT7TXWP5PxqrdUipuMZKVgyFyaUpc0Kcn4D3X3ldjfA8wDrQIdHfhRfrcdmglt6
         9hs+d2yAK9yX1X2H+Hjs3Cx3AC1BaB6xZQid3bayUaSigadN5eUfyUSmTEff0ZRffjGI
         URxA==
X-Forwarded-Encrypted: i=1; AJvYcCWoEm5e5pCrVMuSvTJ3IM1t6ZXhEwGfVR/ktXiXvFh4TT+4G7DJ2QlsnTtoFIjc9rQdnbfJveY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9d3wUc88RIv/I6BfEqXzHAB07O6LQG+A0NAKu4W6w3t/tAeJQ
	SuIlbqRFm3rRxF+GCw7QVQdOUP9lMcSKMeX7YCHXBTyb2Ai0+woGSiFQGLo6UkrsNgV8pqvOGWi
	SGOZW
X-Gm-Gg: ASbGncvkqktDxjd+6m4aJiEo9a9NTR0OCXhV58UabrQ9H38mLO3PMW/QjmLAD8m2eU1
	LCi1xklHsy+fOi7J8d5GeSu1T/4NlIZYjrlVKVcj9GtJ7afqBnbHhoMNrA9IxO7zp6bvew4IEC9
	aCyxJTHt52awZ28opwgT+JE6NQXSEAdH6j0GH0qSkf/LdntkAukhA0ghBlQUaparIvS1JuSWwfF
	Pk4hRuRBcs1aTwykzxLm7k616hiCFMdMIAp8vHjQtLhP2gJ65qPGZ5wgNYs/a7dWyoeMiM3OrGg
	S7Vpglev1BzzG7k8ZHVQGNCXaRX6fYzkoNwwE2YuCd6PfeSG8HSmO6gJ200AnsPpPW8pCBYu
X-Google-Smtp-Source: AGHT+IG2BbeVXOuf9sjTCAwtxddMMI9tpH0ti7rh05AzQMoKV5AwNcYiGuPTbl2svFjfDk98wBdrpQ==
X-Received: by 2002:a05:6e02:258e:b0:3dc:8b68:8b10 with SMTP id e9e14a558f8ab-3dd9c9887aamr196505085ab.2.1748970610548;
        Tue, 03 Jun 2025 10:10:10 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdd7f22536sm2407800173.134.2025.06.03.10.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 10:10:10 -0700 (PDT)
Message-ID: <a6b019ed-a143-43b9-9ca4-7cda56f35568@linuxfoundation.org>
Date: Tue, 3 Jun 2025 11:10:08 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 00/49] 6.15.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250602134237.940995114@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250602134237.940995114@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/2/25 07:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.1 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
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

