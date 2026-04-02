Return-Path: <stable+bounces-232987-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEUaFM9XzmnrmwYAu9opvQ
	(envelope-from <stable+bounces-232987-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 13:49:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B07B3888F6
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 13:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B79E306A1FF
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 11:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5292A3CD8C9;
	Thu,  2 Apr 2026 11:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SD780Z5+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15B73CB2DC
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775130261; cv=none; b=dKr3+d6oKFdP6ruQmrWY0Hyr+LOhtDNh36FHZulxxyG8KPUeOTu03xzlMiZJpY2vDOJ8EkKMxows1j2gfqDdxv8wwFn2aDDlkHvfA6KEVeit8pZ02qlhFI5wHFYF8dFZxCPuutjR4NZXr7Ppm77+NqhGt8AdJkJYCt7y6Mj1oFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775130261; c=relaxed/simple;
	bh=zfBn1cRNNhumvyiV8rBtCw2nXZZgpuvd0gyg+7iLZWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p1bzTgoBjm0Q3mt9G43eu9DTK1m4gB2mF2lPAqbZfP+SrODCvTYsfKmBbutPKtEMm+qQejs46bA6xtbrT7ggrUVbaxOJSTjnHZ1mtRm8NecaPK0yfK+p3seTN2EoUL2hznqvmQfYvWuY6E+vsnjRebSw2v0uZjM3UDiiuF2eoVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SD780Z5+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aae4816912so4551395ad.2
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 04:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775130252; x=1775735052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lXUpdPPA2BsBrA+T+Hk9V88yl+Ek0GfjSeEmssGlqH0=;
        b=SD780Z5+VehTzpXrlK2yBjsiHNxR8BZcoeI1p+twD6eJBQJ08ST3owE5Ynjwc8ujcL
         o9Sg7RJQ4Yhk4uN0GWR/cKDmGuzfteeh/Zwx5doUWjFP916/it7a6YtganRtODANHLqz
         Nd3P/KasdgkAEXIQhuZ8YW8bqNvmGbXHrQKRA+4/Eztc7wMLSHYrSwpruG3gRYMQOviT
         3eSDAT2uQhpGQhrhyAiAHodZWLpawWzMhPHizt8kfS2KH/+r1RqefWaxGHigdE1VUEIN
         ANq7OgR+2yrI1AbmtMq9zcAO1icHpFsz3tUNNT9xsqVlB+i4cXJDBIPH2wLUrGpoRxsx
         rwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775130252; x=1775735052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXUpdPPA2BsBrA+T+Hk9V88yl+Ek0GfjSeEmssGlqH0=;
        b=PDId81qXoku9clxRwhZ0Pwo+Rx8C73It938Oabo2aXB5TpzYYD9AQNTs44lkoIW/vO
         ebydA0SW/IveIXagIHmraVIU/Z+ovgd8P+0dTFGUmByeMg4moAD3satylRmGU6N/2EwJ
         LI5EncKykZYiKT80GrWSgyba+RgVChJ4ul0i0bHHqo7Jng0FNyscprrVrFfqRhL4v9/+
         pXz4V08qVckIwDw4vQgCfss7TrMUOvz9v4ZTeRQahkR3CTwjNUSj0wi6+gV/Oh8M1RQf
         p840BEuAJH4GKtS2D7IaLG2G051TkxXR/S0f4js1cBfH7P1Pc3xL/tYdkuMecqs4Xw6r
         e/qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRRqdNidLfB1NMob5KTEjnx1+iAJ5Ntwc/GS4AtgsnTqj1EGsOb/VTC0UflH0Tr9zzxBg92lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGXb5p65CBmuj7LhF3b4Wqw7X+jbWzdnbTNLvmEY4gNyCjmBVB
	8DdFcATVTi3GEtMTrOV0GzH6ab+VWpGDRGPw5EqmORG70mTj2uuQe/L6
X-Gm-Gg: AeBDietQQPVsp1VSPyr4t340tAbT6mzaJLJQ5t06LAHMsj1EShjChvKMvOr7sSl4+fy
	GKh2LK5EBuRqjDUuZSmn/B5qQ5MwBvfhTDV05MssOBWXpbCsvqJWBoz64ZeMJ7VeLidQN6ESsi0
	WaBh4EpgLlmFlOrMlWI8751IoIewBUQnDtPcZNXpR8/6BfH4aRqR4toyQT0HZmTigCAzPrDl/2r
	6x69jNwfYNpl3VJVpRlxRDV3hw9ef68Ctaj7Iy1XtKq4xvuTGPKiHfhx5/g1XfZWnydX0urhOA9
	QNipfXwN2358nXOvYKdlr3EhQi2o5lA83CF8a/Omq+25gfle+o9btPDKWHcnGm+yGkL88YdvTGb
	zZGyELUtKOwkAT/9uswQpQXg2vIPq1VgtXvW5qdSzIfnomkFqOAhoIlhpWqpBxKTES4a5r40wCS
	8TckwmmeUbnsD5ldO7DvWyVnvOb/CLmJN087c=
X-Received: by 2002:a17:902:ef4e:b0:2b2:5840:80d3 with SMTP id d9443c01a7336-2b269c6e2e8mr68361245ad.33.1775130252451;
        Thu, 02 Apr 2026 04:44:12 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b274979525sm32553295ad.45.2026.04.02.04.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 04:44:12 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Florian Westphal <fw@strlen.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] xfrm: hold dev ref until after transport_finish NF_HOOK
Date: Thu,  2 Apr 2026 19:44:01 +0800
Message-ID: <20260402114401.62212-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[strlen.de,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-232987-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email]
X-Rspamd-Queue-Id: 8B07B3888F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After async crypto completes, xfrm_input_resume() calls dev_put()
immediately on re-entry before the skb reaches transport_finish.
The skb->dev pointer is then used inside NF_HOOK and its okfn,
which can race with device teardown.

Remove the dev_put from the async resumption entry and instead
drop the reference after the NF_HOOK call in transport_finish,
using a saved device pointer since NF_HOOK may consume the skb.
This covers NF_DROP, NF_QUEUE and NF_STOLEN paths that skip
the okfn.

For non-transport exits (decaps, gro, drop) and secondary
async return points, release the reference inline when
async is set.

Suggested-by: Florian Westphal <fw@strlen.de>
Fixes: acf568ee859f ("xfrm: Reinject transport-mode packets through tasklet")
Cc: stable@vger.kernel.org
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
Changes in v3:
  - Drop refcount after NF_HOOK instead of in async okfn variant
    (Florian, Steffen)
  - Remove xfrm_trans_cb.dev_held, async okfn variants, and
    xfrm_trans_queue_net parameter change from v2

Changes in v2:
  - Reuse existing dev_hold, delay dev_put instead of adding
    extra hold/put pair (Steffen)

Link: https://lore.kernel.org/netdev/20260331092737.1937-1-tpluszz77@gmail.com/ (v2)
Link: https://lore.kernel.org/all/20260320073023.21873-1-tpluszz77@gmail.com/ (v1)
---
 net/ipv4/xfrm4_input.c |  5 ++++-
 net/ipv6/xfrm6_input.c |  5 ++++-
 net/xfrm/xfrm_input.c  | 18 ++++++++++++++----
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index f28cfd88eaf5..c2eac844bcdb 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -50,6 +50,7 @@ int xfrm4_transport_finish(struct sk_buff *skb, int async)
 {
 	struct xfrm_offload *xo = xfrm_offload(skb);
 	struct iphdr *iph = ip_hdr(skb);
+	struct net_device *dev = skb->dev;
 
 	iph->protocol = XFRM_MODE_SKB_CB(skb)->protocol;
 
@@ -73,8 +74,10 @@ int xfrm4_transport_finish(struct sk_buff *skb, int async)
 	}
 
 	NF_HOOK(NFPROTO_IPV4, NF_INET_PRE_ROUTING,
-		dev_net(skb->dev), NULL, skb, skb->dev, NULL,
+		dev_net(dev), NULL, skb, dev, NULL,
 		xfrm4_rcv_encap_finish);
+	if (async)
+		dev_put(dev);
 	return 0;
 }
 
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 9005fc156a20..699a001ac166 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -43,6 +43,7 @@ static int xfrm6_transport_finish2(struct net *net, struct sock *sk,
 int xfrm6_transport_finish(struct sk_buff *skb, int async)
 {
 	struct xfrm_offload *xo = xfrm_offload(skb);
+	struct net_device *dev = skb->dev;
 	int nhlen = -skb_network_offset(skb);
 
 	skb_network_header(skb)[IP6CB(skb)->nhoff] =
@@ -68,8 +69,10 @@ int xfrm6_transport_finish(struct sk_buff *skb, int async)
 	}
 
 	NF_HOOK(NFPROTO_IPV6, NF_INET_PRE_ROUTING,
-		dev_net(skb->dev), NULL, skb, skb->dev, NULL,
+		dev_net(dev), NULL, skb, dev, NULL,
 		xfrm6_transport_finish2);
+	if (async)
+		dev_put(dev);
 	return 0;
 }
 
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index dc1312ed5a09..f65291eba1f6 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -506,7 +506,6 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		/* An encap_type of -1 indicates async resumption. */
 		if (encap_type == -1) {
 			async = 1;
-			dev_put(skb->dev);
 			seq = XFRM_SKB_CB(skb)->seq.input.low;
 			spin_lock(&x->lock);
 			goto resume;
@@ -659,8 +658,11 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			dev_hold(skb->dev);
 
 			nexthdr = x->type->input(x, skb);
-			if (nexthdr == -EINPROGRESS)
+			if (nexthdr == -EINPROGRESS) {
+				if (async)
+					dev_put(skb->dev);
 				return 0;
+			}
 
 			dev_put(skb->dev);
 			spin_lock(&x->lock);
@@ -695,9 +697,11 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		XFRM_MODE_SKB_CB(skb)->protocol = nexthdr;
 
 		err = xfrm_inner_mode_input(x, skb);
-		if (err == -EINPROGRESS)
+		if (err == -EINPROGRESS) {
+			if (async)
+				dev_put(skb->dev);
 			return 0;
-		else if (err) {
+		} else if (err) {
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEMODEERROR);
 			goto drop;
 		}
@@ -734,6 +738,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			sp->olen = 0;
 		if (skb_valid_dst(skb))
 			skb_dst_drop(skb);
+		if (async)
+			dev_put(skb->dev);
 		gro_cells_receive(&gro_cells, skb);
 		return 0;
 	} else {
@@ -753,6 +759,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 				sp->olen = 0;
 			if (skb_valid_dst(skb))
 				skb_dst_drop(skb);
+			if (async)
+				dev_put(skb->dev);
 			gro_cells_receive(&gro_cells, skb);
 			return err;
 		}
@@ -763,6 +771,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 drop_unlock:
 	spin_unlock(&x->lock);
 drop:
+	if (async)
+		dev_put(skb->dev);
 	xfrm_rcv_cb(skb, family, x && x->type ? x->type->proto : nexthdr, -1);
 	kfree_skb(skb);
 	return 0;
-- 
2.43.0


