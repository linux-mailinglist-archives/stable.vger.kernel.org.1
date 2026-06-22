Return-Path: <stable+bounces-267789-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0VciJ4+DOWqNugcAu9opvQ
	(envelope-from <stable+bounces-267789-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 20:48:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0106B1DC2
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 20:48:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267789-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267789-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36F633011042
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 18:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4977D342532;
	Mon, 22 Jun 2026 18:48:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB5833F58B;
	Mon, 22 Jun 2026 18:48:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154125; cv=none; b=Z/E+ZxPtpHmPOhcei1zg6WjoXDBc/gHfjEyUblGCo1kX+oWz/H8YwIERRRj1S63vJ1SjUN9/YqXkt/VYwc6Y+qdxNGLcWYQAWQ0dPXDqLNPaQ4RlHeCTZck7e8toIGFZOA5l9hhz3A5Yqb2HZC/PjtzyVPHicEZVtD1972WXQ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154125; c=relaxed/simple;
	bh=gn2CjkQeDZoAmuiaS7haPnR/kL+Anhuwk3Smo7kMd+g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hw+O1RieAK3NImWkn17apiWDVdecS7pHzU/F+VZzzG1kdKAnXE6fPXgGSOkMByfsCsprP14YJJ5bQEsRSMjIXziX+lkVhfdh5AufsMaRi+wL055w1TPAek4p8b7yf9HH6CfXD9YYCQDWiEZKUBWTiDJvMD9w33NSoSs115ee6Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1wbjh4-003kBc-1K;
	Mon, 22 Jun 2026 18:48:26 +0000
Received: from ben by deadeye with local (Exim 4.99.3)
	(envelope-from <ben@decadent.org.uk>)
	id 1wbjh3-00000007oJw-0mf6;
	Mon, 22 Jun 2026 20:48:25 +0200
Message-ID: <ab577daf17c46a72e35c668756d5b33b3ca3ca09.camel@decadent.org.uk>
Subject: Re: [PATCH 5.10 238/342] net: bridge: use a stable FDB dst snapshot
 in RCU readers
From: Ben Hutchings <ben@decadent.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, stable@kernel.org, Yifan Wu
 <yifanwucs@gmail.com>,  Juefei Pu <tomapufckgml@gmail.com>, Yuan Tan
 <yuantan098@gmail.com>, Xin Liu <bird@lzu.edu.cn>, Ren Wei	
 <enjou1224z@gmail.com>, Zhengchuan Liang <zcliangcn@gmail.com>, Ren Wei	
 <n05ec@lzu.edu.cn>, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov	
 <razor@blackwall.org>, Paolo Abeni <pabeni@redhat.com>, Sasha Levin	
 <sashal@kernel.org>
Date: Mon, 22 Jun 2026 20:48:09 +0200
In-Reply-To: <20260616145059.293155612@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
	 <20260616145059.293155612@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-8CzP0LIYX80jWadwAj0l"
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[decadent.org.uk];
	TAGGED_FROM(0.00)[bounces-267789-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:yuantan098@gmail.com,m:bird@lzu.edu.cn,m:enjou1224z@gmail.com,m:zcliangcn@gmail.com,m:n05ec@lzu.edu.cn,m:idosch@nvidia.com,m:razor@blackwall.org,m:pabeni@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,gmail.com,lzu.edu.cn,nvidia.com,blackwall.org,redhat.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,decadent.org.uk:mid,decadent.org.uk:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC0106B1DC2


--=-8CzP0LIYX80jWadwAj0l
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-06-16 at 20:28 +0530, Greg Kroah-Hartman wrote:
> 5.10-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> From: Zhengchuan Liang <zcliangcn@gmail.com>
>=20
> [ Upstream commit df4601653201de21b487c3e7fffd464790cab808 ]
>=20
> Local FDB entries can be rewritten in place by `fdb_delete_local()`, whic=
h
> updates `f->dst` to another port or to `NULL` while keeping the entry
> alive. Several bridge RCU readers inspect `f->dst`, including
> `br_fdb_fillbuf()` through the `brforward_read()` sysfs path.
>=20
> These readers currently load `f->dst` multiple times and can therefore
> observe inconsistent values across the check and later dereference.
> In `br_fdb_fillbuf()`, this means a concurrent local-FDB update can chang=
e
> `f->dst` after the NULL check and before the `port_no` dereference,
> leading to a NULL-ptr-deref.
>=20
> Fix this by taking a single `READ_ONCE()` snapshot of `f->dst` in each
> affected RCU reader and using that snapshot for the rest of the access
> sequence. Also publish the in-place `f->dst` updates in `fdb_delete_local=
()`
> with `WRITE_ONCE()` so the readers and writer use matching access pattern=
s.
[...]

For 5.10 only, commit 3e19ae7c6fd6 "net: bridge: use READ_ONCE() and
WRITE_ONCE() compiler barriers for fdb->dst" is also needed (but doesn't
apply cleanly).

Ben.

--=20
Ben Hutchings
I haven't lost my mind; it's backed up on tape somewhere.

--=-8CzP0LIYX80jWadwAj0l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmo5g2oACgkQ57/I7JWG
EQmrVw//Yyo3ZafQeqsEBoyOqnJpWaXVHLNChi+UyDBRa21WvyovQ6GNUCkxcRh2
lUEVYvXNZMlXi61+5krzqLjw6FEkKuwBQKFZxCwNGQWGY93LVh8uP/umKa3ezZ27
zihpBHVIXI/PJCO2tZVhoAsqIUyC3xIOp2J16IRpWoQy4X4yIWTwSclbK7gmoQBo
OAUaeGvXATbKcxnUT59Le/Lftq+ido/rVE5+ZKAQ2R2hsKMqncMkHZPYfa/TQ0hS
eS9yVrAv5uBETrXBaXWbK7czQpezd6dp8RjQEnfrza8P+agq2aDXZpoR55Liz9kC
NoXd45jKdzmrDtMWqOWm1x2by4r7bAnIlqcKx4i9tGEk4nraZjRXNgPR1ME/xOZF
uszs9c/FOI3e1aKl5Ad+E/uFN/BzJ9VDZdQozz5xtsIov0vE2AJHoh6aQIaY4UQ7
YRRuYyjhXIm8ax8dlj7vUo+KXGW4J4TnwwJHpPHBbELPPMRcY5lPdQxL3JasRw5Y
gNCVrE4Dn6pkT6JtIO63kLbYR/xQW2OWpoBtLkvmjKVruVS7iEvnY6jBjH3gXhMm
m36QNXQlLS2VpjnsJpL56X8TJrIvasVzLUfRe2SBEkNBPCopu2PZah0rn7pX4W/X
rPVa18kiMS1tLauLjwfQD14oU3JLmLDrljFVRStijgt0zNQnJ84=
=Q0/V
-----END PGP SIGNATURE-----

--=-8CzP0LIYX80jWadwAj0l--

