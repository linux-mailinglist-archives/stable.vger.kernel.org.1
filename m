Return-Path: <stable+bounces-255011-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGuxCBhMGGr4iggAu9opvQ
	(envelope-from <stable+bounces-255011-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:07:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 910E05F3604
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89C673148627
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744E5286891;
	Thu, 28 May 2026 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbHPh2+E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D7A285CB4;
	Thu, 28 May 2026 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976696; cv=none; b=IFvTytCjcsV5UjoHewm2/xwJ3f+EfPyiVk2wuppe6FylDc5WZEBVXHD/x40bY0fdI6vVKxRXdg/By/89d97dl5aF0r2b34SOBs/l7klWABSi7RPFDBC+1WjAbS+RseBQlCQkG5+8+SKkKT+Vg2CpblWBgqQeTz425jUNhOfIlY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976696; c=relaxed/simple;
	bh=k0e4japtXqt/7wTvfA6CpC/gU9E40uoXkaunCPNcO2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeJBCmg4yrnHj+12VgTQOIOBrtsS4iodn5DX+GkvztfYcuq1TxdFmunjwHcCJyDSVvJ+1dfHKCfq2s5UxbPsXnvAilO87AVoa8vW0n4qh5zVAGRPV2oAZa183gyeHQD2SeVhoOGU1I2W1fndNjoTGEYhMme+CZYoFAC8SxFoCfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbHPh2+E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2921F000E9;
	Thu, 28 May 2026 13:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779976694;
	bh=lHC/FW7tnteRVtutAnHZv6iVlMg+BbUjWq+ubu9W2Uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XbHPh2+E2OGIwRPj70BzxHGm0COOLjIGDv6+Q7v6tJJmQmvTIukdU5NRlDbCXCD1v
	 lVhqjIjA1ZEhcK4+CwAedkOnP2eoC1CeCEy7OHeEMqYdp7CrjWQ4uw7bWKueifWQRV
	 e9XMaLZqeKNO69qdwDyx9fxIaVN3WS+QfJs0zzzU24KAg4ZJMH+RPJKy6oE5jsyGtT
	 99E6Y2ATljuyyu3KxxuRphhaKShcr0uK68n3yWFnBk6a6eq/KkxjeeeQIThcCCbFP/
	 OuCVS2u+UiYng9DBFGMEslQNY3N7pB2i9K+0TjugBfXuY9fY6Uu6O8JYzO6pI2f6mZ
	 XGSIDL2ZyNasQ==
Date: Thu, 28 May 2026 15:58:12 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Mark Zhang <markz@nvidia.com>, Sean Paul <seanpaul@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3] gpu: host1x: Fix device reference leak in
 host1x_device_parse_dt() error path
Message-ID: <ahhJ6Uo5qHfn0CBg@orome>
References: <20260413141526.2961841-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kcchf3ioudov7kum"
Content-Disposition: inline
In-Reply-To: <20260413141526.2961841-1-lgs201920130244@gmail.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255011-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,ffwll.ch,chromium.org,lists.freedesktop.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thierry.reding@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 910E05F3604
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--kcchf3ioudov7kum
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] gpu: host1x: Fix device reference leak in
 host1x_device_parse_dt() error path
MIME-Version: 1.0

On Mon, Apr 13, 2026 at 10:15:26PM +0800, Guangshuo Li wrote:
> After device_initialize(), the embedded struct device in struct
> host1x_device should be released through the device core with
> put_device().
>=20
> In host1x_device_add(), if host1x_device_parse_dt() fails, the current
> error path frees the object directly with kfree(device). That bypasses
> the normal device lifetime handling and leaks the reference held on the
> embedded struct device.
>=20
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>=20
> Fix this by using put_device() in the host1x_device_parse_dt() failure
> path.
>=20
> Fixes: f4c5cf88fbd50 ("gpu: host1x: Provide a proper struct bus_type")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v3:
>   - note that the issue was identified by my static analysis tool
>   - and confirmed by manual review
>=20
> v2:
>   - add Cc: stable@vger.kernel.org
>=20
>  drivers/gpu/host1x/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--kcchf3ioudov7kum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoYSfQACgkQ3SOs138+
s6G23Q//VVEOmgeC4pq1oP4zmKOzGSMNrQQw6ocVaJnDBex8C/JZv3p0LENKt0Ci
N4mBgQ3uHYceV4B47TWfeiyKe5Hk2Q6Cm+YBVi1/AJ8bg7lMkxJpI08pdv6jMYgc
cl2fKIpRFZi+MccCZw6QtIH2O9+yg4LpLYFZ5BU9ma4dEzhyqpYYWf+I4h+WirEI
b4fWCD60kERAfpF7i3Itqsq+iQdehu28h97gczDZRIiI0o6xeJYZll+woDtyq6QE
eT6vKAoRpLsdaDjyg4qPyyJ+o7KkFQnonfmqrOS1DhWLhTTrHpQfTeJbBhlCB3aD
kDBThYlQAU4Zjo+dQYez2iho1xPF5jyYzipFEdNWAqfBEBAFAtZECP/+v+0oDBLZ
8G9Mt5Pzz7sqQFNHszf2quySJl9Qrqvr6BcjqIr30GTGgTVTyniODwFzDmpTLnvc
hQwNWvuYuqFI+jQ+CC7jl0amPIZsW9Yi+w2HJ0NtchK2p0yVXQ2lIWF7xeRuf5JE
Gxil6d1/PN5LqSPXCQ9S1Fnk8xODUzrX1IACsqVTKyonfy130rDZBzSaYsnA31rE
wqENcv5e1qRo7Z9bZ5REYQfsibhU0HtMP2DJ8cgpJgPQHqIpB//bdTCqrtbTIWwx
O1FPLIvHT5WI2GuN+MkqIiiSTU5UHa3dbJuOyh9oy/E/BaP2PuA=
=16zP
-----END PGP SIGNATURE-----

--kcchf3ioudov7kum--

