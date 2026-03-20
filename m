Return-Path: <stable+bounces-227455-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Og0BwAEvWkO5gIAu9opvQ
	(envelope-from <stable+bounces-227455-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:23:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C606F2D7281
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEA25301442D
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7AF37188D;
	Fri, 20 Mar 2026 08:23:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755E3371898
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773995005; cv=none; b=c1OxZndmyJP6GB2jQEk7ejGvoL5lpaHRpRd9IoR002sjjvPqN6Plq+GK4MiQQfXAlgtHKrApZInOO1J/+KsgdLs8LGfa+qwtHYN1De0WF2FAwMv6unCyUcLSDJe1JRYZiByau4eLEy4udHeBjcYi+SEubOAY0pNMg4Xk2VyJhko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773995005; c=relaxed/simple;
	bh=Clo03zBtTIdH976AMr2Ww2iYTYqAlMmSHwfHuEkSnMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZN/yX/3EuReZL+bqfBJ4lRovbvnQX6+Aj4mxuqRFVMO2AGNzKxO3AAlCD+J5xpb6LopauIHBE/POkIduCkKHy6LSwilMxNen2PEx0dIAkt9dpvbkiR08UgWXHxpOGsyQqO884s+E5DXxySlbev9os83fS6DiZDtSPy9PRYGbJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3V8Z-0001jY-EM; Fri, 20 Mar 2026 09:23:19 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3V8Y-001DAZ-1i;
	Fri, 20 Mar 2026 09:23:18 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3C321508FF7;
	Fri, 20 Mar 2026 08:23:18 +0000 (UTC)
Date: Fri, 20 Mar 2026 09:23:17 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ruohan Lan <ruohanlan@aliyun.com>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH 5.15.y] can: gs_usb: gs_usb_receive_bulk_callback(): fix
 URB memory leak
Message-ID: <20260320-brilliant-loud-muskox-5db370-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260320075431.5695-1-ruohanlan@aliyun.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pcznu24mr4cl2gt5"
Content-Disposition: inline
In-Reply-To: <20260320075431.5695-1-ruohanlan@aliyun.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[aliyun.com];
	TAGGED_FROM(0.00)[bounces-227455-lists,stable=lfdr.de];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.706];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,pengutronix.de:mid,pengutronix.de:url,aliyun.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C606F2D7281
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--pcznu24mr4cl2gt5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 5.15.y] can: gs_usb: gs_usb_receive_bulk_callback(): fix
 URB memory leak
MIME-Version: 1.0

Hello Ruohan Lan,

On 20.03.2026 15:54:31, Ruohan Lan wrote:
> From: Marc Kleine-Budde <mkl@pengutronix.de>
>
> [ Upstream commit 7352e1d5932a0e777e39fa4b619801191f57e603 ]
>
> In gs_can_open(), the URBs for USB-in transfers are allocated, added to t=
he
> parent->rx_submitted anchor and submitted. In the complete callback
> gs_usb_receive_bulk_callback(), the URB is processed and resubmitted. In
> gs_can_close() the URBs are freed by calling
> usb_kill_anchored_urbs(parent->rx_submitted).
>
> However, this does not take into account that the USB framework unanchors
> the URB before the complete function is called. This means that once an
> in-URB has been completed, it is no longer anchored and is ultimately not
> released in gs_can_close().
>
> Fix the memory leak by anchoring the URB in the
> gs_usb_receive_bulk_callback() to the parent->rx_submitted anchor.
>
> Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devic=
es")
> Cc: stable@vger.kernel.org
> Link: https://patch.msgid.link/20260105-gs_usb-fix-memory-leak-v2-1-cc6ed=
6438034@pengutronix.de
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> [ The variable usbcan was renamed to parent in
> commit b6980ad3a90c ("can: gs_usb: uniformly use "parent" as variable nam=
e for struct gs_usb")
> introduced in v6.6. To backport to v5.15, replace parent with usbcan. ]
> Signed-off-by: Ruohan Lan <ruohanlan@aliyun.com>

please also backport:

| 79a6d1bfe114 ("can: gs_usb: gs_usb_receive_bulk_callback(): unanchor URL =
on usb_submit_urb() error")
| 494fc029f662 ("can: gs_usb: gs_usb_receive_bulk_callback(): fix

these fix this patch.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--pcznu24mr4cl2gt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCab0D8gAKCRDMOmT6rpmt
0nSDAPwODQnWErWq206FlGI9pD2ad1vTBqkCHVLiM1Lt51vvpAEAvqH32LPnmklg
gwOTr8xHaDW+No3W78xi2DeFDWTrSgg=
=T83O
-----END PGP SIGNATURE-----

--pcznu24mr4cl2gt5--

