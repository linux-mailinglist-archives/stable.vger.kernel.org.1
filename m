Return-Path: <stable+bounces-211944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK+BADfgeWm50gEAu9opvQ
	(envelope-from <stable+bounces-211944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 11:08:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFDB9F407
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 11:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A1CE302FAAB
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 10:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452032D0C84;
	Wed, 28 Jan 2026 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6h34WAW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9082C21FE;
	Wed, 28 Jan 2026 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594601; cv=none; b=GK5iP8WlWc8g011hhPhwF2IVt9wcWpZPgtnfxWsWN7Ran+qhLfKWP4iJm1JSeAXbsrMYVU/aukjpoic4Xh57CWT4dVG2EAoUJVvs/Uuc0B2uH+GXdhwUtSbrbNOxd/3/Dc2Pzy3/hlf63P62OyWgsdrcKrwYwPWPbuF+YseRvf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594601; c=relaxed/simple;
	bh=AZ+G2n1H7iZMtDW62AcAI4EgJDI28l5C/OSZDSSn/NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+EJKllzLO/RX23X42mx5u9+vITUp1LmbguCMqy2E2aArPoYzx4F/dlELgHEFJt9XUVzdA0MYg3Nsep7p86Xq39ClE7IkZ6XA1QrZJI90VkBeWijfvCfJNFWzY7h2fvqR/lduwyjJqpaogkXT+dUtxpBX2OAl5Um8/RIb0sFVmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6h34WAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01E5C4CEF1;
	Wed, 28 Jan 2026 10:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769594600;
	bh=AZ+G2n1H7iZMtDW62AcAI4EgJDI28l5C/OSZDSSn/NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W6h34WAW9FilZFbvanBuoTC9l6Ab8gyYkTTvLteaQzdxm84d2Ubrmq0UnuO+yDvDh
	 1/6TENRAU1xAz9SUW1D/q2PU7S+lpfRBcBWItV4Yvfs7Ohq+EMveg9MPxlp/nni5BF
	 kofD+nGjrbMKrZI07XxG6z2GS13qD++eQX1hQuLSiRwan9smVJaNGYMxVQ0Vkt1TyM
	 e1BBOTGD5VaqtakMnC+GKeInrqUq4cucmohTCqpfEtz8fqz3usjTkCSO/gRyY9wu+l
	 ooBazBuqo7dd5Sm7OJerCVnwaW71g/JV1X/5yG/6hWqNTh7iNChMOAkakQH1Ri2OnE
	 hUhBPfWv/ZgKw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vl2OG-000000005sl-0ZkC;
	Wed, 28 Jan 2026 11:03:12 +0100
Date: Wed, 28 Jan 2026 11:03:12 +0100
From: Johan Hovold <johan@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2] drm/imx/tve: fix probe device leak
Message-ID: <aXne4DIURKOMQ0gG@hovoldconsulting.com>
References: <20251030163456.15807-1-johan@kernel.org>
 <aR8TWJurF1a0LLGJ@hovoldconsulting.com>
 <aWd2xizOQAnVRaSs@hovoldconsulting.com>
 <aXjg2C0XeVGEtdDy@hovoldconsulting.com>
 <20260128-inchworm-of-fascinating-enthusiasm-de5ab2@houat>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QFGDsgi8T3Q4koif"
Content-Disposition: inline
In-Reply-To: <20260128-inchworm-of-fascinating-enthusiasm-de5ab2@houat>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211944-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[pengutronix.de,linux.intel.com,suse.de,gmail.com,ffwll.ch,lists.freedesktop.org,lists.linux.dev,vger.kernel.org,nxp.com];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,pengutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hovoldconsulting.com:mid]
X-Rspamd-Queue-Id: 4FFDB9F407
X-Rspamd-Action: no action


--QFGDsgi8T3Q4koif
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 10:58:41AM +0100, Maxime Ripard wrote:
> Hi,
>=20
> On Tue, Jan 27, 2026 at 04:59:20PM +0100, Johan Hovold wrote:
> > On Wed, Jan 14, 2026 at 11:58:14AM +0100, Johan Hovold wrote:
> > > On Thu, Nov 20, 2025 at 02:10:48PM +0100, Johan Hovold wrote:
> > > > On Thu, Oct 30, 2025 at 05:34:56PM +0100, Johan Hovold wrote:
> > > > > Make sure to drop the reference taken to the DDC device during pr=
obe on
> > > > > probe failure (e.g. probe deferral) and on driver unbind.
> > > > >=20
> > > > > Fixes: fcbc51e54d2a ("staging: drm/imx: Add support for Televisio=
n Encoder (TVEv2)")
> > > > > Cc: stable@vger.kernel.org	# 3.10
> > > > > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > > > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > > > > ---
> > > > >=20
> > > > > Changes in v2:
> > > > >  - add missing NULL ddc check
> > > >=20
> > > > Can this one be picked up for 6.19?
> > >=20
> > > It's been two more months so sending another reminder.
> > >=20
> > > Can this one be merged now?
> >=20
> > Can someone please merge this for 6.20?
>=20
> I'm not sure what went wrong, but I just applied it. It should end up in
> 6.19.

Thanks, Maxime.

Johan

--QFGDsgi8T3Q4koif
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCaXne3BsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQC8XNwux9ZQhmrwD/dHjD06shoLG8q1QsEcQp
DoBYWhA8S4AEi/XcZp5AMtwA/24TN9ZoDNU3rcJ7aveBPM/5PIT3JBQJUZKPEY0J
xqMM
=HQx8
-----END PGP SIGNATURE-----

--QFGDsgi8T3Q4koif--

