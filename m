Return-Path: <stable+bounces-131793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D17A81059
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 17:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE153A2D41
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D791E98ED;
	Tue,  8 Apr 2025 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ARw/tYPZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BCC1862BB
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126554; cv=none; b=WfaedTKGmcqqmTDL5+2DEMQbMPdpNzv1Uzdg66XE44wNSZCLZjjZ8fx+58p1Uhe9rw9qZc8B6hDnRIlKOIlgAF/uPwGUqXrXmoLj3rXVB2aIa68K25XHfpP0rHYz4+iiTIsnsR8ORUOlE8vjFmf/Ee9n7sZ5aqlze0TdsmomAcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126554; c=relaxed/simple;
	bh=S6DOC2X2/GtSJdHKZrfV8WYIYmEEczMsgL+5jkuX3do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLsCj5WK2zDKUBAXo/UuXqxvz0btyDxHWqUnfFwDTjCeqLJt6HEuSb1Zn+/TZ0VfQBNHxGnc0Uv4QRLeKzSeBFmbv4BJIHmQ0FXYcwV1rzhN8q96YQ+Buiu4nQ0JL1NU0vhsQtERfsb5bagQnNI2pcyucYMS0eeVBjyYWT+oFzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ARw/tYPZ; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-520847ad493so5249422e0c.1
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 08:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744126552; x=1744731352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqY9nqo/bT1yXEsldnMuBK8EFrTJ4cUK70Tv0YCH5v4=;
        b=ARw/tYPZFwyQMm2/A4dagX/ODf0rTCUwRIauDnzuGe4nR74ZbUpdi5cFstnKYSVAWE
         9Gj+URjmyLUB3V6rBs/jqgN6S4RG8bE33UlrgAcfqlWKON8dw/uwVZ1KPHIHMX5Dr/JP
         6XcbboWuVii0qVBNQCSXM5Inv35xG3Gtwpg18DMVSk4G67wpEImTIj3WOoWmKAaGJrah
         CXc+HmXQhU+7JhnRqBCvNN6+np6DQa0F6wBz0R6P82YRI4a7MT1vGvfIt9i4hVoyEbA6
         7VrDt3htYOTS7jCre1/7MaKL3ddZzK03RKQIWt70njU0Y2S60yRTl/N1PviwyyPlngty
         19Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744126552; x=1744731352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqY9nqo/bT1yXEsldnMuBK8EFrTJ4cUK70Tv0YCH5v4=;
        b=n9FVc7zxoL4VVzJUxhNls73YrwdiirY9caRIsY9vgBAfTPfkHymspA3cdvWi1acdlO
         SlxjDDz+1QACVLo0+/JMtpFioMU05VJMjneIy6Ig3vdumIwcNkHQUn1jgmchKPENMbE3
         TqR+aYqU21z5OW1esTh8DhWeLNTgBycxpl3dRL0TCFkOeSGTPN/uw80DHdHMMiNQzXxN
         0m6hkXMIU4cTdlAnazeax0lecj1OVwsAtF41WrXrcy8mQTBdbS4M3ld4UBIAvP0hNIoc
         QR/PrGhN281anlie58ssDbTLRUBu2Nhr2XKF4PJ4NbKW+/qp4OIWJJCVvClMAdEuMnb8
         AzGA==
X-Gm-Message-State: AOJu0YwiIdUJbYwai/48WPQ9B9gvfsJT3iJkv4r0W7hRxzBbPGx1p4Dh
	CSjfDLyqRBuS6kCvZYbginsUbIYq6WO+kQ/4PSOqGMTOsejk99wYlBTi7xQhLCdu+vbyd1BrA3w
	Qf44MOFCPRcb3FEWQ6e7mYK2ksyXejfao9iQDxw==
X-Gm-Gg: ASbGncuoqY3gH3mTz2x0CT4xk70/ub4H3MKp2O2cD77ThBXWt8NCBYYPPLabSHxE0E9
	9K4yohDF37hmRD+5vuU9A80JmPkq6GUPzrx12VHEOrOPwaTxWSe5lTWKoBLyr1049ODIDKxqDGX
	peKiOye15s9GowrDfpOLbWqTUi1mbCPY8UhY2r335iZaFy0yB+3O98qJFv
X-Google-Smtp-Source: AGHT+IFQzExTa65nA0/f4X0nyU/wBDWz+iIbK1IkF+A0MydItYVQcLhe+aX9axgA7v4CkLL4+J/Ad8oezLldyzb9hYg=
X-Received: by 2002:a05:6122:20ac:b0:525:9dd5:d55a with SMTP id
 71dfb90a1353d-527730a9b14mr8923640e0c.8.1744126551943; Tue, 08 Apr 2025
 08:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408104851.256868745@linuxfoundation.org>
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 8 Apr 2025 21:05:39 +0530
X-Gm-Features: ATxdqUE5K9Dlr_XtGSCpzfXdBhhJtN7jxVeLpGfJQfW41WarrWU_eZhxEWZq6W4
Message-ID: <CA+G9fYuzqN6BjRx3XTAC87qviZWMLzOX70KfJvXEX772ZHDZzQ@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/499] 6.13.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Apr 2025 at 17:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.11 release.
> There are 499 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Apr 2025 10:47:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on arm multi_v5_defconfig and tinyconfig builds with clang-20
and gcc-13 on the stable-rc 6.13.

First seen on the 6.13.11-rc1
Bad: 6.13.11-rc1
Good: v6.13.10

* arm, build
 - build/gcc-13-tinyconfig
 - build/clang-20-tinyconfig
 - build/clang-20-multi_v5_defconfig

Regression Analysis:
- New regression? Yes
- Reproducibility? Yes

Build regression: arm ld.lld vmlinux.lds section pattern is expected

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Build log
with clang-20
ld.lld: error: ./arch/arm/kernel/vmlinux.lds:33: section pattern is expecte=
d
>>>  __vectors_lma =3D .; OVERLAY 0xffff0000 : AT(__vectors_lma) { .vectors=
 { OVERLAY_KEEP(*(.vectors)) } .vectors.bhb.loop8 { OVERLAY_KEEP(*(.vectors=
.bhb.loop8)) } .vectors.bhb.bpiall { OVERLAY_KEEP(*(.vectors.bhb.bpiall)) }=
 } __vectors_start =3D LOADADDR(.vectors); __vectors_end =3D LOADADDR(.vect=
ors) + SIZEOF(.vectors); __vectors_bhb_loop8_start =3D LOADADDR(.vectors.bh=
b.loop8); __vectors_bhb_loop8_end =3D LOADADDR(.vectors.bhb.loop8) + SIZEOF=
(.vectors.bhb.loop8); __vectors_bhb_bpiall_start =3D LOADADDR(.vectors.bhb.=
bpiall); __vectors_bhb_bpiall_end =3D LOADADDR(.vectors.bhb.bpiall) + SIZEO=
F(.vectors.bhb.bpiall); . =3D __vectors_lma + SIZEOF(.vectors) + SIZEOF(.ve=
ctors.bhb.loop8) + SIZEOF(.vectors.bhb.bpiall); __stubs_lma =3D .; .stubs A=
DDR(.vectors) + 0x1000 : AT(__stubs_lma) { *(.stubs) } __stubs_start =3D LO=
ADADDR(.stubs); __stubs_end =3D LOADADDR(.stubs) + SIZEOF(.stubs); . =3D __=
stubs_lma + SIZEOF(.stubs); PROVIDE(vector_fiq_offset =3D vector_fiq - ADDR=
(.vectors));
>>>                                                                        =
               ^
make[3]: *** [/builds/linux/scripts/Makefile.vmlinux:77: vmlinux] Error 1

and
With gcc-13
arm-linux-gnueabihf-ld:./arch/arm/kernel/vmlinux.lds:30: syntax error
make[3]: *** [/builds/linux/scripts/Makefile.vmlinux:77: vmlinux] Error 1

## Source
* Kernel version: 6.13.11-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
* Git sha: f1209ffbc87a3003d66f47bd6f986d1a0d154a2f
* Git describe: v6.13.10-500-gf1209ffbc87a
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13=
.10-500-gf1209ffbc87a/

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.=
y/build/v6.13.10-500-gf1209ffbc87a/testrun/27947363/suite/build/test/clang-=
20-tinyconfig/log
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13=
.10-500-gf1209ffbc87a/testrun/27947363/suite/build/test/clang-20-tinyconfig=
/details/
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13=
.10-500-gf1209ffbc87a/testrun/27947363/suite/build/test/clang-20-tinyconfig=
/history/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2vRlYe=
E7ChBo7YMjumm63mifyB9/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2vRlYeE7ChBo7YMjumm6=
3mifyB9/config

## Steps to reproduce
 - tuxmake --runtime podman --target-arch arm --toolchain gcc-13
--kconfig tinyconfig

--
Linaro LKFT
https://lkft.linaro.org

