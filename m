Return-Path: <stable+bounces-45491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13A88CAABF
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 11:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48711C2143A
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 09:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370DF57CB2;
	Tue, 21 May 2024 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzFcs6QK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFF06D1B0;
	Tue, 21 May 2024 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716283510; cv=none; b=AbM96lQPcDpLD/mkbcL3yh+W7FJ9r0P4upGEndNkjyBXzFioTFWCZV3CMhLz4RtPGs2Pnj89WvwbOB8HcLuXIWqNyFkNIt3429PZbspeIclvLKkJgf9ccUxufb/h8/N8rlPSO/hM0oHsKhkYWBgCfAXwjnXl6i5FXPLVrDq0FHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716283510; c=relaxed/simple;
	bh=W7C8qCu9f8aWv8t+JSd20FzArS+tgmmsu1qXPGKkqQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KjXMUujzwJ19F/XC5czgXWohgaKPiRT/S9RzgAbT3XKfjYqiNxDsNjPxmaruLMAXof9Qh7Wy212J4JAvOhMNRxvTYLNps+rs78aN6h53gQ6Zu7s9NdQoV3a+UxW7y6EaMB93ucHen+ZHUtDxCO/hGSuQHTnl4+LVFDj2sdXeIcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzFcs6QK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e3c3aa8938so102245785ad.1;
        Tue, 21 May 2024 02:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716283508; x=1716888308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cx9Q/EMTUpa92+pOPrcJO/MH3AWeXtVafWw6ElrJXwI=;
        b=PzFcs6QKsraea6O4nNMbEjCzvGFvSLD1u7s8lS5BH7NLuTqulqohI1+Z4BVGA5Bljt
         DrMqXqfKGnnNb+5oRkdpy+LKA0hRc5CyS42Xm6bKmZMxDB0G3BfzFDwFugmyEY4KSTWj
         tJz6pEuA62HGhA8xX7pddBZgMoPKmZ2e5oW6Xiz74LOtE1wSD4pSmW7pfSbfs98OCFHB
         vae774blmzCu9llBEOEM+58zojQ3J+4/cJfa7zM8CkodhknP6qeDFnagB0rZ5QPlTuWz
         F/NW+AL0Ibf2djFmwUMBI/LJsufQTs6RqFzJex7ko3ueiRniQylC+q14TZgjFVQYPhaF
         XCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716283508; x=1716888308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cx9Q/EMTUpa92+pOPrcJO/MH3AWeXtVafWw6ElrJXwI=;
        b=Jdw+2mAaxaDVxVXfkze7mCdiQVSq8YPI+Dy+jMR33zwLCnmdyURtjEe9QZ/x/MTH8R
         /mFONSRENbjGFbhEyM+WIOgf5JMbFUvjXLSg/vlNvta94lJJSKPZT2KomzQUPP9CtQtW
         wrW8sQ1EFKHuwqTamW7kUGBxYhdL3/89YAe/0ejNXI0sQBvV//6TrLkc3EQPvecFbz+a
         Ltxu1n+/LrA32H/giw/DciuWddC3sUjHw2tQoM1m8lm93vKUg4fa+dguZHhmaQPzj3sM
         A3mM+gdhhEGXJ6RwDh3SJ1ifsYTLXOm0RyGI1uZqJ46a77YHiJZXpeWa+rAS6P4NtGJy
         dxeA==
X-Forwarded-Encrypted: i=1; AJvYcCUcC2JPZHCf3zVW364uadu0Gr4zYVLdGUmOnyok55LDHe2GfxeoZYK/RUGijQ2G2jC7mqK3E0Q1BEg918w/OGS/w1/RQeOyEZdQNpJhyrcu9/F/PFVW5BlY2dW+2O0EThYs4fDzTAG7c5WKqj5+CyPro2FQK4UwaguRJhCz2/rw
X-Gm-Message-State: AOJu0YytVwqMDQWRMEY03l05n26jW8zVZVpySQ8a81nTbYl6miCEyBDD
	2ya11Xt9C9eyG1DOwsJkHiZzIyvoIJ4yPGvYv1FbUc9q4DVC6eaa3MJ3Nv7BgonGfZ7C9OHjKdT
	G+fq2fXlWY5XdpFOvLE0FrwIkywQ=
X-Google-Smtp-Source: AGHT+IEwCS7Kheh/nn+lzkJGd0xBKEmdH0HPDsPUkPmuz+sowdI7it3ZW1guqCXJUYh1almZi/G075PMfPqiuKbJrKc=
X-Received: by 2002:a17:90b:46c4:b0:2b1:817d:982b with SMTP id
 98e67ed59e1d1-2b6cc777f3cmr28269888a91.14.1716283507825; Tue, 21 May 2024
 02:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHe5sWavQcUTg2zTYaryRsMywSBgBgETG=R1jRexg4qDqwCfdw@mail.gmail.com>
 <38de0776-3adf-4223-b8e0-cedb5a5ebf4d@leemhuis.info> <lqdpk7lopqq4jn22mycxgg6ps4yfs7hcca33tqb2oy6jxc2y7p@rhjjbzs6wigu>
 <611f8200-8e0e-40e4-aff4-cc2c55dc6354@amd.com> <CAHe5sWY_YJsyiuwf2TsfRTS9AoGoYh4+UxkkZZ0G9z2pXfbnzg@mail.gmail.com>
 <20240521051525.GL1421138@black.fi.intel.com> <CAHe5sWY3P7AopLqwaeXSO7n-SFwEZom+MfWpLKGmbuA7L=VdmA@mail.gmail.com>
 <20240521085501.GN1421138@black.fi.intel.com>
In-Reply-To: <20240521085501.GN1421138@black.fi.intel.com>
From: Gia <giacomo.gio@gmail.com>
Date: Tue, 21 May 2024 11:24:56 +0200
Message-ID: <CAHe5sWaABJi0Xo4ygFK4Oa3LdNUiQJSLidGPdAE=gwmy=b+ycw@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] "xHCI host controller not responding,
 assume dead" on stable kernel > 6.8.7
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Christian Heusel <christian@heusel.eu>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "kernel@micha.zone" <kernel@micha.zone>, 
	Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, 
	Yehezkel Bernat <YehezkelShB@gmail.com>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, =?UTF-8?Q?Benjamin_B=C3=B6hmke?= <benjamin@boehmke.net>, 
	"S, Sanath" <Sanath.S@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your suggestion Mika, as a general rule I totally agree
with you and I do not mess with kernel default parameters, but I
remember "pcie_aspm=3Doff" was necessary at the time I set up the
system. Probably a kernel or a BIOS update makes it unnecessary today.

I see it removes these messages from my logs but I trust you when you
say they have not an impact on functionality:

May 21 11:01:36 um773arch kernel: pcieport 0000:05:04.0: Unable to
change power state from D3hot to D0, device inaccessible
May 21 11:01:36 um773arch kernel: igb 0000:09:00.0 eth0: PCIe link lost
May 21 11:01:36 um773arch kernel: xhci_hcd 0000:08:00.0: xHCI host
controller not responding, assume dead
May 21 11:01:36 um773arch kernel: xhci_hcd 0000:07:00.0: xHCI host
controller not responding, assume dead
May 21 11:01:36 um773arch kernel: usb 3-1: 1:1: cannot set freq 48000 to ep=
 0x82
May 21 11:01:36 um773arch kernel: usb 3-1: 10:0: cannot get min/max
values for control 2 (id 10)
May 21 11:01:41 um773arch kernel: xhci_hcd 0000:06:00.0: xHCI host
controller not responding, assume dead
May 21 11:01:41 um773arch kernel: xhci_hcd 0000:06:00.0: HC died; cleaning =
up
May 21 11:01:41 um773arch kernel: usb 1-2: 1:1: cannot set freq 48000 to ep=
 0x1
May 21 11:01:41 um773arch kernel: usb 1-2: 1:2: cannot set freq 48000 to ep=
 0x1
May 21 11:01:41 um773arch kernel: usb 1-2: 1:3: cannot set freq 96000 to ep=
 0x1
May 21 11:01:41 um773arch kernel: usb 1-2: 1:4: cannot set freq 96000 to ep=
 0x1
May 21 11:01:41 um773arch kernel: usb 1-2: 1:5: cannot set freq 48000 to ep=
 0x1
May 21 11:01:41 um773arch kernel: usb 1-2: 2:1: cannot set freq 48000 to ep=
 0x82
May 21 11:01:41 um773arch kernel: usb 1-2: 7:0: cannot get min/max
values for control 2 (id 7)
May 21 11:01:41 um773arch kernel: usb 1-2: 5:0: cannot get min/max
values for control 2 (id 5)
May 21 11:01:41 um773arch kernel: usb 1-2: 6:0: cannot get min/max
values for control 2 (id 6)
May 21 11:01:41 um773arch (udev-worker)[453]: controlC0:
/usr/lib/udev/rules.d/78-sound-card.rules:5 Failed to write
ATTR{/sys/devices/pci0000:00/0000:00:03.1/0000:04:00.0/0000:05:01.0/0000:07=
:00.0/usb3/3-1/3-1:1.0/sound/card0/controlC0/../uevent},
ignoring: No such file or directory
May 21 11:01:42 um773arch (udev-worker)[440]: controlC1:
/usr/lib/udev/rules.d/78-sound-card.rules:5 Failed to write
ATTR{/sys/devices/pci0000:00/0000:00:03.1/0000:04:00.0/0000:05:00.0/0000:06=
:00.0/usb1/1-2/1-2:1.0/sound/card1/controlC1/../uevent},
ignoring: No such file or directory
May 21 11:01:43 um773arch kernel: hid-generic 0003:0D8C:0134.000A: No
inputs registered, leaving

On Tue, May 21, 2024 at 10:55=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Tue, May 21, 2024 at 10:07:23AM +0200, Gia wrote:
> > Thank you Mika,
> >
> > Here you have the output of sudo journalctl -k without enabling the
> > kernel option "pcie_aspm=3Doff": https://codeshare.io/7JPgpE. Without
> > "pcie_aspm=3Doff", "thunderbolt.host_reset=3Dfalse" is not needed, my
> > thunderbolt dock does work. I also connected a 4k monitor to the
> > thunderbolt dock thinking it could provide more data.
> >
> > I'm almost sure I used this option when I set up this system because
> > it solved some issues with system suspending, but it happened many
> > months ago.
>
> Okay. I recommend not to use it. The defaults should always be the best
> option (unless you really know what you are doing or working around some
> issue).
>
> The dmesg you shared looks good, there are few oddities but they should
> not matter from functional perspective (unless you are planning to have
> a second monitor connected).
>
> First is this:
>
>   May 21 09:59:40 um773arch kernel: thunderbolt 0000:36:00.5: IOMMU DMA p=
rotection is disabled
>
> It should really be enabled but I'm not familiar with AMD hardware to
> tell more so hoping Mario can comment on that.
>
> The second thing is the USB4 link that seems to be degraded to 2x10G =3D
> 20G even though you say it is a Thunderbolt cable. I'll comment more on
> that in the other email.

