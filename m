Return-Path: <stable+bounces-156246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB1DAE4EC8
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0A33BE736
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5963C21638A;
	Mon, 23 Jun 2025 21:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XkksCuUW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163B870838;
	Mon, 23 Jun 2025 21:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750712941; cv=none; b=kboRHMx6HMVkiABKeKnSvnPZbEyKhMLVVy9vvoOcVB5IYBZfVIKguC2tOKvszkmkrVEFxnsePNDBG/0YmFT2FeLoyH/k5T8vMy5EV/6LgbO2AH+zm9WaMayi9fHE0/VMXXJhf3jHkC2TOAUqsfIBKaoTw1gxmmpksPhCe+57qno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750712941; c=relaxed/simple;
	bh=2BXSKfsDd9UFTR2IRqCFAgigfTx5xLCi52B4sYlmRDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIhrVTfY7ECI3HIYUWIDgxT/G56QCCfkI2aiSD3c0BDZ/RC3ABKmQHuZhaOxAFtL8y+A6laJu7JHAnY7KLb3g9ekRpRcnWE5wiA52aGwPMQpWiYTawjiV+P3qGb6L9QkRHfHmtxixL5QRNLFMjaNfneXIQQFopyeY1YdQZuh1HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XkksCuUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C625C4CEEA;
	Mon, 23 Jun 2025 21:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750712940;
	bh=2BXSKfsDd9UFTR2IRqCFAgigfTx5xLCi52B4sYlmRDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XkksCuUWBIYEKA3bD7DLGuu0/efM04qDt8SMkXSaRm3l2hJtSC10Xr2l4j59/HpSj
	 XoegCD/aZdqheplRML9KMqlW14UWa7kO/F32D+sUTEqLWpbZrvYyLGlrclYup4MY17
	 k84Mtg5Z7wtnFVpxU8xdFeoFr8G4b+dFMpleo0sQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huajian Yang <huajianyang@asrmicro.com>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 068/508] netfilter: bridge: Move specific fragmented packet to slow_path instead of dropping it
Date: Mon, 23 Jun 2025 15:01:53 +0200
Message-ID: <20250623130646.914421951@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huajian Yang <huajianyang@asrmicro.com>

[ Upstream commit aa04c6f45b9224b949aa35d4fa5f8d0ba07b23d4 ]

The config NF_CONNTRACK_BRIDGE will change the bridge forwarding for
fragmented packets.

The original bridge does not know that it is a fragmented packet and
forwards it directly, after NF_CONNTRACK_BRIDGE is enabled, function
nf_br_ip_fragment and br_ip6_fragment will check the headroom.

In original br_forward, insufficient headroom of skb may indeed exist,
but there's still a way to save the skb in the device driver after
dev_queue_xmit.So droping the skb will change the original bridge
forwarding in some cases.

Fixes: 3c171f496ef5 ("netfilter: bridge: add connection tracking system")
Signed-off-by: Huajian Yang <huajianyang@asrmicro.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/netfilter/nf_conntrack_bridge.c | 12 ++++++------
 net/ipv6/netfilter.c                       | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index e60c38670f220..e7df2911d2be7 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -60,19 +60,19 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
 		struct ip_fraglist_iter iter;
 		struct sk_buff *frag;
 
-		if (first_len - hlen > mtu ||
-		    skb_headroom(skb) < ll_rs)
+		if (first_len - hlen > mtu)
 			goto blackhole;
 
-		if (skb_cloned(skb))
+		if (skb_cloned(skb) ||
+		    skb_headroom(skb) < ll_rs)
 			goto slow_path;
 
 		skb_walk_frags(skb, frag) {
-			if (frag->len > mtu ||
-			    skb_headroom(frag) < hlen + ll_rs)
+			if (frag->len > mtu)
 				goto blackhole;
 
-			if (skb_shared(frag))
+			if (skb_shared(frag) ||
+			    skb_headroom(frag) < hlen + ll_rs)
 				goto slow_path;
 		}
 
diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
index 857713d7a38a5..d873658fc821f 100644
--- a/net/ipv6/netfilter.c
+++ b/net/ipv6/netfilter.c
@@ -163,20 +163,20 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		struct ip6_fraglist_iter iter;
 		struct sk_buff *frag2;
 
-		if (first_len - hlen > mtu ||
-		    skb_headroom(skb) < (hroom + sizeof(struct frag_hdr)))
+		if (first_len - hlen > mtu)
 			goto blackhole;
 
-		if (skb_cloned(skb))
+		if (skb_cloned(skb) ||
+		    skb_headroom(skb) < (hroom + sizeof(struct frag_hdr)))
 			goto slow_path;
 
 		skb_walk_frags(skb, frag2) {
-			if (frag2->len > mtu ||
-			    skb_headroom(frag2) < (hlen + hroom + sizeof(struct frag_hdr)))
+			if (frag2->len > mtu)
 				goto blackhole;
 
 			/* Partially cloned skb? */
-			if (skb_shared(frag2))
+			if (skb_shared(frag2) ||
+			    skb_headroom(frag2) < (hlen + hroom + sizeof(struct frag_hdr)))
 				goto slow_path;
 		}
 
-- 
2.39.5




