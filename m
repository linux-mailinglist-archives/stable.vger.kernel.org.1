Return-Path: <stable+bounces-107751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F00EA03016
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 20:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45E81885F14
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 19:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515C71DF748;
	Mon,  6 Jan 2025 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WS23p4cj"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A394503C
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736190042; cv=none; b=sK3ACmVxFFE01sqFHTg4+OMMQuQe+B8tGdCicH1psrDdpdPY/Fz/JzEud/RNDeWlCGI6ZAB4ewP4waI9WWtH2MmHPFrKfZV/Yfdso74Nf0nQpidxcPSZ2E8PPye0i7y+sB4hmL3Bej9MsyNOJAklpuytcX2zxo6gQvvhx13N48Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736190042; c=relaxed/simple;
	bh=B7rVRS91AqCk9yDGpsv3634h2LOcw/WLlfQL1LFLPMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euk120KGmfF8IzXUSmUznuGk6Dh8l44ti58AigDYBKdCM615GbOIVnRJYVlC1nOuGCBFzMy+Wi3j7fDRd7/B9qmIUEK4z+g7xc8fDGU30KO2v3lzVuJlwYmhfkhDNxgH9UI1KLk3cKBxnJR2+sNCM2DQPQmfy7ZEHI3KujlE7lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WS23p4cj; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4aff78a39e1so4241520137.1
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 11:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736190039; x=1736794839; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/SamHPw263yrqg1TIgcL3Fr0uDVcwI04kQhRloNiwTU=;
        b=WS23p4cj+QMbGcFc7AI/LSfDzB8ykseywrvXk6LB0gAzL/cRp1Lm/tyBzK1PlVJhE6
         hL2mApDI5yYv0ynlY3OaBE4tyPij8QMQm6PzO+0aCMKOt4wP0RN3Zuu05zGplQiqBsfr
         /fG9QRVY94AoJnAzvyCh9bdDVRRQnri+3GiABcBNi11A60NmL+/7agFKPo7tvbeCIeMq
         nyAkqfUruwMmpO6W8xgb/iVwkWZv52kwwYJ8fLEEZT3i0d9e58wcpJ4WVPRWISH015ap
         Gd/A6aCuG7wQtvuiCimq3bPWMCcG0/UntmrnMpvyylKtcygBFntFzH5zVdMQinrAjr52
         swjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736190039; x=1736794839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/SamHPw263yrqg1TIgcL3Fr0uDVcwI04kQhRloNiwTU=;
        b=PX/yoZLR/aMWqLwJNxsXMayoRs+MZ6UIeLZSAXk0pzrVbXlp1TZiZG3CfhP/SdhZaj
         v3IqyP9VyTTEZ8ur40hz0QSrECCCJ0w3uKlP4NNV+wjpyGPjai7JoCPTAgjo+ovcoWDB
         PF+xYyihErheI32v8P2nwgKBymBHDRYpSueYJ7zhYaUqCD9UPYiblRUxisepOwp80m6B
         TSF7z9XkFsgeX0fZXphFrLscg5JMECYuTB5NSxuVDA31et3DNSxI3uOy1dqNbPG+pqy2
         lID55NtejrZHtdr43pftB9gYDqYVfaqTHbDBwBg6RlEQhuV//UHaNpX95BZbdLvxv27Z
         OleQ==
X-Gm-Message-State: AOJu0YxyQRNqKa2E2WQBR/le9c4zRDOENGZeWvdj6WKwDY7kPEefOEH4
	+SX3XOMvkL9fO/3lwy1oXS9WJV7X60LDEpACAIh4SZ2r1Hp4IGCMO6O1XvEJ1kTQTrzIoSuNI4N
	M8ARA/HOm8JVEnGklOr1W3RN9I3WtjsnH0LoyJA==
X-Gm-Gg: ASbGnctIeFcqenT2ZllfnacQyYo7o11I16+9H+zsziN0Nd219DOjnhp28nqsyOgCKju
	NHdnqXnVSumj4u464Sn1aVmmZr/InBkwdSLc3gMcR9tyqpQ1rC5DValW44jW76ijEQQI=
X-Google-Smtp-Source: AGHT+IEfg6L+vAJ+W155bbYhFlBN7EQr9HoPXCxPpXMxSiDpusoK6g29Za4uGp8RgqzdfD1PvvZDhU7iPn1gVCTFucc=
X-Received: by 2002:a05:6102:3ed4:b0:4af:a98a:bd67 with SMTP id
 ada2fe7eead31-4b2cc313aaamr52272787137.3.1736190038068; Mon, 06 Jan 2025
 11:00:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106151150.585603565@linuxfoundation.org>
In-Reply-To: <20250106151150.585603565@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 7 Jan 2025 00:30:26 +0530
X-Gm-Features: AbW1kvZgDTF2dX-LsDqh7ToTptDXowuCxSxrU1wO36mVYDFbBVHHVuYoi_0Rmp8
Message-ID: <CA+G9fYuJA5eUxunLVyws_J6YNuZdyVUjTGGgGyPwFMgCHUpsnA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/222] 6.6.70-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, linux-i2c@vger.kernel.org, andi.shyti@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Jan 2025 at 20:53, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.70 release.
> There are 222 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.70-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The following build errors were noticed while building the
allmodconfig builds on arm64 on the stable-rc linux-6.6.y
branch.

This is first seen on 5652330123c6a64b444f3012d9c9013742a872e7.
GOOD: v6.6.69
BAD: 5652330123c6a64b444f3012d9c9013742a872e7

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
============
drivers/i2c/busses/i2c-xgene-slimpro.c:95: error: "PCC_SIGNATURE"
redefined [-Werror]
   95 | #define PCC_SIGNATURE                   0x50424300
      |
In file included from drivers/i2c/busses/i2c-xgene-slimpro.c:12:
include/acpi/pcc.h:23: note: this is the location of the previous definition
   23 | #define PCC_SIGNATURE                   0x50434300
      |
cc1: all warnings being treated as errors
make[6]: *** [scripts/Makefile.build:243: drivers/i2c/busses/i2c-xgene


Links:
-------
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.69-223-g5652330123c6/testrun/26613311/suite/build/test/gcc-13-allmodconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.69-223-g5652330123c6/testrun/26613311/suite/build/test/gcc-13-allmodconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.69-223-g5652330123c6/testrun/26613311/suite/build/test/gcc-13-allmodconfig/history/

metadata:
----
  git sha: 5652330123c6a64b444f3012d9c9013742a872e7
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2rGGBoqD6FxSfg6IKJLK43h9cCM/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2rGGBoqD6FxSfg6IKJLK43h9cCM/
  toolchain: clang, gcc-13, gcc-8
  arch: arm64
  config: allmodconfig

--
Linaro LKFT
https://lkft.linaro.org

