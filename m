Return-Path: <stable+bounces-87026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 330449A5E77
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619EE1C2166D
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 08:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1864D1E2013;
	Mon, 21 Oct 2024 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="jjDGKvYw"
X-Original-To: stable@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9763F1E1C3B;
	Mon, 21 Oct 2024 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729498804; cv=none; b=gCA0G1PDGJfkGpsWmTkh/b/eLfg5qU53Q0udK9m3WgWrPRwU9wOessifhaAqVHroQPAeidG7xkF2ZGOp8EY4AHxWgNK10jV8OIDszv2llrZpR/PT1I5g+elJnr5mTUxftsoE2XWZ8q/4+wdDNHIR/xJOOplrtaZ1fBG24jzu3bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729498804; c=relaxed/simple;
	bh=4hBTAmQJd6Cv2qV6Aix7eFzHnl0R9SuHamcn43yjWyA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ae0friNp1OJdNCtlqFrjbAQZ9lrvFpjrMYfNmRWNWK5MYILp/lXePIF/ulegK+Vs1Xo9KO9IigMiulFYWlabP/RP1qKou0C2Zj8SpA3IYRV4Ptj0OxaezV/N9KHnuyDNzvqatrvgrK37dXLVqKdYBmbb9T6lG/07lrIdcsKe+XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=jjDGKvYw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49L8Jr5E22131826, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729498794; bh=4hBTAmQJd6Cv2qV6Aix7eFzHnl0R9SuHamcn43yjWyA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=jjDGKvYwZn6J12rvkCygRz551x0ANIj3q++NIVcX1+13ijsBc9ha7Z1yEvQNAt572
	 eLHLcCKlLLaMffBPtfTpUqkg/NVKACT3qbyBLTWF5Scub3U4Qnhcg/t5mJuiIDcxTL
	 bOnzPISu4s8FC1yaQmQ+LWnLqDjuUC1khT2+sFpz3bX0Co/ll4cXkDCx+b/O7yAZEJ
	 HhMBpvgcU/WSMj2SxVoNmNIur3SHmoYywaNhGjiC3iwr3b1Jlr93YhfXpmkfSHGcik
	 gDIchkIuAR93cJZ/srcGI5u4fk9Qutt+Skn5GH1HGEEuoBwK+3y7ow90bJGx4EJVnK
	 eX2VffHKVxbjw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49L8Jr5E22131826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 16:19:53 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 16:19:53 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 21 Oct 2024 16:19:53 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2]) by
 RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2%7]) with mapi id
 15.01.2507.035; Mon, 21 Oct 2024 16:19:53 +0800
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
Thread-Index: AQHbIwVT/23eeZo4dEmkKtnQN51H6bKP5WWAgABb9wCAAJxEgA==
Date: Mon, 21 Oct 2024 08:19:53 +0000
Message-ID: <43fe74e10d1d470e80dc2ae937bc1a43@realtek.com>
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

Change to below model.=20
+	SND_PCI_QUIRK(0x17aa, 0x231e, "Thinkpad", ALC287_FIXUP_THINKPAD_I2S_SPK),
+	SND_PCI_QUIRK(0x17aa, 0x231f, "Thinkpad", ALC287_FIXUP_THINKPAD_I2S_SPK),

The speaker will have output. Right?

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
>=20
> As of now, the possible fix is to simply remove the quirk entries for ALC=
1318.
> But I'd need to know which model was targeted for your original fix in co=
mmit
> 1e707769df07 and whether the regressed model is with ALC1318.
>=20
>=20
> Takashi

