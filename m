Return-Path: <stable+bounces-68678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50E6953378
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52EF7B2890F
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12681ABECE;
	Thu, 15 Aug 2024 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eOvZMHoC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F31E1EA80;
	Thu, 15 Aug 2024 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731322; cv=none; b=DKsnObtmUrT/ujEpyEi+IDu3j5/dKl6Csrm6OOMJm6MHlliIZf30idipCuXg+nnu4X/APKqz4Q5utnfbFmN7+TDs5eLqgOsrbET0LWRIjBMshYSBhQ6uSrop2n0zNcB7AIiY1Fwp6n3tRvo8GtqJmbmfspOkjxmb/GAKYp3Eobo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731322; c=relaxed/simple;
	bh=kqXCOTEWURsxMO7xGD07sclp9i2Ob5OM+JXLLZ+0RnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anfcZBL/alZaKPu+1OCu1jU/65Ot/87soUOJPJf7WdSrYF3hDjHY4LjQSs6pGhnITj55+qqYz4Whg/v1FMq/L1TGIfk3U+ozXablqJ4wDZVGlvvnVumYD3xeQE1AfEjXqloDxz5O1gP86nYh6uDYbf4I84EfUc4uW0OtyEe2WqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eOvZMHoC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CFCC4AF0C;
	Thu, 15 Aug 2024 14:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723731322;
	bh=kqXCOTEWURsxMO7xGD07sclp9i2Ob5OM+JXLLZ+0RnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eOvZMHoCCnBxGb/dJQJICThIwXN+Tfzppqba/58dr4+A/jZX+KhS8n/bM5LsvwzFf
	 mf82pEYQ00Vzx84rOM/rVA3Azuo8tHqcnibQygd1IASVI71uX6pgfOMoc5rQFeRdcX
	 Q3sCUH8UK122T/Du/tyq088RCNfHdtEbF/7UD40U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chengen Du <chengen.du@canonical.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.4 091/259] af_packet: Handle outgoing VLAN packets without hardware offloading
Date: Thu, 15 Aug 2024 15:23:44 +0200
Message-ID: <20240815131906.316916187@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131902.779125794@linuxfoundation.org>
References: <20240815131902.779125794@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -492,6 +492,61 @@ static void *packet_current_frame(struct
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
@@ -967,10 +1022,16 @@ static void prb_clear_rxhash(struct tpac
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
@@ -2364,6 +2425,10 @@ static int tpacket_rcv(struct sk_buff *s
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
@@ -2393,7 +2458,8 @@ static int tpacket_rcv(struct sk_buff *s
 	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
 	sll->sll_family = AF_PACKET;
 	sll->sll_hatype = dev->type;
-	sll->sll_protocol = skb->protocol;
+	sll->sll_protocol = (sk->sk_type == SOCK_DGRAM) ?
+		vlan_get_protocol_dgram(skb) : skb->protocol;
 	sll->sll_pkttype = skb->pkt_type;
 	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
@@ -3422,7 +3488,8 @@ static int packet_recvmsg(struct socket
 		/* Original length was stored in sockaddr_ll fields */
 		origlen = PACKET_SKB_CB(skb)->sa.origlen;
 		sll->sll_family = AF_PACKET;
-		sll->sll_protocol = skb->protocol;
+		sll->sll_protocol = (sock->type == SOCK_DGRAM) ?
+			vlan_get_protocol_dgram(skb) : skb->protocol;
 	}
 
 	sock_recv_ts_and_drops(msg, sk, skb);
@@ -3477,6 +3544,21 @@ static int packet_recvmsg(struct socket
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



