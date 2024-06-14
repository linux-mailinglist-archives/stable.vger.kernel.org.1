Return-Path: <stable+bounces-52196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B23D908C8C
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 15:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39DF31C2280D
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 13:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC7F19D8AF;
	Fri, 14 Jun 2024 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="f4k+PHYQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0867F4A11
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718372173; cv=none; b=VmNU2j7Epm0d/Wpq/jw0sHxZBKMcVOgu9afRB9oUd8wHIhXG1yJ7V4Nw7fV0nLDHen1aexyruFwI0Iru4oJUSrqraQfrwVsFYUWc1bJoMTc+/hrqa/HGjrCGgx1VpMj9krrpbdcERZWO+RT5nb1Elkfn/vL+U1rKNkupc0Ur6mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718372173; c=relaxed/simple;
	bh=0Fyw2oi0PJ4zgHdtg5qFlJ/sWYDmUatojKDZyeTNDfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i0+YTfLMpttlrH4EI9MSJJPrPhC/F75J+BHjQpjKNINEoqxaJz/GQZCpVW0OnZJXd2XYUrk8r4iy9x0X3mA8ZsaEDSFhxMa0pa85rCCsNL0IDBFbpKebXOSCdyQ0Yc4z7DUOQPt3wQANoqOy627kn5f3i8kxJUrY4GPsytjgtdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=f4k+PHYQ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 26A193FE5B
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 13:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718372167;
	bh=GK8h6NQNP7JzdpPbE6t/kIzMjg5w4wGbCy5qhXBbtjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=f4k+PHYQZAkfzFW/yI86pWfmERS7dAI9o/dG8wWwiAd8vHvZ86BHcEPtE+ujbtCCO
	 doHrSt7oKaKlOGck0OtpYJpv9DG9T4XjG6OTx7h09VYaSuwmGbwvNOixhsXmxWjEuI
	 ywahsuPSX4AxBqNcLY3I9cUaSdrRXv8xOIqIAMP2lX2p2GwBbA4k+o5a0ynxa7dD0S
	 FjY0V1MTFFKqeNfY6e97htZkrYJ78VYerWl6AQ3wBzODyM5zt1Fi/ezYn7WuFahD8V
	 D7glNCGiKcEXUHGsNG55+oel5Yz/hZuOI7sywf0t4NuWwXuDKb2AaOGmA7WwVRAVvP
	 BVEKmvCPMnHgQ==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c2fdad743bso1966928a91.1
        for <stable@vger.kernel.org>; Fri, 14 Jun 2024 06:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718372166; x=1718976966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GK8h6NQNP7JzdpPbE6t/kIzMjg5w4wGbCy5qhXBbtjs=;
        b=hF1ZNwwcLxU285tUVDffVMB2/8s16SA1l56+e08qnnQYUh34W+25egq2c9CIWrcXxl
         Wc9gxiioidiY5rT/46kVl2G6MRKculQlYuVkh9AyiFIalZ9XF1MH/dDMEQ6Hao4Hb8on
         Q7kzeyzBWxKZpY+P4dwmTN0sphyuQiUQkQWcrKfR3/AaQU24+RmM17LS+ATbwLYRV8Pb
         lfNHN9OWHExIHnbxDdKNDrTt0+wiU1FASwNiqQPDGxA7LrHfzHzvumNqrn7ZQIWEQTq3
         E2H2zxUVkSeg+bEvr/+y+pbuL+sX81SQCAjpkz5vVoxSWll7IpizK4XqRMK36pT9XF7+
         +41A==
X-Forwarded-Encrypted: i=1; AJvYcCVTwvZ0fB/5K1A7Pa9hpx38MyMT51XBK9s7AUyLliqmcRWZ+AqmxQj/SmEDGHsNB7KgT0Mrr+3a5zspASSIEA/GUx4fe5Uc
X-Gm-Message-State: AOJu0Yx0ng/AMYmTlH2U5K7uQzXau6JiQBPUtDExailTTtqY5jflRszF
	0T7QSRFfja3Wd9krI1Si0xtd0M2OZue6iH7BvQK9EawARl+9X4Y8PKzyE/nyvD9YUWtoGUOj8/0
	FrAhR93E+dfzS3EGlPZc+88/YkXi41SZz7gdSk5tg9ZqJDq58sWl/FFsqkJ9znngsehyoXQ==
X-Received: by 2002:a17:902:e5ca:b0:1f7:187f:cb5b with SMTP id d9443c01a7336-1f8629ff097mr30877785ad.64.1718372165636;
        Fri, 14 Jun 2024 06:36:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgXxr+ZAVTEDPn/8uyTdRs+Jdy4Cj8MeB1K4gxukHRaSi9BtLTR0vXvZ41Nu9N78xBvpKj/Q==
X-Received: by 2002:a17:902:e5ca:b0:1f7:187f:cb5b with SMTP id d9443c01a7336-1f8629ff097mr30877395ad.64.1718372165174;
        Fri, 14 Jun 2024 06:36:05 -0700 (PDT)
Received: from chengendu.. (2001-b011-381c-305c-a26c-f5ac-1961-dcaf.dynamic-ip6.hinet.net. [2001:b011:381c:305c:a26c:f5ac:1961:dcaf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f28fd8sm32000895ad.252.2024.06.14.06.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 06:36:04 -0700 (PDT)
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
Subject: [PATCH v7] af_packet: Handle outgoing VLAN packets without hardware offloading
Date: Fri, 14 Jun 2024 21:35:45 +0800
Message-ID: <20240614133545.85626-1-chengen.du@canonical.com>
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
 net/packet/af_packet.c | 93 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 2 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index ea3ebc160e25..41d6ebb38774 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -538,6 +538,69 @@ static void *packet_current_frame(struct packet_sock *po,
 	return packet_lookup_frame(po, rb, rb->head, status);
 }
 
+static u16 vlan_get_tci(struct sk_buff *skb, struct net_device *dev)
+{
+	struct vlan_hdr vhdr, *vh;
+	u8 *skb_orig_data = skb->data;
+	int skb_orig_len = skb->len;
+	unsigned int header_len;
+
+	if (!dev) {
+		if (!skb->dev)
+			return 0;
+		dev = skb->dev;
+	}
+
+	/* In the SOCK_DGRAM scenario, skb data starts at the network
+	 * protocol, which is after the VLAN headers. The outer VLAN
+	 * header is at the hard_header_len offset in non-variable
+	 * length link layer headers. If it's a VLAN device, the
+	 * min_header_len should be used to exclude the VLAN header
+	 * size.
+	 */
+	if (dev->min_header_len == dev->hard_header_len)
+		header_len = dev->hard_header_len;
+	else if (is_vlan_dev(dev))
+		header_len = dev->min_header_len;
+	else
+		return 0;
+
+	skb_push(skb, skb->data - skb_mac_header(skb));
+	vh = skb_header_pointer(skb, header_len, sizeof(vhdr), &vhdr);
+	if (skb_orig_data != skb->data) {
+		skb->data = skb_orig_data;
+		skb->len = skb_orig_len;
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
+		u8 *skb_orig_data = skb->data;
+		int skb_orig_len = skb->len;
+
+		/* In the SOCK_DGRAM scenario, skb data starts at the network
+		 * protocol, which is after the VLAN headers. The protocol must
+		 * point to the network protocol to accurately reflect the real
+		 * scenario.
+		 */
+		skb_push(skb, skb->data - skb_mac_header(skb));
+		proto = __vlan_get_protocol(skb, proto, NULL);
+		if (skb_orig_data != skb->data) {
+			skb->data = skb_orig_data;
+			skb->len = skb_orig_len;
+		}
+	}
+
+	return proto;
+}
+
 static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
 {
 	del_timer_sync(&pkc->retire_blk_timer);
@@ -1007,10 +1070,16 @@ static void prb_clear_rxhash(struct tpacket_kbdq_core *pkc,
 static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
 			struct tpacket3_hdr *ppd)
 {
+	struct packet_sock *po = container_of(pkc, struct packet_sock, rx_ring.prb_bdqc);
+
 	if (skb_vlan_tag_present(pkc->skb)) {
 		ppd->hv1.tp_vlan_tci = skb_vlan_tag_get(pkc->skb);
 		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->vlan_proto);
 		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+	} else if (unlikely(po->sk.sk_type == SOCK_DGRAM && eth_type_vlan(pkc->skb->protocol))) {
+		ppd->hv1.tp_vlan_tci = vlan_get_tci(pkc->skb, NULL);
+		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
+		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 	} else {
 		ppd->hv1.tp_vlan_tci = 0;
 		ppd->hv1.tp_vlan_tpid = 0;
@@ -2428,6 +2497,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
 			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
 			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+		} else if (unlikely(sk->sk_type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
+			h.h2->tp_vlan_tci = vlan_get_tci(skb, NULL);
+			h.h2->tp_vlan_tpid = ntohs(skb->protocol);
+			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 		} else {
 			h.h2->tp_vlan_tci = 0;
 			h.h2->tp_vlan_tpid = 0;
@@ -2457,7 +2530,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
 	sll->sll_family = AF_PACKET;
 	sll->sll_hatype = dev->type;
-	sll->sll_protocol = skb->protocol;
+	sll->sll_protocol = (sk->sk_type == SOCK_DGRAM) ?
+		vlan_get_protocol_dgram(skb) : skb->protocol;
 	sll->sll_pkttype = skb->pkt_type;
 	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
@@ -3482,7 +3556,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		/* Original length was stored in sockaddr_ll fields */
 		origlen = PACKET_SKB_CB(skb)->sa.origlen;
 		sll->sll_family = AF_PACKET;
-		sll->sll_protocol = skb->protocol;
+		sll->sll_protocol = (sock->type == SOCK_DGRAM) ?
+			vlan_get_protocol_dgram(skb) : skb->protocol;
 	}
 
 	sock_recv_cmsgs(msg, sk, skb);
@@ -3539,6 +3614,20 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
 			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
 			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+		} else if (unlikely(sock->type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
+			struct sockaddr_ll *sll = &PACKET_SKB_CB(skb)->sa.ll;
+			struct net_device *dev;
+
+			dev = dev_get_by_index(sock_net(sk), sll->sll_ifindex);
+			if (dev) {
+				aux.tp_vlan_tci = vlan_get_tci(skb, dev);
+				aux.tp_vlan_tpid = ntohs(skb->protocol);
+				aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+				dev_put(dev);
+			} else {
+				aux.tp_vlan_tci = 0;
+				aux.tp_vlan_tpid = 0;
+			}
 		} else {
 			aux.tp_vlan_tci = 0;
 			aux.tp_vlan_tpid = 0;
-- 
2.43.0


