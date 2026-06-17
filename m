Return-Path: <stable+bounces-266658-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zvfCOMhWMmpQywUAu9opvQ
	(envelope-from <stable+bounces-266658-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 10:11:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3350769774C
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 10:11:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266658-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266658-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B4DB300BCAF
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 08:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5CB3BBFB4;
	Wed, 17 Jun 2026 08:11:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C841E3101D8;
	Wed, 17 Jun 2026 08:11:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683904; cv=none; b=C3Fr1R/KVXyTzqNu5ZFBPYbn5Kuln8U3oh3lqI4KD2r/6DNfLJgHYMj2kq78hZZ29c9I3JlwpU2AoWL9f1nQqs5nbF7qAyD0hUJrwQWd9ony3zwOQ/KEqQeOlm7KTuyJExTpKVmNFuFl5+x/qNcszpUbim5EkWgsmhX9EY46ovA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683904; c=relaxed/simple;
	bh=o0QRzMw59BKC+Umm2MVLXZyIXEVDH49bJOp6d8LXa8g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sx8Tl9lFzM0AljdwkmyzCRV78Ct0Q4aiY8UAuPF0jqg+qd84/MKxhZ8XWBCUp0XoJKIt9Ag1/e3cLiTdvdwf9OfWY5iUX2MWRAgTK2Ky9XS8pXd7FfwFcgr0XKy1m7pwbl/Wz7CwKNiFhoqIckH5G4lgPxzzTYrvoaqo2U9CkkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Received: from [2a02:a03f:8fba:4c00:9e56:df29:1317:540b] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1wZlN7-002tTq-03;
	Wed, 17 Jun 2026 08:11:41 +0000
Received: from ben by deadeye with local (Exim 4.99.3)
	(envelope-from <ben@decadent.org.uk>)
	id 1wZlN5-00000006dOd-2ds2;
	Wed, 17 Jun 2026 10:11:39 +0200
Message-ID: <80be436bbcda9b8a66058c01eef0b0f94722e7ef.camel@decadent.org.uk>
Subject: Re: [PATCH 6.1 064/522] selftests/bpf: S/iptables/iptables-legacy/
 in the bpf_nf and xdp_synproxy test
From: Ben Hutchings <ben@decadent.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Martin KaFai Lau <martin.lau@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, David Vernet <void@manifault.com>,
 Paul Chaignon <paul.chaignon@gmail.com>,  Shung-Hsi Yu
 <shung-hsi.yu@suse.com>, Sasha Levin <sashal@kernel.org>
Date: Wed, 17 Jun 2026 10:11:34 +0200
In-Reply-To: <20260616145128.790200973@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
	 <20260616145128.790200973@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-OuHVlKhfMlMTcoamQPNx"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:a03f:8fba:4c00:9e56:df29:1317:540b
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266658-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,manifault.com,gmail.com,suse.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:martin.lau@kernel.org,m:andrii@kernel.org,m:void@manifault.com,m:paul.chaignon@gmail.com,m:shung-hsi.yu@suse.com,m:sashal@kernel.org,m:paulchaignon@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DMARC_NA(0.00)[decadent.org.uk];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,decadent.org.uk:mid,decadent.org.uk:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3350769774C


--=-OuHVlKhfMlMTcoamQPNx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-06-16 at 20:23 +0530, Greg Kroah-Hartman wrote:
> 6.1-stable review patch.  If anyone has any objections, please let me kno=
w.
>=20
> ------------------
>=20
> From: Martin KaFai Lau <martin.lau@kernel.org>
>=20
> [ Upstream commit de9c8d848d90cf2e53aced50b350827442ca5a4f ]
>=20
> The recent vm image in CI has reported error in selftests that use
> the iptables command.  Manu Bretelle has pointed out the difference
> in the recent vm image that the iptables is sym-linked to the iptables-nf=
t.
> With this knowledge,  I can also reproduce the CI error by manually runni=
ng
> with the 'iptables-nft'.
>=20
> This patch is to replace the iptables command with iptables-legacy
> to unblock the CI tests.
[...]

There is a later fix for this: commit 967e8def1100 "selftests/bpf: Fix
bpf_nf selftest failure".  But I don't think it's that important.

Ben.

--=20
Ben Hutchings
Humour is the best antidote to reality.

--=-OuHVlKhfMlMTcoamQPNx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoyVrcACgkQ57/I7JWG
EQm2Nw/+MMlB0T0Nv2k8/UUJ1KduQp1+Opr0JDMKwgxcKSjur1vjM2CUXCxELqCu
Vy1/QlUTRx0attSOPgw7u8UUrN2BHtKbC3ldRIMDkeiOtMZ//Rjl3i01SiWmMoGE
0rNWdMNhOOMNdQGgvdCVWLcMJ8JwaKJ2wCuLkpQc96XuGxhzPXwRi1mZTmw1ljif
D+yicFKYQbATaqnIg6I2w2T02xmUj6iOcBFF0syn00vgaABcX/7T3LmQTu8qY7Nv
XraYqPx+3t/DK76LrjX7FzaELfvrl9VzcVi4whWFoLQii6arL/z2jBOqhIXCQanY
KHOeFaU4paJFC581SPvGbzhV/GR/HgQYZfwiu6Be5cmED1wLI4PQ2qGr6DTZ1MuO
Fuf83+9PCUgW9sCR5ISmLV5GmhvrzJTFIdcmicmOO6nz7jtKxyY5m9JSdrNqooOF
XEpx/uMMS3OAMyAb2tSpcznmQTCdlu/UyUI0ZnlPeu+5UcvEUk5lWGomogFFt9x/
dHT5TSK64/jkU0+GeW+Avx/OgoJesTRjupTWeUv54GKAXVC72UAI0Hz3tCFhF0yM
wa4k0eFah2tRvlxf5jCRCI7WNhYV00QYt91dJ85TCBaGm9pkOt6oI6RUgUeWd2hR
5QBIk1eqgeEBRapdlwFz2eGxOTpiAKlTx73Z3JLS5AYPDo0anWQ=
=2PNE
-----END PGP SIGNATURE-----

--=-OuHVlKhfMlMTcoamQPNx--

