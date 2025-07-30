Return-Path: <stable+bounces-165595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 116FFB16759
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 22:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D4A3AE673
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 20:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBFC20485B;
	Wed, 30 Jul 2025 20:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="P21/MKo+"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63AA1EA7FF;
	Wed, 30 Jul 2025 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753906132; cv=none; b=iDnV/oH2aslcZSxLJJARNKuCaJmufVjXoTqknQDBQeLY/Uz5d+9DSc933SJjNBXDN9Zx9M1ssv8CI2Um+ggTSFozIGjqxqmyDxT3A5XCsjUTd40iygiVyrFykiGOnjDxEeAFBTAIEYFcP/0zBmDNFmfISUt9YgogNkgHUlMwqkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753906132; c=relaxed/simple;
	bh=I2VwIorDAW82CA2/qdCBZgMLcdD+U2jqsGaJ1dMtPxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLT8oUZitgjonXRBI86nwdE5um9PuiDn7Su6SEIdnYQNNhC1BG6kSeQstxNnM5joHdo5X0X7ifJn1HhfjtI+ehc2d/F9NK0/xcvxb8KycF5+WAQPqzINGwd4IteblSdyUmAi3xCC3O71pgOAjmdWpq1x8bDQBa8TR28S1gnIzdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=P21/MKo+; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b78d13bf10so240818f8f.1;
        Wed, 30 Jul 2025 13:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1753906129; x=1754510929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+cMNnDttzZ6RQt6wGgmmTCVQa3RNZnes1HqAh2ZhHsc=;
        b=P21/MKo+Y/085b9So5lWWc1MOFeq6rDGJtpOYaEoGkaFFAr5S/YDHpw1bfGhQjFflA
         veZhraRo2nZKzGB+iBx1pKRIY++gGCcQw6QRfV5aCtiCGSKaUfDCLY0X+zaX3vnzu+ES
         A3km30nDVjb8zmaa/4rKc0qxMg+HSSbVJlisyOtkfVcRTSyGEjhY8EoCXOO+936QhFp9
         Axen0Cs/8OV1YEhGIozqmqwN6ZRleRzn3XMmphxBHWkNy9Pb6UZRAT2VxLOTdpLt2LxE
         FzPpf4z2AdEp+RUdqpVDtdKg4Y9baK36JlDbcl/qHKadDBkeVlBLEla9JrXV87OU8Shd
         cgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753906129; x=1754510929;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+cMNnDttzZ6RQt6wGgmmTCVQa3RNZnes1HqAh2ZhHsc=;
        b=omLCrscXS/IJW7okt2AuzfCcs+p/qCCiLsuLARBli6UoPrlHVQebN35Dw3iIRDqasY
         75Vjfx/RSu6sBvvQXVEg7sAfd6afEOUX6ij17ze6bJ2apQXP22elre8Xadl9DfR+zdjz
         koRr19iHPAS3vu0AGyl6smB96N+g6S1DfRIjBdSJJb/hwk+pSk+CnvOKXlCLFp03Cbte
         AnZE0q+U6YfXIcnBWm5VMtJ6chJ5jqotJW+d5TFa2VW94SEzw3duo9euBJGhGBcMXS9F
         RHXlQVIBQbYTebgz9TOa0KCt1lKJfM9DMMadIyZCc3HxYpTLa2x4sDkEWOy1Jva/sxln
         ie0A==
X-Forwarded-Encrypted: i=1; AJvYcCVpU2w8n5Fa9ULRROiiOXzUAxhm+9WUXOe+Bfk5yYv2XYYVp4uD5bDTjS7yOzzSoN6F79nTQoNIqya+I9g=@vger.kernel.org, AJvYcCWHl+N02mwJqWbyGI7omB8FnjIAtjaaxkZ4MslEZgqCGfYXYzdyKZqzkMv2iZjew3SKJl5lWyj+@vger.kernel.org
X-Gm-Message-State: AOJu0YxMOqkT5k24tW30+WMzgl1KQYjvRt37dXf8w4pfjBOTFxyz0HtH
	jG9OgerqWqxM8yT7+TwTCnVfouJbStcVGnc0MNEWPdZtctcMpu+CN3U=
X-Gm-Gg: ASbGnctNJIVTu69ydBHmbI2fZTugiLBT0oevTEluWE4iPuSMPQWrVIGb8W4kanMkEwx
	49/pVZTdDMc69uurEP4nw9aQiH+TG/dSm2z/uZs8QLvtsMdkN2FWWKEKNlsCodm0PQucbkkepqt
	Y4mknpMYaVfr0JZF2+dZ8SURnjWVQ3TEm1o1myMmyWA5jtRbbuJORmuUbtI08nZrc0YGt+ySVJh
	3SUk1OiSPekQ4BWzZ0J0n4nqMiFvckz7K7jTh6rXQS0+FoP+ncTp4fUc4982C/F4JcKBygKkxDF
	suVe2CBDJ8oTKGx0RapPzL3MOgGlGZZcw9mITd+ZX4PZeZ8gSSR4LGg7G/ReU9DH6ZY5Ni3OiLD
	R0CP+XXTtwy2dwTcVXxSTxhR5N1631QWVvPOimXxGB15T492JpYDbjdTTQOa+GfdKEZefVkSCpl
	w3LLOX+zcJNQ==
X-Google-Smtp-Source: AGHT+IGbbeFnHcOTsEgMeBZIa911Ksjql+ptroLdZznDSsPIw7/H4yUH8bndCMfzMG5rIym/4F2a2g==
X-Received: by 2002:a05:6000:2003:b0:3b7:886b:fb8d with SMTP id ffacd0b85a97d-3b795026234mr3404428f8f.31.1753906128897;
        Wed, 30 Jul 2025 13:08:48 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4284.dip0.t-ipconnect.de. [91.43.66.132])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abe18sm14384f8f.2.2025.07.30.13.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 13:08:48 -0700 (PDT)
Message-ID: <c0060290-ee3f-4b54-8b16-50a1ea5ac2ec@googlemail.com>
Date: Wed, 30 Jul 2025 22:08:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.15 00/92] 6.15.9-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250730093230.629234025@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250730093230.629234025@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.07.2025 um 11:35 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.15.9 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Built wich Clang 20.1.8 this time, boots and works fine on my 2-socket Ivy Bridge Xeon 
E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


[    0.000000] Linux version 6.15.9-rc1+ (root@linus.localdomain) (clang version 20.1.8 
(https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261), LLD 
20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)) #1 
SMP PREEMPT_DYNAMIC Wed Jul 30 21:01:43 CEST 2025
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-6.15.9-rc1+ 
root=UUID=3842ebdd-e37f-4e4e-afd4-d7eb79b41984 ro quiet intel_iommu=on iommu=pt 
vfio-pci.ids=10de:1201,10de:0e0c
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000096fff] usable



Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

