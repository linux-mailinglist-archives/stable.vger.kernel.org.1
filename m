Return-Path: <stable+bounces-239418-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NwSMp9X5mlQvAEAu9opvQ
	(envelope-from <stable+bounces-239418-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:43:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 400B342FE3B
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 059323387D52
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5B133262B;
	Mon, 20 Apr 2026 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2J9b8FbL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C1532E696;
	Mon, 20 Apr 2026 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700200; cv=none; b=KadNo8+zTwHYnDUyIF9T98Sot4YqP0R5w/zx5tWWD0kWqe8SPsikQb1azJgMFbQEBfKhwkPBRVLcisKxTVPIsqyuGz3MFrCyo1c5uvTxHtbwLgmBBT25bgALUl3QGMeBhPNXlAgawgHyick2Ip5erzdscCNBw0wyX2DIpmgd1sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700200; c=relaxed/simple;
	bh=i/2RTa5pmmIcQZfwo5t6y/MyllIujMydOrg8NbiDYeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocQ7QwvaPB9BMWzr9uKbdZwyajax0B5+CRRoMngncs0vRXHFb4OnhcK/79plePpKQQigOpWDb2CaXIRBdXsmK3HiuI6SYqT7TptpJ4sumjOc3eGjvrdYGm/haCXCtvyxyUy9v+mhcxxyK3zd/JLSa/pgnJlD+O/59T8c1HQSVxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2J9b8FbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15ECC19425;
	Mon, 20 Apr 2026 15:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700200;
	bh=i/2RTa5pmmIcQZfwo5t6y/MyllIujMydOrg8NbiDYeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2J9b8FbLrCKsqKzJApS1nQb9mXU3R+XIshC35j0wouNjdtMgeA7D4VtXfsa+WFgBB
	 yUJWPJMSN5r03AG8EarunupcSJNGnqYH7z5siOxUMwGUAcd1/evlZbcP/Z9Asp9Egd
	 bDImeDQFIdSqE4Jk0wUTRj353MaYSp7lQPQgEVo4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yiming Qian <yimingqian591@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Justin Iurman <justin.iurman@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 081/220] ipv6: ioam: fix potential NULL dereferences in __ioam6_fill_trace_data()
Date: Mon, 20 Apr 2026 17:40:22 +0200
Message-ID: <20260420153936.954187934@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-239418-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,google.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: 400B342FE3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 4e65a8b8daa18d63255ec58964dd192c7fdd9f8b ]

We need to check __in6_dev_get() for possible NULL value, as
suggested by Yiming Qian.

Also add skb_dst_dev_rcu() instead of skb_dst_dev(),
and two missing READ_ONCE().

Note that @dev can't be NULL.

Fixes: 9ee11f0fff20 ("ipv6: ioam: Data plane support for Pre-allocated Trace")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
Link: https://patch.msgid.link/20260402101732.1188059-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ioam6.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/ioam6.c b/net/ipv6/ioam6.c
index 8db7f965696aa..12350e1e18bde 100644
--- a/net/ipv6/ioam6.c
+++ b/net/ipv6/ioam6.c
@@ -710,7 +710,9 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 				    struct ioam6_schema *sc,
 				    unsigned int sclen, bool is_input)
 {
-	struct net_device *dev = skb_dst_dev(skb);
+	/* Note: skb_dst_dev_rcu() can't be NULL at this point. */
+	struct net_device *dev = skb_dst_dev_rcu(skb);
+	struct inet6_dev *i_skb_dev, *idev;
 	struct timespec64 ts;
 	ktime_t tstamp;
 	u64 raw64;
@@ -721,13 +723,16 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 
 	data = trace->data + trace->remlen * 4 - trace->nodelen * 4 - sclen * 4;
 
+	i_skb_dev = skb->dev ? __in6_dev_get(skb->dev) : NULL;
+	idev = __in6_dev_get(dev);
+
 	/* hop_lim and node_id */
 	if (trace->type.bit0) {
 		byte = ipv6_hdr(skb)->hop_limit;
 		if (is_input)
 			byte--;
 
-		raw32 = dev_net(dev)->ipv6.sysctl.ioam6_id;
+		raw32 = READ_ONCE(dev_net(dev)->ipv6.sysctl.ioam6_id);
 
 		*(__be32 *)data = cpu_to_be32((byte << 24) | raw32);
 		data += sizeof(__be32);
@@ -735,18 +740,18 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 
 	/* ingress_if_id and egress_if_id */
 	if (trace->type.bit1) {
-		if (!skb->dev)
+		if (!i_skb_dev)
 			raw16 = IOAM6_U16_UNAVAILABLE;
 		else
-			raw16 = (__force u16)READ_ONCE(__in6_dev_get(skb->dev)->cnf.ioam6_id);
+			raw16 = (__force u16)READ_ONCE(i_skb_dev->cnf.ioam6_id);
 
 		*(__be16 *)data = cpu_to_be16(raw16);
 		data += sizeof(__be16);
 
-		if (dev->flags & IFF_LOOPBACK)
+		if ((dev->flags & IFF_LOOPBACK) || !idev)
 			raw16 = IOAM6_U16_UNAVAILABLE;
 		else
-			raw16 = (__force u16)READ_ONCE(__in6_dev_get(dev)->cnf.ioam6_id);
+			raw16 = (__force u16)READ_ONCE(idev->cnf.ioam6_id);
 
 		*(__be16 *)data = cpu_to_be16(raw16);
 		data += sizeof(__be16);
@@ -822,7 +827,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		if (is_input)
 			byte--;
 
-		raw64 = dev_net(dev)->ipv6.sysctl.ioam6_id_wide;
+		raw64 = READ_ONCE(dev_net(dev)->ipv6.sysctl.ioam6_id_wide);
 
 		*(__be64 *)data = cpu_to_be64(((u64)byte << 56) | raw64);
 		data += sizeof(__be64);
@@ -830,18 +835,18 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 
 	/* ingress_if_id and egress_if_id (wide) */
 	if (trace->type.bit9) {
-		if (!skb->dev)
+		if (!i_skb_dev)
 			raw32 = IOAM6_U32_UNAVAILABLE;
 		else
-			raw32 = READ_ONCE(__in6_dev_get(skb->dev)->cnf.ioam6_id_wide);
+			raw32 = READ_ONCE(i_skb_dev->cnf.ioam6_id_wide);
 
 		*(__be32 *)data = cpu_to_be32(raw32);
 		data += sizeof(__be32);
 
-		if (dev->flags & IFF_LOOPBACK)
+		if ((dev->flags & IFF_LOOPBACK) || !idev)
 			raw32 = IOAM6_U32_UNAVAILABLE;
 		else
-			raw32 = READ_ONCE(__in6_dev_get(dev)->cnf.ioam6_id_wide);
+			raw32 = READ_ONCE(idev->cnf.ioam6_id_wide);
 
 		*(__be32 *)data = cpu_to_be32(raw32);
 		data += sizeof(__be32);
-- 
2.53.0




