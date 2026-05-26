Return-Path: <stable+bounces-254383-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIevEErCFWoAagcAu9opvQ
	(envelope-from <stable+bounces-254383-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 17:54:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9245D9216
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 17:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45A9F30DE763
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF30F347FC4;
	Tue, 26 May 2026 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Jx1lG1Ki"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA03830C15B
	for <stable@vger.kernel.org>; Tue, 26 May 2026 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809162; cv=none; b=LoBGs0x7bDwryp47kkcdNQ7m4cl8amwS63cdqEbBAvz7z4EZubqh/I2KrE51754NGtd1o5E/Cdpt415onctQJyVoAO4jbZwszplaf9pTgubbFjWztFDQRCG3+jndEL/LTz7eASo1PBG+V1MeL6JsQMx50S9hDB8DpCgKdRxW22M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809162; c=relaxed/simple;
	bh=5Y8oR+KoKskA3FNVYnfA0EbDZ68H3oWIh6hZUHqJx0o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N6ZxfSvImRRWRdPTUMJNiecnaoIOxIDw1kD3xa8+F6IxOjxFezWutZEV6Q3SP2wqToQpaLArUaQk/ZpKLYNWQYTHwfP9uqfhJOAVxgn0MNfefZgdPgmMKQ/sVNFvwbTiB7rQPGgd2FXrNQCzndOUuYHuCSuh/cIwVS98pt2Vz9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Jx1lG1Ki; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9iS3sJAasiDC8zeOw7PtnPEZBgzSBjSgT17X4V1FFos=; b=Jx1lG1KiWLXQiYXfbTDmysYKjq
	+agzMmBczRQO0tM9Cfa7FDQkDraVtc1T+VqOx8rj8/v+lgFvTBATFbH4w5i1IapHv1rZ+Yq+Si7rv
	SeqRzxTBLEhT/+PM5j6T4GHSMCCzp4zJ3+EdLHTsX//sOylOh3qKmV3kMRX8GsGAIa67ymDtEIDUf
	3oCzV0fl+5F/haKkDKcfxsvPjLvxe5ZOpJf+Xd6Fk4qMgh2wQn0iWpXzeqWOK4hjObYli8mZHgUpx
	4j0w5j7+x5Fyrszdjcu4mrd03oG75/5IFXt8Ulk+dy6UIoZZqGQckttY+NKxtZDuLtZyLD7gkAl53
	YIr1UxLA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wRtfE-002RUJ-1a;
	Tue, 26 May 2026 15:25:52 +0000
Message-ID: <ece62fc01497ee5b8bb7e272a0f6474e89c8e7b2.camel@debian.org>
Subject: Re: [PATCH 5.10] Revert "s390/cio: Fix device lifecycle handling in
 css_alloc_subchannel()"
From: Ben Hutchings <benh@debian.org>
To: Sasha Levin <sashal@kernel.org>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>, Salah Triki <salah.triki@gmail.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.ibm.com>
Date: Tue, 26 May 2026 17:25:44 +0200
In-Reply-To: <20260526140000.agent5-0001@kernel.org>
References: <ahVuMv5SLjHVUbkt@decadent.org.uk>
	 <20260526140000.agent5-0001@kernel.org>
Organization: Debian
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-0coBZp/mt3fhBitbhzYV"
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-254383-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linux.ibm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benh@debian.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5B9245D9216
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-0coBZp/mt3fhBitbhzYV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-05-26 at 09:38 -0400, Sasha Levin wrote:
> On Tue, May 26, 2026 at 11:56:02AM +0200, Ben Hutchings wrote:
> > The backported commit calls put_device() on the embedded struct
> > device, which is now reached if css_sch_create_locks() fails, before
> > it was initialised.  This effectively reverts upstream commit
> > f65c75b0b9b5 for 5.10.
>=20
> Queued for 5.10, thanks. I also queued matching reverts on 5.15 (of
> b1d4e6fb24167) and 6.1 (of fd295a75d828c), since the same goto-err
> path lands at the err: label before device_initialize() on those
> branches too.

Thanks.  I am still working my way through various fixes needed for
different stable branches.  I agree with reverting for exactly those
branches too.

Ben.

--=20
Ben Hutchings - Debian developer, member of kernel, installer and LTS
teams

--=-0coBZp/mt3fhBitbhzYV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoVu3gACgkQ57/I7JWG
EQk2dw/+PQTuaJ+CdUCCw3txIxgmXi9AsOcS//HL+VtUfdYYOnRw3ZhOHQFXNC0i
9f5NvA7ZZxcglhnTPpKNjEqPX+CMnDhFgH+On6A5p37BrMSYdDhJhzD+WA/dwOwx
JLOmW8M62kSjTrVO2iI+MGUNe4dC5pC1OQdOqnTT/VssuInDYawXuDVeTAsFK3i9
aQs+Kg4SC4wlnpkoi4a1Fa4siuFO3TqSYeMCjdYu8JVHs379lDlPtglES84EsEkm
gWROBGNiP2+ohLMaKwhm64Xp9bjhi+zh/Kuxg6fb66lp6gFOH8Wd+yItSQY7qqnV
tiDXgkYmb2kd3ySKJNe7XXXw0gbuIZ0P06CDEzRGEhsNYwYTnIlF2rDBn7JvMDfD
XuQrLC3AqBGb19tVMCHpqGHfynk3pXpQY9Eb9KK3NR8L4m6nTtjLpWpDhmCRhgoI
p9gDbNgdmx+AsQXbMBpdEIuG2cZvEptnDOyXC/Aouhch5sZ61v7QYbHzKZPpYHAO
5zyMd6+7NGA5cq37cuq98JBOV1G3DZQFA3hStTUk8THx450r9qMGd8WnzuCFSCmL
MtHOZENTU6kjlFKy3XcLccFAV8fw31z8LDmk4tQpBQgH/5YaUqrcpMPNiRDxz6rx
I+65X0ROpovpqIgHt1NZtnqAUEU9Yzkmz5HmQG+kw/kJWzPSYmo=
=LjJw
-----END PGP SIGNATURE-----

--=-0coBZp/mt3fhBitbhzYV--

