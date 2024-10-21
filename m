Return-Path: <stable+bounces-87019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E7D9A5DBF
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 09:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374C21C215E4
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 07:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FEE1E1026;
	Mon, 21 Oct 2024 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="dR2SPeVM"
X-Original-To: stable@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEAF1E1022;
	Mon, 21 Oct 2024 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729497406; cv=none; b=A4f5RRhVdehITMjYDmm3du4/Fd6YrNnDlJyBHOfiMbS28q1uBpyia+FN4hppnsuYuUd8l7uOOpew6xlV0KXDIUPKIYt9aq1ZoLlpSxItdpCSfuvn41PW0DLJ0qlBggJCrFJ5FRrct6OddnemPZc1zQ/2vBJjnIfAu/E4F+1hBKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729497406; c=relaxed/simple;
	bh=OQ8rJdgVEyrXGuuW4HbA/wAE8d62CqGOzxmvfsDM7uE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qoppG+WO1zWjUvBZ/NV51Jk9l7yAgULpxO3fsuam0Pt/8Pv0eC9VFauyTWaB1uICQo9udd7O4VvPXEbOYN31/wdZL0yqAX5SwfOS5SBvCc2dvdrqRcCQHZV7ln6IZnNMcNIEdTYnBcd4InTyO5ZeIcg8QekhXwWO5+VSO8p4yvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=dR2SPeVM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49L7uXutD2108098, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729497393; bh=OQ8rJdgVEyrXGuuW4HbA/wAE8d62CqGOzxmvfsDM7uE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=dR2SPeVMQh3kk4XKaVq7WzA5kZqxG5ae70G9KmrK1qQcDdVy1LQ07VfHzZZjhqyBC
	 Y9zPdKHFLAHTRP3gcEzvvAVVs7p16DfSMwqYqb4H0iYmd0wjC1YWK25jPI8Zoz0aBq
	 s1GcrR2BvoXOq6GBpIGPDwzbKsMXTefAntam8JOdKt1ypJEt+Q+0K5U5oUyEJVnuGR
	 f8HuAbgPO1Cn15tEKSfAtV2W9ChVxmlAL47pDwV3TFKz46lqUKzF/xum4XkS2Bv/Nf
	 JqfQAZOP5Nteo5e9LbyHAwo2LrOJNEq67gBjF+0C73h6aJC3G3uwzzX9jajQBus38P
	 NKgJ1YRvoI6aA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49L7uXutD2108098
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 15:56:33 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 15:56:33 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 21 Oct 2024 15:56:32 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2]) by
 RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2%7]) with mapi id
 15.01.2507.035; Mon, 21 Oct 2024 15:56:32 +0800
From: Kailang <kailang@realtek.com>
To: Takashi Iwai <tiwai@suse.de>,
        Dean Matthew Menezes
	<dean.menezes@utexas.edu>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Linux Sound System
	<linux-sound@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: RE: No sound on speakers X1 Carbon Gen 12
Thread-Topic: No sound on speakers X1 Carbon Gen 12
Thread-Index: AQHbIwVT/23eeZo4dEmkKtnQN51H6bKP5WWAgABb9wCAAJQEMA==
Date: Mon, 21 Oct 2024 07:56:32 +0000
Message-ID: <325719ad24c24f1faee12a4cdceec87b@realtek.com>
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
 <877ca2j60l.wl-tiwai@suse.de>
In-Reply-To: <877ca2j60l.wl-tiwai@suse.de>
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
> Sent: Monday, October 21, 2024 2:59 PM
> To: Dean Matthew Menezes <dean.menezes@utexas.edu>
> Cc: Takashi Iwai <tiwai@suse.de>; Kailang <kailang@realtek.com>;
> stable@vger.kernel.org; regressions@lists.linux.dev; Jaroslav Kysela
> <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; Linux Sound System
> <linux-sound@vger.kernel.org>; Greg KH <gregkh@linuxfoundation.org>
> Subject: Re: No sound on speakers X1 Carbon Gen 12
>=20
>=20
> External mail.
>=20
>=20
>=20
> On Mon, 21 Oct 2024 03:30:13 +0200,
> Dean Matthew Menezes wrote:
> >
> > I can confirm that the original fix does not bring back the speaker
> > output.  I have attached both outputs for alsa-info.sh
>=20
> Thanks!  This confirms that the only significant difference is the COEF d=
ata
> between working and patched-non-working cases.
>=20
> Kailang, I guess this model (X1 Carbon Gen 12) isn't with ALC1318, hence =
your
> quirk rather influences badly.  Or may the GPIO3 workaround have the simi=
lar
> effect?

No, I check with our AE. It's ALC1318 include.
And This fixed was testing with Lenovo.

>=20
> As of now, the possible fix is to simply remove the quirk entries for ALC=
1318.
> But I'd need to know which model was targeted for your original fix in co=
mmit
> 1e707769df07 and whether the regressed model is with ALC1318.

+	SND_PCI_QUIRK(0x17aa, 0x231e, "Thinkpad", ALC287_FIXUP_LENOVO_THKPAD_WH_A=
LC1318),
+	SND_PCI_QUIRK(0x17aa, 0x231f, "Thinkpad", ALC287_FIXUP_LENOVO_THKPAD_WH_A=
LC1318),

Yes, this model include ALC1318.

> =09
>=20
> Takashi

