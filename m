Return-Path: <stable+bounces-88131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E42E9AFB26
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 09:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B472F1F23C8A
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 07:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E9819B59F;
	Fri, 25 Oct 2024 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="pNgK1Bw2"
X-Original-To: stable@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE581BC5C;
	Fri, 25 Oct 2024 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729841585; cv=none; b=VW8UFeVg5olKQyilSqI2x+vp/sVJ+VRzC/ztAci0T2v+P3TLcwOqv4QC+k7y0lKNAkrf9IPxCleSYsy5qaLiKsL1ldLdSW3AZy5lpf645sthQotMqIS2o0kcss7nQ5VdovUUVUlZAbsrdLYltRWqO+9K16Db/k6slQFcQF3RDbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729841585; c=relaxed/simple;
	bh=rQzYkXul6Rw+pJQnum4RN5R3vzG9twby/wiCPRhKPHQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fAXhtMVUYAQQKBt7vh/q0tjHJvNcFPbRTCV8K5ucVG2jbUBpFs4RgNCzx7IhBMH1SUgNK4bbf0BN5LIZKZv+U8McqeaN4EBDd/3q91QBcGlK5ysm4JnxvnZXVqw1vhsWn9ZlRxTXMzoSzbcK6mAsvPG9EQ7XWwvnR6vIR8iHQnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=pNgK1Bw2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49P7WqX22255012, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729841572; bh=rQzYkXul6Rw+pJQnum4RN5R3vzG9twby/wiCPRhKPHQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=pNgK1Bw2tTTECiBFspXvtWclZJNJte6AB6QwXNhJpt8I+28LeoK4Vu9Y26HwB3SI5
	 +gxq7TYZNRSHp9iZOWyfARXNOYx8DycVz8KLhWANKOZDARgIG2WuZu/42wx7xDXWq+
	 qG1W/wbnG2EMtbmx5cLPeENec7AgNPGMLBlyd6CL3x0K8fdE/O3dgLuAGFsfdSHcWe
	 LlvrGpEIp2BJOlg9y+PvIPEc5S7++O5YnnShDCmW7Y3MG7BGZW5w40auZePYxOBiOT
	 KRAWN4KXsSoiOmoErEt1SDUpbV74MQr6r9ZFlrdv3x2I3py7eVWD2ezwMfNwoLCZEa
	 SSzWLbPvvGePA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49P7WqX22255012
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 15:32:52 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 15:32:52 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 25 Oct 2024 15:32:51 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2]) by
 RTEXMBS01.realtek.com.tw ([fe80::147b:e1e8:e867:41c2%7]) with mapi id
 15.01.2507.035; Fri, 25 Oct 2024 15:32:51 +0800
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
Thread-Index: AQHbIwVT/23eeZo4dEmkKtnQN51H6bKP5WWAgABb9wCAAJxEgP//e3+AgACHy9D//4FDgIAAhkBggAVELQCAAGMKAIAAiivw
Date: Fri, 25 Oct 2024 07:32:51 +0000
Message-ID: <7450fb7c26d64049a92ba4b5df022b41@realtek.com>
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
	<87h6956dgu.wl-tiwai@suse.de>	<c47a3841cd554c678a0c5e517dd2ea77@realtek.com>
	<CAEkK70SojedmjbXB+a+g+Bys=VWCOpxzV5GkuMSkAgA-jR2FpA@mail.gmail.com>
 <87ldyctzwt.wl-tiwai@suse.de>
In-Reply-To: <87ldyctzwt.wl-tiwai@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback



> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Friday, October 25, 2024 3:17 PM
> To: Dean Matthew Menezes <dean.menezes@utexas.edu>
> Cc: Kailang <kailang@realtek.com>; Takashi Iwai <tiwai@suse.de>;
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
> On Fri, 25 Oct 2024 03:22:38 +0200,
> Dean Matthew Menezes wrote:
> >
> > I get the same values for both
> >
> > axiom /home/dean/linux-6.11.3/sound/pci/hda # hda-verb /dev/snd/hwC0D0
> > 0x5a SET_COEF_INDEX 0x00 nid =3D 0x5a, verb =3D 0x500, param =3D 0x0 va=
lue =3D
> > 0x0
>=20
> Here OK, but...
>=20
> > axiom /home/dean/linux-6.11.3/sound/pci/hda # hda-verb /dev/snd/hwC0D0
> > 0x5a SET_PROC_COEF 0x00
>=20
> ... here run GET_PROC_COEF instead, i.e. to read the value.
>=20
But SOF mode can't read from this usage. I forgot.

>=20
> thanks,
>=20
> Takashi

