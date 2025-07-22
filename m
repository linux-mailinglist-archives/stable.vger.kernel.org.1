Return-Path: <stable+bounces-164286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D17CB0E3A7
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 20:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2E9166C5E
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 18:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC1C280A58;
	Tue, 22 Jul 2025 18:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQ5ZvArU"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBB1221297;
	Tue, 22 Jul 2025 18:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753210113; cv=none; b=sQ7+a5VVeeqxyLekRb4rBuh1KOnmhxVOQtgEKyfr54yU4dJghMtmLLK2pw0Cr2bu8CrlD6RsZ0ASzkEjplcTHWuBmkjfSvK1nUWOhGRNU8dGoZvO3IQdjQT/VkvxnLotb9tx4WVUqLE+x9j/8yzCl1VHBQ62JWokSwapHpJv9SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753210113; c=relaxed/simple;
	bh=zQ/4OwDLfn5dpcA3J5EKTLu+pBN0isLZrN3tDuqtwno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQBqrkNSwfff2wIvHUe7Ntpm3k4Q1Ms6fmfhZsgHaN8MIHlIE0XytPd0ps5WEIj6X1+UbNpNy/ctlXE5QSwoCGYxlqh7nYvJeSrYNx/at83EpRfI5yH/Bhz8eFuWqTy71dAYQI3xOAAIgr/CuKfe+0ZjfM8kvCfZlIQXUpKY1FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQ5ZvArU; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6fafb6899c2so2449446d6.0;
        Tue, 22 Jul 2025 11:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753210110; x=1753814910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9Fj7cC1Bb149c271AILgPqn/RqP8CD+fwWfP4khPOcY=;
        b=dQ5ZvArUhkGiZoNSjJQjPSvebhnPaChd5ML1CuJYkSccVnTZUmiHucciwilFbaayd0
         YGb0hE5I4IDNwSe08RrwxpeNjRgFS2n41cuZO7psfDemhysJV15NNWdEKy3ngnH5+bC8
         lB49054zkcqCxrfPKJDnlEF34dtZp736Eg03uvAfQ6cdIhbGYzKogAEFORZbcYsrYQXj
         CKppUKbzDQhLOIIZOI91iqSCycSjwXHlvn9g97+eUL2Zi8fOMiyc24Ok5CcxO5aWzjzq
         V6m/6jmKn/CYaqY43QmdNR8tTmoduJvBXIytRMWPAzNdISdetdxDydFj6tUBovzDZXuv
         tprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753210110; x=1753814910;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Fj7cC1Bb149c271AILgPqn/RqP8CD+fwWfP4khPOcY=;
        b=COBT1tfNvLcOKbjKHmWdF9Kr7i3h+PM9qnNZKiqbDVKFbLE33Wv00RnLuYZBmpKtP6
         sWQBAhzDxeaZHZCVgQBCRByRBu0Tcj4PEReJ4Djq0rFKFVcCGNSZ4mCSxfMO4WvvFg9k
         20/L0N6dDCOxsQvPNAiolmy9S0Lna19BF/wpV5UwADpDd6VCMucfttXSrWN6omq5MD6F
         AmrgEjeW3NAoEstIkBSkk5kSm1Ifsns6CgNvIPi3D2HSXZ49EyBDCLMMLIUhjDwyBQqq
         bDGjfLxZO2nIzugKgE7HgoaluGWm6E4rtRBJkxSXflr+6tUPdKCOBsUEgxcOeU3cNylS
         0LJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlEY9ijpy5jgkgdqP+RcG2wkYdjwwmDhAXf5wzahozT2fHXPtC9GQJaDp+tJgN4Mimnmp2DO+2C+iCxbY=@vger.kernel.org, AJvYcCXmaqDiUjVvdRnh5Odv14js7r3GvP5RRL5NX8HAC6p5LvL4bdm0sjRDWle8t4od4mb0NJc5ZJp/@vger.kernel.org
X-Gm-Message-State: AOJu0YxHUWXQDiulHaGyFIxsACPhY/19FQ2b1V9WsLLlbgWZPLBEJFqj
	P7gHOqm26pNiLL/SRpbzx89KLgKiBea1YLEfnUqR6rIahIAcNP06/RqS
X-Gm-Gg: ASbGnctHKOk01WKdNL8XOBYfAV0fUGzckcHmNFlEDRDTV2pSYaKLCX7VRZbfHXCcPcA
	K8ot9Z8nX/EfzJc3BIVxlc10un9HndVM/eRbqQKGdI3hGTTtYTUXaxiOiGPwTZuglw1/GHXwfEN
	Rz29rycY/xxr4CgrLQfh6XJM5xN1Q+6QzDiUd2fuzXZjqt9rhgs6qOeoTQSF/+CXk56eFP4JaCg
	mBazZ3B/VTsl1RqUIUy1KrGsQ9OwcHfeBHYKUFK96YVxi7RuNdYucnjeG2p/gbRNTSS/NxhOVNw
	kSaQa7f8G8z+Pc1sCbuvCbJB0/I1Upxh7/DNdPvcmCF/PVdOLOmkDAsVBs+hQfVDJXI/Kz3c0K8
	2+wBQ1lRC9Y0OQwZLBr6cl2LNtepzfeInPFnrVG/6enSkBvURdAWYBGAIMBOY
X-Google-Smtp-Source: AGHT+IE1IdJLWN14lZ/a1hlnhbGAPVlfTg31siwEJTw4A9NxFRu3VoywnycoKul/ySYiWrFw13Skqw==
X-Received: by 2002:ad4:5f46:0:b0:702:c5d4:3c32 with SMTP id 6a1803df08f44-706eb78a213mr55138156d6.9.1753210110132;
        Tue, 22 Jul 2025 11:48:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051baaa8c1sm54367276d6.94.2025.07.22.11.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 11:48:29 -0700 (PDT)
Message-ID: <6e16aac4-22e3-4135-b8f4-64c04060e4d3@gmail.com>
Date: Tue, 22 Jul 2025 11:48:20 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/79] 6.1.147-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250722134328.384139905@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250722134328.384139905@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/25 06:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.147 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.147-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

