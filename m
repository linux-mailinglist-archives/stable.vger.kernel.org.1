Return-Path: <stable+bounces-169404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64115B24BFC
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 16:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BC362553B
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 14:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5735E2EFDA5;
	Wed, 13 Aug 2025 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OagzIKxm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983FE2EFDA3
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095527; cv=none; b=Fie5UsPST05vneYREKa8yVgkLPiCfkWWVmYsy6Av3ECCzcVPiGCdj5bweQfThzlXO3r2z8UnV41QS7pzjvF1QftALRaKBNFEJOIttlnswqLTWQxrZm9SmxdLcFS+oGAJ+JgW9nQkBJ5cTfTXNwT+tlH63sAS6hP+R2sSZyy/H6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095527; c=relaxed/simple;
	bh=ipApUWXD/vc+gn0dpjkARbKTGMwSNJWFy53h/IiXXnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWr0VsQSzLQJmPp5rga8RJRFYi9VFJlCLxeduG2CUUM5HNgcCenf36XY+fYrlECItaXEOXveGFcZalOOtlETnkYFK5ahwQASIitemWY2FEQbJCZKQkRs9lz+sHxHqw/WBlfwDLrqVmxJw+lvmPq2vdvBa7UscgapXyTzqH54wcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OagzIKxm; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b46f9bb92edso1543901a12.1
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 07:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755095525; x=1755700325; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SdEySWA9pjFNhAetIdOe+TeBj+YFSkBbS61Z6xuGeG0=;
        b=OagzIKxmmqyqb3udhiQ9X5ZnsWD902l4tGC1vq8DetSlLgrd6fiX/6jJ5aWzUO0HT7
         1RPrXod7+PDSTjjPFoitGwp20HiGZAdEFGsHo8dZ3whAMwLYQWGNIEOGVcSHMpyRjOs0
         RUQId8z4UfQW7cF5AtY6qbu+QGbRtIy3TlPp4aCUyCCy/0EksNlxUBKYGjiASAaW6IIZ
         ZcoOBfbd6FhhqUdZh6KscUfL4HUo5RomEeu12790Kn6Zr2OoEd8jyX+QDzwY+Sb31dk6
         QMfQSBXeHI3VbV4gkL3sLqfOdbl58htcmv1HP8iQ8qjFLVNFMssDSxTCg+qhZPM7eEne
         VQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755095525; x=1755700325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SdEySWA9pjFNhAetIdOe+TeBj+YFSkBbS61Z6xuGeG0=;
        b=FIj4KGL1pEU//kLaRq3USh+MhHNPFNhTDtJ+AnlEznuOxwC48nzmZ6WHjOaSV0sj4M
         TQou7YRRuuxcQs9J5J2m9M+zyZVp+bnVL7GYmVshClRP30JW0SRJjyrCvMLnu88v/Bjs
         T9q5mtgSaQyyGJreoD2+MhnbFnYPtIhUFX9l/6JNRSannv64g5RgoYYVISJaap4dx707
         cimDi7seUUVDuErUcFhY790rpcVq3+aYSCSs2WHdnLLeWd5NxP3UwbrvFvCYD5EnGHWn
         ZOTZKoIruuIYv1W3KqptkFTTxqFe5Axld2Z5C0xVVPMO87y/z0QsUrDnIX+6futy9VJZ
         pYEg==
X-Gm-Message-State: AOJu0YwDp6vXeYEZalK0An1yhrFciiy+OyIHKsML2aMolXN/a7TaZCxO
	s4Bej0goPYJWw4Jjho4mMoDxYQnI8IqugGB1bhFDguorv4aI/YyR/ha7zMvdIq2qBanFZTMRLTd
	shBcJoSTTmIOSTASxBOeCYEMjeV2MIDEs4gd9JKRivA==
X-Gm-Gg: ASbGncs05opaQIYy5fxQ9AEetzBecyUSvt8g3N9tNhFphoN9WruL5recolHUTDzV7zu
	HBxlh4ZeYN9wE2vB19pIXvU2JmFNg6174BAXEG2z2UiQhRtR6tkRr/mjmWnC39gpx06pYcO5GXC
	ukJItkTxQ4fb5F5EWOXVjIzHzWVNl8Pi5Nc+TybPQPjbN2tKgXxlJasDaMlfMp1ovkwpBVyqqbs
	DE+rB/wkHOdmacj5WifFdzIBu+J/UVwSX9S53xeaqTmjEYTvrXzzeLprVQB6w==
X-Google-Smtp-Source: AGHT+IFzsa7z2LB/NwMV+7ODMzwtQZ5c6SDjL/beKBH/4CiDe3n9MltwqzwrpDodhDWNKfzJI3ZmU6XpdnvXzSkeC14=
X-Received: by 2002:a17:90b:39c7:b0:321:cfbf:cbd6 with SMTP id
 98e67ed59e1d1-321d0d6912bmr4596811a91.6.1755095524619; Wed, 13 Aug 2025
 07:32:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812173419.303046420@linuxfoundation.org> <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <2025081300-frown-sketch-f5bd@gregkh>
In-Reply-To: <2025081300-frown-sketch-f5bd@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 13 Aug 2025 20:01:51 +0530
X-Gm-Features: Ac12FXzTlKbJUDUafTa4ZlpVkqfN8sdY7Wfx9w4NKXTaujZ4mJCVSf-u4y5vZP8
Message-ID: <CA+G9fYuEb7Y__CVHxZ8VkWGqfA4imWzXsBhPdn05GhOandg0Yw@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, qemu-devel@nongnu.org, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	LTP List <ltp@lists.linux.it>, chrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>, 
	Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, 
	Zhang Yi <yi.zhang@huaweicloud.com>, Joseph Qi <jiangqi903@gmail.com>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>, 
	Zhang Yi <yi.zhang@huawei.com>, "Theodore Ts'o" <tytso@mit.edu>, Baokun Li <libaokun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

> > 2)
> >
> > The following list of LTP syscalls failure noticed on qemu-arm64 with
> > stable-rc 6.16.1-rc1 with CONFIG_ARM64_64K_PAGES=y build configuration.
> >
> > Most failures report ENOSPC (28) or mkswap errors, which may be related
> > to disk space handling in the 64K page configuration on qemu-arm64.
> >
> > The issue is reproducible on multiple runs.
> >
> > * qemu-arm64, ltp-syscalls - 64K page size test failures list,
> >
> >   - fallocate04
> >   - fallocate05
> >   - fdatasync03
> >   - fsync01
> >   - fsync04
> >   - ioctl_fiemap01
> >   - swapoff01
> >   - swapoff02
> >   - swapon01
> >   - swapon02
> >   - swapon03
> >   - sync01
> >   - sync_file_range02
> >   - syncfs01
> >
> > Reproducibility:
> >  - 64K config above listed test fails
> >  - 4K config above listed test pass.
> >
> > Regression Analysis:
> > - New regression? yes
>
> Regression from 6.16?  Or just from 6.15.y?

Based on available data, the issue is not present in v6.16 or v6.15.

Anders, bisected this regression and found,

  ext4: correct the reserved credits for extent conversion
    [ Upstream commit 95ad8ee45cdbc321c135a2db895d48b374ef0f87 ]

Report lore link,

https://lore.kernel.org/stable/CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com/

--
Linaro LKFT
https://lkft.linaro.org

