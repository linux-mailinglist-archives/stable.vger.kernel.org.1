Return-Path: <stable+bounces-238110-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJO1HeN832lAUAAAu9opvQ
	(envelope-from <stable+bounces-238110-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:56:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB39940412C
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0621B3011F2A
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF57937B03F;
	Wed, 15 Apr 2026 11:55:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C58A2BD11;
	Wed, 15 Apr 2026 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776254154; cv=none; b=a2e62n+Fi6wEBj2He9evQvSd2nHPu8S8peYgNTEC4BmIR1mz08JMPTTJ2M0sYRq/S+D+95OvaSCS+Fj1ayBlOl7kB0IVXuV4pJ3YJ+NxH9mIXvcAji2Re8DzWd47K92BOr3qTyl8TMXDT4ZNkN7B3vHIPRxfTPKq6oBL8zIgWrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776254154; c=relaxed/simple;
	bh=v2UqBcnUS3BG0Dga8XdxxXrGCE2SWzervJIigD7T6OI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W+1cvZm7Opb9A5Xtn3JyVAJw92dhDIWDwKTW/vjJp1uBVhomsOGah3YMRaVSAjxW3B83QUa+qsa3NTfeeeYXzZxDNJJnFV3+W5kOtYbfBRexUQjsYY63yCGTj+tkUw+8xX1uRn+byV8Gp20aAL+1xdP2fjDDeN7mCK4qR1HorCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1wCyqT-004yRY-0Q;
	Wed, 15 Apr 2026 11:55:48 +0000
Received: from ben by deadeye with local (Exim 4.99.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1wCyqR-00000003bWW-1DnX;
	Wed, 15 Apr 2026 13:55:47 +0200
Message-ID: <3868fd19d247624c3fc394d4db227234af9f7ab5.camel@decadent.org.uk>
Subject: Re: [PATCH 5.10 189/491] usb: roles: get usb role switch from
 parent only for usb-b-connector
From: Ben Hutchings <ben@decadent.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
  Xu Yang <xu.yang_2@nxp.com>
Cc: patches@lists.linux.dev, stable <stable@kernel.org>, Arnaud Ferraris
	 <arnaud.ferraris@collabora.com>, Heikki Krogerus
	 <heikki.krogerus@linux.intel.com>, Sasha Levin <sashal@kernel.org>
Date: Wed, 15 Apr 2026 13:55:42 +0200
In-Reply-To: <20260413155826.144013004@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
	 <20260413155826.144013004@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-rJ6EvuMzANWeSOpCTlVw"
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
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-238110-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DMARC_NA(0.00)[decadent.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:email,msgid.link:url,intel.com:email,nxp.com:email]
X-Rspamd-Queue-Id: BB39940412C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-rJ6EvuMzANWeSOpCTlVw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-04-13 at 17:57 +0200, Greg Kroah-Hartman wrote:
> 5.10-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> From: Xu Yang <xu.yang_2@nxp.com>
>=20
> [ Upstream commit 8345b1539faa49fcf9c9439c3cbd97dac6eca171 ]
>=20
> usb_role_switch_is_parent() was walking up to the parent node and checkin=
g
> for the "usb-role-switch" property regardless of the type of the passed
> fwnode. This could cause unrelated device nodes to be probed as potential
> role switch parent, leading to spurious matches and "-EPROBE_DEFER" being
> returned infinitely.
>=20
> Till now only Type-B connector node will have a parent node which may
> present "usb-role-switch" property and register the role switch device.
> For Type-C connector node, its parent node will always be a Type-C chip
> device which will never register the role switch device. However, it may
> still present a non-boolean "usb-role-switch =3D <&usb_controller>" prope=
rty
> for historical compatibility.
>=20
> So restrict the helper to only operate on Type-B connector when attemptin=
g
> to get the role switch from parent node.

Is this safe to backport?  It seems like very few device trees on older
branches have the compatible string that will now be required.

Ben.

> Fixes: 6fadd72943b8 ("usb: roles: get usb-role-switch from parent")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> Tested-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Link: https://patch.msgid.link/20260309074313.2809867-3-xu.yang_2@nxp.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [ replace fwnode_device_is_compatible() call with it's expansion ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/usb/roles/class.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> --- a/drivers/usb/roles/class.c
> +++ b/drivers/usb/roles/class.c
> @@ -108,9 +108,14 @@ static void *usb_role_switch_match(struc
>  static struct usb_role_switch *
>  usb_role_switch_is_parent(struct fwnode_handle *fwnode)
>  {
> -	struct fwnode_handle *parent =3D fwnode_get_parent(fwnode);
> +	struct fwnode_handle *parent;
>  	struct device *dev;
> =20
> +	if (fwnode_property_match_string(fwnode, "compatible", "usb-b-connector=
") < 0)
> +		return NULL;
> +
> +	parent =3D fwnode_get_parent(fwnode);
> +
>  	if (!fwnode_property_present(parent, "usb-role-switch")) {
>  		fwnode_handle_put(parent);
>  		return NULL;
>=20
>=20

--=20
Ben Hutchings
The obvious mathematical breakthrough [to break modern encryption]
would be development of an easy way to factor large prime numbers.
                                                           - Bill Gates

--=-rJ6EvuMzANWeSOpCTlVw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmnffL4ACgkQ57/I7JWG
EQmFxg//Z1y+wDce18t88wn55oEqwK32FnVLgzHbx0oRCRVuyuoUPtBd78c8FHkq
auKFkm8AvJ1zf6GMoHjCuYBXqat6DO0Cw/vuv8DHOL7k05DWhFlWTexhp6wq5SeO
Out/yMD+MFj9O6A+JNJBmRendqlF5io3XwZ1UIjtuzZmBQWu3K5M51l+6gcsLoqd
yG3Pf6Z5nsYTeqOT6A4MMdybOzojM9vQ66Fzc5PyLodHCaCJx4nRRBl0xdfJ8SCX
Jhkqg0Fi3WC79euudKEVV116FG02wFheVPytmHcY1Yk1uwxAJzpghoL8kaBzOvI+
350iGKtK1twmQc5+XjEqtvgu6MDsF2ZZiJboUdq1H6J/I45ijE37pkYYuA9p1Qyp
No8nTdgEAJ6p/hxve9yPvsBc5v/Q1mOprAH+N8p05hn6vjSbQQmRH8qkhx25wVvd
0NUgq+VgKLec8thDugPsaqw9ZFYlwSIbwhClxJqU/skfCB5oFMLfmlSXNjKkD5DV
8IO356BdBJP23bQMtItgf1UnVl+4s5uvc6IOjSo3z82KbDzApah8uxL3ej/1K9Vd
GwvJ5WCe6ybDdNqwChBRZss/tUxA4s2LwLSoADg+nNcO+RL6LUTi1oM02fuJ/JQy
fNO0BAYkN/NP7B2S6JRiIkaSSOFGI7LeIoFdZuB6dYXqpmTO8C8=
=gxG2
-----END PGP SIGNATURE-----

--=-rJ6EvuMzANWeSOpCTlVw--

