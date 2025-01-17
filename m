Return-Path: <stable+bounces-109341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE89A14A65
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 08:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7C43AAB0F
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 07:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D6A1F75AD;
	Fri, 17 Jan 2025 07:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="IagUcQbK"
X-Original-To: stable@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CF41B4F0C;
	Fri, 17 Jan 2025 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737100147; cv=none; b=OJd7VoziagRd7g8kVRVV6nYqXDJSvu2m4B4EzyGdd4bTBJquflasgdBVJQ16tKs+Ie6bIiWwupSyGlu8JnU/55LYhdrKAmhV8sMrlryUtNBSgeB5EzJG3o3kraPrLyJl1XC4rfOd48de5wpPqaD3kECM00U6W6yW34YrDyVF+mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737100147; c=relaxed/simple;
	bh=+yBmPoF4ogpbGxrxDVIFImhd0LLlFhUgbAtZq8Zp9fc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aPaIeYz1+9d4UNLJErlzx3FWJcMIHRjPaC9Tvs4x7Y43yvM4D2OzlBAnYqS8QjL39Liq0TyhBEKJidSEna6z4RELlNUQwLRuO8MEyjufUcb2D5oeoG9VYIyXye1btZhLSKspEMN2U1eTFPDp+9sE9Qnz6NFlzTPsGdrh9zPGuUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=IagUcQbK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50H7mlK332353177, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737100127; bh=+yBmPoF4ogpbGxrxDVIFImhd0LLlFhUgbAtZq8Zp9fc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version;
	b=IagUcQbKRs46148jsMZ/WZRywwRSIdO4zJok6JbQjKe62J/3/ZKI5+NP9TKzRsrlr
	 nLDPtdqxIeddWVvMOQ6dr4XHyH8mwxS2ImKXe0RnwmzoAhYIimV6UBmuX2feHoNYst
	 pbwYOGDlI3vfXyTSR2ySb4Uh8sLDdBHTzdE0oV4BS0EhhUYLT44OJcQKAwcsrwJnEJ
	 xGem5R0q5ZQoZuKr2msdwVcBrdKGf+YEX6MswXMLYSKF6pFulRO09f2vz+/P3tvwzl
	 YZOscdRxw9057FXMCQDHRURkgU7nIxb9j24oz28NHlLv+OS0m1RKU6t1uQuYP+HZXf
	 8/4usD1HIZeKA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50H7mlK332353177
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 15:48:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 17 Jan 2025 15:48:47 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 Jan 2025 15:48:47 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547]) by
 RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547%5]) with mapi id
 15.01.2507.035; Fri, 17 Jan 2025 15:48:47 +0800
From: Kailang <kailang@realtek.com>
To: Takashi Iwai <tiwai@suse.de>, Evgeny Kapun <abacabadabacaba@gmail.com>
CC: Linux Sound Mailing List <linux-sound@vger.kernel.org>,
        "Linux Kernel
 Mailing List" <linux-kernel@vger.kernel.org>,
        Linux Regressions Mailing List
	<regressions@lists.linux.dev>,
        Linux Stable Mailing List
	<stable@vger.kernel.org>,
        " (alsa-devel@alsa-project.org)"
	<alsa-devel@alsa-project.org>
Subject: RE: [REGRESSION] Distorted sound on Acer Aspire A115-31 laptop
Thread-Topic: [REGRESSION] Distorted sound on Acer Aspire A115-31 laptop
Thread-Index: AQHbTvIxtyWK99B6LkqZbi3R9/JZE7LtROwAgAQfxYCAAA3tgIAB5qEAgAFmuDCAHI8ogIAH0iwAgAGookA=
Date: Fri, 17 Jan 2025 07:48:46 +0000
Message-ID: <0a89b6c18ed94378a105fa61e9f290e4@realtek.com>
References: <e142749b-7714-4733-9452-918fbe328c8f@gmail.com>
	<8734ijwru5.wl-tiwai@suse.de>
	<57883f2e-49cd-4aa4-9879-7dcdf7fec6df@gmail.com>
	<87ldw89l7e.wl-tiwai@suse.de>
	<fc506097-9d04-442c-9efd-c9e7ce0f3ace@gmail.com>
	<58300a2a06e34f3e89bf7a097b3cd4ca@realtek.com>
	<0494014b-3aa2-4102-8b5b-7625d8c864e2@gmail.com>
 <87a5bqj0mb.wl-tiwai@suse.de>
In-Reply-To: <87a5bqj0mb.wl-tiwai@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: yes
Content-Type: multipart/mixed;
	boundary="_002_0a89b6c18ed94378a105fa61e9f290e4realtekcom_"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--_002_0a89b6c18ed94378a105fa61e9f290e4realtekcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Attached.

> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Thursday, January 16, 2025 10:27 PM
> To: Evgeny Kapun <abacabadabacaba@gmail.com>
> Cc: Kailang <kailang@realtek.com>; Takashi Iwai <tiwai@suse.de>; Linux
> Sound Mailing List <linux-sound@vger.kernel.org>; Linux Kernel Mailing Li=
st
> <linux-kernel@vger.kernel.org>; Linux Regressions Mailing List
> <regressions@lists.linux.dev>; Linux Stable Mailing List
> <stable@vger.kernel.org>
> Subject: Re: [REGRESSION] Distorted sound on Acer Aspire A115-31 laptop
>=20
>=20
> External mail.
>=20
>=20
>=20
> On Sat, 11 Jan 2025 16:00:33 +0100,
> Evgeny Kapun wrote:
> >
> > On 12/24/24 04:54, Kailang wrote:
> > > Please test attach patch.
> >
> > This patch, when applied to kernel version 6.12.8, appears to fix the
> > issue. There are no distortions, and the left and the right channel
> > can be controlled independently.
>=20
> Good to hear.
>=20
> Kailang, care to submit a proper patch for merging?
>=20
>=20
> thanks,
>=20
> Takashi

--_002_0a89b6c18ed94378a105fa61e9f290e4realtekcom_
Content-Type: application/octet-stream; name="0000-acer-a115.patch"
Content-Description: 0000-acer-a115.patch
Content-Disposition: attachment; filename="0000-acer-a115.patch"; size=1342;
	creation-date="Tue, 24 Dec 2024 02:52:43 GMT";
	modification-date="Fri, 17 Jan 2025 07:45:06 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2YTI2MmVmZTkzZWFhMjQ2NmYzZDRkMTAzNDRlZTU1Y2UyNjI1NmMyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IE1vbiwgMzAgRGVjIDIwMjQgMTQ6NDQ6MDEgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIEZpeGVkIGhlYWRwaG9uZSBkaXN0b3J0ZWQgc291bmQgb24gQWNlciBB
c3BpcmUgQTExNS0zMSBsYXB0b3AKClNvdW5kIHBsYXllZCB0aHJvdWdoIGhlYWRwaG9uZXMgaXMg
ZGlzdG9ydGVkLgoKTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtc291bmQvZTE0
Mjc0OWItNzcxNC00NzMzLTk0NTItOTE4ZmJlMzI4YzhmQGdtYWlsLmNvbS8KU2lnbmVkLW9mZi1i
eTogS2FpbGFuZyBZYW5nIDxrYWlsYW5nQHJlYWx0ZWsuY29tPgoKZGlmZiAtLWdpdCBhL3NvdW5k
L3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMK
aW5kZXggNjFiYTVkYzM1YjhiLi4yOTM0Nzk5YjZlMDcgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9o
ZGEvcGF0Y2hfcmVhbHRlay5jCisrKyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCkBA
IC0xMDE1OCw2ICsxMDE1OCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaGRhX3F1aXJrIGFsYzI2
OV9maXh1cF90YmxbXSA9IHsKIAlTTkRfUENJX1FVSVJLKDB4MTAyNSwgMHgxMzA4LCAiQWNlciBB
c3BpcmUgWjI0LTg5MCIsIEFMQzI4Nl9GSVhVUF9BQ0VSX0FJT19IRUFEU0VUX01JQyksCiAJU05E
X1BDSV9RVUlSSygweDEwMjUsIDB4MTMyYSwgIkFjZXIgVHJhdmVsTWF0ZSBCMTE0LTIxIiwgQUxD
MjMzX0ZJWFVQX0FDRVJfSEVBRFNFVF9NSUMpLAogCVNORF9QQ0lfUVVJUksoMHgxMDI1LCAweDEz
MzAsICJBY2VyIFRyYXZlbE1hdGUgWDUxNC01MVQiLCBBTEMyNTVfRklYVVBfQUNFUl9IRUFEU0VU
X01JQyksCisJU05EX1BDSV9RVUlSSygweDEwMjUsIDB4MTM2MCwgIkFjZXIgQXNwaXJlIEExMTUi
LCBBTEMyNTVfRklYVVBfQUNFUl9NSUNfTk9fUFJFU0VOQ0UpLAogCVNORF9QQ0lfUVVJUksoMHgx
MDI1LCAweDE0MWYsICJBY2VyIFNwaW4gU1A1MTMtNTROIiwgQUxDMjU1X0ZJWFVQX0FDRVJfTUlD
X05PX1BSRVNFTkNFKSwKIAlTTkRfUENJX1FVSVJLKDB4MTAyNSwgMHgxNDJiLCAiQWNlciBTd2lm
dCBTRjMxNC00MiIsIEFMQzI1NV9GSVhVUF9BQ0VSX01JQ19OT19QUkVTRU5DRSksCiAJU05EX1BD
SV9RVUlSSygweDEwMjUsIDB4MTQzMCwgIkFjZXIgVHJhdmVsTWF0ZSBCMzExUi0zMSIsIEFMQzI1
Nl9GSVhVUF9BQ0VSX01JQ19OT19QUkVTRU5DRSksCg==

--_002_0a89b6c18ed94378a105fa61e9f290e4realtekcom_--

