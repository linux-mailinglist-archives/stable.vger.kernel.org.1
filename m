Return-Path: <stable+bounces-268681-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ysWGFlqxPWrA5ggAu9opvQ
	(envelope-from <stable+bounces-268681-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 00:53:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A993B6C910A
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 00:53:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268681-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268681-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE47A302DA0F
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 22:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28BA37756C;
	Thu, 25 Jun 2026 22:53:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0368332EBC;
	Thu, 25 Jun 2026 22:53:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782427988; cv=none; b=WN4+s/SdfPT06cv9wRKiAuxYDtzRZR81UryQ3Qe45LDa2X3RgvRRtBFo/dAiMdzAyCQQDDeYs/l3OVTwv6SwI3weUFrFQ5Re9XoiywblXUgnyDr2VTygcn8dDqANroxAJD74YTmYxluvbPNhB9Se1kAPgnd6DJ1YqUoDiBm8ulU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782427988; c=relaxed/simple;
	bh=XjLZN3lDklgtmkPOwZ87MbAnn4N/2RXd3aR3mdyxhFM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j5ANMgda5TnrevkuQLjAPfm2NHcP/UIQ0eNOB3MHceAa6qB57opmh3JC21SIqZl151o52Tu1dAGlNo7N9F3EyzZrjtC3u5xCHh2CgZ+H4v8ZFoiGnO/pDXvQ7zIbbX9gZLAXlHpwVJ/JRpfbvCU+xkL9QvqoIrt7sSvrDMIXKHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1wcswS-004N2n-2l;
	Thu, 25 Jun 2026 22:53:04 +0000
Received: from ben by deadeye with local (Exim 4.99.3)
	(envelope-from <ben@decadent.org.uk>)
	id 1wcswR-00000008lwY-0ktQ;
	Fri, 26 Jun 2026 00:53:03 +0200
Message-ID: <72890f3caf368d0e4dcb5d1ec53c083c16ce8b20.camel@decadent.org.uk>
Subject: Re: [PATCH 5.10 310/342] usb: typec: ucsi: Dont update power_supply
 on power role change if not connected
From: Ben Hutchings <ben@decadent.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, stable <stable@kernel.org>, Myrrh Periwinkle
	 <myrrhperiwinkle@qtmlabs.xyz>, Sasha Levin <sashal@kernel.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Date: Fri, 26 Jun 2026 00:52:57 +0200
In-Reply-To: <20260616145102.909504547@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
	 <20260616145102.909504547@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Yns9Wed2gkSPmVC12iHj"
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268681-lists,stable=lfdr.de];
	DMARC_NA(0.00)[decadent.org.uk];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:myrrhperiwinkle@qtmlabs.xyz,m:sashal@kernel.org,m:senozhatsky@chromium.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A993B6C910A


--=-Yns9Wed2gkSPmVC12iHj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-06-16 at 20:30 +0530, Greg Kroah-Hartman wrote:
> 5.10-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
>=20
> [ Upstream commit d98d413ca65d0790a8f3695d0a5845538958ab84 ]
>=20
> We only need to update the power_supply on power role change if the port
> is connected, because otherwise the online status should be the same for
> both cases.
>=20
> Cc: stable <stable@kernel.org>
> Fixes: 7616f006db07 ("usb: typec: ucsi: Update power_supply on power role=
 change")
> Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
> Reported-and-tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Link: https://patch.msgid.link/20260519-ucsi-fix-2-v1-2-6f1239535187@qtml=
abs.xyz
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/usb/typec/ucsi/ucsi.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -775,6 +775,12 @@ static void ucsi_handle_connector_change
>  	    role !=3D prev_role) {
>  		typec_set_pwr_role(con->port, role);
> =20
> +		/* Some power_supply properties vary depending on the power direction =
when
> +		 * connected
> +		 */
> +		if (con->status.flags & UCSI_CONSTAT_CONNECTED)
> +			ucsi_port_psy_changed(con);
> +

This should be making a call to ucsi_port_psy_changed() conditional, not
adding a call.

I think this went wrong because an earlier backport, commit 7a3f8d1a44db
"usb: typec: ucsi: Update power_supply on power role change", put the
call to ucsi_port_psy_changed() in the wrong place in this function.

Ben.

>  		/* Complete pending power role swap */
>  		if (!completion_done(&con->complete))
>  			complete(&con->complete);
>=20
>=20

--=20
Ben Hutchings
[W]e found...that it wasn't as easy to get programs right as we had
thought. I realized that a large part of my life from then on was going
to be spent in finding mistakes in my own programs.
                                                 - Maurice Wilkes, 1949

--=-Yns9Wed2gkSPmVC12iHj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmo9sUkACgkQ57/I7JWG
EQlooQ//RT4Ta4GvcxFaDEAPB1ClNDWyhg96zSAvtwW9piZq5CnIQyqHZfmYirID
bd/F7wyeG0hjwFJuODDrQI+zZLsQXDoZqid1PFPmmWnfXEKRmk6XMo9E5alGyVbK
jtuR8fCqx6ydV8XUvNYhoPHOIOO0CL1UfgwtErnOIxmFgQ4NYV+T1HeBVb+ttduA
W+YLsSpt44FjO/9ubLkoOusTVfQQoGAiMeRTNukYG8792QmVCvzJkaro/2X3csnS
/JK9r/AoFisCiMTr9aQ9xPNEiKoSg3O+CTQ8IcpOkiqTyQTxm/A/KY10vQcg9o31
0XAW3jFZnyiLpcBIYedGy/iLSzNNExNFQQ0LY0O+dQouGR9SyxjhutilF2ZS2WmK
k7M5gRg0hlvWOWapWcmh2bxbq3s/jbgXGB6ZsOhPO54v/ZF2IRVx/6h3iFTgx2Oq
OrOn+PmBd6Nz3+VenfEMDt3NBkEcgC2czv4MGuwD4p3WH9eiJA/bWYy8/jNbUt8F
NgRYVR+0ahVk2fKFI+0uhUb62ufx/6M8RiT2bEzATVi+QlvUVIZ63lyy91tpLpZR
/Z84oOebchs5QVtKVkynyd0pQsUZIc4ar3o1ZBvaLCn8TJRRftWNoIyX1Fa971LI
J/7c+qM39cRh77NH08cKyy3Y55uhY1TV9hEapVpV1cz+ktwrnxs=
=2J+P
-----END PGP SIGNATURE-----

--=-Yns9Wed2gkSPmVC12iHj--

