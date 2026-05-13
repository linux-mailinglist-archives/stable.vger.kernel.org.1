Return-Path: <stable+bounces-246930-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBE/LeKsBGrIMwIAu9opvQ
	(envelope-from <stable+bounces-246930-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:54:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1804B537816
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EE41318D1D1
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985834C77CD;
	Wed, 13 May 2026 16:22:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CF849551B;
	Wed, 13 May 2026 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689342; cv=none; b=F05cS+izFIlPBxGt8Vy9I93gJpPTtjSTTFQIw5fsiNBAEt0nFFLEf9yNkF+4Ev8h3v5yRuJRmCR4x0QFa3zCmKRG+sNglvmD0zv9VLGESL0YNuVqyKi3oEmFcfvLDENl4HCoJYHH0na+ct0D4nPtIQHG+2w7KzNmI8pt7C56Lnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689342; c=relaxed/simple;
	bh=vFAZgYDD5dZ4VzF0mMVbIqdZ7V3SXjVYPJfwu5WgA+o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gJtXOsRu+z7y01xs+FDrMQovO7UTyPZZOuyrZ6SCTVfdYGpVZdJ+d4CFIA2th4I0F+KL8PAIpT9sAKKbMkbsbhOg0Wnhj6Nh6N79/cJhYjAmUGZRopqjaBR3BKuyGR9y/SiSc5qR6VPE1eebzwANEPnUdjyDN+c5yTHRu+Cof6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1wNCLL-000uBt-14;
	Wed, 13 May 2026 16:21:55 +0000
Received: from ben by deadeye with local (Exim 4.99.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1wNCLJ-00000000Jmr-3fj7;
	Wed, 13 May 2026 18:21:53 +0200
Message-ID: <811b31f3373526d1ff60160c2f32ddb359e54c31.camel@decadent.org.uk>
Subject: Re: [PATCH net] net: skbuff: propagate shared-frag marker through
 pskb_copy()
From: Ben Hutchings <ben@decadent.org.uk>
To: Hyunwoo Kim <imv4bel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, 	kuba@kernel.org, pabeni@redhat.com,
 steffen.klassert@secunet.com, 	herbert@gondor.apana.org.au,
 dsahern@kernel.org, vakzz@zellic.io
Cc: stable@vger.kernel.org, netdev@vger.kernel.org
Date: Wed, 13 May 2026 18:21:45 +0200
In-Reply-To: <agRfuVOeMI5pbHhY@v4bel>
References: <agRfuVOeMI5pbHhY@v4bel>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-VtuV1HUGkvWM/tnmIfYU"
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
X-Rspamd-Queue-Id: 1804B537816
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246930-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,secunet.com,gondor.apana.org.au,zellic.io];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DMARC_NA(0.00)[decadent.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zellic.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--=-VtuV1HUGkvWM/tnmIfYU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-05-13 at 20:25 +0900, Hyunwoo Kim wrote:
> __pskb_copy_fclone() shallow-copies the source's frag descriptors and
> bumps each page's refcount via skb_frag_ref(), then defers the rest
> of the shinfo metadata to skb_copy_header().  That helper only carries
> over gso_{size,segs,type} and never touches skb_shinfo()->flags, so
> the destination skb keeps a reference to the same externally-owned or
> page-cache-backed pages while reporting skb_has_shared_frag() as
> false.
>
> The mismatch is harmful in any in-place writer that uses
> skb_has_shared_frag() to decide whether shared pages must be detoured
> through skb_cow_data().  ESP input is one such writer (esp4.c,
> esp6.c), and a single nft 'dup to <local>' rule -- or any other
> nf_dup_ipv4() / xt_TEE caller -- is enough to land a pskb_copy()'d
> skb in esp_input() with the marker stripped, letting an unprivileged
> user write into the page cache of a root-owned read-only file via
> authencesn-ESN stray writes.
>=20
> Set SKBFL_SHARED_FRAG on the destination whenever frag descriptors
> were actually moved from the source.  skb_copy() and skb_copy_expand()
> share skb_copy_header() too but linearize all paged data into freshly
> allocated head storage and emerge with nr_frags =3D=3D 0, so
> skb_has_shared_frag() returns false on its own; they need no change.

What about skb_shift()?  It seems like that should also propagate this
flag.  But I could be missing some reason why it's not necessary.

Ben.

> Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
> Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb fra=
gs")
> Reported-by: William Bowling <vakzz@zellic.io>
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/core/skbuff.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 7dad68e3b518..15bdec53e8d9 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -2248,6 +2248,7 @@ struct sk_buff *__pskb_copy_fclone(struct sk_buff *=
skb, int headroom,
>  			skb_frag_ref(skb, i);
>  		}
>  		skb_shinfo(n)->nr_frags =3D i;
> +		skb_shinfo(n)->flags |=3D skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
>  	}
> =20
>  	if (skb_has_frag_list(skb)) {
> @@ -6200,6 +6201,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk=
_buff *from,
>  	       from_shinfo->frags,
>  	       from_shinfo->nr_frags * sizeof(skb_frag_t));
>  	to_shinfo->nr_frags +=3D from_shinfo->nr_frags;
> +	if (from_shinfo->nr_frags)
> +		to_shinfo->flags |=3D from_shinfo->flags & SKBFL_SHARED_FRAG;
> =20
>  	if (!skb_cloned(from))
>  		from_shinfo->nr_frags =3D 0;

--=20
Ben Hutchings
Tomorrow will be cancelled due to lack of interest.

--=-VtuV1HUGkvWM/tnmIfYU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoEpRkACgkQ57/I7JWG
EQnHXg//egi/k+h/cersu22OkNm+wnhtPoWEUjKNYOKjYkhfqAYa52XfiKXT4xRc
ALIpU3ltu4JSO7/oFtDuwr0PCwjm7oFKQlN1CuhTI/GlRlHglyvwx2ZucNfQ7+gN
Seqi1g09cceIcNT/R6SCyRQ/2rqNz0tGTiuCAnrw0dkCrp2chL8o1xvvNZUctu6A
CXclAhcXC44VX+E19ER/RWEyAN7YQOcDuSiKsrzYJvquCcWBSRkVyNBNqrqNB8TN
KiYraoeSG8lHuFkzazeYG/Jw20f+fMic35AlIF/fhNcvbPeV/Ol/3QyhTH66jJ6w
7rr92kR5kcPcKu60JdooggKHYmpRTdGwO+TjqpTiKOuWPwcHKDufZcpNU//2fq00
zugVf7l7JMN4tOktxm70q7nBqwK+q+scsweH/zOT0ixKManA0JKqgS9AIXLg7Nvx
ao271w5kgPRz7YnNE3Biw2B2qEK0uKF/DchIxBAgFSns6ioiTs+kwWo70Do08RkU
Ae1uckXZd3S85RK20Gz3uGX3tS5JdeNoJoxQ3Xr4ta2GmWTU9CQfgL4K/0ThGXzP
5BRY7r9re55wbIaNXUQVvFhMhoPH1wcOFXDINyohAtVI0ysjP2zTANlnbnCLCorG
7FGxkYuh4xo7R/zBLeyt0NTMKHMfPkz9I9uIOz5+yvwPow23Wds=
=//TR
-----END PGP SIGNATURE-----

--=-VtuV1HUGkvWM/tnmIfYU--

