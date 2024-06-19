Return-Path: <stable+bounces-54632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2034190EF33
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334031C2451E
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F80314D2A2;
	Wed, 19 Jun 2024 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="SPEeoP9t";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="X1i2bT+J"
X-Original-To: stable@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB36114E2C9;
	Wed, 19 Jun 2024 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804463; cv=none; b=hJ5ofneEJ1UVfa1ZfeRiKYIoP7Vx68OaWA3b6p6QzNvN9tdiEt6Y8HbBEigFo1s38SCTu4ypr8VNG5udFscICMSF93q3PijS+9hV8BhVRG9KxTo3NbSgEhW22+9Acl1N8RmviIKagMu+vlOfdQnDmX0ZzyxIkEtl6DOBH7BEK4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804463; c=relaxed/simple;
	bh=3iT0uVqp/hE43nJf7cv/4HXVDWa9DxO/5qFqB/IBEt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRoZ9nV8r4BMpFXf8mVdgfako2iPeOp94hhCDt6xDp1wfzyXq0o6WmEYr5aBDx3bt3v+Ifk5ZUBIKTQZEg56bGwsxz2p2QrT0T2Fau2ksIBM6aS1eUNu76ZitSWpaW0zQ8UbGPQClkot9HotzuMDd9JLNpMiZnZPeFFiCI+QGI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=SPEeoP9t; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=X1i2bT+J reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718804459; x=1750340459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a3p1avtfpkyJrZzVNjSPngeHAvFYfymQmXZ8Pg6h+F0=;
  b=SPEeoP9tiJQX7U1cCQ0oPv/wKat7eWkEHRhlp6d1HUsvwHSgJwNl2SkM
   rTqVp3GyE8IJCvE4RxOfb1weNVSD1EzBfUfI5+uMLZiDN84dKCqbgiAO9
   yjPhiCtaybb8o4/PXjouoTYQDXEq94yxrdFMsTA9wHRZgafj1QVEYdvwu
   8y+tHADO134XrFSNVnaxe1oLIa4NTxlTpnjzPlUVGCpshqhmDV+Gq+CgD
   OCSWy8pAF/pfutQJlbj9YylA45lvEw9atRCr1g1Ys+pUp8LkeZJuKkNfV
   4ITXTxxITALVzg0KMVRZ+1XHuq5LSC/naSlY+J6Uvn3bEZuhaAMNuBe6c
   A==;
X-CSE-ConnectionGUID: eXj6ePJ5Q5Gwr9PBa//6xw==
X-CSE-MsgGUID: XkMx1NbvSlS/3/pjw2rKOQ==
X-IronPort-AV: E=Sophos;i="6.08,250,1712613600"; 
   d="scan'208";a="37478359"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Jun 2024 15:40:56 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 12538166A8D;
	Wed, 19 Jun 2024 15:40:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718804452;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=a3p1avtfpkyJrZzVNjSPngeHAvFYfymQmXZ8Pg6h+F0=;
	b=X1i2bT+JRLfusJy9yQPurlsBZxGjUKHbjB2UYkhw0cq1/vgS07+WrR2h7xcsGmK1kUKLN2
	iH3wnaKSRyxQZxSapx2LA/6TBYm+hOpfcXMBQHnMXup1+3HQHVyOqGvtar7k/hKiWn13uh
	RlVGqwLVpINzgWYwAaBnpLUEBxy8JizT3Qzis3qWDR40sgtEpRCmBJ+b3zo3VOgvXXLuHz
	ogX/rvsQDodje8rdxF0AXYS+0B62yQZoQmt46zIoT+U7zYvFtmReWLyqLdDJjlOXz6LqL7
	9CVKEZrUuRutHFirC9QvF6DtouMyTiCULRdfXWpqjN5AvH0X04GuMh3zUf9BFA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, Markus Niebel <Markus.Niebel@ew.tq-group.com>, Lee Jones <lee@kernel.org>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1 resend] MAINTAINERS: Fix 32-bit i.MX platform paths
Date: Wed, 19 Jun 2024 15:40:54 +0200
Message-ID: <3326703.44csPzL39Z@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <2024061933-oxidizing-backspin-8c4e@gregkh>
References: <20240619115610.2045421-1-alexander.stein@ew.tq-group.com> <13561511.uLZWGnKmhe@steina-w> <2024061933-oxidizing-backspin-8c4e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Mittwoch, 19. Juni 2024, 14:37:09 CEST schrieb Greg KH:
> On Wed, Jun 19, 2024 at 02:23:36PM +0200, Alexander Stein wrote:
> > Am Mittwoch, 19. Juni 2024, 14:18:35 CEST schrieb Greg KH:
> > > On Wed, Jun 19, 2024 at 01:56:10PM +0200, Alexander Stein wrote:
> > > > The original patch was created way before the .dts movement on arch=
/arm.
> > > > But it was patch merged after the .dts reorganization. Fix the arch=
/arm
> > > > paths accordingly.
> > > >=20
> > > > Fixes: 7564efb37346a ("MAINTAINERS: Add entry for TQ-Systems device=
 trees and drivers")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > > ---
> > > >  MAINTAINERS | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index c36d72143b995..762e97653aa3c 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -22930,9 +22930,9 @@ TQ SYSTEMS BOARD & DRIVER SUPPORT
> > > >  L:	linux@ew.tq-group.com
> > > >  S:	Supported
> > > >  W:	https://www.tq-group.com/en/products/tq-embedded/
> > > > -F:	arch/arm/boot/dts/imx*mba*.dts*
> > > > -F:	arch/arm/boot/dts/imx*tqma*.dts*
> > > > -F:	arch/arm/boot/dts/mba*.dtsi
> > > > +F:	arch/arm/boot/dts/nxp/imx/imx*mba*.dts*
> > > > +F:	arch/arm/boot/dts/nxp/imx/imx*tqma*.dts*
> > > > +F:	arch/arm/boot/dts/nxp/imx/mba*.dtsi
> > > >  F:	arch/arm64/boot/dts/freescale/fsl-*tqml*.dts*
> > > >  F:	arch/arm64/boot/dts/freescale/imx*mba*.dts*
> > > >  F:	arch/arm64/boot/dts/freescale/imx*tqma*.dts*
> > >=20
> > > Why is a MAINTAINERS change needed for stable kernels?
> >=20
> > This fixes the original commit introducing these entries, mainlined in =
v6.6
> > Unfortunately that got delayed so much it was merged after commit
> > 724ba67515320 ("ARM: dts: Move .dts files to vendor sub-directories"), =
which
> > was merged in v6.5.
> > Thus the (32-Bit) arm DT paths are incorrect from the very beginning.
>=20
> That's fine, who is using these paths on older kernels anyway?  You
> should always be doing development on the latest kernel tree, so they
> shouldn't matter here.
>=20
> or am I missing something?

Sure development is on newer trees, but I'm wondering if anyone uses
scripts on that stable version evaluating this file.
I don't mind if this is not applied to stable. Want me to send without Fixes
and CC tag?

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



