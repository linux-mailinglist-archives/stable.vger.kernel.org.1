Return-Path: <stable+bounces-211941-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N50FsffeWm50gEAu9opvQ
	(envelope-from <stable+bounces-211941-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 11:07:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9659F3A6
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 11:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27F383068D6F
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 09:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2833434D3A1;
	Wed, 28 Jan 2026 09:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZgjrPHI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA74E222565;
	Wed, 28 Jan 2026 09:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594324; cv=none; b=CS6CUSD7FpcRdJPD8hJ/7O9rZlD1aZc2zmdno8J5XJYbV8qwJYvQfdlhY2H8pPwHCEOYWNvIXruFeVNdBCmYGC71TUvZxE/Mo1szZz3QW6hNyPp2B54rRcZlIggI3mgeh8kMmpiseB6DgnCMw19dosvw6PnVamfqSM0lhkziw1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594324; c=relaxed/simple;
	bh=S+kzbsUAv+9ZIJ9gROnXWuYdug3mDJrjsfqbJmx1oyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBUfdnHurUXmZJLbSICbPLHMHqWpJR1w7p3TEMg6ao5bsa40ZYTL3twsLZd10dQbnX9nmDXxY1pqsaCSLxFi3OQ2A3txVzCFw4JZc4GibOENIKoHW6T2eK0JTB4uc6oIecNt/DdwaqTljBWhd0aeFqTFkNyn8Jlp5OoEjnTEoeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZgjrPHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA03C4CEF1;
	Wed, 28 Jan 2026 09:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769594324;
	bh=S+kzbsUAv+9ZIJ9gROnXWuYdug3mDJrjsfqbJmx1oyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZgjrPHIvRauCS4zCGzFR/1kiUJjREfmbeFXQIh8TesIeDPKJayOjWs5vEge8LVF+
	 AZ7vfN10DR3Loc0192AuZzHRoBJiOnyU7LW+isLs+n81+AOjS2cM3+t4npaX3c46RE
	 7muag92gaobKB7dJQrwUEIG59sgcX4czzchjkHXURZaH/d92/oYCnWivqjm7+NisEA
	 Q4umbhq3/ujNgDHoUrCccTc15QfZVI5MvSYHGCVBWuXw/REnZAduQP7Lu/HS/3B0yX
	 f0f1O3hwrF4bNEyTwlTGsVwG3ArXaOQOFEEqpsUTZaouOIRVdCZdHnJlxmIxOKKl6i
	 0OX+DlyrGosmQ==
Date: Wed, 28 Jan 2026 10:58:41 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2] drm/imx/tve: fix probe device leak
Message-ID: <20260128-inchworm-of-fascinating-enthusiasm-de5ab2@houat>
References: <20251030163456.15807-1-johan@kernel.org>
 <aR8TWJurF1a0LLGJ@hovoldconsulting.com>
 <aWd2xizOQAnVRaSs@hovoldconsulting.com>
 <aXjg2C0XeVGEtdDy@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="lpelexmbpijxrpns"
Content-Disposition: inline
In-Reply-To: <aXjg2C0XeVGEtdDy@hovoldconsulting.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211941-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,linux.intel.com,suse.de,gmail.com,ffwll.ch,lists.freedesktop.org,lists.linux.dev,vger.kernel.org,nxp.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mripard@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: 9E9659F3A6
X-Rspamd-Action: no action


--lpelexmbpijxrpns
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] drm/imx/tve: fix probe device leak
MIME-Version: 1.0

Hi,

On Tue, Jan 27, 2026 at 04:59:20PM +0100, Johan Hovold wrote:
> On Wed, Jan 14, 2026 at 11:58:14AM +0100, Johan Hovold wrote:
> > On Thu, Nov 20, 2025 at 02:10:48PM +0100, Johan Hovold wrote:
> > > On Thu, Oct 30, 2025 at 05:34:56PM +0100, Johan Hovold wrote:
> > > > Make sure to drop the reference taken to the DDC device during prob=
e on
> > > > probe failure (e.g. probe deferral) and on driver unbind.
> > > >=20
> > > > Fixes: fcbc51e54d2a ("staging: drm/imx: Add support for Television =
Encoder (TVEv2)")
> > > > Cc: stable@vger.kernel.org	# 3.10
> > > > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > > > ---
> > > >=20
> > > > Changes in v2:
> > > >  - add missing NULL ddc check
> > >=20
> > > Can this one be picked up for 6.19?
> >=20
> > It's been two more months so sending another reminder.
> >=20
> > Can this one be merged now?
>=20
> Can someone please merge this for 6.20?

I'm not sure what went wrong, but I just applied it. It should end up in
6.19.

Maxime

--lpelexmbpijxrpns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaXnd0QAKCRAnX84Zoj2+
dsV1AX9BFigou9HGowx/ngN6YjSXQ5Rff4NddhPSZcqx3xHqGrrWdRHACfLWnB2l
Jgv0sXUBfjNJajMrRR/Xk+iEilujyUH/t0vyCgIuBps5wF4bv3JnenqhEhH6FomS
GvuA1Y2Hvw==
=rF9r
-----END PGP SIGNATURE-----

--lpelexmbpijxrpns--

