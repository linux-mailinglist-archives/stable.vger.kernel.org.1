Return-Path: <stable+bounces-183225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0290ABB6FB2
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 15:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DF9A4E9D7F
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 13:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4AF1DD9D3;
	Fri,  3 Oct 2025 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lU+ono0N"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99463522F
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759497673; cv=none; b=u6Tj4x5QOWW7d6vA1VQuf4undxcO7K79ViY37GneQG7l7xsRyU9PULcH3JhXOFLJwAHZlO9e83efJuGU6ul9X3dNE6Aetf9ZrvXANij3GsvwR9fh1raN1JkwetPLLLa0ocsdCCXJLg7mCy9j5j2i5FGSBSf5BLRDSF8qDgcSMeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759497673; c=relaxed/simple;
	bh=+T3UOqQZFvy7eBHlAWJr/3kPNyoFfQ1q2UOiIWHKdwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WFCPa4Cs8D9MYO+3fSKWeu+euZIT9pDAPCxDHANhmILvwUUi2FfgyV4I9QTWLPbHXx+7Sw7uHJEfVIPgaehnVaRlSiqVJMaZ9oZofltEon1jwD510C7Obc5p1CeOgJBOJ214LLwMERnGAKYMl3KH3ec3Fl3FWC9KRlVSJ5T+0fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lU+ono0N; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so3620318a12.3
        for <stable@vger.kernel.org>; Fri, 03 Oct 2025 06:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759497670; x=1760102470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8zhl7eFh/Ccgjvyj875lnW0wZkdwAI8sMWJQNebn0o=;
        b=lU+ono0NDj2J+OfGgerQ6M9g0JYYdRJhwVDwRuHdr4N50dmZZ4GoLVxf+w6Bnx24Sm
         uWQUPJe1XEc49Sl2YRkoReP6H5cF3floBG/SJ3B6vvkGeplq/lezu+cj0dGslQSlB/zB
         tVxEpTebwxwxyO6/2zAtMqycec0BamJ4iKH1onRlYyPCRqGZQIDLEdgjN2uKQPdw+xT6
         V8/lV5MNgrC+4nM5TbmOk2xSSILLQeMjS0b6Bn3GPn6tSBfHxu4Uw9lFvxUB1NytOPJM
         wy61ZM3oEEK542HIzqHJiIBEqwsu3UiAM7HeO/Fx+ZGxoc59Gi9t0dnDEFzUJ0gnr7rl
         lSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759497670; x=1760102470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8zhl7eFh/Ccgjvyj875lnW0wZkdwAI8sMWJQNebn0o=;
        b=TeMJIq09Fd8fcwKFuhF3mkcPREXfMPik8utl61AQA7DPKFLrug8F2OqK7/+hDQEHhR
         e+aO+XRNnp1HmdD8TtTxw//y2aNwdCT4BdxMkSj9VPonHbgmTap+YYnWVwSz6e3jE+Iy
         V+s/andu1HQgEE/1lh2aU6/G193Cv24KJXKbr+bTNgGpW47uJRl10Q/XGbeMIzUCh8gL
         YJJanOSppv/Afi+AhqA+vYbDCPV6xDuWzNd9xoUg+5vRSFlNZpjNRBU6pOeNz6lGQ/D7
         7Mkp9qOFSuLbeVihSEHSjJL8vcT+opcRnpXQV6viKlA/xcnhXO/oBmMPGx4TGXcgxe24
         g17g==
X-Forwarded-Encrypted: i=1; AJvYcCVmNxhJ6/c1E32s+VQCA7viVFG+DReQyFqmznc2TIAZ/k3JAY352mZZpTgC4RtNVrTv3uaNpgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YywuYxMaU+rTay23OOwZNYeJygcPda2oOP1pR6oYSv3Und9KpDA
	EWFnt9BPj21F1KqW4/JUjNn5iNR3bMaeo/OWne7Bz/KLf4TjUN7qkw9/B8zX1FZYJf871ZPVG/Q
	JcDf7gOcSqNdGnFpxCceGaPWTL5ppqDg=
X-Gm-Gg: ASbGnctH3pOtHf3Npwu/+pAZesQLMpkZDDsuq82jXGEw9W8UJziaFWLGqrFH1ELud52
	2rl1xSOSiUX+DEK68LJvhADGoAMo19dh4KoI5ld0ySckVlDlIdPDiPzPBEiP3q6y1ffD+Q860jL
	jsAVeg8n69EnGb02tRzW62YZQelJC7nvDekfosWcBc2FXRKMckzdMwmXsWUEerqBwcfAJcXwhct
	5DdfDb1Ikyr2sybtQURhpKu2jLzQqEUJZAzWdoUPJyg4rX1P2rdyh+gcIYCCC8kqy/RpXJ3jX43
	oG+rmT8NPCSyQ6PpnyxorVcQ/j6o+VzQWRxe4cnsKWB/l8uijgcuFkzYXCVnig==
X-Google-Smtp-Source: AGHT+IEA3negWfetSsQ9J9E7GZNGFXMwJJzB/z247mUrnUgKg78kzOOKAjkgcmEBNB3ECXV1sheBHc3044R6M6RK6bo=
X-Received: by 2002:a17:907:2d22:b0:b40:e267:93dc with SMTP id
 a640c23a62f3a-b49c2958624mr388499866b.24.1759497669641; Fri, 03 Oct 2025
 06:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMBK1_QFuLQBp1apHD7=FnJo=RWE532=jMwfo=nkkGFSzJaD-A@mail.gmail.com>
 <2024011723-freeness-caviar-774c@gregkh> <CAMBK1_S2vwv-8PfFQ4rfChPiW7ut5LXgmUZRtyhN=AoG3g5NEg@mail.gmail.com>
 <bf07c1bc-b38e-4672-9bb0-24c16054569a@leemhuis.info>
In-Reply-To: <bf07c1bc-b38e-4672-9bb0-24c16054569a@leemhuis.info>
From: Serge SIMON <serge.simon@gmail.com>
Date: Fri, 3 Oct 2025 15:20:38 +0200
X-Gm-Features: AS18NWDqPgMDcv-4TQOr74BUnAM5tFfS08euR1LMs-basfmqfZJtbqn0MsFu4Tc
Message-ID: <CAMBK1_Sw8nVSN3Z7WtHYyJ2xWUNVYNcx26UKFx5hy+xQrO=bHA@mail.gmail.com>
Subject: Re: S/PDIF not detected anymore / regression on recent kernel 6.7 ?
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: linux-sound@vger.kernel.org, stable@vger.kernel.org, 
	Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I still encounter this issue (and every month i test the latest
kernel, each time with the same results) :
- i do have an ASUS B560-I WIFI (ITX) motherboard with a S/PDIF output
- everything was working flawlessly until (and including) kernel
6.6.10, and that S/PDIF output was perfectly detected (under GNOME
SHELL, etc.)
- starting from kernel 6.7.0 (and newest ones, including 6.16.10
tested today) the S/PDIF output it NOT detected anymore at boot time
by the kernel (so is not selectable any more under GNOME SHELL or
COSMIC, etc.)

With old kernel (example :
https://gist.github.com/SR-G/0e86d917716acff0d31cad0365f0b500#file-gistfile=
1-txt)
:

% cat /proc/asound/pcm

00-00: ALC1220 Analog : ALC1220 Analog : playback 1 : capture 1
00-01: ALC1220 Digital : ALC1220 Digital : playback 1
00-02: ALC1220 Alt Analog : ALC1220 Alt Analog : capture 1
01-03: HDMI 0 : HDMI 0 : playback 1
01-07: HDMI 1 : HDMI 1 : playback 1
01-08: HDMI 2 : HDMI 2 : playback 1
01-09: HDMI 3 : HDMI 3 : playback 1


With kernels >=3D 6.7.0 (example :
https://gist.github.com/SR-G/0e86d917716acff0d31cad0365f0b500#file-dmesg-6-=
12-6-log)
:

% cat /proc/asound/pcm
00-03: HDMI 0 : HDMI 0 : playback 1
00-07: HDMI 1 : HDMI 1 : playback 1
00-08: HDMI 2 : HDMI 2 : playback 1
00-09: HDMI 3 : HDMI 3 : playback 1

It seems i'm the only one impacted :(

Who can help me on this topic ?

Thanks in advance and regards.

--
Serge.


On Mon, Feb 5, 2024 at 8:35=E2=80=AFAM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 05.02.24 08:09, Serge SIMON wrote:
> >
> > Any news on this ?
>
> Apparently not. I added the sound maintainers just to be sure they are
> aware of this.
>
> > Just to say that i tried the 6.7.3 version and i have the exact same
> > problem as described below
> > ("linux-headers-6.7.3.arch1-2-x86_64.pkg.tar.zst" for the exact ARCH
> > package, of course with a system fully up-to-date and rebooted) : no
> > more S/PDIF device detected after reboot (only the monitors are
> > detected, but not anymore the S/PDIF output at motherboard level-
> > which is what i'm using).
> >
> > Reverting to 6.6.10 does solve the issue, so per what i'm seeing,
> > something has definitely been broken between 6.6.10 and 6.7.0 on that
> > topic.
>
> Unless the sound maintainers come up with something, we most likely need
> a bisection from you to resolve this.
>
> In case you want to perform a bisection, this guide I'm currently
> working on might help:
>
> https://www.leemhuis.info/files/misc/How%20to%20bisect%20a%20Linux%20kern=
el%20regression%20%e2%80%94%20The%20Linux%20Kernel%20documentation.html
>
> > Is this tracked by a bug somewhere ? Does i have to open one (in
> > addition to these mails) ?
>
> No, this thread (for now) is enough.
>
> Ciao, Thorsten
>
>
> > On Wed, Jan 17, 2024 at 6:39=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> >>
> >> On Tue, Jan 16, 2024 at 09:49:59PM +0100, Serge SIMON wrote:
> >>> Dear Kernel maintainers,
> >>>
> >>> I think i'm encountering (for the first time in years !) a regression
> >>> with the "6.7.arch3-1" kernel (whereas no issues with
> >>> "6.6.10.arch1-1", on which i reverted).
> >>>
> >>> I'm running a (up-to-date, and non-LTS) ARCHLINUX desktop, on a ASUS
> >>> B560-I motherboard, with 3 monitors (attached to a 4-HDMI outputs
> >>> card), plus an audio S/PDIF optic output at motherboard level.
> >>>
> >>> With the latest kernel, the S/PIDF optic output of the motherboard is
> >>> NOT detected anymore (and i haven't been able to see / find anything
> >>> in the logs at quick glance, neither journalctl -xe nor dmesg).
> >>>
> >>> Once reverted to 6.6.10, everything is fine again.
> >>>
> >>> For example, in a working situation (6.6.10), i have :
> >>>
> >>> cat /proc/asound/pcm
> >>> 00-00: ALC1220 Analog : ALC1220 Analog : playback 1 : capture 1
> >>> 00-01: ALC1220 Digital : ALC1220 Digital : playback 1
> >>> 00-02: ALC1220 Alt Analog : ALC1220 Alt Analog : capture 1
> >>> 01-03: HDMI 0 : HDMI 0 : playback 1
> >>> 01-07: HDMI 1 : HDMI 1 : playback 1
> >>> 01-08: HDMI 2 : HDMI 2 : playback 1
> >>> 01-09: HDMI 3 : HDMI 3 : playback 1
> >>>
> >>> Whereas while on the latest 6.7 kernel, i only had the 4 HDMI lines
> >>> (linked to a NVIDIA T600 card, with 4 HDMI outputs) and not the three
> >>> first ones (attached to the motherboard).
> >>>
> >>> (of course i did several tests with 6.7, reboot, ... without any chan=
ges)
> >>>
> >>> Any idea ?
> >>
> >> As this is a sound issue, perhaps send this to the
> >> linux-sound@vger.kernel.org mailing list (now added).
> >>
> >> Any chance you can do a 'git bisect' between 6.6 and 6.7 to track down
> >> the issue?  Or maybe the sound developers have some things to ask abou=
t
> >> as there are loads of debugging knobs in sound...
> >>
> >> thanks,
> >>
> >> greg k-h
> >
> >
>

