Return-Path: <stable+bounces-254976-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGahNc49GGo1hggAu9opvQ
	(envelope-from <stable+bounces-254976-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:06:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F6A5F2735
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9063E30F664E
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB013E6DDB;
	Thu, 28 May 2026 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="IDY6M+9j"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E613E63BB
	for <stable@vger.kernel.org>; Thu, 28 May 2026 13:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973414; cv=none; b=rp35yuXuFyYwnmtox/yayNW4pQY+aB42vxG9y+vbZyJ2psCdO8rw+F7ylO4Z7997Ui7THjJYcrylT1chb02mdMbXBRsiACj49TnsCDZF+aH6qgBaJiv0r2g6bQ1Yfejb67TbD8TIZ1GFm3UhdDIv69BmR+2TGhDVMGNSojqw9+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973414; c=relaxed/simple;
	bh=Nm+p+nmfjhZOnbVsb3m0VShZGBahQcFEut+sgOC0ddI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hgcigGSpyHRuIamQMtQIXQkwMJ0ZoX03Lm+JtBe42wDATmHkPwj+Wq0FJpAvIbwdYo6z/aw26oU9cW7m/nbau0Ky2VZ3xQ+CEGNQYctpyvySJHHvzhgm8UM9qgpMav0qsBczE2vUbqiY32iPc9NAZW0IWyvVdyQMjeGmyeXbicQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=IDY6M+9j; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Nm+p+nmfjhZOnbVsb3m0VShZGBahQcFEut+sgOC0ddI=; b=IDY6M+9jZQ4hWCar9qsSS+b7vr
	1R4tGjXq49EjZ3fh7QpyYpybgz+5pu9MiwMl5KBh4Mrm0zuIltwmuqe2WjZkyMlHcHhACuOozGjux
	6BvnmhSa1DY4iev4RWG7Tv+iAlBjGsvFULPueiuqsVTzLL/U7w+068lhaTga/SJhwBvGqWZeu2tmB
	LjZSPneZZ/Cr2Tq80ILWqhT3TX4JwGGD9f/9RtyiBHZnn6dVY4vG9eJRuRDquJ7OIuTatjURjSvMi
	wIK5QG7I+ARHbCjwwGjhP2L2G/VOr1hkYzlEIfGAW5IWxPeKGyyei/RXXfxZxAZ1qyWc0okcMdZuV
	/C5MP1Yw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wSaOX-0043ax-1B;
	Thu, 28 May 2026 13:03:29 +0000
Message-ID: <3f2908646639f4af8844cb8f5a9b4d2d4f904631.camel@debian.org>
Subject: [6.6] fbdev/vt8500lcdfb: Initialize fb_ops with fbdev macros
From: Ben Hutchings <benh@debian.org>
To: Sasha Levin <sashal@kernel.org>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>
Cc: Thomas Fourier <fourier.thomas@gmail.com>, Helge Deller <deller@gmx.de>,
 	stable@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Javier
 Martinez Canillas	 <javierm@redhat.com>
Date: Thu, 28 May 2026 15:03:28 +0200
In-Reply-To: <ahg8Ocvb3UFV6Vdl@decadent.org.uk>
References: <ahg8Ocvb3UFV6Vdl@decadent.org.uk>
Organization: Debian
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-cxjp6X+G6yi2xlZJzDae"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Debian-User: benh
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,gmx.de,vger.kernel.org,suse.de,redhat.com];
	TAGGED_FROM(0.00)[bounces-254976-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[debian.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benh@debian.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 69F6A5F2735
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-cxjp6X+G6yi2xlZJzDae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For 6.6, please cherry-pick commit 63a11adaceb8 "fbdev/vt8500lcdfb:
Initialize fb_ops with fbdev macros" as stable dependency of commit
88b3b9924337 "fbdev: vt8500lcdfb: fix missing dma_free_coherent()".=20
This seems to be applicable without changes.

Ben.

--=20
Ben Hutchings - Debian developer, member of kernel, installer and LTS
teams

--=-cxjp6X+G6yi2xlZJzDae
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoYPSAACgkQ57/I7JWG
EQkFUA//SBgLShkGe38PUv0O81moIKkvnxqZVi1LMjgH0yHZBG9QXtuha5BvFdDX
qWhId4JsmNBZkW61AxX33ze5IO+ormwaQQMMJL9lCiRRZs7v7QJ4wObJ4a/Fpdb4
xAFletWSsNWymdMlceTh1uS9wZ796CWJJjwWV4AbGj62CPA08S1C44bcoXH2doc1
TOLR+hKnzTL8ztM21Ab7Dgkc9qhcZNeE/lRnakRBYgclj+mdRZ6WVjVzJ0bJFKci
u4EUMHiq1G1gNCFO4y2LSDGfIzfzm1qCYt7stKaJi0pnZmVVgdFKnvFLAQaYFZqG
p3PjahtgAyF5J+L4LgfVXpGJTkDg879763Ly3otqmRiTSjl+QQjpnI77Lkq7Gu/u
Bd+Y/K/16tV758yTjugW4EqtfFEpbITXpBX5LFsVCG/zi3lmEPMZKVQwQhpriIA1
PDCS6WOIEPgdXsQ6f83kB2KEr75n9mS65G2Kp8sOptNUqt6EThkObrPgGgP9r9aP
QjknGhgHGC8eBFWdIsVqa9r1r6MHSyPbHJ861jm+JmNV/q8oGnjQGf9F/yEmLKB5
bIYjk6+L0AVJ0nyXZa8/M54dBpsITc1FpHk043mpqMLaOh/CKb5tlDwt5TDORApI
+UOZqsSuoAbxlMzOJ67COXfFqBtXqZA3Ii8TgtXnZwBYGpe304U=
=Wge0
-----END PGP SIGNATURE-----

--=-cxjp6X+G6yi2xlZJzDae--

