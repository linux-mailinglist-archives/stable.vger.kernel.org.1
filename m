Return-Path: <stable+bounces-236347-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oD8IJ0oY3WnoZwkAu9opvQ
	(envelope-from <stable+bounces-236347-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:22:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 190233EEBDF
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62CF33085E91
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30BF2737E0;
	Mon, 13 Apr 2026 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LJJLJWs/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F5A2472A2;
	Mon, 13 Apr 2026 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096671; cv=none; b=q6Sb1BWYkT40mxeZCUsRKfnUEsm2fgprofmXZ5d9PiTnr+nrNQil0M7wFpR+jREAjOXRZ2x8rFgsU9Tn5iG3qpApJeR8g1mkFnncQ3fdttIKtSQ3/XiAfDStVudGV4KI4AuLuD6OU4shF2Ul8/9bLJCUxF/6JNsS70/u72RdWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096671; c=relaxed/simple;
	bh=2N0Fup779BgEb/LQZSgoyTis44BxAZh96t40NTmsuJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgNXvWQnAEsXxSAfExmHpIU8qV1JKdMfPRgpsX9Ghyv5ryKQc12cMiNlcThLqZSWaS26rJL6j/+DiOMx01RctBYdhbpkJPNw2uXV8/tn7vOJks4ySrBaqGZLiTBFycGbUnM62T8Pk6WNB+xoJDnNZBnh2ZCmtHc5p+RA7pDpGTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LJJLJWs/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7E1C2BCAF;
	Mon, 13 Apr 2026 16:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096671;
	bh=2N0Fup779BgEb/LQZSgoyTis44BxAZh96t40NTmsuJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJJLJWs/2n8EN9JFPcFFZsGBqHiHEfOvzYwwexFK2KImEqdeEkYDU6wFRmnUnESzj
	 hJ/g9S1yfROE/GbszE42KhimU6MGYKvZ9dXr++opzsCOGUNLJW6TM8QgzDR2UcziP3
	 uCmlhxpVarlTuix0GO12aSMEdA+NCBy6AENAG5Wc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Justin Iurman <justin.iurman@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 07/70] seg6: separate dst_cache for input and output paths in seg6 lwtunnel
Date: Mon, 13 Apr 2026 18:00:02 +0200
Message-ID: <20260413155728.460152405@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155728.181580293@linuxfoundation.org>
References: <20260413155728.181580293@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-236347-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,uniroma2.it,6wind.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,6wind.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 190233EEBDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrea Mayer <andrea.mayer@uniroma2.it>

commit c3812651b522fe8437ebb7063b75ddb95b571643 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/seg6_iptunnel.c |   34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

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
 
@@ -488,7 +489,7 @@ static int seg6_input_core(struct net *n
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
@@ -564,7 +565,7 @@ static int seg6_output_core(struct net *
 	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
 
 	local_bh_disable();
-	dst = dst_cache_get(&slwt->cache);
+	dst = dst_cache_get(&slwt->cache_output);
 	local_bh_enable();
 
 	err = seg6_do_srh(skb, dst);
@@ -591,7 +592,7 @@ static int seg6_output_core(struct net *
 		/* cache only if we don't create a dst reference loop */
 		if (orig_dst->lwtstate != dst->lwtstate) {
 			local_bh_disable();
-			dst_cache_set_ip6(&slwt->cache, dst, &fl6.saddr);
+			dst_cache_set_ip6(&slwt->cache_output, dst, &fl6.saddr);
 			local_bh_enable();
 		}
 
@@ -701,11 +702,13 @@ static int seg6_build_state(struct net *
 
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
 
@@ -720,11 +723,20 @@ static int seg6_build_state(struct net *
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



