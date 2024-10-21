Return-Path: <stable+bounces-87030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B332E9A5ED1
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B89F28322E
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 08:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3F31E25E1;
	Mon, 21 Oct 2024 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="CkX8UPrO"
X-Original-To: stable@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A98F1E230F;
	Mon, 21 Oct 2024 08:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729499938; cv=none; b=O0vhLoq+FDwLOTuLr557V6tCnENM6lmsDLRWIYdoHnKFjVXVJV2djbTORuspqSpMnLbE9maLfwIiP6BTm1m4NcjL32ekjjW2O/VhbWXbiga4k8bSBAPIe0B5pW2fWEAsU1wQBwfYMOTup7vwudY2NaqG9h0nGJejMWR8+VrpEtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729499938; c=relaxed/simple;
	bh=s5jFVQoJMxYhV09/liMZzSutGBkfnEHUXdFHsEIC78s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o5llkETrevLxBwh4nefpofoGCVJyvpRAl0boFRVHLVM1cfIJrA+nyq6FH62hcAJa/fMILKt14yr2OLOc4G2L5goaQ1YyeG6YXPAACsuUyG+jyPgw1OT/CNa47StZUs4Y8jS9fCk4y7R90tshs0gOQyMkm7vu4BmCSk2+XhBZu9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=CkX8UPrO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49L8cmtI72151458, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729499928; bh=s5jFVQoJMxYhV09/liMZzSutGBkfnEHUXdFHsEIC78s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=CkX8UPrOYVfOMUYXCDJi0C0fl0FztDc3T73Jtx3oUVSdKRfhSMnan17YIZF9CuGu0
	 t72vo4IoiYvUp0evj+WQ+l/w5EzN7ImaINncQ/CrS2/vYs6VdM4fDQyPH80ZC3xam+
	 JyZH2Uk4S9JaaSMI8RYdb06Aw0m5FIwStxVIsIQXf75xh778x88xV9dbhb2ICekGnP
	 ZS5/NcLlHVJODsF2Y2gMw8VTOgFLGfIGAuq0b0IoP4OK3oRDUYkDcQTaDnE2KlfChs
	 rMhllmlYt9ruSyCAaNs4aYHo0/LNHz6g/LJKrh3HevJqWKYqfvCqg6VQh/qeowhoA0
	 q5vxjtE8/NDog==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49L8cmtI72151458
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 16:38:48 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 16:38:48 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 21 Oct 2024 16:38:48 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2]) by
 RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2%7]) with mapi id
 15.01.2507.035; Mon, 21 Oct 2024 16:38:48 +0800
From: Kailang <kailang@realtek.com>
To: Takashi Iwai <tiwai@suse.de>
CC: Dean Matthew Menezes <dean.menezes@utexas.edu>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>,
        Linux Sound System <linux-sound@vger.kernel.org>,
        Greg KH
	<gregkh@linuxfoundation.org>
Subject: RE: No sound on speakers X1 Carbon Gen 12
Thread-Topic: No sound on speakers X1 Carbon Gen 12
Thread-Index: AQHbIwVT/23eeZo4dEmkKtnQN51H6bKP5WWAgABb9wCAAJxEgP//e3+AgACHy9A=
Date: Mon, 21 Oct 2024 08:38:48 +0000
Message-ID: <18d07dccef894f4cb87b78dd548c5bdd@realtek.com>
References: <CAEkK70Tke7UxMEEKgRLMntSYeMqiv0PC8st72VYnBVQD-KcqVw@mail.gmail.com>
	<2024101613-giggling-ceremony-aae7@gregkh>
	<433b8579-e181-40e6-9eac-815d73993b23@leemhuis.info>
	<87bjzktncb.wl-tiwai@suse.de>
	<CAEkK70TAk26HFgrz4ZS0jz4T2Eu3LWcG-JD1Ov_2ffMp66oO-g@mail.gmail.com>
	<87cyjzrutw.wl-tiwai@suse.de>
	<CAEkK70T7NBRA1dZHBwAC7mNeXPo-dby4c7Nn=SYg0vzeHHt-1A@mail.gmail.com>
	<87ttd8jyu3.wl-tiwai@suse.de>
	<CAEkK70RAWRjRp6_=bSrecSXXMfnepC2P2YriaHUqicv5x5wJWw@mail.gmail.com>
	<87h697jl6c.wl-tiwai@suse.de>
	<CAEkK70TWL_me58QZXeJSq+=Ry3jA+CgZJttsgAPz1wP7ywqj6A@mail.gmail.com>
	<87ed4akd2a.wl-tiwai@suse.de>	<87bjzekcva.wl-tiwai@suse.de>
	<CAEkK70SgwaFNcxni2JUAfz7Ne9a_kdkdLRTOR53uhNzJkBQ3+A@mail.gmail.com>
	<877ca2j60l.wl-tiwai@suse.de>	<43fe74e10d1d470e80dc2ae937bc1a43@realtek.com>
 <87ldyh6eyu.wl-tiwai@suse.de>
In-Reply-To: <87ldyh6eyu.wl-tiwai@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

But this platform need to assign model ALC287_FIXUP_LENOVO_THKPAD_WH_ALC131=
8.
It has a chance to broken amp IC.
But I don't know why it doesn't have output from speaker.
Maybe could run hda_verb to get COEF value. To get NID 0x5A index 0 value.

> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Monday, October 21, 2024 4:24 PM
> To: Kailang <kailang@realtek.com>
> Cc: Takashi Iwai <tiwai@suse.de>; Dean Matthew Menezes
> <dean.menezes@utexas.edu>; stable@vger.kernel.org;
> regressions@lists.linux.dev; Jaroslav Kysela <perex@perex.cz>; Takashi Iw=
ai
> <tiwai@suse.com>; Linux Sound System <linux-sound@vger.kernel.org>; Greg
> KH <gregkh@linuxfoundation.org>
> Subject: Re: No sound on speakers X1 Carbon Gen 12
>=20
>=20
> External mail.
>=20
>=20
>=20
> On Mon, 21 Oct 2024 10:19:53 +0200,
> Kailang wrote:
> >
> > Change to below model.
> > +     SND_PCI_QUIRK(0x17aa, 0x231e, "Thinkpad",
> ALC287_FIXUP_THINKPAD_I2S_SPK),
> > +     SND_PCI_QUIRK(0x17aa, 0x231f, "Thinkpad",
> > + ALC287_FIXUP_THINKPAD_I2S_SPK),
> >
> > The speaker will have output. Right?
>=20
> FWIW, that was what I asked in
>   https://lore.kernel.org/87h697jl6c.wl-tiwai@suse.de
> and Dean replied that the speaker worked with it.
> (His reply missed Cc, so it didn't appear in the thread, unfortunately).
>=20
>=20
> Takashi
>=20
> > > -----Original Message-----
> > > From: Takashi Iwai <tiwai@suse.de>
> > > Sent: Monday, October 21, 2024 2:59 PM
> > > To: Dean Matthew Menezes <dean.menezes@utexas.edu>
> > > Cc: Takashi Iwai <tiwai@suse.de>; Kailang <kailang@realtek.com>;
> > > stable@vger.kernel.org; regressions@lists.linux.dev; Jaroslav Kysela
> > > <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; Linux Sound System
> > > <linux-sound@vger.kernel.org>; Greg KH <gregkh@linuxfoundation.org>
> > > Subject: Re: No sound on speakers X1 Carbon Gen 12
> > >
> > >
> > > External mail.
> > >
> > >
> > >
> > > On Mon, 21 Oct 2024 03:30:13 +0200,
> > > Dean Matthew Menezes wrote:
> > > >
> > > > I can confirm that the original fix does not bring back the
> > > > speaker output.  I have attached both outputs for alsa-info.sh
> > >
> > > Thanks!  This confirms that the only significant difference is the
> > > COEF data between working and patched-non-working cases.
> > >
> > > Kailang, I guess this model (X1 Carbon Gen 12) isn't with ALC1318,
> > > hence your quirk rather influences badly.  Or may the GPIO3
> > > workaround have the similar effect?
> > >
> > > As of now, the possible fix is to simply remove the quirk entries for
> ALC1318.
> > > But I'd need to know which model was targeted for your original fix
> > > in commit
> > > 1e707769df07 and whether the regressed model is with ALC1318.
> > >
> > >
> > > Takashi

