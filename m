Return-Path: <stable+bounces-45983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098018CDA07
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 20:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB772822B3
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 18:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62047604F;
	Thu, 23 May 2024 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHHR9fm7"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32587433A4;
	Thu, 23 May 2024 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716489359; cv=none; b=ZZLktG4s+MasqHGyUxPIfbJI4tpEMcRJ2vuCaHfxdqS3RLSDp23MJSq0P8NO9Syqi3yI+9ikipFlD0u8eiNEjxuQetO27+JvBX79bsCI71cw7HQG77XUsBcgDVFLlqEb2nVGEZSgvCUsyJuj33NVHE5ndsD05+MDgrcwqKLLI+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716489359; c=relaxed/simple;
	bh=e1g4M6PP/Tu52fL0+f5mEFTHjeQVpZLqOhGBVTnrLWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lf4s0ZdI7KQ9YE+k4q5UoD4x0En3ewkWG+IO0nJXa0IcKPLIzXdOvfFyBNtpIfZtZXuCABDiTIrOdrKEs2Te85bxzdEkbw3mj0nNx1Em8vmKeAJ0MiKFiL9R+jgaiyh+HatU/05WZSpOW9Sz3HIRaccAAi7QaQzg9RaJiaOULZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHHR9fm7; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6a3652a732fso13417156d6.3;
        Thu, 23 May 2024 11:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716489357; x=1717094157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AcM1HEYW+RYXL509g3aAc7ycNKgv1hXSbOH207bKEdQ=;
        b=ZHHR9fm76DTpkKvPFI+5FBdZwfxppFAuwmiyGwE73qwYm+oSJhzpF8vMGEZ8aMNm8H
         Qr6rA5jJsI6K2+LXL14xsingKoCny3egQIwJLLS5aNpR3YV1nFUxBS3dPa17P5eaY7L0
         h5u4RYt03PwsPYUhxrk13EjMWp0ZN0gSAvnaozHwLDvPYO8ra4mqHlyv/bHsFyBict+A
         elDfxNSkBCaFIc2NrbRZ2F01sYLlt5lvQkTpGp2s6jLeDUdXUc5DBye7RyVIuecggMKS
         hU8LTVK0d1ojUIiEkEFfDikJG5Pwc0MsMjSDp91xH4yxEM0qIo1DCqvbDeKvhmqNM3D2
         8tZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716489357; x=1717094157;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AcM1HEYW+RYXL509g3aAc7ycNKgv1hXSbOH207bKEdQ=;
        b=BdeZjoDp9A8VOsWi3rlAezqz4HoGjgylJIRfCNGEfmYK8+qbIm6K6QO9IHPqwEomHE
         z3U4E0CkrD9PnJuswL2XsWReIHCdmJiFr0hG5rwFeXGS2t60BJk4yrZHhESOB3WAg/h7
         F4xSDjKSRwp6LCmn8fzU4BxCHRG4C7yh2xqxUcdBVk9S9fkF9Lnnif/pOkDHTtFMW0Sj
         cAi+G+qk/7UQtL3HdtW5JfWoEmh5dvUKSRXYFamhsm+tuF0x6k2H8TKwsvh33UisiSiJ
         SoqLL5IG1DoScsS0WG9WRlWRmHAx1UVGF4pagxLVcOGzoz4fCWJtx+uDq3MwpPeURWBL
         EWVw==
X-Forwarded-Encrypted: i=1; AJvYcCX7yHKprAISg2XXUBnKLR3DWbJ++yUi3Jzn8y5py6d2prwUlkmLRn819hWcsqdwwYhOGLjp0buhPMnOfHDYD9ROhrgYJJw0WIDYwfV164WCqFkfTmakckdbUHQQw/gL1aSo8iM2
X-Gm-Message-State: AOJu0Yyc+fd2qSVEv3HWZNVqRgZi+78MYnBzOvH9BDqOvbVcma3P8mJS
	mYciB1NGJ3kFqn5TkdO41w0oKyWbGImki8nfLFfLOIy6aKYKtKuo
X-Google-Smtp-Source: AGHT+IHsvP5Q7DiWwyS3W7rrKp1gK0kHW8+e5/rS/l628A9sPfGlzh23EaHca7OdXue0kQSpK451lw==
X-Received: by 2002:a05:6214:911:b0:6ab:898b:42e7 with SMTP id 6a1803df08f44-6ab898b4406mr34770196d6.65.1716489357055;
        Thu, 23 May 2024 11:35:57 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6a941c29753sm51784136d6.18.2024.05.23.11.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 11:35:56 -0700 (PDT)
Message-ID: <44c42a1a-00d4-4d74-93cb-fb97be9191ea@gmail.com>
Date: Thu, 23 May 2024 11:35:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 00/15] 5.10.218-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240523130326.451548488@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240523130326.451548488@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 06:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.218 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.218-rc1.gz
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


