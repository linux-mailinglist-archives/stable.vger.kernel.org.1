Return-Path: <stable+bounces-52596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1CC90BA8F
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 21:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C548B1C2302A
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 19:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2B0198E83;
	Mon, 17 Jun 2024 19:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YozlLf7m"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921CC364BE;
	Mon, 17 Jun 2024 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718651284; cv=none; b=ut2VgdpMTLolt/4w3nPE0vusVFyLtn5mrP4zlE+3/Dt5a9BQaVY7HYYOzdioJYkLq6EviGselXdurB8CfQ/3yzwhNtDTnChQpmeabf7iZveU4VhRDkE7FcWKT+qyGAfx67YZteCrsQu6pdMHaIqtszvCnxKhBVxyrJFCg2dFWf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718651284; c=relaxed/simple;
	bh=F7rPyK5AG73Q5gxMe9v27RKSWK+iTffH6tEkcyjLvuQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HPSn3BP8dUzLxsJ0n5XZjkOdm8tFZieEruxw2ChpX/kGYq/8os+9Obgw9bZrfqmK1hbWXjSpOjcXOUKGsprBNDZPtTmiRDsGoZZIok/NE6BVlGzG8RzHlWKaU/nDKfygnZvxFVH3dFMAYr37IRPEhsF2sb/ed3Dd9LGZawDELhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YozlLf7m; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-441187684e3so30399481cf.3;
        Mon, 17 Jun 2024 12:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718651281; x=1719256081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVmWjhI4LxI1RGpnFHROdhgzv6RHapEzTRQ8EdXC5mc=;
        b=YozlLf7m261jmYAShzed+5rwGUm9KNIfYLEpn6F3yqHrK8S5LBK9vkIJN26tTxAixa
         faPN+AiwFPVQKwbY9Dn/xjp8PE1gGKctTWS6xoAP0OmwEp5CvdgmoM+zxUea7+gQ/N9s
         hrgBHMocekmgdHr//eEi7nrWpJ6gpSyvcQVMIsDv3VR+SWodfb6ute8AzLBCQqG0/kUE
         M5h3f2PsKVVT4ezMAJcT35KsHuPvzRstZ9o5/cPxBMSGcDcD6qX4XYOPs/fDWszgYDA4
         vdHyFpKpPzFacgV0j4HmQsu+R9K04bF8CSozfGC6YKxB1oxLF1XKBJ7IkvEimFuiP//I
         a2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718651281; x=1719256081;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OVmWjhI4LxI1RGpnFHROdhgzv6RHapEzTRQ8EdXC5mc=;
        b=CFM6+gi7IXcCpzTW+XpbZw8kqeVRkZ1z/Q0XOJS3OBEqNIZuX0HqD+gniTk1H5pAl6
         wyWj7ZYYWcA/gK2j9eYwzzhe0tHvJFw5e03XkxzAYQDAtWkDNK6zPBWHJbgS4jMivt9a
         467Eer6hrp3qL9qI41zYqyLHjinjlHmYCvni0RXgMsIEYXCMvdlVv5vDK75w1ibrVmiQ
         Oc0hEN81e+16pzf2LS/XMPgVNhL8L5K3qNVBYcQh0Jv8zC1biMQ0MO7PDvb8URsxUX1W
         Xlj5ExghzdX6Pv3qb1Vk7hTbWjLbqKrXVdElC5PteaV6hClzQu2PyeBDDbdKDdjwAcDS
         r8Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWskjqU/z9P5y5Dhs/HDxbuMzcecKBTB6S7mxYZLfW/waFRX312v9DJDg8YTkuGqoFBPlWexl9EYy5C/1ZDwp1uiOBrP0BpfBZz2O7YJjd+xc47I7C2+35rE9C4Ryy7KO7LDZTb0HkOr9qJoHtyhzEujDjeaUZGLupd1OH8
X-Gm-Message-State: AOJu0YwgDPJerHWza0VQRGyG5wcrM23iSnhU71DF84nPBzcMnT4ACC+/
	6vpJJMMOAvjz392tlGvVEXte34ahqNTsMsYyXUFNggnNF6xqUXho
X-Google-Smtp-Source: AGHT+IGWJEYYbga0s24RJNsB+VnxGMhLe6eCDv2y7owLqb0oa/tteYV+YrLRdO3cDYzbtq06F8zBog==
X-Received: by 2002:a05:6214:4b85:b0:6b0:76f1:8639 with SMTP id 6a1803df08f44-6b2afd5a04amr108308886d6.42.1718651280272;
        Mon, 17 Jun 2024 12:08:00 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ed9075sm57794056d6.102.2024.06.17.12.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 12:07:58 -0700 (PDT)
Date: Mon, 17 Jun 2024 15:07:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>, 
 Chengen Du <chengen.du@canonical.com>
Cc: willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 kaber@trash.net, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <6670898e1ca78_21d16f2946f@willemb.c.googlers.com.notmuch>
In-Reply-To: <ZnAdiDjI_unrELB8@nanopsycho.orion>
References: <20240617054514.127961-1-chengen.du@canonical.com>
 <ZnAdiDjI_unrELB8@nanopsycho.orion>
Subject: Re: [PATCH v8] af_packet: Handle outgoing VLAN packets without
 hardware offloading
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jiri Pirko wrote:
> Mon, Jun 17, 2024 at 07:45:14AM CEST, chengen.du@canonical.com wrote:
> >The issue initially stems from libpcap. The ethertype will be overwritten
> >as the VLAN TPID if the network interface lacks hardware VLAN offloading.
> >In the outbound packet path, if hardware VLAN offloading is unavailable,
> >the VLAN tag is inserted into the payload but then cleared from the sk_buff
> >struct. Consequently, this can lead to a false negative when checking for
> >the presence of a VLAN tag, causing the packet sniffing outcome to lack
> >VLAN tag information (i.e., TCI-TPID). As a result, the packet capturing
> >tool may be unable to parse packets as expected.
> >
> >The TCI-TPID is missing because the prb_fill_vlan_info() function does not
> >modify the tp_vlan_tci/tp_vlan_tpid values, as the information is in the
> >payload and not in the sk_buff struct. The skb_vlan_tag_present() function
> >only checks vlan_all in the sk_buff struct. In cooked mode, the L2 header
> >is stripped, preventing the packet capturing tool from determining the
> >correct TCI-TPID value. Additionally, the protocol in SLL is incorrect,
> >which means the packet capturing tool cannot parse the L3 header correctly.
> >
> >Link: https://github.com/the-tcpdump-group/libpcap/issues/1105
> >Link: https://lore.kernel.org/netdev/20240520070348.26725-1-chengen.du@canonical.com/T/#u
> >Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")
> >Cc: stable@vger.kernel.org
> >Signed-off-by: Chengen Du <chengen.du@canonical.com>
> >---
> > net/packet/af_packet.c | 86 +++++++++++++++++++++++++++++++++++++++++-
> > 1 file changed, 84 insertions(+), 2 deletions(-)
> >
> >diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> >index ea3ebc160e25..84e8884a77e3 100644
> >--- a/net/packet/af_packet.c
> >+++ b/net/packet/af_packet.c
> >@@ -538,6 +538,61 @@ static void *packet_current_frame(struct packet_sock *po,
> > 	return packet_lookup_frame(po, rb, rb->head, status);
> > }
> > 
> >+static u16 vlan_get_tci(struct sk_buff *skb, struct net_device *dev)
> >+{
> >+	struct vlan_hdr vhdr, *vh;
> >+	u8 *skb_orig_data = skb->data;
> >+	int skb_orig_len = skb->len;
> >+	unsigned int header_len;
> >+
> >+	if (!dev)
> >+		return 0;
> >+
> >+	/* In the SOCK_DGRAM scenario, skb data starts at the network
> >+	 * protocol, which is after the VLAN headers. The outer VLAN
> >+	 * header is at the hard_header_len offset in non-variable
> >+	 * length link layer headers. If it's a VLAN device, the
> >+	 * min_header_len should be used to exclude the VLAN header
> >+	 * size.
> >+	 */
> >+	if (dev->min_header_len == dev->hard_header_len)
> >+		header_len = dev->hard_header_len;
> >+	else if (is_vlan_dev(dev))
> >+		header_len = dev->min_header_len;
> >+	else
> >+		return 0;
> >+
> >+	skb_push(skb, skb->data - skb_mac_header(skb));
> >+	vh = skb_header_pointer(skb, header_len, sizeof(vhdr), &vhdr);
> >+	if (skb_orig_data != skb->data) {
> >+		skb->data = skb_orig_data;
> >+		skb->len = skb_orig_len;
> >+	}
> >+	if (unlikely(!vh))
> >+		return 0;
> >+
> >+	return ntohs(vh->h_vlan_TCI);
> >+}
> >+
> >+static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
> >+{
> >+	__be16 proto = skb->protocol;
> >+
> >+	if (unlikely(eth_type_vlan(proto))) {
> >+		u8 *skb_orig_data = skb->data;
> >+		int skb_orig_len = skb->len;
> >+
> >+		skb_push(skb, skb->data - skb_mac_header(skb));
> >+		proto = __vlan_get_protocol(skb, proto, NULL);
> >+		if (skb_orig_data != skb->data) {
> >+			skb->data = skb_orig_data;
> >+			skb->len = skb_orig_len;
> >+		}
> >+	}
> >+
> >+	return proto;
> >+}
> >+
> > static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
> > {
> > 	del_timer_sync(&pkc->retire_blk_timer);
> >@@ -1007,10 +1062,16 @@ static void prb_clear_rxhash(struct tpacket_kbdq_core *pkc,
> > static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
> > 			struct tpacket3_hdr *ppd)
> > {
> >+	struct packet_sock *po = container_of(pkc, struct packet_sock, rx_ring.prb_bdqc);
> >+
> > 	if (skb_vlan_tag_present(pkc->skb)) {
> > 		ppd->hv1.tp_vlan_tci = skb_vlan_tag_get(pkc->skb);
> > 		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->vlan_proto);
> > 		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> >+	} else if (unlikely(po->sk.sk_type == SOCK_DGRAM && eth_type_vlan(pkc->skb->protocol))) {
> >+		ppd->hv1.tp_vlan_tci = vlan_get_tci(pkc->skb, pkc->skb->dev);
> >+		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
> >+		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> > 	} else {
> > 		ppd->hv1.tp_vlan_tci = 0;
> > 		ppd->hv1.tp_vlan_tpid = 0;
> >@@ -2428,6 +2489,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
> > 			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
> > 			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
> > 			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> >+		} else if (unlikely(sk->sk_type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
> >+			h.h2->tp_vlan_tci = vlan_get_tci(skb, skb->dev);
> >+			h.h2->tp_vlan_tpid = ntohs(skb->protocol);
> >+			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> > 		} else {
> > 			h.h2->tp_vlan_tci = 0;
> > 			h.h2->tp_vlan_tpid = 0;
> >@@ -2457,7 +2522,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
> > 	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
> > 	sll->sll_family = AF_PACKET;
> > 	sll->sll_hatype = dev->type;
> >-	sll->sll_protocol = skb->protocol;
> >+	sll->sll_protocol = (sk->sk_type == SOCK_DGRAM) ?
> >+		vlan_get_protocol_dgram(skb) : skb->protocol;
> > 	sll->sll_pkttype = skb->pkt_type;
> > 	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
> > 		sll->sll_ifindex = orig_dev->ifindex;
> >@@ -3482,7 +3548,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> > 		/* Original length was stored in sockaddr_ll fields */
> > 		origlen = PACKET_SKB_CB(skb)->sa.origlen;
> > 		sll->sll_family = AF_PACKET;
> >-		sll->sll_protocol = skb->protocol;
> >+		sll->sll_protocol = (sock->type == SOCK_DGRAM) ?
> >+			vlan_get_protocol_dgram(skb) : skb->protocol;
> > 	}
> > 
> > 	sock_recv_cmsgs(msg, sk, skb);
> >@@ -3539,6 +3606,21 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> > 			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
> > 			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
> > 			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> >+		} else if (unlikely(sock->type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
> 
> I don't understand why this would be needed here. We spent quite a bit
> of efford in the past to make sure vlan header is always stripped.
> Could you fix that in tx path to fulfill the expectation?

Doesn't that require NETIF_F_HW_VLAN_CTAG_TX?

I also wondered whether we should just convert the skb for this case
with skb_vlan_untag, to avoid needing new PF_PACKET logic to handle
unstripped tags in the packet socket code. But it seems equally
complex.

Aside from this conversation whether we need to support this
unstripped case at all, code LGTM.

