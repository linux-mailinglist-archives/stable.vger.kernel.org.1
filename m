Return-Path: <stable+bounces-253845-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNEQFmG4EGqzcwYAu9opvQ
	(envelope-from <stable+bounces-253845-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 22:11:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8B35B9EAC
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 22:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D07F9300B461
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 20:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3CB366560;
	Fri, 22 May 2026 20:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="AeEOHLnp"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DCE3164C3
	for <stable@vger.kernel.org>; Fri, 22 May 2026 20:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779480576; cv=none; b=d0P/NOU+P6Ou7rYCoSSzSygvZ7iSTMVZyK7hoWhxRDAE1gVt56JUxSCRoRxsOVLcuqK6gN22oxCw4UHi0Ity+Sh4s1FhaujtgxgqwZM7AuVPX/MBqEa1fBMgzH8cGvGpuFDJgveId/egRiJ8A1foxmNBDTUx73MFmb3yAyUhmho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779480576; c=relaxed/simple;
	bh=8HAvCT9JmAr3tMKMtb+u8hlmKOoh5HFadK4qXCnbVxU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TKjZv/nPoD7IPC99FUaGzWD3eIBzHxFEI262u2J0izOPFTSe8FRMH1D9RUjJ6oxhhFKzlHCOU8dhPVhsEuNI6toBB6/dW7AzAUzV5bT+BSyX49xSy72KAzWeEL3g60GkE4Dgwjo0bNMqx3gP18FJ6zEm/7Vu/4+fhL0l69piwjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=AeEOHLnp; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:References;
	bh=BOTVtEwChMF5bUnlSK4EFmJxp7tRj+ZXsHhd8LNxGfs=; b=AeEOHLnppYttovtgwID+Os8rHX
	jOldp2HBAlkaIrnbt2ZUpIGifukOHTQjriaZv4VtbG18oQqMbKvM5wIwnihbLWnij762K8Kp7YwWM
	x6e9ctNfnO+foX65aJ/aCdHYx11vSlcLbiWlDYAbEfmvXD49x53JO7hL4FTtczAI4lNDVJs8a+/d3
	HRV7q9L2zdUIqwGi9GvuI8oHawN0l2B0D0f8Qn0NsTEIC6x7JMPelERknfNFcO7lPkamzzYnWjW46
	sH4CHuQDL/AuNriHnjG1cbojqjEDy9CmPF6rSEa7D2ena+1DvflDI0yoMje2nCzRK+FgSDcbruxiQ
	trUVg7xg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wQWBP-004ucK-1c;
	Fri, 22 May 2026 20:09:24 +0000
Date: Fri, 22 May 2026 22:09:21 +0200
From: Ben Hutchings <benh@debian.org>
To: gregkh@linuxfoundation.org
Cc: vakzz@zellic.io, edumazet@google.com, jiayuan.chen@linux.dev,
	kuba@kernel.org, stable@vger.kernel.org
Subject: [PATCH 5.10] net: skbuff: preserve shared-frag marker during
 coalescing
Message-ID: <ahC38RZJN2O3Ur0R@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B/sUx3V38N8Tf+zc"
Content-Disposition: inline
In-Reply-To: <2026052258-glamorous-basically-d5e2@gregkh>
X-Debian-User: benh
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253845-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benh@debian.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,decadent.org.uk:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,zellic.io:email]
X-Rspamd-Queue-Id: AD8B35B9EAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--B/sUx3V38N8Tf+zc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: William Bowling <vakzz@zellic.io>

commit f84eca5817390257cef78013d0112481c503b4a3 upstream.

skb_try_coalesce() can attach paged frags from @from to @to.  If @from
has SKBFL_SHARED_FRAG set, the resulting @to skb can contain the same
externally-owned or page-cache-backed frags, but the shared-frag marker
is currently lost.

That breaks the invariant relied on by later in-place writers.  In
particular, ESP input checks skb_has_shared_frag() before deciding
whether an uncloned nonlinear skb can skip skb_cow_data().  If TCP
receive coalescing has moved shared frags into an unmarked skb, ESP can
see skb_has_shared_frag() as false and decrypt in place over page-cache
backed frags.

Propagate SKBFL_SHARED_FRAG when skb_try_coalesce() transfers paged
frags.  The tailroom copy path does not need the marker because it copies
bytes into @to's linear data rather than transferring frag descriptors.

Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags=
")
Signed-off-by: William Bowling <vakzz@zellic.io>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Tested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Link: https://patch.msgid.link/20260513041635.1289541-1-vakzz@zellic.io
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[bwh: Backported to 5.10: Set the SKBTX_SHARED_FRAG flag in
 sk_buff::tx_flags, instead of SKBFL_SHARED_FRAG in sk_buff::flags]
Signed-off-by: Ben Hutchings <benh@debian.org>
---
 net/core/skbuff.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 297a2efd6322..c195107434b8 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5315,6 +5315,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_b=
uff *from,
 	       from_shinfo->frags,
 	       from_shinfo->nr_frags * sizeof(skb_frag_t));
 	to_shinfo->nr_frags +=3D from_shinfo->nr_frags;
+	if (from_shinfo->nr_frags)
+		to_shinfo->tx_flags |=3D from_shinfo->tx_flags & SKBTX_SHARED_FRAG;
=20
 	if (!skb_cloned(from))
 		from_shinfo->nr_frags =3D 0;

--B/sUx3V38N8Tf+zc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoQt+0ACgkQ57/I7JWG
EQnCgw/7BTUWd/FxNa/gGJELrIWxIrmS7irx/LGRaalleajZcecFFBzNdoFThGYC
yGNcuX22lhyV0ypxQySLeUfOcNP9LJ/eeqSmO5B87EOmGaQvFf4U8S6lbMZTmERl
ef9W/QZXify5wTu2U5PZuA7UGslEyN4MQl6Ziey3yDGR3qvWGYmjaoPXBW5ckAhV
DgSA1ZL2sTadYiR/LbsDlySAQbtr1vasLRTDfwydeoXv94/xdOpwViFgyzAGzjHW
TFbJzL9YAK/QdY/8I/+86JQvefWvGZ2Re6Xhwljaq4SqhUcqawO2mAcx44WUVFJQ
xDGeTVNUvKYy09d29ixkwUr55ePUrlf15VKxAaPiFwTjBZ92vNH3qZG3o3YbjpDL
9JVftZbK7hyjbQLj0R5norzIvGphVzM0syWEbhf0lUxeUcwCtQWXtqKmvQJLxJQa
jrCyaq4Qnu5MzC2323cWLAB+YYqEMb/DrEBllxDLq4/xyjqNmZaGMokZHUMv5BTK
N5+F9EyQToV9g64SLZbOnm5moUFnthjhLAy/hwv8+E8FL5Co5j7JB7Y+QUlW3fNO
yag5tnZhkgSPWuXxf9sjeYr42ANKAQj2pGYoh/EIZrFA6jrhtCw5hGkCO6HtuzpY
QthsUZt23ufiia1upG8C1d2Ke1c1HndLgipz7NPkxC6VM6RqFN4=
=s7x9
-----END PGP SIGNATURE-----

--B/sUx3V38N8Tf+zc--

