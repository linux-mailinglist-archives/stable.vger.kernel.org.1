Return-Path: <stable+bounces-93597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6969CF546
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 20:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06026B341F7
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 19:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772301E1C07;
	Fri, 15 Nov 2024 19:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0+Y6rlf"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF9E1AF0CE;
	Fri, 15 Nov 2024 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731700124; cv=none; b=Mmu8G0nYtQZ7+dpNru272DIoCYBZkLZmKBN1MaI7uk+jNew3TLLaIyKso3QLf6ORH7mtkL78o6MH4aGJ6j01hIBA4e1Uj2Y6TO262mi2zb5sw5T6RAuN0rd7zvSo29juys2bl7OIA1jZx/Dw+nmdGU5u8/Clrr6y92JdE8v/xUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731700124; c=relaxed/simple;
	bh=3Pamc2pHDRRt/OVVjCpkW7oO/ZRVr39U18POxIoOGlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RlnrR64Fg4CDFarEyxOwKYrsIG35A/JHWiSRnoYyT0zmV4ZKNGgN6RWCXTrIXuWwzTe3jI4HVdvyfDdk157W7swxaXahXMSnYHvEe17xA5rF/dP04nBTEUBw9zmUhlPzb3Bv0eLWWFwEMAfq7b9nGVMezIfzN2bmPtbJrA3uU7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0+Y6rlf; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-718123ec383so1091683a34.3;
        Fri, 15 Nov 2024 11:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731700122; x=1732304922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tvsVDGPciR37sqK7Rpyn6/aPD6OobOr63Nhz+Sg2kEY=;
        b=O0+Y6rlfQZpgotpOw3Ad8hdxHYL24wwCQOghlsCa/lzdsAehPnEcV3VxrVnwLPESAq
         6eLSCPdnoj7BU0h9ZlVDbi1RCCkRPYR8+Qok0hP65LC8OdrQd1CiMWfMVo2lO7rHoXD3
         WSlVCspvkAYVQNHTa0mDMA5neZHfdZCKDTFgqPkhOvfLcM4gUQxCffD/xr+jBH3FJ8C+
         Mlw+ZnS8gxhkaZArGIMpHXy5UE+GHRQ4v8PRN+1RioNAFGO08c3zjPB/hkNApDN7q5H6
         l1LrfRW7ZRheuKw7YldH7PkrPOH9qirNbpWmwW9IqShCsIUulf22QTCiLQXq1brUXsWD
         hgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731700122; x=1732304922;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvsVDGPciR37sqK7Rpyn6/aPD6OobOr63Nhz+Sg2kEY=;
        b=iiejkjXWZO+0PepFxO0XjfnOCSO8bZ3+G1o97Dv1Z0wivvbiOUCZaOKTjQMa+pGzqw
         46/ECK5wTx3e2llzjtGSdmEun9O+zxDXVocCzCD7FMuGRopQIs9R58iP0Dw3W7hZ/OI7
         pcGLQDvhWEWZri99D79UGYZIru8YjgMZOidYswUz9qlwJrY0wqPvXA75IY0IswkujweW
         01OUac+OSYsCdV+kHI/yAaoNYNJEdJSuTV+Hvlo7yFaACl5vCRwFdqnEWHG9zOjDcePy
         jB2j0n50MBNXj9YHcHc5y0uiZcRmwM58Wm6OeRAJvPhpvdzyVVO5wTr8mQEcnY14B9mn
         VuDA==
X-Forwarded-Encrypted: i=1; AJvYcCVnLxm8iypf+y66mFyQ1AhiEoIPaC/n9kIgVHbreMu16F+yf3YhsDy7ICixg8oChiR52WA7A/Ac@vger.kernel.org, AJvYcCW8ETd+TfHCh9RSj5T6JlRwrnwj9T2ks3Pr92UuvkKCu6q4YgZbXWkhRmzXw291XRTs/WcdGAiSwNPVYQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnwbBp20sT7JwYoh/KlT3UuWLOf/ZanGtgZmCwxu/VBEhXwL5E
	XZOxbguFpVaZj4sbeMRe5rjZxff3AWiM3v49ghXU3YKCjGQCMR/8Bm4DmA==
X-Google-Smtp-Source: AGHT+IGh7WZAYcF6Ax9rEj9t2k78Rg4dQnvv4+DD7GxbLHm+XE5Bxh/OwCqcXmBGqR9IGnXfPsuxzQ==
X-Received: by 2002:a05:6830:6305:b0:715:4e38:a1ad with SMTP id 46e09a7af769-71a779e3738mr4790576a34.21.1731700121788;
        Fri, 15 Nov 2024 11:48:41 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c63ddfsm1664100a12.46.2024.11.15.11.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 11:48:41 -0800 (PST)
Message-ID: <bd2b2377-6f02-4472-8d9d-4e4254fcd885@gmail.com>
Date: Fri, 15 Nov 2024 11:48:39 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 00/63] 6.11.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241115063725.892410236@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20241115063725.892410236@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/24 22:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.9 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 Nov 2024 06:37:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested with 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

