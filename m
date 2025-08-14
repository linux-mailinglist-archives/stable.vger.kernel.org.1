Return-Path: <stable+bounces-169532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC43B264C7
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 13:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3903C7AC8AF
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 11:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448142EAB9D;
	Thu, 14 Aug 2025 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQpC2S77"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D57E2FB965
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 11:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755172562; cv=none; b=HRSd8GFZ2oKLT0Mez/n/fjV7ncTP+2zyv6G2Vw6vW8i2o5T/6vME8mM5sIbwrCiX4X76dwZVELm8zFxx7jBF8RWlObIAb7qQBi6U2qksM5SjdGxoT2IDrKa+OnXotfM+OlCbFxREEK6Ui1uSiManZg1R27InYASI+Iu1p0MhGrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755172562; c=relaxed/simple;
	bh=ydtlsBkAUr4SHMqutR1buO4GbWXN3n6bbjZJT1XhPWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bkIgENcqq4ONkbYo6orLVLKEdlscpB4qgxVDned97dlu1jK+zeyUuXWS0eYlNtrM7HzKEs5jloGWc0V4/11ybkKf6o0OoZUcG+KkLbhfVPMWwU+EuPCKoak8ie6BwjVTaHL6ZrMEoJQBLIPX0Y966I54gFH1aFrE2yurN7dELvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQpC2S77; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6188b65a2f0so1545324a12.1
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 04:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755172558; x=1755777358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tb315cmtvC7XRKPOkvyrzytTN46nIxubLRXMz5iL+MY=;
        b=FQpC2S77hVQ2BnCO71k9Nd/m40a89LmS44SEAB9aXCtHVqHMZPt7q1bqS+VzDucAKq
         L/w9UyO+YPw32sbwlWMM+E67w1t/n812E+TUgjF9wMIwautLDWK4puCTuUwgNpHbv+QU
         dhqDItSZAeE1L7lupshkmL6B/HAxFK37SUBxonj1pMpSI86TjUMPF66C6V2sUrEmi/M5
         44HiblfFr9iLQfbprO5XbaC9j7Earr92xWXGAtYUoCPJBWpFJ060xRU1YGWQsJlQqsTl
         WJ0NDmbu18fmzv8VAlYsgs6UbdZphwTJB2fOZdEy963l/j5bpYZhpPnLDLPLul+E353o
         vL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755172558; x=1755777358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tb315cmtvC7XRKPOkvyrzytTN46nIxubLRXMz5iL+MY=;
        b=tk9qeUIGVBpon9F9KFnacd54DKEowXjvUyF7tfthCXcnMcfA1mN9UppzVWNfRRMmr0
         RKkeZBEoGNf8kZDdbAiL2M+G9EqSrU3rqt+JY4ogCJSH1Vql/7j30b7A1G5+RXnmQ3fE
         /DIZZI8a4yv1qM6/2KYm4LwEctqePJH5iHF7X/wKV+QTjt0xSJ5BNILsSoI2eOMWoPQv
         RD++DmmoIJcHGr6EXjZFrn6UasErXBNDeVNWVaHbTPq/ThCLsX2dyDqZJyQ6DabeRH+X
         bXppB7wGKFIZ286M/dSRcsTQElH3ClwbT7zul6ng/1IpSIceXyhKqGuPl78tZwGOqx1v
         LdIw==
X-Forwarded-Encrypted: i=1; AJvYcCU0mNwxh8nW/TGSwUzfrVv4BtiDv3Aqg9oSUGgHjDh58dvR82p0mpnBLT1/NGFeyfjXsUqjp/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXS8OS2KNhl1lHVOpUO2mzhSW12pg5HMJ9Ot3vC+5pOwkeYq1U
	agUc6CxwP6/qYDNdAHLtKqF26vMjyKm4Pe+3/7lgx7A8pBIWWuPdpf920lBkgO3hqBUrBFZOp90
	P0Zwk/0FBRTteTSL6MW6cVfGgQ5x65n4=
X-Gm-Gg: ASbGnctuOGHGzMSn0UdChn/txJcxi4IJIrzS3C25qh8so/h0zHs4kJVF28g1KGTMVcZ
	BP68MqRaeUgg53hAogY8NU44YgJl1Pl1MAL2tBXWYdUXaDys/djRi1c0JhM8RX2tTuJbUo15fUo
	xVMpjGZptMCq32yE4qdPOA9+cDoCNoppmxC/PwIedf4F8Dh5fpDCJMlm2pTR9jBZ8TRFPY+tOwj
	4pmYi03aQ==
X-Google-Smtp-Source: AGHT+IFrvGlyyUa4/Eu4Vj5ie79bie0Z0kQT3gWwNEi9fvArmWk7nAaceJDjE9bqa4GntjTYG3K8gVLiOM5WSvemVI4=
X-Received: by 2002:a05:6402:13c7:b0:618:196b:1f8a with SMTP id
 4fb4d7f45d1cf-618911a7eb0mr2297174a12.4.1755172558047; Thu, 14 Aug 2025
 04:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJmAMMyOk7AVqQRrtK4Oum2uVKreGeLJ943-kkRCTspoGApZ8w@mail.gmail.com>
 <CAJmAMMyt5QQQOavVy+Gytf00Y0F6G+GCLYhj0E9RZ8cV85gwCw@mail.gmail.com>
 <10850475be9302b5b397173c1d4554335c0df966.camel@mediatek.com> <CAJmAMMxtH+WnJfU2tcHRxP472cnyM4cZ7vaTcZN0NSxQ6U5HCg@mail.gmail.com>
In-Reply-To: <CAJmAMMxtH+WnJfU2tcHRxP472cnyM4cZ7vaTcZN0NSxQ6U5HCg@mail.gmail.com>
From: Tal Inbar <inbartdev@gmail.com>
Date: Thu, 14 Aug 2025 14:55:46 +0300
X-Gm-Features: Ac12FXzL763y85w5TLRnSxTOv88UagtlDVl64Ouyp_ebALHCLfT1LPFzZnOagHY
Message-ID: <CAJmAMMzYkoVWq2w4UCdyF1x2huwtcbW37RyKiDiCR9pmACdDuQ@mail.gmail.com>
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

I've collected some of my Routers' configuration information which
I'll share with you in a private email message.

Tal

On Mon, Aug 11, 2025 at 12:08=E2=80=AFPM Tal Inbar <inbartdev@gmail.com> wr=
ote:
>
> Hi Mingyen,
>
> I'll see what I can gather and I'll let you know.
>
> Tal
>
> On Mon, Aug 11, 2025 at 4:47=E2=80=AFAM Mingyen Hsieh (=E8=AC=9D=E6=98=8E=
=E8=AB=BA)
> <Mingyen.Hsieh@mediatek.com> wrote:
> >
> > On Fri, 2025-08-08 at 17:37 +0300, Tal Inbar wrote:
> > >
> > > External email : Please do not click links or open attachments until
> > > you have verified the sender or the content.
> > >
> > >
> > > typo, laptop model is:
> > > Lenovo IdeaPad Slim 5 16AKP10
> > >
> > > On Fri, Aug 8, 2025 at 4:14=E2=80=AFPM Tal Inbar <inbartdev@gmail.com=
> wrote:
> > > >
> > > > Hi,
> > > >
> > > > Since kernel v6.14.3, when using wireless to connect to my home
> > > > router
> > > > on my laptop, my wireless connection slows down to unusable speeds.
> > > >
> > > >
> > > > More specifically, since kernel 6.14.3, when connecting to the
> > > > wireless networks of my OpenWRT Router on my Lenovo IdeaPad Slim 15
> > > > 16AKP10 laptop,
> > > > either a 2.4ghz or a 5ghz network, the connection speed drops down
> > > > to
> > > > 0.1-0.2 Mbps download and 0 Mbps upload when measured using
> > > > speedtest-cli.
> > > > My laptop uses an mt7925 chip according to the loaded driver and
> > > > firmware.
> > > >
> > > >
> > > > Detailed Description:
> > > >
> > > > As mentioned above, my wireless connection becomes unusable when
> > > > using
> > > > linux 6.14.3 and above, dropping speeds to almost 0 Mbps,
> > > > even when standing next to my router. Further, pinging
> > > > archlinux.org
> > > > results in "Temporary failure in name resolution".
> > > > Any other wireless device in my house can successfully connect to
> > > > my
> > > > router and properly use the internet with good speeds, eg. iphones,
> > > > ipads, raspberry pi and a windows laptop.
> > > > When using my Lenovo laptop on a kernel 6.14.3 or higher to connect
> > > > to
> > > > other access points, such as my iPhone's hotspot and some TPLink
> > > > and
> > > > Zyxel routers - the connection speed is good, and there are no
> > > > issues,
> > > > which makes me believe there's something going on with my OpenWRT
> > > > configuration in conjunction with a commit introduced on kernel
> > > > 6.14.3
> > > > for the mt7925e module as detailed below.
> > > >
> > > > I have followed a related issue previously reported on the mailing
> > > > list regarding a problem with the same wifi chip on kernel 6.14.3,
> > > > but
> > > > the merged fix doesn't seem to fix my problem:
> > > > https://lore.kernel.org/linux-mediatek/EmWnO5b-acRH1TXbGnkx41eJw654=
vmCR-8_xMBaPMwexCnfkvKCdlU5u19CGbaapJ3KRu-l3B-tSUhf8CCQwL0odjo6Cd5YG5lvNeB-=
vfdg=3D@pm.me/
> > > >
> > > > I've tested stable builds of 6.15 as well up to 6.15.9 in the last
> > > > month, which also do not fix the problem.
> > > > I've also built and bisected v6.14 on june using guides on the Arch
> > > > Linux wiki, for the following bad commit, same as the previously
> > > > mentioned reported issue:
> > > >
> > > > [80007d3f92fd018d0a052a706400e976b36e3c87] wifi: mt76: mt7925:
> > > > integrate *mlo_sta_cmd and *sta_cmd
> > > >
> > > > Testing further this week, I cloned mainline after 6.16 was
> > > > released,
> > > > built and tested it, and the issue still persists.
> > > > I reverted the following commits on mainline and retested, to
> > > > successfully see good wireless speeds:
> > > >
> > > > [0aa8496adda570c2005410a30df963a16643a3dc] wifi: mt76: mt7925: fix
> > > > missing hdr_trans_tlv command for broadcast wtbl
> > > > [cb1353ef34735ec1e5d9efa1fe966f05ff1dc1e1] wifi: mt76: mt7925:
> > > > integrate *mlo_sta_cmd and *sta_cmd
> > > >
> > > > Then, reverting *only* 0aa8496adda570c2005410a30df963a16643a3dc
> > > > causes
> > > > the issue to reproduce, which confirms the issue is caused by
> > > > commit
> > > > cb1353ef34735ec1e5d9efa1fe966f05ff1dc1e1 on mainline.
> > > >
> > > > I've attached the following files to a bugzilla ticket:
> > > >
> > > > - lspci -nnk output:
> > > > https://urldefense.com/v3/__https://bugzilla.kernel.org/attachment.=
cgi?id=3D308466__;!!CTRNKA9wMg0ARbw!gTAaJeIN6s3eF_Kp6U3iwfv0wCCO_BVcRkNVpJY=
nwR8qeqIIh134mEJ5dxdeNqzuWSPF2ocLAt43LxaBTIY-7w$
> > > >
> > > > - dmesg output:
> > > > https://urldefense.com/v3/__https://bugzilla.kernel.org/attachment.=
cgi?id=3D308465__;!!CTRNKA9wMg0ARbw!gTAaJeIN6s3eF_Kp6U3iwfv0wCCO_BVcRkNVpJY=
nwR8qeqIIh134mEJ5dxdeNqzuWSPF2ocLAt43LxY1pkjZCA$
> > > >
> > > > - .config for the built mainline kernel:
> > > > https://urldefense.com/v3/__https://bugzilla.kernel.org/attachment.=
cgi?id=3D308467__;!!CTRNKA9wMg0ARbw!gTAaJeIN6s3eF_Kp6U3iwfv0wCCO_BVcRkNVpJY=
nwR8qeqIIh134mEJ5dxdeNqzuWSPF2ocLAt43LxYcu-Db2g$
> > > >
> > > >
> > > > More information:
> > > >
> > > > OS Distribution: Arch Linux
> > > >
> > > > Linux build information from /proc/version:
> > > > Linux version 6.16.0linux-mainline-11853-g21be711c0235
> > > > (tal@arch-debug) (gcc (GCC) 15.1.1 20250729, GNU ld (GNU Binutils)
> > > > 2.45.0) #3 SMP PREEMPT_DYNAMIC
> > > >
> > > > OpenWRT Version on my Router: 24.10.2
> > > >
> > > > Laptop Hardware:
> > > > - Lenovo IdeaPad Slim 15 16AKP10 laptop (x86_64 Ryzen AI 350 CPU)
> > > > - Network device as reported by lscpi: 14c3:7925
> > > > - Network modules and driver in use: mt7925e
> > > > - mediatek chip firmware as of dmesg:
> > > >   HW/SW Version: 0x8a108a10, Build Time: 20250526152947a
> > > >   WM Firmware Version: ____000000, Build Time: 20250526153043
> > > >
> > > >
> > > > Referencing regzbot:
> > > >
> > > > #regzbot introduced: 80007d3f92fd018d0a052a706400e976b36e3c87
> > > >
> > > >
> > > > Please let me know if any other information is needed, or if there
> > > > is
> > > > anything else that I can test on my end.
> > > >
> > > > Thanks,
> > > > Tal Inbar
> >
> > Hi,
> >
> > Can you capture a sniffer log? There should be some configuration
> > differences that we can identify from the packet frames during the
> > connection process. So please provide the sniffer logs when connecting
> > to your OpenWRT, TPLink, and Zyxel.
> >
> > Or you can check for any configuration differences between OpenWRT and
> > the other routers, which might also help with debugging.
> >
> > Thanks~
> >
> > Yen.
> >
> >
> > *********** MEDIATEK Confidentiality Notice
> >  ***********
> > The information contained in this e-mail message (including any
> > attachments) may be confidential, proprietary, privileged, or
> > otherwise exempt from disclosure under applicable laws. It is
> > intended to be conveyed only to the designated recipient(s). Any
> > use, dissemination, distribution, printing, retaining or copying
> > of this e-mail (including its attachments) by unintended recipient(s)
> > is strictly prohibited and may be unlawful. If you are not an
> > intended recipient of this e-mail, or believe that you have received
> > this e-mail in error, please notify the sender immediately
> > (by replying to this e-mail), delete any and all copies of this
> > e-mail (including any attachments) from your system, and do not
> > disclose the content of this e-mail to any other person. Thank you!

