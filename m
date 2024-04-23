Return-Path: <stable+bounces-40739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9AD8AF4A6
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 18:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11521F2209B
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 16:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4998413D52B;
	Tue, 23 Apr 2024 16:53:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48764CB55
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891203; cv=none; b=aNKZTPf/7p0o+BQikw3n5q0/ncy//VC3OcxuqXCYKJjRg3rF0QsMIgISfNMgHi2/cxnC1yWXbf1c0E1pb+EwoZ8jks0Q/5NXVR4qYUF0HxxWfC69XqJSQf43sdP/k+eC2FYUp1/yKlDK2rWHo5m8IKqJpj/4MR2znDykBULoc4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891203; c=relaxed/simple;
	bh=PJ5BR0dvZM0ij5MtwuKhYnpnGn1ZiNTFavjNQAFJmzA=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=rHeMT4Qs7e7YznQjOXjjbLBGN6aDjLJ+nyMIOX61yKjLnsdk4+UFY0YNUJvaU6iVhq6TR6vy5UukIXlW6lVL988rZJAPqFiz9r6xBQpp1wSpwm1mrDIGuOBi2Gg8OCg8YIZEhA6/aFmi0Xo5yvA3WS6OEKB2EciXR4prlFN4v+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 7CDFF3780022;
	Tue, 23 Apr 2024 16:53:18 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <2024042307-detract-flammable-d542@gregkh>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <CA+G9fYsyacpJG1NwpbyJ_68B=cz5DvpRpGCD_jw598H3FXgUdQ@mail.gmail.com> <2024042307-detract-flammable-d542@gregkh>
Date: Tue, 23 Apr 2024 17:53:18 +0100
Cc: "Naresh Kamboju" <naresh.kamboju@linaro.org>, "linux-stable" <stable@vger.kernel.org>, lkft-triage@lists.linaro.org, petr@tesarici.cz, "Sasha Levin" <sashal@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>, "Anders Roxell" <anders.roxell@linaro.org>, "Dan Carpenter" <dan.carpenter@linaro.org>, "Gustavo Padovan" <gustavo.padovan@collabora.com>, "kernel mailing list" <kernel@lists.collabora.co.uk>, kernel@collabora.com, skhan@linuxfoundation.org
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7dc1b-6627e780-5-39ef3480@154053587>
Subject: =?utf-8?q?Re=3A?==?utf-8?q?_stable-rc=3A?==?utf-8?q?_5=2E10=3A?=
 =?utf-8?q?_arm=3A?==?utf-8?q?_u64=5Fstats=5Fsync=2Eh=3A136=3A2=3A?=
 =?utf-8?q?_error=3A?= implicit declaration of function 
 =?utf-8?q?'preempt=5Fdisable=5Fnested'?=
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Tuesday, April 23, 2024 21:52 IST, Greg Kroah-Hartman <gregkh@linuxf=
oundation.org> wrote:

> On Tue, Apr 23, 2024 at 01:35:28PM +0530, Naresh Kamboju wrote:
> > The arm and i386 builds failed with clang-17 and gcc-12 on stable-r=
c
> > linux.5.10.y
> > branch with linked config [1].
> >=20
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >=20
> > In file included from init/do=5Fmounts.c:7:
> > In file included from include/linux/suspend.h:5:
> > In file included from include/linux/swap.h:9:
> > In file included from include/linux/memcontrol.h:13:
> > In file included from include/linux/cgroup.h:28:
> > In file included from include/linux/cgroup-defs.h:20:
> > include/linux/u64=5Fstats=5Fsync.h:136:2: error: implicit declarati=
on of
> > function 'preempt=5Fdisable=5Fnested'
> > [-Werror,-Wimplicit-function-declaration]
> >   136 |         preempt=5Fdisable=5Fnested();
> >       |         ^
>=20
> That function is not in the queue at all, are you sure you are up to
> date?
>=20

Hi Greg,

Just to add, KernelCI has also reported these failures on stable-rc 5.1=
0 kernel recently.
Following are the details for it :-

32r2el=5Fdefconfig =E2=80=90 mips =E2=80=90 gcc-101 warning =E2=80=94 2=
 errors
allnoconfig =E2=80=90 i386 =E2=80=90 gcc-101 warning =E2=80=94 2 errors
haps=5Fhs=5Fsmp=5Fdefconfig =E2=80=90 arc =E2=80=90 gcc-107 warnings =E2=
=80=94 14 errors
i386=5Fdefconfig =E2=80=90 i386 =E2=80=90 gcc-101 warning =E2=80=94 2 e=
rrors
imx=5Fv6=5Fv7=5Fdefconfig =E2=80=90 arm =E2=80=90 gcc-107 warnings =E2=80=
=94 14 errors
multi=5Fv5=5Fdefconfig =E2=80=90 arm =E2=80=90 gcc-108 warnings =E2=80=94=
 16 errors
multi=5Fv7=5Fdefconfig =E2=80=90 arm =E2=80=90 gcc-107 warnings =E2=80=94=
 14 errors
omap2plus=5Fdefconfig =E2=80=90 arm =E2=80=90 gcc-108 warnings =E2=80=94=
 16 errors
rv32=5Fdefconfig =E2=80=90 riscv =E2=80=90 gcc-1010 warnings =E2=80=94 =
16 errors
tinyconfig =E2=80=90 i386 =E2=80=90 gcc-101 warning =E2=80=94 2 errors
vexpress=5Fdefconfig =E2=80=90 arm =E2=80=90 gcc-109 warnings =E2=80=94=
 18 errors

Build Logs Summary
Errors Summary
include/linux/u64=5Fstats=5Fsync.h:143:2: error: implicit declaration o=
f function =E2=80=98preempt=5Fenable=5Fnested=E2=80=99; did you mean =E2=
=80=98preempt=5Fenable=5Fno=5Fresched=E2=80=99? [-Werror=3Dimplicit-fun=
ction-declaration]
include/linux/u64=5Fstats=5Fsync.h:136:2: error: implicit declaration o=
f function =E2=80=98preempt=5Fdisable=5Fnested=E2=80=99; did you mean =E2=
=80=98preempt=5Fdisable=5Fnotrace=E2=80=99? [-Werror=3Dimplicit-functio=
n-declaration]
include/linux/u64=5Fstats=5Fsync.h:143:2: error: implicit declaration o=
f function 'preempt=5Fenable=5Fnested'; did you mean 'preempt=5Fenable=5F=
no=5Fresched'? [-Werror=3Dimplicit-function-declaration]
include/linux/u64=5Fstats=5Fsync.h:136:2: error: implicit declaration o=
f function 'preempt=5Fdisable=5Fnested'; did you mean 'preempt=5Fdisabl=
e=5Fnotrace'? [-Werror=3Dimplicit-function-declaration]

Warnings Summary
cc1: some warnings being treated as errors
<stdin>:830:2: warning: #warning syscall fstat64 not implemented [-Wcpp=
]
<stdin>:1127:2: warning: #warning syscall fstatat64 not implemented [-W=
cpp]

Detailed information can be found on the KernelCI dashboard :- https://=
linux.kernelci.org/build/stable-rc/branch/linux-5.10.y/kernel/v5.10.215=
-32-gd3c603576d90b/

Thanks,
Shreeya Patel

> thanks,
>=20
> greg k-h
>


