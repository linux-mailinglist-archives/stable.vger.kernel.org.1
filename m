Return-Path: <stable+bounces-199945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA364CA1FD8
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 00:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93DB4300ACCC
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 23:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676972EA143;
	Wed,  3 Dec 2025 23:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fa7Y8YoP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFCE2D8791
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 23:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764805801; cv=none; b=BVHNe1H1ZGWpjb+LE2YUXrQ9aqOCD+wWPncPG9lPxo8VJtqF5EgATm5kOJLEtr4QsyvsKOI3z57vVbyOOmjpERooEbXdlm2mBSn9aGBbxRSTFHbgWyYXXPn54Vx0lL214uncXdPyJNzqfJJlrK3Wf9waOk5BrZo9Pl8w0vpagfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764805801; c=relaxed/simple;
	bh=JFSiBs6BnxUnLxmM5BL7ZTG9PV6ZaHk+QzB2RyFeQkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHp5Owc3A+g2c82Urr2JDhqdDdAqONmoGPCTy3bIQk/OCvfJaLYcVLQpkANOfMchJaHLBQJJi7Ah7pKmrZHXEbrKTz326EnpIYOocWRTSmQqUc0m5VOOLAoPiM0zH/fsgiqFJC1GZGFXinHloljD4JxfRoX1LidZGcn0s+wHf0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fa7Y8YoP; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c6da5e3353so307001a34.3
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 15:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1764805798; x=1765410598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PkOm+9erKjGelb4JuVxNjBpVULkuBNccnXwdNJ0IPpY=;
        b=Fa7Y8YoPDKWgWb1tINlxrljDeWwW+xn2VJM6sXFs07K7zQqemrOI2vjEpr5BVrfUz0
         8qDEEfxKlXQVUEH9y5e9u/FP6lKYdGbJyKqFmZCizSKSXTMkY66tEPF/ONDUgSM4+HEY
         N6aiWsE1q7r3hmbLsOwijUpX4/8d7vJ9IViUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764805798; x=1765410598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PkOm+9erKjGelb4JuVxNjBpVULkuBNccnXwdNJ0IPpY=;
        b=lwPZW9E9N2ftijiP2zYzCdFvrUvUHd5aIz2z1jlVoqW+gR9DVw9drPfVQYGxL69glK
         Tcp4OtHG1ZSg0lRQkfZbzhqyCznLeztTt4jH08ZBySHgYNgUmG14RjJGagX//F7NF7d4
         l9/YCZOWSFGlGJrWQyrKQMyk1b53rY2IcFjw1NTBFT4yN0oojQ7ALAWiHhVSZdRr7+Lz
         8KX2J8T0FaQFrTeKqzuNzu/RIYWObfhHC0kSdqsGeEvL1bDbydUNqlmzELJcdJnYh9PM
         mSMplZKzIHJHimYQM9N+1J8xKj6qLucSEkJESthA/8gIIZofYwtZEoGLFJ2CYqJwZzwa
         sMnw==
X-Forwarded-Encrypted: i=1; AJvYcCUJiK6URdHT7Hkjt/2w19E8vC1XI6EYL/QMG6eWpBEq9h6Kcn6QxIbvMi2Uq0Q8x+tvZYKkElg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXdrFNxZqnB4sdDGPsP2BsZF6+KRvvxn4/6vxzLp3vEpIohrYG
	Ix4pSg+wAJqSEGMZbm3cAK+F2kPF5/JShRKTInpyX30beOQgPbdHlBWvExaVUuEAcd0=
X-Gm-Gg: ASbGncv0PvzeIS6es4EQBtgCQPrF2JLfHd+rCtxmoCIEyvRq9swdNo7hGZyMP07tsCv
	r9AK3HAxy28owV1kbiDJjXioKNOdf9F4wsct/tQWWSQr228exRdZP6/lSrZOsDHa9DZEArqoYG2
	ynp2RAkFtjduwmWM4nNJW87YrEC9auHENSYFleCRxrdGs2qNgJfJEcPVJ3HoZLh3CL9ArPWrvfn
	Jy+U/NrHlixRhPfRRn5M+z2eMWY6pUNZ+9gDbanTFZoaY+l+SrmmfMMqu6nYgRgdl4pD8qtg/M6
	BxSqt1a7K2x53jsqg9t4+jEcjqtLPz+Wiia7bASfU8LfsTw0OzdEHh5yEjTJHKiWcpTrG0Ye/+X
	yFfGOsYpTMyBY+bftZQ07aSUR+ET3sFUjlkQWEDPTPMHzXGP+JTAfpPpQ8yqHNN7+74gaL7nhh+
	CtHB/zK2GUvCuBCdtY6WnMhaBBZs0nlqRoXw==
X-Google-Smtp-Source: AGHT+IEVH5pEDui1bm5kSi8ZVAF9yVP50iGQz3MX36H2IYxoSbyx18I2RHqLyOnIKpemsOOuqZiz6g==
X-Received: by 2002:a05:6830:448d:b0:7c6:ca1f:1779 with SMTP id 46e09a7af769-7c958cd2748mr441833a34.30.1764805798452;
        Wed, 03 Dec 2025 15:49:58 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c95ac84f1dsm133477a34.19.2025.12.03.15.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 15:49:57 -0800 (PST)
Message-ID: <66fe8863-375a-44ff-9b08-328783aca09c@linuxfoundation.org>
Date: Wed, 3 Dec 2025 16:49:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/93] 6.6.119-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251203152336.494201426@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251203152336.494201426@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/25 08:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.119 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Dec 2025 15:23:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.119-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

