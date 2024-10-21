Return-Path: <stable+bounces-87033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 870F59A5F95
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F290B1F236B8
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 08:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4002C1E2603;
	Mon, 21 Oct 2024 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="m18TV+jM"
X-Original-To: stable@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FD5200CD;
	Mon, 21 Oct 2024 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729501152; cv=none; b=mLLSGWEJ6TBfPhhy79aKLQdd4pL6RjtnIAbJwPurzqslhKpQLYjQLkhe1usbALCpenSgcCrhO4rognS/w1/NskVPIeJGfbBBqytyFBS8PkBzw/422za1XqFnLUghS9VRfHrdjZRuhTRHwj0J/qAcsG82pFvk1OBtIia/XRWFg+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729501152; c=relaxed/simple;
	bh=C7NIpMnvUoTZxe6zhDE0hY4LhkMmsoBIL9CZOvEdxxY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=in4ICFYbnhw4eCkG2nYDkDElkpQdq7pD2JODs2YUzl6ce38dSrW1HZcmQHnJ11iHb6SLjAdBqNEKs+82s1XmDbab0Np3k59fdgtjDlOrdBqVV0FnX8ziyGbfLuFC3iT2Ex7KogtpkADqyRvixOAmMywa7bXZ/wbnIzeVwmR9Hr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=m18TV+jM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49L8x19612167434, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729501141; bh=C7NIpMnvUoTZxe6zhDE0hY4LhkMmsoBIL9CZOvEdxxY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=m18TV+jM+A7vGI5s2Rs31sOPverQvZygA/gF7/pfcWhGMEsW9//ze7XskWg/LEPrv
	 PKX1NYI3Mor/cAD953z4ohUujbTj8s9hc35qPtS9vommkpuqYuxCr7MN/wnZibxiDf
	 hdG+LOPTyHYQSRRXFzb2DQ2FbJGs22D7ZKOfATnIujdygUcHOm3gpk+zTQJqx4zNDa
	 BTAs4GhYQSvOGlr61WAxyerTGICDj7yDQiangRKv7uLvkfE1687mq1gNeSzvDiUVpg
	 sqzxUmOzlhOu8GDzICG3qk3bxlQC4HYeHe8aBgyZvyy320Y3JLPW+P8uw557b0220l
	 m/lzG327YLy8g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49L8x19612167434
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 16:59:01 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 16:59:01 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 21 Oct 2024 16:59:00 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2]) by
 RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2%7]) with mapi id
 15.01.2507.035; Mon, 21 Oct 2024 16:59:00 +0800
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
Thread-Index: AQHbIwVT/23eeZo4dEmkKtnQN51H6bKP5WWAgABb9wCAAJxEgP//e3+AgACHy9D//4FDgIAAhkBg
Date: Mon, 21 Oct 2024 08:59:00 +0000
Message-ID: <c47a3841cd554c678a0c5e517dd2ea77@realtek.com>
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
	<87ldyh6eyu.wl-tiwai@suse.de>	<18d07dccef894f4cb87b78dd548c5bdd@realtek.com>
 <87h6956dgu.wl-tiwai@suse.de>
In-Reply-To: <87h6956dgu.wl-tiwai@suse.de>
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



> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Monday, October 21, 2024 4:57 PM
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
> On Mon, 21 Oct 2024 10:38:48 +0200,
> Kailang wrote:
> >
> > But this platform need to assign model
> ALC287_FIXUP_LENOVO_THKPAD_WH_ALC1318.
> > It has a chance to broken amp IC.
>=20
> Yes, if X1 Carbon Gen 12 is indeed the targeted model of the fix, it must=
 be
> applied.  But we seem still missing some small piece...
>=20
> > But I don't know why it doesn't have output from speaker.
>=20
> The diff of COEF dump showed at NID 0x20:
> (working)    Coeff 0x10: 0x8006
> (broken)     Coeff 0x10: 0x8806
> (working)    Coeff 0x46: 0x0004
> (broken)     Coeff 0x46: 0x0404
> It shouldn't be a problem to leave the bit 0x800 to COEF 0x10, I suppose?
>=20
> > Maybe could run hda_verb to get COEF value. To get NID 0x5A index 0 val=
ue.
>=20
> Dean, please run hda-verb program (as root) like:
>   hda-verb /dev/snd/hwC0D0 0x5a SET_COEF_INDEX 0x00
>   hda-verb /dev/snd/hwC0D0 0x5a GET_PROC_COEF 0
>=20
> and give the outputs on both working and non-working cases.
>=20
> hda-verb should be included in alsa-utils.

Dean,
Please also get the value via music playing.

>=20
>=20
> Takashi
>=20
> >
> > > -----Original Message-----
> > > From: Takashi Iwai <tiwai@suse.de>
> > > Sent: Monday, October 21, 2024 4:24 PM
> > > To: Kailang <kailang@realtek.com>
> > > Cc: Takashi Iwai <tiwai@suse.de>; Dean Matthew Menezes
> > > <dean.menezes@utexas.edu>; stable@vger.kernel.org;
> > > regressions@lists.linux.dev; Jaroslav Kysela <perex@perex.cz>;
> > > Takashi Iwai <tiwai@suse.com>; Linux Sound System
> > > <linux-sound@vger.kernel.org>; Greg KH <gregkh@linuxfoundation.org>
> > > Subject: Re: No sound on speakers X1 Carbon Gen 12
> > >
> > >
> > > External mail.
> > >
> > >
> > >
> > > On Mon, 21 Oct 2024 10:19:53 +0200,
> > > Kailang wrote:
> > > >
> > > > Change to below model.
> > > > +     SND_PCI_QUIRK(0x17aa, 0x231e, "Thinkpad",
> > > ALC287_FIXUP_THINKPAD_I2S_SPK),
> > > > +     SND_PCI_QUIRK(0x17aa, 0x231f, "Thinkpad",
> > > > + ALC287_FIXUP_THINKPAD_I2S_SPK),
> > > >
> > > > The speaker will have output. Right?
> > >
> > > FWIW, that was what I asked in
> > >   https://lore.kernel.org/87h697jl6c.wl-tiwai@suse.de
> > > and Dean replied that the speaker worked with it.
> > > (His reply missed Cc, so it didn't appear in the thread, unfortunatel=
y).
> > >
> > >
> > > Takashi
> > >
> > > > > -----Original Message-----
> > > > > From: Takashi Iwai <tiwai@suse.de>
> > > > > Sent: Monday, October 21, 2024 2:59 PM
> > > > > To: Dean Matthew Menezes <dean.menezes@utexas.edu>
> > > > > Cc: Takashi Iwai <tiwai@suse.de>; Kailang <kailang@realtek.com>;
> > > > > stable@vger.kernel.org; regressions@lists.linux.dev; Jaroslav
> > > > > Kysela <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; Linux
> > > > > Sound System <linux-sound@vger.kernel.org>; Greg KH
> > > > > <gregkh@linuxfoundation.org>
> > > > > Subject: Re: No sound on speakers X1 Carbon Gen 12
> > > > >
> > > > >
> > > > > External mail.
> > > > >
> > > > >
> > > > >
> > > > > On Mon, 21 Oct 2024 03:30:13 +0200, Dean Matthew Menezes wrote:
> > > > > >
> > > > > > I can confirm that the original fix does not bring back the
> > > > > > speaker output.  I have attached both outputs for alsa-info.sh
> > > > >
> > > > > Thanks!  This confirms that the only significant difference is
> > > > > the COEF data between working and patched-non-working cases.
> > > > >
> > > > > Kailang, I guess this model (X1 Carbon Gen 12) isn't with
> > > > > ALC1318, hence your quirk rather influences badly.  Or may the
> > > > > GPIO3 workaround have the similar effect?
> > > > >
> > > > > As of now, the possible fix is to simply remove the quirk
> > > > > entries for
> > > ALC1318.
> > > > > But I'd need to know which model was targeted for your original
> > > > > fix in commit
> > > > > 1e707769df07 and whether the regressed model is with ALC1318.
> > > > >
> > > > >
> > > > > Takashi

