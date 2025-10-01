Return-Path: <stable+bounces-182897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6037BAF580
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 09:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A12173203
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 07:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463F42701C3;
	Wed,  1 Oct 2025 07:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4SF4gYz"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C02027144E
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 07:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759302098; cv=none; b=dodYUVxAjItwRLlDlc9frZ3vkuhsVIG2hK04tGSGHd8py+6vkXRajpOpnJXZBcYEKVgt3H0BzOL+Vpm+sqjMEbQSKPDHpVzXxHd/jj8gkzuvsmwuVrwJUutvz5uomqxcsMAQu540r/qqvaj8cD0q+0w1qDvp7B6Ikfz1eqaCrTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759302098; c=relaxed/simple;
	bh=NoddTmT1ZpMZmhvqL/VnxeYOx5G30Q7gAZRFXZdird8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwGAKtSahOrL1Z71F9G4Dy/y143PVLyMLUK4e1Bnu05jNh/lU44RYJBtFf0qBo7iIYnBeupcbplfzie5SaQ3wbDfMbKyGrz0oy1kYNL3AvswbPuvkIxR/8CfCdHUCbot5d8qOWIZ3CE74NH4o3Lp8Nm5Fl+fTEd33dWw++Ti690=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4SF4gYz; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57f0aa38aadso5726731e87.2
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 00:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759302094; x=1759906894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLTUhbN3S9oKDftwQ4KAabVHzCpjwG5/226AXZhhAnw=;
        b=d4SF4gYziQUTLErGuJtyv1QWLx6wGi331oc+QqcxSm6kHE9paW5ncu/WgGuve0AOHC
         N3tyEAVibeYQW9z8WrDGSmn1cpAn4zvF5ilPQHjzLOJbQlLrGNzfUcCqPYeCYn31QGj6
         BuONJv+iaNNXCtYdpkn7EZCm4qufc9B7mZPBno1WY0Tz3ReyWvcOAJfYxdJmCr7dAdKw
         bCdWHQXrl/E2yMo7wsGuR9q4H7BjXNpzyPkVIUXGBEeCLbXk1XYiZx+u48uR7KxJ5qt1
         7kDX5yMs7BbPlgDq3JSBnr6V1tSPwjZ0MIDxGfjZ+zTBKVX7ktGRJxKEq1OmCgpKFrCl
         zSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759302094; x=1759906894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLTUhbN3S9oKDftwQ4KAabVHzCpjwG5/226AXZhhAnw=;
        b=QiuKPnSSH5BQO3SUaDFaE3zPiR//LbGJHd5ynGn9xaazI01B/mj4165/soXjMLjAZF
         sMmwx8gjYgLfrqFINH/PIQdjAMBFuRAyOEy1S1FWTbfGETKRzrRsJafrU4cPJdCM2bkm
         tfYsWFGlWta9B3KmKmVn3JmJgebseCMWn9hNa6At3dwZZgnsrOqUywBskBJMCVsh1pfE
         vn4jAbEbEoPDyL+hAZXBw0C1CpzqDE/R/Hm9mIQ0c9E0RJ9COYjj/Mv5qJCBamrBTKyT
         pjv+Noclw9Cu4HnHmuYBxSrHVSTKnjyv0/K2NlXw/B8Qe0sex2ButSIm1Ur5WUzwjPTa
         tnCg==
X-Gm-Message-State: AOJu0Yz3agM8Ej5yUgwPlgKqpTgrULZYrt+1DT71nmDPq6wvFz/Fjngp
	wLDaS/da/WB8b3KvIrNv/OGB2qsSShgN65/7koIkPECV1s0Xwwvj4eDa9O7Hgk1u+bEouY9f9/D
	Xk80G5gVmO3OQK+bm2U5m1rUmUTFud5o=
X-Gm-Gg: ASbGnctsNxl1of9Wu+sJgHgVm/SHLnL2iDyr0qT8N1L0HGd3i4GfJZVp1jwzc+7Wxcr
	lz7qMGNfw267DFsxpifXd+ETdxTr/v1mYSpbexUI4+Kxydgt68TpfyvcFBeJ7P8RIhkF9aGznRa
	hewVZd6272cQEmjYOPmSV9T7fHZuXFCOagW0eR4LPsyU8G5Ia4O3zj8KZqNIF0KDg67vqXu76gC
	1wueU18LUNq6BFUjKKr1+V31vIlybWhGlLXbEAICNNPiQZEm7jChgh/8WAjBn3UBR6pOeKm3Q==
X-Google-Smtp-Source: AGHT+IFwcnpELmeJSQeEEzcc1sfvMTyHOGQce3S8i35SE1Ix9luZWMEUuqlQ1lvfYGfcFV55BA5E5+gdos42rFQPf/w=
X-Received: by 2002:a05:6512:3994:b0:586:83e2:228a with SMTP id
 2adb3069b0e04-58af9f4a92fmr623509e87.45.1759302093749; Wed, 01 Oct 2025
 00:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930143831.236060637@linuxfoundation.org>
In-Reply-To: <20250930143831.236060637@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Wed, 1 Oct 2025 12:31:21 +0530
X-Gm-Features: AS18NWB0_y7FqfcK3WyRSleddS4VDm6-xNbmK1P6eeEu7ZgL8DsqI6nEF_XJ2II
Message-ID: <CAC-m1rqxJ+wOODZUacmDcRjzNYJqE8OazoP18mY0KDjt1kPAQQ@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/143] 6.16.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 8:34=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.10 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------

Build and boot tested 6.16.10-rc1 using qemu-x86_64. The kernel was
successfully built and booted in a virtualized environment without
issues.

Build
kernel: 6.16.10-rc1
git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
.git
git commit: e1acc616e91adfbab433eb599e00d88f0bcdb07f

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards
Dileep Malepu.

