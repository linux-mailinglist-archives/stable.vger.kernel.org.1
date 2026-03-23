Return-Path: <stable+bounces-228843-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iM96HslpwWmoSwQAu9opvQ
	(envelope-from <stable+bounces-228843-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:26:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F1F2F8188
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55A17325B2CE
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E133AE6E6;
	Mon, 23 Mar 2026 14:48:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A877F3AF678
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 14:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277282; cv=none; b=DTg+S8FBXpLDAGqByQuL+A80NhtxtYUnU77nOQhbGPoDKNoWqfr4sy2e0fPaWxjImkzBPEZDYjMOBIFet5T7TuMWXCWkVPmTFRHvN6ZdMRrsRL+YrTuhXb2xQJlfS4OerS/B9xzOfkY3Y7yxFVWyiKppFQ7t0NRdKXD1U2P2ElE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277282; c=relaxed/simple;
	bh=KRhWMY0D4yhGWFmKo7SIP64MOjxHmC4RNBxgbfWI36k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dgjeym9keNVM5UxJfwuydso0Y5YH2xzkbeg5EokAp3m6ASmSmKz5SOeaEVhu8izkRwczr3VNe6VGUbw36+iJlMtwumkkxat/5GRMULkYoxgg3n+6g+WDW18JOi0G08oc8bTyBqkQ2PWc7l53k+hN6C6ND6tTG6fmOCd3bhthXZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4gZG-0008Jq-WB; Mon, 23 Mar 2026 15:47:47 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4gZG-001kFp-1W;
	Mon, 23 Mar 2026 15:47:46 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2C7C050ABB1;
	Mon, 23 Mar 2026 14:47:46 +0000 (UTC)
Date: Mon, 23 Mar 2026 15:47:45 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Johan Hovold <johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>, 
	Laxman Dewangan <ldewangan@nvidia.com>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/5] spi: imx: fix use-after-free on unbind
Message-ID: <20260323-kickass-original-wapiti-a01804-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260323104948.844583-1-johan@kernel.org>
 <20260323104948.844583-2-johan@kernel.org>
 <20260323-demonic-worthy-guillemot-c2abb8-mkl@pengutronix.de>
 <acEh6KiKMfBehoZO@hovoldconsulting.com>
 <20260323-dangerous-brown-polecat-a4988f-mkl@pengutronix.de>
 <acFHVTsDIbQm6GG6@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3bczsw4zpehoor7x"
Content-Disposition: inline
In-Reply-To: <acFHVTsDIbQm6GG6@hovoldconsulting.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228843-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,pengutronix.de:mid,pengutronix.de:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0F1F2F8188
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--3bczsw4zpehoor7x
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] spi: imx: fix use-after-free on unbind
MIME-Version: 1.0

On 23.03.2026 14:59:49, Johan Hovold wrote:
> On Mon, Mar 23, 2026 at 12:57:42PM +0100, Marc Kleine-Budde wrote:
> > On 23.03.2026 12:20:08, Johan Hovold wrote:
> > > On Mon, Mar 23, 2026 at 12:00:59PM +0100, Marc Kleine-Budde wrote:
> > > > On 23.03.2026 11:49:44, Johan Hovold wrote:
> > > > > The SPI subsystem frees the controller and any subsystem allocated
> > > > > driver data as part of deregistration (unless the allocation is d=
evice
> > > > > managed).
> > > > >
> > > > > Take another reference before deregistering the controller so tha=
t the
> > > > > driver data is not freed until the driver is done with it.
> > > >
> > > > Would re-ordering the spi_imx_remove() function be an alternative f=
ix?
> > > > I.e. call spi_unregister_controller() last?
> > >
> > > No, the controller needs to be deregistered before disabling clocks a=
nd
> > > releasing other resources.
> >
> > I see. So the API is a bit strange to use:
> >
> > Allocate with spi_alloc_host(), free with spi_controller_put() before
> > spi_register_controller(), the free with spi_unregister_controller()
> > afterwards.
> >
> > But spi_unregister_controller() shuts down the SPI interface _and_ frees
> > the memory. Which is the culprit here.
>
> Indeed, it's a known issue with the SPI API. See for example:
>
> 	68b892f1fdc4 ("spi: document odd controller reference handling")
> 	5e844cc37a5c ("spi: Introduce device-managed SPI controller allocation")
> 	f0c35a024cce ("spi: fix misleading controller deregistration kernel-doc")
>
> > Would using devm_spi_alloc_host() be an option here?
>
> It can also be used, but that's more intrusive so I did that as a
> follow-on cleanup to the fix (see patch 2/5).

Ah, nice! At the time I replied to the patch, the whole series was not
available on lore, yet.

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

And thanks for taking the time in explaining me the details :)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3bczsw4zpehoor7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCacFSjwAKCRDMOmT6rpmt
0jH5AP4hVLzgh7/KCvS63tENtlYD/gBthypUPqjQU1yH9ekz8AD+ILG7/baVx/CU
a1jobkWC7TfT0gUTX6hEpNk1YdY0dgM=
=SyjM
-----END PGP SIGNATURE-----

--3bczsw4zpehoor7x--

