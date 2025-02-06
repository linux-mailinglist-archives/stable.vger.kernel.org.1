Return-Path: <stable+bounces-114163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EFAA2B176
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 19:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736391691B8
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 18:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D59239563;
	Thu,  6 Feb 2025 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xk12lPKm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9FC23956F;
	Thu,  6 Feb 2025 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738867393; cv=none; b=C/GmF/N4p1IdEcQovH+JbS0T4qW+Qduhli/A7EdewfWd7aiVRoLkcs8/y8+odGUv1JtbegIInAs0p10XAfZiJjDbLnIkjMi0JNygjXMFUcewdaqE+/72CUvdWg0AS4bomtuqRTUnRlaiwb7nkwYTx5WsJvxWpDfq1q3Q0T0zaLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738867393; c=relaxed/simple;
	bh=uAdAXJ3ttfBwLPhGf5YBt3vPt5f0DiFXdkavg0WbUCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Il4kBR2KjYx87ZnEDuiHug6PrctPGfJFTlMUWQdrA0txfsHiONC050UHzxrtlHM2iVxSGcbaB/t/xHTa/vLp7PCz3tT9KIUTl+KMDM3NqpIfKQRagaB2Hz6QDusYEsThpHh3Wm2O1zoOOfeC7Q7wG0R1TK/cuR1VLqndOMjVq7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xk12lPKm; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f9bed1f521so1913124a91.3;
        Thu, 06 Feb 2025 10:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738867391; x=1739472191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o/SGIzDDU1HxCcCtg97Oxc2BICy9BGiv/PmjOhgONoM=;
        b=Xk12lPKma3CSB8v0asc2L/bgyTxXiJJly95+a6vmgYMi1+cnO95RUIVYkH+C1izKIQ
         WPwNXSqXj/bwyU56WkPKntvxewD+/jSbzCRdx2RREV8rtPdk6JW272qknXoUQXrAkDo8
         UdLC6SlxnRrc5ZJRhpkM/EolZ/n+PYWfqSex3Pmfo93xFflgTr6m9/JeJYKWUhC7q02j
         7Y4SIYK0gM7erfSYyIFyeQM4B1Urlc3UtMaVFsZWNY2KybB5KkXuNT3rDWOcmh10CFBD
         JfUq+HBKnZ2I+5uC5LTxihuqrjvUavK13+riuW5+7VzbPF6PZ/OCEO8QINuLGSrK5M1l
         GGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738867391; x=1739472191;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/SGIzDDU1HxCcCtg97Oxc2BICy9BGiv/PmjOhgONoM=;
        b=VuSNwAE2DmteP1ppyq4ewtoUR8p/tqm+4B4e3ovZmAT7OEqcqxHg74Uimv3qelc8R6
         OjKmdZtWyu11Ih6ivI3cXZBdwMU7DxlN+Gq3+0hOEtyD2TT213MH2PIb3+otri7TjLNT
         +QFjGffO6OWdLgAkCsS7ZbJ+YhjlxZFu1lk1a6Qz59jTghDyhRneuUeviUYpHiDsQGyJ
         KBt//cXycL6P3zRCUW7Rf/LE0JCPks0dnSG0FZpijapEXAhYgTvGmbi13M9Q+RkXJ+Zs
         1qv6RaB2pg5zfX5KLlKkQEcSmiNoLtp97RmhFf+Vs1lzVJGs/ZmIx0S1RaWWWSpI/pL/
         J3CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPZYmv57yGdozqpb7+FA8w4Wv+y2NRPeF0yaKBVVDXu/SKTc+mPh+5LYZDPq0Nh++aL7gsWW7O@vger.kernel.org, AJvYcCXiWSVH7elpgNbBaJTj7+V4oRDXXDfYSh2v1Oaj7T4fDq5ImLyuUdGIpTbOTZr3/3UoeXIHZ+P/nAdHuBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2/QVtuSNqK81nVJZrFFZeonNU31wHsm+OQMTHzIXprojnxNb3
	1UJEUcelkd/dWFUGUCg/eleV43td9Z88OI5CcOnRqTffuhYovgIMx6hf6g5/
X-Gm-Gg: ASbGnctCuoSP8R37sMDpStVBS9imXzDMIUxLbE/TJCu9fTCCgTnHGYB0SsV5Ph69ZJQ
	bNKYXEg7wd2+q2siOvrpteyhjQEl2By888Akf44YvvTuBf0qqNQYrGIaaQgvK0VnwOA1QsuNhvt
	qhAzdFQcpQmxi0FV1hcy5slI2sTuml1dGV6foHYQKsjejg2e73Mq00S1bqqyYvhBW6RxpUUzxf+
	AfMCGFOV9TvyQK9HIKNGFv+inBRvqNJ7yQQ8PcHz2g2/zYVeba7SGd2l1Gl1/yLWZrQinY2SRyB
	AAyrGHMdJYJB07w5YQOQ2VtxI4SVmRF9HXFGQ9uISb4=
X-Google-Smtp-Source: AGHT+IGiU24T0A4ZJOX9laIhtVM1hqrLeeLDEOg8OUwzqY7sc88PLn51PkImSwHoo/N/LgXlKs9E2w==
X-Received: by 2002:a17:90b:38c3:b0:2f4:434d:c7f0 with SMTP id 98e67ed59e1d1-2fa23f6e5f1mr182841a91.12.1738867391422;
        Thu, 06 Feb 2025 10:43:11 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9e1e4166dsm3946656a91.44.2025.02.06.10.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 10:43:10 -0800 (PST)
Message-ID: <cda2a9a3-825d-473c-a9ad-10fb7cdf139c@gmail.com>
Date: Thu, 6 Feb 2025 10:43:09 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/619] 6.13.2-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250206160718.019272260@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20250206160718.019272260@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/6/25 08:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.2 release.
> There are 619 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 08 Feb 2025 16:05:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.2-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
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

