Return-Path: <stable+bounces-131849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB30A816FE
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 22:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118AE1B62FF4
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 20:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCEA254867;
	Tue,  8 Apr 2025 20:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7oesPj3"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627852505D6;
	Tue,  8 Apr 2025 20:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744144313; cv=none; b=epRewr1fQTTY+eQ66a/Vct2qI4cxsutWAvMI8ZLmQPYE0gEU983FULvbXfHXSvOEiJDPF6qI+PDN4m8C2k60M/XkEtjLLLWzC9ui/l2eVb3xl9ghLBJt3XSUSbNbVAtZNqgxFE98iO207NbTIa9BrJKFHLcXCM1yDT64+7Ddb+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744144313; c=relaxed/simple;
	bh=jcHHwYl04ttVXHaM95E/0bdlpnT2qWzZKbErWQGgHQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DyWFueicEJ84NbZhUiROoLqKb7nFzYOZL3LNX91PAsrPSOTXRKKWt7WQtgNv5z6IlMBnw8sbttC0qGb+9hqi0VMy4wxHRsjMvG8Uy8dUj7xrqdLU3wWc+MKHvtiQspgaKo6/clkl/UWtU2Bm+eabUqWANfPE+dyhMxZaoRju8Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7oesPj3; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72bb9725de1so1404987a34.2;
        Tue, 08 Apr 2025 13:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744144309; x=1744749109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ej+ETfMxy13xBpn6+4kyy/pRZQVyQrYQb0cU7d/VY0=;
        b=k7oesPj3DAfBt23an/LF2hiTzu4rUxW5pm9yX4bCRU0MmjFJ2TOEVKNcZQdkBH9ugg
         bVWSgk55M7FUH3lhZjdcBvHP1pWFvXryo7INgcEBSq3bx2w8FkfDbT3GstE5MmXrl3HX
         luiaWeta4d4TUFlkAyBlSZ2Y84pcI/XojHeb19cNfAcvTPpAGyfMU//DRZPy/3wxltQk
         xUX6vqzR6f1p69Hg/OFIjb3DeoIEc4lpILxHgJ6Qk4KVzeRZ3II80a3Wm9uVfI/MUW6x
         jQGU1Og3KnlGGZwKDmph7hXTkW5q1qlQjs/WtfgcqY6KHsRTp3ZtdOtr6s+bB/aV/FrH
         qHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744144309; x=1744749109;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ej+ETfMxy13xBpn6+4kyy/pRZQVyQrYQb0cU7d/VY0=;
        b=V+8/LxEpNwOEQJZiI5kHQLQQiAryIrTDhwIv99nOP4HGtp9BeKWrjm8iuskPe8Qow+
         XtGoy7kH7XCxAO4wGIGShElbTpCqAVGFc8O4ttjBQvhd1vspg+LmTUnUA8lpZ+bJqBgJ
         Wxw1Q5lBg+b0chnV8PrLFbY4LUPJCg24QUjyDV65YJCBJ2Q5a/RLy92hfYTSOVH5RKpR
         0bvL2Q0tHcsySCKd6m7Fy3xnhfFoZeNlDozGakj7qQCID1tbp53nNR3Uv/+dDhFqBUm8
         Opk/ZcZo2uLTkXdXZ2z/6/PIoJ0awl0Epz8TWzKHxLShLo8uhq0SCO2Dsff+7FqQF2/a
         1eqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXNTWPBXr3OKWY5nxA7VceNdC5D7n8c8a0jpANaRhyg+H6jswhSPtnvEgcURLT4pIldhmlzLS9@vger.kernel.org, AJvYcCWKaJ5+vznwI6LcFO8wNsSy8va831bMC8s807rAntUoua7EKE1WfvHhHbc7aFkb1VIEX/EUclC4GpjPZ9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZfUT7HJtk4v/a1/2djqD8yQKfi16IYaEMJX/zLrh7/mPNoWA8
	KHVvR6SiLQAWu/fe46M2ldFWUNU68OMUlf5c7yhYmCEkoFXoTTTl
X-Gm-Gg: ASbGnctFzG4AAoL9IEcIGd/HBxtV+vhTjLKmW8VYNOE288x7o0LrBxQHoxTlESTU5YV
	67dYsadYkPchW8fSAWzFX6tyLzFsE2z83/7JrE+pONhHqInNoQ40QFhfdnQTUVygD3NuAJp1ro7
	Sv1pa+/Hj94zoIh4n4fffRNF8s+NXvv2CUNa9S0RNKgYPT1UtoFWPDhlPIm4T3WfbOyqcj6bAXN
	SDDbrH6ggwFdmpAGNp2B/PuepRW4kAm6CnGbq/utXTjQFR0iwMGZ/wLIik1LY2eSkoEVB3+PdDK
	ZfmfSfAUtQDRJE8wYfqdRYgubPSecrHuVH0fChfmvG9vF7DFtHCHfBeA9+CfeaV5UVEuE30/
X-Google-Smtp-Source: AGHT+IFfjcTZ+1ercJo5eWnRjDs56g87ASnazbppsCCX43zOu5mk0vhvzWBkxYl6OAOgIPlsZgiuhw==
X-Received: by 2002:a05:6830:3c81:b0:72b:8c4b:8ef2 with SMTP id 46e09a7af769-72e71bbcd28mr9208a34.24.1744144309258;
        Tue, 08 Apr 2025 13:31:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e6515bf9fsm581546a34.6.2025.04.08.13.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 13:31:48 -0700 (PDT)
Message-ID: <ef68af5f-65ec-4fb1-9029-2eb12b4b23f3@gmail.com>
Date: Tue, 8 Apr 2025 13:31:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/154] 5.4.292-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250408104815.295196624@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250408104815.295196624@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/25 03:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.292 release.
> There are 154 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Apr 2025 10:47:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.292-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

