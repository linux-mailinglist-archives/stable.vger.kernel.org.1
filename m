Return-Path: <stable+bounces-119410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 906A6A42CE2
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 20:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C81177A31
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 19:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F212054FA;
	Mon, 24 Feb 2025 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ELpyTyVR"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C798200138;
	Mon, 24 Feb 2025 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740426095; cv=none; b=LAvYWZICHALdBMOGJks6oy3HupBsqwg6ZFFMmbMpFvAscXwlN2jMjlyVpAAV+Zjn9CDYUImyisSGKEGGVi9tNoNPkraXHM+wjMGx5DW9JT6KeqjA8e8nKGVdn6QYD0ETAhNn9eYPDZ5AOcQwdgl8XffrY5c06Zr/YphPa2AHoLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740426095; c=relaxed/simple;
	bh=pIlWuwhv32Fy8JMLlSg+tD+gTMaQUC3yphF4Z1NQYtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DTCrC2POp98Bzt+ylqdjfzL4gtsybEuNHCbKqMW3gu+UpV3vhyIeO0La8UTo+CKNaHaYj2PrsntHGphNrJamVwbl5YgjGpna4QKmyypJL3a1HjP5LtupAYeyGvjILmJLB2fq9pYghsrI+ZBmmwJ2ONda1zF5T5tkGDdr/T2vKAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ELpyTyVR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-439946a49e1so30191255e9.0;
        Mon, 24 Feb 2025 11:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1740426092; x=1741030892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B+zMpSCX50TzWUIveAEPWDT1S6dupXFUyCvXOBadv3M=;
        b=ELpyTyVRwzkwvsp08HkUFAVELXyoQ4yH2MtqDJFbQUVnr+bEO4jjA5WCgG0AzOGk2H
         L9I9h5HDr7gp54m0kO1Zsl+sH13VbX/3Gx0ivDcg7vTCQ2CDnecLZYsbmuWBF445LQK0
         sbgrxWcQYUGiDqCeC/wNEkCVvI3IGgsGImF95j8I4kMaYKgg7pmcwhwcu0m7ZZ1en4He
         v1cR4g0G3IzyR7r/ZvVL9BTKE95BHlDkPq4/WhSnGmS/+WLgDfiqo+uIjk9aUNrZSQNd
         VUtpTA147nc77oiO7gQ/UIgbdSYFv8rCsybYzI2ty/DfLJnyCgKKPBtdqg2Bt6awo5qu
         XSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740426092; x=1741030892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B+zMpSCX50TzWUIveAEPWDT1S6dupXFUyCvXOBadv3M=;
        b=EdF4l6TFly0LnaFoLYIvuzNU5+wPHOojqTwX/ZmLWQKh3fnfWQNd26FCHEWlRm4HY5
         fyoK9MRH2c3e6JQwuU7YGo6W5+VPMlWFYDXzvVbt6e/+ge7vQC4vmdUUrwXJiZqzzfXI
         Gmi+RqKJo2xngX29ZL1f1TE40ou5X1SmWocOlPrdrJN3dHUoxwlX6NT2dpxtRenROeYT
         M8owBBwSDbsMATqlqvZX2nEm4VjpeoevLnYFJcw91WSfQN6nk6EFZxkzQVu2pd2IuEFs
         Z7uHxCfgn8d4rkgKNijzH9fAgUMJ3mHpmdSKuSf0rTVFh9952bWyaEFwM3jvqQH7HqAn
         LBsg==
X-Forwarded-Encrypted: i=1; AJvYcCWhS6AHyeUTd8thXPrKEvU/K7Y28dIiyL4gERKSaS+DY5XtNCe/RwfbUiGnzapBRQ+tML+1x+vF@vger.kernel.org, AJvYcCWy0W5vQnURaHCpB0CdYyl4qeygqdSBZA6+Ar0d8XdstwnK9N8V8NOkuWo+eCzK4VTBfiHJlu94lAT/SX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL8lNuj9FL9tBNIG+WlWu+HNV0l3m/GXm1QeLRRezZW8l6bvHI
	yZ1+aLS07vz/JJEi12G4QD/4PGdXRRRPcXrtT19TbjGX22cpCcg=
X-Gm-Gg: ASbGncvwik4aKMestZf8NzJLWzGL3RegiRijEn4Ys89Ekys9fWswtwJhXa9PoD6Smct
	RsaZBy3QcZfarmWblE0DO+qf4NckQRmyYx5XFfIWBDzU8E5OGyqG9b5iwGAIt3hE2DcdobYoNbO
	H+Uz925xuuAFmt/dLHU1MG0Tmj0Zg5IugLB/PkyF8/BCVwIrLyhpi6lDK5iYgmCOQd/Cm+eUsn5
	51tktVydigG8kqxrMsKiN18X3jKEAta26s7YYceZmHcVZ8IVgqu3CZyOc+kua17lmAj7BAqeIVI
	IRjxAsFYgnlTBm+SBjnxiZGdLDntUKeLYW2TyQwpTPgsZt2bWTOcLbJyrf/EP5n4az9t7ATE7fV
	fumc=
X-Google-Smtp-Source: AGHT+IE53N4mkXuJ7fLpoJ5n0IdUhAPGRtSiEGaxYfcj5xCF7dklfjhVyZ7U1mE301X83KY4BJJ6Sg==
X-Received: by 2002:a05:600c:1906:b0:439:8a62:db42 with SMTP id 5b1f17b1804b1-439ae1e62fbmr103998865e9.8.1740426090451;
        Mon, 24 Feb 2025 11:41:30 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4180.dip0.t-ipconnect.de. [91.43.65.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab1546fadsm1083775e9.18.2025.02.24.11.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 11:41:29 -0800 (PST)
Message-ID: <5ab54053-bd9f-4481-aa7e-476dac292a30@googlemail.com>
Date: Mon, 24 Feb 2025 20:41:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/140] 6.6.80-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250224142602.998423469@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250224142602.998423469@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 24.02.2025 um 15:33 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.80 release.
> There are 140 patches in this series, all will be posted as a response
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

