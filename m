Return-Path: <stable+bounces-220884-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PFtEdZFo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220884-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:45:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB4F1C7540
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A07B32FBC5C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1214742288B;
	Sat, 28 Feb 2026 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUMLbQKm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83E6422879;
	Sat, 28 Feb 2026 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300774; cv=none; b=NiAFeoR+Xt0sehoThzpfaFfkctSKsxh7ZXn8vnOjdUwJ03yc3+g+VtxbphqpY9gNkARkZ2RPXn966l2ZyP2/7mHEt0xFwsk8K3ixDwzpCEI7e9juEe74EJaG0Bt3G/kodLofv63B1tftjrQjfYwj5gVev+LoTAZyBA5gNz8z6N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300774; c=relaxed/simple;
	bh=ZMGr9zlLKvUGwFobXcT97WA+X/+/KbFE5hJxL/qb/Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUFtZlM9WpOVYHH+zUZPTjqBjsiW34DgfwtgLHQwj3LvkCv9eoHJgkDhXoNmgE9HATmVOelukjuSaAQwcgN955gyvr290dJh7q460t79uH54u4mPxTh1MuMA68/iOvulBBpmZIoUsw6qeXzegy1oYKLc9rrh6JgGm8hjouHgbto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUMLbQKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CE4C2BCB0;
	Sat, 28 Feb 2026 17:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300774;
	bh=ZMGr9zlLKvUGwFobXcT97WA+X/+/KbFE5hJxL/qb/Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sUMLbQKmF2Dspuv2oF4uagzp/sQH9jBEyXxakUYRI93Br0PrthbcI/KtRr6mDEA7C
	 3mYrtfO3oayOSP+9NGPmdC4cL/cxb1KpdXSMXet9FvWHw3Yz2GDxQErwjCBYfBmbln
	 NJ4HQQlXEYGTKvL+HBTbj+DqRJA5a9/ZUgMqsVAw9LVS1UPv1aD7L5qwC1xNtH2s7z
	 pfCUsY3WkuQppgGBUH7jB/yhR32UXgTbZv30Scs68l4YTuysFVECuWwaej/RnL6upY
	 ZvoBLYY666Q02Iy0FXNhanwWPkWRnHXGyfL0uWZU7NHLZA617HVJVT2hlRO8hfIMgd
	 0Tf1m3iXjxTgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qanux <qjx1298677004@gmail.com>,
	Justin Iurman <justin.iurman@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 805/844] ipv6: ioam: fix heap buffer overflow in __ioam6_fill_trace_data()
Date: Sat, 28 Feb 2026 12:31:58 -0500
Message-ID: <20260228173244.1509663-806-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220884-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EB4F1C7540
X-Rspamd-Action: no action

From: Qanux <qjx1298677004@gmail.com>

[ Upstream commit 6db8b56eed62baacaf37486e83378a72635c04cc ]

On the receive path, __ioam6_fill_trace_data() uses trace->nodelen
to decide how much data to write for each node. It trusts this field
as-is from the incoming packet, with no consistency check against
trace->type (the 24-bit field that tells which data items are
present). A crafted packet can set nodelen=0 while setting type bits
0-21, causing the function to write ~100 bytes past the allocated
region (into skb_shared_info), which corrupts adjacent heap memory
and leads to a kernel panic.

Add a shared helper ioam6_trace_compute_nodelen() in ioam6.c to
derive the expected nodelen from the type field, and use it:

  - in ioam6_iptunnel.c (send path, existing validation) to replace
    the open-coded computation;
  - in exthdrs.c (receive path, ipv6_hop_ioam) to drop packets whose
    nodelen is inconsistent with the type field, before any data is
    written.

Per RFC 9197, bits 12-21 are each short (4-octet) fields, so they
are included in IOAM6_MASK_SHORT_FIELDS (changed from 0xff100000 to
0xff1ffc00).

Fixes: 9ee11f0fff20 ("ipv6: ioam: Data plane support for Pre-allocated Trace")
Cc: stable@vger.kernel.org
Signed-off-by: Junxi Qian <qjx1298677004@gmail.com>
Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
Link: https://patch.msgid.link/20260211040412.86195-1-qjx1298677004@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ioam6.h       |  2 ++
 net/ipv6/exthdrs.c        |  5 +++++
 net/ipv6/ioam6.c          | 14 ++++++++++++++
 net/ipv6/ioam6_iptunnel.c | 10 +---------
 4 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/include/net/ioam6.h b/include/net/ioam6.h
index 2cbbee6e806aa..a75912fe247e6 100644
--- a/include/net/ioam6.h
+++ b/include/net/ioam6.h
@@ -60,6 +60,8 @@ void ioam6_fill_trace_data(struct sk_buff *skb,
 			   struct ioam6_trace_hdr *trace,
 			   bool is_input);
 
+u8 ioam6_trace_compute_nodelen(u32 trace_type);
+
 int ioam6_init(void);
 void ioam6_exit(void);
 
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 54088fa0c09d0..310836a0cf17b 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -931,6 +931,11 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 		if (hdr->opt_len < 2 + sizeof(*trace) + trace->remlen * 4)
 			goto drop;
 
+		/* Inconsistent Pre-allocated Trace header */
+		if (trace->nodelen !=
+		    ioam6_trace_compute_nodelen(be32_to_cpu(trace->type_be32)))
+			goto drop;
+
 		/* Ignore if the IOAM namespace is unknown */
 		ns = ioam6_namespace(dev_net(skb->dev), trace->namespace_id);
 		if (!ns)
diff --git a/net/ipv6/ioam6.c b/net/ipv6/ioam6.c
index 9553a32000813..08b7ac8c99b7e 100644
--- a/net/ipv6/ioam6.c
+++ b/net/ipv6/ioam6.c
@@ -690,6 +690,20 @@ struct ioam6_namespace *ioam6_namespace(struct net *net, __be16 id)
 	return rhashtable_lookup_fast(&nsdata->namespaces, &id, rht_ns_params);
 }
 
+#define IOAM6_MASK_SHORT_FIELDS 0xff1ffc00
+#define IOAM6_MASK_WIDE_FIELDS  0x00e00000
+
+u8 ioam6_trace_compute_nodelen(u32 trace_type)
+{
+	u8 nodelen = hweight32(trace_type & IOAM6_MASK_SHORT_FIELDS)
+				* (sizeof(__be32) / 4);
+
+	nodelen += hweight32(trace_type & IOAM6_MASK_WIDE_FIELDS)
+				* (sizeof(__be64) / 4);
+
+	return nodelen;
+}
+
 static void __ioam6_fill_trace_data(struct sk_buff *skb,
 				    struct ioam6_namespace *ns,
 				    struct ioam6_trace_hdr *trace,
diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index 1fe7894f14dd9..b9f6d892a566c 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -22,9 +22,6 @@
 #include <net/ip6_route.h>
 #include <net/addrconf.h>
 
-#define IOAM6_MASK_SHORT_FIELDS 0xff100000
-#define IOAM6_MASK_WIDE_FIELDS 0xe00000
-
 struct ioam6_lwt_encap {
 	struct ipv6_hopopt_hdr eh;
 	u8 pad[2];			/* 2-octet padding for 4n-alignment */
@@ -93,13 +90,8 @@ static bool ioam6_validate_trace_hdr(struct ioam6_trace_hdr *trace)
 	    trace->type.bit21 | trace->type.bit23)
 		return false;
 
-	trace->nodelen = 0;
 	fields = be32_to_cpu(trace->type_be32);
-
-	trace->nodelen += hweight32(fields & IOAM6_MASK_SHORT_FIELDS)
-				* (sizeof(__be32) / 4);
-	trace->nodelen += hweight32(fields & IOAM6_MASK_WIDE_FIELDS)
-				* (sizeof(__be64) / 4);
+	trace->nodelen = ioam6_trace_compute_nodelen(fields);
 
 	return true;
 }
-- 
2.51.0


