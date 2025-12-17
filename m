Return-Path: <stable+bounces-202888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6CCCC9307
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 19:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 060C4304F641
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 18:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647331E520C;
	Wed, 17 Dec 2025 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="m6VctSRG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0EF221FBA
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765994737; cv=none; b=i/VP0dXLVmN1dFkI5MRwQ1xTD96lOFJulY++5j6n4V8gu2MG3k8Ggqn6mCQLiNT5OyWEOgWuQaN4JhlH/ss3/UeNHlZA1YrL+7hsT1zpCjbg4SI02jKYA18AJjHkEiOLOHuLhXbtPu7kb0KgWeDR/qcPSvjGniFWomldRsqgTQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765994737; c=relaxed/simple;
	bh=p1cvpTX5RLoAO8HeSmuv2dfbdIEinYB2dnMfMZOY2Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2m5uXrfIInzsXV5One5dOlJNCqAS0XuezHWi6ImoK2LxBl5iNg6X3sEglL6j5kmoP5HzZLEw2UtluBPvaqX3ewJOiucZjhDbSDB4xKwqkN0yXdr/Dh0cM4yussdpjWqeg1Ftm9Syiy5J6PjCcoMw0caaQHlGLV0563jKSur/wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=m6VctSRG; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b79ea617f55so633961466b.3
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 10:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1765994733; x=1766599533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNbYUFZZYG5LLhuFezjR0F4Hdhz6rQmi452cio67adk=;
        b=m6VctSRGFteBuBWfeGr6+KFVCewrNAlZ70vlJv1BesSb5mHJke78XaXKBq2cFWq/Q3
         24a7IB5Odf0OeO3RntpFISFxA9ynPPKlePXFOpOnhmT+AsV8qfNhcBGVHSm3r7JqapZw
         qKeUAFQFFGyG2lQ860BiD9RqnFccja5MsMCZV/uH/U/rBrBFIZBHuLVfgdjhwsAYgFll
         74naUWSfmWcsq8HivA2u1N1yC2Anc/3LdgLAY/RP+LbnvZo2uG4uIGXy2NTv1URvc+Eg
         Ff0yWpE3LtGKHgr6IOMF8GbcfsDdPKvkZ+TXzZcNIo8FTF+qu6BWkdXdFLIWkovzBy9v
         ALrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765994734; x=1766599534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uNbYUFZZYG5LLhuFezjR0F4Hdhz6rQmi452cio67adk=;
        b=opD9RoJzNN1tU5JXKdxwQD+uNDk30V+v8bE+R3z2gsDVbIkvcRnpGBKxZX4l3Y3auc
         f4GnbZAWDZ3aCMXty5TiqPJjGlyNfRZztkn8Sz5STknjcTifKkkfBp87g4ye/4Rv2a8c
         PtqSeKiOBXVTku9D35c6lExc9QH+p1IuMu1VUYZKv7z56Qq4T74rldnjRy28wL5/VGh+
         sHoc+3VIZHhJNTT6lAKh+lH84m8bCW8GiYbMo+TayXkHD8eXMHIAGt4ney8AA9NZU2tt
         r8eoS0wUVTvgbH6vw6juDKYPJsAv+clFmK/MzQs7WpmBd7h/ZmdYzkNCH5J4hgBsru2P
         q6Dg==
X-Gm-Message-State: AOJu0Yyu06MuFU0Z5RA3nWYPD6hjq4qLXEnoAsMs2/1ZDFI2Nj/v116c
	aN6Gl8ck5V7C3RRus0MqSTDz7UhFqeENT4k8tAriRKUG1BHTPubRNt21B9BEMyhkOEvFDyI+H5P
	vIYrduz8lsAFfoaaZ45oekW8RqThPIl+/ZqAP2Rls4w==
X-Gm-Gg: AY/fxX7IUTDKDHK3j0ac6T/DJnUXDfqmrSWDnmtLqtSGVVrjRUVBC3vgtmtdK0dnjTj
	dbPXxit5bUf2VRXj0WOwQp+rOmcPlxjvfL2vrbdixXjm+0TZlz1jZytBFW179knyCSs1vIbRErz
	zW2qFCY9K9B5m0vHvCCEb7VP3M7rcS4tVEzYIQ/R4rJEdHJthvVwgh17U80mJ24W+i+cALF2kze
	KOH4Ix8ONWVmTisYkrpxKlBuQeGCO6NOJtJ8WFJrunB3Q0iKRIXFZZrurHIhyvrgIUQ+8sp0VYL
	wYE/HA==
X-Google-Smtp-Source: AGHT+IFrXPT5pcsN4U9JlCw3uDxBO5Lgj2D0BJHK4Sibf7pThlYmGH7eHfZlo4QOetU1br00xeRdHfxUZK63kQf3PlY=
X-Received: by 2002:a17:907:9411:b0:b76:74b6:dbf8 with SMTP id
 a640c23a62f3a-b7d236af43amr1989150966b.14.1765994733369; Wed, 17 Dec 2025
 10:05:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216111947.723989795@linuxfoundation.org> <CAG=yYwnv+EsEhOSUFFFGQYm6MXzDFzPKq=pp+wk2J5rvLupoQQ@mail.gmail.com>
 <CAG=yYwkuq=WCGMqYcuWh5eHuVY5rUFWRtbZKgcUb1Eg1GxgM3w@mail.gmail.com> <2025121746-hardcopy-curry-5e02@gregkh>
In-Reply-To: <2025121746-hardcopy-curry-5e02@gregkh>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 17 Dec 2025 23:34:55 +0530
X-Gm-Features: AQt7F2o6K-RhZYV1UO-lRzII2PWuZegpdTnwtoiI-vNUJHGfd8UCWzLlPz6azE4
Message-ID: <CAG=yYwmY7_iqUTG9m1yPyaSNFqMTsNCTz-Yx=H6=rU_HeXxygg@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/506] 6.17.13-rc2 review
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

On Wed, Dec 17, 2025 at 8:34=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 17, 2025 at 08:24:15PM +0530, Jeffrin Thalakkottoor wrote:
> > On Wed, Dec 17, 2025 at 1:09=E2=80=AFPM Jeffrin Thalakkottoor
> > <jeffrin@rajagiritech.edu.in> wrote:
> > >
> > > hello
> > >
> > > Compiled and booted  6.17.13-rc2+
> > >
> > > dmesg shows error...  file attached
> > >
> > > As per dmidecode command.
> > > Version: AMD Ryzen 3 3250U with Radeon Graphics
> > >
> > > Processor Information
> > >         Socket Designation: FP5
> > >         Type: Central Processor
> > >         Family: Zen
> > >         Manufacturer: Advanced Micro Devices, Inc.
> > >         ID: 81 0F 81 00 FF FB 8B 17
> > >         Signature: Family 23, Model 24, Stepping 1
> > >
> > > Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
> >
> > i  have done a  git bisect  and the log is attached.
> > THANKS
> >
> >
> > --
> > software engineer
> > rajagiri school of engineering and technology
>
> > git bisect start
> > # status: waiting for both good and bad commits
> > # bad: [f89c72a532b507111acfe1b83ff4855dc6772043] Linux 6.17.13-rc2
> > git bisect bad f89c72a532b507111acfe1b83ff4855dc6772043
> > # status: waiting for good commit(s), bad commit known
> > # good: [6fedb515e7f90986da3de36a35752e6dc2e0c911] Linux 6.17.12
> > git bisect good 6fedb515e7f90986da3de36a35752e6dc2e0c911
> > # good: [6fedb515e7f90986da3de36a35752e6dc2e0c911] Linux 6.17.12
> > git bisect good 6fedb515e7f90986da3de36a35752e6dc2e0c911
> > # good: [bef2390379e56d44e5fed5400bba2f6c2486cd6c] tracefs: fix a leak =
in eventfs_create_events_dir()
> > git bisect good bef2390379e56d44e5fed5400bba2f6c2486cd6c
> > # good: [16be45fa274beefba34a25da3551276b9fb48382] vhost: Fix kthread w=
orker cgroup failure handling
> > git bisect good 16be45fa274beefba34a25da3551276b9fb48382
> > # good: [3e619964439334c23c079ff3986fd62d94d8c842] NFS: Initialise veri=
fiers for visible dentries in _nfs4_open_and_get_state
> > git bisect good 3e619964439334c23c079ff3986fd62d94d8c842
> > # good: [9786c2e58c42de159067fa3ae7a5b1e029bdcab1] rtc: gamecube: Check=
 the return value of ioremap()
> > git bisect good 9786c2e58c42de159067fa3ae7a5b1e029bdcab1
> > # good: [96b48878043620b06e74f5e435f0caf16105db8d] scsi: imm: Fix use-a=
fter-free bug caused by unfinished delayed work
> > git bisect good 96b48878043620b06e74f5e435f0caf16105db8d
> > # good: [299f05075dfe002156bbc46ba7da2a89357fe94f] usb: phy: Initialize=
 struct usb_phy list_head
> > git bisect good 299f05075dfe002156bbc46ba7da2a89357fe94f
> > # good: [0ecfb458bae89e7cc2ceca578405a014a7090c33] ALSA: hda/realtek: A=
dd match for ASUS Xbox Ally projects
> > git bisect good 0ecfb458bae89e7cc2ceca578405a014a7090c33
> > # good: [25b1100cb9ff0dcbd7263ab57fcede673be0ecc4] ALSA: hda: cs35l41: =
Fix NULL pointer dereference in cs35l41_hda_read_acpi()
> > git bisect good 25b1100cb9ff0dcbd7263ab57fcede673be0ecc4
> > # good: [5f0bc5d1d892e7bd28dab743c9e8dce2b6596fbc] ALSA: wavefront: Fix=
 integer overflow in sample size validation
> > git bisect good 5f0bc5d1d892e7bd28dab743c9e8dce2b6596fbc
> > # first bad commit: [f89c72a532b507111acfe1b83ff4855dc6772043] Linux 6.=
17.13-rc2
>
> So the change that sets the makefile is the bad commit?  I don't think
> the testing went correct for some reason :(
>
>

Actually i think that  the problem was with my kernel config and
during the test process
i was requested to  at least  change the config if i wanted . I
accepted the default values.
I booted with the new configuration  and dmesg -l err was clean.THANKS
for helping me :)




--=20
software engineer
rajagiri school of engineering and technology

