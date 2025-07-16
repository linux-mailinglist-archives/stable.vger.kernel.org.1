Return-Path: <stable+bounces-163185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B853FB07B98
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 18:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB9D17DCF5
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 16:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C91A2F5C24;
	Wed, 16 Jul 2025 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLFK15XI"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6A5283FE0;
	Wed, 16 Jul 2025 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752685137; cv=none; b=E1t6lC/iGZc+e9h7oJp95tWwf1wkcvgsRGJhrLR8V3QKH2LhdlF6LcQcIgxXbY+h9HizKQeCp0t0T6dXn7V+XRFuK//bNFObuPtjuZjfifQ4NVGhCK1vb43Hg6DmwlVZLVu7pmPYzRmk54KFPHI/M5VXk+6JSr5ty48yr0lI5XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752685137; c=relaxed/simple;
	bh=iP6JTEZBLF+70HcemQ1GufE3WwClNLEat4r+78V/zjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rAX1VDQaY9tRPJe/iINrMTB4gjuAEsXkYtjhr7UhTWwzifjx6IeYx/aahYxMjFMyMH04ZnKSCIom5SA2SPccblUGcvRzHaF2dQ/n6cff8vdzwbJuoc9/meWozsDo7JO96Iusxk30VUgD+ibfr5cnMcZ+78qu86NElWd632fAgG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLFK15XI; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ab53fce526so1400621cf.2;
        Wed, 16 Jul 2025 09:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752685130; x=1753289930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kNK3kjQTEgT+WTYqCLEzmN18nhM0bQJWt1l3l5/y6bw=;
        b=SLFK15XI6N/gSXiKrKesXCL53FF1lR9LkBioSAQgCPbCjGAlKHpKAlj+oZAuGdlW/N
         65dcO9bsjFyEAJVnOvHJksZIjThptq+x9hoSjIOhf6EK68ekHNcpCtxWs2aff+80Kh1/
         MPrZVylm/9bRZx+ZrEjtb0eJoIRNyJESt0IewwnU+M4+91vVdqcXQGdYN4Z1tPt4zaWd
         DE4A3763EMT5ipEuA1Tf0KWKPOkrQRaYOrR4390MiKK1GnH3/OYdzSjS9hOdvg/CyB0H
         1MJnnu5x6NIjAu+tMk2Lsqz3+D9XyzrSKsaaSlG0kE+EoN0y0GV5ydJzsTGcvcfkw+FK
         iLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752685130; x=1753289930;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNK3kjQTEgT+WTYqCLEzmN18nhM0bQJWt1l3l5/y6bw=;
        b=XePTDQAwkT0/GjKOW/k2X+TPxGA1R8QvMlKPUchwOc6NVbsO2Ur91Po7vxepIY/8aN
         LfdgYf/kBeMQGOnXTsalJZxcFA/EeVPHVRxNFj/bHDIs8iVLayWcicYCJZb8VT+74aMj
         Io1t7Ds8CKUZjihWYh9J+TTceq3mSHGunpy4YqOddgKGp/vtkkh3S+glmZ+QP61FG+F5
         abhJMJa7gan4qqu9E96+jTzuvZGLREiamQhTT66aX3Ke2Z9bY7/ThLktyu6izvgAD+4A
         PhHs89R+OTd4HF6c7Os/6v2lTZWa9GVateQBLE4GbxxSxil1C2PSMe/5Hi2TX9GFapaE
         NMqg==
X-Forwarded-Encrypted: i=1; AJvYcCUqbB2H/QXuMZTk4HQMKP6QiDkmcU9GKD7eahlLUs2Lzb7FCt4ThEDwnLsPMNYOfwTyOy4c4xsY@vger.kernel.org, AJvYcCXjuUK71fsII3LW26Zx1yMPdLM67m31xcTaKBf2f+7rBgGGriulnh+s/V6RTkIi/vLC8LliTRpbYp6Lzvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL1VSFvLN4je0F/LhEoP6WsPhwdc/7OPTm5aqWkAj3flckUPQ7
	Rjey6Pzifv8+WvGyiPyb/g14hFUdQGFFkHaO/4acw+UcCAVrWgHD8hyX
X-Gm-Gg: ASbGncuPSfqpkQksn+VAL0JC2xFNm5aHytWUV25g5R8H6B/5RiQT/eMp3sgSG9a0xdy
	bEs7lCv+V7/BBpv6/Am5ixL8Mt7vxudDWc49r94mjsLn5UTJWhaWJW0fsKwCBAegOb1TdCOKp8u
	uCULI9muXbbhoWFozoZnGwy/nF9/qkRnwoDhh9hXy3C5lX9iyVGAMO0xRq/+kxK1q0RywquogSH
	rcF8uqb2apjuCuDe22IqIfunI//y+Yz0KkEBOSj6/uZRDH88q2QMdkgPCFf7B/+CP7gTUzg8UCG
	+0ak8Vr5Ggd/p8qqCJKPWhtf/+/tHNOPw/VslS8tV3o693TZNFsYqDYT/KFqNwDHkjSD7vQfuPL
	Pd2PFplhaPEYE+CrcNZHkHP3Mr85j+FCstbSyFublepDA0qGaOA==
X-Google-Smtp-Source: AGHT+IEwkI9+9yXOsyKNH0nezJp0ZgD3k5h6KOcI2B6jChy0Xl7/JmD697iNa5itSdPpBUh2baIYLg==
X-Received: by 2002:a05:622a:1997:b0:4a5:98c2:34b9 with SMTP id d75a77b69052e-4ab93d8dfdcmr48569031cf.34.1752685129732;
        Wed, 16 Jul 2025 09:58:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab5da31391sm43620321cf.23.2025.07.16.09.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 09:58:49 -0700 (PDT)
Message-ID: <76e3ac74-eaf1-41e7-916c-d6127901eb0d@gmail.com>
Date: Wed, 16 Jul 2025 09:58:41 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/89] 6.1.146-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250715163541.635746149@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250715163541.635746149@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 09:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.146 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Jul 2025 16:35:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.146-rc2.gz
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

