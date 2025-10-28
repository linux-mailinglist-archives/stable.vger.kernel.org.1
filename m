Return-Path: <stable+bounces-191512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A29C15CAD
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 17:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818971A22658
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 16:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482DB33EB02;
	Tue, 28 Oct 2025 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJf2QXDc"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA6A345738
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668444; cv=none; b=F2BEKGt+SKrjQyugS6lBSQ+llSEydZ3H46ibVARoA2Jn6D6Nf7Zn6tQa1qvRZpPLYYOtqnvPbc2aRbK6i1BDqVSnjvT89xLWnKjZtDoC5lGwVzFMvtNbGzhP+pElG17vPchVOzDdo/Qv1k/gwX5twgFezcL5tj5+GkjfgkzJIGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668444; c=relaxed/simple;
	bh=HH99Hm1/4ME4y2NVT7mTUovpgSko9sHLYoPoc4qGOcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qm7X2fPL9MlTs/pgCG/XEtF5PJsLvk0wwfrOmyvPgG7k0kmHUpKcQgFmRRFcWE5P4ScapNIJ70+bwTf8LAUGwd1Oe0tBvxsNl94kRR4k6PVdCeF/aBLEREOY+vRXEq8sUO1ZJQAkBUMGC1gqNn3yfxI+QMLrCNKJwG3VMgMXick=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJf2QXDc; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-87de60d0e3eso63558326d6.3
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 09:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761668441; x=1762273241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBw19L+zHPRR+YuRqFX7epI1wOiSjzP6L9/PKbP4WH0=;
        b=bJf2QXDctUqX/W4nwI1yFSZcT/LC8tHxnnGuquVebCQwCIkzHIxKM62q86yIsG1glk
         dSBDyL1Yn1BRmDbBl1YCagQ9wY3DbB5NYQmdyk/3doCAFz72bdU/hQFLnq2lx64It59U
         //+Onhle66a88C1TButEJWgBySCuVLraBP0VzHwiU5wRoFSB5equLVrPP1DoPBoz27Ii
         w6iP6Uk4foMT9CCQaJE160G4LE7+JHbIDy3X9fp1qANW7QUop8DC4FfgdgOgyXQTXVCB
         YRk1ZXwn+l4OcPYHSZAbcz4s4pSaeD9lB8/KicLNIjPFwJe3oVfVpv1Kr7a4r/DWbKTQ
         +ziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761668441; x=1762273241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBw19L+zHPRR+YuRqFX7epI1wOiSjzP6L9/PKbP4WH0=;
        b=jVUSpCs+FbsBejidt7iFdpbv/mwgGakXN+RaajqM6dnL6Nd3Rp6O2GxhttU0aPGaQr
         L6xkBwXqSoyNcTXb/jXZ5TnChIOiAxozuTWSKCXitHO9vbQwuJnMZnAJiN37qYHMdgkn
         FDlncAv/5SBufJvfvBVvf0NS2CBpPZ+aS5YVwVUIQykmV7zea3GfkJNaRTWzb4dGTTLS
         QnXEwBrINzre/fJoZaqeJKvssWuzTOeofj9tsxH6g44axowIkS1llTZWjsK+PKSRUYwN
         PkLkwp5jP8CEq8LPRxQVC1n0wj/RkumsVeheBIItNI5pCaOx3WSsHTVp96oD1kkxlfy7
         /ftw==
X-Forwarded-Encrypted: i=1; AJvYcCVg9SWME7zqol0UXIeS/yBvXxhwRy59itWVarnLbuOoS9B4MZ3qsIcaVNifnGriX872zL5n+fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVHNNrMvfeebWZm1HEFYxorQJXsum3KkbooYhWL5i7NAV1RSi+
	6MxSxWVy/Tlcy5gYDTbnZUFJ8Pxr7RDliSzVkzR2u5fEVIHOPzf8OWHw
X-Gm-Gg: ASbGncsCqx6LKOBvuilWOTg+LdfSumnCH1ec6IsgYvKEra/O/cyGVNfkS00M9ChPsXv
	XwJxsIE/MWRGelqWUzyHCTIYSovDfv+C39VefrKl/YoucICnUgeWI+uol1oGbGp3pt4M5SkLGoH
	h6ftkNs9fD4I2t2OuVW0yDEwixb6u73y9EcFv3+/MuM3ZU78fXqC3ejGaCrw/H4Vp4oN+aWwJ7K
	vjhjGhDIY5qCgfxNWHqBv4WiTZvbbd+czlJP5dVqL/ZB1ZN7hwiB/SToz/74mLGM8GbUFQnExZc
	wZCLO40vTbk4PStvnmsmEO8xRMfN63crQG++VaZZTREzvVfmVeAOwKylTFj/czFz3ktQhUXVfuq
	5rGwXenBHc5tEQUOF+1RB7XZO4O2FqoNCSCwL0GXLBVjQ0t4Mr14/Jmthb24hYpFzcaRKedbj7y
	VTujyZFna/ULBmBLTBzOqYBY5yoQM=
X-Google-Smtp-Source: AGHT+IFiY7niBCsgWr+WrtN943Z11lRxWOW9j3KP33GiWaN6m/57e17SHj2oKDJ2x2+uveoFhStVnQ==
X-Received: by 2002:a05:620a:4052:b0:8a4:19a:dd5e with SMTP id af79cd13be357-8a7008e05a6mr507815685a.68.1761668441025;
        Tue, 28 Oct 2025 09:20:41 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f25798ad0sm838599385a.36.2025.10.28.09.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 09:20:39 -0700 (PDT)
Message-ID: <f978f5e5-5828-4556-a9d7-1f8df8bc16e0@gmail.com>
Date: Tue, 28 Oct 2025 09:20:36 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/325] 5.10.246-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251028092846.265406861@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251028092846.265406861@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/25 02:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.246 release.
> There are 325 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 30 Oct 2025 09:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.246-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

