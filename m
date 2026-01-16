Return-Path: <stable+bounces-210076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F88DD33A84
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 18:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1EF2B302AFD6
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 17:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F0B39A7E0;
	Fri, 16 Jan 2026 17:02:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9F6369220
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582973; cv=none; b=AmFOm5UhGKQFX+oqfkQZ0oSNNE1sGPbIwng90RPAtnwvoxZjg2U9VqqqasBRzNoR1401P0s5M15/KYsuiN642LRt5YuZ25TNFmwhmP72LbgVJ4+rGN2W36QYixPDNxD/5ij8+VDCupYJZ0rWydEgm6W33B8VHGjb7v7FfIDcON0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582973; c=relaxed/simple;
	bh=IbEwciyhwpuFm15AlQJawIlmJViOLsYtHhvUF9Fj/A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdK4azuZOSsI4GIWuCjayrSYNht2NgGgCKcjxtfr9fUrNEsk6uykMxTouBzSYprg5nZTQy0gvV80qJmIWLFP0ypELJYQxuMU4thcn1lDJus5s151R52uYc846khiQh8I9yCZsdivuEpdtLFTOrIbSVDmLt7beOTBEbzfK+4KLL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgnDb-0005cz-Lr; Fri, 16 Jan 2026 18:02:39 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgnDa-000xLS-2u;
	Fri, 16 Jan 2026 18:02:38 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DC1684CED52;
	Fri, 16 Jan 2026 17:02:37 +0000 (UTC)
Date: Fri, 16 Jan 2026 18:02:37 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, mailhol@kernel.org, ondrej.ille@gmail.com, 
	linux-can@vger.kernel.org, davem@davemloft.net, kernel@pengutronix.de, 
	swilczek.lx@gmail.com, pisa@fel.cvut.cz, 
	syzbot+e8cb6691a7cf68256cb8@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [net,2/3] can: gs_usb: gs_usb_receive_bulk_callback(): fix URB
 memory leak
Message-ID: <20260116-analytic-splendid-frigatebird-5cb087-mkl@pengutronix.de>
References: <20260109135311.576033-3-mkl@pengutronix.de>
 <20260110223836.3890248-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2tzpgghhms3g6g7m"
Content-Disposition: inline
In-Reply-To: <20260110223836.3890248-1-kuba@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org


--2tzpgghhms3g6g7m
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [net,2/3] can: gs_usb: gs_usb_receive_bulk_callback(): fix URB
 memory leak
MIME-Version: 1.0

On 10.01.2026 14:38:36, Jakub Kicinski wrote:
> This is an AI-generated review of your patch.
> > diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> > index a0233e550a5a..d093babbc320 100644
> > --- a/drivers/net/can/usb/gs_usb.c
> > +++ b/drivers/net/can/usb/gs_usb.c
> > @@ -751,6 +751,8 @@ static void gs_usb_receive_bulk_callback(struct urb=
 *urb)
> >  			  hf, parent->hf_size_rx,
> >  			  gs_usb_receive_bulk_callback, parent);
> >
> > +	usb_anchor_urb(urb, &parent->rx_submitted);
> > +
> >  	rc =3D usb_submit_urb(urb, GFP_ATOMIC);
>
> If usb_submit_urb() fails here, the URB remains anchored but is never
> submitted. When gs_can_close() later calls usb_kill_anchored_urbs(), it
> iterates over anchored URBs and calls usb_kill_urb() on each one. For URBs
> that were never successfully submitted, use_count is 0, so usb_kill_urb()
> returns without unanchoring them. This causes usb_kill_anchored_urbs() to
> loop infinitely on the same URB since the anchor list never becomes empty.

Good AI!

Here's the patch to fix the problem. I'll include this in my next PR.

| https://lore.kernel.org/all/20260116-can_usb-fix-reanchor-v1-1-9d74e72892=
25@pengutronix.de/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2tzpgghhms3g6g7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlqbyoACgkQDHRl3/mQ
kZyTBAgAt8SmEwKz5wQOu3K6wbfoIm+Ps1df8mjyWiSOPp2qs4Xhrx/MJ8pwtfiv
sPXH2JOFa/aOcQL1i7Xx7IsCuThNWylvSWKu+JBpSGkDWk1O4y8WobvLPwmo4Mh1
ToZvsfvf36BbapKSfk2mvjOF01dDCGDewai2NrRyzVqfP6aHHtS5dpEFEBTyhhkz
hh2DBCvxiqUXGxH1/sPbnolOZnd0YPrM3t40axXkS7J8an1LqnhNKShMhU1sqZKe
RUy/jIIBnkomyC6R8/PTRwIi/mucsL93+LiBGFoKSIdN7WOLJXTfmQlvoDzcyKWD
UI9oL8Tw7hRKfGQhIIH4I1sVQgGcVw==
=pvan
-----END PGP SIGNATURE-----

--2tzpgghhms3g6g7m--

