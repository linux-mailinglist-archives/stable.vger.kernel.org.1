Return-Path: <stable+bounces-247392-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLIMMmW1BmqKnAIAu9opvQ
	(envelope-from <stable+bounces-247392-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:55:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C1F549CC1
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D42E3040A92
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF14315785;
	Fri, 15 May 2026 05:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKrHLgRd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402A9372066
	for <stable@vger.kernel.org>; Fri, 15 May 2026 05:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778824543; cv=none; b=HE4LOw9iswWU6gcsTGqv1Gz79RnVul6uPfHaf4uXa+bPVlCeU3lbMDTtz9+KQvldsh6tuMIDKNXHWL/rRdKWj86uGz6aK4SbtyE2wt/grjLDhOA1qdyGdN4SAd3za48akQPwJrO8Rxorwcc9sLIpMZ9dc+jC3984fOUM2CbwDkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778824543; c=relaxed/simple;
	bh=kiGBY43ZgTHH+8dj2AvY07Oa87W2raHsSDpHldiKLfw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ybgz+w2OawHkbw76c+4ftdxLlubnjZ/Yg3NXk5/Cd+Al7IqEoaBzum7UwZKLXmUtvfsEGj4P7b6jiLyEXSSfR/t+d2gi1cd/5A04sjqTN84wqrs5PXfae2stOO8XOl4WNXhHFjznD3Et5thztopjLSBVwfaaMSZsWUVcoOtmIyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKrHLgRd; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-366070f71adso8074668a91.2
        for <stable@vger.kernel.org>; Thu, 14 May 2026 22:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778824541; x=1779429341; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R7u2xRDtI3zLL+092m8rkgcne2y/yfPHTwkHpvlenKo=;
        b=SKrHLgRdhfLab8XJjKPnyL2I6XFda40ZXXm7A/qmLs34unSLqB6j3M2HzbpJxmUF5R
         xf40MlkZJOPZJQ20RBGfRidi8KhOpyx+Nuo8mZ9dujCXV7dTKgI6X3fzrBS7pgICve/x
         ckk+SneDbb7jxK3GqbKPcAqNrChhL/8wlbBdn0KKjk+zjfeq9OtqexELmQHzUYQbjMjd
         9sWKu8EKpo3ruWnacHAeqTz3YJXbG6zd6ksCQNF10tX9W85bTOQoz/taFzMYUmeOkqxa
         evG24h7mKNGnEMHzpoJSQQNs4iLB0P6uASQWB2q+iuPTBwbE0yRFUeJFiup9QVGxBcwI
         cv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778824541; x=1779429341;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R7u2xRDtI3zLL+092m8rkgcne2y/yfPHTwkHpvlenKo=;
        b=IkK9c18Ip0mt1i24JRFT8OvLHPk0SIVHF46hDUuliIwcohdvZ10Uzcr67dC02kvpvd
         9kVR2v56uyh/yqQhLcrASm5QjXMdR2TvmlqrF8KkevRYthF75MkV3avWZxw1HM76AZwN
         RGV2n6S6yrECTDqHz4nzkoqqkrYhx0u3f1TuV4/0wLzJ3zS93Rj+l6PNsL2ynsvTvowb
         DrcKbP5B0OkilYcmpYRG8/3hAgbFy1DmRaOyXtQP3TnWJ48sA4db/VQuwoqTqG7fZWjn
         003MLJynm1iEfMCitaE98vW6rFWxM4rQhG1kztbmp55nK2K5AuI0sYagCfw6N9EAlqNH
         osOw==
X-Forwarded-Encrypted: i=1; AFNElJ8FYQgUi6D7I6koSo+JntnrOBEc8BDEQVHZ4FxEMx6urU7ORFLsNxxi4ykO8n5y5oICtD/Lhak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3c7wMkLTTcu7JLFTGg39SAFBPFmQQ7vqP6GWmE4ygmYsSSYrZ
	4ElpBhWQ9b/1lCsmZ9J2Th9U3rDipKhVMW8ZqcQ2MDcYT5NkV6dbRbk6WLYHOd+5
X-Gm-Gg: Acq92OGsIO97X0sjIuqI6rNiEhmTSnvuTGJTwQK3d+7fB35DetSiJk6FShiiMm7rA4L
	qsfxPfsWjO7ECMh1uGbk7gAOD8Xwr3aMpeUhtmBg9UtTfUnpQdNW1q/Hw0iyT4DmkC73GcwgjMG
	t2wSv8Jvz/wudS+34ml7rvIb96MaQSSc8j7sQ4toHW5lrj93ydeUrLarl6Ts0TGU+rtMpCcr2m2
	KtC8S7kjq0wTHhgScTe8n5irbB8/my0Qze6cmiPK8zO48VX0mq+CW+5W1Obry/7faHbYw6t7q/z
	8c4+AvkkBj0GZxbum3Tt+LK1QJbKtuOQvfD8B6l3kuua8M1eARhBeXX97uSilmIcF1K1G+GCdr4
	XTkhjo9avrDP4c/RuOv+9OTMW/8oqt7/HXv0Zdm4owylOlqokibs0CiTjl8ePfOeB4PVVfuNOe3
	Q1WRDchlF7isszxi1QbdxmOy5OZTs2x9fBoY/Y4wU9WVKxRBxhE4VlJw==
X-Received: by 2002:a17:90b:4d0e:b0:367:cb53:7435 with SMTP id 98e67ed59e1d1-36951caf2b3mr2499377a91.24.1778824541434;
        Thu, 14 May 2026 22:55:41 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695155b2c4sm1503887a91.3.2026.05.14.22.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 22:55:40 -0700 (PDT)
Date: Fri, 15 May 2026 14:55:35 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kerneljasonxing@gmail.com,
	kuniyu@google.com, mhal@rbox.co, jiayuan.chen@linux.dev,
	steffen.klassert@secunet.com, ben@decadent.org.uk,
	herbert@gondor.apana.org.au, dsahern@kernel.org,
	sultan@kerneltoast.com, sd@queasysnail.net
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net v4] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <aga1VyHpHaUhnGZa@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 73C1F549CC1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247392-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,rbox.co,linux.dev,secunet.com,decadent.org.uk,gondor.apana.org.au,kerneltoast.com,queasysnail.net];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kerneltoast.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:email]
X-Rspamd-Action: no action

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
allocated head storage and emerge with nr_frags == 0, so
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

Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Suggested-by: Sultan Alsawaf <sultan@kerneltoast.com>
Suggested-by: Ben Hutchings <ben@decadent.org.uk>
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v4:
- Include the tcp_clone_payload() propagation suggested by Sabrina.
- Drop the skb_try_coalesce() change; addressed by commit f84eca581739.
- v3: https://lore.kernel.org/all/agW4vC0r8QOUKtRT@v4bel/

Changes in v3:
- Include the skb_gro_receive() audit patch suggested by Sultan
- v2: https://lore.kernel.org/all/agToIEDI4TaTNLRb@v4bel/

Changes in v2:
- Also propagate SHARED_FRAG in skb_try_coalesce() and skb_shift()
- v1: https://lore.kernel.org/all/agRfuVOeMI5pbHhY@v4bel/
---
 net/core/gro.c        | 4 ++++
 net/core/skbuff.c     | 3 +++
 net/ipv4/tcp_output.c | 1 +
 3 files changed, 8 insertions(+)

diff --git a/net/core/gro.c b/net/core/gro.c
index 31d21de5b15a..9f8960789b2c 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -213,10 +213,12 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	p->data_len += len;
 	p->truesize += delta_truesize;
 	p->len += len;
+	skb_shinfo(p)->flags |= skbinfo->flags & SKBFL_SHARED_FRAG;
 	if (lp != p) {
 		lp->data_len += len;
 		lp->truesize += delta_truesize;
 		lp->len += len;
+		skb_shinfo(lp)->flags |= skbinfo->flags & SKBFL_SHARED_FRAG;
 	}
 	NAPI_GRO_CB(skb)->same_flow = 1;
 	return 0;
@@ -244,6 +246,8 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 	p->truesize += skb->truesize;
 	p->len += skb->len;
 
+	skb_shinfo(p)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
+
 	NAPI_GRO_CB(skb)->same_flow = 1;
 
 	return 0;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 9c4e8d331d6d..7cd388504297 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2248,6 +2248,7 @@ struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb, int headroom,
 			skb_frag_ref(skb, i);
 		}
 		skb_shinfo(n)->nr_frags = i;
+		skb_shinfo(n)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
 	}
 
 	if (skb_has_frag_list(skb)) {
@@ -4349,6 +4350,8 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 	tgt->ip_summed = CHECKSUM_PARTIAL;
 	skb->ip_summed = CHECKSUM_PARTIAL;
 
+	skb_shinfo(tgt)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
+
 	skb_len_add(skb, -shiftlen);
 	skb_len_add(tgt, shiftlen);
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f9d8755705f7..6e4bb411dc04 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2626,6 +2626,7 @@ static int tcp_clone_payload(struct sock *sk, struct sk_buff *to,
 			todo = min_t(int, skb_frag_size(fragfrom),
 				     probe_size - len);
 			len += todo;
+			skb_shinfo(to)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
 			if (lastfrag &&
 			    skb_frag_page(fragfrom) == skb_frag_page(lastfrag) &&
 			    skb_frag_off(fragfrom) == skb_frag_off(lastfrag) +
-- 
2.43.0


