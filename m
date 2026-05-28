Return-Path: <stable+bounces-254843-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LvUK+EiGGrkeAgAu9opvQ
	(envelope-from <stable+bounces-254843-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:11:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B86C95F116F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29A2B3025AD0
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD3E3DEAE4;
	Thu, 28 May 2026 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="WK9pAt2Y"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120C137B007
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966617; cv=none; b=kmxIEUe9GA2CV++Ng/YRwPQQCh8Em8P44p3AFNIXhkJoQQlDP73tFNYZcgOnWDZS0aVBGKS2fC1RogHhNvVSV+TAfhWp7FwmRjsVrKQWQjjTPvYwZsy6+H2c+07m8/zw2Ff5i6ZbF9svdAvg+RqrTVC2CfkNAbqNsPzcgAKA/Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966617; c=relaxed/simple;
	bh=O7TqQp1ifE+XWbzOJkonqBq9p8R5a/wtq6JWMZ0THEI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ox95VnekKzJyWGEIAcru+Jh5nsA6iplbinkxgPF2TwTHtcGaRXCL2F+rMRHKfU7IxB9auPQrWBUY8dcfoqXM2jvqIpQRYSN5eHBIxMv6eXY8za2drkWOWg7eR5XIEmgZbA6u9tkts6FulUMi1DjgoFvCTtP0c7K9cI0evXBLcBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=WK9pAt2Y; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T9Cv0nl0M/WdEnMfOrR5rI1IxaR7g8kxmGZyXVRoNes=; b=WK9pAt2YVmESE9fUld9rr06Wyd
	siLumDazF6T8J25q6vB44BRoMW6GvCYYKetExxxPgW/6aMittbv96mzOQIV3C/O0i2BBM+ktvuxiq
	xXRAVDPd6YN1CFv/cx+0Xygq/NoQ7GFFN+MRc50fQ/jE8wMwPGWuhXvl1x6ysrpEdli9h+SJz6lo7
	cCmok17OlPAUGI7AwFKHq9vxA0N8vaT8I8lZlk/eumGL/jbGdwJM56nzTqON1roL0bAsbOLkVrpCb
	V8I8UMvgVdscR1/Xp/22c81bJKWqs3QCakUlLloF+G1Bb80q+vX6J0e15OksQnsy2Sz9qEh0VrvEV
	l4+bK+iA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wSYct-003zMv-0W;
	Thu, 28 May 2026 11:10:11 +0000
Message-ID: <bbee79323cd7836164c92229b0b2ed38b5179353.camel@debian.org>
Subject: Re: [PATCH 5.10 2/2] RDMA/rxe: Fix double free in rxe_srq_from_init
From: Ben Hutchings <benh@debian.org>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>, Sasha Levin
	 <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Zhu Yanjun <yanjun.Zhu@linux.dev>, Leon Romanovsky <leon@kernel.org>, 
	stable@vger.kernel.org
Date: Thu, 28 May 2026 13:10:10 +0200
In-Reply-To: <ahgh1NzAqpY53SzJ@decadent.org.uk>
References: <f7f34b5cf1ddd5a880e0ceba52670bb73f2d21e2.camel@decadent.org.uk>
	 <ahgh1NzAqpY53SzJ@decadent.org.uk>
Organization: Debian
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-zgjjOotmmR0sHGVaXuKL"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Debian-User: benh
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-254843-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,linuxfoundation.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benh@debian.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:email,msgid.link:url]
X-Rspamd-Queue-Id: B86C95F116F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-zgjjOotmmR0sHGVaXuKL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies, this should have been sent from my address.

Ben.

I wrote:
> commit 0beefd0e15d962f497aad750b2d5e9c3570b66d1 upstream.
>=20
> In rxe_srq_from_init(), the queue pointer 'q' is assigned to
> 'srq->rq.queue' before copying the SRQ number to user space.
> If copy_to_user() fails, the function calls rxe_queue_cleanup()
> to free the queue, but leaves the now-invalid pointer in
> 'srq->rq.queue'.
>=20
> The caller of rxe_srq_from_init() (rxe_create_srq) eventually
> calls rxe_srq_cleanup() upon receiving the error, which triggers
> a second rxe_queue_cleanup() on the same memory, leading to a
> double free.
>=20
> The call trace looks like this:
>    kmem_cache_free+0x.../0x...
>    rxe_queue_cleanup+0x1a/0x30 [rdma_rxe]
>    rxe_srq_cleanup+0x42/0x60 [rdma_rxe]
>    rxe_elem_release+0x31/0x70 [rdma_rxe]
>    rxe_create_srq+0x12b/0x1a0 [rdma_rxe]
>    ib_create_srq_user+0x9a/0x150 [ib_core]
>=20
> Fix this by moving 'srq->rq.queue =3D q' after copy_to_user.
>=20
> Fixes: aae0484e15f0 ("IB/rxe: avoid srq memory leak")
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> Link: https://patch.msgid.link/20260112015412.29458-1-jiashengjiangcool@g=
mail.com
> Reviewed-by: Zhu Yanjun <yanjun.Zhu@linux.dev>
> Signed-off-by: Leon Romanovsky <leon@kernel.org>
> [bwh: Backported to 5.10: There was no assignment to init->attr.max_wr
>  here; don't add it]
> Signed-off-by: Ben Hutchings <benh@debian.org>
> ---
>  drivers/infiniband/sw/rxe/rxe_srq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/=
rxe/rxe_srq.c
> index 41b0d1e11baf..4e523d91e7dc 100644
> --- a/drivers/infiniband/sw/rxe/rxe_srq.c
> +++ b/drivers/infiniband/sw/rxe/rxe_srq.c
> @@ -98,8 +98,6 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_s=
rq *srq,
>  		return -ENOMEM;
>  	}
> =20
> -	srq->rq.queue =3D q;
> -
>  	err =3D do_mmap_info(rxe, uresp ? &uresp->mi : NULL, udata, q->buf,
>  			   q->buf_size, &q->ip);
>  	if (err) {
> @@ -116,6 +114,8 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe=
_srq *srq,
>  		}
>  	}
> =20
> +	srq->rq.queue =3D q;
> +
>  	return 0;
>  }
> =20

--=20
Ben Hutchings - Debian developer, member of kernel, installer and LTS
teams

--=-zgjjOotmmR0sHGVaXuKL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoYIpIACgkQ57/I7JWG
EQlh9A//SpfFXfvVwbhPPGIG7aTjCHw9nvsix7BgiUBqfzTlPBTzH1lJWH327IZX
Jg21c+Unw9T+FwXQUQ+aOYJsTVVrnil0dTgk3Vp13qhV507Ru1wOcsI7+EaSTUb5
40ddD/jq2/68i2CJCAo891IgvEivvKsPmT8eHYGCeUnMj/ut9gX9kzU9zXMfGxpB
apZaks8hmYroQBOEc6dQPhfGBV8CsZ9fTqlGHYxhafpcH2f2q2qfId+aSv3fu2ri
wNRps+Sclj0sNUJl4lTlCF3a8fPYXE6AL+otD1PujdNCl7QKuaz3jqawZrCp3gV3
x/VPfiv58VWDsLzq2xaQAt8eAr7V12iwh7S+bOQi6m572GwZNbdFx5TQk91HGpIB
16ZbIjffsq1imtWybDOJMwnqnUkJzxZVZNUUIHpFMTDuta9iznBE9af83m6zd72N
UH2emo0MfMwmO6AFYi6RI+ySOz8tLw/QWe7LX7NaQwONvlna118iBV1+t7Mw0TSm
RTTh8roqPvHiD1xXVqxX3IRtUblTBecJikafnix/aoacMXQ7U2UsNzdKLO2bscSY
ZXUkaVnHCEbtAmJ/m8MwPjL4U6qKT1pWcy15m59gdbGfCmMjWtHz34YLDdE8V2sU
czsQZtRWTB6v5ndBGwxG24l/bWF4KTcz0CsXQrpg4nCiZMUa3pE=
=WIQX
-----END PGP SIGNATURE-----

--=-zgjjOotmmR0sHGVaXuKL--

