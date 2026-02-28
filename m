Return-Path: <stable+bounces-220542-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBlaNDFNo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220542-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:16:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C97A1C821D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 180D3343DD10
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770EC3D16F7;
	Sat, 28 Feb 2026 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbpte7vi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396B33D16ED;
	Sat, 28 Feb 2026 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300425; cv=none; b=IbwWeuA3/UjVP/jjyC/0WmL6Zx/2SfdKDNKFM2gTkBiLTcEgXZWrVS+hv2EPDkCFnkeKI3EtWbRtIWKF1GTqqPeAtyrdj2oRdWWEblCM/eAEDgqh43SuWEU+/o2PlXK29LLrtgh94XX+3ma+QLS+5cYRJsxbIhA+NiaP6RRoAJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300425; c=relaxed/simple;
	bh=Jb5ywi24OQ8pNIhxv/M9crNwVllSRmKpFUIzwjBM088=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGgvuYpDWh3FhFZzhoBgtHM31lvEWrqmyFaGGOYTM3tVLgBnRQDw4XOUXcuogaT+q72exHjIyxqpwxf+vCV5FTnnv+dgHcHHeFTkRK3RvKLbjfaESDtRbP0qtjiYiUX5J3HLlTxVOhg34EO9XCGeU/CNdpcWO9sQInvPR7ovau0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbpte7vi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553D6C116D0;
	Sat, 28 Feb 2026 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300425;
	bh=Jb5ywi24OQ8pNIhxv/M9crNwVllSRmKpFUIzwjBM088=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qbpte7vid3xXwl2a8MkI7dIMHniVlAm2wJ/w9a2FiMBUJQAqpOAjLO9KnQXx0mnl3
	 f/6Z/FWwjAipp12BCQp+iD60rb+u7SmexP8d4K7TUAd7X0O9U0zQZaWUjDtY8hK+d0
	 mCJ2TLBql3G39wE6Qy7ZomCcrWMHkJOGw5seoYhnjFevgd3p8RHZ5zbg9KMXOFHfWi
	 Ig1gT5dZ+RqRwRTGDNh5IxLlabNmka8q7Ned7HgBOg5odpsGzTr8yzL+huitMFs0js
	 DnYJGjPndsi8XD6XD2QR29ONWGesLcjAwzuPavtyGlUyRVCo6W6OaXfAknx4Alx9LH
	 KjwpjeOHwr+7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 463/844] ovpn: tcp - fix packet extraction from stream
Date: Sat, 28 Feb 2026 12:26:16 -0500
Message-ID: <20260228173244.1509663-464-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220542-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:email,openvpn.net:email,mandelbit.com:email,davemloft.net:email]
X-Rspamd-Queue-Id: 4C97A1C821D
X-Rspamd-Action: no action

From: Ralf Lici <ralf@mandelbit.com>

[ Upstream commit d4f687fbbce45b5e88438e89b5e26c0c15847992 ]

When processing TCP stream data in ovpn_tcp_recv, we receive large
cloned skbs from __strp_rcv that may contain multiple coalesced packets.
The current implementation has two bugs:

1. Header offset overflow: Using pskb_pull with large offsets on
   coalesced skbs causes skb->data - skb->head to exceed the u16 storage
   of skb->network_header. This causes skb_reset_network_header to fail
   on the inner decapsulated packet, resulting in packet drops.

2. Unaligned protocol headers: Extracting packets from arbitrary
   positions within the coalesced TCP stream provides no alignment
   guarantees for the packet data causing performance penalties on
   architectures without efficient unaligned access. Additionally,
   openvpn's 2-byte length prefix on TCP packets causes the subsequent
   4-byte opcode and packet ID fields to be inherently misaligned.

Fix both issues by allocating a new skb for each openvpn packet and
using skb_copy_bits to extract only the packet content into the new
buffer, skipping the 2-byte length prefix. Also, check the length before
invoking the function that performs the allocation to avoid creating an
invalid skb.

If the packet has to be forwarded to userspace the 2-byte prefix can be
pushed to the head safely, without misalignment.

As a side effect, this approach also avoids the expensive linearization
that pskb_pull triggers on cloned skbs with page fragments. In testing,
this resulted in TCP throughput improvements of up to 74%.

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ovpn/tcp.c | 53 ++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index ec2bbc28c1966..5499c1572f3e2 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -70,37 +70,56 @@ static void ovpn_tcp_to_userspace(struct ovpn_peer *peer, struct sock *sk,
 	peer->tcp.sk_cb.sk_data_ready(sk);
 }
 
-static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
+static struct sk_buff *ovpn_tcp_skb_packet(const struct ovpn_peer *peer,
+					   struct sk_buff *orig_skb,
+					   const int pkt_len, const int pkt_off)
 {
-	struct ovpn_peer *peer = container_of(strp, struct ovpn_peer, tcp.strp);
-	struct strp_msg *msg = strp_msg(skb);
-	size_t pkt_len = msg->full_len - 2;
-	size_t off = msg->offset + 2;
-	u8 opcode;
+	struct sk_buff *ovpn_skb;
+	int err;
 
-	/* ensure skb->data points to the beginning of the openvpn packet */
-	if (!pskb_pull(skb, off)) {
-		net_warn_ratelimited("%s: packet too small for peer %u\n",
-				     netdev_name(peer->ovpn->dev), peer->id);
+	/* create a new skb with only the content of the current packet */
+	ovpn_skb = netdev_alloc_skb(peer->ovpn->dev, pkt_len);
+	if (unlikely(!ovpn_skb))
 		goto err;
-	}
 
-	/* strparser does not trim the skb for us, therefore we do it now */
-	if (pskb_trim(skb, pkt_len) != 0) {
-		net_warn_ratelimited("%s: trimming skb failed for peer %u\n",
+	skb_copy_header(ovpn_skb, orig_skb);
+	err = skb_copy_bits(orig_skb, pkt_off, skb_put(ovpn_skb, pkt_len),
+			    pkt_len);
+	if (unlikely(err)) {
+		net_warn_ratelimited("%s: skb_copy_bits failed for peer %u\n",
 				     netdev_name(peer->ovpn->dev), peer->id);
+		kfree_skb(ovpn_skb);
 		goto err;
 	}
 
-	/* we need the first 4 bytes of data to be accessible
+	consume_skb(orig_skb);
+	return ovpn_skb;
+err:
+	kfree_skb(orig_skb);
+	return NULL;
+}
+
+static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
+{
+	struct ovpn_peer *peer = container_of(strp, struct ovpn_peer, tcp.strp);
+	struct strp_msg *msg = strp_msg(skb);
+	int pkt_len = msg->full_len - 2;
+	u8 opcode;
+
+	/* we need at least 4 bytes of data in the packet
 	 * to extract the opcode and the key ID later on
 	 */
-	if (!pskb_may_pull(skb, OVPN_OPCODE_SIZE)) {
+	if (unlikely(pkt_len < OVPN_OPCODE_SIZE)) {
 		net_warn_ratelimited("%s: packet too small to fetch opcode for peer %u\n",
 				     netdev_name(peer->ovpn->dev), peer->id);
 		goto err;
 	}
 
+	/* extract the packet into a new skb */
+	skb = ovpn_tcp_skb_packet(peer, skb, pkt_len, msg->offset + 2);
+	if (unlikely(!skb))
+		goto err;
+
 	/* DATA_V2 packets are handled in kernel, the rest goes to user space */
 	opcode = ovpn_opcode_from_skb(skb, 0);
 	if (unlikely(opcode != OVPN_DATA_V2)) {
@@ -113,7 +132,7 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
 		/* The packet size header must be there when sending the packet
 		 * to userspace, therefore we put it back
 		 */
-		skb_push(skb, 2);
+		*(__be16 *)__skb_push(skb, sizeof(u16)) = htons(pkt_len);
 		ovpn_tcp_to_userspace(peer, strp->sk, skb);
 		return;
 	}
-- 
2.51.0


