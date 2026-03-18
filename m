Return-Path: <stable+bounces-227182-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLXEB200u2lFgwIAu9opvQ
	(envelope-from <stable+bounces-227182-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 00:25:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B19D42C3D17
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 00:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B26130B8491
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 23:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91E334DCC4;
	Wed, 18 Mar 2026 23:25:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE42B330D24
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 23:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773876307; cv=none; b=R/u8evY9zAsrjdPIG3ck6RBgDzHjkuut/Ih1spglENFMuOlB5KMJE2f0IXyhkPwvBowfgKOfmsMwM8rYwSc6kUys5+29C5oosPEBuYuED5P2SpKWp1DeBiG8lv3WYrnuOPizXzJjgPPC0NR+RiA5pvn4yqxlrslxqn7tx4Sf8T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773876307; c=relaxed/simple;
	bh=Kd7BU1YGmlHSPedRbtFQWtnhOfWayICtYpeiwOagYS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dypnrzVLpXdetsKPGrK4S8eWkzgEdKqWrCHTgAgiyiNxJvFCQR5XTWfgDWgQVfC/565ynRruccrcBYqkO7lUhIG0lL89DLuIu/625eoKb7lX+da4fWmO4Ip7HVwTm36p3iR/GbXpoNERAUkGMyPZqqH8fR4OYH225hnWhFjrCS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1w30Fx-0004SV-0J; Thu, 19 Mar 2026 00:24:53 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1w30Fw-000yxs-0I;
	Thu, 19 Mar 2026 00:24:52 +0100
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1w30Fv-00000009G77-48Le;
	Thu, 19 Mar 2026 00:24:51 +0100
Date: Thu, 19 Mar 2026 00:24:51 +0100
From: Michael Grzeschik <mgr@pengutronix.de>
To: Hyungjung Joo <jhj140711@gmail.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
	linux_oss@crudebyte.com, gregkh@linuxfoundation.org,
	v9fs@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: 9p: usbg: clear stale client pointer on close
Message-ID: <abs0Q2Sw3WvLYFbe@pengutronix.de>
References: <20260313171659.1225180-1-jhj140711@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+erp7nSIvu7J2s4t"
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227182-lists,stable=lfdr.de];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mgr@pengutronix.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.505];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B19D42C3D17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--+erp7nSIvu7J2s4t
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

I wonder where greg did this review? Was this in another thread?

I will have to drop this anyway, when splitting it appart.

>Signed-off-by: Hyungjung Joo <jhj140711@gmail.com>
>---
> net/9p/trans_usbg.c | 63 +++++++++++++++++++++++++++++++++------------
> 1 file changed, 47 insertions(+), 16 deletions(-)
>

=2E..

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--+erp7nSIvu7J2s4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmm7NEAACgkQC+njFXoe
LGS87RAAlXg50t73dUaoyzCA1jdI9UPra00KAQduhdJCA6lmuNIhjvfoORqsCzCv
WYzfAWW+WjHSsNS+3BVPHtygcsqV/qhySKXfb2FJGmv104fHwACpTlENrEaczo8z
vaSVO0DiYnIQcJaVjKz2IRVuYYPOGOupc+Uipv+/y6a1h1Gnzv65XgMA2rAMmx5g
xKStC01/rXBtYJlMnwWn6jgRVquZ0zUhstm/4gPuplf7kN4e1NjZTLbbkHj2ERQg
ltVjzmMpkYrYIfrBkaMRx3gAEsg4DPp1v2bZ8M87u/pLj3yXEPr9Iog7+Zg7Lhwt
dC9u99dsLQAXYUylVWeoHLmuh1gwsPcSieUYG1x9L3FyTF5jaxu+cVq42IWpo6mZ
eF2GpE1C3b/9cEMuAQ/AjPTqSIoDdN4ae0MkEp/o7+dCJWtzq7/I6WGnhTgOJkPD
GFooKEUZvsMttQ1UAg+drK0MMzL3UATjwc3tRdBuSqp/H71X9CzHxFnrqmruWB86
kyJxxVlT/6lpp0yjf0pPd1uogMxN5d0M7y6dFBDkB/ao7Wfx/hSyJwW7KvQuq7dH
zgWH6hes0Om4qR0MOGeIkAB3D4U8h+kCWbDw3IiGqyNfOOt6pPemOeDvtcGrExQk
QrRv8xm/SA52AiK263E8irdddJRBgxNM0Q916QpLoW7S/otbkBw=
=DIlH
-----END PGP SIGNATURE-----

--+erp7nSIvu7J2s4t--

