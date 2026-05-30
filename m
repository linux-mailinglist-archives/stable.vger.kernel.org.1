Return-Path: <stable+bounces-256844-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL2RCIU1Gmp+2AgAu9opvQ
	(envelope-from <stable+bounces-256844-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 02:55:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 947AA60A7E7
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 02:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB6C63013A5D
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 00:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E7E29AAFA;
	Sat, 30 May 2026 00:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJ4+rB+w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9832023BCE3
	for <stable@vger.kernel.org>; Sat, 30 May 2026 00:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102263; cv=none; b=frb4geOntFILSwUgZjsDkX+o+q9Qs0F9g526gENcpj8Vr91hbnp2RPYxzEuwSmU/j0gn6Xm/hgvNKONNBm5kR8VH/FcwC8N0HhDvdAaVcVqENPAR3cDeJ5ToLDgRxe4wbchRzegG6TA5wFlV1iZpW9EM2nNNAQtqj2bZ0ttveb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102263; c=relaxed/simple;
	bh=UjTorGaA5o2UVFsWPY9vcLMjHdXfak/y6mEN7q0kRV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOHYdA5S1Ytcx6PBCyuykX6W74phG/BiENY+lpq6Tj8awI28goxk/CYy6J61GSH/RZzLe/mdDQdXWTDMe7mATa/uBNSt0trDkQtretFN+r+9f2nvfZv1KK8Yo+6vmwztu8l9BaldIomZi1MDFCdpvhZSQol4JTJZGr8dHRVNwXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJ4+rB+w; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B1A1F00893;
	Sat, 30 May 2026 00:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102262;
	bh=49x5IUpjuig+q8efw5Q/B8Zk6A5Ifs1KzMSwNwjoJ28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XJ4+rB+w0nwyr4oB70tWFTn4q1z+UgbXRI/4TVzXJ5NdkEHW7vof/YE6IGbwW0orc
	 ixexERgb9Kt0wxxXQQmRGOOa99DwX0IVvm1+M88++PwifJMaOIfvKImwgLzrnoA190
	 Cu6KcQAPV114pkSlKffO5y0kiFZwGfQW3OLWPkpVXsUpyQpf0EvVPFsu3V/GGjUqeT
	 h9oZdiW5OQCOd80Iapwbg9Vpx7bJjV0WMimkg7vBthnhH/XlHNJ4N1jp0yHNmfWGFG
	 xA34J0WqC7+M4H0gqKohInY+WCp1UlvUKZJ0RmOeRBBb1waeSAOhQft8drVC7N3Foh
	 EjDfI/xSUzFXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Justin Iurman <justin.iurman@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ipv6: ioam: add NULL check for idev in ipv6_hop_ioam()
Date: Fri, 29 May 2026 20:50:58 -0400
Message-ID: <20260530005058.2390235-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052813-cornhusk-amulet-ebad@gregkh>
References: <2026052813-cornhusk-amulet-ebad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-256844-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 947AA60A7E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Justin Iurman <justin.iurman@gmail.com>

[ Upstream commit d4ea0dfd75011b78cebf3808f98ac4c4f51a6fb9 ]

Reported by Sashiko:

The function ipv6_hop_ioam() accesses
__in6_dev_get(skb->dev)->cnf.ioam6_enabled without validating the returned
idev pointer. Because addrconf_ifdown() can concurrently clear dev->ip6_ptr
via RCU, __in6_dev_get() can return NULL during interface teardown, which
could cause a NULL pointer dereference when processing an IOAM Hop-by-Hop
option.

Let's add a check and use SKB_DROP_REASON_IPV6DISABLED accordingly.

Fixes: 9ee11f0fff20 ("ipv6: ioam: Data plane support for Pre-allocated Trace")
Cc: stable@vger.kernel.org
Signed-off-by: Justin Iurman <justin.iurman@gmail.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20260517183059.29140-1-justin.iurman@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ dropped READ_ONCE() wrapper from idev->cnf.ioam6_enabled ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/exthdrs.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 61e0060185f4b..67c54c8bce68b 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -941,16 +941,27 @@ static bool ipv6_hop_ra(struct sk_buff *skb, int optoff)
 
 static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 {
+	enum skb_drop_reason drop_reason;
 	struct ioam6_trace_hdr *trace;
 	struct ioam6_namespace *ns;
+	struct inet6_dev *idev;
 	struct ioam6_hdr *hdr;
 
+	drop_reason = SKB_DROP_REASON_IP_INHDR;
+
 	/* Bad alignment (must be 4n-aligned) */
 	if (optoff & 3)
 		goto drop;
 
+	/* Does the device still have IPv6 configuration? */
+	idev = __in6_dev_get(skb->dev);
+	if (!idev) {
+		drop_reason = SKB_DROP_REASON_IPV6DISABLED;
+		goto drop;
+	}
+
 	/* Ignore if IOAM is not enabled on ingress */
-	if (!__in6_dev_get(skb->dev)->cnf.ioam6_enabled)
+	if (!idev->cnf.ioam6_enabled)
 		goto ignore;
 
 	/* Truncated Option header */
@@ -1000,7 +1011,7 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 	return true;
 
 drop:
-	kfree_skb_reason(skb, SKB_DROP_REASON_IP_INHDR);
+	kfree_skb_reason(skb, drop_reason);
 	return false;
 }
 
-- 
2.53.0


