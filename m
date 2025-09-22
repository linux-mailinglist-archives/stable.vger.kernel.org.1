Return-Path: <stable+bounces-181416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25E1B9386C
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 01:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABDD47AA3A2
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 22:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A8C27FD54;
	Mon, 22 Sep 2025 23:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLkXlpPy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B82F1E833D
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 23:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758582064; cv=none; b=AAnHIjQiI/DuZV73XTOJJj9HKlEJN2rFwaBAPz1CLZ8T0gJnaDiNuGR5AwDsPOTC3HKwlztXN8JaztL/4F+46N26BlWP/iGQVbudC+cfXyF70LScAe7bwtDf/ftPpQtOgEr5YF/dBkBDzHKNgMzLwjPAhvT1z1q+QL1iddiq8eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758582064; c=relaxed/simple;
	bh=YF49FiKprncqneMObMSuDBid7JTl9NN4qkiSsmutA+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mc2Wi/1MtnaqhT7FKMRhdrbCunBM2P/k8IqCwYuIthmK5SI7ie6if2lFcjYBaIqlW8Wdur24y/3ePCRIHsejXEW0SAFqztUlLiIRssZH9npljgk1WS9rjIablOrrDd9YRA7QCigCom0Z8UTiRwGfSHy+aiYGqbOYjlRL9I2F6RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLkXlpPy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-279e2554c8fso15011795ad.2
        for <stable@vger.kernel.org>; Mon, 22 Sep 2025 16:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758582063; x=1759186863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eeNy2aiqf1BC85NqN+Fm2fdEOmzGU7K8Kz4tZyZLL3k=;
        b=VLkXlpPyWxvPBTPGlnB1zEnHeGSbXRQ2vST1aQwTkBMgAMO7oLZWqCdwwP+mlKq8Ap
         N+tNPB7JdT2Xr6jMCxkFOH8Rv00LUPo8TwF7RLoOeFV6+tQ9fNMra3eDK0E0oe5xcKRE
         ioib/hD3sW4/6lhXl3vZtUbZB0ysGN8X013vAQemSL19gHdk754bdZ22tctGgPaoVLLa
         +Yr6EZfyf8T5ylDmSCTOLM8p6OaezJ9+rUl2LAv+tuLW0QeTlkd8b/ZbZD7VPlPX7+qq
         pc6qIdF040gBBeoIZ/NBw43osNGYEjGZWJ+NImz4GoDHAybcWVehfJqRGj7odrmRJTwn
         jCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758582063; x=1759186863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eeNy2aiqf1BC85NqN+Fm2fdEOmzGU7K8Kz4tZyZLL3k=;
        b=R2PXap2OEUOKoOx1x4aheHQxY9VJFza6LLaRotMTEjya6X+W02xcdR7yc0nVqJ2So3
         0dxq+CflpGVX3IAbyte9JgofhQRXnQa5BR3zXNrV8BFUYAXrc3BosZdhfPXAmIsetx+9
         R8TI4NPeMXgYjfr6+VH6SJz0TfLz+jVrFvBAp3hDMkoBCT56L2Znk38sBaMfknrH83iN
         RM2IRuQE19Dt6TM9wwr8UWCWuVEFxSfeZA2Wnon24SRgCn3dAzOAsfhKy1RJGim3989y
         U16V8xepNyiZpIo6jjlpcZJVY2L2f0kyYC6QF3QGN0PyhPPX8/MFWloYFMggZjKZ7he+
         acPA==
X-Forwarded-Encrypted: i=1; AJvYcCVhxqSb2KC4msvl2JOixHDK2sJTbqtZE8UJ1AILT54L0asNIGi40u3E4O2M1iHE59PTlFuzJow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrHHnnhpTZPF8K4LDnydfz/6JJfxeyLF0FWdeVXWyj5skpOzII
	+CSJQUjGYATxdKylYM54/k/GRcMhRkHjtikIctC1aTEOU2WWigghmVW4
X-Gm-Gg: ASbGncuHdMJ7S/ORjWmSrO7WKomcYRtG5JNgLrIT8Gq3xq+Xlm6ie7aWJIiQKFYafMv
	kbm6ZdXg1M4oaf49nTRIHF2qC4CTl792NVMhkmO1tL98zZL+UokTMAlOuQOCkpGd/9NA6X8YPWH
	ZoDyhVCDUCKl2x82MFjhqIn+/XeqSPvVU+UuNVTbrUpnMT1D66prw2mqZP+he9ISqRc8RdkuXT9
	vyEZxxtQC2wyK16z8Oo1v6oeOtvNSAbwaWpHBGOMRuEB+15u2d/tusbYqjjNUfdEDO0BCS9I5ff
	eLIoRvtp952hi4FIMbOcR3OKedRM+vcDZ8tjt3TtWFpgNvZOzOrExUrYii7WMFaDolaI31HlAI3
	u+WuTqULteeVP7AJAmxi6FtkS2rw+YsIQxQvTSRSqQdN5s9ihARMyTNyFjX+FrBJYHboIYfFegx
	qcY/VwImva
X-Google-Smtp-Source: AGHT+IEJUpXiZJYpDaJSVRMQpD6oGixikoujh15zTGcx9C53XnFLYqY6WqAGmtYFnuvTNfHs9MT4Lw==
X-Received: by 2002:a17:903:1d2:b0:267:c8d3:531 with SMTP id d9443c01a7336-27cc48a03e7mr6204565ad.25.1758582062572;
        Mon, 22 Sep 2025 16:01:02 -0700 (PDT)
Received: from [10.255.83.133] (2.newark-18rh15rt.nj.dial-access.att.net. [12.75.221.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-271353b8792sm80534825ad.123.2025.09.22.16.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 16:01:01 -0700 (PDT)
Message-ID: <b40b700e-6bff-44d6-9cbd-0a208889a40c@gmail.com>
Date: Mon, 22 Sep 2025 16:00:59 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/105] 6.12.49-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250922192408.913556629@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250922192408.913556629@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/22/2025 12:28 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.49 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.49-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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


