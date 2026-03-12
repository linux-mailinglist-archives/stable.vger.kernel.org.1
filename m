Return-Path: <stable+bounces-224815-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLQOAaxxsmmuMgAAu9opvQ
	(envelope-from <stable+bounces-224815-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 08:56:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9743026E834
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 08:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69C2F308B715
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 07:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7731F3B7749;
	Thu, 12 Mar 2026 07:56:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D78B3B7744
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773302183; cv=none; b=cgx5JxMuDMn7EV9btJB9jTCoE+Vp0nEvwcK3hZHNmvq2JSytluhTfVfAWx1MiQaeoBS52hnmdL5WI2MHPDZLAOEcLiDpKzQYk2TyStYXiguhvJUr6AEvywTMoLAjrkJI7VVUBPTssJO2CHvyCALkfOcdbFGOU+oaIhIYvB/rniA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773302183; c=relaxed/simple;
	bh=9Q0jKMCK2gwwowvD979GrkosTYA7evdQaJnpQV4NLwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5tWK21Ac+mn2jJHl14WkXO2mmb3LB0VxHH8/OXFIxvYfFJM0xD2wzbR4AdYgybz5ymtndW1M+801CLIcbEiJOP74i6/draLXta9l+xmtrZMGGMpX9LaKIvPEiCL24lEvuKCyFVTj/W2ZjNkkB84yv3L6qGiPY1SUIE5xCb9T/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w0au1-0001O8-Tm; Thu, 12 Mar 2026 08:56:17 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w0au0-004zEy-13;
	Thu, 12 Mar 2026 08:56:17 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 61B724FF6E5;
	Thu, 12 Mar 2026 07:56:17 +0000 (UTC)
Date: Thu, 12 Mar 2026 08:56:17 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH can] can: netlink: can_changelink(): add missing error
 handling to call can_ctrlmode_changelink()
Message-ID: <20260312-rousing-cordial-mouse-6b2814-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260310-can_ctrlmode_changelink-add-error-handling-v1-1-0daf63d85922@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zfex7dst5aen2skk"
Content-Disposition: inline
In-Reply-To: <20260310-can_ctrlmode_changelink-add-error-handling-v1-1-0daf63d85922@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224815-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email,pengutronix.de:mid,pengutronix.de:url]
X-Rspamd-Queue-Id: 9743026E834
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--zfex7dst5aen2skk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can] can: netlink: can_changelink(): add missing error
 handling to call can_ctrlmode_changelink()
MIME-Version: 1.0

On 10.03.2026 13:48:03, Marc Kleine-Budde wrote:
> In commit e1a5cd9d6665 ("can: netlink: add can_ctrlmode_changelink()") the
> CAN Control Mode (IFLA_CAN_CTRLMODE) handling was factored out into the
> can_ctrlmode_changelink() function. But the call to
> can_ctrlmode_changelink() is missing the error handling.
>
> Add the missing error handling and propagation to the call
> can_ctrlmode_changelink().
>
> Cc: stable@vger.kernel.org
> Fixes: e1a5cd9d6665 ("can: netlink: add can_ctrlmode_changelink()")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Applied to linux-can

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zfex7dst5aen2skk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCabJxngAKCRDMOmT6rpmt
0pyWAP42umX9UxBMMBEef7cyzlO24QqP/eysv+9q49hmw5VATwD/Yiq20/G/a7jY
Z5UpOfo08ByOnF9A1lRgRtoAw6kpawU=
=hR7b
-----END PGP SIGNATURE-----

--zfex7dst5aen2skk--

