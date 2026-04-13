Return-Path: <stable+bounces-237090-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGNeNH8d3WlhaAkAu9opvQ
	(envelope-from <stable+bounces-237090-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:44:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CBA3EFAC8
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A89F8304FECE
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDD231354C;
	Mon, 13 Apr 2026 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PUH38WAF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66CA30FC0F;
	Mon, 13 Apr 2026 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098559; cv=none; b=sdXKxNfIqMJ34pzCRf9GFywH2yX5Vw+bLGBSbPBJ9QcJAq9vzkdMSWbjDoWHxn3lFxMMoabpMkbps7bC5ZlYk7zAqzRomI5qp4vQ8NF4rDGea0b5yiGS+z5XHFG/Q+3hdsssWSXh81aFJ+GfnhdU68v2MJYE8OxAwHeroCV65ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098559; c=relaxed/simple;
	bh=Qc8Xrocmp0dKexzxnV7WACj82HORHp8eba/f6XyDLuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OodYT94S7SDDY8Iy/giJi58hlVlDqZoDt+vr7PO4bad0T3WlWThnpDudiZWDKL6zSnhVJOVGLyOO5yPKSqhWs8DKkzBKQgQWikUBSJxaYgFustFmXLot5y058LE8aJQhbvjHCXW7501wV/k5Ek34PhjRi7KvqmL6cESLmq07O3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PUH38WAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EC1C2BCAF;
	Mon, 13 Apr 2026 16:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098558;
	bh=Qc8Xrocmp0dKexzxnV7WACj82HORHp8eba/f6XyDLuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PUH38WAFV3Fy9KWQAq7oMcC0l0SBUqILiMlhvUeGt3ahcJLAJNRRqoLcnTiMTwKlj
	 IvMLYWAtXx/JnTnT5Leu6hlA2v78w0iF5fZNALPKnkYh7nOcF/63IpMIjPB3p+BZua
	 agbdYmoHf4SOJ5Vbf5RxqSQkxQC00gVAcmOINqKE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Justin Iurman <justin.iurman@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 544/570] seg6: separate dst_cache for input and output paths in seg6 lwtunnel
Date: Mon, 13 Apr 2026 18:01:15 +0200
Message-ID: <20260413155850.824243601@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-237090-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,uniroma2.it,6wind.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 71CBA3EFAC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrea Mayer <andrea.mayer@uniroma2.it>

[ Upstream commit c3812651b522fe8437ebb7063b75ddb95b571643 ]

The seg6 lwtunnel uses a single dst_cache per encap route, shared
between seg6_input_core() and seg6_output_core(). These two paths
can perform the post-encap SID lookup in different routing contexts
(e.g., ip rules matching on the ingress interface, or VRF table
separation). Whichever path runs first populates the cache, and the
other reuses it blindly, bypassing its own lookup.

Fix this by splitting the cache into cache_input and cache_output,
so each path maintains its own cached dst independently.

Fixes: 6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and injection with lwtunnels")
Cc: stable@vger.kernel.org
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
Link: https://patch.msgid.link/20260404004405.4057-2-andrea.mayer@uniroma2.it
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ added missing dst reference loop guard in seg6_output_core() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/seg6_iptunnel.c |   41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -48,7 +48,8 @@ static size_t seg6_lwt_headroom(struct s
 }
 
 struct seg6_lwt {
-	struct dst_cache cache;
+	struct dst_cache cache_input;
+	struct dst_cache cache_output;
 	struct seg6_iptunnel_encap tuninfo[];
 };
 
@@ -486,7 +487,7 @@ static int seg6_input_core(struct net *n
 	slwt = seg6_lwt_lwtunnel(lwtst);
 
 	local_bh_disable();
-	dst = dst_cache_get(&slwt->cache);
+	dst = dst_cache_get(&slwt->cache_input);
 	local_bh_enable();
 
 	err = seg6_do_srh(skb, dst);
@@ -504,7 +505,7 @@ static int seg6_input_core(struct net *n
 		/* cache only if we don't create a dst reference loop */
 		if (!dst->error && lwtst != dst->lwtstate) {
 			local_bh_disable();
-			dst_cache_set_ip6(&slwt->cache, dst,
+			dst_cache_set_ip6(&slwt->cache_input, dst,
 					  &ipv6_hdr(skb)->saddr);
 			local_bh_enable();
 		}
@@ -563,7 +564,7 @@ static int seg6_output_core(struct net *
 	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
 
 	local_bh_disable();
-	dst = dst_cache_get(&slwt->cache);
+	dst = dst_cache_get(&slwt->cache_output);
 	local_bh_enable();
 
 	err = seg6_do_srh(skb, dst);
@@ -587,9 +588,12 @@ static int seg6_output_core(struct net *
 			goto drop;
 		}
 
-		local_bh_disable();
-		dst_cache_set_ip6(&slwt->cache, dst, &fl6.saddr);
-		local_bh_enable();
+		/* cache only if we don't create a dst reference loop */
+		if (orig_dst->lwtstate != dst->lwtstate) {
+			local_bh_disable();
+			dst_cache_set_ip6(&slwt->cache_output, dst, &fl6.saddr);
+			local_bh_enable();
+		}
 
 		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
 		if (unlikely(err))
@@ -697,11 +701,13 @@ static int seg6_build_state(struct net *
 
 	slwt = seg6_lwt_lwtunnel(newts);
 
-	err = dst_cache_init(&slwt->cache, GFP_ATOMIC);
-	if (err) {
-		kfree(newts);
-		return err;
-	}
+	err = dst_cache_init(&slwt->cache_input, GFP_ATOMIC);
+	if (err)
+		goto err_free_newts;
+
+	err = dst_cache_init(&slwt->cache_output, GFP_ATOMIC);
+	if (err)
+		goto err_destroy_input;
 
 	memcpy(&slwt->tuninfo, tuninfo, tuninfo_len);
 
@@ -716,11 +722,20 @@ static int seg6_build_state(struct net *
 	*ts = newts;
 
 	return 0;
+
+err_destroy_input:
+	dst_cache_destroy(&slwt->cache_input);
+err_free_newts:
+	kfree(newts);
+	return err;
 }
 
 static void seg6_destroy_state(struct lwtunnel_state *lwt)
 {
-	dst_cache_destroy(&seg6_lwt_lwtunnel(lwt)->cache);
+	struct seg6_lwt *slwt = seg6_lwt_lwtunnel(lwt);
+
+	dst_cache_destroy(&slwt->cache_input);
+	dst_cache_destroy(&slwt->cache_output);
 }
 
 static int seg6_fill_encap_info(struct sk_buff *skb,



