Return-Path: <stable+bounces-271869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t6nTLaUgSGp2mgAAu9opvQ
	(envelope-from <stable+bounces-271869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 22:50:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B607059AA
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 22:50:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271869-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-271869-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB7433018AF7
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 20:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AA73264EA;
	Fri,  3 Jul 2026 20:49:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87E73090D7;
	Fri,  3 Jul 2026 20:49:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783111743; cv=none; b=DK6601zycbqhfDR7j9Smk90H7SRJ1jRmL+I5VOUwlqtsxjVUTVDtCjcSr9mGzDXGGoJ9mlQjYESwGyeird5PGBBN+WzMYuT4SyH3Wi+WqrMy9EvZTSGU/7PjMyw+MtMRkjnlxrtyTIhC1be0a1bHiP+vjkHCJCjeJ8i4CmDJnYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783111743; c=relaxed/simple;
	bh=7vF+1YpyfDgEivlNTmzmQvMRIpkNvmGnSqvstV+ydLQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d2HG4EQhWEKzPg0vtVAMVeMAitGO2fcR4BiyKGha5gMp9qwEGJP7c86Teo8BFH3ptB1C5S5BylZycCO7GObOMA9EDCejPvvRntwChWQBRFS0Sdhk6/SJeUtpJ1t7azTP7zGKDUNScawsTliFsPEZywieMBRgONkRMcloqevwMKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1wfkJe-0000g5-1i;
	Fri, 03 Jul 2026 20:16:49 +0000
Received: from ben by deadeye with local (Exim 4.99.3)
	(envelope-from <ben@decadent.org.uk>)
	id 1wfkJc-0000000BnnG-1cun;
	Fri, 03 Jul 2026 22:16:48 +0200
Message-ID: <418ca29bbbb1190853136331c572470dca803800.camel@decadent.org.uk>
Subject: Re: [PATCH 5.10 01/96] net/sched: act_pedit: use NLA_POLICY for
 parsing ex keys
From: Ben Hutchings <ben@decadent.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Pedro Tammela <pctammela@mojatatu.com>, Simon
 Horman <simon.horman@corigine.com>, "David S. Miller"
 <davem@davemloft.net>, Wentao Guan	 <guanwentao@uniontech.com>, Sasha Levin
 <sashal@kernel.org>
Date: Fri, 03 Jul 2026 22:16:43 +0200
In-Reply-To: <20260702155108.985307603@linuxfoundation.org>
References: <20260702155108.949633242@linuxfoundation.org>
	 <20260702155108.985307603@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-XfvXdxQgiIl/EicnFLg0"
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
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271869-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:pctammela@mojatatu.com,m:simon.horman@corigine.com,m:davem@davemloft.net,m:guanwentao@uniontech.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DMARC_NA(0.00)[decadent.org.uk];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05B607059AA


--=-XfvXdxQgiIl/EicnFLg0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-07-02 at 18:18 +0200, Greg Kroah-Hartman wrote:
> 5.10-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> From: Pedro Tammela <pctammela@mojatatu.com>
>=20
> [ Upstream commit 5036034572b79daa6d6600338e8e8229e2a44b09 ]
>=20
> Transform two checks in the 'ex' key parsing into netlink policies
> removing extra if checks.
[...]

No objection, but this should also be applied to 5.15 and 6.1.

Ben.

--=20
Ben Hutchings
You can't have everything.  Where would you put it?

--=-XfvXdxQgiIl/EicnFLg0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmpIGKsACgkQ57/I7JWG
EQnUwg/+O8Yr+URKd9ewwlqMKZzuFb4C0DCY0OBrYwR4bV8XYbTqoY+cuk8O4NiH
KP5N7H7DzvnEYgRHW/4OecxPkDvCWVLcWN7Qz1zLG9I3151+JYEMRWdQGOArUxJw
veD2YdfA3O+xubIv2dqvUS+Fg/S7lHQnyShdN9LDKdE9m6E5KBwtdyELxA6gauAZ
/vFL+bkL9mYXbjITrd9UBAsoTZ7tSdwVTyDxWoac89IswBkgZO/x+rxFhdanECHb
XTdeZlEKTS4Cbu0RCxlrV3PPtVE5YIDZ9dmt5Aj8cWdwuLQDeirdYjvuMtdMHYpS
hNQDkL9xGNo40H8JUKt44pd1HbxFEiojgIVdcaD3rjhUYORyW6BC5Tl0igBECrU0
Gh8o1mU/54oVTAO4Q8h4nURcWjEX/TNPqM6ydeX8YCE9iQ0gsNXoOyzu2hAo4EJM
NLHMvEVYyBz/9/gPb2XrMVLONoSpbYNuDF6iAbFxP50nQDmCtJ8bfZq0UBzNI1b6
ArbUqssbWOdUYxrETar/GsctCCoZMlmAGcuETu4zmTZeN8RG5JtPoWe8IqqQxD08
f3ZXyX7FxUgyo7T7RaBmev5zr/cqfZ3qRzb7eBonnXpWwjATK7CqFhuNJOzA+1i3
KEw3nfqWW7mCnAsrl2X3a6M89LcgcvN8sHW+g1EqPXAdF6P9PUk=
=UAVZ
-----END PGP SIGNATURE-----

--=-XfvXdxQgiIl/EicnFLg0--

