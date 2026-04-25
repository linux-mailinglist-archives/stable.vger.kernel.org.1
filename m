Return-Path: <stable+bounces-241121-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGsHCFaS7GkvaAAAu9opvQ
	(envelope-from <stable+bounces-241121-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 12:07:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E50E465D71
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 12:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15BA2300DF69
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 10:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71C030DD1B;
	Sat, 25 Apr 2026 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvTASLTx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B04381724
	for <stable@vger.kernel.org>; Sat, 25 Apr 2026 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777111634; cv=none; b=pFHk6vVPzXyD3SdXOvm6DAPXe/C6P287maR68BgO4m7H7YZjGEtV0skRpxCQkT051oioEfTTLR6r37QF38HfeJuxYGCKA9SKutNy7dAlYNYj39BW49shkrtoRJvOr1+I07vTSDZm2FDtgKeo6VFL28VmGqCNiNgRzFPcLR8bu/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777111634; c=relaxed/simple;
	bh=lTA+5PkLtisENRFGqOh/QZ55BpZVtqVKphv7zSYSevI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lcqk2QSV5XBcQf+xWett+LiflPYTc7bizYksVwpIO//vpL2QJLW+5loxOQHG4vAy9/LNZeAcVuKSKyMcShDN1h2Fr844I+GYNfvb1EpTNKQbPSm4ji/auP6Pj5PL6r/02OgIO7izg39E8vMGVGFm06Gx8SJPxyicZ3cRDegB3wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvTASLTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAB8C2BCB0;
	Sat, 25 Apr 2026 10:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777111634;
	bh=lTA+5PkLtisENRFGqOh/QZ55BpZVtqVKphv7zSYSevI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kvTASLTxkCsBUUrJ0/iztVjbXkBVi6J+08rwkkPO6by9uQO67lRFam+etxQqCmf6H
	 zN3NaTdeOeg4GCpc/gActI/rM8vJyQIZzLN/sJqjmbSR8WKxS9+kOUgYAxgepXx2iF
	 4XsUogbkM9mRlWGPIZPEBX7/VqVDOrpnEF++5osxrbnULRKScy0e9XhD9qYIHP06Np
	 i/9sM3YUTgb7uVKGFYAG3vQgcuisCHQ2rHdF2ZCDPc091vi/jQJpjV9A4+4OvM2gVW
	 zjL1nGOlW44CTjiEKXdID5A7VKnf6Mu+uI9zi7Jdw+YbqJH6vkZHlTBkLQd4LA5NQd
	 AaANb3KebpLOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bingquan Chen <patzilla007@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net/packet: fix TOCTOU race on mmap'd vnet_hdr in tpacket_snd()
Date: Sat, 25 Apr 2026 06:07:11 -0400
Message-ID: <20260425100711.3493958-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042434-salad-scope-84d1@gregkh>
References: <2026042434-salad-scope-84d1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7E50E465D71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241121-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]

From: Bingquan Chen <patzilla007@gmail.com>

[ Upstream commit 2c054e17d9d41f1020376806c7f750834ced4dc5 ]

In tpacket_snd(), when PACKET_VNET_HDR is enabled, vnet_hdr points
directly into the mmap'd TX ring buffer shared with userspace. The
kernel validates the header via __packet_snd_vnet_parse() but then
re-reads all fields later in virtio_net_hdr_to_skb(). A concurrent
userspace thread can modify the vnet_hdr fields between validation
and use, bypassing all safety checks.

The non-TPACKET path (packet_snd()) already correctly copies vnet_hdr
to a stack-local variable. All other vnet_hdr consumers in the kernel
(tun.c, tap.c, virtio_net.c) also use stack copies. The TPACKET TX
path is the only caller of virtio_net_hdr_to_skb() that reads directly
from user-controlled shared memory.

Fix this by copying vnet_hdr from the mmap'd ring buffer to a
stack-local variable before validation and use, consistent with the
approach used in packet_snd() and all other callers.

Fixes: 1d036d25e560 ("packet: tpacket_snd gso and checksum offload")
Signed-off-by: Bingquan Chen <patzilla007@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260418112006.78823-1-patzilla007@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ replaced `vnet_hdr_sz` with `sizeof(vnet_hdr)` and `if (vnet_hdr_sz)` with `if (po->has_vnet_hdr)` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/packet/af_packet.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 1c9b2d67c3ed4..1babbe7819e64 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2726,7 +2726,8 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 {
 	struct sk_buff *skb = NULL;
 	struct net_device *dev;
-	struct virtio_net_hdr *vnet_hdr = NULL;
+	struct virtio_net_hdr vnet_hdr;
+	bool has_vnet_hdr = false;
 	struct sockcm_cookie sockc;
 	__be16 proto;
 	int err, reserve = 0;
@@ -2826,16 +2827,20 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		hlen = LL_RESERVED_SPACE(dev);
 		tlen = dev->needed_tailroom;
 		if (po->has_vnet_hdr) {
-			vnet_hdr = data;
-			data += sizeof(*vnet_hdr);
-			tp_len -= sizeof(*vnet_hdr);
-			if (tp_len < 0 ||
-			    __packet_snd_vnet_parse(vnet_hdr, tp_len)) {
+			data += sizeof(vnet_hdr);
+			tp_len -= sizeof(vnet_hdr);
+			if (tp_len < 0) {
+				tp_len = -EINVAL;
+				goto tpacket_error;
+			}
+			memcpy(&vnet_hdr, data - sizeof(vnet_hdr), sizeof(vnet_hdr));
+			if (__packet_snd_vnet_parse(&vnet_hdr, tp_len)) {
 				tp_len = -EINVAL;
 				goto tpacket_error;
 			}
 			copylen = __virtio16_to_cpu(vio_le(),
-						    vnet_hdr->hdr_len);
+						    vnet_hdr.hdr_len);
+			has_vnet_hdr = true;
 		}
 		copylen = max_t(int, copylen, dev->hard_header_len);
 		skb = sock_alloc_send_skb(&po->sk,
@@ -2872,12 +2877,12 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			}
 		}
 
-		if (po->has_vnet_hdr) {
-			if (virtio_net_hdr_to_skb(skb, vnet_hdr, vio_le())) {
+		if (has_vnet_hdr) {
+			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le())) {
 				tp_len = -EINVAL;
 				goto tpacket_error;
 			}
-			virtio_net_hdr_set_proto(skb, vnet_hdr);
+			virtio_net_hdr_set_proto(skb, &vnet_hdr);
 		}
 
 		skb->destructor = tpacket_destruct_skb;
-- 
2.53.0


