Return-Path: <stable+bounces-158429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 326C9AE6C6D
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 18:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C36C5A5447
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 16:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CF12E174B;
	Tue, 24 Jun 2025 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQpOBC9q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503C6274B21;
	Tue, 24 Jun 2025 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750782626; cv=none; b=Mv+Hl3BW1i5MJubbR51QeOykRjEcRrjk0yItAKwTv2MTjFqWxGNk8Zy0mVVoYzkAWWyCnFobQah8I4n5ur9ebq/KcAJnjB03gsHqqIiJIJyU6UULi+Kl6akiw/tqWUlsI7pl4U1BjiM+9vKHusopaDCuoaewMbEtqWhVxGsz3o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750782626; c=relaxed/simple;
	bh=gKMPTkfUjmeGkeTinayig8vCmkghRWoA+dn4/KL/Vok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQWtrDHzG3PfJ1GLVfCF1qf4UVLpqofCDLX3I0Hh3RaJUuy+DKRXE+eCZplOHAvrFw9nfHQv2Kpcd9QdIpa3343zxWF4S7JFCvL6+TQB1sSll46kQyC7r2xcFWRRQ3GqTjm/bm3zoucCZy/YZ9waLavw0MM50dUzf1+ZkdQctXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQpOBC9q; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b3182c6d03bso930369a12.0;
        Tue, 24 Jun 2025 09:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750782624; x=1751387424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4bZoTWO4+wQAYyr+HiGHwhWvZDtBUnYSBhmhbwbqVjs=;
        b=PQpOBC9qfKeGblQB5lTPJ7zxCcYlXqRQkEbW+WEeHA9m48zbK6JIzCGmi4NntrSpa+
         /yPqj37SOtuUZ33kxyC/PfEBJwB4pS5KRvU17vCJak0CjHHTlTBtngcneNBMQ4De7WFI
         Koqks27wHpB0FEK7BHf/E+6kSBNx5h6g+yL5+0+m2ceYGldLheBS7zfbeQWPf34lY30P
         jjZcy6kL1SXx0ueYLsQ63XgnC/a/XlIrmEptGlKGTMGyB3NVBm+5mi7NP5hy4RhRWMJL
         h+Eye7gvb4dLoWB+Tk6JAOkrnN9ciZkitw6dyBOAF1VTRyFtatcyE01yg3TxLH1hf3Go
         OHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750782624; x=1751387424;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bZoTWO4+wQAYyr+HiGHwhWvZDtBUnYSBhmhbwbqVjs=;
        b=Z+8jkezni2/QuhLZbnS9HrwY5VYA6GwSEFtDdkcrKT2VYMtFqX2IYpKjw/6DxpSlme
         jTFJ/ZOEUlYMsVl5RVYdbfD8z8LXcRNiW6a5IQNEjaXDBsaUUiWaBpf3HwEsoSplv0+/
         jGtFMLiCprpHIGCR4rNPwgWLZBJrH3Ahg8jx7+KNLa8uXKII5dt4KdAzOQQs/DI3p9WN
         Gv3Bg/I8Pc4q8jVwFsh6crFYp0XM0qmDoLW48Wwy9A66qKuV9tpN0RwBsVy/MKWb1Glz
         O5mai+Y6uZVRhuXzfUmPV5q1eiYPFujNpeuZAhODGIpM9GmJEm/cjjLWOlyQMs1jh0l7
         oSFg==
X-Forwarded-Encrypted: i=1; AJvYcCUalcuvf3oDI5RQvXVWgKn5oCzVGYhoAJtySSTqDX/5gqbhwk16Wx5cRLiC9JGjFzMNzNDLPird@vger.kernel.org, AJvYcCVL/D5OcEar8MVrZrlPyvDPukBr4415DK05kRFD8rjMfiRoAy/dRVm6/P7V9MAZA5VfOmNRLRGNmNecuZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9fq47CuYIZO3ILox0p+Re3Gtd3zH0d3b+zDLtijE4zn60flzu
	dVf+D8ISYDIQ+85my3Y9ERB57S69glWwcsDeJaQ4WpFjLZ77kJ/Ri/tC
X-Gm-Gg: ASbGnct/CIN6bz7zomypijaeSO6YCT0mQ6f7tvbzxbSLBY30iG+e7YXjjlgEJ1OodC/
	ee5hZHV19yvY+9lJW/QpUrrNpjgIT/QYvJBnPORfFoIGWZOTnmXYgD7zzs7rPsCivy9Q7Spnc0v
	WsXoIUAzdIqqRGC5jJCFRceZ9zksovQxT/+qXHTYrBBq0UVK/C6Y1dBklUMnSPnONJM4a3qsY/V
	6qPSwCWvZJWrS80Owyoltf6hdYTEplEmDCkD0iVQwsx2k2KYuOdG8X2YbKPuNjiuhuQDRsp/k7u
	m/0a2Wh0bzFeDn73m19YQ3B9/Xf5BVOW3XSl81uPK4ycJjpi/yx5qKPFJ1IZB7tG7AdYbQJwph1
	R/LAh8WNfxQ6uZg==
X-Google-Smtp-Source: AGHT+IGV4rhwef4pWVroOvbIiHwEv415Wg/T+kR2AvIAoW1BXJeB7C1wZ2s1GH5m4uQsTs3wYzKGxQ==
X-Received: by 2002:a05:6a00:80f:b0:748:e585:3c42 with SMTP id d2e1a72fcca58-7490d629119mr22030600b3a.15.1750782624343;
        Tue, 24 Jun 2025 09:30:24 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c88721b9sm2228592b3a.150.2025.06.24.09.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 09:30:23 -0700 (PDT)
Message-ID: <8e98218b-543c-4484-b937-d62a64a9a17e@gmail.com>
Date: Tue, 24 Jun 2025 09:30:21 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/352] 5.10.239-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250624121412.352317604@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250624121412.352317604@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/25 05:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.239 release.
> There are 352 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 26 Jun 2025 12:13:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.239-rc2.gz
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

