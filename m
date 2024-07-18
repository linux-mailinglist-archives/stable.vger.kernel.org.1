Return-Path: <stable+bounces-60568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 808419350F4
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 18:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A1E1C21BD2
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 16:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306222F877;
	Thu, 18 Jul 2024 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZGur6e7"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEA714430A;
	Thu, 18 Jul 2024 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721321727; cv=none; b=Kn1UrPaau3Fbm4txARorF/a4NRmb7WeIPSYfwh6W//kHOwZh3wSX7P3i1Oci+E6y2bl2pjPPc1FP+cqIcuWn3yaXEetUrIjO28eBqZCLkoFuo57TMfNzvxu8gAj28NE8UVAU8gi2kI5FwIcM4z6Fj2PikEJXZYp2FMxI2xxvlkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721321727; c=relaxed/simple;
	bh=L704YxFv6WxS/2XwbbkAAHUe+jUXMMPapu3Jvt8nbqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFx4w7m5zpgx202LmfHTvKP/OiRdn8uYoNdqBGIyn6hLywjHFwTQQ2nvuGLOgLOtZ6D75sBMYZky62j2WW1JwoYLErUBEcckE+rTfPYBHdi8VdRshFH3aVxJCXFRMsgaszF8Us+yokbSEoOszEiT73XqqzJoyikSnhFIT5WoAt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZGur6e7; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-48fe7e1c6feso264977137.3;
        Thu, 18 Jul 2024 09:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721321724; x=1721926524; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ebmgK7JnwwSSz9YsrAOoF0dr35Ecvk28jzs/lLa8vlg=;
        b=NZGur6e774PMF6kFaqQTmM3pAtuEonASk7tzk7cbcgxlkOgPVxZ7kFgWULvrXWN2ia
         VwZH21mq3XTi0TYtyVFfQwa6TmDIS4utUvI8aq3wLZz2d7IGS5YlZ/g3xNeiuQN4VI1d
         0BRbGwfJMDX4wRtAISpKas5jIbT3xeAKt8EMy0olE8YA6NpdhHoPhHjUqScsjWUSeYuE
         ibBEWWGJOebpZBzElz+g2HgP9da7yqvKfwxxPZegVWTXS4W0KBqs4jxkFe02HA7/uNnc
         XQ1HUra8UKFgJXQNAlMPuZgkA9scyYYB3snWunrasVPKPG+1mI8zP/0uMiiwdv9r+yrQ
         xHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721321724; x=1721926524;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ebmgK7JnwwSSz9YsrAOoF0dr35Ecvk28jzs/lLa8vlg=;
        b=vdpxIHAc3OkUQZBlf47uBt4BNkochStp1wC3Ch8i2jnAaDqX5g0/wpBtvU/0q0CjJS
         jtuMFx0KdQ7O4ZZEAV0Xs+ypJRBJuC9paDZ+T93dO7jIQ0xM8raD/012iWr/4NA/6QT7
         XhaNIamVOOtH6jv6LqcXMDj6Z5t8t+1TWIrfANLlvt+I3216JNRXv/TE3sHmg4awOlIr
         jnPW4RT39dR4d3xXLlyueWZnwvxB2O03oJI5J+h6ec8CgSS4aKjFhyXXURY2irsks8Ey
         yQ73b9ZPFOET9+RzJWMik0ZMqmywel1F0uXut2NbvFN7vUEJfoq5e3PHm/LEFU6w6VMO
         e6bw==
X-Forwarded-Encrypted: i=1; AJvYcCWVsHg1O3zbuOYDzNnVc+JCqd0todJCRRU6HQ09frCS5au4uuVd7bHWEco9ByciJgLOSNrux4QazBN2wvNONUDgQr4q/VlbPeVAGYKn
X-Gm-Message-State: AOJu0YzMa6K0+RuA3VNV+HQKNS2FokbZHBIlLl1NvCo6+r4mDgcXlymj
	Vpcf6JOTxcyVzPJOgcAoyXeZH1mxGmV3gRpqSYcjuO1F4o50mTsy2PYIZxmCYCF7s+Tkz46+Hv9
	Gnkj1ZFmEjAvVNB1RcQiRDWZW2ik=
X-Google-Smtp-Source: AGHT+IHymPvqbtbvbeckpfoFMmjdZw1WhewvBshIjDm/V2E6daJTQ5YMxzVXkrZ1CzwHSTPGjJ7z91XAGmtMY3t9GHY=
X-Received: by 2002:a05:6102:159e:b0:48f:cb62:231a with SMTP id
 ada2fe7eead31-491599a8db2mr8253335137.23.1721321724502; Thu, 18 Jul 2024
 09:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717063804.076815489@linuxfoundation.org>
In-Reply-To: <20240717063804.076815489@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 18 Jul 2024 09:55:12 -0700
Message-ID: <CAOMdWSLLpy7=A-Qqg8vCvu1qOOG+EMZpqkwhFg2767WZ7n6tmQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/145] 5.15.163-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 5.15.163 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Jul 2024 06:37:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.163-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.
-- 
       - Allen

