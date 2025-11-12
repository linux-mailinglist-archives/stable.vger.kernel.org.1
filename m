Return-Path: <stable+bounces-194635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AFCC53F9E
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 19:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83C964FAE2F
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 18:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9225D3546F2;
	Wed, 12 Nov 2025 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ot7iuL0r"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E92134BA5B
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762972504; cv=none; b=Dxr007IDr1714mK5BYuk27ZrDCc6BQA7CtSzuM9eflOQFPKMPzp1ZwcWkvsWVU4uLEwmGh4JnEtStVED6K8SnZxnWuIglFnOKWBHtIoAmP698hrmtAPQpMLl5PEichhP6rtThn/aA0JGKAwa2/UyIy99AGlfmLLeFQ+viVpETig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762972504; c=relaxed/simple;
	bh=CiCb/WxR5IiY4zTCVf9V+wc+I2yi8BeC/aaOHbPg3pA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rDf2K0NRP361DkTehhpHLgWZkpHPhKgqGul6tQ27CG3BE0gDELWmtF0wTsbpcBOSWeg4ejt7nvlMNcQZs8pMcRxpWQ+zafUq25NH5XBBaeDXO9w37p336xviYn4rjHkEAQslPvZtWKlmk2gSzzKrYPe2a5enxMQ0RGjeBzzv9v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ot7iuL0r; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37a5ab1e81fso9463041fa.1
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 10:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762972499; x=1763577299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjohzFTrNt1dds0Ak9mhbsBPxnWVffo9MAGuUzPAPSI=;
        b=Ot7iuL0rV+cT6a5+BClr1i1wVP1eWjkgNfoJJe7z12v/HaqO2yXAB2+W2tHYoHqfKw
         z0LhZV1Ja//0VTJcOS6ibwT1Kbz6piy/uDIXW7GaLg2uNvKJFSL4ABT4lQlhkJX352pO
         P3jK49WaCLIlRTGEkqFxgyp4Ty0gGgAafofXtRA52nwiBJfjjfeRLn1ly2YPsIodg12d
         M5cG+dbWEl/YCGdaiOuif+5tAii/PndS1G20TBIyao+gJHjUJgbeWUSatZAqjZsLYAWs
         WklmqbYR4nP5TW7fw6IRNABPHrkULSw/rOWoVagqn2n/6f8Q4t3qhMjPbx1CSr4GLMzW
         hHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762972499; x=1763577299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jjohzFTrNt1dds0Ak9mhbsBPxnWVffo9MAGuUzPAPSI=;
        b=qHGQ5ofUMBXy+d/9TItNXqHUzSOirLkK5RPrYVZ7HkzbknKJMafZ/jkV9oVeKuiIqy
         KHBMeIbzjb31GQX2P+6xdolSFO5KedPIWD7F4ILILMG3mBbyO2vrizC8s/thbNUo5XI+
         TK8kCn2pcZx7UYpPkHSUjBf/BAbnl4js9RYPImb4uDR6QT84chKHEa4N9Nj4cUzv5qr3
         pTMRE1DmExMuMZthw9KsHtHMH3TuTyTBNRdp1zUpG/yrPhSu7dttBMY2xCN+A8YxwgAI
         O7w9WdGIeSF1dvclm+QmusqDCgJPO+bCAMFtKliEzzPQnx8Ivi/OTb8ZOJznEWPKVree
         TWhw==
X-Gm-Message-State: AOJu0Yw/N6VL6XDdRBHhz+gOR9LScYVSMy4M8IU1ifIruV9mJ2Cl+7ps
	ni9SBgOG7l603GPCIIw7BSA6vg9DJOAHm9O/vcCpIWcRNjh7YdyJlaKjH9EDQOGIfzUcOcbNyIj
	teCSerGQ/WySrMLqiztM5pl3Lig2rEHI=
X-Gm-Gg: ASbGncte7X2LWWyG9dPTiQzLzWWZ7q/8AQ4LFTAKndo10IcsfhHCYkufwdXVY3ggif/
	H1UREtZfb/XNyYbsv4A4mWN+VlflPta1G5FDLE5f25HBjJgCvG3j4mHqz5ftFEn9NcrxGeYx2Zl
	rY+fAOm+A09h+0vGKttuy4rreb50Itwj1317Q2YJ3wqPwZ6WEkHt976CPrWbqFhgHnN5C57R9a1
	xQi9RMri5mR1OE3NunQCBSa6mIXsFY3O9Ijh3nkQ+QoesUauL70BLFd+6G6
X-Google-Smtp-Source: AGHT+IEa3xVTKMLat1Wb0V6k6SNt6JXXRV4if7NrYfYOs9e0hkHkyyXtZb+lc0TmiRtVlY0vx8iH0c8Q2gESBvg9vVA=
X-Received: by 2002:a2e:98d2:0:b0:37a:9558:5bf8 with SMTP id
 38308e7fff4ca-37b8c3dca00mr9373041fa.32.1762972499219; Wed, 12 Nov 2025
 10:34:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111012348.571643096@linuxfoundation.org>
In-Reply-To: <20251111012348.571643096@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Thu, 13 Nov 2025 00:04:47 +0530
X-Gm-Features: AWmQ_bkg2w5p36Lweybo9KaHemnwRDH-EtITn2wPi38Rv8gnjjgkxCZ4pHNcSPE
Message-ID: <CAC-m1rqHCCMwVu4WVVV4w0SXuZNuv+e+Q1qZUzVrxH+=EeGJNw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/562] 6.12.58-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HIII greg,

On Tue, Nov 11, 2025 at 7:07=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.58 release.
> There are 562 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 13 Nov 2025 01:22:51 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.58-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Build and Boot Report for 6.12.58-rc2

The kernel version 6.12.58-rc2 was built and boot-tested using qemu-x86_64
and qemu-arm64 with the default configuration (defconfig). The build and bo=
ot
processes completed successfully, and the kernel operated as expected
in the virtualized environments without any issues.

Build Details :
Builds : arm64, x86_64
Kernel Version: 6.12.58-rc2
Configuration : defconfig
Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Commit :

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu

