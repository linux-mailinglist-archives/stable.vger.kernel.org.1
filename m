Return-Path: <stable+bounces-165590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3137B1667F
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 20:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19EF169AB8
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74702267733;
	Wed, 30 Jul 2025 18:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="X7wPEPZl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936AEBE6C;
	Wed, 30 Jul 2025 18:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753901192; cv=none; b=SXFhXL9oGuKFG1YCfJe/55ORF9WsMmzlnHbfUqR5DJ4WoH6h4W8rPJ2eYlAcBvDFp/QrKVo/ZUzN4yREf0J3tqqxtBqxEzjx6cHG80u7F4kkl7EJmCW4tqGdz41pkKhm/9ewfhrB2J8o4zEQaIwafSggjVNqstN728Qyt2P/cxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753901192; c=relaxed/simple;
	bh=9X5rB2DD9NvDA87R6zBY/jLfEC/DuBTtpZ3q4uwJEiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3GZPcs67CUAsVsrrPAGSMoTv0tkqpNxOLKKfYlvhzdBCi0U7BVMh08T3kgF0dml0AHDQG7AdHExW9XEidtaoBzGKmmLc5rEPI4NK/W1yIed319pKVvz7FLAfMzoBgAusmNcz6WZc5kYwb+/tlRNR7Il2SQtfzOPuLGMLyBFmCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=X7wPEPZl; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4560cdf235cso703205e9.1;
        Wed, 30 Jul 2025 11:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1753901189; x=1754505989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AXT96IcPXUVEl6g+nGD58CFvGJlPwbsKBbwPj8iXt+w=;
        b=X7wPEPZl8zlTs47+4xeMZZXHTg08QEcMhzi2CsBbGHNKhyLy8BRgOMfBUOu5BgAjnN
         ZFFJKtT+kbwr7Hmw228pYp2xEG72VstHACTxJh59QozEhyfhzxU7mWDtJM15pmVfjiWX
         fRM1Sej3qu6JskvRG57oFqwsiEYnsz8Evny8MbhsvdgyQRFIMPyUEEunylIfW1KkBsC/
         SJLb5HutzTxpyAR/K1Ffn6EXMNhevdD/qtmXIezuTZVUCTk6oJpJBK6xiKssrP83B2kj
         PPzNoPR49CNZh6ZRe9ggCWg8nLeh362vzG3J9qm76BtYOyfOELM1jFYzJhR0n81m1sGt
         zfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753901189; x=1754505989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AXT96IcPXUVEl6g+nGD58CFvGJlPwbsKBbwPj8iXt+w=;
        b=fXS6Jl/seyEooetNUuIXZl9sGpKem/Ap+9gTU+cGzh3SMzoet+gqvK8VRW2qyMWiSZ
         4lHIQ63tvPiGNZVxihO14GeKSwnTUCrcnW9I5jk1lP2yZBZrXDGbHCXKYBSPk7ITlvX/
         ZImCTPHvqGqiO87zG0ihLFG/DIGjRSePramszZVX7EHw57DBcMcez7+NMXwmYb+8IY8U
         e6xHi2iTdL5BRzltFEZX3WnOOyuzaeft9zOZFxJF5wH5ai/ETy5RfveHKZIcPWz6NJqy
         Vf0j0MuNeuYgMiwQpfjo3fMohVWRi6T+BuEnQW0yuSZ0a1THeGfpt9zhTMrOtRLJ30YI
         Wimg==
X-Forwarded-Encrypted: i=1; AJvYcCUF/QrUiD/zhLooCyGs1p014Rp5Yxp/k4cR1PA/uUVH+lvGUUoiTx6WfieG0mCm27gzlIQmn3MWsrHHbKQ=@vger.kernel.org, AJvYcCVvm15b7wyMgZYpzimDLDbGLaiM8uMTTWv25P/DC18ByE7mbwHof8cN4lUR7Dr6/3KORc/bFr+W@vger.kernel.org
X-Gm-Message-State: AOJu0YydfOJWB8CeEP7a0wonPgNVAkddkfsccqzPPfFWK7gZeSpVCOLQ
	8+N7Yp5b9Tf9xqDRVNDGBULUbbyTUkPCyq6+CHJ/RT/JwiMygMYeEdg=
X-Gm-Gg: ASbGncu5jXloZNHbqh+ptGz6K5Io+LMLZNjF5MGwFZDqM1cl4QOeslOJwYfNdXOb18B
	4WP1hBd3iRqqjXAvCU0+Vfxx4mrsqBsIE8JCztDEIdQwep7NAVtyKFHK7NPrXuOeZBKAZ3Mp7X7
	54kKlT7qSn3p/38lhUP2AtQ9B1+wd4EMOn72fLXxQcVRBpNwPpUJzuWhahnwgsW6BTUKM9Uhg+a
	wasADCpzn1RUVyr+FZJDTx7e4zcaURL9EsSq+TNbrrdsDjkEKrw2mpdy/UzxPHHxXF/NatM7W9Q
	Y4I0gUav0AyOHJRg4byLcVy0HlWtP9rM3rbz27YzSDRMHScCju7xXVtO/YESXUWPNmvoOHEzfGT
	OyLVj7l+27iQ6w1yhMlaWLVLu78gpuSL9kC/QfFrDFBUaZRjhRoUKQuHaAxG7bgtqiBKKuTvrDk
	Q=
X-Google-Smtp-Source: AGHT+IF/pbzgQd+sQCZHmuo70hAr+91gxeh5dQb8U4efTOyD82aT1sr9wb3UzlFSREtkjtbyKAIjiA==
X-Received: by 2002:a05:600c:c4a3:b0:450:6b55:cf91 with SMTP id 5b1f17b1804b1-45892b94d5emr39235455e9.6.1753901188618;
        Wed, 30 Jul 2025 11:46:28 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4284.dip0.t-ipconnect.de. [91.43.66.132])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f04009sm17082353f8f.38.2025.07.30.11.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 11:46:27 -0700 (PDT)
Message-ID: <d04970df-1884-4007-b0ae-8c964d517dbe@googlemail.com>
Date: Wed, 30 Jul 2025 20:46:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/117] 6.12.41-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250730093233.592541778@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250730093233.592541778@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.07.2025 um 11:34 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.41 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Built wich Clang 20.1.8 this time, boots and works fine on my 2-socket Ivy Bridge Xeon 
E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


[    0.000000] Linux version 6.12.41-rc1+ (root@linus.localdomain) (clang version 20.1.8 
(https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261), LLD 
20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)) #1 
SMP PREEMPT_DYNAMIC Wed Jul 30 19:42:27 CEST 2025
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-6.12.41-rc1+ 
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

