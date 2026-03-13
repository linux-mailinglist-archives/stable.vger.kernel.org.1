Return-Path: <stable+bounces-225374-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKuILytStGk4kAAAu9opvQ
	(envelope-from <stable+bounces-225374-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 19:06:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3462887F4
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 19:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7AC93028B59
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 18:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B962765FF;
	Fri, 13 Mar 2026 18:06:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA1D3DB629
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 18:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773425192; cv=none; b=h2RFQgnQPy18nbwcOxq6nYicAigktsMGgPStbdUiUCspBemXgXUFf+RlpQ57mWnHwUtqrw7W1AyITcY7DCEFyezhjyPm4gzEmK1DlqDjmFKjiG7bfSR9g/2AEd2aWQY3BBzgMxupW5elO7ZvUy5iyGdQd+UkmQZIzPDsc2TJwco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773425192; c=relaxed/simple;
	bh=M3roLdTudCdgfNngjNG50W+qQBuGSk9K3KnYMwGA7Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmQrdpjPtjkaXa9UUbaYDu2HUqsDBGj7ZTG4cloOlYpefA166EIiZKnqN0RE1M5luFdhswTwiugmnMNBMQp5mI72zrGKo5YOfBvO9pqesPspKi+8m27n+8H3kcaj+P9BA6f/bKsOn/m/Rt6n2SKJsx35L60LYw38aT0ey9A8N0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1w16tr-00052h-Rh; Fri, 13 Mar 2026 19:06:15 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1w16tq-0007Np-35;
	Fri, 13 Mar 2026 19:06:14 +0100
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1w16tq-0000000HIrS-3ZPe;
	Fri, 13 Mar 2026 19:06:14 +0100
Date: Fri, 13 Mar 2026 19:06:14 +0100
From: Michael Grzeschik <mgr@pengutronix.de>
To: Hyungjung Joo <jhj140711@gmail.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
	linux_oss@crudebyte.com, gregkh@linuxfoundation.org,
	v9fs@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: 9p: usbg: clear stale client pointer on close
Message-ID: <abRSFmpKpRgjTWPn@pengutronix.de>
References: <20260313171659.1225180-1-jhj140711@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iiClkwdaAZdCwp1M"
Content-Disposition: inline
In-Reply-To: <20260313171659.1225180-1-jhj140711@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225374-lists,stable=lfdr.de];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mgr@pengutronix.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:url]
X-Rspamd-Queue-Id: 6A3462887F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--iiClkwdaAZdCwp1M
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

On Sat, Mar 14, 2026 at 02:16:59AM +0900, Hyungjung Joo wrote:
>p9_usbg_close() tears down the client transport, but usb9pfs keeps
>using usb9pfs->client from asynchronous TX and RX completion handlers.
>A late completion can therefore dereference a client that has already
>been freed during mount teardown.
>
>Clear usb9pfs->client under usb9pfs->lock when closing the transport,
>detach any pending TX request from in_req->context, and make the TX/RX
>completion handlers bail out once the transport has been detached. This
>keeps late completions from touching a freed or rebound p9_client.
>
>Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
>Cc: stable@vger.kernel.org
>Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Signed-off-by: Hyungjung Joo <jhj140711@gmail.com>

I was just preparing a similar change in an series of patches. Let me
come back with a test of your patch and the comparison to my changes.

Thanks!
Michael


--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--iiClkwdaAZdCwp1M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmm0UhMACgkQC+njFXoe
LGSNrQ//bivobCzCGMnkMzEuCNf9x5yt+/OvHIVGHgtlZXhMZcDYo/x6EUeXcQib
MFuI4Bh2LGLFRuWjgn0fAnBmxuIwVYcqUiLUy7d+VYLwZRStCjH0ytb4+c9kw2FY
9V5IluViM0TmW27Wk0D/48/3vhMdWAuCJTkuGKvmfLZC8IE0/YrpEivQ4VcVDpc7
2nkGveu0R8a8bcCwFUDLnzxkgUuerptpBgj5Q6m/VCbRUtSOw5AEYxHcQqCqGWLq
nyz/wruCDot1uXMobsvawXL6tL4bUgkhmgO66Zwuuf30QYP9Alq+HjdVM5uhNTk3
7D+y7g6UC1VmYU2FFrNn/66S52ZqSOKwsNiXDc487q92ONMYw86W7bVj5sBHFoS4
8nGtFwCZ16nsQYHuUQd88xFTkbf2atp8thgMGQbCkBqSAv02LS0PijPjAEw7IT9V
MaJNGhHVv33Wtqh9pZ/A9gZlq7SdCCzMau5VA6IBQW5zsIQubTOyegNZQv1zITwJ
nuLTa8gcK2ByKAX//fipf6Ac9ehHpRsqbGR3Q1vGNedtbkY54s5XKYY0JnYVHbgS
cFJEobzJfCTeEfE9DWLCs+ahQs1ia2cnsSvS3u8PaQXzufttdqWfoIUlJmjqxX/2
pLbWnGjaJbeQ4wBE7zK+AmBRP8rOF2QUGfJ4qf5Mjf1yxeFB+90=
=AlgS
-----END PGP SIGNATURE-----

--iiClkwdaAZdCwp1M--

