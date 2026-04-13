Return-Path: <stable+bounces-235949-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KByqETOi3GkEUgkAu9opvQ
	(envelope-from <stable+bounces-235949-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 09:58:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B92E3E89F3
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 09:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BED543004D25
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 07:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB4339B484;
	Mon, 13 Apr 2026 07:57:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from algol.kleine-koenig.org (algol.kleine-koenig.org [162.55.41.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F89B3932FF;
	Mon, 13 Apr 2026 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.41.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067025; cv=none; b=KycBOpy1A1ac33Vcv71q/rYhV8RkeFJHC5Iy8BxhgiZafoTOiyO/63VCESbesKB8FzYG1XrofQXkN0fDVhEHK17J+6tjkbFCeaKbwLV3SfIXN7z4i87JCsRRVu3Svp2bRdc+llR4VHVWtSijW7HdNtY2FavsoVoPVGyT6n3PbOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067025; c=relaxed/simple;
	bh=pnI+xxVxDqXDIhTjkgLxIPlUhrTxzcIQbkFUGrxtmtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLpVe0pQhxJr3AjaQASfQ1HVWCXKHme3jTKhcX9ANsV+d8pSQEujzOBSzz0c8ziNdA+OW4RRnVSyyngW1tSvtQtxWUU94Y0BvBpEw19VXDKJkiza5Lm6HCu8ceNk77l5bOK0zbvlo210KhQVd2PviTsVj1acrIJQM8IgmBTtSzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=kleine-koenig.org; arc=none smtp.client-ip=162.55.41.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kleine-koenig.org
Received: by algol.kleine-koenig.org (Postfix, from userid 1000)
	id D5F491193CA6; Mon, 13 Apr 2026 09:47:04 +0200 (CEST)
Date: Mon, 13 Apr 2026 09:47:04 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] counter: Fix refcount leak in counter_alloc() error path
Message-ID: <adyb3Cdr1p3p76h6@monoceros>
References: <20260411133511.2214024-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kpnjgihwq7j2npzh"
Content-Disposition: inline
In-Reply-To: <20260411133511.2214024-1-lgs201920130244@gmail.com>
X-Spamd-Result: default: False [-3.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-235949-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@pengutronix.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B92E3E89F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--kpnjgihwq7j2npzh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] counter: Fix refcount leak in counter_alloc() error path
MIME-Version: 1.0

Hello,

On Sat, Apr 11, 2026 at 09:35:11PM +0800, Guangshuo Li wrote:
> After device_initialize(), the lifetime of the embedded struct device
> is expected to be managed through the device core reference counting.
>=20
> In counter_alloc(), if dev_set_name() fails after device_initialize(),
> the error path removes the chrdev, frees the ID, and frees the backing
> allocation directly instead of releasing the device reference with
> put_device(). This bypasses the normal device lifetime rules and may
> leave the reference count of the embedded struct device unbalanced,
> resulting in a refcount leak and potentially leading to a use-after-free.
>=20
> Fix this by using put_device() in the dev_set_name() failure path and
> let counter_device_release() handle the final cleanup.
>=20
> Fixes: 4da08477ea1f ("counter: Set counter device name")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/counter/counter-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-cor=
e.c
> index 50bd30ba3d03..12dc18c78672 100644
> --- a/drivers/counter/counter-core.c
> +++ b/drivers/counter/counter-core.c
> @@ -123,10 +123,10 @@ struct counter_device *counter_alloc(size_t sizeof_=
priv)
>  	return counter;
> =20
>  err_dev_set_name:
> +	put_device(dev);
> +	return NULL;
> =20
> -	counter_chrdev_remove(counter);
>  err_chrdev_add:
> -
>  	ida_free(&counter_ida, dev->id);
>  err_ida_alloc:

This patch is technically correct. Looking in more detail however I
wonder why 4da08477ea1f ("counter: Set counter device name") was created
in the presence of

	static const struct bus_type counter_bus_type =3D {
		...
		.dev_name =3D "counter",
	};

	int device_add(struct device *dev)
	{
		...
		if (dev->bus && dev->bus->dev_name)
			error =3D dev_set_name(dev, "%s%u", dev->bus->dev_name, dev->id);
		...
	}

The only upside I can see is that the name is already set before
device_add() is called.=20

Assuming the dev_set_name() call should be kept, I think that

diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 50bd30ba3d03..69f042ce4418 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -114,12 +114,12 @@ struct counter_device *counter_alloc(size_t sizeof_pr=
iv)
 	if (err < 0)
 		goto err_chrdev_add;
=20
-	device_initialize(dev);
-
 	err =3D dev_set_name(dev, COUNTER_NAME "%d", dev->id);
 	if (err)
 		goto err_dev_set_name;
=20
+	device_initialize(dev);
+
 	return counter;
=20
 err_dev_set_name:

also fixes the issue.

Best regards
Uwe

--kpnjgihwq7j2npzh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmncn3YACgkQj4D7WH0S
/k6Fawf/X+HU86tYVBm8GkrsWc4YJnj8yB87NGb1+LPlDl39GNeWt4bpu9z7JA4h
hdLRWcdY6COMe9WQ9T99uie9ZASjlsnlCVGwZ/THTVVrT9Wew3eDwbBoO6SEmSzD
BlV476vO0XLV2+L7KfDS9g8BVMy8lM6+F6mR7deucbdgHFajD6KCV+cj+aRMjY4U
92eBMQz58MB+4lE/W0oTww5I6Ev+U2wyV/vTbeeHYbGsMGU0UbTMz+ds9D+x5PIR
oz01Wh+uLc5+zYkYx1EJEvCDYcGcGY5IpwfJlI+FbVmGz9Ol9AVsjocQfjRM7bVT
OkA7yn14UYSsyaz9fEc1HOKmOq+eug==
=qbIY
-----END PGP SIGNATURE-----

--kpnjgihwq7j2npzh--

