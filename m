Return-Path: <stable+bounces-139083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2816FAA401A
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 03:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D9D97B7684
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 01:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F082DC761;
	Wed, 30 Apr 2025 01:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HAh0tLEU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8967B4685;
	Wed, 30 Apr 2025 01:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745975438; cv=none; b=dgMOrEr7WccqEOWCJqg8Hu7dycRRLXzDCCs+CT9mTEeFKijXlcrjaTlgPFJga9ewnqyVP39ECEdMQBN8fVhMT+l7zQciqY7dgY2wIA3aFUSWauDwAaXxpJ7Qw15fp0FGCZL0Ghc04jv/QvzKo81LFfa9fzCYNaBd2CZrjT8+Yt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745975438; c=relaxed/simple;
	bh=GcA0wqe4bwS+nqsbaE7zGxsfAfwH+z1wdZ2jUKGpfNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TcGIzf/2BvJKPq2M6NK0MZZv0eoQbboW+H0LjhnBXazojg2uor1ldqhdK/RS0mXtcCFcokFP9ej0H18IyoLlcOIUSkNItDt7Woyo9z+ES4SlXvY0qIwLsUXwO82GcvNSeVwgjeyIYM06Cj9qy+jyc7l183xpk4b5aUAX3A+X6H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=HAh0tLEU; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39c14016868so6928267f8f.1;
        Tue, 29 Apr 2025 18:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1745975435; x=1746580235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fy0EpqkwjDtmTcF94zxnemA5fOntKhPCB9hsiCBnym0=;
        b=HAh0tLEU1yvdiJ0qbNlBS4z9cIw6EhrV5G7xwFRHmQ+hvmeT/tRv3qxsAKZcgv3EnM
         sui/HPvs/vFRPPgjMbcSfeVyl/x4ncVdJofaXqACyvzHcJhaVfeRyP1tMAyuy2SPCOhb
         llZxnjsmqycSItNZkdx2HkyFT7UMr7FZxZ8UykgOqlwdMtKSbNmjp+cJ+drqR+WnPckE
         aoUnxERztASuLaJK5/U4+Mt6nFM3/HeRUbxMaaJo+kQz7So61y/B90JKOjksm9z2fVER
         DrkpQRwzcVMzbDUZImIZsbUcJHJaXe/MkXQfyJc4mawxI533BjW41YKjMmuQtwB0NbYz
         3+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745975435; x=1746580235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fy0EpqkwjDtmTcF94zxnemA5fOntKhPCB9hsiCBnym0=;
        b=tt+hA12C7OvJjgaILW6YkoDN13pslFD9QZwmqRCZ4xM9K02mrEWJ0SeAmJAZsVD4Mj
         4lUZKd6sAmxzmPD6wQoje6a8gGEU87wzL3oA4fWkX4SbGdsSxj8qb1KQC9e2hatkqndZ
         c9bsNSPDwdsQcBbOLxQsfMFwPaXu5wpVwuTptljbJexGBI5ugtDkbpmzHsOzTyyWKYYC
         LriKa2SR1uP7qOPQUYiony1RPQHVcJWholvPFV+zpyfoJs5umSOme0FM63GiCpBKXUZg
         Gm3vD9qEDniGXGNzy3xpnrPi4XJMPaGlZDlV7AgmRAsO53I4Msnof+GjKJCgtmhoiDN7
         N2qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv3CBGrYuhrQawgAu5OvL8nVa0ZM6D8Lc/ZqVB7AR+scVxsMjX7PfJreqTrqDpfQ7+Qm8t7AmLIhMeZqU=@vger.kernel.org, AJvYcCWTwWuOYHxyVDpJ++IlSqbHChbd4vCaqTtL5tOWPBauvyU2F2t0c4GP2d/wugWTnHXzOw2NPyQL@vger.kernel.org
X-Gm-Message-State: AOJu0YxSEId+i/SEqx0/Kts0MDvxuJGblP67tTZ3OPeKbHquA6Z1cVhY
	/jWPHf5TYkgTuIvhVG3ieCn5kiVO6DD0aKJ+SHhWQd9f0hTi+VA=
X-Gm-Gg: ASbGncuXr8ulZXlkJuVrgHAC4bNXR2VdQdT/64/5yh1DVmXltvMKjijkUKjp9Y+2O/w
	/0YoGQickiW5KAMoRnuAWCPEVeI8lD+or4hw2mEAq3x+20vVLSZOhpbm28g/lHibSSaUY5P4rXg
	9EDuZzFFA6VQEztXUNk2RFL51C1SHIpe6fMSz+tFpJWKLEMrd/n8l5OJJWS2mICZQ1HF7aRU9lU
	DHmZVZlIefGte6Qraa6VmdhfJvUgvYPcA2hRfFFWuQfq9RY1sLRGY88efB5lgKUm5isWF+v5c8f
	Q1GNIETnDhsi8GMHMtOhPW3Gz+VYE3dU3GFVTpxY2WA07T7E5xKuAmHwqLXfWO8baeEuOfRrV67
	6xgoB3WdG6UXhBVoXSTU=
X-Google-Smtp-Source: AGHT+IEfCZyklWz25dz8UgxLE8bMSFKXl1EvDpiL4cI6Uh838bs3W6K4R8SlOQyze6UjmyVl60Hv3A==
X-Received: by 2002:a5d:64a5:0:b0:39e:e438:8e3c with SMTP id ffacd0b85a97d-3a08f7babaamr1003573f8f.53.1745975434662;
        Tue, 29 Apr 2025 18:10:34 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac6c7.dip0.t-ipconnect.de. [91.42.198.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5c6a0sm15385345f8f.86.2025.04.29.18.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 18:10:33 -0700 (PDT)
Message-ID: <92ed23e2-651a-4730-b5b6-d9e85761c1f8@googlemail.com>
Date: Wed, 30 Apr 2025 03:10:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/204] 6.6.89-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250429161059.396852607@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250429161059.396852607@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 29.04.2025 um 18:41 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.89 release.
> There are 204 patches in this series, all will be posted as a response
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

