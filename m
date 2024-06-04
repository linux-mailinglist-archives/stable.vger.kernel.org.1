Return-Path: <stable+bounces-47906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC34C8FAA3D
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 07:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F27DB20995
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 05:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73BB13D608;
	Tue,  4 Jun 2024 05:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="uJx/mT5m"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2E9199BC
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 05:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717480274; cv=none; b=G6drpZgCtNk+eGHkGONu2g+tp2iK63Vp6TgaNxsqfCYQ50SOIGZKChQkDQJEze1VaEz/5smKk0NxhS7TgvQIAumfxAur0E/KW8d6Dzp7llsEzoH3kiK63HFPqYXBkBxD+ikuTrMrCH8mpCgVyKj2jBgIIIofbRxcUdykLTp2VCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717480274; c=relaxed/simple;
	bh=uss0X1VN88HbrrQxklnUMnnojK0g+Phe6pPxPPeCyyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TW1fgd0hiBAyWMXcI07CACrXlpjZw9OR3MLKwfsNFMmeqAMwPIAqrOsWyNJVCw75oVmmqtnkhXgmiweCKXvW3GeGFDxoaG0JNktdABQhg+hgdNU/d31WhvJtvlNhYzsz0+RpY3NclJdo9dHd6HAtFe2D/5Y3bDe2qeJXr6IVDW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=uJx/mT5m; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 313113F2A7
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 05:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717480261;
	bh=bakozUuCaN+IM6untUm+580ISMXPQFrIaEMbe9vcbuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=uJx/mT5mkkPDvsgk/rXDnQy1AXbbQLcvc3pkyuzddOxPT5/LMJuTFePdfSip8k7Au
	 idjbtdbd7eGp1tNfIfPiGYIY+BqfDiQ9Ysix9RepqxmtBVyPbWRywecXaTxw/QEpr4
	 57rArkCsRrIJXCJo9r3k4kQdJ/plCFa7ZepNXOcP43d/qK3rZ7HiTOvzzHGUV9YG+r
	 OAQezpGmz2Yr9aM8BHmbWAr9QWDd8Y0iONndeehqvrMbPGneUZn5EixJVsngg16CMA
	 1nkFmnnni/rlrmdjtXWoNmeDY+ofEANjk7uPPo6FJZXVATqDpTKZ4MBMKvOlMGRA0Q
	 rQC286ac51BGw==
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-43fa039d2dbso50282061cf.2
        for <stable@vger.kernel.org>; Mon, 03 Jun 2024 22:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717480260; x=1718085060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bakozUuCaN+IM6untUm+580ISMXPQFrIaEMbe9vcbuo=;
        b=dbmFKxlZzi8PsTevjRCRZBgLnuPT+xCPmJUTvfUU1qd8o104n+G1K2lNLs9xofCq//
         vyeUsryIF/nSKa42Wd0UWeZv6FtQ9iJTyxPuEnYambTtLj09OB2bh3TeUgyicFDQxg6l
         ZFGk8U/NSSqc8hpVofUP/1bSt7ukPikeaPxDs6L355hd0RY4ONd5OJ13N514vUyCxJU/
         TIRI1iZPK4EmQ1g5wJX7DnLqzVFMI0c/f06OwNJpq/hYZADXeBPpaJLbWj75BhT72yYm
         dxRT1KOoBBwnxU5TKpdR9xkZYeEwgvdLv+GGWzbdkAJ4KdwSmC9NcflJ/H6N2XlJcdoN
         pUAA==
X-Forwarded-Encrypted: i=1; AJvYcCVxJjWWtkanKVT1Jt3jHyIlZTaQcDjga6+ACPjbQjSn7H2+wX2MOQbL8SySzM6OofuHsmgdFL/1q/zjxKYoztKTqBiXpXZs
X-Gm-Message-State: AOJu0YxI4g1SBJEgCXxYjAIbHhc9BiXGQjj2PZHnyXJ0k8wrGDgA7U8q
	37MU+mbDBLZwPTpZV88Pm4E0MsDPKAgeZR/8qaFljlHg4k2Z15sYaDUglD7J5xYyYqdMzT1R5OZ
	zCt0F1Z9VOYbRyHyfKI+K0UpJO4vn0QvCQTezMUSEp8+fL8nO76oLtPDj7q+kyR9dC0WRdA==
X-Received: by 2002:ac8:7d42:0:b0:43e:3b8e:670f with SMTP id d75a77b69052e-43ff549f297mr105319931cf.43.1717480260122;
        Mon, 03 Jun 2024 22:51:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNNMHj3DNemo6r8ze9mxeAlNiDseNl5q4JzhvkZ5jaG0w4QaVp8XWGaG9AL3DFRkMjFlevuQ==
X-Received: by 2002:ac8:7d42:0:b0:43e:3b8e:670f with SMTP id d75a77b69052e-43ff549f297mr105319801cf.43.1717480259672;
        Mon, 03 Jun 2024 22:50:59 -0700 (PDT)
Received: from localhost.localdomain ([2001:67c:1560:8007::aac:c40b])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff23a1aacsm46472871cf.12.2024.06.03.22.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 22:50:59 -0700 (PDT)
From: Chengen Du <chengen.du@canonical.com>
To: willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kaber@trash.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengen Du <chengen.du@canonical.com>,
	stable@vger.kernel.org
Subject: [PATCH v5] af_packet: Handle outgoing VLAN packets without hardware offloading
Date: Tue,  4 Jun 2024 13:48:23 +0800
Message-ID: <20240604054823.20649-1-chengen.du@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue initially stems from libpcap. The ethertype will be overwritten
as the VLAN TPID if the network interface lacks hardware VLAN offloading.
In the outbound packet path, if hardware VLAN offloading is unavailable,
the VLAN tag is inserted into the payload but then cleared from the sk_buff
struct. Consequently, this can lead to a false negative when checking for
the presence of a VLAN tag, causing the packet sniffing outcome to lack
VLAN tag information (i.e., TCI-TPID). As a result, the packet capturing
tool may be unable to parse packets as expected.

The TCI-TPID is missing because the prb_fill_vlan_info() function does not
modify the tp_vlan_tci/tp_vlan_tpid values, as the information is in the
payload and not in the sk_buff struct. The skb_vlan_tag_present() function
only checks vlan_all in the sk_buff struct. In cooked mode, the L2 header
is stripped, preventing the packet capturing tool from determining the
correct TCI-TPID value. Additionally, the protocol in SLL is incorrect,
which means the packet capturing tool cannot parse the L3 header correctly.

Link: https://github.com/the-tcpdump-group/libpcap/issues/1105
Link: https://lore.kernel.org/netdev/20240520070348.26725-1-chengen.du@canonical.com/T/#u
Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")
Cc: stable@vger.kernel.org
Signed-off-by: Chengen Du <chengen.du@canonical.com>
---
 net/packet/af_packet.c | 64 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index ea3ebc160e25..53d51ac87ac6 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -538,6 +538,52 @@ static void *packet_current_frame(struct packet_sock *po,
 	return packet_lookup_frame(po, rb, rb->head, status);
 }
 
+static u16 vlan_get_tci(struct sk_buff *skb)
+{
+	unsigned int vlan_depth = skb->mac_len;
+	struct vlan_hdr vhdr, *vh;
+	u8 *skb_head = skb->data;
+	int skb_len = skb->len;
+
+	if (vlan_depth) {
+		if (WARN_ON(vlan_depth < VLAN_HLEN))
+			return 0;
+		vlan_depth -= VLAN_HLEN;
+	} else {
+		vlan_depth = ETH_HLEN;
+	}
+
+	skb_push(skb, skb->data - skb_mac_header(skb));
+	vh = skb_header_pointer(skb, vlan_depth, sizeof(vhdr), &vhdr);
+	if (skb_head != skb->data) {
+		skb->data = skb_head;
+		skb->len = skb_len;
+	}
+	if (unlikely(!vh))
+		return 0;
+
+	return ntohs(vh->h_vlan_TCI);
+}
+
+static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
+{
+	__be16 proto = skb->protocol;
+
+	if (unlikely(eth_type_vlan(proto))) {
+		u8 *skb_head = skb->data;
+		int skb_len = skb->len;
+
+		skb_push(skb, skb->data - skb_mac_header(skb));
+		proto = __vlan_get_protocol(skb, proto, NULL);
+		if (skb_head != skb->data) {
+			skb->data = skb_head;
+			skb->len = skb_len;
+		}
+	}
+
+	return proto;
+}
+
 static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
 {
 	del_timer_sync(&pkc->retire_blk_timer);
@@ -1011,6 +1057,10 @@ static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
 		ppd->hv1.tp_vlan_tci = skb_vlan_tag_get(pkc->skb);
 		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->vlan_proto);
 		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+	} else if (unlikely(eth_type_vlan(pkc->skb->protocol))) {
+		ppd->hv1.tp_vlan_tci = vlan_get_tci(pkc->skb);
+		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
+		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 	} else {
 		ppd->hv1.tp_vlan_tci = 0;
 		ppd->hv1.tp_vlan_tpid = 0;
@@ -2428,6 +2478,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
 			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
 			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+		} else if (unlikely(eth_type_vlan(skb->protocol))) {
+			h.h2->tp_vlan_tci = vlan_get_tci(skb);
+			h.h2->tp_vlan_tpid = ntohs(skb->protocol);
+			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 		} else {
 			h.h2->tp_vlan_tci = 0;
 			h.h2->tp_vlan_tpid = 0;
@@ -2457,7 +2511,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
 	sll->sll_family = AF_PACKET;
 	sll->sll_hatype = dev->type;
-	sll->sll_protocol = skb->protocol;
+	sll->sll_protocol = (sk->sk_type == SOCK_DGRAM) ?
+		vlan_get_protocol_dgram(skb) : skb->protocol;
 	sll->sll_pkttype = skb->pkt_type;
 	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
@@ -3482,7 +3537,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		/* Original length was stored in sockaddr_ll fields */
 		origlen = PACKET_SKB_CB(skb)->sa.origlen;
 		sll->sll_family = AF_PACKET;
-		sll->sll_protocol = skb->protocol;
+		sll->sll_protocol = (sock->type == SOCK_DGRAM) ?
+			vlan_get_protocol_dgram(skb) : skb->protocol;
 	}
 
 	sock_recv_cmsgs(msg, sk, skb);
@@ -3539,6 +3595,10 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
 			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
 			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+		} else if (unlikely(eth_type_vlan(skb->protocol))) {
+			aux.tp_vlan_tci = vlan_get_tci(skb);
+			aux.tp_vlan_tpid = ntohs(skb->protocol);
+			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 		} else {
 			aux.tp_vlan_tci = 0;
 			aux.tp_vlan_tpid = 0;
-- 
2.43.0


