Return-Path: <stable+bounces-53854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A7E90EB0D
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 14:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1750A1F21F4F
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 12:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DB414B06C;
	Wed, 19 Jun 2024 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="AQ0a9Yip";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="MgJdwiPO"
X-Original-To: stable@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD9C1482F9;
	Wed, 19 Jun 2024 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799829; cv=none; b=do6XNl32te4m3kBxW6vw8oJxoQ+GqaDZqIcOOiESzccaf7WrS/fsGeMNM3NmynyRGnBtU+U5tThpXCB2jE8fNoDteB9CNOVVHEp3GedRFGq3bTb5f0XDRG/avqqfXXmsGctcIBdSE1vFYumr0UBPF3ZnT8nwNLxXrB5fHcWaU4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799829; c=relaxed/simple;
	bh=0Wajh9hf8aQ4w6VBs7C1QP5+1bMP5jm1LhzQTcPPkGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAcadCn6en6syb/Gj8AeWtg/+xqtDWYwiO+gp1o74yNP9RfIdCQqLQPjlUeQA69EsaO6NiFplv6T3qrEpsXc84EJUzN5PjCrqLb3t6xbpGWD/3yi/DBcb55F0tJdKGskUGw8S4uXXpNH5K4Xox9ypA5NhHYWy/3b0+wDCnr7yY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=AQ0a9Yip; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=MgJdwiPO reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718799825; x=1750335825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ub8TRoLtI7o1oH6Fs2P1jN0+GX8tw7Fve8YcIfkXSyM=;
  b=AQ0a9YipNGB7OTTzb/+8KNS0LSdaSXn8SFW6ttDkzxaVDY9NngNqsLnU
   Q6ThRibSGpXGdkDZ9Qd0rzLDSnlIgvV5WmFZD9mIraVylt6Uayz5qj1rl
   VivYCYcrMHQemLjdexy8wGgRZksXG8FcZ3VzgFg16ETzddaxgm8MPf6ZE
   y5QwTsksOoiYacJtYBl1cn+QV+X0sBmbqHWMe2A1Ll5LheFOsOkWLL4Ce
   Y94mggeHnTeEtqho1Gi3BJoNcDflrBS61lrNcCVYZydzkQwnw2uNRiefg
   E9VYOtRfaPH+Xne+6v9LyzcU9WaC8OszByhuLsjDH2ME2shcsjwBbnAgH
   Q==;
X-CSE-ConnectionGUID: 9a6ZSWGXShqdIhbpSqIRfA==
X-CSE-MsgGUID: R/x2h4YiTs2phflBPKaF5w==
X-IronPort-AV: E=Sophos;i="6.08,250,1712613600"; 
   d="scan'208";a="37476347"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Jun 2024 14:23:42 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 19F15160F3E;
	Wed, 19 Jun 2024 14:23:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718799818;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ub8TRoLtI7o1oH6Fs2P1jN0+GX8tw7Fve8YcIfkXSyM=;
	b=MgJdwiPOdrEbVrl1cs9gD3S5VFR+66dGvAJzu9iYcHxKt95SqBKcw8R/bhq3mpOWbieqXV
	zEiC9piBaHX0YPHqaYpXFiq5NtMK3+qGwb+quNGt9ImsSmg4BR/g5nZz50Mt77VLt5l9oE
	NPWwHjwRceEUzFSCecoFpMjvQ0WnqVZaULik4DGVb5b1VJ/yD8XN6+yayMG91HFTSb9U7p
	5hd8sKjnF7hKzXXaGOvW1gludMNbjDCo6JkDK6SHJe7NVODAl56/V9DZKKZP5aMjWJ3jRR
	yxv1JgSL5ZVnSblnBGual/NlVtRri4h8pwcxMedsY3Pa6ZvNznJ/Y/K/tF6mHQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, Markus Niebel <Markus.Niebel@ew.tq-group.com>, Lee Jones <lee@kernel.org>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1 resend] MAINTAINERS: Fix 32-bit i.MX platform paths
Date: Wed, 19 Jun 2024 14:23:36 +0200
Message-ID: <13561511.uLZWGnKmhe@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <2024061920-hardwired-pry-bb81@gregkh>
References: <20240619115610.2045421-1-alexander.stein@ew.tq-group.com> <2024061920-hardwired-pry-bb81@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Mittwoch, 19. Juni 2024, 14:18:35 CEST schrieb Greg KH:
> On Wed, Jun 19, 2024 at 01:56:10PM +0200, Alexander Stein wrote:
> > The original patch was created way before the .dts movement on arch/arm.
> > But it was patch merged after the .dts reorganization. Fix the arch/arm
> > paths accordingly.
> >=20
> > Fixes: 7564efb37346a ("MAINTAINERS: Add entry for TQ-Systems device tre=
es and drivers")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> >  MAINTAINERS | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c36d72143b995..762e97653aa3c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -22930,9 +22930,9 @@ TQ SYSTEMS BOARD & DRIVER SUPPORT
> >  L:	linux@ew.tq-group.com
> >  S:	Supported
> >  W:	https://www.tq-group.com/en/products/tq-embedded/
> > -F:	arch/arm/boot/dts/imx*mba*.dts*
> > -F:	arch/arm/boot/dts/imx*tqma*.dts*
> > -F:	arch/arm/boot/dts/mba*.dtsi
> > +F:	arch/arm/boot/dts/nxp/imx/imx*mba*.dts*
> > +F:	arch/arm/boot/dts/nxp/imx/imx*tqma*.dts*
> > +F:	arch/arm/boot/dts/nxp/imx/mba*.dtsi
> >  F:	arch/arm64/boot/dts/freescale/fsl-*tqml*.dts*
> >  F:	arch/arm64/boot/dts/freescale/imx*mba*.dts*
> >  F:	arch/arm64/boot/dts/freescale/imx*tqma*.dts*
>=20
> Why is a MAINTAINERS change needed for stable kernels?

This fixes the original commit introducing these entries, mainlined in v6.6
Unfortunately that got delayed so much it was merged after commit
724ba67515320 ("ARM: dts: Move .dts files to vendor sub-directories"), which
was merged in v6.5.
Thus the (32-Bit) arm DT paths are incorrect from the very beginning.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



