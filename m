Return-Path: <stable+bounces-253841-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PrJDnS0EGoUcwYAu9opvQ
	(envelope-from <stable+bounces-253841-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 21:54:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 862EE5B9B5C
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 21:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DAAD3007F61
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 19:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4C237BE62;
	Fri, 22 May 2026 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="eLyZlubn"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8AF37D123
	for <stable@vger.kernel.org>; Fri, 22 May 2026 19:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779479189; cv=none; b=HVvirxg+mv5N3rY63onwtulqBcfNFOrWVkJ4bcF1V7gMnpdyrYjGuxPJTIGNnf7nzqn+bvHS8viQ2SBut3zFqIyRrmTkiQyURtqFX8lmXCA+RSEL7VMBiWEFtYtqkASgpY/gKAHVpGslM4tNwa4Nzxh6b4HkNcCQLxPoHsqm9hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779479189; c=relaxed/simple;
	bh=htFZLhL7I6dFV1rc+Ese4K7tBrtgrFEYBa72mL6qFw8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Nr/mhy5J464vy/q8zbXrlBw33LqS5W+U+TrPi5K0MaJsVsFYdP4ZNsiuJ+FVk6fXTsT0F9umOrrVr6ddU65PwHUi1AF/P7+XNUaW8TpIJBtZeO6Xp7yINZ/IBnmLppLjo6/CkPpEtDfKZMZHlbVEcEz54mtSU8RxsK2sCbV9kto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=eLyZlubn; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:References;
	bh=/wASEH4XR11VGlWEYf85t2UsWJAd/XcpMDsIkVwgRBA=; b=eLyZlubnoxuIxgbqpnjE6BFGKU
	7aBi4Be8kwAYXMZ2FLfNwVpDOhYhKeSKPUf4uTpIno/tVXmB+GR09aEWMVY+G+QfQolhr8apu+op/
	7W+HFrHvGSO8ATcv74XYwbjfKuNTDFwfroNQH4RpUkDIjbTdFeqNhfxpuGQ5fyB/ssOTGXC4wh7YR
	aea51WA4PAWrPPFMBCqadUmxCr1tdxShlUYdjspOF13gUdYRX+Harvk8t5hhRy/qGex+Q9mRH/KsO
	aNnV+NZH8OTTvAOG4anBVjCaa2Mg/cFRIGyNUZS1z2jb4VqJnxiQ2NZYdNI88piv9Q22vwTzik3Hf
	rKvFENUw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wQVov-004to6-0m;
	Fri, 22 May 2026 19:46:10 +0000
Date: Fri, 22 May 2026 21:46:07 +0200
From: Ben Hutchings <benh@debian.org>
To: gregkh@linuxfoundation.org
Cc: imv4bel@gmail.com, aaron1esau@gmail.com, ben@decadent.org.uk,
	malin89@huawei.com, pabeni@redhat.com, rajat.gupta@oss.qualcomm.com,
	sd@queasysnail.net, sultan@kerneltoast.com, tanjingguo@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH 5.15] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <ahCyf28nWFO49oDZ@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iVwi7WFUgcrvEKmC"
Content-Disposition: inline
In-Reply-To: <2026052230-kilogram-proving-cd58@gregkh>
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
	TAGGED_FROM(0.00)[bounces-253841-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,kerneltoast.com:email,decadent.org.uk:mid,decadent.org.uk:email]
X-Rspamd-Queue-Id: 862EE5B9B5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--iVwi7WFUgcrvEKmC
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
[bwh: Backported to 5.15:
 - skb_gro_receive() and skb_gro_receive_list() are in skbuff.c here
 - Drop change to tcp_clone_payload(), which does not exist here
 - Adjust context in skb_shift()
]
Signed-off-by: Ben Hutchings <benh@debian.org>
---
 net/core/skbuff.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index aadb87aa5e7e..a8d09eff26f1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1661,6 +1661,7 @@ struct sk_buff *__pskb_copy_fclone(struct sk_buff *sk=
b, int headroom,
 			skb_frag_ref(skb, i);
 		}
 		skb_shinfo(n)->nr_frags =3D i;
+		skb_shinfo(n)->flags |=3D skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
 	}
=20
 	if (skb_has_frag_list(skb)) {
@@ -3650,6 +3651,8 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *sk=
b, int shiftlen)
 	tgt->ip_summed =3D CHECKSUM_PARTIAL;
 	skb->ip_summed =3D CHECKSUM_PARTIAL;
=20
+	skb_shinfo(tgt)->flags |=3D skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
+
 	/* Yak, is it really working this way? Some helper please? */
 	skb->len -=3D shiftlen;
 	skb->data_len -=3D shiftlen;
@@ -4017,6 +4020,8 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk=
_buff *skb)
 	p->truesize +=3D skb->truesize;
 	p->len +=3D skb->len;
=20
+	skb_shinfo(p)->flags |=3D skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
+
 	NAPI_GRO_CB(skb)->same_flow =3D 1;
=20
 	return 0;
@@ -4251,7 +4256,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		skb_copy_from_linear_data_offset(head_skb, offset,
 						 skb_put(nskb, hsize), hsize);
=20
-		skb_shinfo(nskb)->flags |=3D skb_shinfo(head_skb)->flags &
+		skb_shinfo(nskb)->flags |=3D (skb_shinfo(head_skb)->flags |
+					    skb_shinfo(frag_skb)->flags) &
 					   SKBFL_SHARED_FRAG;
=20
 		if (skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
@@ -4268,6 +4274,9 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
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
@@ -4490,10 +4499,12 @@ int skb_gro_receive(struct sk_buff *p, struct sk_bu=
ff *skb)
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

--iVwi7WFUgcrvEKmC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoQsnsACgkQ57/I7JWG
EQmi6xAAgK6tGyTGriQZ3Vyud2x4S1D5aiKojhS4fvYaiVs4El8DlYhweLF3daVm
hWwR4S4cZUOm/PuEMCPDnoSUb44XtPn+jh3RyY/S49mS/omseT8BYTu9SiEFQpm5
BheEZzpc9cGwPH6T257+Ly50/uv5nJey9lPedvbdA0wINcUMHwA7bVIi98RNFV89
udG1yjzyaKUaZkGAlBsyseUjzYcC/suHvrGPlwARPoCFtr7/95pKlMvaJcNPqtXr
j1S802zoP2Y1r3VW35628ieQHOWGooD6brgoYvvFMOOlFVmeyxUF+glQfHrUTR2E
ukrM+GxNcxJFlJ2qWWv9cb7NjRSZwTp5VNu8HlSQpLfWxAWXo9URQnijKcj3LCiq
cZGUzxBEx8lxPUwXM+1OJRlDBRJsAcSGvGv7kXjfeRQ9HdhQtpAvopDaUjoJjgTT
DOjDMRqWWdEngGZG+mp9dce2Tu7SlgewpcV47iujxlrAOZtRycgyNZL1botEN3y5
IvERjoskVKkrTfRxFO/p8in/XxeF9QlAoYRv0qd63f3zSNP6q9Z7/8Cl49aJDlwB
24LJc5t1fUMN0/Ua/sgZZ+W1+n5tx0RSI4+p9HQdyb37DdEMXgLUEisB83kx6pPm
tcWrg4++Iz635ERRjkBE7Ho+R6i0zKPrVVE+fi4aAZvEtwxTt8U=
=G3m5
-----END PGP SIGNATURE-----

--iVwi7WFUgcrvEKmC--

