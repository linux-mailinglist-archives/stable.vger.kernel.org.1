Return-Path: <stable+bounces-52344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6341390A36B
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 07:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0729C2829E3
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 05:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B3D17C9F6;
	Mon, 17 Jun 2024 05:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="BA9ak4RU"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07102F5B
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 05:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718603148; cv=none; b=E7IGszZd1V/0P6P9MfdrkTGhufamgl9BySXCTZhI7kdWtuz2un77c+ugnMhXzUmgiTjMftHQSgT4HFgfYGh6AXlScFXAcSWSox8lsNJGkonMupNISyw3CZ1x2aQjwoIz76vci7z+Zx033yPBMUt6sxttMpKRNoyMXiP9sRi0bWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718603148; c=relaxed/simple;
	bh=NlCD2N/GTA25z+Lv3QJ4ioPnzGqSDCz42FqtGeEExpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CFKwRHJfOtoIc1E7gSqcBSoD/A/AXOWvwoIiB0/b0ICxPVOs0AqtTLbe5sMHjVXUbN/qgrupLAG2JUp+S5SBdfZmOs+TXwoWB8HSifl55Pl2PD0ap67qtNh2+7DD1X4cj1Mp6fL2Vjcs49janQa0oBT2Y/Y5kVNinEtpMZ4f1ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=BA9ak4RU; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5427B3F1AF
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 05:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718603143;
	bh=KlZHJQ1gZb5CHVxW02hQaRdYCM2wgPQ+hnanLrc4+9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=BA9ak4RU6PILYFt8HuhfWCOyzGyuAtgMsxUSVYSDHR77I0xHWL7VMBBufAQbrtGSu
	 vUX+onSAde5EM8dCGceDsVdyv8yq7hI5j1mqu2Z7kQUvCTCEG4cTgOx55GkduhuxUO
	 ohfHW6ahvL00YPCyL7XHtx0jhsfUY9BtGdTcREGaNmbBXjA/1bjU/6FNGQrG3ZGhIX
	 sPT/gu8Z7umPoQdQ1TE31b9Q4m3xIOzeX7mEl41xR1ZO1M9KbPCiNncswzkltcHxs7
	 lZf1UTerYhFuB6XtYKgF2h7yOPX4Sl5iwVDcLj5l1gq5m4yVpUurdOPQNkjPXYY8cU
	 tdQPf6MWfDCog==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1f6828e8823so50970455ad.2
        for <stable@vger.kernel.org>; Sun, 16 Jun 2024 22:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718603141; x=1719207941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlZHJQ1gZb5CHVxW02hQaRdYCM2wgPQ+hnanLrc4+9g=;
        b=Q5pYyWqwnjrkrTZ7ElR9bjhvh6sa9WUhU9eDZL97fGYHW1ELePY6RpEypodvy6Nonn
         Q86NxU/W7jIr8VjxqTrJ9B3YcVIHicXdVAgNYvDltqf85J/nllkUcpZixbR/Ua855fCX
         t3Qb8x+TQk5jm4t15qT869SyZp7X2+mUHOqfUVsz3R8czGcOCnkqavufrbKCUwlSmMfZ
         O+ToL7Jd0er5IkmEgItzF8i865w6Nb+Dl4Gnf+GHlsrcA3JeTtwqqCdu8hdPqEiACEpt
         7VEOsyr00sFY4jqODvGyj5SzUfme7Gm8olqio097n35vRJfQm4YVaZqcTyRazd904LTB
         Y1fw==
X-Forwarded-Encrypted: i=1; AJvYcCU4ASc2m7MrcUpBKY98NL1mo2rppuFF92BHH8PNx00n1/smNulbXJ/rvNL1Wx4lVCBwonrLavI6ISwO2eX/yNg7CfPR+K3s
X-Gm-Message-State: AOJu0Yw2v6an+T5QT24AdMV7Oio4vYraDJvM8Z4IYsCjJOORaT3GaedF
	WpFdFFjrX2BKZxkfKlnkzJT/JVwjYg93EotrYq+tnvFGSbYpNzrAiqniiqk/4vtT152RDvIkHha
	AqxIrcUXwldqgi6U5DzvGM6DDqvfno4iMutLkDimjvtKMsv/12zXIDfBI8nrPzkPtGH/PPQ==
X-Received: by 2002:a17:902:6506:b0:1f6:5795:fb7 with SMTP id d9443c01a7336-1f8629006c9mr84026505ad.53.1718603141318;
        Sun, 16 Jun 2024 22:45:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IED2PoD+HvdyfQzEAqExpwcQoz1Qxbys6hm/1ofFX18g05jF+SSrxjpMLjXPjJLF/Zrx40ixw==
X-Received: by 2002:a17:902:6506:b0:1f6:5795:fb7 with SMTP id d9443c01a7336-1f8629006c9mr84026275ad.53.1718603140594;
        Sun, 16 Jun 2024 22:45:40 -0700 (PDT)
Received: from chengendu.. (2001-b011-381c-17ee-74a3-6d78-7091-fcb7.dynamic-ip6.hinet.net. [2001:b011:381c:17ee:74a3:6d78:7091:fcb7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f13562sm72605765ad.212.2024.06.16.22.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 22:45:40 -0700 (PDT)
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
Subject: [PATCH v8] af_packet: Handle outgoing VLAN packets without hardware offloading
Date: Mon, 17 Jun 2024 13:45:14 +0800
Message-ID: <20240617054514.127961-1-chengen.du@canonical.com>
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
 net/packet/af_packet.c | 86 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 2 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index ea3ebc160e25..84e8884a77e3 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -538,6 +538,61 @@ static void *packet_current_frame(struct packet_sock *po,
 	return packet_lookup_frame(po, rb, rb->head, status);
 }
 
+static u16 vlan_get_tci(struct sk_buff *skb, struct net_device *dev)
+{
+	struct vlan_hdr vhdr, *vh;
+	u8 *skb_orig_data = skb->data;
+	int skb_orig_len = skb->len;
+	unsigned int header_len;
+
+	if (!dev)
+		return 0;
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
@@ -1007,10 +1062,16 @@ static void prb_clear_rxhash(struct tpacket_kbdq_core *pkc,
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
+		ppd->hv1.tp_vlan_tci = vlan_get_tci(pkc->skb, pkc->skb->dev);
+		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
+		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 	} else {
 		ppd->hv1.tp_vlan_tci = 0;
 		ppd->hv1.tp_vlan_tpid = 0;
@@ -2428,6 +2489,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
 			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
 			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+		} else if (unlikely(sk->sk_type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
+			h.h2->tp_vlan_tci = vlan_get_tci(skb, skb->dev);
+			h.h2->tp_vlan_tpid = ntohs(skb->protocol);
+			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 		} else {
 			h.h2->tp_vlan_tci = 0;
 			h.h2->tp_vlan_tpid = 0;
@@ -2457,7 +2522,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
 	sll->sll_family = AF_PACKET;
 	sll->sll_hatype = dev->type;
-	sll->sll_protocol = skb->protocol;
+	sll->sll_protocol = (sk->sk_type == SOCK_DGRAM) ?
+		vlan_get_protocol_dgram(skb) : skb->protocol;
 	sll->sll_pkttype = skb->pkt_type;
 	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
@@ -3482,7 +3548,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		/* Original length was stored in sockaddr_ll fields */
 		origlen = PACKET_SKB_CB(skb)->sa.origlen;
 		sll->sll_family = AF_PACKET;
-		sll->sll_protocol = skb->protocol;
+		sll->sll_protocol = (sock->type == SOCK_DGRAM) ?
+			vlan_get_protocol_dgram(skb) : skb->protocol;
 	}
 
 	sock_recv_cmsgs(msg, sk, skb);
@@ -3539,6 +3606,21 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
 			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
 			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+		} else if (unlikely(sock->type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
+			struct sockaddr_ll *sll = &PACKET_SKB_CB(skb)->sa.ll;
+			struct net_device *dev;
+
+			rcu_read_lock();
+			dev = dev_get_by_index_rcu(sock_net(sk), sll->sll_ifindex);
+			if (dev) {
+				aux.tp_vlan_tci = vlan_get_tci(skb, dev);
+				aux.tp_vlan_tpid = ntohs(skb->protocol);
+				aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+			} else {
+				aux.tp_vlan_tci = 0;
+				aux.tp_vlan_tpid = 0;
+			}
+			rcu_read_unlock();
 		} else {
 			aux.tp_vlan_tci = 0;
 			aux.tp_vlan_tpid = 0;
-- 
2.43.0


