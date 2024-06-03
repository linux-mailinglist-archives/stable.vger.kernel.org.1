Return-Path: <stable+bounces-47841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAFA8D7A85
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 05:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663DF1C20D4D
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 03:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91FCEAD7;
	Mon,  3 Jun 2024 03:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="WJr7ufkd"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E7019F
	for <stable@vger.kernel.org>; Mon,  3 Jun 2024 03:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717386494; cv=none; b=t70OdlrXu4F2jF9E1thYNt4lyarOEhXTtLdU3gyzM4WSIfom4YtKMqsSkZ5tbiUwsLDRPAAc0JGRLf8NLT9ZYtjFacqbA3TrGXpJ3hr3Nty7W3NtKA5mBsgprZE7+8Bj7eOravkVwXKaVn34EyZC5emt4dHhFT+sdi/KwRYwDzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717386494; c=relaxed/simple;
	bh=V6no+JOxFu6hE8CwBog5PLmk8xjOFmUBL9bYvY1meQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ghj3Ct5rF1DCerwAxXsnKEDiB6Ra89RvFj8U5hT7+St5GDpbgLm5Vtbp5Nvw9wGGT6VTHbq5wDO/Lw4X0+t+qQDGWCrTIbvlWnsV1N54GmQkymKo5tuRjDqqb0XznH7xwMtbQul/qYUfl49wbAV78iOXIn+d6QnUVsQi002JYmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=WJr7ufkd; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5CF4B3F6FD
	for <stable@vger.kernel.org>; Mon,  3 Jun 2024 03:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717386483;
	bh=QujbI3ub2leVIzffl99klAg4JkTbEBolhsx9zKs28ys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=WJr7ufkdJ0F3PySe02PkF6Vskg1EmltDPlTor8xZoH/XUsMf9yrE16gkVJ9ZRJ/Cw
	 rihNmIRup1wo1fnevaLuSH/bbrzYsv+NcoyHDbZR9JzWsOua/WQvyk1qBNsk4Q28j2
	 ne8EEs+lTqcom3w93eqckTuSxiGmTxnuk8+8vgdNbYCNG22+c3fIKurYS9oS8mOGTl
	 /wpgFnpv3l43uOBLrVCWDaJnD9I786A32ecdnd8UTD0RNKRvVDLCOcixDKlEBdUYc5
	 2W42xIHJzmyOI/S3Zu5hSHXF03f8MXxlbX43FODR14knf+1RRCuWumB4BG7hH6GBz7
	 vuSZMov0gXubw==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1f302bf0c29so24441255ad.0
        for <stable@vger.kernel.org>; Sun, 02 Jun 2024 20:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717386482; x=1717991282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QujbI3ub2leVIzffl99klAg4JkTbEBolhsx9zKs28ys=;
        b=Dfk7tTqdwhjPVIqkVgLE1Sc/BYIt+U0Ez6VYescHsjhR16mv3h5nAe8hUelVXQHQxI
         WYTSIseFFNOTXHw7Yw8ITI10w16lYJXr8rv8L4mvskZn/LV/G2R0EiHtIiSur8TTl1/7
         IQoRXFHc6/c8Nn9zUBkAOiX7CNN/DrWZBS10FwiNpdBD0GYwcxaJgae/h2T/LbnIKH4h
         0WFZdgy/2BsYadac7+huG1sncM4/8r2dbxqSziwXAufswNLRIFxkH3IHoisDMiPm2ZQH
         U8itRTZyF8lcfDdG6EHbfcfMDDg4yroIun9ihPpnURLHZ4kNpSpSowYibsDn4fQl4PuO
         o+9A==
X-Forwarded-Encrypted: i=1; AJvYcCWx7K88xuu25Z0xYqbD1EIkF/kM1ApHrqh9KwP5f7mRL5uySQbggBu4RjeRWCcKgeKh+X5MGjfRfZce5At6kLPg6Xi8mwJ3
X-Gm-Message-State: AOJu0Yyi5Hq5NpDbXDG6B96qRSIlwsXNczNkPEqyiZ+3C8ZHT8iQHdAt
	gD8LbGvaoiXs2TCC3AGdfFApV4KZSnPJRZ7+01O20X1yIEuO7N1xQBUHKhy0d9LzUPMMwLQvOoZ
	8YXCS9VczTAHYS5FivJ09OMCVJYwXpbsdxB1Oty2WjZhTnrRi+MueyPqkSetKr+gs2LbhTQ==
X-Received: by 2002:a17:902:d54e:b0:1f4:a026:4888 with SMTP id d9443c01a7336-1f636ff7814mr90804725ad.21.1717386481808;
        Sun, 02 Jun 2024 20:48:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfJQFLZDpG5uBNaJv5PjCSJ7asQ2yxOqR65veCtG/Uc/9OU8yeD1QY7UbGYQzZCk7ImLvv3g==
X-Received: by 2002:a17:902:d54e:b0:1f4:a026:4888 with SMTP id d9443c01a7336-1f636ff7814mr90804565ad.21.1717386481339;
        Sun, 02 Jun 2024 20:48:01 -0700 (PDT)
Received: from chengendu.. (2001-b011-381c-35f0-9186-e9dd-98e7-04cc.dynamic-ip6.hinet.net. [2001:b011:381c:35f0:9186:e9dd:98e7:4cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323e181csm54120975ad.178.2024.06.02.20.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 20:48:00 -0700 (PDT)
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
Subject: [PATCH v4] af_packet: Handle outgoing VLAN packets without hardware offloading
Date: Mon,  3 Jun 2024 11:47:47 +0800
Message-ID: <20240603034747.162184-1-chengen.du@canonical.com>
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
 net/packet/af_packet.c | 85 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 11 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index ea3ebc160e25..21d34a12c11c 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -538,6 +538,62 @@ static void *packet_current_frame(struct packet_sock *po,
 	return packet_lookup_frame(po, rb, rb->head, status);
 }
 
+static int vlan_get_info(struct sk_buff *skb, u16 *tci, u16 *tpid)
+{
+	if (skb_vlan_tag_present(skb)) {
+		*tci = skb_vlan_tag_get(skb);
+		*tpid = ntohs(skb->vlan_proto);
+	} else if (unlikely(eth_type_vlan(skb->protocol))) {
+		unsigned int vlan_depth = skb->mac_len;
+		struct vlan_hdr vhdr, *vh;
+		u8 *skb_head = skb->data;
+		int skb_len = skb->len;
+
+		if (vlan_depth) {
+			if (WARN_ON(vlan_depth < VLAN_HLEN))
+				return 0;
+			vlan_depth -= VLAN_HLEN;
+		} else {
+			vlan_depth = ETH_HLEN;
+		}
+
+		skb_push(skb, skb->data - skb_mac_header(skb));
+		vh = skb_header_pointer(skb, vlan_depth, sizeof(vhdr), &vhdr);
+		if (skb_head != skb->data) {
+			skb->data = skb_head;
+			skb->len = skb_len;
+		}
+		if (unlikely(!vh))
+			return 0;
+
+		*tci = ntohs(vh->h_vlan_TCI);
+		*tpid = ntohs(skb->protocol);
+	} else {
+		return 0;
+	}
+
+	return 1;
+}
+
+static __be16 sll_get_protocol(struct sk_buff *skb)
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
@@ -1007,9 +1063,11 @@ static void prb_clear_rxhash(struct tpacket_kbdq_core *pkc,
 static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
 			struct tpacket3_hdr *ppd)
 {
-	if (skb_vlan_tag_present(pkc->skb)) {
-		ppd->hv1.tp_vlan_tci = skb_vlan_tag_get(pkc->skb);
-		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->vlan_proto);
+	u16 tci, tpid;
+
+	if (vlan_get_info(pkc->skb, &tci, &tpid)) {
+		ppd->hv1.tp_vlan_tci = tci;
+		ppd->hv1.tp_vlan_tpid = tpid;
 		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 	} else {
 		ppd->hv1.tp_vlan_tci = 0;
@@ -2418,15 +2476,17 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 		hdrlen = sizeof(*h.h1);
 		break;
 	case TPACKET_V2:
+		u16 tci, tpid;
+
 		h.h2->tp_len = skb->len;
 		h.h2->tp_snaplen = snaplen;
 		h.h2->tp_mac = macoff;
 		h.h2->tp_net = netoff;
 		h.h2->tp_sec = ts.tv_sec;
 		h.h2->tp_nsec = ts.tv_nsec;
-		if (skb_vlan_tag_present(skb)) {
-			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
-			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
+		if (vlan_get_info(skb, &tci, &tpid)) {
+			h.h2->tp_vlan_tci = tci;
+			h.h2->tp_vlan_tpid = tpid;
 			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 		} else {
 			h.h2->tp_vlan_tci = 0;
@@ -2457,7 +2517,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
 	sll->sll_family = AF_PACKET;
 	sll->sll_hatype = dev->type;
-	sll->sll_protocol = skb->protocol;
+	sll->sll_protocol = (sk->sk_type == SOCK_DGRAM) ?
+		sll_get_protocol(skb) : skb->protocol;
 	sll->sll_pkttype = skb->pkt_type;
 	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
@@ -3482,7 +3543,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		/* Original length was stored in sockaddr_ll fields */
 		origlen = PACKET_SKB_CB(skb)->sa.origlen;
 		sll->sll_family = AF_PACKET;
-		sll->sll_protocol = skb->protocol;
+		sll->sll_protocol = (sock->type == SOCK_DGRAM) ?
+			sll_get_protocol(skb) : skb->protocol;
 	}
 
 	sock_recv_cmsgs(msg, sk, skb);
@@ -3521,6 +3583,7 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	if (packet_sock_flag(pkt_sk(sk), PACKET_SOCK_AUXDATA)) {
 		struct tpacket_auxdata aux;
+		u16 tci, tpid;
 
 		aux.tp_status = TP_STATUS_USER;
 		if (skb->ip_summed == CHECKSUM_PARTIAL)
@@ -3535,9 +3598,9 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		aux.tp_snaplen = skb->len;
 		aux.tp_mac = 0;
 		aux.tp_net = skb_network_offset(skb);
-		if (skb_vlan_tag_present(skb)) {
-			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
-			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
+		if (vlan_get_info(skb, &tci, &tpid)) {
+			aux.tp_vlan_tci = tci;
+			aux.tp_vlan_tpid = tpid;
 			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 		} else {
 			aux.tp_vlan_tci = 0;
-- 
2.43.0


