Return-Path: <stable+bounces-160241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F94DAF9E08
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 05:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CD947B6073
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 03:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0753927280B;
	Sat,  5 Jul 2025 03:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ERRON1bJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9651C5D46;
	Sat,  5 Jul 2025 03:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751684715; cv=none; b=QUgJBnB5QMV5fQqm/ASNK65mQlUd5rtyFMRKDrnpQ0y3NR5mM+dFAg2ffNhuOWEmMx8GL1ySEZAM0lWRY2WaizMNBQmGXIZjnTaFww5s3MifnlfbI7bQOY6BNzwPFkzwRddUR/P4ZSuY33c7ilCLjMtjBLx4HtPnLFyqm3OqfyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751684715; c=relaxed/simple;
	bh=Vlx2GvFm40wboNWyllqdf8cY0wBZ7D+Hm+a57/azXbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZK+uOSDK3LBx00HWX47vLA96GHkRXZwEoTsrqRuMj8kZb2/kfl/SO7M6iS6EkVvrTs1PR3Lslv36v5Rhfw1oZTL4XA9q121m7ek9xZHjlVp8xoTphqy2z8ZL4hBYBhzdGpyPLjATWlYY6YItTn2zb6/H15mbIlybZIxiPs4L3IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ERRON1bJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451d7b50815so10595865e9.2;
        Fri, 04 Jul 2025 20:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1751684712; x=1752289512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vqDgb6K91dMFZj8xNFjdBXiilDAaERulOXneKfNxeww=;
        b=ERRON1bJ8oxwU6ceotb4Sz7UGW5JLW5HVUl5SrOdToetbZwVqi71Q2kA4PJ3jpqHrV
         317BEqTvC/wLP2Nnz9JYXLCFthBiudzjDkURRbOhbbYwcFqqMKkXEXePcgfnTy3mRrDf
         n6td676KUYGtwYE3cdlAJcRl8lC83fLbCuX61oqITkuqmw34JZdS6NIEwR+H8z0Jwjno
         o8CsueJMU0YU2VjHjbLm0aNknQ6aCB4fItBp8z2/qhBtexzvbc4WmdblPKfqzO4lMW32
         RI7ayFQnBnEUifW5NTIhTf3CmZsDafMXCyBYnvkgUGK38o6dKBbcFvOBqX+Nb3lK7cQE
         OFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751684712; x=1752289512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vqDgb6K91dMFZj8xNFjdBXiilDAaERulOXneKfNxeww=;
        b=ugpF82BJ9zffTwP3tb0TsfZaf1KNS7CaBxkdZzSc5Ob0HnyE29dJMOvpCQ//uhQJzV
         mRxC4qKFcVygxjhKYJr5PbnYIeEEllcWrceWXLuewjy+f9aw6a56pftl4Kw4Iq458yV4
         72/VtCu+iH0RoYUqQw4gpfQ6/5g/dFuB3/QRRqTK0t+czsEbD1oCl88MLhkd5eXblJeS
         hvDojiukLl/NlX716dNYAtCxJpsBqDVdi1ysWyfbgtJ4FXl71MLgE82yq1s8w+FAw01/
         h8Z4CyTlEjVWw7FKvKoQUwx1E+vvFCpIBG2qe5PRr4grp/DB1eqnQQxoBcHxouxJj4Nv
         ADfw==
X-Forwarded-Encrypted: i=1; AJvYcCVY2otdXlWru1uowNtIbf6S/wHshNPYUGbucPrIL/0REVcNcsgJye0F5XwLuuXhduCy+EJnJPMnWIYBwTE=@vger.kernel.org, AJvYcCWe9VY02i2I/vwhw26h8QlBs+L3a2X9FUmfzh9B9jdebBS3ZbIEtdNPALc3xcY7aAbdqJNEP369@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8/G/+ysSTAqsU2D9OA4tWvylmDnT9onV+I+4IxnrYblT5TX2X
	j4GhX6ZJFpsHzOAmfdN0CwAMmom0go4vGeXDdtm/rKWizUTO3PkJP7jybuC5g3g=
X-Gm-Gg: ASbGncsqP3HGNDJB4Fn487h6PjjRYwxYNvFSdRW1fp12vQzglooQyugkmkkTiUb06Kl
	02Nf3Q5kCIn+RwdkP4FyzWKyfnrHjWXxcPOhL25Y25icgrvOBaWng+ViihxDEbRqCP7hGI0Bvqz
	lZkQGezsseIuIS0D1h0Tst2AuesXLzutux0JrrqpJfJoWfMHiuWsKr55BV3BNGj13UlAu7xNcIm
	VqUg/cJSnDGpVDrpvQ5P+W46g7kANcsS53IGXDKg+ql0V15yM+e5gMAn/ALpIK1p8j+i6OKQ46D
	uSfh5uZImfoOXWfTB2C5fdrNZ7jSKEfS8sTp/0TySnmbiPv8W5l1NBDRf/4QbBPTfMrVW0KvuX0
	mtid4RCCqw4iVRO7Im6mh8wcTSTKKUU+a/V2Q7HA=
X-Google-Smtp-Source: AGHT+IFQud81K4EZdzm02dUULvNS2awoAwpf6hPFkMhnS2aLLE0I4C3SRdmCGLLVYb8WkdHV/QxdyA==
X-Received: by 2002:a05:600c:3b01:b0:442:dc6f:2f11 with SMTP id 5b1f17b1804b1-454b3169103mr42806675e9.25.1751684712260;
        Fri, 04 Jul 2025 20:05:12 -0700 (PDT)
Received: from [192.168.1.3] (p5b0570c7.dip0.t-ipconnect.de. [91.5.112.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47225a6fasm3828039f8f.81.2025.07.04.20.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 20:05:11 -0700 (PDT)
Message-ID: <62e3fd86-f640-4d67-950c-791674cea5e2@googlemail.com>
Date: Sat, 5 Jul 2025 05:05:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/218] 6.12.36-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250703143955.956569535@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250703143955.956569535@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.07.2025 um 16:39 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.36 release.
> There are 218 patches in this series, all will be posted as a response
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

