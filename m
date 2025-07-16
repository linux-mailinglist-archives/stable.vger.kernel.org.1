Return-Path: <stable+bounces-163128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B46B07503
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 13:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EDB5582179
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 11:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351582C08C8;
	Wed, 16 Jul 2025 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVCpynLs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69500286D4E;
	Wed, 16 Jul 2025 11:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666561; cv=none; b=ACD/z9Q1SaE4JLEmxZav6NkhHDZyEGmZW88OHTdKwcTo+RNfsBf0WPcXqLId9TFutCmAuE+EGgZzx87BdogsfCmBAYzg2X4wo+LgmVD/DWvga5Gw9uQBObqUak5IU4wue4Fl2e+rWeuYf+Ymlc5s+O15fgf2aOlZQjpRzvk8Xe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666561; c=relaxed/simple;
	bh=EfIZ3AaNhUTMuhQh3gY9/eRnLi3OVX5M6gZKgoUL7yw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IUCVLpIDIg/yaR3HC4iByPymw3DEMm1Ky4Wj2bkIl18dePJMCB1Tkfb9Wu9qpNSSOs0u3+t5EDpxL1ZRqQ+LZ1DOZoS2kyOdOhkQB8HKQnejXZkIDxol9TL052SYjCLjV21s+jWzFWhnvIoYgDonCHw6qtf4ZTyGqv6PGMelu1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVCpynLs; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45619d70c72so7287535e9.0;
        Wed, 16 Jul 2025 04:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752666557; x=1753271357; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4mHwEr8aXM8Rm2WbnaOlMv2XTUB4hN6RMG5Qw6s+9Wk=;
        b=UVCpynLsF3oZU6ID+C4IgBhf9ApvszfshuGqhaGiAQWMtiAd35+y7JSpZZdguBiuhQ
         /15J3ujddPimwB6j9QLGW+hbbaez6gLE2Fld4SyTHk+lBeT8wqyiq8QMHuXPV5VxIub/
         9Q4xr/goiZfYE0VO9MeKN5qppzSFpO1hdLxlCg9KXE0KjnyYStsWkJ6X9rhtGlaa7ZO7
         3yb9Cbf+8HX4hf6rFCs4vDqZ3G7Vl2sJ2Y2T7OGGNCtszv6ELe5mAhC64sPULlifH9PM
         tv+8ZLA+kNkOt6HiFpLzIkh6X6TPFHX58Hi2Khl3EpSYnRjP7YhI0sHWKXFY/mK93k6t
         5B+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752666557; x=1753271357;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4mHwEr8aXM8Rm2WbnaOlMv2XTUB4hN6RMG5Qw6s+9Wk=;
        b=mokVTCxzt4PH2re9IRQ5jZ7sDEhm1d3msWZYNkdwaiQybZAmsbY9AAwdvwg23Ymk9d
         5JGXXHJEVtAX6fx0aRJvBuR14PnjB8K6yW0Ehtl2aBPiPNrkp/mOt3TWzejelJLenYLF
         aJQfJQfURZ0oEBUpVzCleu483aI0d96kBQn700uuhUpdOvKLnWxGHaMpnyB42VhVhamg
         dvQ2hHU4FwLfT2wUddFEBqUnnx36s7kChNSdR0IusfRu7U1UuG9M+bY56I5x9Vqc7od9
         Q/0LJ4t9EyKX5z17aeGRvaeEtsL8ibdNWFZrYHiVYlZ32dCbN3R56KlsDn7X/E5Jo0Ta
         VWQg==
X-Forwarded-Encrypted: i=1; AJvYcCVEHGRynxd57wHfPqjd4J2naIIiRLCxfAvuj+pkSfR7F7/Vfjbb8fxb6UiHFbwPAz2vqxU462H9@vger.kernel.org, AJvYcCXcN/Bd6Ly0hzVw+4QYQsDmRfrgVj1hMSxpeUZQ+fgvQ60VFQlMJMhANzJZkfNQ2izu4seekxwR5/r40yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUVirHU9NU1CoAt5QIgmmOOjKyQ27H8Yg8dX5SjAg6uk6+CaKo
	HgpfgeYjCB5xIDMSeA1VkRS2lYfEbypnax0BDFukxIX1aGktHCgigVLN02UaIAcOoKjt60pKRLH
	5nwFr7lv1pPK5LUEDIyBcU7/T51lngEkldhuqUcE6PT7D
X-Gm-Gg: ASbGncvq6Rzn3kGBs/U3fbhrF3Xe3aa8xILRZQFDhULjjQLK1cca65sgE/UyQMz3PzC
	ovzBSOHrpp2j9HEZWvKP1kJyFatW8J+ths0VgCbgfHaeGBTtZoA7mp3MC9FVRWgYJWsKgV9Uf1v
	UCB/g5sfEYaGaFgiY59lICywr+goxLaERZIjYvywM30AszgKeG/yQcE1c8FQ/aBWeSxK72gA0nn
	Gjb316KLaSjoOJ5Cwdl4fxlrJfb2fqtzAFU
X-Google-Smtp-Source: AGHT+IHd1O90KF1+jH53EPUgdhgA0S+qM0ugf/xNYrgnYVrSa5To++qM+eBy8Mx+ZQrXxsG40EAjBGOx/NExfNplCY8=
X-Received: by 2002:a05:600c:1d03:b0:456:1ab0:d566 with SMTP id
 5b1f17b1804b1-4562f825a5amr17037445e9.16.1752666556454; Wed, 16 Jul 2025
 04:49:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dileep malepu <dileep.debian@gmail.com>
Date: Wed, 16 Jul 2025 17:19:05 +0530
X-Gm-Features: Ac12FXzQIz-iQkdUtftKGgdOsL1jWnJIYTwWISRGw9PwtFZI6pam8h1KvOjDnwk
Message-ID: <CAC-m1rots=Rz+_VRWQetOM25MGLnEnQ89EO6DQm7ZykP5TjsdA@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/192] 6.15.7-rc1 review
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, broonie@kernel.org, conor@kernel.org, 
	f.fainelli@gmail.com, hargar@microsoft.com, jonathanh@nvidia.com, 
	linux-kernel@vger.kernel.org, linux@roeck-us.net, 
	lkft-triage@lists.linaro.org, patches@kernelci.org, patches@lists.linux.dev, 
	pavel@denx.de, rwarsow@gmx.de, shuah@kernel.org, srw@sladewatkins.net, 
	stable@vger.kernel.org, sudipm.mukherjee@gmail.com, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.15.7 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Jul 2025 13:07:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.7-rc1.gz
> or in the git tree and branch at:
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Tested Linux kernel 6.15.7-rc1 on Fedora 37 (x86_64) with Intel i7-11800H.
All major tests including boot, Wi-Fi, Bluetooth, audio, video, and USB
mass storage detection passed successfully.

Kernel Version    : 6.15.7-rc1
Fedora Version    : 37 (Thirty Seven)
Processor         : 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
Build Architecture: x86_64

Test Results:
- Boot Test                      : PASS
- Wi-Fi Test                     : PASS
- Bluetooth Test               : PASS
- Audio Test                     : PASS
- Video Test                     : PASS
- USB Mass Storage Drive Detect : PASS

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

