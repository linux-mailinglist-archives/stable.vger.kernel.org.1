Return-Path: <stable+bounces-161320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC7CAFD532
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 19:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E348717E865
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B58F9E8;
	Tue,  8 Jul 2025 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLdYxq/O"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5604F2DD5EF;
	Tue,  8 Jul 2025 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995206; cv=none; b=jsyQiX6Rq6LxdDYPyv5wXqvY0BgZsBcNf26h3CPuMMzUTcJ2pC2j06zJwy3EsHXJSe+ekbOttyiK/CjS+EPMoM2m0GRt9sraIrJ6RHpPb9bZ1Wpxh1nqsWcGs/5QPrvGk3UXp+orvWYfesm1/3PNHhLoTgA1s01peTMYJW9kg2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995206; c=relaxed/simple;
	bh=5HKDLUwL/LdlMoeCZ0mvFi6Ak2fk9HX39Njg+XBJbDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7gOwTsY+y0DnoCcrfBmfb0TvbzS0/W1UMO+FwG2y4vEHGmj70VGAyM3mLsgFfwj7rQqNrpWQo2faz72/Cv82fv4R+Ww05SGhTAHXM6ReI/sbHtdBFWbE2l3zCoiYM919x8EU7AdJcwKUvcEISoFYEKs8J7llGpV/adop0TXzAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLdYxq/O; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b39011e5f8eso2717280a12.0;
        Tue, 08 Jul 2025 10:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751995204; x=1752600004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9ONPi5RfC9AjSuKPoYYov/Aga4AW9k6qwLcUOFYQQdA=;
        b=gLdYxq/OEQs0M5x54kGINJuWtFPD7SVuevIaV2lrsGLgUkrlstu/vE9XyuuGROqil1
         KHBf8ad1nwgk29uasqoBv6ol04KkZBYY0JvC3LwsE93w9nG+hkXjwsWGdUCrq8Ahd9PM
         4Gjs7lmC45kDayg0uKeIkyzrMAtw1Zrfj6cNkAUw5MKwdi0It9DBMOCaJ3j0PSwb0qRx
         dtBDK8aq80yYNyBUw9W1JIVHHH0p89tcTaZKfMv9Gsd5nVn3UNupT/gZtyJJpFZvTAlI
         2u5CMlXCqHhc8BlNLEvYvWUkcA4ZNNs4qbgY7ouRu9C6RnxjpL0iVnoC50myCarvQEbf
         sPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751995204; x=1752600004;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ONPi5RfC9AjSuKPoYYov/Aga4AW9k6qwLcUOFYQQdA=;
        b=l9fANcfOuT+RpSDciQ197Co0q9dZ2E7alzSnfDepTWYpHppB8Dkgi+bLO58Sv9K4al
         KhVSCZr9kluliOD2uplcGVLJw9ZbE7MlmsHDDhZLeLk18cPMQ4swDxmdQnfCsnh/YfE9
         uVn1xTntXJ7wdbNUtxfpFlWCDK1suRmYdqH6uc7qGUn/PrVxaBZ9mV7BwzAVJeomBufr
         oGYYjmWKX2wQxYcu30+Dw4DVyUyW++ww3Id5zOf/t+7G7pM+ybxl3VkoKZ5742O8J1pF
         G8Brt2pLYU5Situs7+65UAMDKvCNin50eiMBBR0mgiuwho2f9lCYMXyjMT2ti2D0RiLc
         19VA==
X-Forwarded-Encrypted: i=1; AJvYcCVtt/KSjFT8vZdLdU26TikrajEYn6+OYgsGu9kFwMe7acvKmMbpyQKcF+ZaLzSSP11xiyqF/fZ8@vger.kernel.org, AJvYcCWKHTdsVVud2fKyrNwUVAEgzxRS2XKBPHrkxu05zKoMm+6dGQHVCku4VFEkKq+Fsp3iACrNGGKJuZR5Avc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMSMWYmBZglg1xEVoBaSj0SJLXcM++OgFS+29he8Ku3yNSysoS
	bbN17Sw5u5est8lEutYwfNQVk40+M0GaV9bwW4iaayP3tSpXexL4yL5C
X-Gm-Gg: ASbGncvGyyZHGIoMa0oeairq25RmDjpkoHupOxUEbl+IzmK0X/hawsTnsf1+VlPJeu2
	ARZQPncO/JWYHgb38kLp1xr6N0fiX72o6PMekVQ1OxsHWD2j3ab00hUyu8hzv+0+WdBYpS2PP04
	yTO6fVfJwxcheXx78BnbpjVAqeJ6a2p4po5kW44FZDazsSCkoENcPMLthu/B1W4U+9BXE6EQXFy
	xXXws7JxDvzB+7hpmiWmwk9zSfOEgQ6Tlc8N4HRZ5tWgaehZplaK23H9nsqDKYhYm33M8QN27+o
	9lHMY3QmNaQGhTgN8a6WLh4w3cytzBsKCoZ5qMgcYRTkZL0fTQgW85cMrJA8mlB+0D4N2/fA5M2
	ifzAGh73EMs0rfy6l1PnUNQVO
X-Google-Smtp-Source: AGHT+IF+yI8LROtj0p5DPStD22YvfLpioPplA4G0IH6B6dY/haS9t3i+nGdLM/G1uO1e+QYM/i4g9A==
X-Received: by 2002:a05:6a20:c6c1:b0:21f:563e:b7e8 with SMTP id adf61e73a8af0-22608fb3017mr28149530637.4.1751995204221;
        Tue, 08 Jul 2025 10:20:04 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42a17bcsm12417556b3a.130.2025.07.08.10.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 10:20:03 -0700 (PDT)
Message-ID: <2438aa80-091d-4668-90e0-fb75f3e0b699@gmail.com>
Date: Tue, 8 Jul 2025 10:20:01 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/160] 5.15.187-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Kim Phillips <kim.phillips@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250708162231.503362020@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250708162231.503362020@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/25 09:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.187 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Jul 2025 16:22:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.187-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

The ARM 32-bit kernel fails to build with:

/local/users/fainelli/buildroot/output/arm/host/bin/arm-linux-ld: 
drivers/base/cpu.o: in function `.LANCHOR2':
cpu.c:(.data+0xbc): undefined reference to `cpu_show_tsa'
host-make[2]: *** [Makefile:1246: vmlinux] Error 1

This is caused by:

commit 5799df885785024821d09c334612c00992aa4c4b
Author: Borislav Petkov (AMD) <bp@alien8.de>
Date:   Wed Sep 11 10:53:08 2024 +0200

     x86/bugs: Add a Transient Scheduler Attacks mitigation

     Commit d8010d4ba43e9f790925375a7de100604a5e2dba upstream.

     Add the required features detection glue to bugs.c et all in order to
     support the TSA mitigation.

     Co-developed-by: Kim Phillips <kim.phillips@amd.com>
     Signed-off-by: Kim Phillips <kim.phillips@amd.com>
     Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
     Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I don't see this in Linus' tree but it's not clear yet why that is not 
happening there.
-- 
Florian

