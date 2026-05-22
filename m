Return-Path: <stable+bounces-253832-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEU0MEeqEGrKcAYAu9opvQ
	(envelope-from <stable+bounces-253832-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 21:11:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 196625B947C
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 21:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49992300AB22
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 19:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80747374E67;
	Fri, 22 May 2026 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Sx3Jsk5o"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D4837267B
	for <stable@vger.kernel.org>; Fri, 22 May 2026 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779477058; cv=none; b=fE8hR2m21SVY5gsVWUMbShXf+evP91eVItrevq652Icj6QYN7sD3vodOJ6cXbJNMBwvhLVonGdNVw9ITjej7Vk5xzc8VqCJoTao1sOslaMF24fHK++L9q5yOgbs7nq68xnyWP1xcGHcut57YdCN0sW9r/HhkULSdFq1wZqaSNkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779477058; c=relaxed/simple;
	bh=l3Vaifya65BWqJD6uwYveWZb2/fVpqBHZe6uKHVHBg8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iran8hNOUQEVBlNGGWUSzCTLN2HGjgTj7SjQLQ2G5RW7uUaFsKrgUmHBZzr3K/FmT9XyRUK8O1E8IX+LnGCfeU2IPeSJjWxvNd6tPzhMHbKotOCKifXVSEW1NzApjMijSJ+vjdN1qmAq1v43qqg57ITxkxC2go08msO/c874kGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Sx3Jsk5o; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:References;
	bh=pLW6vqa2lPA2cvKTuwYeI0BWmivvcBCBj7L1OOLpd8k=; b=Sx3Jsk5osdlYE2xLqYXMN+/5nb
	ZraAMrmDzQ/g43s1UtB+CPp0pPm2nGsvZY9BQ2tVj4G5WsIySZXSDzSjd1Yvj3jlnKz5TMRzxa20x
	KayAvYJ3rWmBoitfXoHb+G2M+KRAPLZm1u4y6JIWIt1QZkA/iipgdfAZCqUEMa/16JG1ObE0P38J3
	spErkTI+9Pm9xY9mKJV9XaYVZnn6jiu0jMkzMKqhcRgnOn0RdQtFWl9G7HtBUvie9us5iMyRWum81
	YQuZW7rr6g4muTLUAfi9iZo2vnDpmkqB1Q0AzYb+IfkGUZzv3RNSHho2BZn3vv8sOObMlqUAIPJvO
	miD3kiZg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wQVGS-004saf-1V;
	Fri, 22 May 2026 19:10:33 +0000
Date: Fri, 22 May 2026 21:10:30 +0200
From: Ben Hutchings <benh@debian.org>
To: gregkh@linuxfoundation.org
Cc: imv4bel@gmail.com, aaron1esau@gmail.com, ben@decadent.org.uk,
	malin89@huawei.com, pabeni@redhat.com, rajat.gupta@oss.qualcomm.com,
	sd@queasysnail.net, sultan@kerneltoast.com, tanjingguo@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH 6.1] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <ahCqJlqexPCiB0P9@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jvVrsJBQudFFlcg+"
Content-Disposition: inline
In-Reply-To: <2026052229-surpass-savanna-6757@gregkh>
X-Debian-User: benh
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	FREEMAIL_CC(0.00)[gmail.com,decadent.org.uk,huawei.com,redhat.com,oss.qualcomm.com,queasysnail.net,kerneltoast.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253832-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benh@debian.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Queue-Id: 196625B947C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--jvVrsJBQudFFlcg+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Hyunwoo Kim <imv4bel@gmail.com>

commit 48f6a5356a33dd78e7144ae1faef95ffc990aae0 upstream.

Two frag-transfer helpers (__pskb_copy_fclone() and skb_shift()) fail
to propagate the SKBFL_SHARED_FRAG bit in skb_shinfo()->flags when
moving frags from source to destination.  __pskb_copy_fclone() defers
the rest of the shinfo metadata to skb_copy_header() after copying
frag descriptors, but that helper only carries over gso_{size,segs,
type} and never touches skb_shinfo()->flags; skb_shift() moves frag
descriptors directly and leaves flags untouched.  As a result, the
destination skb keeps a reference to the same externally-owned or
page-cache-backed pages while reporting skb_has_shared_frag() as
false.

The mismatch is harmful in any in-place writer that uses
skb_has_shared_frag() to decide whether shared pages must be detoured
through skb_cow_data().  ESP input is one such writer (esp4.c,
esp6.c), and a single nft 'dup to <local>' rule -- or any other
nf_dup_ipv4() / xt_TEE caller -- is enough to land a pskb_copy()'d
skb in esp_input() with the marker stripped, letting an unprivileged
user write into the page cache of a root-owned read-only file via
authencesn-ESN stray writes.

Set SKBFL_SHARED_FRAG on the destination whenever frag descriptors
were actually moved from the source.  skb_copy() and skb_copy_expand()
share skb_copy_header() too but linearize all paged data into freshly
allocated head storage and emerge with nr_frags =3D=3D 0, so
skb_has_shared_frag() returns false on its own; they need no change.

The same omission exists in skb_gro_receive() and skb_gro_receive_list().
The former moves the incoming skb's frag descriptors into the
accumulator's last sub-skb via two paths (a direct frag-move loop and
the head_frag + memcpy path); the latter chains the incoming skb whole
onto p's frag_list.  Downstream skb_segment() reads only
skb_shinfo(p)->flags, and skb_segment_list() reuses each sub-skb's
shinfo as the nskb -- both p and lp must carry the marker.

The same omission also exists in tcp_clone_payload(), which builds an
MTU probe skb by moving frag descriptors from skbs on sk_write_queue
into a freshly allocated nskb.  The helper falls into the same family
and warrants the same fix for consistency; no TCP TX-side in-place
writer is currently known to reach a user page through this gap, but
a future consumer depending on the marker would regress silently.

The same omission exists in skb_segment(): the per-iteration flag
merge takes only head_skb's flag, and the inner switch that rebinds
frag_skb to list_skb on head_skb-frags exhaustion does not fold the
new frag_skb's flag into nskb.  Fold frag_skb's flag at both sites
so segments drawing frags from frag_list members carry the marker.

Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags=
")
Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Suggested-by: Sultan Alsawaf <sultan@kerneltoast.com>
Suggested-by: Ben Hutchings <ben@decadent.org.uk>
Suggested-by: Lin Ma <malin89@huawei.com>
Suggested-by: Jingguo Tan <tanjingguo@huawei.com>
Suggested-by: Aaron Esau <aaron1esau@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Tested-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Link: https://patch.msgid.link/ageeJfJHwgzmKXbh@v4bel
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[bwh: Backported to 6.1:
 - skb_gro_receive_list() is in net/ipv4/udp_offload.c here
 - Drop change to tcp_clone_payload(), which does not exist here
]
Signed-off-by: Ben Hutchings <benh@debian.org>
---
 net/core/gro.c         | 2 ++
 net/core/skbuff.c      | 9 ++++++++-
 net/ipv4/udp_offload.c | 2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/core/gro.c b/net/core/gro.c
index 52b91cfb3bf1..ea6571c01faa 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -281,10 +281,12 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff=
 *skb)
 	p->data_len +=3D len;
 	p->truesize +=3D delta_truesize;
 	p->len +=3D len;
+	skb_shinfo(p)->flags |=3D skbinfo->flags & SKBFL_SHARED_FRAG;
 	if (lp !=3D p) {
 		lp->data_len +=3D len;
 		lp->truesize +=3D delta_truesize;
 		lp->len +=3D len;
+		skb_shinfo(lp)->flags |=3D skbinfo->flags & SKBFL_SHARED_FRAG;
 	}
 	NAPI_GRO_CB(skb)->same_flow =3D 1;
 	return 0;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index fd743051c898..8bc4b26de5e5 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1798,6 +1798,7 @@ struct sk_buff *__pskb_copy_fclone(struct sk_buff *sk=
b, int headroom,
 			skb_frag_ref(skb, i);
 		}
 		skb_shinfo(n)->nr_frags =3D i;
+		skb_shinfo(n)->flags |=3D skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
 	}
=20
 	if (skb_has_frag_list(skb)) {
@@ -3789,6 +3790,8 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *sk=
b, int shiftlen)
 	tgt->ip_summed =3D CHECKSUM_PARTIAL;
 	skb->ip_summed =3D CHECKSUM_PARTIAL;
=20
+	skb_shinfo(tgt)->flags |=3D skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
+
 	skb_len_add(skb, -shiftlen);
 	skb_len_add(tgt, shiftlen);
=20
@@ -4362,7 +4365,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		skb_copy_from_linear_data_offset(head_skb, offset,
 						 skb_put(nskb, hsize), hsize);
=20
-		skb_shinfo(nskb)->flags |=3D skb_shinfo(head_skb)->flags &
+		skb_shinfo(nskb)->flags |=3D (skb_shinfo(head_skb)->flags |
+					    skb_shinfo(frag_skb)->flags) &
 					   SKBFL_SHARED_FRAG;
=20
 		if (skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
@@ -4379,6 +4383,9 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 				nfrags =3D skb_shinfo(list_skb)->nr_frags;
 				frag =3D skb_shinfo(list_skb)->frags;
 				frag_skb =3D list_skb;
+
+				skb_shinfo(nskb)->flags |=3D skb_shinfo(frag_skb)->flags & SKBFL_SHARE=
D_FRAG;
+
 				if (!skb_headlen(list_skb)) {
 					BUG_ON(!nfrags);
 				} else {
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 58cabb2bb32a..35c014e10f24 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -546,6 +546,8 @@ static int skb_gro_receive_list(struct sk_buff *p, stru=
ct sk_buff *skb)
 	p->truesize +=3D skb->truesize;
 	p->len +=3D skb->len;
=20
+	skb_shinfo(p)->flags |=3D skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
+
 	NAPI_GRO_CB(skb)->same_flow =3D 1;
=20
 	return 0;

--jvVrsJBQudFFlcg+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoQqiEACgkQ57/I7JWG
EQngBg//UCpx4E9Fj5Wrz9xevNGlllCTXIYKJ+5PeUmvs7GC5KQTuQkedC56l1wu
tgisrQjW58hbsVuUcmkTOvY24oMXeWpAHJJ4EIR4sBYzzpVCyMjfkRr7KDp9RuKz
MG6L37lwp9UDMVNzsd0k8v+YI8c9bHJ2HXeQsP+3ky9bwvm4Uwx8O6+0sfCcH7sO
NLgsf2yjmITnWXBtU/T5617awHlffOeiDmuY4Y+5S8YxquSPcH50wzJTNDtn+mrg
nomUjn2iQDMsldQdVcrOsXIzEUjd0fToEMrFf1mkpWbvn9b3HQ7EdXi5WC6j96km
ellKO0hD1aourlonjcaEDcWvTZiL3R7NoOs7ZGJ4bxldh8ldxFFyKfzQZIOBPO2I
QRTR0xiCpWp9stjpFWyLgtQnjJV8qptYHENyYXuzlyZDuQsqEs5x016ZtBdxZLWf
aNsbahEP4WF8VJKVDJyVdcArnm0BFgx1i6NuTdj1Lp494tmUj+bIG9w0uaUzukl9
CbwWO65ppp7sN/KqgRDB/Krz9yl6UeUNX3n6448MFrsLCzrQGc1rCyxzF75MAWg6
hiaQ0bi/0FdpBJXyokoTBNc01vKs0p87FdOV36rFl77YJY2/5/mrrVmxxsX3uANw
9nyJnECPqWyCv+R6z2saDBC4hqIbfA60yNDaNAb3cN5oY73Ek7U=
=vGIF
-----END PGP SIGNATURE-----

--jvVrsJBQudFFlcg+--

