Return-Path: <stable+bounces-83189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 203B69968E9
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 13:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF121F25E71
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 11:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656711922DA;
	Wed,  9 Oct 2024 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EtiUtMGc"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E251F18785C
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728473751; cv=none; b=l/DDMkY/njJutSQr/Tk9ZNBQPgjNUthXA/ZoLa7p9cS++VDwnEmMeoHicKtKZuJ7mh7Fd8udSfQmOT5h7JyHbHFrEG32860xivHewf0ca/w3zHg1A4Gm1OpNRXjTZwcx73sk9FUH9hxiITkIlTI6u9s5c2zls+BFzkeJQEECKXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728473751; c=relaxed/simple;
	bh=iYh8icxS+03RcbNsz4+AeuY5qGQrXSCvfXvPNeyDKC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AU8OVuYf+tZNj4f/bbueoBGrHlFcoB9AQGhwv7EG+S2l6B+T+CXdPxXZ7PtoV7VaPhGA0lJ0DOJDej1bkbmjitnmvgF6hBmXBRigXdTPtbLLx/owHt34t2tB8AQArCqprEFhlUWVyAWjxjd7MxI2jz+mUZG9CZB4bCh5YQjnqfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EtiUtMGc; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cbc1638608so1390826d6.0
        for <stable@vger.kernel.org>; Wed, 09 Oct 2024 04:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728473748; x=1729078548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FurzM10u95VKmaZwS7ymh0VKZoWWm9NbSC/cRDUlyeU=;
        b=EtiUtMGc3NDlkomLtveCeGMnWg8HDUKFKhwk+5SKFJRFv0pItzwVLyoFLDuvjKeTqX
         2/ZyplA446ijC24QREn4OZKtmnvD2+IXWwVyhEpNyB3YDWKQ6AcskFW+ciiC7XwcMJ5Q
         uo/cWTKiqOPq5YnAwmFRnqCX0tehhMaL/02i5YXtfPywIZmk0x2LnhsO8C0+JkYsYfJY
         o97qu32fjFPP7PWl0uJ/t2zkRCJKsABXU5JM+zgaNpXrDF7xOh0GS166V6nZvmQUDlYb
         9irwKuX82xe1eX95ZsKmMHPNEntaFtFUpBAc8AnBpFKExZVhDP9pAJ+NEDNqYHcGA5TJ
         v92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728473748; x=1729078548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FurzM10u95VKmaZwS7ymh0VKZoWWm9NbSC/cRDUlyeU=;
        b=DockWVc/oyn+luNt1CAE0E37lk6rQvanLUW+R9twuF85yAtFAW7XjvNzR4sWmj8X7/
         uj0mnnKPqYvH2J1tIgc2fiUSUzVLO0nfYKJAxli/s1hL0ivaul949jOGJW1tGx4W+WhR
         iOmqSYL3aie/A2GnwCahnCldxBh4rjLmJdRZQ5UQAZMcGz/3QEgoPpAbVBkPZLKKbqBd
         xNl253kP8p96SRQTm2IpdZ+us8nuREkeN7Hgo6RJrZAUP1bKazOBd6ovSsQszQVL6cM1
         i4OF9UuSUCAP1EMdUxNxC2nts3WK4ZVb1HET2QF9LnhoAAApxXWNDJ1ePYNYHG2kCVc8
         zPpg==
X-Gm-Message-State: AOJu0Yy7BZjU7XR9pau1u88Q8M7A18zqXmUhc7SdwxHs5bq6Q/g5rpou
	GYYfOv2brqAUVj6QNcyZfZV0GoZBwAFRjH/cjtBpJCFTYCroNMHDVaQvyhVxuzbPxubLv46f5+0
	LG0oey1mrBGg0FQv2qSm7OoPYyTqipmZYJG5YPQ==
X-Google-Smtp-Source: AGHT+IGxVD61+vnO6Sd1PNMSaYrQo9NkwfAClZ0FVDtlnROBKd2JA5fPqspTbiQbddkGddY+tZ38AMM6AmjuFdGb7sY=
X-Received: by 2002:a05:6214:5014:b0:6cb:6006:c98b with SMTP id
 6a1803df08f44-6cbc932a05amr17137026d6.5.1728473747881; Wed, 09 Oct 2024
 04:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008115648.280954295@linuxfoundation.org> <CA+G9fYv=Ld-YCpWaV2X=ErcyfEQC8DA1jy+cOhmviEHGS9mh-w@mail.gmail.com>
In-Reply-To: <CA+G9fYv=Ld-YCpWaV2X=ErcyfEQC8DA1jy+cOhmviEHGS9mh-w@mail.gmail.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 9 Oct 2024 13:35:36 +0200
Message-ID: <CADYN=9KBXFJA1oU6KVJU66vcEej5p+6NcVYO0=SUrWW1nqJ8jQ@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/482] 6.10.14-rc1 review
To: Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Oct 2024 at 08:22, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Tue, 8 Oct 2024 at 17:42, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.10.14 release.
> > There are 482 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.14-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
>
> The LTP syscalls fanotify22 test failed  (broken).
> This regression is noticed on linux.6.10.y, linux.6.11.y and linux.6.6.y.
>
> We are bisecting this issue.

The bisection pointed to patch b1a855f8a4fd ("ext4: don't set
SB_RDONLY after filesystem errors")
[ Upstream commit d3476f3dad4ad68ae5f6b008ea6591d1520da5d8 ]

Reverting patch b1a855f8a4fd ("ext4: don't set SB_RDONLY after
filesystem errors") makes
ltp-syscalls/fanotify22 pass.

That said, I also checked Linus tree and fanotify22 fails there too.
Reverting the upstream
patch d3476f3dad4a ("ext4: don't set SB_RDONLY after filesystem
errors") from Linux tree
v6.12-rc2-58-g75b607fab38d and run syscalls/fanotify22 it pass.

Any ideas whats wrong here?

Cheers,
Anders

