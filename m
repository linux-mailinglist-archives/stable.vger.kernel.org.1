Return-Path: <stable+bounces-191947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF850C264B4
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 18:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B864462DC5
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 17:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCB12FDC25;
	Fri, 31 Oct 2025 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOkHBL7+"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A83C2F1FF3
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761930392; cv=none; b=nmn4WceAyC5m/MlT81PfCd6n1f4l2cLxqmfQeTKKFkMNmR/uzvh7VXAT248C6AMZrl2MGPTqtWPKGJ/HxsTsEJ+LvIeT6fdgX6Xsv9J+i+XE06L36d5lc2fCI3Cj8RLCxIGecfU+nk9WR+4V8wbvJvmmokyWWYI5LYD8bhLx0/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761930392; c=relaxed/simple;
	bh=V4e11FPTB70217C5nj91+hem0/N3V+YGbQrtmxcFY/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfocEmGxOTv1dkn0IIBiGHD2u1bVxF8nmNwXvu1l9kaCCd8y6bmG7JcIzzy6XskRpvQYSm3FrbllgzkEl9M/1HX0w3ALgQwbDFlxfovT09W1RsbDicSEyUR6mtd6iXVuh5ZhHYNw1Y85amZHuKprI8ndX01cxRXZc6oK3A0wVkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOkHBL7+; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-591ea9ccfc2so3463052e87.1
        for <stable@vger.kernel.org>; Fri, 31 Oct 2025 10:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761930388; x=1762535188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMkJiBcxuds+akFzr16pnTLfygNUfqye+Q3+HnkrYH8=;
        b=UOkHBL7+ynDpGtXo3om4ksJjDsM5Ucnc3/gjUxh9YO8FTgEbxqE3+6+9q/zlTPp6t+
         VWIl1gTdDhqOA2xblvgRt6/xkEJ7fye0c6XEfJ9FycNMooO1lqfR9riz8HPO06otuHPR
         t9HZA0817kBZXqcGIHwiDiGzufY0PtbzIc7pZ3yHKmWYKA2IPObLwzcH+ZwM5OMs7RtD
         EDxuyN+aewnOIPC5rlGZUuCNi1K7bil1E2qZLsh+TJusQOTxV4VJ+ZeQ3/CoitJlMjr9
         WFKQfMIyi40psyTluqaPdAqFyEgqr98w0NfPFtO3BiY/XjK+8OlJcrUDUBaiVGX51bHC
         HsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761930388; x=1762535188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMkJiBcxuds+akFzr16pnTLfygNUfqye+Q3+HnkrYH8=;
        b=lsv/1eS7VYB1IkBceN3u0ryYgMJDcgViAoIW8ItoHdJ+aV6+8ASKqZ0Y3VWSiDUXK6
         gG+Z9r2mi0TaXlppyZISoF/G1KAmHRPrl1419r9LUZfooAaRgLFVY0skjvr6GI8MTbvc
         dQgawn3tR16DKyQcqjo7yYbcRmuVm7ObchNMPT+XVb7EN+pwO0b6ITkQJaIR0mv1/Oeo
         VkgYaKUApgIuGpXAeMqjT7Zeel2eyUfIL4zuBNYytJRR+Q4ANlGHmhcOtrlnBvl7ectU
         7DI+3aSQDqQ8nMX3gxqG/rfO1mu0zJw1uiTLX1OVOcPIB8i90nIdLC8SgYm30AJkyJtq
         njLA==
X-Gm-Message-State: AOJu0YxowsS+5J3aHWnjKltfgtLUC8Ab/b/LoUxVwoC3+ECvhlD0915u
	z8aNskdRRkwiHknvnkgmdOPGXLQiy85KSLCo1iIRMj4HciqEuq9TwojBZTueh6ArSN0H2zE/7Xz
	CjbCfeSw5iKesmn8IV5A73Cm9nbpZMZA=
X-Gm-Gg: ASbGncsqVbH28Oo7+3CxxCpsK/P1V+dRePkC4hNkxJJ/eWeaHtIkGVCLaJiOGGUjJAX
	ZHVyznjaeUIdR4sMwPugd6St25As9plKbhAxPTau1SmQxXDsp7xDsqgDuhBZiqZDkMk/kJoy8ed
	/y7MZ6EperA2SgMcd+KGcYNb+wVsWRsSezUJ3L3sINW9LFCh4o2c5OmE5kfnw6joXGddVNiL3Uj
	RgD7zZ+W8T4hWAyIoEnN1xI6o5uQJecL7WG8rV+Zl01Y4Quah9XLTCPqX2YN7wnpEMLklkv4lcv
	Orje5niwaB7dCXOoYw==
X-Google-Smtp-Source: AGHT+IFnG8xxlm9juE2SEhrODTBOOrCE0rh37MNi8KlVkCf6aXpO0iApavTsldubjEQyHeOMvNj5YZ+IFGx8qPHgQyY=
X-Received: by 2002:a05:6512:220c:b0:585:2df4:7965 with SMTP id
 2adb3069b0e04-5941d39c3d0mr1492676e87.14.1761930387930; Fri, 31 Oct 2025
 10:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031140043.564670400@linuxfoundation.org>
In-Reply-To: <20251031140043.564670400@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Fri, 31 Oct 2025 22:36:16 +0530
X-Gm-Features: AWmQ_bnNapyza39VXDxGKokse023cnqtK8m6TeE7upn_35b0lbcczdmC83kKVz8
Message-ID: <CAC-m1rod_Qsk917N9A5G4a9B1vwA=n+E0RTujMPBAk96ZR3J=A@mail.gmail.com>
Subject: Re: [PATCH 6.17 00/35] 6.17.7-rc1 review
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

Hyy Greg,

On Fri, Oct 31, 2025 at 7:45=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.7 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------

Build and Boot Report for 6.17.7-rc1

The kernel version 6.17.7-rc1 was built and boot-tested using qemu-x86_64
and qemu-arm64 with the default configuration (defconfig). The build and bo=
ot
processes completed successfully, and the kernel operated as expected
in the virtualized environments without any issues.

Build Details :
Builds : arm64, x86_64
Kernel Version: 6.17.7-rc1
Configuration : defconfig
Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Commit : 7914a8bbc909547c8cb9b1af5fbc4f1741e9e680

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu

