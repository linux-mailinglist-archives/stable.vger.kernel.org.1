Return-Path: <stable+bounces-106069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E839FBD36
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 13:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346A5162448
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 12:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D3E1BBBC8;
	Tue, 24 Dec 2024 12:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SxlVQnqj"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050411B653E;
	Tue, 24 Dec 2024 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735042706; cv=none; b=ApRFfSIFQvq51m7o+q5xiHL7Q3D7XiprCpDH4a15FPiMcPhzxZkNRh0fURGXO+g7Ai+3btPZHz7Amw4A1bdUcVTJ6FV6SA54O8CZZIm+tEJLGrPb9VvyeHvnxNa6npp6S709PxJjuSn6yzKvv5QsxG4m7ns8+BZDJOdReigvL+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735042706; c=relaxed/simple;
	bh=ErATO3wWw4JwUGbt9YDU3ibfUHfhqpA1AqRX9pV/pJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GDorzC0ge+0TQv+AMySBStBPulvyz+ovaUy+C7hQ/cOfLvPma5KeSsIZ7o1RDC4ywC5piBFhTiIkgcJB4IP+qJYOVUQh12LuBpxOxioBEm3t7W1RzaOBrivbPGU/vUnOjycQL0iR16xMD5muDYLeJun9UfsI7wZe7FTgFOqbqV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SxlVQnqj; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa68b513abcso987479766b.0;
        Tue, 24 Dec 2024 04:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1735042703; x=1735647503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mb+RiudxCgxsWyDcAHJGp6RqlPZh4GuS25YePvjI4LI=;
        b=SxlVQnqj9V7vrAMNHdJL4eft++h2UUuKj/3ei1WzTZZtMpKte62TopLRZcSt5TpttN
         bbFzTYHFHeRzpMQYhGZD9Gbsd3r18h/glDHZMuFMN52OkuTcZ5+A0XaJ5dsSiL7JKUtS
         AANAGUELGtMrg39v4yICwnSBZxzI1HqYqO2SjhFbBUWvODzotvSx4CY7G4JLesG7yBK0
         7UFeF+C2RO3Sy9/Bjn4QrRDiRjvu5tw9514/POZpMpLSPYV0gwtD5VVyhMT95SQpE8SZ
         Xliv0WWjcB4VxAsL5X2zjrdryqU91Qcr96bwfbrkcuK6zWmz/+Z6tiDfQu4hPOqDPCl8
         4bfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735042703; x=1735647503;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mb+RiudxCgxsWyDcAHJGp6RqlPZh4GuS25YePvjI4LI=;
        b=lZ9CVwBlNkO+Byj/L0+MFXtDWPqjp4RUlQT9qpGZkeBK/s+B0CfxHUK6ZmYTvmc/B3
         naeNkgoGnIHfculInHQ/eyTiqCYHG8xloTZQiJWv9y279rQeZ/leUoz9eMPGflDnY2Nc
         kOUHAwx4W9OqJ5mTdf81q/4ZDhUARD9zmymM1yk8PAQWOMpZxmrMHzLaJCseZUJOW4kh
         gCKvLLii6Pd81jxFaJzRbIKaicjBWxVT8Q03johlKE8ld3Sm77IHxjSo2xRhd8QmvGlQ
         /rAgsdfL0dMNjhIorxa2yXEbTfC1mKikE46eVd6ECM08dq9c6ifDPM8mYVwzpz22WuQf
         cAkA==
X-Forwarded-Encrypted: i=1; AJvYcCW67TlBRnLBJJ4/NtjVIWRVWFMty/r5u5qQkahoVKFHS+moEbQAlfQGwkteJo1Mi3i3/oZ4HGKPE5WStI8=@vger.kernel.org, AJvYcCWlIfj/vlo9FeCNSA2ozip/o3yupU/9aHum544muAtKAY5p9fQC9Mjk9aE9+tHdHCFv4hZGezhx@vger.kernel.org
X-Gm-Message-State: AOJu0YzvwjT5idDVacmbyhjZ8ufvA3D3vf5Lsms7235ff5kk3Jzl/Ob9
	38f+3LFrBIpQKK/0/B8R5LWvwEvpF+76sAZuBLGarT/6im61nhw=
X-Gm-Gg: ASbGncso3sgMLgZYhnXkB3p/cMYaBySBZi5iVAJibwDqcZEiBEZvvbyI8yT/v6XDijl
	DwI8QY0LkmU8YujP/oOHfox+uqPa+76V5Y9S9vqh5kLgs3a76Xm+6+ZCuWN8wfYAf7gJXLy2M0t
	LcuyZJ9FNk9z7+sQmzTs4r5VHyNuEWZ3Z7UwmSPea91RZucHKYjNQjY0QAfwDUDoRxFWcI+bQ74
	sutdWN67fuZncG02Q0zesaoNKrvR7ydtmS5HxIEvsKwiIrHggVCNBqkkuB1ixn7A/X8pRt7Z8DE
	Agzihgb6xvfCY6wcJVnPXh1GVCeZ7UnEYQ==
X-Google-Smtp-Source: AGHT+IFa8YNAs+CzLV3KLRaSyW954mnGATmOz/1e1JwC4yDSqc7YwnlN0ZYhiw4WZqVEHs0U53fYCg==
X-Received: by 2002:a17:907:d14:b0:aa6:a53a:f6c7 with SMTP id a640c23a62f3a-aac2d459679mr1648757766b.31.1735042703000;
        Tue, 24 Dec 2024 04:18:23 -0800 (PST)
Received: from [192.168.1.3] (p5b2aca5b.dip0.t-ipconnect.de. [91.42.202.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e830b3bsm655852366b.25.2024.12.24.04.18.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 04:18:22 -0800 (PST)
Message-ID: <dac29565-3d5e-4f31-96c9-9c98a2521590@googlemail.com>
Date: Tue, 24 Dec 2024 13:18:21 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/160] 6.12.7-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241223155408.598780301@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241223155408.598780301@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 23.12.2024 um 16:56 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.7 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>

Happy holiday season!
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

