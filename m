Return-Path: <stable+bounces-167011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C676B202B2
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 11:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8AD18C0B7E
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 09:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC84B2DEA93;
	Mon, 11 Aug 2025 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ytq+9a/a"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6953E2DEA87
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903317; cv=none; b=FoFCDbUTiQVTIJ7qwCRWP+A+gfY2DeHnfEg2bMabyMfdZ38w8EKHi82Aq5SN4Oun3hSy2LYPUBTMJe6OsDRBxF/QZsJ8zrKBcRgbPrnsOxRhB/A3kgzn3PLOCVJvHxSgymuGOgb/5VJrWxGLsOZnhhK+xuGQQmUzJXe9JUNl0o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903317; c=relaxed/simple;
	bh=GxSBTCNgd4eJENpfjoGCAFFcGIxRfntdX/fQersbJVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BF+pwEuQC7SCiR7Vgnr5sdfGbUFTD7K4JUeM9qJ+gbFfJCJo8Mw6Ce80ciF0Yaw7FWQAboxqRXHumcTVEqoOK+EPo8WfEiB5VAjAU1t1BjxdaP+RiFQW15IqBUpU4VXA6Ymcni2rBc0KZ3dhXb8uhANwbsr13p9z7FKe9vhlCWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ytq+9a/a; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-af93c3bac8fso581732566b.2
        for <stable@vger.kernel.org>; Mon, 11 Aug 2025 02:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754903314; x=1755508114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwHawNcF/JQ8X+Uy0Ve0MFsO6tqiI9dn3acsx3kJnRQ=;
        b=Ytq+9a/afd/vK1e8EQX2jCt3A+m9Ejm3s5V50WYnyZNV29UVEO2tiNjBaM8K4uSMT9
         w/9dZz2eIOambyjOAsfy+xyqUjfIxBBWMkUONNV+Bn12SF6ohnvzWLunS8coWNEx/zsj
         mTggzK182/jFKyNGsWK8ERZtxiC2qwx5DuZ56wNAcdn1qa3/ML/D+yrO/aoRtx/IOWiO
         65YSkPvSkwYBhJFJjPt47eALG9CpTP+rwVlM1XSaAUJkkJC3gS44x+u6kjhsfg75vg1i
         8nCtnagOzu94SzVj6ONG8Dmy9n/jcXbZH7K+bIYmtcmYHF42J9AFjpqL2Rx+T6C43p8/
         lq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754903314; x=1755508114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwHawNcF/JQ8X+Uy0Ve0MFsO6tqiI9dn3acsx3kJnRQ=;
        b=wvcQd6+X/7d3fZyvu2DUlL7UjLF2FRvnNh5D+sMj4l8ClO0ruMiPXmAsHVq8lkVM8U
         X8ZDuFzTro7pq1OyMaBGvnctT53XjEVRWk5g/uU9kXQ8hi6czQA/jwqzjMsfW5lvdZ0i
         CK2dU5QgcBGaFQItgDVaswG7hZ7XftVSZgMkXNFMtnoDlABv+WUbBTpZKfDWlH8PGidi
         vQvOBqpya+YHtV3bDoYRheBiL/wblGGUL1LjHfoOi1WnOcCBmvXrrAfQL0MRKFGs9kJV
         MJw+Uqf2aUnsVIrhXRfh5VDU1OML1IMHXCR5Kri7Dm1UCNBDlS1kOvqE9ZO1fl/MeHvF
         Kq3g==
X-Forwarded-Encrypted: i=1; AJvYcCXCKvfBQJxV5wecYTnneHXfmIb9SJSAhMBuc78Wov+WTAI06cLaucHH+fMFHjZulTvLDQT66z8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6gnFTKfMiTDxMqRJwiPg7URlRMLZdTKTJlgNoJ72K0jNtcEZy
	mvhqTvFEsCRGLkXrZO+GLAgZ0zIqTKb5mbcsXi64kQwuZRqvafYp1+QW0mA6Xb1zydnclh9xTpr
	+KAjx2asiu2ej32SQE2KCki0dDhzFWig=
X-Gm-Gg: ASbGnctSp4YgC3fklnNRhlxiVsoGxDz5ieWxyx4VPGulSeA0BdKEygzqqxLP33JwXXh
	13YpmFFLDj52fvxKYu0TsOBObc0C4ep5cbsChw3EGcFnzDpA95oq5LtBnE3K68EfeIPizw1MwoK
	k5JYXcNXyjIAtdlpWEhhHC49hcPklsPIW3vxLCnKGv2eyRq1JV05DeCEjP3igQG/FpX7xnKrz2W
	DKY6MEkng==
X-Google-Smtp-Source: AGHT+IGdt733GvWY5lAGoK+XbGYb2hLaYemZnckhDKBvkh4Fb3S8ppPlbLEYEw1YiRpusRegIQ+oXaTyXeg6ZsGhcWk=
X-Received: by 2002:a17:907:d89:b0:aec:6600:dbe3 with SMTP id
 a640c23a62f3a-af9c6544634mr1151954766b.56.1754903313414; Mon, 11 Aug 2025
 02:08:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJmAMMyOk7AVqQRrtK4Oum2uVKreGeLJ943-kkRCTspoGApZ8w@mail.gmail.com>
 <CAJmAMMyt5QQQOavVy+Gytf00Y0F6G+GCLYhj0E9RZ8cV85gwCw@mail.gmail.com> <10850475be9302b5b397173c1d4554335c0df966.camel@mediatek.com>
In-Reply-To: <10850475be9302b5b397173c1d4554335c0df966.camel@mediatek.com>
From: Tal Inbar <inbartdev@gmail.com>
Date: Mon, 11 Aug 2025 12:08:22 +0300
X-Gm-Features: Ac12FXxpDyTwSrfAbNsg-NT2mwV9frv3BhLyjLgyjeTQ1rashWaHY-G52WOJkz4
Message-ID: <CAJmAMMxtH+WnJfU2tcHRxP472cnyM4cZ7vaTcZN0NSxQ6U5HCg@mail.gmail.com>
Subject: Re: [REGRESSION] [BISECTED] MT7925 wireless speed drops to zero since
 kernel 6.14.3 - wifi: mt76: mt7925: integrate *mlo_sta_cmd and *sta_cmd
To: =?UTF-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?= <Mingyen.Hsieh@mediatek.com>
Cc: Sean Wang <Sean.Wang@mediatek.com>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, =?UTF-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?= <Allan.Wang@mediatek.com>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, 
	=?UTF-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mingyen,

I'll see what I can gather and I'll let you know.

Tal

On Mon, Aug 11, 2025 at 4:47=E2=80=AFAM Mingyen Hsieh (=E8=AC=9D=E6=98=8E=
=E8=AB=BA)
<Mingyen.Hsieh@mediatek.com> wrote:
>
> On Fri, 2025-08-08 at 17:37 +0300, Tal Inbar wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >
> >
> > typo, laptop model is:
> > Lenovo IdeaPad Slim 5 16AKP10
> >
> > On Fri, Aug 8, 2025 at 4:14=E2=80=AFPM Tal Inbar <inbartdev@gmail.com> =
wrote:
> > >
> > > Hi,
> > >
> > > Since kernel v6.14.3, when using wireless to connect to my home
> > > router
> > > on my laptop, my wireless connection slows down to unusable speeds.
> > >
> > >
> > > More specifically, since kernel 6.14.3, when connecting to the
> > > wireless networks of my OpenWRT Router on my Lenovo IdeaPad Slim 15
> > > 16AKP10 laptop,
> > > either a 2.4ghz or a 5ghz network, the connection speed drops down
> > > to
> > > 0.1-0.2 Mbps download and 0 Mbps upload when measured using
> > > speedtest-cli.
> > > My laptop uses an mt7925 chip according to the loaded driver and
> > > firmware.
> > >
> > >
> > > Detailed Description:
> > >
> > > As mentioned above, my wireless connection becomes unusable when
> > > using
> > > linux 6.14.3 and above, dropping speeds to almost 0 Mbps,
> > > even when standing next to my router. Further, pinging
> > > archlinux.org
> > > results in "Temporary failure in name resolution".
> > > Any other wireless device in my house can successfully connect to
> > > my
> > > router and properly use the internet with good speeds, eg. iphones,
> > > ipads, raspberry pi and a windows laptop.
> > > When using my Lenovo laptop on a kernel 6.14.3 or higher to connect
> > > to
> > > other access points, such as my iPhone's hotspot and some TPLink
> > > and
> > > Zyxel routers - the connection speed is good, and there are no
> > > issues,
> > > which makes me believe there's something going on with my OpenWRT
> > > configuration in conjunction with a commit introduced on kernel
> > > 6.14.3
> > > for the mt7925e module as detailed below.
> > >
> > > I have followed a related issue previously reported on the mailing
> > > list regarding a problem with the same wifi chip on kernel 6.14.3,
> > > but
> > > the merged fix doesn't seem to fix my problem:
> > > https://lore.kernel.org/linux-mediatek/EmWnO5b-acRH1TXbGnkx41eJw654vm=
CR-8_xMBaPMwexCnfkvKCdlU5u19CGbaapJ3KRu-l3B-tSUhf8CCQwL0odjo6Cd5YG5lvNeB-vf=
dg=3D@pm.me/
> > >
> > > I've tested stable builds of 6.15 as well up to 6.15.9 in the last
> > > month, which also do not fix the problem.
> > > I've also built and bisected v6.14 on june using guides on the Arch
> > > Linux wiki, for the following bad commit, same as the previously
> > > mentioned reported issue:
> > >
> > > [80007d3f92fd018d0a052a706400e976b36e3c87] wifi: mt76: mt7925:
> > > integrate *mlo_sta_cmd and *sta_cmd
> > >
> > > Testing further this week, I cloned mainline after 6.16 was
> > > released,
> > > built and tested it, and the issue still persists.
> > > I reverted the following commits on mainline and retested, to
> > > successfully see good wireless speeds:
> > >
> > > [0aa8496adda570c2005410a30df963a16643a3dc] wifi: mt76: mt7925: fix
> > > missing hdr_trans_tlv command for broadcast wtbl
> > > [cb1353ef34735ec1e5d9efa1fe966f05ff1dc1e1] wifi: mt76: mt7925:
> > > integrate *mlo_sta_cmd and *sta_cmd
> > >
> > > Then, reverting *only* 0aa8496adda570c2005410a30df963a16643a3dc
> > > causes
> > > the issue to reproduce, which confirms the issue is caused by
> > > commit
> > > cb1353ef34735ec1e5d9efa1fe966f05ff1dc1e1 on mainline.
> > >
> > > I've attached the following files to a bugzilla ticket:
> > >
> > > - lspci -nnk output:
> > > https://urldefense.com/v3/__https://bugzilla.kernel.org/attachment.cg=
i?id=3D308466__;!!CTRNKA9wMg0ARbw!gTAaJeIN6s3eF_Kp6U3iwfv0wCCO_BVcRkNVpJYnw=
R8qeqIIh134mEJ5dxdeNqzuWSPF2ocLAt43LxaBTIY-7w$
> > >
> > > - dmesg output:
> > > https://urldefense.com/v3/__https://bugzilla.kernel.org/attachment.cg=
i?id=3D308465__;!!CTRNKA9wMg0ARbw!gTAaJeIN6s3eF_Kp6U3iwfv0wCCO_BVcRkNVpJYnw=
R8qeqIIh134mEJ5dxdeNqzuWSPF2ocLAt43LxY1pkjZCA$
> > >
> > > - .config for the built mainline kernel:
> > > https://urldefense.com/v3/__https://bugzilla.kernel.org/attachment.cg=
i?id=3D308467__;!!CTRNKA9wMg0ARbw!gTAaJeIN6s3eF_Kp6U3iwfv0wCCO_BVcRkNVpJYnw=
R8qeqIIh134mEJ5dxdeNqzuWSPF2ocLAt43LxYcu-Db2g$
> > >
> > >
> > > More information:
> > >
> > > OS Distribution: Arch Linux
> > >
> > > Linux build information from /proc/version:
> > > Linux version 6.16.0linux-mainline-11853-g21be711c0235
> > > (tal@arch-debug) (gcc (GCC) 15.1.1 20250729, GNU ld (GNU Binutils)
> > > 2.45.0) #3 SMP PREEMPT_DYNAMIC
> > >
> > > OpenWRT Version on my Router: 24.10.2
> > >
> > > Laptop Hardware:
> > > - Lenovo IdeaPad Slim 15 16AKP10 laptop (x86_64 Ryzen AI 350 CPU)
> > > - Network device as reported by lscpi: 14c3:7925
> > > - Network modules and driver in use: mt7925e
> > > - mediatek chip firmware as of dmesg:
> > >   HW/SW Version: 0x8a108a10, Build Time: 20250526152947a
> > >   WM Firmware Version: ____000000, Build Time: 20250526153043
> > >
> > >
> > > Referencing regzbot:
> > >
> > > #regzbot introduced: 80007d3f92fd018d0a052a706400e976b36e3c87
> > >
> > >
> > > Please let me know if any other information is needed, or if there
> > > is
> > > anything else that I can test on my end.
> > >
> > > Thanks,
> > > Tal Inbar
>
> Hi,
>
> Can you capture a sniffer log? There should be some configuration
> differences that we can identify from the packet frames during the
> connection process. So please provide the sniffer logs when connecting
> to your OpenWRT, TPLink, and Zyxel.
>
> Or you can check for any configuration differences between OpenWRT and
> the other routers, which might also help with debugging.
>
> Thanks~
>
> Yen.
>
>
> *********** MEDIATEK Confidentiality Notice
>  ***********
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or
> otherwise exempt from disclosure under applicable laws. It is
> intended to be conveyed only to the designated recipient(s). Any
> use, dissemination, distribution, printing, retaining or copying
> of this e-mail (including its attachments) by unintended recipient(s)
> is strictly prohibited and may be unlawful. If you are not an
> intended recipient of this e-mail, or believe that you have received
> this e-mail in error, please notify the sender immediately
> (by replying to this e-mail), delete any and all copies of this
> e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!

