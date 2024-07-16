Return-Path: <stable+bounces-60363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91339332F5
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 22:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45E231F23C11
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 20:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEB31A00F7;
	Tue, 16 Jul 2024 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nbwdMmEY"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A84548E0
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721161777; cv=none; b=hhQBuIMLqxgVYL9J+nuJfdSl58o3psJ0F1zUt7KfFvvoEYcXEmUr+JkNTnaMOOnNbvTqgm66cjx3N7px61bv4HgluGD2jqUahw0etm0sGOVmsrnNp97NpyIuXpFW9AxU1jYZl1oZ+nYPC6OwH1v6oFFsCx53pRevCaEiqZg0Pd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721161777; c=relaxed/simple;
	bh=Yhuhmc5ref3VmS6JXOcfK0IohaRteaXk3J4z1O4kN40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tpp05UnHXmhhZIPpRDf7pbma0/v0kgpdX/PQxz/8LadpgktO7/5iMoFoGUdBYelewzEjPzzu6f55hL9UxKzBmm6DIVLJBS94DNMcEJIhsDmdyFJFJU7muV0WKBZIzv7sGq73ekFpRTUocpea2u0HbDHdU60eLDMvNGDVK1I2D7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nbwdMmEY; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58c947a6692so7617752a12.0
        for <stable@vger.kernel.org>; Tue, 16 Jul 2024 13:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721161773; x=1721766573; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bbPj/PZFGIDhT7c0ujDQ6E8Mz16O/2FBR9KQusTsgDg=;
        b=nbwdMmEY0NTg9IWIkgVAwywUnPLwvHAtByVr0aLQW+TAEgNyqHoykQjVREcD71cBdj
         Rd0jY5SU0ju5pq+R9z6vazIw2WknZttGVwaBMfssCVLsIC5pbdJsdVJO1qw3Eky/3Kmx
         OjApGc7C1oIyjZvzYrQFMf13+N5C188Vqu4pNOKVqcx8nCIestQ23aFs3XSo9n1JXEsl
         rxyqMxTt4mJq1sJs4FhrOlpwcumjSoIRwYERrMAYHEbtIBIEjl3xbKEOagrxKmjIQ0mc
         DE1aQpzAcVBONd/Z7zXSUqXmvlhaLWASlIYd8XKnhF+I+DjF8Ioury8ibnMFbIJf8/Yf
         vEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721161773; x=1721766573;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbPj/PZFGIDhT7c0ujDQ6E8Mz16O/2FBR9KQusTsgDg=;
        b=t43cL96Umcz4YPNr+7+9PDlytrnBrO3qsusXQpox1EedryzI0nCP/6Bmj9aEvXS/2v
         lkQyAcYJ9qxWV9ZsbC/qLX6LIxZr+ds5LvvBFrVPmBEOydrYAMvDLh8CFUJkzNE3KDHJ
         qES9svypLHFVBTlqcb+ri3LRI/RhGhJN2qbnmXakvX6igUfpRNxeLGJJEZ1M1k6JdSRO
         ljS+sWkIcQA0Jd1N8TTKGG1NOYX9FIsJm11KKbrpYnTzg3xiwbD3ODjWEV1GDHrcpnNT
         miO/ccCZvV3JSylQ1hYyojlOSx6qRSvQoHqWqKLZvfE5LDDobUmXaK7oLxLWCKAyteyV
         ehCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnEaycKXJNY+oXBCo7ItoL/Nr8Zq+Pyj74ZHV7bcSlbchFHdJoqqI4kh/Y/qYkcmLvnlSyMwQwYwL/U6BGXt1SCFr0pdyp
X-Gm-Message-State: AOJu0YxT5oaOj0nWKxTLec3HQUUO2cDsk0Y5imLX0aqW/8llgCJMGgCY
	75TJJot9amBJ29WWjttA/nOk2EGpIqzbmbBs5w744I8yvhKkHitXoXE3U+8HasvLnHSmHmwZmiM
	wKAcI6pMNxJnRrSHeVBVSfPVhagIZLxf87UiR9A==
X-Google-Smtp-Source: AGHT+IF+ga++87qZIL9GesqchqNJ7nMQoknpRRE8QlgGw72R1Ft17dXna2B9Rqo1YtNOnhci3c7g/FHe4x02at6YBzY=
X-Received: by 2002:a50:a696:0:b0:58d:b529:7dc3 with SMTP id
 4fb4d7f45d1cf-59eef45b5e4mr1989963a12.19.1721161773520; Tue, 16 Jul 2024
 13:29:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716152746.516194097@linuxfoundation.org> <aaccd8cc-2bfe-4b2e-b690-be50540f9965@gmail.com>
 <ZpbDlwpfBwViDonu@duo.ucw.cz>
In-Reply-To: <ZpbDlwpfBwViDonu@duo.ucw.cz>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 17 Jul 2024 01:59:21 +0530
Message-ID: <CA+G9fYtosFR2O3A+bgYKV4q+13dWdfqGFqmB+NVu3Qfdfa3Ghg@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/96] 6.1.100-rc1 review
To: Pavel Machek <pavel@denx.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, Paulo Alcantara <pc@manguebit.com>, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, jonathanh@nvidia.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 00:31, Pavel Machek <pavel@denx.de> wrote:
>
> On Tue 2024-07-16 11:42:39, Florian Fainelli wrote:
> > On 7/16/24 08:31, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 6.1.100 release.
> > > There are 96 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.100-rc1.gz
> > > or in the git tree and branch at:
> > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > > and the diffstat can be found below.
>
> > Commit acbfb53f772f96fdffb3fba2fa16eed4ad7ba0d2 ("cifs: avoid dup prefix
> > path in dfs_get_automount_devname()") causes the following build failure on
> > bmips_stb_defconfig:
> >
> > In file included from ./include/linux/build_bug.h:5,
> >                  from ./include/linux/container_of.h:5,
> >                  from ./include/linux/list.h:5,
> >                  from ./include/linux/module.h:12,
> >                  from fs/smb/client/cifsfs.c:13:
> > fs/smb/client/cifsproto.h: In function 'dfs_get_automount_devname':
> > fs/smb/client/cifsproto.h:74:22: error: 'struct TCP_Server_Info' has no
> > member named 'origin_fullpath'
> >   if (unlikely(!server->origin_fullpath))
>
>
> We see same problem.

Same problem as others have already reported on the
arm, parisc and powerpc.
+
The old s390 build failures which were reported from
the previous stable-rc 6.1 release.

* arm, build
  - clang-18-nhk8815_defconfig
  - clang-18-s3c2410_defconfig
  - clang-nightly-nhk8815_defconfig
  - clang-nightly-s3c2410_defconfig
  - gcc-13-nhk8815_defconfig
  - gcc-13-s3c2410_defconfig
  - gcc-8-nhk8815_defconfig

* parisc, build
  - gcc-11-defconfig

* powerpc, build
  - clang-18-defconfig
  - clang-18-ppc64e_defconfig
  - clang-nightly-defconfig
  - clang-nightly-ppc64e_defconfig
  - gcc-13-defconfig
  - gcc-13-ppc64e_defconfig
  - gcc-8-defconfig
  - gcc-8-ppc64e_defconfig

and

* s390, build
  - clang-18-allnoconfig
  - clang-18-defconfig
  - clang-18-tinyconfig
  - clang-nightly-allnoconfig
  - clang-nightly-defconfig
  - clang-nightly-tinyconfig
  - gcc-13-allnoconfig
  - gcc-13-defconfig
  - gcc-13-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-defconfig-fe40093d
  - gcc-8-tinyconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


--
Linaro LKFT
https://lkft.linaro.org

