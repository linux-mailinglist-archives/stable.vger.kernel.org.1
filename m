Return-Path: <stable+bounces-221538-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qClIOxqYo2neHgUAu9opvQ
	(envelope-from <stable+bounces-221538-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:36:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC511CB189
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19C9130440EA
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F3F2877DE;
	Sun,  1 Mar 2026 01:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Et+Z2ORQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94871430BB5;
	Sun,  1 Mar 2026 01:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328516; cv=none; b=HmQMBKPTUDpYH1XMm7nV6R/dIg3tJN8lcLbHx6r8QvYIJdNp9jmaDBYf2GSD8maOYy8qH/iDEPWXx2rqNqcD/apRyYrtf7vyWtWKtpCNyVRIJP+tGe2Nhd79YT5ZqgRYAr5cs6IXe2DhZuNhKKMpdFRPX1BgRVyfKeXjGqflkeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328516; c=relaxed/simple;
	bh=Si2q11zQVF7PgHPZE4SXXVan9J85tw9T8ZHibFGTpm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S7KHP+C9Xi/FHKrydBzr6xVrnakDCL2ai7Wt/IyMH/aVs+HDm+Itx/D9Dfjcd7/69enBNGaKKVrvdsmcHE1GIaV3YU5QXh6bs73732cVUoaKnxA2iWjGH5/x86snBpRX3iKkRToRQstEtGGInGsCNwHBrKCGfiuj7ILjztffNEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Et+Z2ORQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F67C19424;
	Sun,  1 Mar 2026 01:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328516;
	bh=Si2q11zQVF7PgHPZE4SXXVan9J85tw9T8ZHibFGTpm0=;
	h=From:To:Cc:Subject:Date:From;
	b=Et+Z2ORQBuBc+JY6Q5B4MUV4k/BCqUdZzTPbi7fygvO1yUbAiqa9YdRGRC+O5sonb
	 W7iAb7qBjwDUURXW2iyVg0JWkd1brvm+Ge4WsuHQhcMSGwypl2BvF3Oie43UuOpPuC
	 onn/9PvJ+0JEeKMMUuihX+UqYyK4eMJa244TMWisBhheSJCq7iaQQdLt9FXdlpmTQc
	 nqoBiHlvYgcYqx4RUWAQsQ6BWeRNmXmfJm1WK/sQg13g6i13v2GmCJQwoKdf0tqAUz
	 dip6GRdhj4yMhIk/FCWt1ckAZkghQix0u4RFY3V4ZG9j+n/raZtRi3hnZM14279zau
	 zkvj32CK/4Prg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	qjx1298677004@gmail.com
Cc: Justin Iurman <justin.iurman@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Subject: FAILED: Patch "ipv6: ioam: fix heap buffer overflow in __ioam6_fill_trace_data()" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:28:34 -0500
Message-ID: <20260301012834.1686345-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221538-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BDC511CB189
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6db8b56eed62baacaf37486e83378a72635c04cc Mon Sep 17 00:00:00 2001
From: Qanux <qjx1298677004@gmail.com>
Date: Wed, 11 Feb 2026 12:04:12 +0800
Subject: [PATCH] ipv6: ioam: fix heap buffer overflow in
 __ioam6_fill_trace_data()

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
index 209fdf1b1aa9b..5e3610a926cfb 100644
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





