Return-Path: <stable+bounces-218712-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFa5JJpYnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218712-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:04:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AAD19078A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 154E231D968F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B25B1E2834;
	Wed, 25 Feb 2026 01:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GSeNkZ9d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2DE2494FE;
	Wed, 25 Feb 2026 01:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983573; cv=none; b=B1saA1izLdDAnCIXiE/o+25hbEgPrVcHQhLnlKPNt0wSXcnQ8c2JBjCADccCA3ujs6YARXuchinSzQd08Kxo2+gJzbkb5kOS+MOrbyabRTF/8O2sTQQXlmzRXSuqHpLmF2VzOYgEOZJWZIMizffAUpu4/Jgks35nAI9JRaCqT0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983573; c=relaxed/simple;
	bh=0ZM2NMccFLeKpdxT0dnhhxiAef9r+jwZM9Mswk2oGYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ky6YDHlKs9MRpDSQaC7OBHyGrkhj9HG+vYZf+CoiHByUlpZav3T8sJdvrepd0ECpzsQ5ORyPisliMIMvfTiDDrvn9LskPtXEKSgwlgG3zC2duZFcgBoNbQWMx+XK2UP+n24qLdrEEa0BW9EskENL5jSgtMQosoSo2ARIFnmm4DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GSeNkZ9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF344C116D0;
	Wed, 25 Feb 2026 01:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983573;
	bh=0ZM2NMccFLeKpdxT0dnhhxiAef9r+jwZM9Mswk2oGYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GSeNkZ9dx0/hwVCzf/azA21Gt4F7peGchgz3xaLnoXczUkF55Uc6D2z0d7bLrZlVv
	 B/N9yMqc5WpYgwNYStCXNHqgVimkb9o0qugUDAAvqL8E/xmrRqQ0N14y1KzvJWoGN+
	 SIf39UZkiGuaYYn4XhWydk70bIcyxioFp2ZZrUUg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Julian Anastasov <ja@ssi.bg>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 666/781] ipvs: do not keep dest_dst if dev is going down
Date: Tue, 24 Feb 2026 17:22:55 -0800
Message-ID: <20260225012416.121463355@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218712-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ssi.bg:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email]
X-Rspamd-Queue-Id: 03AAD19078A
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Anastasov <ja@ssi.bg>

[ Upstream commit 8fde939b0206afc1d5846217a01a16b9bc8c7896 ]

There is race between the netdev notifier ip_vs_dst_event()
and the code that caches dst with dev that is going down.
As the FIB can be notified for the closed device after our
handler finishes, it is possible valid route to be returned
and cached resuling in a leaked dev reference until the dest
is not removed.

To prevent new dest_dst to be attached to dest just after the
handler dropped the old one, add a netif_running() check
to make sure the notifier handler is not currently running
for device that is closing.

Fixes: 7a4f0761fce3 ("IPVS: init and cleanup restructuring")
Signed-off-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipvs/ip_vs_xmit.c | 46 ++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index 64c697212578a..124f779424b0f 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -294,6 +294,12 @@ static inline bool decrement_ttl(struct netns_ipvs *ipvs,
 	return true;
 }
 
+/* rt has device that is down */
+static bool rt_dev_is_down(const struct net_device *dev)
+{
+	return dev && !netif_running(dev);
+}
+
 /* Get route to destination or remote server */
 static int
 __ip_vs_get_out_rt(struct netns_ipvs *ipvs, int skb_af, struct sk_buff *skb,
@@ -309,9 +315,11 @@ __ip_vs_get_out_rt(struct netns_ipvs *ipvs, int skb_af, struct sk_buff *skb,
 
 	if (dest) {
 		dest_dst = __ip_vs_dst_check(dest);
-		if (likely(dest_dst))
+		if (likely(dest_dst)) {
 			rt = dst_rtable(dest_dst->dst_cache);
-		else {
+			if (ret_saddr)
+				*ret_saddr = dest_dst->dst_saddr.ip;
+		} else {
 			dest_dst = ip_vs_dest_dst_alloc();
 			spin_lock_bh(&dest->dst_lock);
 			if (!dest_dst) {
@@ -327,14 +335,22 @@ __ip_vs_get_out_rt(struct netns_ipvs *ipvs, int skb_af, struct sk_buff *skb,
 				ip_vs_dest_dst_free(dest_dst);
 				goto err_unreach;
 			}
-			__ip_vs_dst_set(dest, dest_dst, &rt->dst, 0);
+			/* It is forbidden to attach dest->dest_dst if
+			 * device is going down.
+			 */
+			if (!rt_dev_is_down(dst_dev_rcu(&rt->dst)))
+				__ip_vs_dst_set(dest, dest_dst, &rt->dst, 0);
+			else
+				noref = 0;
 			spin_unlock_bh(&dest->dst_lock);
 			IP_VS_DBG(10, "new dst %pI4, src %pI4, refcnt=%d\n",
 				  &dest->addr.ip, &dest_dst->dst_saddr.ip,
 				  rcuref_read(&rt->dst.__rcuref));
+			if (ret_saddr)
+				*ret_saddr = dest_dst->dst_saddr.ip;
+			if (!noref)
+				ip_vs_dest_dst_free(dest_dst);
 		}
-		if (ret_saddr)
-			*ret_saddr = dest_dst->dst_saddr.ip;
 	} else {
 		noref = 0;
 
@@ -471,9 +487,11 @@ __ip_vs_get_out_rt_v6(struct netns_ipvs *ipvs, int skb_af, struct sk_buff *skb,
 
 	if (dest) {
 		dest_dst = __ip_vs_dst_check(dest);
-		if (likely(dest_dst))
+		if (likely(dest_dst)) {
 			rt = dst_rt6_info(dest_dst->dst_cache);
-		else {
+			if (ret_saddr)
+				*ret_saddr = dest_dst->dst_saddr.in6;
+		} else {
 			u32 cookie;
 
 			dest_dst = ip_vs_dest_dst_alloc();
@@ -494,14 +512,22 @@ __ip_vs_get_out_rt_v6(struct netns_ipvs *ipvs, int skb_af, struct sk_buff *skb,
 			}
 			rt = dst_rt6_info(dst);
 			cookie = rt6_get_cookie(rt);
-			__ip_vs_dst_set(dest, dest_dst, &rt->dst, cookie);
+			/* It is forbidden to attach dest->dest_dst if
+			 * device is going down.
+			 */
+			if (!rt_dev_is_down(dst_dev_rcu(&rt->dst)))
+				__ip_vs_dst_set(dest, dest_dst, &rt->dst, cookie);
+			else
+				noref = 0;
 			spin_unlock_bh(&dest->dst_lock);
 			IP_VS_DBG(10, "new dst %pI6, src %pI6, refcnt=%d\n",
 				  &dest->addr.in6, &dest_dst->dst_saddr.in6,
 				  rcuref_read(&rt->dst.__rcuref));
+			if (ret_saddr)
+				*ret_saddr = dest_dst->dst_saddr.in6;
+			if (!noref)
+				ip_vs_dest_dst_free(dest_dst);
 		}
-		if (ret_saddr)
-			*ret_saddr = dest_dst->dst_saddr.in6;
 	} else {
 		noref = 0;
 		dst = __ip_vs_route_output_v6(net, daddr, ret_saddr, do_xfrm,
-- 
2.51.0




