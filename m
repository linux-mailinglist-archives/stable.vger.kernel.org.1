Return-Path: <stable+bounces-111235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AC5A2257D
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 22:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015811657FA
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 21:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997BE1B040B;
	Wed, 29 Jan 2025 21:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="072AC6SY"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AD77081B;
	Wed, 29 Jan 2025 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738184815; cv=none; b=NzGSqIUPC9uAiX7HfqZISgBSjpE6u1yZkq8L5ZAKzCClNpGvEsihgKbpDT42dszZOnycyS+IkaBek/DbFhWIjF9AtEYsZlafbIVW/l7LSME85X9nnjVUd8pXzGmdZ4muuFHiPs66QsBbMjioDx+9DPHp8n6/xGAjUQxys8/6Aew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738184815; c=relaxed/simple;
	bh=ay1HQ+bDvetSMc+UNYbtxOuXq6jA/VSfWbLnyKSw6Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxuFvHifDTFS86WJwG2dKGuL3cvB0/V4QPghedh4WxBRS7gxPaW4VxwnRshe2hzZBMn/tLZURLi9PlM1PiFF5bbGw+qMcAaLhqMaiNRwGaLVsVRD0xHeovq1XyUKvAz0DcjVD1F04zlNd/olXAcsOs46mRnpkZMFP+V5jQgemG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=072AC6SY; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/kf6ODXYcMXx2paQtH81CD+vnYtFAqJ2OGlXqXU64uo=; b=072AC6SYK+vyqiVTfqvv8NEiH0
	ECnmTD1/ildUN7Nv6FI0Yp/BwsrR3zff8YtbOzwC1kko9pQAqt83UHpC7UTc9v5trdjI4ueZRYdmF
	xqxxTM37wRcqgt60E3daFRixHfdV6z2ueZGW8ZNoTMIKgh+u2HpPUUP3lZGbsyMfMil6thxCyKVr7
	qNAdCn+0RBeDTWK9ul5Uxge46sojhUEJndG5DqNVsbZr0Px3J2Ky7cLruM8RZPOCsWvWu9/B0Wsd9
	1jl+4vi23g8QVzagZzRUsCVrdX9P5Wf9lXhGARyyW3OXbvtNIJI7I46Lj3ybcLSxakSXxIygshL22
	nzKQ5ATQ==;
Received: from i53875b5c.versanet.de ([83.135.91.92] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tdFGn-0008V1-5i; Wed, 29 Jan 2025 22:06:45 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Vinod Koul <vkoul@kernel.org>
Cc: Jan =?utf-8?B?xIxlcm3DoWs=?= <sairon@sairon.cz>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 FUKAUMI Naoki <naoki@radxa.com>,
 Michael Zimmermann <sigmaepsilon92@gmail.com>,
 Chukun Pan <amadeus@jmu.edu.cn>, regressions@lists.linux.dev
Subject:
 Re: [REGRESSION] USB 3 and PCIe broken on rk356x due to missing phy reset
Date: Wed, 29 Jan 2025 22:06:44 +0100
Message-ID: <3060177.e9J7NaK4W3@diego>
In-Reply-To: <Z5p2Ugfegw5ty0GU@vaman>
References:
 <20241230154211.711515682@linuxfoundation.org> <5040940.GXAFRqVoOG@diego>
 <Z5p2Ugfegw5ty0GU@vaman>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Vinod,

Am Mittwoch, 29. Januar 2025, 19:41:22 CET schrieb Vinod Koul:
> On 29-01-25, 14:55, Heiko St=C3=BCbner wrote:
> > Hi Greg,
> >=20
> > Am Mittwoch, 29. Januar 2025, 14:36:07 CET schrieb Greg Kroah-Hartman:
> > > On Wed, Jan 29, 2025 at 02:27:05PM +0100, Jan =C4=8Cerm=C3=A1k wrote:
> > > > Hi Greg, everyone,
> > > >=20
> > > > unfortunately, this patch introduced a regression on rk356x boards,=
 as the
> > > > current DTS is missing the reset names. This was pointed out in 6.1=
2 series
> > > > by Chukun Pan [1], it applies here as well. Real world examples of =
breakages
> > > > are M.2 NVMe on ODROID-M1S [2] and USB 3 ports on ODROID-M1 [3]. Th=
is patch
> > > > shouldn't have been applied without the device tree change or extra=
 fallback
> > > > code, as suggested in the discussion for Chukun's original commits =
[4].
> > > > Version 6.6.74 is still affected by the bug.
> > > >=20
> > > > Regards,
> > > > Jan
> > > >=20
> > > > [1]
> > > > https://lore.kernel.org/stable/20241231021010.17792-1-amadeus@jmu.e=
du.cn/
> > > > [2] https://github.com/home-assistant/operating-system/issues/3837
> > > > [3] https://github.com/home-assistant/operating-system/issues/3841
> > > > [4] https://lore.kernel.org/all/20250103033016.79544-1-amadeus@jmu.=
edu.cn/
> > > >=20
> > > > #regzbot introduced: v6.6.68..v6.6.69
> > >=20
> > > So where should it be reverted from, 6.6.y and 6.12.y?  Or should a
> > > different specific commit be backported instead?
> >=20
> > Alternatively, ways forward would be:
> >=20
> > - 6.13 contains the devicetree change, the failing phy-patch
> >   requires:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D8b9c12757f919157752646faf3821abf2b7d2a64
> >=20
> > - there is a pending fix to the phy driver that acts as a fallback for
> >   old DTs, waiting for phy maintainers coming back from winter-break
> >   https://lore.kernel.org/all/20250106100001.1344418-2-amadeus@jmu.edu.=
cn/
>=20
> Okay, I will pick and add it in fixes and push up

thanks a lot :-)

Heiko




