Return-Path: <stable+bounces-202733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 140D1CC503A
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 20:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 545A230422BE
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 19:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF7132F74E;
	Tue, 16 Dec 2025 19:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Leps6HpZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACCD324714
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765913731; cv=none; b=dmLytHu7XYn2hXzTUNUusSlXwx4Xbo8sdCq+kQ3wVWPHdL/5TpZ1ENUtyDlVlNfXhL6su46b6Jdm9LDBd9PXxk16gQoo17MqKZSx/e455800IG/bKE77N/BQS3t1VDhp0woSIoLpE248gx8U9kGNylyy8dLsVfDq0pISz58vNVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765913731; c=relaxed/simple;
	bh=Rakyn03cAn4ws+rNLp8303TuvZ2Hh6/IlUu4Bqrn6HY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkPzLE6Dv9aQMfYenWggIfF/1js7sj/2F7LBT0NUUwMSt0put6pp1iCmtIzW2ZsQC7IXQ30vgiLk+PYb1wSU/qyLcRRYq/k8mbDCqjsLst/OQWvOEl6L/s6MeWK2CBRiECdf/6RemUP61FZMQwTIo7oDT4Z/1BuqVbNQo7yr7wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Leps6HpZ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-37fd6e91990so33060271fa.3
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 11:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765913728; x=1766518528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fiWdyTxHzyXdHV/LzIlNud4Xk0jRxN/vsFndQKWzkA=;
        b=Leps6HpZitSM5F1uc3Wh3+rdwY0yZ0CJ0o8rtMzsFIvwYkoL7G/3MygWQTE7SHNBIi
         2caEP07L+Pk5WNUMQzIvnyCdTQf1pTgQnIyaieQP1SE2auzWUolR0XpvZFD9Zw5zWpF1
         qbquDoy94nKyfoyveaNwVq/tLpu6lacRWtT6f1f0Agmz4i88Q2xTMM8LGMG3NZl4fBvA
         ETiJ6QvGp70sSquPkogVASy3nQtU3S834HtsbElSP/Yb+svKNEDPg5bUWl93yJT6Ea6p
         FCEMypmyNzOuFksO1b0ePm4PcoLKd97Ttgee/lk0bIZTepnlQrc+/Js7T9Fx98E/WB3x
         XoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765913728; x=1766518528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2fiWdyTxHzyXdHV/LzIlNud4Xk0jRxN/vsFndQKWzkA=;
        b=u7BCb0AmvikxwljOEYq8klz/GN4Lhuw40op71R2oq2LFXTW3/oQA6Z6WScN72DL0no
         M+7zDg7Zlj9QY96bd/li4cQQW5nD3wenqnWEtR2dD4AtZosWdBAnXg63fEmYMqtn7sA+
         kR2Vclf932IMiGgUTWGWgOQMMOqdzo4BRSw6WKdTxRoNKrDSgGEMWlPVgY8pXjqNLaNU
         JBjm82wntTKUlsvEfGuukZA7wVwwZuGcfewKvQTNpQoekssVddtKYwikNzm+Ujrj3Q1z
         sNquaTa6k8PNp1bm9AgGHvKmOktRgBUvATqrbtulXCH7j9nbNUiTd44TqBpxbV/pS90W
         vkzQ==
X-Gm-Message-State: AOJu0Yzx+WbKb7ZpHOPcgJVVHBRASNJpbty6VPtVNQsgq1M0jdIgpbxP
	M+/o9V/0By1qivUJ9mOzIrO9YqpfLDEPKKqq3pXyJhl7FbzyYjSa2uvjW+J1iWoM3o7jOynRh+K
	gMzOHP2H2lHD+NGh9oJlAfBRyHEV1gTx+GofJ
X-Gm-Gg: AY/fxX6VOu4b8s/JEkMncQH5qOPNMHfslGnee4cqPxbte/dbFO3lbgd6S86E4+8S3kE
	q3KMXpkfdH95I/T5zs3kyE2hFpakNlzKO7b/66gJIzooPebZE/NSlFelsaW0HHCfbkd0TqhKVcU
	5ZNtuqVXgRbCtDRQXyqmM4dL0BwvuFG+aNI3kdPVV/abysZXvuJB9IIDEmrIZR7lP4fvpcAxBKl
	WlUf3dBXiPq7UY73allLwYdMhfj8frsF2skohL+JboMKo86ZxLaTzQp2kMvmSRyTwc/+7RNW/Ws
	2BVk8eVrfI7CNpzU2YtkTa4udmLmfk+u+AaDGx8=
X-Google-Smtp-Source: AGHT+IHZM8F29rp+QN4MkCIOrX/NB2E/euo2QTu/DopKbrenIZ+1+TQWP8v7tZWC9LQE2K4BhCvnHd3cxZ3xPZC7bVw=
X-Received: by 2002:a05:651c:1549:b0:37a:31fc:1d53 with SMTP id
 38308e7fff4ca-37fd08e3424mr53192691fa.40.1765913727332; Tue, 16 Dec 2025
 11:35:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216111401.280873349@linuxfoundation.org>
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Wed, 17 Dec 2025 01:05:15 +0530
X-Gm-Features: AQt7F2qKOKbFXjxASAe-Bch2wX46L0eCWZnOy9xsLOGgVArYPoja3obSdP1hc1A
Message-ID: <CAC-m1rrxiEimyx24MjZze6doMEN=EevwOMb+VPuiy1reh9Cdug@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/614] 6.18.2-rc1 review
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

On Tue, Dec 16, 2025 at 6:32=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.2 release.
> There are 614 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Dec 2025 11:12:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The Linux kernel version 6.18.2 was built and boot-tested using qemu-x86_64
and qemu-arm64 with the default configuration (defconfig).

Both build and boot processes completed successfully on arm64 and x86_64.
The kernel operated as expected in the virtualized environments, and no iss=
ues
were observed. No dmesg regressions were found.

Build details:
Architectures: arm64, x86_64
Kernel version: 6.18.2
Configuration: defconfig
Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Commit: 103c79e44ce7c81882928abab98b96517a8bce88

Tested-by: Dileep Malepu dileep.debian@gmail.com

Best regards,
Dileep Malepu

