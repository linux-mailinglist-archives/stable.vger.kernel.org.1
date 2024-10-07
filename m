Return-Path: <stable+bounces-81382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 640F89933EE
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 18:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8703E1C223FE
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 16:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96DC1DD528;
	Mon,  7 Oct 2024 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fstab.de header.i=@fstab.de header.b="SWKv+m77"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C571DD526
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319804; cv=none; b=pak79i2u/a/gsZR5Tpw/4wQtAozPlrgEzDzcuXGmBGZZ9YPxLJRVIWWw1u4157T0svCKjTCfLvtrXnbIKBK1cX3oCkX58pt5m//FwmbvyuE67aIiNZCySGyywZDZBxqpMPUrsHkw8yTrDeU+24wrrWvZgsQTo+byj42ph4SBpts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319804; c=relaxed/simple;
	bh=6dI3sJJNpJlplzaGuy7c1kRQ/dEO5ZpL6LqEprZfR5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9T7oNVYPM0FCyLihRZQ/rGTswM1QgfUwN1jYtflbbWZImHDR+e7GFwBsVDRpLTb2IMSQw6uQLAD45i1T6e4hwy4Mh6Mk4aEwgpR6yZKmoQH84FjMu0Xg6QcnY1kDzQ9tWKE/AFUNISZ64u6x5c1yVgbTYwU4/CUhbz7H/bL63w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fstab.de; spf=pass smtp.mailfrom=fstab.de; dkim=pass (2048-bit key) header.d=fstab.de header.i=@fstab.de header.b=SWKv+m77; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fstab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fstab.de
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cb284c1a37so40940056d6.1
        for <stable@vger.kernel.org>; Mon, 07 Oct 2024 09:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fstab.de; s=google; t=1728319802; x=1728924602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmGaAQmkU9F3c2Jeb7g7GHDPHRwyj2CfpEporkATVQA=;
        b=SWKv+m77mX2iVk2ucExgL3CWJZ4HQNjwUgYFVt61TSnQ2OrzMC34GRjLPmFAvhKiUh
         z91vbssM/522B/eJ/EVbLywipnO/vQPJjYb86uAyOj5gonX/IcoMtRx9uhwfY38veMKZ
         /SGGRsD10LEi270dX/Gi72P4k5dcVmKgnWrhoMJNdo7fc8Nn/qr0SlEiKXmgB1RWEnA6
         dwsTXM65pSpbimf7YVBsMwy68HhPBStHJpQOFF18UNx+P2FkQL485nD9LyY5OAobE2ch
         IR2sMWgg6XZzcIkrS1PHE4/lvvUfxExeag5vKl/t1FFrTkjNxuHldH/LG1AswfIbr03H
         Nuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728319802; x=1728924602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmGaAQmkU9F3c2Jeb7g7GHDPHRwyj2CfpEporkATVQA=;
        b=FtoHGeB45LYyXfbx3dhPRFMOLp7hIWAc4XMScXOkDj/FgyjopMjn3Piex/eqRFVFcc
         7Mv6WThzTW4roHKmGUFyoRfuJuuOZa3bjbE11U5KQAb06FvM0GHST61BMb+3J9Tl9HrO
         79TEHgOq1t6pnMjzLqz/1ITktHhsAVQtJreWW0xcPfE6x3XP4DiwwxPg4h2LG73fQLrY
         V1QwkdUVfSIXHzjgu/9Skw617w5YcFMwYYcnW+CJq3j1fJlpgr9U11EfWrDyKiFcp4tK
         T2R5nUCFm3Ff2uCpLJCGkpGfoQzZFQt8YVwnQ0HUFlD7u59UmFmEzaP+wSY0ZYkoYT9+
         micg==
X-Gm-Message-State: AOJu0YyB8KwLRgtLo86zj+RYSVIjhZDJJVTZ1jILkgk0FYrSyZPIZVCg
	UFE0reKbtceYtd/Lt5CCLCDOKRq9H+JZvCvxUPqmdbqOfi27Lr2g2UBGLVr/xqDLGOwP+4rcfhr
	vHUXDzxI4Lhnvgjxh3agjDSuacI1hED8elPuJ5Q==
X-Google-Smtp-Source: AGHT+IEm+VXpk2PXdAMKj32kJciQY2qUulpmzOvWUM5SHIl1I7X9ZVDGrC8jmlFtgyk3aSmC+UhdwaJrO50hnJny9+M=
X-Received: by 2002:a05:6214:2c05:b0:6c5:681e:1d4 with SMTP id
 6a1803df08f44-6cb9a4556a6mr191929736d6.34.1728319801515; Mon, 07 Oct 2024
 09:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPX310gmJeYhE2C6-==rKSDh6wAmoR8R5-pjEOgYD3AP+Si+0w@mail.gmail.com>
 <2024092318-pregnancy-handwoven-3458@gregkh> <CAPX310hNn28m3gxmtus0=EAb3wXvDTgG2HXyR63CBW7HKxYkpg@mail.gmail.com>
In-Reply-To: <CAPX310hNn28m3gxmtus0=EAb3wXvDTgG2HXyR63CBW7HKxYkpg@mail.gmail.com>
From: =?UTF-8?Q?Fabian_St=C3=A4ber?= <fabian@fstab.de>
Date: Mon, 7 Oct 2024 18:49:51 +0200
Message-ID: <CAPX310hCZqKJvEns9vjoQ27=JZzNNa+HK0o4knOMfBBK+JWNEg@mail.gmail.com>
Subject: Re: Dell WD19TB Thunderbolt Dock not working with kernel > 6.6.28-1
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

sorry for the delay, I ran git bisect, here's the output. If you need
any additional info please let me know.

3c1d704d9266741fc5a9a0a287a5c6b72ddbea55 is the first bad commit
commit 3c1d704d9266741fc5a9a0a287a5c6b72ddbea55 (HEAD)
Author: Sanath S <Sanath.S@amd.com>
Date:   Sat Jan 13 10:52:48 2024

    thunderbolt: Reset topology created by the boot firmware

    commit 59a54c5f3dbde00b8ad30aef27fe35b1fe07bf5c upstream.

    Boot firmware (typically BIOS) might have created tunnels of its own.
    The tunnel configuration that it does might be sub-optimal. For instanc=
e
    it may only support HBR2 monitors so the DisplayPort tunnels it created
    may limit Linux graphics drivers. In addition there is an issue on some
    AMD based systems where the BIOS does not allocate enough PCIe resource=
s
    for future topology extension. By resetting the USB4 topology the PCIe
    links will be reset as well allowing Linux to re-allocate.

    This aligns the behavior with Windows Connection Manager.

    We already issued host router reset for USB4 v2 routers, now extend it
    to USB4 v1 routers as well. For pre-USB4 (that's Apple systems) we leav=
e
    it as is and continue to discover the existing tunnels.

    Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
    Signed-off-by: Sanath S <Sanath.S@amd.com>
    Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

 drivers/thunderbolt/domain.c |  5 +++--
 drivers/thunderbolt/icm.c    |  2 +-
 drivers/thunderbolt/nhi.c    | 19 +++++++++++++------
 drivers/thunderbolt/tb.c     | 26 +++++++++++++++++++-------
 drivers/thunderbolt/tb.h     |  4 ++--
 5 files changed, 38 insertions(+), 18 deletions(-)

On Tue, Sep 24, 2024 at 8:58=E2=80=AFAM Fabian St=C3=A4ber <fabian@fstab.de=
> wrote:
>
> Hi Greg,
>
> I can reproduce the issue with the upstream Linux kernel: I compiled
> 6.6.28 and 6.6.29 from source: 6.6.28 works, 6.6.29 doesn't.
>
> I'll learn how to do 'git bisect' to narrow it down to the offending comm=
it.
>
> The non-lts kernel is also broken.
>
> Fabian
>
> On Mon, Sep 23, 2024 at 8:45=E2=80=AFAM Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> >
> > On Mon, Sep 23, 2024 at 08:34:23AM +0200, Fabian St=C3=A4ber wrote:
> > > Hi,
> >
> > Adding the linux-usb list.
> >
> > > I got a Dell WD19TBS Thunderbolt Dock, and it has been working with
> > > Linux for years without issues. However, updating to
> > > linux-lts-6.6.29-1 or newer breaks the USB ports on my Dock. Using th=
e
> > > latest non-LTS kernel doesn't help, it also breaks the USB ports.
> > >
> > > Downgrading the kernel to linux-lts-6.6.28-1 works. This is the last
> > > working version.
> > >
> > > I opened a thread on the Arch Linux forum
> > > https://bbs.archlinux.org/viewtopic.php?id=3D299604 with some dmesg
> > > output. However, it sounds like this is a regression in the Linux
> > > kernel, so I'm posting this here as well.
> > >
> > > Let me know if you need any more info.
> >
> > Is there any way you can use 'git bisect' to test inbetween kernel
> > versions/commits to find the offending change?
> >
> > Does the non-lts arch kernel work properly?
> >
> > thanks,
> >
> > greg k-h

