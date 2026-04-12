Return-Path: <stable+bounces-235796-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIl5AFAr22kT+AgAu9opvQ
	(envelope-from <stable+bounces-235796-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 07:19:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 672473E2D3C
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 07:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DE93300BCB9
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 05:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DBF282F0F;
	Sun, 12 Apr 2026 05:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z95U86FN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C33D1DE4E0
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 05:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775971100; cv=none; b=cMAMhdWMt6BI+960313t2A4LH2iYzCPUKIQrW1Q2ODx6W7s0qp/DStcruQHf7xl8P621CjMK+qwagQ8EiOK7n+n8Lz+1oOu7vthIFB2NHBAs0g/WmkwKU01/nGFemSmE1vogt9BrOjjBF5auTppsMsSIea7HD0ilpWphMqNLUN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775971100; c=relaxed/simple;
	bh=/FUULWo1AXJDllf3LfucAdHI+VsCrj9xlE2YAflAYxw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=enZZcUajto2ToIlEB0KEzPCpucyT50nfC7RG6CKqXouI+taH3dO8yrkYWnwAtVc30cX0W5pw+B84LnXL5Hc3s92iefYkd2OJEta6gSzghXd78LUxngCyKnUehHxhNxLL3UoaWm4CJp0ioj41tzJHOeplxyEamkh8QYpxcPzI3iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z95U86FN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766C4C19424;
	Sun, 12 Apr 2026 05:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775971099;
	bh=/FUULWo1AXJDllf3LfucAdHI+VsCrj9xlE2YAflAYxw=;
	h=Subject:To:Cc:From:Date:From;
	b=z95U86FNLXz8fsofi7EBP5sgL05X3joT4OgtXDYaebYulcUDu1zq8MmcsxD4rGiZf
	 vMfGefTrZtBWgYxgqXWYDUJNiNBj3dQgcyhCr+6LnRKHe8+5vaOvvogWimOonIb26i
	 s5B5jBkQdpnjjpVdC/JZm+IO2PjK+dFTuua9K37w=
Subject: FAILED: patch "[PATCH] seg6: separate dst_cache for input and output paths in seg6" failed to apply to 5.10-stable tree
To: andrea.mayer@uniroma2.it,justin.iurman@gmail.com,kuba@kernel.org,nicolas.dichtel@6wind.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 12 Apr 2026 07:18:05 +0200
Message-ID: <2026041205-decent-bottle-51e5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235796-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[uniroma2.it,gmail.com,kernel.org,6wind.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniroma2.it:email,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 672473E2D3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c3812651b522fe8437ebb7063b75ddb95b571643
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026041205-decent-bottle-51e5@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c3812651b522fe8437ebb7063b75ddb95b571643 Mon Sep 17 00:00:00 2001
From: Andrea Mayer <andrea.mayer@uniroma2.it>
Date: Sat, 4 Apr 2026 02:44:04 +0200
Subject: [PATCH] seg6: separate dst_cache for input and output paths in seg6
 lwtunnel

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

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 3e1b9991131a..d6a0f7df9080 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -48,7 +48,8 @@ static size_t seg6_lwt_headroom(struct seg6_iptunnel_encap *tuninfo)
 }
 
 struct seg6_lwt {
-	struct dst_cache cache;
+	struct dst_cache cache_input;
+	struct dst_cache cache_output;
 	struct seg6_iptunnel_encap tuninfo[];
 };
 
@@ -488,7 +489,7 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 	slwt = seg6_lwt_lwtunnel(lwtst);
 
 	local_bh_disable();
-	dst = dst_cache_get(&slwt->cache);
+	dst = dst_cache_get(&slwt->cache_input);
 	local_bh_enable();
 
 	err = seg6_do_srh(skb, dst);
@@ -504,7 +505,7 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 		/* cache only if we don't create a dst reference loop */
 		if (!dst->error && lwtst != dst->lwtstate) {
 			local_bh_disable();
-			dst_cache_set_ip6(&slwt->cache, dst,
+			dst_cache_set_ip6(&slwt->cache_input, dst,
 					  &ipv6_hdr(skb)->saddr);
 			local_bh_enable();
 		}
@@ -564,7 +565,7 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
 
 	local_bh_disable();
-	dst = dst_cache_get(&slwt->cache);
+	dst = dst_cache_get(&slwt->cache_output);
 	local_bh_enable();
 
 	err = seg6_do_srh(skb, dst);
@@ -591,7 +592,7 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 		/* cache only if we don't create a dst reference loop */
 		if (orig_dst->lwtstate != dst->lwtstate) {
 			local_bh_disable();
-			dst_cache_set_ip6(&slwt->cache, dst, &fl6.saddr);
+			dst_cache_set_ip6(&slwt->cache_output, dst, &fl6.saddr);
 			local_bh_enable();
 		}
 
@@ -701,11 +702,13 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
 
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
 
@@ -720,11 +723,20 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
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


