Return-Path: <stable+bounces-238585-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MbBTDGNt42n9GgEAu9opvQ
	(envelope-from <stable+bounces-238585-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 13:39:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C428420FE2
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 13:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E3FE3020026
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 11:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB89034B669;
	Sat, 18 Apr 2026 11:39:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6E913D539;
	Sat, 18 Apr 2026 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776512350; cv=none; b=hlSMkj5WUfGVB3cJn/EBdaoQuWuBHdNuliLtMFH12mAayl0ePSRQLqxWz5kgnrw0TiFxWkFeyqk8zH+qn6imvt6BNEVlom+OjQoN8HA6xRDonSSydmDJizClL7BHKAUj3PYxX8Bx8N3YK+3BZGjrMEKChfdsMRVW8E02ORnU58w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776512350; c=relaxed/simple;
	bh=h/xPEMjBgVXxyiu2XIneJdCerOWT3S+I/9ksQ4Juam8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qxskpUUdfjGOj4oTmmQUMGEKiR63QO+53I9MBbkhvkirCXxt+8u0HyEeXRK3Wihd/5Rp7gD+eE86O+OW5+VYdffZpHGoA0XiTE5wcI6o285DBvRBoRlAXCOHBJ8YO0j9qGj6kqWPreLpam3dVZR+BfT/Tf7huCVmp+OCpzNJnwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1wE40r-005QWR-0g;
	Sat, 18 Apr 2026 11:39:00 +0000
Received: from ben by deadeye with local (Exim 4.99.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1wE40p-00000004Q4Q-0wjv;
	Sat, 18 Apr 2026 13:38:59 +0200
Message-ID: <d5dde03f796af3efcdabcbadb604e8981268ae5c.camel@decadent.org.uk>
Subject: Re: [PATCH 5.10 393/491] phy: renesas: rcar-gen3-usb2: Lock around
 hardware registers and driver data
From: Ben Hutchings <ben@decadent.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Yoshihiro Shimoda	
 <yoshihiro.shimoda.uh@renesas.com>, Lad Prabhakar	
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Claudiu Beznea	
 <claudiu.beznea.uj@bp.renesas.com>, Vinod Koul <vkoul@kernel.org>, Sasha
 Levin	 <sashal@kernel.org>
Date: Sat, 18 Apr 2026 13:38:53 +0200
In-Reply-To: <20260413155833.747676279@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
	 <20260413155833.747676279@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-msvjpwEEThymAvOn4Cyc"
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_FROM(0.00)[bounces-238585-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,decadent.org.uk:mid]
X-Rspamd-Queue-Id: 7C428420FE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-msvjpwEEThymAvOn4Cyc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-04-13 at 18:00 +0200, Greg Kroah-Hartman wrote:
> 5.10-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> commit 55a387ebb9219cbe4edfa8ba9996ccb0e7ad4932 upstream.
[...]


This backport wrongly omitted the conversion of msleep() to mdelay()
inside rcar_gen3_init_otg(), which is now called in atomic context.

Ben.

--=20
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.

--=-msvjpwEEThymAvOn4Cyc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmnjbU0ACgkQ57/I7JWG
EQnsqg/8DaFCKg06pN/PtcUaeglr3Ac6Enty7ljQdig/1daRYuNKAoIF1svRW/yZ
p6sjKy0pYV/10S923NAS9tL0GXlJ/pr+AM+3y8hNL1j8l6RmEEjfeGhc5M1Ynteb
d/o76ZVT3hOUZDhdGlxhiGnasgaobpvw2B2dfSQwKsLHcihp3HQ1mmIJqM1HVcYf
KyAA+MbafTC8j4kCx8Ii+RWcQcrFnM3uZkI6PLDhIYgvyXG6j72emfwKlvx049+5
sB8zW9zIDO6ZnSOgvAggKTFUJhLucQPRj0nyoA1q7pcjUL+7hP3Ck8lRkqnH9TZo
JoNO0xYq5ajMYwYQknomxCNgnrQ41A2k6ojwX5PiYQNc86ObJoFk4hC00AWTYGNB
kFQ+fXuxzWt7VVXDCSICLUhk0MOXDLi5oCxzwxzuTV3La0iTpDInz+teFAr0Hnz4
CurRNxyCY/QtDzEELAqxLqwSTdJBnmTHfwVzjU0GsMN2l1P8s+PkKr/r1QlvXvdu
ZdcAaWZKrnIEdvBOJJ74l+Blo3U5c1rINxqfVtzh9QnhBHMI0IdF4QXAOalYWSIP
t/CNPmv8gK8SvzRQNmeSXNKFnrn6AaFZtru/BN7GnEVdh/nxaBGuY76l9HlqbQh/
hTTMGjjGLdJURiMBXBfgtcvoCp50T/TQFLPd8vTAmB6s2QAY8xk=
=zCKV
-----END PGP SIGNATURE-----

--=-msvjpwEEThymAvOn4Cyc--

