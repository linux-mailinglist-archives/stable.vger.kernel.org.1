Return-Path: <stable+bounces-259638-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UInTFn3JHWrHeQkAu9opvQ
	(envelope-from <stable+bounces-259638-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 20:03:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5049623ADB
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 20:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 941EF30E2DE9
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 17:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499413EDAD1;
	Mon,  1 Jun 2026 17:54:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCBD3E95B2;
	Mon,  1 Jun 2026 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336495; cv=none; b=Z8NGwZzhyD9O7FpeLetUbpp+W7MCcQ6W1RpkdhSzanpHD4Hg9ZytvkgYBSKJmYQme+NEmmbDVnH7zB7+hrA/5NgbMjvori0AB7mYysOu33wjFhM1yGAqAW0R0xXPh3uWY57Cq6eF2TKLpI6rrYYIdg2juwP/ygWuahoj13JOgiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336495; c=relaxed/simple;
	bh=Aq8PSN71PGj5mwkYvwEYGP4oPUfEvZw50FSae1nP2sc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nvSQ3UDO6D445M1HhuKaWkNnUV3tEQ56EFGa1M5nYsTS570ZTNi4lfTGBuP0YzkC4EI+kaSG0R4+Ji+OX9YBsQVIkhB7OOC/WVwiUJYWHZlkCkV80JA8nb5a7L+NyIYRz0xHXtMQCnurw2sAda+Z4MImMh4tp7ALm9Dj5DexqC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1wU6qg-000X3d-0J;
	Mon, 01 Jun 2026 17:54:50 +0000
Received: from ben by deadeye with local (Exim 4.99.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1wU6qf-0000000Fmln-0o0O;
	Mon, 01 Jun 2026 19:54:49 +0200
Message-ID: <dbb2510d89e3545af204a7bf3eac06512042120e.camel@decadent.org.uk>
Subject: Re: [PATCH 5.10 267/589] media: rc: streamzap: Error handling in
 probe
From: Ben Hutchings <ben@decadent.org.uk>
To: Oliver Neukum <oneukum@suse.com>
Cc: patches@lists.linux.dev, Sean Young <sean@mess.org>, Hans Verkuil	
 <hverkuil+cisco@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  stable <stable@vger.kernel.org>
Date: Mon, 01 Jun 2026 19:54:43 +0200
In-Reply-To: <20260530160232.006498371@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
	 <20260530160232.006498371@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-BC5sKzpuLpm9MlqUkVTe"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spamd-Result: default: False [-2.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259638-lists,stable=lfdr.de];
	DMARC_NA(0.00)[decadent.org.uk];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,decadent.org.uk:mid,suse.com:email]
X-Rspamd-Queue-Id: B5049623ADB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-BC5sKzpuLpm9MlqUkVTe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-05-30 at 18:02 +0200, Greg Kroah-Hartman wrote:
> 5.10-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> From: Oliver Neukum <oneukum@suse.com>
>=20
> commit 42844992664f03ef9f930e64f7370fa481e9c267 upstream.
>=20
> If submitting the URB fails, the device will be unusable.
> Probe() must fail.
[...]
> @@ -398,11 +397,16 @@ static int streamzap_probe(struct usb_in
> =20
>  	usb_set_intfdata(intf, sz);
> =20
> -	if (usb_submit_urb(sz->urb_in, GFP_ATOMIC))
> +	retval =3D usb_submit_urb(sz->urb_in, GFP_ATOMIC);
> +	if (retval < 0) {
>  		dev_err(sz->dev, "urb submit failed\n");
> +		goto rc_submit_fail;
> +	}
> =20
>  	return 0;
> -
> +rc_submit_fail:
> +	rc_free_device(sz->rdev);

Shouldn't this be rc_unregister_device()?

Ben.

> +	usb_set_intfdata(intf, NULL);
>  rc_dev_fail:
>  	usb_free_urb(sz->urb_in);
>  free_buf_in:
>=20
>=20

--=20
Ben Hutchings
The obvious mathematical breakthrough [to break modern encryption]
would be development of an easy way to factor large prime numbers.
                                                           - Bill Gates

--=-BC5sKzpuLpm9MlqUkVTe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmodx2MACgkQ57/I7JWG
EQnvng/+NQNtKNN94AxU3SI4tGCps5XKCai41Yu68Ai7T35M4a5bSV3QE7LJXAXB
+KwZsCE5sd/uzE0BvrrYMJTIN45t5f18N7JcurfvZ3SPYdMf+X8BAC9ZqQY7MWsV
iKHQmCD9l6yKHM6LGJrTGj1+bObNNiBm6nqaB2UupQJE5HwyYjgzgRZ0xRKFljfd
lntvqbF1Cih0A//Y2dGEp7vpUzoT0sZFo8beekD/L7JDel/zk8yKiFIj0eN97C8x
xfNp63FW8h3UfWQSGFFi+dWdkQe7w1kfZLCzej8yQM2By2/8Z03yxVffAtaYRyS6
BRInRaN1lUpY3kAksW7BHz/OUeny86HX5fFhhOs2h6Er4GJvMfifYAvZKSUe4uA9
q1sJlSrUJIkuRa/sG0G/fPdST1AjbzeItl4MCeuB3ramKDcutpm7VoWqXIYtToAh
d+OuiHwHortSlAlBmR5tgLISFka/iD/v4PU+V4/po1AYhfbYPiRCjNnnIYFvbS8h
tGwwqFFwit8xEG+uPjeQquXOjk6acbyoIVk90xQLSGceXFW9D7+kIGnocWenmcVh
3RHSr5bzmAzig52dyDd/b+00jSxeC16clEE9Up9HUiPbxWEYB0Qw9KsyZ6z7f0mO
S0E1pUqzzM/tMOOZsTc/MWo6O1W/VQvQjVqlAP8QCdN+7+bC2hg=
=K4bF
-----END PGP SIGNATURE-----

--=-BC5sKzpuLpm9MlqUkVTe--

