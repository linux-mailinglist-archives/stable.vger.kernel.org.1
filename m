Return-Path: <stable+bounces-253910-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAaACElmEWoelgYAu9opvQ
	(envelope-from <stable+bounces-253910-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 10:33:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8BA5BDEE3
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 10:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 919AD3018425
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 08:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9414A3491C4;
	Sat, 23 May 2026 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="mQxWEdKb"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61951314A98
	for <stable@vger.kernel.org>; Sat, 23 May 2026 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525153; cv=none; b=QKMBnBX+Db2kJrEc67v6461EzUvHXYp8vr+E0HUUNi/fj6sg6ZQCdNtdejYy8a1ofKMw8yVIXGUkPfto59AhNGVTCY/G7QjzCpQ+A07fr9ByWRAkqdaw+E5YRb0D5NjYzXu+L/vI6mkGYTvQA0c90v7Bh0UrXJGDpfX8amumR+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525153; c=relaxed/simple;
	bh=VUU0ju3A3Hnv5bE2o22tMR2sSZHuDiJzoXWCyDngj5w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IFgqJevtE7pf+7FuZFXT/kpXvnuCtD/qN38njf4gqK/ydlslyBgUXiq+WCNrg/S0zUO2uLevIoT9w6sxGB/d5bIB6zz+Us/DHmjIqQ02Wx9A+5PfHPEVPlmSEO84B+P6lrz2chZL1rkfF3QpAiiULmBVR1EZOZL1fMro6zraNSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=mQxWEdKb; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:References;
	bh=1prso1fiTXJVkvd32BOn2l+10wwdpl6ge+nAIthDE1E=; b=mQxWEdKbfpqL+LuDL9ch9Az2KR
	aEqrIA7YnNkDf9+lTy+o4AzODEjYcTbGjUzOQ9vawiz0URyrHqq1Rdxqlx+v8GEUWlKODBjCFwxKQ
	NalhTUYCOQMSTf2XlPxIl3swQeenYG2RtS9bkBNlqhf5jmltxquSCwZ8QOz8nt7qix4kDUfPeOVue
	yMlRSroccJwh5saLfslmkALFagPzLScCAopkRYrQtIBkJxgecwoxIbhRN+PvSMBhXWKjXsAo7ibmw
	1Pqd4YAlQIGmMyVFSCBTOY+wc6yUwT2ak+StXAP3YTIzMVfVXwL++O0kwkvOz3f3J1NLKBs86PTHQ
	KgVmwkxQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wQhmV-005JK2-1g;
	Sat, 23 May 2026 08:32:28 +0000
Date: Sat, 23 May 2026 10:32:23 +0200
From: Ben Hutchings <benh@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>, Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <ahFmF_XkUzOHBMnC@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ewwF1QnzEhsTbLw2"
Content-Disposition: inline
In-Reply-To: <2026052357-viper-tipped-4ea9@gregkh>
X-Debian-User: benh
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253910-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benh@debian.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:email,kerneltoast.com:email,queasysnail.net:email]
X-Rspamd-Queue-Id: 8A8BA5BDEE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--ewwF1QnzEhsTbLw2
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
[bwh: Backported to 6.6: skb_gro_receive_list() is in
 net/ipv4/udp_offload.c here]
Signed-off-by: Ben Hutchings <benh@debian.org>
---
 net/core/gro.c         | 2 ++
 net/core/skbuff.c      | 9 ++++++++-
 net/ipv4/tcp_output.c  | 1 +
 net/ipv4/udp_offload.c | 2 ++
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/core/gro.c b/net/core/gro.c
index 92cb86d4ce50..0a9d4a3bb104 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -216,10 +216,12 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff=
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
index 88e0bf8004bf..8b05866e93b1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2050,6 +2050,7 @@ struct sk_buff *__pskb_copy_fclone(struct sk_buff *sk=
b, int headroom,
 			skb_frag_ref(skb, i);
 		}
 		skb_shinfo(n)->nr_frags =3D i;
+		skb_shinfo(n)->flags |=3D skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
 	}
=20
 	if (skb_has_frag_list(skb)) {
@@ -4086,6 +4087,8 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *sk=
b, int shiftlen)
 	tgt->ip_summed =3D CHECKSUM_PARTIAL;
 	skb->ip_summed =3D CHECKSUM_PARTIAL;
=20
+	skb_shinfo(tgt)->flags |=3D skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
+
 	skb_len_add(skb, -shiftlen);
 	skb_len_add(tgt, shiftlen);
=20
@@ -4658,7 +4661,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		skb_copy_from_linear_data_offset(head_skb, offset,
 						 skb_put(nskb, hsize), hsize);
=20
-		skb_shinfo(nskb)->flags |=3D skb_shinfo(head_skb)->flags &
+		skb_shinfo(nskb)->flags |=3D (skb_shinfo(head_skb)->flags |
+					    skb_shinfo(frag_skb)->flags) &
 					   SKBFL_SHARED_FRAG;
=20
 		if (skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
@@ -4675,6 +4679,9 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
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
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index db8f2830c67b..19e11b944db3 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2364,6 +2364,7 @@ static int tcp_clone_payload(struct sock *sk, struct =
sk_buff *to,
 			todo =3D min_t(int, skb_frag_size(fragfrom),
 				     probe_size - len);
 			len +=3D todo;
+			skb_shinfo(to)->flags |=3D skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
 			if (lastfrag &&
 			    skb_frag_page(fragfrom) =3D=3D skb_frag_page(lastfrag) &&
 			    skb_frag_off(fragfrom) =3D=3D skb_frag_off(lastfrag) +
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index cd860d8d497b..84ae2759ff19 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -547,6 +547,8 @@ static int skb_gro_receive_list(struct sk_buff *p, stru=
ct sk_buff *skb)
 	p->truesize +=3D skb->truesize;
 	p->len +=3D skb->len;
=20
+	skb_shinfo(p)->flags |=3D skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
+
 	NAPI_GRO_CB(skb)->same_flow =3D 1;
=20
 	return 0;

--ewwF1QnzEhsTbLw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoRZhMACgkQ57/I7JWG
EQlnjxAAqa4Ir1AmXn7GiHjlDdcuVjIakQuP93JEZJgh89vr8+7mI0o0xr5dvYPz
ptn7BPtBbynakXBF7BUjolNQ2FgqCeCqKhoSkufVST+vxdNCLKxM2t9Hy7XZDIqW
rUgxByADv5gii4A7HsDSBmbrIBVcr5mY9ZWC1qTrJOvGo/18x1Y8+rGvJZZQspCX
ffesHm2CqXsVxp4l66JK645HTPGoaRH5WVNtW2a7fj4rX2YnUIN8OUzTNh74jz9g
+3GaxWU1Z25aFjoBgrw1HAbUR3Ys0wtbFRaQN6uschMKQj8tLgDEp/tynULumadm
u5KW2oCovlv6NKW3kcvMqwyoc8+046D/9t1tdZ1AggawYTfvxYA/sRVVJ37Hi2ko
49+ei+22nK/KcTcmXc8SWp5GqS1L4hA5u2Rj2vS9um6ghe+gDWFtUYYKtKv/cmMM
N96DPXvYVi5jL0geA55OmWYtKpK23NIyxMNy5qg3QxQoFdqsXDGGu2S1DIrM2KFg
SjaQz6tvpMiwm5czbY95tvvoihEGEeIOmxTzbmYBN2Pjl3Dpcjmho1I4u3zkmPxX
iWfBuN6ya0T53c63hS+rpQlLQUUpfw3g/sG9mKPLYziqhjdDCVdsJp2sfXcUeSOS
K0fkwuHg7DnewnxViBz4/uCQvzKeJE99nOijJQ/ncNgwCgQ549U=
=MGgD
-----END PGP SIGNATURE-----

--ewwF1QnzEhsTbLw2--

