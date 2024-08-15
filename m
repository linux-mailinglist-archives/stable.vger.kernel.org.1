Return-Path: <stable+bounces-68976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695129534DA
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1461C23AB0
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA7D14AD0A;
	Thu, 15 Aug 2024 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n3DnuT4F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF0A1DFFB;
	Thu, 15 Aug 2024 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732267; cv=none; b=rAIbDUeUq8foyrDPl6DwRjPjzmcVf/h6B+qhJe0IetwFNvddmkNt+KPnRi9656J3d5C37vbTRUW7rJC78T2BgS92bvlJJjeVtMg8YDEuLdfcDs4Ta1kvcrsBv5CO1GYWgAm9YRdI0QfWKESOQYJWiBFrMS+5fNmYzSf039ra9ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732267; c=relaxed/simple;
	bh=Fe0NjUiE2LvQZFZfsnppW8P28SIRA2jVrCaQukjRvOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAJ9eHOXhFKKGhjiM5/csXGVmMSDgcDnpH4a+kVZhRyDJGoNLSLjk4wWzlHBfqySkC2Fen/eKQlKZiU01EZ/7lVLqzAArUe913yU0Ys33v9slrm4GsTj495x2AjEk1tRUAymSxEYOnEx1v2FapeUVIN51w4nuxeeM2U12rRoBD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n3DnuT4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D0FC32786;
	Thu, 15 Aug 2024 14:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723732267;
	bh=Fe0NjUiE2LvQZFZfsnppW8P28SIRA2jVrCaQukjRvOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n3DnuT4F2HvM6+m4/cHGe/YlBGQtbHiKITDmciIB7GhGe/jB6FNF0PYzEQZY/M89s
	 dqK60vNQkY9zzbkIbcTC6jF+ChToWvP7UPJy0CZR41qr0jHny7QvfOZ2GT/Pj2yT95
	 ITPf/febUaSNAyAhXlWLGKBzTy+AAUc6zZZOPOU0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chengen Du <chengen.du@canonical.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10 127/352] af_packet: Handle outgoing VLAN packets without hardware offloading
Date: Thu, 15 Aug 2024 15:23:13 +0200
Message-ID: <20240815131924.164364341@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131919.196120297@linuxfoundation.org>
References: <20240815131919.196120297@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengen Du <chengen.du@canonical.com>

commit 79eecf631c14e7f4057186570ac20e2cfac3802e upstream.

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
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20240713114735.62360-1-chengen.du@canonical.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/packet/af_packet.c |   86 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 2 deletions(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -503,6 +503,61 @@ static void *packet_current_frame(struct
 	return packet_lookup_frame(po, rb, rb->head, status);
 }
 
+static u16 vlan_get_tci(struct sk_buff *skb, struct net_device *dev)
+{
+	u8 *skb_orig_data = skb->data;
+	int skb_orig_len = skb->len;
+	struct vlan_hdr vhdr, *vh;
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
@@ -972,10 +1027,16 @@ static void prb_clear_rxhash(struct tpac
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
@@ -2390,6 +2451,10 @@ static int tpacket_rcv(struct sk_buff *s
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
@@ -2419,7 +2484,8 @@ static int tpacket_rcv(struct sk_buff *s
 	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
 	sll->sll_family = AF_PACKET;
 	sll->sll_hatype = dev->type;
-	sll->sll_protocol = skb->protocol;
+	sll->sll_protocol = (sk->sk_type == SOCK_DGRAM) ?
+		vlan_get_protocol_dgram(skb) : skb->protocol;
 	sll->sll_pkttype = skb->pkt_type;
 	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
@@ -3451,7 +3517,8 @@ static int packet_recvmsg(struct socket
 		/* Original length was stored in sockaddr_ll fields */
 		origlen = PACKET_SKB_CB(skb)->sa.origlen;
 		sll->sll_family = AF_PACKET;
-		sll->sll_protocol = skb->protocol;
+		sll->sll_protocol = (sock->type == SOCK_DGRAM) ?
+			vlan_get_protocol_dgram(skb) : skb->protocol;
 	}
 
 	sock_recv_ts_and_drops(msg, sk, skb);
@@ -3506,6 +3573,21 @@ static int packet_recvmsg(struct socket
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



