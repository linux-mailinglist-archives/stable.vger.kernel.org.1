Return-Path: <stable+bounces-250028-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Fu4KRHgDWrb4QUAu9opvQ
	(envelope-from <stable+bounces-250028-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:23:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B23591D30
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE458300360A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABAE368941;
	Wed, 20 May 2026 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlTTQaxU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B3636655C;
	Wed, 20 May 2026 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294221; cv=none; b=hhIFlt20V8YqLB2k70/lxHpZKVQYOh24Ul7cds6FUdTFt07BoYicVNQPXx7+lJR9h7bQuziT4qkAQNA9/uXNBeZqLxvwNbJxLyLMJjemcLZzt9is5+I5QRdRUzn3bTfpEIPviRsk3VE4Puo9ODU9q/l64vAuj0fXmEzy9KPSQIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294221; c=relaxed/simple;
	bh=u/KaO83SHVe6c5S4taIdYCoZPJKYBkzrlFkFaB3LDIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1eIY4uPMetQ4W9lFom19nsV2qKfBNh4+BNnDOi65Ap02KL8grMCbf7HHf3HQ9W1cjoH0PG9zJG9wnREOnQzKB6HEQPx16G3Ygqqq27MwROL3nPiki1FU7L56myD2vxBh88lLgt+Cq3eeqyz49vvka7U1fGF3HFnLoA7EZRnS9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlTTQaxU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4591F000E9;
	Wed, 20 May 2026 16:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779294219;
	bh=JQ3Y7Pc2yJ25rdUSOQrD2jMUXpcIdISfmKHryk524Do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BlTTQaxUpjQveA7qLIdW+1aPFhhjjmxI9BIlColQpuokMH0nu4PJ/v/UaZzIbLRUL
	 RNg1g5O+RuG28gCef6ogyujH6zmikGiXvNKL9uWUznzJ/L2ljTMj9T+nSBkw7A/ZtC
	 9fng/gKakmcN9cdWSxXxRjViw+DgtC4wwibtfC7Y1xF7scT57F/jI0dukfz5bwr5wP
	 2bFKQSU3yBULEia6vCvWyYNEXkzweVdrWzD1NhuZLpni53zqXW3QekYYlA4Tx9l9sb
	 DzECsdi4VYnsM6M2dz7CaVATrKjKo/47xnYDdNZFZL5qeHox8Dc9JMuG0a/RnaWHhx
	 QLcDf0eGxRwZg==
Date: Wed, 20 May 2026 17:23:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mfd: max77620: Avoid regmap mutex deadlock in power-off
 handler
Message-ID: <3b2b25f9-3ab5-4811-9945-f317b8788484@sirena.org.uk>
References: <20260520-max77620_poweroff-v1-1-9186a3bcbe9e@tecnico.ulisboa.pt>
 <c8d16352-63a3-4512-b90c-a79e7e96dd3c@gmail.com>
 <38f5201a-6b52-4f18-bbbe-775171a3f147@tecnico.ulisboa.pt>
 <20260520161900.GM2767592@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7jdFGGanP92EQ6XD"
Content-Disposition: inline
In-Reply-To: <20260520161900.GM2767592@google.com>
X-Cookie: Natural laws have no pity.
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[tecnico.ulisboa.pt,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-250028-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 53B23591D30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--7jdFGGanP92EQ6XD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 05:19:00PM +0100, Lee Jones wrote:
> On Wed, 20 May 2026, Diogo Ivo wrote:

> > This patch was motivated by the Sashiko review I got in [1]. Its point
> > here is that there is a possibility for a deadlock scenario in which
> > a secondary CPU obtains the mutex for the regmap and then smp_send_stop=
()
> > is called before this secondary CPU gets a chance to release the mutex,
> > making it so that when the primary CPU tries to acquire it to issue the
> > write it hangs. Is there something that I am misunderstanding here?
> >=20

> It's my understanding that using the Regmap wrappers _prevents_ locking
> issues, rather than causes them.

In the case where the CPU is being powered off during a regmap write
there is a potential issue - as Diogo says if we're in the middle of
holding the lock and we power off the CPU that owns the lock then it
will never be able to release the lock.  I would expect the same issue
to apply to a bus like I2C or SPI though, they'll hold a lock while
they're in the middle of doing bus I/O unless you use some special API.

--7jdFGGanP92EQ6XD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoN4AcACgkQJNaLcl1U
h9AtEwf/SjiouU51+7i5JE9Hob+eT0GLACNgc+RVWCzqslyuCwJpEWO811M5HPSb
HQnVLdxXjchQ2ONToXretikUumZ6Rb+TKnEp7e5Pt/cubqIKWG+oJZlWV+CLsOW/
P1vcxF/Zy3l10GRNAkiNZAHarvsAUDrD+5Lo4+LLmwkT5o3qr8qWnHROrgTQigFv
zX7ASnbLJBWcAZ487yDSoQoHrjIEJlPLV4gNtrzjRQi5E8q0chUCZeKV1KXizvl2
b3LYMfAKxD23TC2xWmpXuTuNFNmiBOUhNt79+IY38wEgR+WpR4mY/JDa4baSBkTQ
F8LP5GFPw7IklOOElv5b7yZgtGdtIg==
=QtbP
-----END PGP SIGNATURE-----

--7jdFGGanP92EQ6XD--

