Return-Path: <stable+bounces-227324-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEJkHsAWvGnbrwIAu9opvQ
	(envelope-from <stable+bounces-227324-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 16:31:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2165F2CDC1B
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 16:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85D0831C5E75
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384D636C0D1;
	Thu, 19 Mar 2026 15:23:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1CD3D7D63
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933815; cv=none; b=D5O7Fj5GuLKwv2QRVLZEEvwFd1isxzakPswZaJwnt+yZgwcv6wXp24dWclDFnABqsDOkrO7HaqHTunv5YTlsv6EAGICA7PWFgrn43XqkaiHgGcQVvMumNosjumDiZhAWAj7yviAI54K5Ef9JCWBxJ+FEv7SlQA4nuT5MJ7b3ClM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933815; c=relaxed/simple;
	bh=uaWb6/xqp8QnpCZbKh/j4Cy77K/pBbIqd9YmD2ToINI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXQ6u3I1yUdlNNEwaPsBcQmVQh87qhWTUjszmyqG3bDsZ4K0TWVbYTmkBfSns6IuCGAvnLeJSmNZ3Yjc20lB8iQzgCY/6BlSuPSyA6mJp4BX6yWvLb+S4j5fnrxSlJTwSxVVoGaybknjU9nknr1faQKHIeJjYdJlDvw9R4tn/kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3FDd-0007mU-AY; Thu, 19 Mar 2026 16:23:29 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3FDc-00168G-1t;
	Thu, 19 Mar 2026 16:23:28 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4D736508652;
	Thu, 19 Mar 2026 15:23:28 +0000 (UTC)
Date: Thu, 19 Mar 2026 16:23:27 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, stable@vger.kernel.org, 
	Ali Norouzi <ali.norouzi@keysight.com>
Subject: Re: [PATCH 2/2] can: isotp: fix tx.buf use-after-free in
 isotp_sendmsg()
Message-ID: <20260319-rigorous-gracious-seal-6e47fb-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260318165120.17560-1-socketcan@hartkopp.net>
 <20260318165120.17560-2-socketcan@hartkopp.net>
 <20260319-dashing-scarlet-angelfish-dfaa67-mkl@pengutronix.de>
 <2f4e771e-62fd-4908-9dab-02120bc51467@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ra5rpter53rz6vgr"
Content-Disposition: inline
In-Reply-To: <2f4e771e-62fd-4908-9dab-02120bc51467@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227324-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.588];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[keysight.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:mid,pengutronix.de:url]
X-Rspamd-Queue-Id: 2165F2CDC1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--ra5rpter53rz6vgr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] can: isotp: fix tx.buf use-after-free in
 isotp_sendmsg()
MIME-Version: 1.0

On 19.03.2026 16:12:21, Oliver Hartkopp wrote:
>
>
> On 19.03.26 15:58, Marc Kleine-Budde wrote:
> > On 18.03.2026 17:51:20, Oliver Hartkopp wrote:
> > > isotp_sendmsg() uses only cmpxchg() on so->tx.state to serialize acce=
ss
> > > to so->tx.buf. isotp_release() waits for ISOTP_IDLE via
> > > wait_event_interruptible() and then calls kfree(so->tx.buf).
> > >
> > > If a signal interrupts the wait_event_interruptible() inside close()
> > > while tx.state is ISOTP_SENDING, the loop exits early and release
> > > proceeds to force ISOTP_SHUTDOWN and continues to kfree(so->tx.buf)
> > > while sendmsg may still be reading so->tx.buf for the final CAN frame
> > > in isotp_fill_dataframe().
> > >
> > > The so->tx.buf can be allocated once when the standard tx.buf length =
needs
> > > to be extended. Move the kfree() of this potentially extended tx.buf =
to
> > > sk_destruct time when either isotp_sendmsg() and isotp_release() are =
done.
> > >
> > > Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Ali Norouzi <ali.norouzi@keysight.com>
> > > Co-developed-by: Ali Norouzi <ali.norouzi@keysight.com>
      ^^^^^^^^^^^^^^^
> >
> > I'm missing Ali Norouzi's S-o-b. It was in the Mail that Linus Torvalds
> > forwarded us:
> >
> > mid:CAHk-=3DwheQ2o0B_-EV5H3w=3DZZS2huESOxrvTaub_EbrbAMbgi4A@mail.gmail.=
com
> >
> > Ali can I add you S-o-b here?
>
> Is this correct?
>
> I picked some of his commit message but the code is entirely my product.

You added "Co-developed-by: Ali Norouzi <ali.norouzi@keysight.com>" to
this patch. According to Documentation/process/submitting-patches.rst,
we need Ali's S-o-b then.

Please discuss authorship with Ali, consult submitting-patches.rst, use
"b4 prep --check", then send a v2 :)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ra5rpter53rz6vgr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCabwU7QAKCRDMOmT6rpmt
0lYjAQDkCabeq/HZ2GiRi7Iz9As/jBnQqxoPN0G5Gi38uR1dlQD6AsDw4yVSCfa8
zsd/zLriNsZ2lW6ryiKnk+v84UT+egM=
=scyZ
-----END PGP SIGNATURE-----

--ra5rpter53rz6vgr--

