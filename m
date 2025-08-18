Return-Path: <stable+bounces-169944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD37B29E2B
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494EE1884E15
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 09:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05E930E0EC;
	Mon, 18 Aug 2025 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6SEl1Ov"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C510830DEAA
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 09:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510042; cv=none; b=q9rfyVE0epwJfuuB+nQs3EOrOToayffvRwhWJz8IbH0KsYFzQxlLAo7s0dllzdiNuUz+5F787QN3+uHmFYTek8RqxbbxLpppoOybaYYv2DIH8AGwQHced7CKVQf+DEXzm2q2qrVAQEmRj1rcaWeY5U/jkkN6Z2i/G4BQRpFjXOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510042; c=relaxed/simple;
	bh=E5z6JZEgA9pmfBC3vwJjoOA56o/5LuBItI88S/53DZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbTphmslf/B421iS3QpPYbx/SpZlOZkQ+V8em1wXh1lU4hVIkB0UiriN3Bh9XykKuS9vzTJ/Q6DcPinMyC2twS3XiWRSGlV5gcuzVYg8MA/Yjmy0OecAob8I09UW/UtYvAe4NkPoISLhSPZc4SZIiKZ4k45fO9sJuiDXsfuN7LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6SEl1Ov; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-618b62dba1aso3249522a12.2
        for <stable@vger.kernel.org>; Mon, 18 Aug 2025 02:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755510039; x=1756114839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULtP4TPRiwLFVgdH9tMF4FKUEQSjydA2syIDemXrgs4=;
        b=I6SEl1OvEfbf3fvcz4Ujooi6FyEnw4LCJCR3wXgMQVrWWn0kD0tzVOt2ZwXh/WStE7
         n93X8qfKeyOd5BiD5OCCf8QGgXklfrnNl1B1e4cjnjw4goDvfVO84xVEQ/Y3x9ua1hMv
         7g9P5lOe7lj9Lu86wn6bs4QvfqIlK7hwhQXPftG8Vfb4nnIOHMA7SfJge0BpgYNglpQD
         127pjXhP77aHxrxPDOO5x1cRxdd1ljVfxrGEMkKa4y5kynEzVs2JNlIfUUCrZrXIwZdP
         pS9U/OUWaJ94H/Z2WMfd0Lxf4/VEpGQWCS6lf2Nj4WttiXABJZCccVM1m0+aiEoTJY2u
         Q2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755510039; x=1756114839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULtP4TPRiwLFVgdH9tMF4FKUEQSjydA2syIDemXrgs4=;
        b=P5igxtj4waYPazpgVlGGqX8+6KSq9nWmj/9HNzO7lIPYNdiYBE9BHxwLWRiNDqErFI
         4PxQbXLTOxONnuyLCrUbqhdmrU9wPo8Dzu/F+0D5UdKN/kLxiA5/jN7t+7e73pQBrCrH
         516AVmawOejR5n9ycfZf/FkKVYBX/0kVR5fr3+mXSQqsyQgquGhvYNGZDEOSv3e/NNP6
         y9zwMyhzHnS7/+1edH8KG6GiTcoOeFVkRjZ0XaNZAfMzm8KAy9YomFrk9s1ctTrPcNp6
         dLc4j0eFJuQ3Fto3WZObzQxT4XG8tMJJPqW/vUSsSoonk7kgz3CKcERLrxti2hQNUtHr
         XHvA==
X-Forwarded-Encrypted: i=1; AJvYcCUOJkNkKqKpuiOygu+LB1SzxGfT8yFTeqtJNcIH5r73rsgF0pV2xYJxCRVZUoQEOO0nykmE0xM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFkokJUTWtun/EW46qCSaAevsrx3WWy9GuO8PC7TiWresdNE9o
	JWyvYjw5EmN2gpEaoinLrmu+VagHKRjTF4MUEuDy8kvTrkMiGWYB9+tdBTQj512UifUvFqM8puB
	+XMjBNKuU40tdQkkKNxYoIxwRO7UYNzM=
X-Gm-Gg: ASbGncsuYlFBxfG7q6/1UqgLw2QTsb2LsJEsSa6Wht33AmIOx3hWv0Nekllcm9ARoaS
	tV5GiiTLK4spc2SGCIZyOjlYdo329921I8fPIncMQlv70NxOo82yme4t/5VgFqlLpIsDITM7LRZ
	2/y9enuXHFirvdNN8qBKZkNB6KjSbT233X6C2XYG6KulN+5nv6I4A9nfCcFqr4hD9NhRLGMIEDK
	LW2EMIGLw==
X-Google-Smtp-Source: AGHT+IF8KA/khkHfW1zM5A6VICcLQcaTlNP2NaY79413IWzC7ZXQoMbtUjB4YFC1WmKSdkoLWnGX/LuUFnS7Ou+6WdM=
X-Received: by 2002:a05:6402:2686:b0:618:6af8:3f71 with SMTP id
 4fb4d7f45d1cf-618b05322cfmr8012966a12.9.1755510038754; Mon, 18 Aug 2025
 02:40:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJmAMMyOk7AVqQRrtK4Oum2uVKreGeLJ943-kkRCTspoGApZ8w@mail.gmail.com>
 <CAJmAMMyt5QQQOavVy+Gytf00Y0F6G+GCLYhj0E9RZ8cV85gwCw@mail.gmail.com>
 <10850475be9302b5b397173c1d4554335c0df966.camel@mediatek.com>
 <CAJmAMMxtH+WnJfU2tcHRxP472cnyM4cZ7vaTcZN0NSxQ6U5HCg@mail.gmail.com>
 <CAJmAMMzYkoVWq2w4UCdyF1x2huwtcbW37RyKiDiCR9pmACdDuQ@mail.gmail.com> <a28a7735e9ac1bdebb7b2e875c7c8433c40f7e38.camel@mediatek.com>
In-Reply-To: <a28a7735e9ac1bdebb7b2e875c7c8433c40f7e38.camel@mediatek.com>
From: Tal Inbar <inbartdev@gmail.com>
Date: Mon, 18 Aug 2025 12:40:27 +0300
X-Gm-Features: Ac12FXxMCu7eSzBQVb_UY0JnTLwZiuEPdhH3wExn75Hp4TUW0Ygum7_B1H-rsCM
Message-ID: <CAJmAMMx7u9Zf4yMvV9KMz25SLrLx+MRHPRmhJZCn+iBqo+kp6w@mail.gmail.com>
Subject: Re: [REGRESSION] [BISECTED] MT7925 wireless speed drops to zero since
 kernel 6.14.3 - wifi: mt76: mt7925: integrate *mlo_sta_cmd and *sta_cmd
To: =?UTF-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?= <Mingyen.Hsieh@mediatek.com>
Cc: Sean Wang <Sean.Wang@mediatek.com>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, =?UTF-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?= <Allan.Wang@mediatek.com>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, 
	=?UTF-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>, 
	"nbd@nbd.name" <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Indeed as discussed privately, the aforementioned patch fixes the issue.

Thanks,
Tal

On Mon, Aug 18, 2025 at 6:22=E2=80=AFAM Mingyen Hsieh (=E8=AC=9D=E6=98=8E=
=E8=AB=BA)
<Mingyen.Hsieh@mediatek.com> wrote:
>
> On Thu, 2025-08-14 at 14:55 +0300, Tal Inbar wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >
> >
> > Hi Mingyen,
> >
> > I've collected some of my Routers' configuration information which
> > I'll share with you in a private email message.
> >
> > Tal
> >
> > On Mon, Aug 11, 2025 at 12:08=E2=80=AFPM Tal Inbar <inbartdev@gmail.com=
>
> > wrote:
> > >
> > > Hi Mingyen,
> > >
> > > I'll see what I can gather and I'll let you know.
> > >
> > > Tal
> > >
> > > On Mon, Aug 11, 2025 at 4:47=E2=80=AFAM Mingyen Hsieh (=E8=AC=9D=E6=
=98=8E=E8=AB=BA)
> > > <Mingyen.Hsieh@mediatek.com> wrote:
> > > >
> > > > On Fri, 2025-08-08 at 17:37 +0300, Tal Inbar wrote:
> > > > >
> > > > > External email : Please do not click links or open attachments
> > > > > until
> > > > > you have verified the sender or the content.
> > > > >
> > > > >
> > > > > typo, laptop model is:
> > > > > Lenovo IdeaPad Slim 5 16AKP10
> > > > >
> > > > > On Fri, Aug 8, 2025 at 4:14=E2=80=AFPM Tal Inbar <inbartdev@gmail=
.com>
> > > > > wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > Since kernel v6.14.3, when using wireless to connect to my
> > > > > > home
> > > > > > router
> > > > > > on my laptop, my wireless connection slows down to unusable
> > > > > > speeds.
> > > > > >
> > > > > >
> > > > > > More specifically, since kernel 6.14.3, when connecting to
> > > > > > the
> > > > > > wireless networks of my OpenWRT Router on my Lenovo IdeaPad
> > > > > > Slim 15
> > > > > > 16AKP10 laptop,
> > > > > > either a 2.4ghz or a 5ghz network, the connection speed drops
> > > > > > down
> > > > > > to
> > > > > > 0.1-0.2 Mbps download and 0 Mbps upload when measured using
> > > > > > speedtest-cli.
> > > > > > My laptop uses an mt7925 chip according to the loaded driver
> > > > > > and
> > > > > > firmware.
> > > > > >
> > > > > >
> > > > > > Detailed Description:
> > > > > >
> > > > > > As mentioned above, my wireless connection becomes unusable
> > > > > > when
> > > > > > using
> > > > > > linux 6.14.3 and above, dropping speeds to almost 0 Mbps,
> > > > > > even when standing next to my router. Further, pinging
> > > > > > archlinux.org
> > > > > > results in "Temporary failure in name resolution".
> > > > > > Any other wireless device in my house can successfully
> > > > > > connect to
> > > > > > my
> > > > > > router and properly use the internet with good speeds, eg.
> > > > > > iphones,
> > > > > > ipads, raspberry pi and a windows laptop.
> > > > > > When using my Lenovo laptop on a kernel 6.14.3 or higher to
> > > > > > connect
> > > > > > to
> > > > > > other access points, such as my iPhone's hotspot and some
> > > > > > TPLink
> > > > > > and
> > > > > > Zyxel routers - the connection speed is good, and there are
> > > > > > no
> > > > > > issues,
> > > > > > which makes me believe there's something going on with my
> > > > > > OpenWRT
> > > > > > configuration in conjunction with a commit introduced on
> > > > > > kernel
> > > > > > 6.14.3
> > > > > > for the mt7925e module as detailed below.
> > > > > >
> > > > > > I have followed a related issue previously reported on the
> > > > > > mailing
> > > > > > list regarding a problem with the same wifi chip on kernel
> > > > > > 6.14.3,
> > > > > > but
> > > > > > the merged fix doesn't seem to fix my problem:
> > > > > > https://lore.kernel.org/linux-mediatek/EmWnO5b-acRH1TXbGnkx41eJ=
w654vmCR-8_xMBaPMwexCnfkvKCdlU5u19CGbaapJ3KRu-l3B-tSUhf8CCQwL0odjo6Cd5YG5lv=
NeB-vfdg=3D@pm.me/
> > > > > >
> > > > > > I've tested stable builds of 6.15 as well up to 6.15.9 in the
> > > > > > last
> > > > > > month, which also do not fix the problem.
> > > > > > I've also built and bisected v6.14 on june using guides on
> > > > > > the Arch
> > > > > > Linux wiki, for the following bad commit, same as the
> > > > > > previously
> > > > > > mentioned reported issue:
> > > > > >
> > > > > > [80007d3f92fd018d0a052a706400e976b36e3c87] wifi: mt76:
> > > > > > mt7925:
> > > > > > integrate *mlo_sta_cmd and *sta_cmd
> > > > > >
> > > > > > Testing further this week, I cloned mainline after 6.16 was
> > > > > > released,
> > > > > > built and tested it, and the issue still persists.
> > > > > > I reverted the following commits on mainline and retested, to
> > > > > > successfully see good wireless speeds:
> > > > > >
> > > > > > [0aa8496adda570c2005410a30df963a16643a3dc] wifi: mt76:
> > > > > > mt7925: fix
> > > > > > missing hdr_trans_tlv command for broadcast wtbl
> > > > > > [cb1353ef34735ec1e5d9efa1fe966f05ff1dc1e1] wifi: mt76:
> > > > > > mt7925:
> > > > > > integrate *mlo_sta_cmd and *sta_cmd
> > > > > >
> > > > > > Then, reverting *only*
> > > > > > 0aa8496adda570c2005410a30df963a16643a3dc
> > > > > > causes
> > > > > > the issue to reproduce, which confirms the issue is caused by
> > > > > > commit
> > > > > > cb1353ef34735ec1e5d9efa1fe966f05ff1dc1e1 on mainline.
> > > > > >
> > > > > > I've attached the following files to a bugzilla ticket:
> > > > > >
> > > > > > - lspci -nnk output:
> > > > > > https://urldefense.com/v3/__https://bugzilla.kernel.org/attachm=
ent.cgi?id=3D308466__;!!CTRNKA9wMg0ARbw!gTAaJeIN6s3eF_Kp6U3iwfv0wCCO_BVcRkN=
VpJYnwR8qeqIIh134mEJ5dxdeNqzuWSPF2ocLAt43LxaBTIY-7w$
> > > > > >
> > > > > > - dmesg output:
> > > > > > https://urldefense.com/v3/__https://bugzilla.kernel.org/attachm=
ent.cgi?id=3D308465__;!!CTRNKA9wMg0ARbw!gTAaJeIN6s3eF_Kp6U3iwfv0wCCO_BVcRkN=
VpJYnwR8qeqIIh134mEJ5dxdeNqzuWSPF2ocLAt43LxY1pkjZCA$
> > > > > >
> > > > > > - .config for the built mainline kernel:
> > > > > > https://urldefense.com/v3/__https://bugzilla.kernel.org/attachm=
ent.cgi?id=3D308467__;!!CTRNKA9wMg0ARbw!gTAaJeIN6s3eF_Kp6U3iwfv0wCCO_BVcRkN=
VpJYnwR8qeqIIh134mEJ5dxdeNqzuWSPF2ocLAt43LxYcu-Db2g$
> > > > > >
> > > > > >
> > > > > > More information:
> > > > > >
> > > > > > OS Distribution: Arch Linux
> > > > > >
> > > > > > Linux build information from /proc/version:
> > > > > > Linux version 6.16.0linux-mainline-11853-g21be711c0235
> > > > > > (tal@arch-debug) (gcc (GCC) 15.1.1 20250729, GNU ld (GNU
> > > > > > Binutils)
> > > > > > 2.45.0) #3 SMP PREEMPT_DYNAMIC
> > > > > >
> > > > > > OpenWRT Version on my Router: 24.10.2
> > > > > >
> > > > > > Laptop Hardware:
> > > > > > - Lenovo IdeaPad Slim 15 16AKP10 laptop (x86_64 Ryzen AI 350
> > > > > > CPU)
> > > > > > - Network device as reported by lscpi: 14c3:7925
> > > > > > - Network modules and driver in use: mt7925e
> > > > > > - mediatek chip firmware as of dmesg:
> > > > > >   HW/SW Version: 0x8a108a10, Build Time: 20250526152947a
> > > > > >   WM Firmware Version: ____000000, Build Time: 20250526153043
> > > > > >
> > > > > >
> > > > > > Referencing regzbot:
> > > > > >
> > > > > > #regzbot introduced: 80007d3f92fd018d0a052a706400e976b36e3c87
> > > > > >
> > > > > >
> > > > > > Please let me know if any other information is needed, or if
> > > > > > there
> > > > > > is
> > > > > > anything else that I can test on my end.
> > > > > >
> > > > > > Thanks,
> > > > > > Tal Inbar
> > > >
> > > > Hi,
> > > >
> > > > Can you capture a sniffer log? There should be some configuration
> > > > differences that we can identify from the packet frames during
> > > > the
> > > > connection process. So please provide the sniffer logs when
> > > > connecting
> > > > to your OpenWRT, TPLink, and Zyxel.
> > > >
> > > > Or you can check for any configuration differences between
> > > > OpenWRT and
> > > > the other routers, which might also help with debugging.
> > > >
> > > > Thanks~
> > > >
> > > > Yen.
> > > >
> > > >
> > > > *********** MEDIATEK Confidentiality Notice
> > > >  ***********
> > > > The information contained in this e-mail message (including any
> > > > attachments) may be confidential, proprietary, privileged, or
> > > > otherwise exempt from disclosure under applicable laws. It is
> > > > intended to be conveyed only to the designated recipient(s). Any
> > > > use, dissemination, distribution, printing, retaining or copying
> > > > of this e-mail (including its attachments) by unintended
> > > > recipient(s)
> > > > is strictly prohibited and may be unlawful. If you are not an
> > > > intended recipient of this e-mail, or believe that you have
> > > > received
> > > > this e-mail in error, please notify the sender immediately
> > > > (by replying to this e-mail), delete any and all copies of this
> > > > e-mail (including any attachments) from your system, and do not
> > > > disclose the content of this e-mail to any other person. Thank
> > > > you!
>
> Hi,
>
> As we discussion on the private mail, this issue has been fixed at this
> patch:
> https://patchwork.kernel.org/project/linux-wireless/patch/20250818030201.=
997940-1-mingyen.hsieh@mediatek.com/
>
> Thanks.
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

