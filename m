Return-Path: <stable+bounces-45450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BBE8CA05E
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 17:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98A49B21F5D
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 15:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4DE13776A;
	Mon, 20 May 2024 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZ8P6Zu6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7B44C66;
	Mon, 20 May 2024 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716220675; cv=none; b=jkOe8f1f9E32YCPhbJIBSQkWWhDSKfb+dIhL4pETsjlTRQM+Docd/C3ZpaBZIZ6k4vrOarfxE8cmdthxXNcF3NSqVXesFqGLCgoSl8epSaae+zKBBEXR4XlOzcHVycI4o1DlS2LW4ECxoF2dcrT5E20JF//SQaY+s+hrOHRPZrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716220675; c=relaxed/simple;
	bh=Ubvg7/bUDji76tdgAn5Z+55CXMf3HjF4vhBaLuUlYEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIus1MQ/aY3zMjU43ZaY7mt4bW+247OKirbSdu+ei8xhYH2pwOh9RclFnSKiS5GdIsWL9pNyivuua+e9kjkfRUxr46SB/9cqPYevOQuzVTqIUyREmFux/JUSKaeVAaqzkJSGxBsDyF0iXKtEHXM75zR/+E4Qh5klAsWurobnZ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZ8P6Zu6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1edf506b216so75545215ad.2;
        Mon, 20 May 2024 08:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716220673; x=1716825473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjH8e+R60esnA42ensqqUdM+fwtzfN5aPs3zsl9Chx8=;
        b=WZ8P6Zu6Ga4NDr6unUwMgqG+9pVBMQOuMGAcR265KQP0L3u5yOtGQwlrFJYu0hczO+
         ifeJea0xfJ3MTWar7QLQ0rsLjLkh+CP5O52DFVhFSojrF2d8N8ncevZr/8xWxfb3hU5P
         Xgey4I5Skc5mriLIZeAlQG/BnA1xTjZXldxDWKLRhpzWckSIyo42oOUYm2K01V64pzvo
         aFJ9IUm25/ahEZ8cUM4BFaUFQG8ccPlCNEMfEHzO0Rh+mnk8Zuta1Vo2kYY8MAvLxKBU
         kNnwdSRKsF64L5GGjqIgWtXYDaWpHGCcfRlvWGrK3xmzd3BDdHcz1O4SkPdWjOepJSPS
         ii/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716220673; x=1716825473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjH8e+R60esnA42ensqqUdM+fwtzfN5aPs3zsl9Chx8=;
        b=cZ3yZI5MZS9k260v67r7UONhyCtYERzgFV7OGJHs/JF/0NKseVrgtO3+xdvdnvYefv
         iTKqaiO5enlpoOl66mrhbApRH6OqvoocNzvoBPWRNumkryNJ+a1Y7jFnUxt5xWMimC0f
         w3CWdmXm0TzuqJt3+XfqgV4sheN0eutuUSY9CjxSD7ulgpo0iCoCHZVyuB83NVfNB3DZ
         WyMjRydMwlASiEHAMBWwRosUhlP4uDnaoGpSbVcvg7Eiva1KCL9nosVytVFDGoQ79MRw
         wNHezSKofNXnqyuiwg+3doC2RSNxV/s+Q6o/DZdXP5Iqarv+P9bz3A4Y+YHg9gqAj0/l
         vVAA==
X-Forwarded-Encrypted: i=1; AJvYcCXf8+LhWqEtZ1ajo0Ige1jW0/5NqHJ4l2Z/icFZQ2uhaCE6UhADk/pl3SIYkoSYMQ830mgagiEzdeUYRxfg9JaGv8w3snrnJ7lt+8wqsFwdvFRUUhP6Gl9fnMW6nTF5iP7Sj41hu5Y0+tp/r+uX2J/7vkFElN5/0cbRmMGzkKr/
X-Gm-Message-State: AOJu0YyQHR9ABSLmfREQhpa6SO1+m6Ab+sH/R0pUOzRZRFwUSY9ObM4Z
	1t5neVsxko8uOV1Xsq7Z3L2tS5LRCpoFMkCXdnB8QvmBzY+aEM+lHSCc7QEKkz+rjPmkOqiQKm+
	cKAps8dqumLixqG0SD/k0iDscUsc=
X-Google-Smtp-Source: AGHT+IGR0QJwNONgLrUrdS9bK1zR2hDGXfZLtrDr3dOnQQbOEKaLAKicvLTb2C4p5DrkQw4YSMQ8x0x/um9d2gfsaZs=
X-Received: by 2002:a17:90a:ab02:b0:2b4:39cd:2e0e with SMTP id
 98e67ed59e1d1-2b6cc76bdd5mr26911326a91.21.1716220673365; Mon, 20 May 2024
 08:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHe5sWavQcUTg2zTYaryRsMywSBgBgETG=R1jRexg4qDqwCfdw@mail.gmail.com>
 <38de0776-3adf-4223-b8e0-cedb5a5ebf4d@leemhuis.info> <lqdpk7lopqq4jn22mycxgg6ps4yfs7hcca33tqb2oy6jxc2y7p@rhjjbzs6wigu>
 <611f8200-8e0e-40e4-aff4-cc2c55dc6354@amd.com>
In-Reply-To: <611f8200-8e0e-40e4-aff4-cc2c55dc6354@amd.com>
From: Gia <giacomo.gio@gmail.com>
Date: Mon, 20 May 2024 17:57:42 +0200
Message-ID: <CAHe5sWY_YJsyiuwf2TsfRTS9AoGoYh4+UxkkZZ0G9z2pXfbnzg@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] "xHCI host controller not responding,
 assume dead" on stable kernel > 6.8.7
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Christian Heusel <christian@heusel.eu>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "kernel@micha.zone" <kernel@micha.zone>, 
	Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, =?UTF-8?Q?Benjamin_B=C3=B6hmke?= <benjamin@boehmke.net>, 
	"S, Sanath" <Sanath.S@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mario,

In my case in both cases the value for:

$ cat /sys/bus/thunderbolt/devices/domain0/iommu_dma_protection

is 0.

Output of sudo journalctl -k with kernel option thunderbolt.dyndbg=3D+p:
https://codeshare.io/qAXLoj

Output of sudo dmesg with kernel option thunderbolt.dyndbg=3D+p:
https://codeshare.io/zlPgRb

Output of sudo journalctl -k with kernel options thunderbolt.dyndbg=3D+p
thunderbolt.host_reset=3Dfalse:
https://codeshare.io/Lj3rPV

Output of sudo dmesg with kernel option thunderbolt.dyndbg=3D+p
thunderbolt.host_reset=3Dfalse:
https://codeshare.io/beQw36

Best

Giacomo

On Mon, May 20, 2024 at 4:41=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 5/20/2024 09:39, Christian Heusel wrote:
> > On 24/05/06 02:53PM, Linux regression tracking (Thorsten Leemhuis) wrot=
e:
> >> [CCing Mario, who asked for the two suspected commits to be backported=
]
> >>
> >> On 06.05.24 14:24, Gia wrote:
> >>> Hello, from 6.8.7=3D>6.8.8 I run into a similar problem with my Caldi=
git
> >>> TS3 Plus Thunderbolt 3 dock.
> >>>
> >>> After the update I see this message on boot "xHCI host controller not
> >>> responding, assume dead" and the dock is not working anymore. Kernel
> >>> 6.8.7 works great.
> >
> > We now have some further information on the matter as somebody was kind
> > enough to bisect the issue in the [Arch Linux Forums][0]:
> >
> >      cc4c94a5f6c4 ("thunderbolt: Reset topology created by the boot fir=
mware")
> >
> > This is a stable commit id, the relevant mainline commit is:
> >
> >      59a54c5f3dbd ("thunderbolt: Reset topology created by the boot fir=
mware")
> >
> > The other reporter created [a issue][1] in our bugtracker, which I'll
> > leave here just for completeness sake.
> >
> > Reported-by: Benjamin B=C3=B6hmke <benjamin@boehmke.net>
> > Reported-by: Gia <giacomo.gio@gmail.com>
> > Bisected-by: Benjamin B=C3=B6hmke <benjamin@boehmke.net>
> >
> > The person doing the bisection also offered to chime in here if further
> > debugging is needed!
> >
> > Also CC'ing the Commitauthors & Subsystem Maintainers for this report.
> >
> > Cheers,
> > Christian
> >
> > [0]: https://bbs.archlinux.org/viewtopic.php?pid=3D2172526
> > [1]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/=
issues/48
> >
> > #regzbot introduced: 59a54c5f3dbd
> > #regzbot link: https://gitlab.archlinux.org/archlinux/packaging/package=
s/linux/-/issues/48
>
> As I mentioned in my other email I would like to collate logs onto a
> kernel Bugzilla.  With these two cases:
>
> thunderbolt.dyndbg=3D+p
> thunderbolt.dyndbg=3D+p thunderbolt.host_reset=3Dfalse
>
> Also what is the value for:
>
> $ cat /sys/bus/thunderbolt/devices/domain0/iommu_dma_protection

