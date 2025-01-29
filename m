Return-Path: <stable+bounces-111135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5450BA21E3C
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 14:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3BDE1886978
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 13:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1223149C6F;
	Wed, 29 Jan 2025 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="oAx/lblN"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945C622EE5;
	Wed, 29 Jan 2025 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738158942; cv=none; b=i+QQmdztFofWQN1adSrcsKLcTgXnpjnGeRLz2dzil0liAjoMwWLwGFYWDAt7r+7T07wrY5d8Q78s0/Mir2KnpoKpeP3kB+TMfZbGcui1kTjS2M1SC+Euzl1stSesie380jZidY8MZ4xj62DkEegteZNmdUcxJLblkXfDQkDEEhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738158942; c=relaxed/simple;
	bh=2kaCYS5D2miQDJwbjzPYw58eNbfxzb33KrouHy+Rl5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCdpO6qr21rdYQ7/ePowQ5lUoyYFJTFLG1HwdInfcQbmAUgK2VD8h6143iYB2pujpL+tAUclsAYvstHvlQY9ywO0OuA+++GMvWJ2DhGTJ2527ByBK9BEohZLwO+1tiApXlMS0x/9t8FtrXGv5wQfxCJchY38t/VA+R1eJZI+IqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=oAx/lblN; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KXkBWHEaJXrpT8JPISvbg7HTtDoP5XWvSl4xzxJ/Qa4=; b=oAx/lblNfV1SuPRzyjcEntGx89
	+aHyC2xPRUZGs/OTNRtOPyaaYxfTK5IQRvrwjxOgv/gPmV7T4cMUGOIR/Dpy98v5tNOPysagNS/Ns
	Ryy51S3zjv78ZXsztw2fkmjg4euWpAUAj8xDs74ZPFizMAGTIGWEnykER/Lieu0BF2V4P+BD8hv6n
	Q58T5njVpMIoI9RwmJV2hm9UiuzfI7scX14YKHlWA1DcgR2/lTFyN+67UYs8uyDNiLX3PJZsda6hS
	YISY8aHxtcHDZDmOj8dlTU6ylrmurSH+db6mdM/tcGhRsY4peUMwdKgFGmzMhOC0JOdrkk+AxAKlx
	SYmlwbiA==;
Received: from i53875b5c.versanet.de ([83.135.91.92] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1td8XR-0005LD-6M; Wed, 29 Jan 2025 14:55:29 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Jan =?utf-8?B?xIxlcm3DoWs=?= <sairon@sairon.cz>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, FUKAUMI Naoki <naoki@radxa.com>,
 Michael Zimmermann <sigmaepsilon92@gmail.com>,
 Chukun Pan <amadeus@jmu.edu.cn>, Vinod Koul <vkoul@kernel.org>,
 regressions@lists.linux.dev
Subject:
 Re: [REGRESSION] USB 3 and PCIe broken on rk356x due to missing phy reset
Date: Wed, 29 Jan 2025 14:55:28 +0100
Message-ID: <5040940.GXAFRqVoOG@diego>
In-Reply-To: <2025012925-stammer-certify-68db@gregkh>
References:
 <20241230154211.711515682@linuxfoundation.org>
 <91993fed-6398-4362-8c62-87beb9ade32b@sairon.cz>
 <2025012925-stammer-certify-68db@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

Am Mittwoch, 29. Januar 2025, 14:36:07 CET schrieb Greg Kroah-Hartman:
> On Wed, Jan 29, 2025 at 02:27:05PM +0100, Jan =C4=8Cerm=C3=A1k wrote:
> > Hi Greg, everyone,
> >=20
> > unfortunately, this patch introduced a regression on rk356x boards, as =
the
> > current DTS is missing the reset names. This was pointed out in 6.12 se=
ries
> > by Chukun Pan [1], it applies here as well. Real world examples of brea=
kages
> > are M.2 NVMe on ODROID-M1S [2] and USB 3 ports on ODROID-M1 [3]. This p=
atch
> > shouldn't have been applied without the device tree change or extra fal=
lback
> > code, as suggested in the discussion for Chukun's original commits [4].
> > Version 6.6.74 is still affected by the bug.
> >=20
> > Regards,
> > Jan
> >=20
> > [1]
> > https://lore.kernel.org/stable/20241231021010.17792-1-amadeus@jmu.edu.c=
n/
> > [2] https://github.com/home-assistant/operating-system/issues/3837
> > [3] https://github.com/home-assistant/operating-system/issues/3841
> > [4] https://lore.kernel.org/all/20250103033016.79544-1-amadeus@jmu.edu.=
cn/
> >=20
> > #regzbot introduced: v6.6.68..v6.6.69
>=20
> So where should it be reverted from, 6.6.y and 6.12.y?  Or should a
> different specific commit be backported instead?

Alternatively, ways forward would be:

=2D 6.13 contains the devicetree change, the failing phy-patch
  requires:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D8b9c12757f919157752646faf3821abf2b7d2a64

=2D there is a pending fix to the phy driver that acts as a fallback for
  old DTs, waiting for phy maintainers coming back from winter-break
  https://lore.kernel.org/all/20250106100001.1344418-2-amadeus@jmu.edu.cn/

> And this isn't an issue on 6.13, right?

correct, 6.13 got the dt change that was part of the original series.
Of course the fallback thing from above should've been part of the
original submission in the first place.


Heiko



