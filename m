Return-Path: <stable+bounces-72689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4988796824F
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 10:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A0981C21E17
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 08:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB33156C4D;
	Mon,  2 Sep 2024 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ab2ZaHKr"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637F212C484
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266823; cv=none; b=O0Yha+r2VvWD6kR7SewK2N+tCqX1HyMnr3Ohs2IoeshntJT8tTB8ZZLdXR/P48Qq5ixQuy0zbsZRfei3JeKVZc8HpN+TVlfBmaeRY3C9yQqVyhavrB2dW3nf8rl0ItHrddDVLXcA1n+/3Sk4XpP8QHJ36URffRcVcgfXvo8QuMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266823; c=relaxed/simple;
	bh=5koipN301NbdmYrqYHB4egArEglH64vZt7s8+esDVR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3ap1ujr79CQZoUecOFgaBNM/GNlwJaXVbv88wfTIz4AsckX0bGQDFSThpjv+y1qh/iJ2QV5JqF6goEkmeoQ1Blu6AORfNOocjktGXyHEQBCaicvDQd98UQ2DvqVhs92rFy/jGzND3YuviNIVF7zifkuZpge7mc5J39xVoq5BGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ab2ZaHKr; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4fce352bd28so1127891e0c.2
        for <stable@vger.kernel.org>; Mon, 02 Sep 2024 01:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725266820; x=1725871620; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KsE6U/k1vC2HTRZ1j0u0FBej1GCe3nPlUj861Ab8TNU=;
        b=ab2ZaHKrnu8OfdA9vst8/za5DA33ej4MAX0YdaHll1+hGtU4brg0nIP8Re6G/IyZJw
         VTQ/DuXqSy+YAePzjJ2kn4/YJIyJ/D7qb6OfpVQjwULBpCcmrutuvUp3nVCEYRsak32K
         pIo5F3GoaB9ITl28hrOwP+sE5TMnFGChvZ/EWvBx9vo0IP9D2V8jFcHE+Oc4z8HMN5+t
         NYT8j2mkrSUg0KmO4KRQaHuu1uHI0lMRmljIBZ5MNrvOzcYGkC1rVg1CpV3x+n9lTp07
         bJyQkbYMFbQCFWN2VOZCJRAeU5ZKosb+1S6qpv7M4WotBj3hKIA97sf5j0v5f+mvQHZM
         4HcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725266820; x=1725871620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsE6U/k1vC2HTRZ1j0u0FBej1GCe3nPlUj861Ab8TNU=;
        b=pQNJUf1OiqA1YMDUVAStkO4So7IG+7iYSdtOmaC/axlKcbwqQi13Yt2GL6FOm4nuMm
         YuM5RxYlAGkGGqDy1EfwxsmAicp8qzGrAmNGlaspj+KjlI522PTjbJcuyCar+2rsYLE5
         83TJ9QCYiJpVJRzpqhU66U5jLVHRTo2UoRs+JyWQWspul+aA6y6Adh+gydqvx3k7R64c
         JeWZ76SiQ97FXuUuqKSFimixlnUgvF7LgiTJvYYfhaF1IQlAUja3EAs8+SiHiBf/uqBF
         Cmp2ic8HWYOrpyNTkEiyCYdw9e2gdD9Onc05EwMfkM3v3A2zBOIEpCS6eA+efvYR5a96
         FQuQ==
X-Gm-Message-State: AOJu0Yy3rlm9/tABOaxS95hvMWU2tPqPUJHSJ6RuuUPPw7EI3E8yar77
	SBe5OoQNAiaJ7xm9wH2T0/s8KHtvSD7BIj1X1V3FQOHW98z2O+oZXeSt2PEGsWmuNoa3T1mC9HF
	9VJUR5bECVMg0dy0n7TsgTh/cRUvbQpPeC6Rx7A==
X-Google-Smtp-Source: AGHT+IGvJFgpWZW72qkUe5lgjauVaBz/o+InxFAah8g4mLKkhioQWBVrVTLkZiBIbyncFCcLhz/zHgWGk2gh5yVhBqk=
X-Received: by 2002:a05:6122:3b06:b0:4f6:ae34:9659 with SMTP id
 71dfb90a1353d-5009ac36f2amr7433710e0c.5.1725266820224; Mon, 02 Sep 2024
 01:47:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901160803.673617007@linuxfoundation.org>
In-Reply-To: <20240901160803.673617007@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 2 Sep 2024 14:16:48 +0530
Message-ID: <CA+G9fYvS_NL7bcKkOJEX2irsBHcrYHz_yOOU84T9V9XB7n92RQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/98] 4.19.321-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Anders Roxell <anders.roxell@linaro.org>, abdulrasaqolawani@gmail.com, 
	Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Sept 2024 at 21:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.321 release.
> There are 98 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 03 Sep 2024 16:07:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.321-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The Powerpc defconfig builds failed on Linux stable-rc due to following
build warnings / errors with clang-18 and gcc-12.

This is a same problem on current stable-rc review on
   - 4.19.321-rc1 review
   - 5.4.283-rc1 review
   - 5.10.225-rc1 review
   - 5.15.166-rc1 review

In the case of stable-rc linux-4.19.y

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Anders bisected this to first bad commit id as,
  fbdev: offb: replace of_node_put with __free(device_node)
  [ Upstream commit ce4a7ae84a58b9f33aae8d6c769b3c94f3d5ce76 ]

build log:
--------
kernel/profile.c: In function 'profile_dead_cpu':
kernel/profile.c:346:27: warning: the comparison will always evaluate
as 'true' for the address of 'prof_cpu_mask' will never be NULL
[-Waddress]
  346 |         if (prof_cpu_mask != NULL)
      |                           ^~
kernel/profile.c:49:22: note: 'prof_cpu_mask' declared here
   49 | static cpumask_var_t prof_cpu_mask;
      |                      ^~~~~~~~~~~~~
kernel/profile.c: In function 'profile_online_cpu':
kernel/profile.c:383:27: warning: the comparison will always evaluate
as 'true' for the address of 'prof_cpu_mask' will never be NULL
[-Waddress]
  383 |         if (prof_cpu_mask != NULL)
      |                           ^~
kernel/profile.c:49:22: note: 'prof_cpu_mask' declared here
   49 | static cpumask_var_t prof_cpu_mask;
      |                      ^~~~~~~~~~~~~
kernel/profile.c: In function 'profile_tick':
kernel/profile.c:413:47: warning: the comparison will always evaluate
as 'true' for the address of 'prof_cpu_mask' will never be NULL
[-Waddress]
  413 |         if (!user_mode(regs) && prof_cpu_mask != NULL &&
      |                                               ^~
kernel/profile.c:49:22: note: 'prof_cpu_mask' declared here
   49 | static cpumask_var_t prof_cpu_mask;
      |                      ^~~~~~~~~~~~~
fs/xfs/libxfs/xfs_inode_fork.c: In function 'xfs_ifork_verify_attr':
fs/xfs/libxfs/xfs_inode_fork.c:731:13: warning: the comparison will
always evaluate as 'true' for the address of 'i_df' will never be NULL
[-Waddress]
  731 |         if (!XFS_IFORK_PTR(ip, XFS_ATTR_FORK))
      |             ^
In file included from fs/xfs/libxfs/xfs_inode_fork.c:14:
fs/xfs/xfs_inode.h:38:33: note: 'i_df' declared here
   38 |         struct xfs_ifork        i_df;           /* data fork */
      |                                 ^~~~
drivers/video/fbdev/offb.c: In function 'offb_init_palette_hacks':
drivers/video/fbdev/offb.c:355:47: error: expected '=', ',', ';',
'asm' or '__attribute__' before '__free'
  355 |                 struct device_node *pciparent
__free(device_node) = of_get_parent(dp);
      |                                               ^~~~~~
drivers/video/fbdev/offb.c:355:47: error: implicit declaration of
function '__free'; did you mean 'kzfree'?
[-Werror=implicit-function-declaration]
  355 |                 struct device_node *pciparent
__free(device_node) = of_get_parent(dp);
      |                                               ^~~~~~
      |                                               kzfree
drivers/video/fbdev/offb.c:355:54: error: 'device_node' undeclared
(first use in this function)
  355 |                 struct device_node *pciparent
__free(device_node) = of_get_parent(dp);
      |                                                      ^~~~~~~~~~~
drivers/video/fbdev/offb.c:355:54: note: each undeclared identifier is
reported only once for each function it appears in
drivers/video/fbdev/offb.c:356:17: warning: ISO C90 forbids mixed
declarations and code [-Wdeclaration-after-statement]
  356 |                 const u32 *vid, *did;
      |                 ^~~~~
drivers/video/fbdev/offb.c:357:39: error: 'pciparent' undeclared
(first use in this function); did you mean 'pci_alert'?
  357 |                 vid = of_get_property(pciparent, "vendor-id", NULL);
      |                                       ^~~~~~~~~
      |                                       pci_alert
cc1: some warnings being treated as errors

Build Log links,
--------
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.320-99-g0cc44dd838a6/testrun/24994095/suite/build/test/gcc-12-ppc64e_defconfig/log

--
Linaro LKFT
https://lkft.linaro.org

