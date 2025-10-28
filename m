Return-Path: <stable+bounces-191542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DEEC169B9
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 20:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 15D5635695E
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 19:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695D734BA49;
	Tue, 28 Oct 2025 19:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Znfa7xL3"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E597255E43
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 19:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679646; cv=none; b=u0bzshy8R63EJ4Ryrs5NEIlCoWk6Tj5OvKHjtbiHPp/33EBHdFreqwoOd4+Ts6zxtQ8WrxYqU9DIo4TxcCrfjV4lW9q99ZKiTdFpaHSNMiFfhZVez3V4vLn2gh1R3ehCPbftrsP60rB+LH8SlCjrWPOwFuKNagsVxYNEt2JoBEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679646; c=relaxed/simple;
	bh=EjQDlMKljLoLF1RNLEqNk/sJQiRMv0YG75vPjfuCAbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W17Jbdog11WDHIM+T228cflWZwljiSWBJct8PfJgpuM0RC41dbjq5WUgLKWLNOcTOCQCzIeUjwSCHZ7Hp/5GvWM3fqmFqnFAWocY51h801CcUpHRHBIN21rF0EsOMxYe03VG5onYPgOFn+nA7ppVzBHbIo2iCVeuSLdfeH5i/DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Znfa7xL3; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-430cadec5deso62255705ab.1
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 12:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761679643; x=1762284443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GB2PFiCN2UaCVMnczPZbv8cjpS+ngdtn8TvyTng1lic=;
        b=Znfa7xL36HVagQIIMyIoI+BujbNqgkf8NrzQIjPOKuyIVMjIafWIHa6PR1todHfHZV
         savVsRFoOej1a0lEnYA83dfWj06cTrfMgzbTpaL5usXep6W0g2IFOb4czCYc5gOVUcuf
         7kgibXGQ3sWTTmF9MWcUpApjKSKH0G3IATGDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761679643; x=1762284443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GB2PFiCN2UaCVMnczPZbv8cjpS+ngdtn8TvyTng1lic=;
        b=j54d0NGiAqr7v1aCSOKwyrSbXiWbxi3Y6Qn3m358WpSjfkOGzgdddP4aUvYMEWF1MT
         y9zutemInI/dBHnC2B/vFX1CwIzvKawgtaLoflmwG0DJlIRWDpe7murULU0/0N6x5oOU
         mwDtfEreC7ezJYG3Rx0EeZV95W3cHudrRyc0zFVGOKSlMLC4oVDB/iJAJN0rdkK5YzGw
         RkzlDybN8dEGnvuguiH1Dwnt3coqRyQgR+/RjpeEOUPgTNQWQT/pEjHa9B6X2FmSfbfU
         cNA4fRi6zCNOKP31EHNbK7SKksLpfSH10L+tZEvQQfpYKQIUnCZ9IXjwju/z1fM8aK1O
         0iGA==
X-Forwarded-Encrypted: i=1; AJvYcCVc2MzvzXnWftTYsIj0lNZs1BJtxBY6hNjZDcSY0yJsKFUIwOwX9NCqMu1++1ocaQnvnwARUWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfo1fK6Hp6MvKmbN+tEdCROtjX8FKYF6KXNRt6C07dm1ibYVp3
	SaiccbJc+L0mP5S4PZrgibgvrR+tzFhnvaetSjLHa1x4L3cRFabvz59oGAKoeE8zg+0=
X-Gm-Gg: ASbGnct3XOx+rgmEmP4vJ5WUgxEuagycPueelZWslvXD/FVi6CBF17lc0EeQNp292kj
	7AtFsZuEGL2FC+G6FptatJ1B+mfgCItahVBrI6nUvxl+lf/R3y+LRtFJ16wAIXf3KAJKvtBa2d1
	vgzGFBPxrTgnMJ/T4b89VqGWQJQsXkQw0226wYEWoGsi8MLo7Q+rWcBSAkhPaEwaW0amfJqAPoF
	uYEEAultNgodmBwZSgt/zvn/wQVlAy5yU4jfR0CvHryFSDOTZAU95y5m0agFgEXIuMoB8UpiLnX
	6RHtC4FWLuGWIR6yL+geWM9e4a98svZ9JRNGPINefjYVgkvI8Vde6UfEVhja+d17Q3b/miUS5qQ
	lWtb75uxOCsBujwVh86coF4IvvxVof/MSt3Tki5xYWtadgiAhgF4XnZkq+1nxfpq0zYVVVImqii
	H55aIUsyT9ugPt
X-Google-Smtp-Source: AGHT+IGXVvv4lpTGzJhlhova0pWyuJ1mMuUD5kivB8hewEmKrt3ll5migY+nbLuVZH69B76ZbpExJg==
X-Received: by 2002:a05:6e02:3c04:b0:430:b6a0:1b6a with SMTP id e9e14a558f8ab-432f9064bbfmr5094085ab.18.1761679643364;
        Tue, 28 Oct 2025 12:27:23 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea946de41sm4714939173.40.2025.10.28.12.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 12:27:22 -0700 (PDT)
Message-ID: <91fdefc0-c79d-49fc-a2f1-ecd650ede4d8@linuxfoundation.org>
Date: Tue, 28 Oct 2025 13:27:21 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/123] 5.15.196-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251027183446.381986645@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251027183446.381986645@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 12:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.196 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.196-rc1.gz
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

