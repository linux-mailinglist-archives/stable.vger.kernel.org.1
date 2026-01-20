Return-Path: <stable+bounces-210556-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJ75M82zb2nHMAAAu9opvQ
	(envelope-from <stable+bounces-210556-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 17:56:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7810748114
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 17:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 35647787C82
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 14:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285E04418FC;
	Tue, 20 Jan 2026 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="wlp0I5GK"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A09A3E9598;
	Tue, 20 Jan 2026 14:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768920082; cv=none; b=s37pxWtWRWKHhMoH2XWKWfoOH+LEWOxGPc0zzhQxpQQzPcnXtVTKiYZWP8x5UAPce20+UnJjNRbhGpznz1ibMm9Bv0YxRsDqN29EYP71ubHGeLcWMkF1Ks9m9ygqaD0B1+GK8ezxUd33Y4Dw+yi8lyzsZrdePk/UYgvjfivkvns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768920082; c=relaxed/simple;
	bh=0eliuaQZWNTt7WLgFve+O+VDDRcSouQfwZyXuVgVuh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHyWSQYAcaR7cejvhrFBrQqAo2+XS0syyEn/EJr87nQhpPPkK2MQW9II5wu05xVSvfiStSrmVd9qAiU10HUhyI9Py7yDUewT+BtvrXoeCKDF+7ArJH7Q4zHjYeyiwipBa7fLzMHOXZ/7343ktWnzrfBf5zT3qDCmi8OqZR91fW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=wlp0I5GK; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=Sag+H/BhPZ45KSkJ6zCyuoYRKvuE9xHt5nOXwQMVW40=; b=wlp0I5GKmkHGAajTVUbav838z3
	6hqseOEREYnEOKPj/nmBZZi/VZDgF5D6MNyxqFPU0be0Ids+mGYNL/DbmmjFKW4UL4X6Tf1IlNKzw
	2JzL/ufy7vBtteFvAA/uIQ5jhdJxU2d6EgQCECbgueW+iOAHk4zaAZpdf2gq4EPJEkAonK0ZmGJor
	q/T/DsRgoreG3A+qEK9gcRNjJr1I2sbYzd4U6W28Wat5tRGRkkLU4d7BIM9N9WbUzE1uQBE5g4FIL
	GgmOdXHfV96fRHsRrGuSGsgbYEwHLdEDX/quh3UR2izo/uXGz5y4QsnuixAmOxjB3EjGTaqorYDcZ
	cG+3jzaA==;
Received: from i53875a75.versanet.de ([83.135.90.117] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1viCuo-003T50-Vr; Tue, 20 Jan 2026 15:41:07 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Manivannan Sadhasivam <mani@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject:
 Re: [PATCH v2] arm64: dts: rockchip: Explicitly request UFS reset pin on
 RK3576
Date: Tue, 20 Jan 2026 15:41:06 +0100
Message-ID: <4830042.taCxCBeP46@diego>
In-Reply-To:
 <CABjd4YwAMbH21jcjhks7ThoXzcF8GeOzBPYDvN+7cip0iA6stg@mail.gmail.com>
References:
 <20260120-ufs-rst-v2-1-b5735f1996f6@gmail.com>
 <9e51b504-e0f0-4d17-baa2-387339507c86@cherry.de>
 <CABjd4YwAMbH21jcjhks7ThoXzcF8GeOzBPYDvN+7cip0iA6stg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[cherry.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-210556-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sntech.de:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[sntech.de,none];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,cherry.de:email,sntech.de:dkim,2a2d0000:email]
X-Rspamd-Queue-Id: 7810748114
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am Dienstag, 20. Januar 2026, 14:14:48 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Alexey Charkov:
> On Tue, Jan 20, 2026 at 5:00=E2=80=AFPM Quentin Schulz <quentin.schulz@ch=
erry.de> wrote:
> >
> > Hi Alexey,
> >
> > On 1/20/26 1:53 PM, Alexey Charkov wrote:
> > > Rockchip RK3576 UFS controller uses a dedicated pin to reset the conn=
ected
> > > UFS device, which can operate either in a hardware controlled mode or=
 as a
> > > GPIO pin.
> > >
> > > Power-on default is GPIO mode, but the boot ROM reconfigures it to a
> > > hardware controlled mode if it uses UFS to load the next boot stage.
> > >
> > > Given that existing bindings (and rk3576.dtsi) expect a GPIO-controll=
ed
> > > device reset, request the required pin config explicitly.
> > >
> > > This doesn't appear to affect Linux, but it does affect U-boot:
> > >
> > > Before:
> > > =3D> md.l 0x2604b398
> > > 2604b398: 00000011 00000000 00000000 00000000  ................
> > > < ... snip ... >
> > > =3D> ufs init
> > > ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=3D[3, 3], lane[2, 2], =
pwr[FASTAUTO_MODE, FASTAUTO_MODE], rate =3D 2
> > > =3D> md.l 0x2604b398
> > > 2604b398: 00000011 00000000 00000000 00000000  ................
> > >
> > > After:
> > > =3D> md.l 0x2604b398
> > > 2604b398: 00000011 00000000 00000000 00000000  ................
> > > < ... snip ...>
> > > =3D> ufs init
> > > ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=3D[3, 3], lane[2, 2], =
pwr[FASTAUTO_MODE, FASTAUTO_MODE], rate =3D 2
> > > =3D> md.l 0x2604b398
> > > 2604b398: 00000010 00000000 00000000 00000000  ................
> > >
> > > (0x2604b398 is the respective pin mux register, with its BIT0 driving=
 the
> > > mode of UFS_RST: unset =3D GPIO, set =3D hardware controlled UFS_RST)
> > >
> > > This helps ensure that GPIO-driven device reset actually fires when t=
he
> > > system requests it, not when whatever black box magic inside the UFSHC
> > > decides to reset the flash chip.
> > >
> >
> > Would have liked a mention on why pull-down in the commit log.
>=20
> Indeed. Heiko, if you're going to apply this to your tree, would you
> mind amending the commit description with something like the
> following?
>=20
> The pin is requested with pull-down enabled, which is in line with the
> SoC power-on default and helps ensure that the attached UFS chip stays
> in reset until the driver takes over the control of the respective
> GPIO line.

Will do :-)

Heiko


> > In any case,
> >
> > Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> Thanks a lot!
>=20
> Best regards,
> Alexey
>=20





