Return-Path: <stable+bounces-220532-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN0hCLE5o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220532-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:53:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 843121C65EB
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C39233435D5
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3F03CEAE5;
	Sat, 28 Feb 2026 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIW0VMyI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2C23CF399;
	Sat, 28 Feb 2026 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300415; cv=none; b=CddZrBmK6tXiTihe5vAtrjmqthMLf9q1IHvbjiDoOfHk+9G/hd1UWiL+Wor8VzYZ72ID83CEHEPJ+0ijN7lZqlVHCjXceb1INUUaTVDRz+B3YqJdcQQdshxNC//DTu42BPTkeG54wi++tEgdONHVY0T0unVajNGHpWCjHufbSMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300415; c=relaxed/simple;
	bh=eS5QHnOZ1NOzGEt+7Pljd+wWiRN60mY52EW9hpayvyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5nGw3AqkKvHgW8qHECJJa+RwgBi2/8Fel5JclugdGdzC0B17tbXsl97gTAATvBmjZl4Ya1y3/0eq3NOsGuXvv0RiXtRJy+55v6D3zMnQK4lV915hAU92gC/Mbc/iq2QUvvflYjuSzYIzeNnWQ5bp7ava5TP2t10HuhznikgFn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIW0VMyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0348C116D0;
	Sat, 28 Feb 2026 17:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300415;
	bh=eS5QHnOZ1NOzGEt+7Pljd+wWiRN60mY52EW9hpayvyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NIW0VMyIi84A4w6/tQ6U41EvhBvrxT4uo824jhPxoFkDqUrKvto3pWm/5bdBBWVI3
	 aRy3IpKARE/vUuyDE585Ys7CmelAqAt+WbCyrDtKqtJOoUx08dKnntuJ+aX6vwRd38
	 InN7Y/w0nV3KxjPgg1iX+lE9Sf/9CiBWWJ6FNMYUpJ0C0zjy+bVpc5z402H+CJgwe8
	 R+d5JM4iupOePGqO/MCUNSBh/LVGuD8LTNNDukNgvxpc6p9UHQ9/wD76swbWo+QpLe
	 eCZcvHztAuT1t8Vjnuau+SYtnhcGh1KYjgVWQbKsRpbCxNniiZC+/q6l7Tqe4GlXYu
	 Pv/fO87fiFqPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 453/844] psp: use sk->sk_hash in psp_write_headers()
Date: Sat, 28 Feb 2026 12:26:06 -0500
Message-ID: <20260228173244.1509663-454-sashal@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220532-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 843121C65EB
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit f891007ab1c77436950d10e09eae54507f1865ff ]

udp_flow_src_port() is indirectly using sk->sk_txhash as a base,
because __tcp_transmit_skb() uses skb_set_hash_from_sk().

This is problematic because this field can change over the
lifetime of a TCP flow, thanks to calls to sk_rethink_txhash().

Problem is that some NIC might (ab)use the PSP UDP source port in their
RSS computation, and PSP packets for a given flow could jump
from one queue to another.

In order to avoid surprises, it is safer to let Protective Load
Balancing (PLB) get its entropy from the IPv6 flowlabel,
and change psp_write_headers() to use sk->sk_hash which
does not change for the duration of the flow.

We might add a sysctl to select the behavior, if there
is a need for it.

Fixes: fc724515741a ("psp: provide encapsulation helper for drivers")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-By: Daniel Zahka <daniel.zahka@gmail.com>
Link: https://patch.msgid.link/20260218141337.999945-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/psp/psp_main.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index a8534124f6266..066222eb56c4a 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -166,9 +166,46 @@ static void psp_write_headers(struct net *net, struct sk_buff *skb, __be32 spi,
 {
 	struct udphdr *uh = udp_hdr(skb);
 	struct psphdr *psph = (struct psphdr *)(uh + 1);
+	const struct sock *sk = skb->sk;
 
 	uh->dest = htons(PSP_DEFAULT_UDP_PORT);
-	uh->source = udp_flow_src_port(net, skb, 0, 0, false);
+
+	/* A bit of theory: Selection of the source port.
+	 *
+	 * We need some entropy, so that multiple flows use different
+	 * source ports for better RSS spreading at the receiver.
+	 *
+	 * We also need that all packets belonging to one TCP flow
+	 * use the same source port through their duration,
+	 * so that all these packets land in the same receive queue.
+	 *
+	 * udp_flow_src_port() is using sk_txhash, inherited from
+	 * skb_set_hash_from_sk() call in __tcp_transmit_skb().
+	 * This field is subject to reshuffling, thanks to
+	 * sk_rethink_txhash() calls in various TCP functions.
+	 *
+	 * Instead, use sk->sk_hash which is constant through
+	 * the whole flow duration.
+	 */
+	if (likely(sk)) {
+		u32 hash = sk->sk_hash;
+		int min, max;
+
+		/* These operations are cheap, no need to cache the result
+		 * in another socket field.
+		 */
+		inet_get_local_port_range(net, &min, &max);
+		/* Since this is being sent on the wire obfuscate hash a bit
+		 * to minimize possibility that any useful information to an
+		 * attacker is leaked. Only upper 16 bits are relevant in the
+		 * computation for 16 bit port value because we use a
+		 * reciprocal divide.
+		 */
+		hash ^= hash << 16;
+		uh->source = htons((((u64)hash * (max - min)) >> 32) + min);
+	} else {
+		uh->source = udp_flow_src_port(net, skb, 0, 0, false);
+	}
 	uh->check = 0;
 	uh->len = htons(udp_len);
 
-- 
2.51.0


