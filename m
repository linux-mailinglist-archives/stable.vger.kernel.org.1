Return-Path: <stable+bounces-121136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1685EA540D8
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 03:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FACC16BE30
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 02:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDB7191484;
	Thu,  6 Mar 2025 02:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="no8Y/rRg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F94F18B47E;
	Thu,  6 Mar 2025 02:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741229343; cv=none; b=g0Sd2SwgSWalxVpIMj6S/919n/QR/J89uhld1oy5gugqLLM3xhWz3gvW75x9Eh2uRfs3WOWg/vBH/b+KR0Hc56nDT5NMCespI+MRI3AILut36ZlPQacvjaKbketkShrftXoxtLmB5GM2ang+ty4oqc6CQjp1EkzqP1HpV7dU8Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741229343; c=relaxed/simple;
	bh=q09dzrvDNqDre9BdwFglDOULg8CNdCE5thazNvCmvmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WsLs0U/Nab8nMLXRf90zJMSU+HrWJ9albenNecRyeA9hrByumd/0JGmXmk9gRrNKFnwy84nm88TCesDqhiBq70hcGfEOng8wTDeQC5hngcE2W/k0cgZqu6PEhMJxZwgp7hn0cAhQejB4J9bR7qrJdeq3oYfm/rZMm0VZFzE985g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=no8Y/rRg; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3910e101d0fso76446f8f.2;
        Wed, 05 Mar 2025 18:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1741229339; x=1741834139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7fJgV3u0zRIRDXCJ2t67tMuU1im7ntmeMqtmUfsLE9Q=;
        b=no8Y/rRgixoc7b64vbw1Up+yLHspP2N+L3Z9ZW1jhpf4XiuJvttmEGUWqz8Z3K5uSX
         MwipeKKVf0Y5PdedqQX17n+BjB1rCDZsG/qZg4fOnheAFEfiSVRBMnHbsBiQ+3wxyrE3
         2q6gSaM9FaIiEvx7jEcE1JWAPdz/T7N3a5Um2YABYd4VZJa0gTX0MRO4ZzGT8C4QGtXA
         Zpbj0ywfWnhIphnh0rYdBsudKSxngahXli9lAiIZyn6npKlB28KlD4BfGr9oNXcgYxIF
         C3L70Ob7DZ+1iZp9vC+ccGbkPk4S+Ake0HAh6PsqYv4vNST7hSD6pvFjMxwJNTBpVJB8
         htmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741229339; x=1741834139;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7fJgV3u0zRIRDXCJ2t67tMuU1im7ntmeMqtmUfsLE9Q=;
        b=G8IFfylxtG7JpWIx5zSyx2pc4hb3tCvLaDLt8+UUDwNASxdSzW+Grc9c/sRvzkOVst
         1INH9JlI/jfHJUle9aqrBtTQtRJm4fRd5b0ywv8ggeaTESZtdRIw4eCzNic5VZY0PmDT
         BuCFx9DgQXaLLB9IXGNqb3I+crueiuCTPpPG9fwDymeV/W+93hofM8+81ccJPDf3UXjO
         BDE2nwZ+3vpLoc2qsOXCVjqHQIiBpBI9MrckwP+ljtOX5050VK5eVc7ZPBWSaCPfRJ3F
         LoNX5YSYv1+Q+Hid2NsGbPHwB3U2nXhKQkyowjMNT3myG96Q9jCsaNn/TA7es2X2vZF6
         MIOw==
X-Forwarded-Encrypted: i=1; AJvYcCU11U8b4diqBs+kbiZJsKjeY53zfXjEwBfVku1A4gZ39PIgYp0Krw0tJ/vgssG/HMSUo7HAY4Kv@vger.kernel.org, AJvYcCVFLLECGO0Wepxgi/h/6+wK+vpbZxY9rrxCRrC6J815499CfknKuxMlDeXn1Cc991dX59SgTjOr3nz/DrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy+VhsrVIH6wkOhOmZQ7JwHESiFSh/SFd88uoZdfQLqnyE/urh
	Mqd75aAGFTyin4uc5hXjtg3N3+0vTBmanq6dHPsAj6F8JIU4ZmDu+4w2
X-Gm-Gg: ASbGncu3pQYaxxRCtIuJsMRbs4suy7NSN7nvan8viHUYs2dStb30+U8Gt5UqrKYNBGw
	KkDPl9JVsIKAPRWcBCbwodPa1waLrAO7pJpi5wKqcMMn4M5m54xXYWJAdH8kbH4Wi/iXhLU3/Km
	qhXMTdJaNKupBIwV8K5kmjyAlIimW5fNUKkrmX/imzB7ckiQ4zTl3Pom8PsvMcpwUF/eG6DwY/2
	TNElb6ZQ/ogTzu3sRQjtHkO95vMun2IOu/UtqiyHLApo/Eucwpqxj2qT7mNWcJ9xIzGmAo6Q8wI
	XifLe8t2jNdsPh9BCUsbpnnxhtnvqUirFjJ+b5EJtqfPJPFyEC69j4aH5NNvngh5SGPS2f2Yeu9
	SM2cMAvVZdlwWBFRKi2Xg
X-Google-Smtp-Source: AGHT+IGJ01RBPjWDQPo0JGFvHQlsX3CBjkc5BgX5rqx+ZQPPwRlCHKwOAyyCvWAN81xVHFx/C7ywRg==
X-Received: by 2002:a05:6000:156f:b0:390:f734:13b1 with SMTP id ffacd0b85a97d-3911f756fdfmr4543795f8f.23.1741229339380;
        Wed, 05 Mar 2025 18:48:59 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4217.dip0.t-ipconnect.de. [91.43.66.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8c314asm5007745e9.10.2025.03.05.18.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 18:48:58 -0800 (PST)
Message-ID: <51d1ef38-c754-459e-862e-015b44b9ea31@googlemail.com>
Date: Thu, 6 Mar 2025 03:48:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/150] 6.12.18-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250305174503.801402104@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250305174503.801402104@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 05.03.2025 um 18:47 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.18 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

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

