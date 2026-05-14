Return-Path: <stable+bounces-247178-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNuEKt64BWpZaAIAu9opvQ
	(envelope-from <stable+bounces-247178-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 13:58:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 245D35414AA
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 13:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 747233027D80
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 11:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CF13C1F50;
	Thu, 14 May 2026 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DARS9AGx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B6E1E515
	for <stable@vger.kernel.org>; Thu, 14 May 2026 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778759876; cv=none; b=Uthm1Yi4dkjzuOrYDu0/idA2Iqcddc6pLVo3Do87DcWMocV80PaPMR8TrZOvZCR9zEp0iJK5UfJJLw04/gmHOQDU8DIAMxoNGJL64JZSgSf13nBW9tMwBfK/lkLpdHz0afhnCcTr5YHc1RYwWvwDuB2pDxINU4kFbA7VLCteE6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778759876; c=relaxed/simple;
	bh=TlK/N3LWoErUOYKgkPO12sDSKmIAzUJCS0yzfed8TCA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FK213MXD8BRH1uUEHXUt1zUjbeJYCghVgcvpCK2TPoPuqBySeHYkDWclYmaa3nXzI8WjX/gz/JF3iAT9CAJeOB+I7W8200D3qazmkkUuZVFmi7IuDjIs8B2hTleqpROaUxRx4BD0zdjs1cKqBbGOrpmfBWXKWjfUZCtYAvgM7Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DARS9AGx; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba6485d219so51484425ad.3
        for <stable@vger.kernel.org>; Thu, 14 May 2026 04:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778759874; x=1779364674; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9VdHfq+GU6K+dFfvRRHW29aQlKC/F7Pn8KdTUs23EV0=;
        b=DARS9AGxfnrcTD6OmGk5LEI3yEOcnb+R65IZbwrKD+rKU6Jcg/4+dWvwff4uQ88QHm
         X9yaNGJjS2zD54PRoi3QHGAdkL5+XkdLV47gujrmPo56pUz4j0YYKuwDFcwSda6+89Xh
         ABlephzwWSonkTuLo0una22OCZT5n8EOU9t6nY6IaY899B+TOwUBuNFjg3XnbJYKQ0aY
         72dECB00yfG/co3GOn/E1tUDlpDFI4ifgXDAaNoN82EYsguU5krVZmkXjfMCXJIQLYIP
         MLiEIxUf8cwCWHcVUsHWeGzZPMhwEjS/noTQbel0d/tNi/kDgfJoAd/UfJLGE7MuodMZ
         9Beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778759874; x=1779364674;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VdHfq+GU6K+dFfvRRHW29aQlKC/F7Pn8KdTUs23EV0=;
        b=WVxX7j3BTclrwS4t+1AtZWrgQKxSWWy34KgyqeMNcN6AhHhMoHCWhDiYqOhsM/ZUl5
         raobxOtDp7w9wq7IxRRESjJ47wFMW+QeIhKEk7EPd/QtAztN/mh+ha7HYGRCdT4wWUSJ
         7ME4ISasrlA2fYJuBs76iUgFfo5fyO1udBOW3YrCzaY54I20qA/vND0o29EvVDhAySuv
         C1bwmwUa/6AXAvbOX1qWu0UgGtLGRpfVC2sSS8bQT95Yd3JHmdbjA9ZYFn70Ddntmz3J
         WZkDTmNVT7C3leWMi7xo5AXdslMQhHoh+EM0+XNEcOnzqm60M9SQJiEVzFraKExzlGuc
         7lYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+gyqjzji5BF0fyoyNCQO/2miv1WPbYjJv2I+7gcuIVO7zueLEZCc/Oc/vgaNU+YO1tmNhwfPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg6AcLuljgHxo2tMe5QJjKfdwhYxUYMtPjBYcrgyz7kPq5qZCB
	1ItbUlIUQhOExMe+hXiaFiyyAVLT3yt5nBIrbmWLwKkH2KC6ck4UliUp
X-Gm-Gg: Acq92OGAscTisOzxYscmcfW0+nUUsuLYDhNy9guNmRtFOYRNkiJLlzhDbsqQa1MY47t
	ZooxKtyW3s6/AhS/Yeph72SVbgOspGrl8o2C6u7AeXU82RMTUNpHRKVgjQMj3G2vUFPZKuGsi7s
	7ELcxL5/SN6P3Yj8Gsy8GG5Oq+vC2r13vSMpu8yxjWHYj4P9dgenekmT22NjBK/K3Lw8+b+otJd
	tgOy0B9mRjywt7A1Mh81ivDGG+WFLmygTVqt/UVG2yzzqmBF3R0K71Tew+2EBbGnhrPBOV7Fdg5
	jj2lFDsm/DvjuG/Z9a/NdVrwvEz2L47GrebWt8kHcye0+V9Fw7UDIQBJP/ICqZuY2zejSEHrW1A
	l24LTxqgppomXPbVvkffhHHPHtieoxUHiL4NgtSBYVs1iEV9OwX0n04EnaWjKhnWOgE3fOsFZgq
	XJLlo/pbXZTnmh3JGszeqokQF0gKb3RyOjjdgXwWDJWIA=
X-Received: by 2002:a17:903:4b24:b0:2b0:6e6a:8504 with SMTP id d9443c01a7336-2bd2ff232f6mr73288155ad.27.1778759873625;
        Thu, 14 May 2026 04:57:53 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe6487sm23953245ad.54.2026.05.14.04.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 04:57:53 -0700 (PDT)
Date: Thu, 14 May 2026 20:57:48 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kerneljasonxing@gmail.com,
	kuniyu@google.com, mhal@rbox.co, jiayuan.chen@linux.dev,
	steffen.klassert@secunet.com, vakzz@zellic.io, ben@decadent.org.uk,
	herbert@gondor.apana.org.au, dsahern@kernel.org,
	sultan@kerneltoast.com, sd@queasysnail.net
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net v3] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <agW4vC0r8QOUKtRT@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 245D35414AA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247178-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,rbox.co,linux.dev,secunet.com,zellic.io,decadent.org.uk,gondor.apana.org.au,kerneltoast.com,queasysnail.net];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,zellic.io:email]
X-Rspamd-Action: no action

Three frag-transfer helpers (__pskb_copy_fclone(), skb_try_coalesce(),
and skb_shift()) fail to propagate the SKBFL_SHARED_FRAG bit in
skb_shinfo()->flags when moving frags from source to destination.
__pskb_copy_fclone() defers the rest of the shinfo metadata to
skb_copy_header() after copying frag descriptors, but that helper
only carries over gso_{size,segs,type} and never touches
skb_shinfo()->flags; skb_try_coalesce() and skb_shift() move frag
descriptors directly and leave flags untouched.  As a result, the
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

Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
Reported-by: William Bowling <vakzz@zellic.io>
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v3:
- Include the skb_gro_receive() audit patch suggested by Sultan
- v2: https://lore.kernel.org/all/agToIEDI4TaTNLRb@v4bel/
Changes in v2:
- Also propagate SHARED_FRAG in skb_try_coalesce() and skb_shift()
- v1: https://lore.kernel.org/all/agRfuVOeMI5pbHhY@v4bel/
---
 net/core/gro.c    | 4 ++++
 net/core/skbuff.c | 5 +++++
 2 files changed, 9 insertions(+)

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
index 7dad68e3b518..7cd388504297 100644
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
 
@@ -6200,6 +6203,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	       from_shinfo->frags,
 	       from_shinfo->nr_frags * sizeof(skb_frag_t));
 	to_shinfo->nr_frags += from_shinfo->nr_frags;
+	if (from_shinfo->nr_frags)
+		to_shinfo->flags |= from_shinfo->flags & SKBFL_SHARED_FRAG;
 
 	if (!skb_cloned(from))
 		from_shinfo->nr_frags = 0;
-- 
2.43.0


