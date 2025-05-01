Return-Path: <stable+bounces-139341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051B5AA62C3
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 20:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D8B4C0232
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 18:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6FC221F29;
	Thu,  1 May 2025 18:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SomsQhRW"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C9A44C7C;
	Thu,  1 May 2025 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746124084; cv=none; b=gdIKwj0EiD0+ervycmpqcYrTGPR+CzZYr7k2rFen/6W797ZHvxPTua+O6jUgxI52ee72mBQOzxeZXUNbsTPOXcnsi0frnEiPB4Os77D4i0VxMmN2fdA1+rchr5itM9Dl4vPJMwao4UADQEJfPUqQwLn1nXOJ96IsCKt9kdToR2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746124084; c=relaxed/simple;
	bh=OvPMEuQ46il3TskZUAK4+nulnbCgpZ4Cd2OcQ/G8dps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6zJ1QB7HV1mok5BGErweYn7yTjQOHLZPwkBjClwmomzi0wsPnX9ZZ424UjUvFZNMudnb7iwvt0egXMGvATA8IxF3Z9JFJrc5a6VA/VDWGBKmvOgHBm2OLYV8F5IAW5/EPpuixQ2WL3x/0yx95mbQ3PXMIPosJC442RLm4Tu5w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SomsQhRW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so10173855e9.3;
        Thu, 01 May 2025 11:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1746124081; x=1746728881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ziO8mDy17x0ZX+4RdFsifgUHBBZZisRMepgvXhKJJxg=;
        b=SomsQhRWcgXMa06GtEB3VBPF35ciky+D5Q++GYr4lQWlB2UAy782E+ZyFbleM4YQ5m
         bChP1+/YLgmX+VTEXFmv1eBsV+d633Xom+kP5Kj8Fj4pXm6FCJSlcqa5X8n1v8g9xHr5
         bneJcekSYgoeZrJxYcia4K7qo2oJKZf5joRDLVn/YEoB5IhZLnOuVBmyl41JuE4ULIuW
         EHzZmAX0+dn4trBzLKqMnDLH6YLm7iwQpccTwmXN8HY1YKtgMNwuX1QbELc8Jc7NN1oM
         75biBkjtRb7ix22g7u1J+M//nYzTGxpk/rgbIUNUUvXBoBZihh5TEr+4DLuVozWZqQ6l
         Ef0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746124081; x=1746728881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ziO8mDy17x0ZX+4RdFsifgUHBBZZisRMepgvXhKJJxg=;
        b=CE7Wt/uAXBZo5FM7CVf0/KU4gqHoaDXNtclipiK5nRnqde6TAxEGRPuEVtnyEbOeZ3
         thU8pwEhHKVGq2I4r0ENK/Y+WB72cb3+MfdG88Xa7C/vNEY91+Ch7tPkYR/R2p66/PLt
         VcobZpkGDWfctRdECm1c35NUHGqjqM5i9TPR7FPQCr/O8PKZEbvcltehYtzzmaDBI/a8
         z8H/3sUhGKCLbITcVCME2+3qtPy3lu+ico2yOLpUJ3KtKXPJ5fBJiq9LfJdGZlc8ynTS
         3OgWEvCfAWTAE5Yb0EJTJg0gRUjaSnI/3jBopopHl/PH+dLuwCkhXLwgJfVn94/e4Be1
         QtRw==
X-Forwarded-Encrypted: i=1; AJvYcCUf4NH/DfKSTzJSsqxrMJDMHXG7jBn2xRrauGqYUinUS8W8Bhct60e2D8eUVtZ88nYEkRtTuzdU@vger.kernel.org, AJvYcCW81p5wlr0O5lPmeJuGoMACWeEpfo94VEYFlCn30jFZP+1T7I7maSsRQ8Kj1vcbm903f7uEzPQ1knkiPn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT89NtIppfqqaQBjbeZM70scGHl/znbJ56DwvX5fY13VGJeWCD
	Zcm13oZLzLBD+ZlgzMu19Sgl0iSYG0Pij73yueAC62wPiR6n1D0=
X-Gm-Gg: ASbGncufGbXzoseTAQVAh/rnGdKVR+bptgI21u8Zj8vAKV91UIYthtmLyXTMDLUew0m
	/H28lh5BCSj1MsR98F6IXilxC5INmu5PWSJGNuoIru/TuKk4q7GxKMCulaIuVL+hnxpFC+T/MNu
	Aq2/wpGbwSAc77KK5H6NTrf4faBn+6dDSbuknTj0zu44odH3CoruVAqz3IHHWHcjCTG/W6DdhsD
	gGlqW6IHgHisIUPSeQZ8eIvChnapun0n7FFhIwy8v2S/01WKoK6llVh+douR1zIPdAz9qGG//yj
	l9Mu/7kYW5a1vEPIMmIAXce2FGz4ip4nCR0uhqhNxsfgHGGa3D+WWthjtpLrgeS8NKgz7S3XIt+
	VPfDie5i+TuqXS82Mdw==
X-Google-Smtp-Source: AGHT+IE0vFV95HheCkKVFzX8joqpHJeWx/EZFT2IHqGfh47jshQk7bRn/7pHku68lkBSbrioTy7maA==
X-Received: by 2002:a05:600c:c89:b0:43c:f81d:34 with SMTP id 5b1f17b1804b1-441b7017eddmr29576555e9.9.1746124081319;
        Thu, 01 May 2025 11:28:01 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4589.dip0.t-ipconnect.de. [91.43.69.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a095a468e3sm1475143f8f.36.2025.05.01.11.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 11:28:00 -0700 (PDT)
Message-ID: <704e57d4-ba2e-4afa-9351-cc5496f7030c@googlemail.com>
Date: Thu, 1 May 2025 20:27:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/196] 6.6.89-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250501081437.703410892@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250501081437.703410892@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 01.05.2025 um 10:18 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.89 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Just like rc1, rc2 builds, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697 v2 
server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


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

