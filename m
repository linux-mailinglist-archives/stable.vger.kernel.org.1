Return-Path: <stable+bounces-32170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 737FC88A47F
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 15:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9DB42E4497
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 14:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD3D15CD68;
	Mon, 25 Mar 2024 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JL5F/GnD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD771494B8
	for <stable@vger.kernel.org>; Mon, 25 Mar 2024 10:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363131; cv=none; b=s3t5DvVzb+RaeTL8ZnpnuMSd9XcSirudR5ylBN3n3Q3mMypAeaKsf6WpHw4Jwwuu1Lrc0fpyEtdXzzfRUYRLJdMwcoBCDbaqJfVs4yWvA/rt7K/00cHH1SuZfr7BeUCpiWTIBfUtZRu9mVNdI1+Pc7cIhM7Px2a62tpgM3O3DRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363131; c=relaxed/simple;
	bh=Fh3nwgtB4/hNAKuOMOxNy2Pkpo90LJkx49Wz4JF1YMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCoXZumQQBsFKC3LKIlEr9siS5wl76C8OngBWj8UBzcrFpdoAO5XftLjXTj1Kbo0y/mTzrFfGje1JuCGKmnZ1n8CaDvqGGP1xTAKfg6Xk2OEpwwggICWe2EZnPCxZ8+b4MKdAmJldvvoOBxbv9tbBJ3Kca8ege4OJFJUZ7X54sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JL5F/GnD; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7e057fb0b69so1276430241.0
        for <stable@vger.kernel.org>; Mon, 25 Mar 2024 03:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711363128; x=1711967928; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6g5n0zDO/k+zn99LgqTberBsE1ninTPL1fai4wdNt1g=;
        b=JL5F/GnDAQzdejdXTwVt5UTEEl5Dx2SFXl+2iPs9A9gYx+IPij6hXyFbu/3UAJVw80
         NNTrJWicWlrz+uMvJwM1jux/23UUG2ktUgRPLHCM2PWCWJcsz0ssDluMDVAgHwyHmnFS
         Nz8nf9VnrarbQzviKYDZ00nZiTbNpsH2Vbx1EDQ+mHklNDy4cM6h+aC168KEReuTDXtp
         yIvmpbhttaKxmNdv0AxxGtEonJcTeuzyg7qkeZY0xL8PaPbfqLHGifXJq6F20dHlkVfV
         KtYTgLfY3fsoVs1WIT/NHzYvq6CgOKhcFih9mmOnN8IKYgouy+0Zrm+kBGVkLRxApRAz
         Yo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711363128; x=1711967928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6g5n0zDO/k+zn99LgqTberBsE1ninTPL1fai4wdNt1g=;
        b=KQF3H4kYX8TMK56aobW/l+xukj1WAeGTiP+0dc+NsJOsFzTklwFgoAsPB8PYJh6TNV
         eRVvjfnoDqXdZZt+alVvQZeat/ZB17SyHN1A6jPG7yPljO+3plSBwTqSLd4JY/LC+O5g
         uP8fx6e4a015BPSenaRKFFFG9cuJ6PTT/AJEGo2XiHR6CgxZbFXMIYZ3QSv1cmf8XnS6
         8FjQ2JlaLCV3E1IrbMkDTgl2A++onia2vdglbLangNUomPK09NijmSYNTXFZSMLy1m/x
         jFKmJoFomYuD2YgDdVas5RHZ1065gYAhffIWsRvceE37gRj7DmOe0wGHTULwRft/mOLA
         Jqsw==
X-Forwarded-Encrypted: i=1; AJvYcCUpGajB8erBicGuaETMfqAfIhYEvos+bckMMYvt5iEVgPCN8+7L2S4RXa+fUyI0tJToXtONqtx/I7c+4/LZQhs7dJqQBIIV
X-Gm-Message-State: AOJu0YzED+hhku2BfgaFidx/g+dDEefX8/e7toFR/Ax37zBuarubNltP
	35uB07cEZ+VghcydgoO9DFqVWuxHrAo6jS6MIMJyilKuVvGSTVd9hOmVas0j0P6nefFCvFt7FHD
	cy29BMSKUEVXXoQOptUumqxAzHHPlC6nYtKR8OA==
X-Google-Smtp-Source: AGHT+IFJxYGwWNIHi6Lbmtdb4kZhXP5ioGaL2mD6ZgHA/n4sgaK7bl1N67pI8OeJhoqvDzhTfAxKbvKvX0om/kjbOgc=
X-Received: by 2002:a05:6102:3549:b0:472:d517:24e1 with SMTP id
 e9-20020a056102354900b00472d51724e1mr4887720vss.29.1711363128587; Mon, 25 Mar
 2024 03:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324224720.1345309-1-sashal@kernel.org>
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 25 Mar 2024 16:08:37 +0530
Message-ID: <CA+G9fYtBKCPVmRETNpo3OdQbky-XiY6RDQ+Pc2b4Yj1yLe_e0g@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/713] 6.7.11-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 04:17, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 6.7.11 release.
> There are 713 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Mar 26 10:47:13 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.7.y&id2=v6.7.10
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

The 32-bit architecture boot failed on stable rc 6.8 and 6.7 branches.

Boot details,
 - linux-stable-rc-linux-6.8.y - arm X15, qemu-arm and qemu-i386 - Boot failed
 - linux-stable-rc-linux-6.7.y - arm X15, qemu-arm and qemu-i386 - Boot failed

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

The bisection is in progress to investigate this problem.
Serial console logs printing as "Starting kernel ..."  that's all.


Steps to reproduce:
-------
tuxrun --runtime podman --device qemu-armv7 --boot-args rw --kernel
https://storage.tuxsuite.com/public/linaro/lkft/builds/2e9fapDKuhiDqLpezalPml1QIf3/zImage
--rootfs https://storage.tuxboot.com/debian/bookworm/armhf/rootfs.ext4.xz
--modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2e9fapDKuhiDqLpezalPml1QIf3/modules.tar.xz
--parameters SKIPFILE=skipfile-lkft.yaml --image
docker.io/linaro/tuxrun-dispatcher:v0.66.0 --tests rcutorture
--timeouts boot=30


Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.7.y/build/v6.7.10-713-g6f0681544906/testrun/23140347/suite/boot/test/gcc-13-lkftconfig-rcutorture/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.7.y/build/v6.7.10-713-g6f0681544906/testrun/23141457/suite/boot/test/gcc-13-lkftconfig-rcutorture/details/
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2e9fc0JdR6N9yOjnYWnO9druaJK

 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.8.1-715-gb0f6de60d946/testrun/23138873/suite/boot/test/gcc-13-lkftconfig-rcutorture/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.8.1-715-gb0f6de60d946/testrun/23138873/suite/boot/test/gcc-13-lkftconfig-rcutorture/details/
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2e9dH67vQBvX6giHu5ymUEpe2H4

--
Linaro LKFT
https://lkft.linaro.org

