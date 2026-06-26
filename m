Return-Path: <stable+bounces-269189-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t5QjELCnPmr0JgkAu9opvQ
	(envelope-from <stable+bounces-269189-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:24:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA616CEFBB
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:24:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=narfation.org header.s=20121 header.b=WcGDqgzm;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269189-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269189-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=narfation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3445B31D5886
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8663FB052;
	Fri, 26 Jun 2026 16:12:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BCA3FB06E
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490359; cv=none; b=Yl6haYp95C5gnF8/V8fldq01pzHnvG3750NWEI36WU4EdvKYQgI2HSPaFf1XipZF4XhCFdnrsGEFOzH8kAkn26bj9tX+E1iifnlDRmb+tE0kpWOTZyesLFJZnqVpc5oDcOM5m21pIYPEuyrsveDME3bMBY3zFe0+siUqIRx+Vyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490359; c=relaxed/simple;
	bh=RRDqPVhOh/jqdvKNH4WvIljG/GX3n6eN0UVkX31YW8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cz5wU/9f+9mzLxJ2OAkCWdtu/JjrV7z4CwEivP87lvsVkOI8ieBruHYI4rvqpmGSUjfma9r11MmVxaSpHhkugn6jIsladYno4eU8uM7id99iabPgyawL2pxnOHij40oUIOQIrEHBYoYk9zgS0VceIJkM9LpOZuqkFgcApw+ql4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=WcGDqgzm; arc=none smtp.client-ip=213.160.73.56
Received: by dvalin.narfation.org (Postfix) id 55B2920541;
	Fri, 26 Jun 2026 16:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xdAMBgvWWkEd/4PXruvyYiBJzDXPSujvV+UvFAMTW0E=;
	b=WcGDqgzmRhVzbrglEupDukE1u46LkvIpricm4apZFQkXZpl+FxXBD830C7A6hLdiDbMPRM
	sQlvQUyBl1qmrstlo9vf7af+g0Dk6w3CzSQbRvIi0emxZGl3gFgf8ZRTo4xjDbsgccnoKJ
	4LV5ewZDIYOzlrkSWfLP6fcMs2T9NoM=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 7.0 16/26] batman-adv: frag: avoid underflow of TTL
Date: Fri, 26 Jun 2026 18:12:15 +0200
Message-ID: <20260626161225.124839-17-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161225.124839-1-sven@narfation.org>
References: <20260626161225.124839-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269189-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sven@narfation.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sven@narfation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[narfation.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,narfation.org:dkim,narfation.org:email,narfation.org:mid,narfation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8AA616CEFBB

commit 493d9d2528e1a09b090e4b37f0f553def7bd5ce9 upstream.

Packets with a TTL are using it to limit the amount of time this packet can
be forwarded. But for batadv_frag_packet, the TTL was always only reduced
but it was never evaluated. It could even underflow without any effect.

Check the TTL in batadv_frag_skb_fwd() before attempting to prepare it for
forwarding. This keeps it in sync with the not fragmented unicast packet.

Cc: stable@kernel.org
Fixes: 610bfc6bc99b ("batman-adv: Receive fragmented packets and merge")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/fragmentation.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index e4e1f9e04aaac..c50a1440bb0d3 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -415,6 +415,13 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
 	 */
 	total_size = ntohs(packet->total_size);
 	if (total_size > neigh_node->if_incoming->net_dev->mtu) {
+		if (packet->ttl < 2) {
+			kfree_skb(skb);
+			*rx_result = NET_RX_DROP;
+			ret = true;
+			goto out;
+		}
+
 		if (skb_cow(skb, ETH_HLEN) < 0) {
 			kfree_skb(skb);
 			*rx_result = NET_RX_DROP;
-- 
2.47.3


