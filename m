Return-Path: <stable+bounces-253846-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mO1yKlq5EGqzcwYAu9opvQ
	(envelope-from <stable+bounces-253846-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 22:15:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 046B95B9F10
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 22:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E725301E3CD
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 20:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43DE366560;
	Fri, 22 May 2026 20:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="I/wfxB4c"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B945A30EF90
	for <stable@vger.kernel.org>; Fri, 22 May 2026 20:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779480767; cv=none; b=b76hDLQOgC6QBO/MJQTwPRAt1Hiesk9L7mGT1jym6JR9QodplOLLV8eBRWw4jkCQ8++Rk9xu5UuuEaBEQgtYbftL4UkoUKrxbymO65YBKLX+rwAtUWMn+Xqz4ayK4UszQNp3auosAhckR5sImbIYlJgWcGjgwjvg1nYIVce7mQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779480767; c=relaxed/simple;
	bh=2qB0GvAemKbj1nT/4r+z632EgR++a6cGUvXz3YzEfdw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=r8BGWSVfJEfxkfPsXdZA1Z1sZAUjqfpLJi4nO8fvQXejf1nO6x4hVxftscIExeF8zqtyITVUnSO0R+MqPwtmwYmRe8oMhpqwjzZvOtsIRqmrKzwifoxw8+v99fQzoSKHBm1ylUSyDZLO7qHmjxdLgHHewco04gpRqEVQYCnZqDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=I/wfxB4c; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:References;
	bh=1V+weDWRJLHVkUSFGCiTcGqJtkWmyWKWbKnbBI7YdQs=; b=I/wfxB4cmqdJ3sXxaQ0dLiNSO6
	NPfpuMP0HEb4x6C9u5KJWKh1C+sN56v4wIxlGpIJOxLmcnF2Ro2YzH0jvZptXShpgLa0oVi5ol6Lg
	OW1WpRnq1D5BI28r/4cRKY5kt5uou3NEzCnHE10Gx8YOmV3mzH5NspKGikwldq8C+raDyWsgayA1J
	70Mc2xZhqdHJ7/twsj13OCdTBJKKqgJ5RgrgPtPDvo9ZgVqHG4pLKBHv/U5gSPKG0nJ0KXg5vwzz2
	TNZoX5xC5rxsrlVZaNmxTA2BJ2ieobujJ3Wbrt2OaYyQTzYCnKBZzR7BWQ0h9fC5dhbTYTP5Rm8hj
	h9w2oPyw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wQWEM-004ueA-0A;
	Fri, 22 May 2026 20:12:27 +0000
Date: Fri, 22 May 2026 22:12:24 +0200
From: Ben Hutchings <benh@debian.org>
To: gregkh@linuxfoundation.org
Cc: imv4bel@gmail.com, aaron1esau@gmail.com, ben@decadent.org.uk,
	malin89@huawei.com, pabeni@redhat.com, rajat.gupta@oss.qualcomm.com,
	sd@queasysnail.net, sultan@kerneltoast.com, tanjingguo@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH 5.10] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <ahC4qNfoeifA-enJ@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WHlcoJyxPOzr5VkP"
Content-Disposition: inline
In-Reply-To: <2026052230-consonant-contented-9dae@gregkh>
X-Debian-User: benh
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	FREEMAIL_CC(0.00)[gmail.com,decadent.org.uk,huawei.com,redhat.com,oss.qualcomm.com,queasysnail.net,kerneltoast.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253846-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benh@debian.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,decadent.org.uk:mid,decadent.org.uk:email,kerneltoast.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Queue-Id: 046B95B9F10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--WHlcoJyxPOzr5VkP
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
[bwh: Backported to 5.10:
 - Set the SKBTX_SHARED_FRAG flag in skb_shared_info::tx_flags,
   instead of SKBFL_SHARED_FRAG in skb_shared_info::flags
 - skb_gro_receive() and skb_gro_receive_list() are in skbuff.c here
 - Drop change to tcp_clone_payload(), which does not exist here
 - Adjust context in skb_shift()
]
Signed-off-by: Ben Hutchings <benh@debian.org>
---
 net/core/skbuff.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c195107434b8..f7100f5af37c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1596,6 +1596,7 @@ struct sk_buff *__pskb_copy_fclone(struct sk_buff *sk=
b, int headroom,
 			skb_frag_ref(skb, i);
 		}
 		skb_shinfo(n)->nr_frags =3D i;
+		skb_shinfo(n)->tx_flags |=3D skb_shinfo(skb)->tx_flags & SKBTX_SHARED_FR=
AG;
 	}
=20
 	if (skb_has_frag_list(skb)) {
@@ -3502,6 +3503,8 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *sk=
b, int shiftlen)
 	tgt->ip_summed =3D CHECKSUM_PARTIAL;
 	skb->ip_summed =3D CHECKSUM_PARTIAL;
=20
+	skb_shinfo(tgt)->tx_flags |=3D skb_shinfo(skb)->tx_flags & SKBTX_SHARED_F=
RAG;
+
 	/* Yak, is it really working this way? Some helper please? */
 	skb->len -=3D shiftlen;
 	skb->data_len -=3D shiftlen;
@@ -3843,6 +3846,8 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk=
_buff *skb)
 	p->truesize +=3D skb->truesize;
 	p->len +=3D skb->len;
=20
+	skb_shinfo(p)->tx_flags |=3D skb_shinfo(skb)->tx_flags & SKBTX_SHARED_FRA=
G;
+
 	NAPI_GRO_CB(skb)->same_flow =3D 1;
=20
 	return 0;
@@ -4076,7 +4081,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		skb_copy_from_linear_data_offset(head_skb, offset,
 						 skb_put(nskb, hsize), hsize);
=20
-		skb_shinfo(nskb)->tx_flags |=3D skb_shinfo(head_skb)->tx_flags &
+		skb_shinfo(nskb)->tx_flags |=3D (skb_shinfo(head_skb)->tx_flags |
+					       skb_shinfo(frag_skb)->tx_flags) &
 					      SKBTX_SHARED_FRAG;
=20
 		if (skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
@@ -4093,6 +4099,9 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 				nfrags =3D skb_shinfo(list_skb)->nr_frags;
 				frag =3D skb_shinfo(list_skb)->frags;
 				frag_skb =3D list_skb;
+
+				skb_shinfo(nskb)->tx_flags |=3D skb_shinfo(frag_skb)->tx_flags & SKBTX=
_SHARED_FRAG;
+
 				if (!skb_headlen(list_skb)) {
 					BUG_ON(!nfrags);
 				} else {
@@ -4309,10 +4318,12 @@ int skb_gro_receive(struct sk_buff *p, struct sk_bu=
ff *skb)
 	p->data_len +=3D len;
 	p->truesize +=3D delta_truesize;
 	p->len +=3D len;
+	skb_shinfo(p)->tx_flags |=3D skbinfo->tx_flags & SKBTX_SHARED_FRAG;
 	if (lp !=3D p) {
 		lp->data_len +=3D len;
 		lp->truesize +=3D delta_truesize;
 		lp->len +=3D len;
+		skb_shinfo(lp)->tx_flags |=3D skbinfo->tx_flags & SKBTX_SHARED_FRAG;
 	}
 	NAPI_GRO_CB(skb)->same_flow =3D 1;
 	return 0;

--WHlcoJyxPOzr5VkP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoQuKgACgkQ57/I7JWG
EQl1/xAAgFuK/o+ammHT0lM7u850uh3hCJO9IcC09emcX3X0zQUPXC6ZsRGY584J
lDM9QH/aLXsOc/SWHgWYIB9f+2w3klzjQkIb5XAD52PwhfnX6/LRTAVyA4JtfzEM
A7nmbCLlHTKh/hNUnkgi44WBE/ZFWvQ5FxEDm0XCDxSlJt0BhHMGzOAvKqwMIcI0
pD6jzBg0VAZJcof5NFxLlBjzjIJ+urEC477cnqRNdTnprpEOSBfApZyoaPolT0ic
WhL0Z42/fSRd5DRFRgrOUr528ZgHgsIEHhY2FyIheSYc0mA3XL8ZmnkUdEVgX/me
nODImIpe/4It20QqikWT/HiectNkCqDxmLrOqTu/9FX8QbEFNNqbqiqStMPpq1IO
LHcAVWRkBHn3t/xdPmfZE2lHfwc08MJ4kF7n395RbLxTXttJapztqHvJ5x6CQkCp
g/KPrPlRZHa43lV4sv4QEDwFh+/LxySwQSkQBZJZUrc7UyndKMTsDQKqyWep4ATT
HFLEg44MGujUdujBJjOzeeWNMOGx5Y+Ux7acM5s1HOIxBPuBhsgy4Maqj9ULHXTc
gfNQXe1jEsg+pgybLoswtW40TZOJdizQ8sYhEMg20gVTxLLVq6b4uAKkZwy8d979
pZjvdO7ErzVy5hRLvxPZbQcVl1NZFRoPq4rokxs5mUcAuJ7747c=
=3WBL
-----END PGP SIGNATURE-----

--WHlcoJyxPOzr5VkP--

