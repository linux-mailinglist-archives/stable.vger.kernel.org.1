Return-Path: <stable+bounces-230796-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O5YEd3+x2kqgAUAu9opvQ
	(envelope-from <stable+bounces-230796-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 17:16:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B2934F223
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 17:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12815302C34D
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 16:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501C81FF7C7;
	Sat, 28 Mar 2026 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bschu.de header.i=@bschu.de header.b="gigh09rf"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529BB3A16BE;
	Sat, 28 Mar 2026 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774714579; cv=none; b=jCcjUn4JAsAa4O7kCQv6n3AwKg2frg5bFv9KB56sy3OyJrW5IbFgAIk1G7Uf5vwqEx8ohEsNO2TWmp967Bz1aXuGQYJTUgkmzrpU1wIBYT8Cc/mV3941iidFkUTiQ+FzAEZSIfcBZ2O3Hp4LRrt1jnLYaoTwt/HLaDDdJN3smNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774714579; c=relaxed/simple;
	bh=3Qd6ZKYvZ2ezTkWdm5ZPnie/sZQm/AeBiQahQgjMvH8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nbuve/7F3wKhfiqRB/jJfyc5Q7iMu+ZUlo8T9h7+atSul50uSw7F57C/4bklxxkXjAgMlwSr1/jwrP4qDFkh6VbijnYIR9dHhBo0+wJ+unza4Y5oEs7/lr3VfTqFBL9optg7yatb/FA6hGdqQW2rcRYYbTAgrSbNOO/lclJ3zR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bschu.de; spf=pass smtp.mailfrom=bschu.de; dkim=pass (2048-bit key) header.d=bschu.de header.i=@bschu.de header.b=gigh09rf; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bschu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bschu.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fjjLP2h2Bz9scQ;
	Sat, 28 Mar 2026 17:16:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bschu.de; s=MBO0001;
	t=1774714573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3Qd6ZKYvZ2ezTkWdm5ZPnie/sZQm/AeBiQahQgjMvH8=;
	b=gigh09rfXSaQ0MFkB9DrpeKevM476BBA+z3Vf3omxbH3WIuUovUodOA/c2FUCvHVdgx+Hl
	Nak2WoNxrX/0UVc+XzvlbtA2pYk6Lpydj99SXCVf01efbDKoFkMoRj8lAV8ATmF3mhn9bo
	psZe4DoJSob6/Az/RAG+AlyJnIuGiFjNe4SzEivY7MmWkQlKkyK73wPLy4fv1+ZW8H2Kd+
	gF6bQU6CL+i9/pKw4tJTDDSbPoOQFxMKoRl4uNV+qF9SqZUZ6Nq/HtUgb5gTHv83fQMJYu
	h1BVzRIso3apEcW8hOndYt5UpN1kLCwBW+CVV7OJN88aqJvq9CWFGuoxEXyd/w==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of bernd@bschu.de designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=bernd@bschu.de
Message-ID: <74bcd84500e5efcca035624f325e400dd8a21f44.camel@bschu.de>
Subject: Re: [6.12.y regression] Regression with 58130e7ce6cb ("PCI/ERR:
 Ensure error recoverability at all times"): echo vfio-pci >driver_override
 does not work for DVB Adapter
From: Bernd Schumacher <bernd@bschu.de>
To: Lukas Wunner <lukas@wunner.de>, Salvatore Bonaccorso <carnil@debian.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>,  Mario Limonciello <mario.limonciello@amd.com>,
 1131025@bugs.debian.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 28 Mar 2026 17:16:08 +0100
In-Reply-To: <acfhf-odtr0yw_py@wunner.de>
References:
	 	<177373189751.7987.7156982489427825197.reportbug@obelix-trixie.bs.de>
		 <acfZrlP0Ua_5D3U4@eldamar.lan> <acfhf-odtr0yw_py@wunner.de>
Autocrypt: addr=bernd@bschu.de; prefer-encrypt=mutual;
 keydata=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
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-IGg7D0NYjAzBsAiNSAPW"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bschu.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bschu.de:s=MBO0001];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230796-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bschu.de:+];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bschu.de,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bschu.de:dkim,bschu.de:mid]
X-Rspamd-Queue-Id: 03B2934F223
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-IGg7D0NYjAzBsAiNSAPW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your patch. But ...
Applying the patch to v6.12.73 did not help. (same errors).

Thanks!
Bernd


Am Samstag, dem 28.03.2026 um 15:11 +0100 schrieb Lukas Wunner:
> On Sat, Mar 28, 2026 at 02:37:50PM +0100, Salvatore Bonaccorso wrote:
> > Bernd Schumacher reported in Debian (report and report from
> > bisection
> > in https://bugs.debian.org/1131025) a 6.12.y specific regression of
> > 58130e7ce6cb ("PCI/ERR: Ensure error recoverability at all times"):
>=20
> Thanks for the report and sorry for the breakage.
>=20
> According to the Debian bug report, the issue only occurs on
> v6.12-stable.=C2=A0 It does not affect v6.18 and v6.19.
>=20
> I note that v6.12-stable commit 58130e7ce6cb differs from upstream
> commit a2f1e22390ac in that the call to pci_save_state() is at the
> top of pci_bus_add_device(), not in the middle of the function after
> pci_bridge_d3_update().
>=20
> @Bernd, could you test whether moving the call to pci_save_state()
> as in the small patch below resolves the issue on v6.12-stable?
>=20
> If it does, then the upstream commit was backported to v6.12 in an
> incorrect manner.=C2=A0 If it does not, I need to dig deeper.
>=20
> Thanks!
>=20
> Lukas
>=20
> -- >8 --
>=20
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 429c0c8ce93d..bdb3e10f947a 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -331,9 +331,6 @@ void pci_bus_add_device(struct pci_dev *dev)
> =C2=A0 struct device_node *dn =3D dev->dev.of_node;
> =C2=A0 int retval;
> =C2=A0
> - /* Save config space for error recoverability */
> - pci_save_state(dev);
> -
> =C2=A0 /*
> =C2=A0 * Can not put in pci_device_add yet because resources
> =C2=A0 * are not assigned yet for some devices.
> @@ -346,6 +343,9 @@ void pci_bus_add_device(struct pci_dev *dev)
> =C2=A0 pci_proc_attach_device(dev);
> =C2=A0 pci_bridge_d3_update(dev);
> =C2=A0
> + /* Save config space for error recoverability */
> + pci_save_state(dev);
> +
> =C2=A0 dev->match_driver =3D !dn || of_device_is_available(dn);
> =C2=A0 retval =3D device_attach(&dev->dev);
> =C2=A0 if (retval < 0 && retval !=3D -EPROBE_DEFER)

--=-IGg7D0NYjAzBsAiNSAPW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEx5NNNf+H1Sb3l9vqxRmiDRIUYfcFAmnH/sgACgkQxRmiDRIU
YfcVOxAAj5oOtyAyMl2q/+doqmrjj5ATgFL2Cx4q6rVxhp0fdLUi6wyJZE7K3mPd
NFux4Ar2QtB3Lr5pTxUpo0i/RuRqKjJfzcfogKW8UgagvQfsnOxOmI8/c1beRMj/
241I0QWKV6joHYhEOOjJLfquIw2PgcIMnH2rakgPSiYLq3fnPhAuY/sqkRrhLbdQ
tlXHcz9C20FjIqEHd5eqcKX6babr1vc+ufhQ5V5ahJ/tCvNacruIukHqphMSuPHp
HupnPaSLNFu40Jk393tvc2oh7QpkkBPyVXshV7iHcGdz26lNHiX8Y93x1U9ulTtq
qaL5k0nPrDBgO8Fquol27rIrusHnhpAqtAY3tlr8vN6fxtGtpuPeuiNX6q1u5VQO
JNrOQBRuYHSrc6WLBVsgRrK+Q36G4w8LxPHKXgvnc0JFKbQv2GuavWR7WUTZ3wCA
xJmkL13bweGdckpM2/vEY1n73g1vDifwz9Pt9vv+7kA9r96OpGt/d9+3RrlLLsQl
VceSJfizIoSEF4wBi/2joGkMjNsJZJMc2LH/ZQ/DnCYEPIjpIVBhESTvxiKLbL/x
Utus5xER7eZkwn4HbAtCYmnWCHeYn37zCg5NmImdptTpVazeSXH2uYTC1YwGnQGv
M+hB3zCmvodLeGWDuarZVoh6KRch2GSn2aZ0169Jf9S5oLvLm6U=
=jLW9
-----END PGP SIGNATURE-----

--=-IGg7D0NYjAzBsAiNSAPW--

