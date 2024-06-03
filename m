Return-Path: <stable+bounces-47886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5958D8A24
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 21:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16931C23BE8
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 19:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A683A1386DF;
	Mon,  3 Jun 2024 19:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILJN3d+Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE840137923;
	Mon,  3 Jun 2024 19:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442850; cv=none; b=GJr6XVOjc1xme8CHjYg5WeJdwAiWphoSv2CDo77b3+HY7TX6yooSCYiMgGO4RkNXF9rGvzL8foAGG+SDJQtgZTY/sqP9z5+IxGN7zvjs0V9tHYbBHNLyH0AMG6hPymLHQNxza2bMaFki/mZdVFU5BfGVWfqRG4Qmv3q1rwdbnC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442850; c=relaxed/simple;
	bh=47uw8RWIbjUiHWJurauYJwd7gqPt4ef9pG1jD75prPk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=b0wUs8mB2LQMotVa4FhrDNBE16aCE0dlmUTrH99XlG63JTDIRzyySZUEX4BBwR/s8snlEPCvm5S+zJCdFNB7d2d/ZKgWmXHmuTltIZMVGE/Okx8AzqR7KAZRXf5jvS1aPfz4+EgqSvIb+8SaQI6fuU+OIA3NLNlS70wB5lVaUZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILJN3d+Z; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ae60725ea1so1916216d6.2;
        Mon, 03 Jun 2024 12:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717442848; x=1718047648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmTEdHXQ85Dl/tdaJHccb8Q46/nHFSNmwMi+k0konyI=;
        b=ILJN3d+ZI9zJ906p3auUkn9+GlLu9BeA2WQHJcTM+8z5gfE3O4vRlx8G2eepbPy1bi
         /4MOWLMY4K2qBSel8OW+Wc1IUn5d4pP7mhr3y6jNe3ucCVbtxfBUN0YfgWCzyTfItRbU
         zolP5cLYoWPu7v9PPhhvprXuyWmmTdn0CLp64C996eAL4QiS+WFnaO/r0gk0BZvPb6ag
         Y2XeCZKVwM88oBQ6KYHwbWyen0qzmec8gpHKfcIBhefKKoxXhN8yIKsQqzNhRuPN3jvf
         dnd5wFnopaiUlpIV5KBXvXB8oc+1q8I3gcBuchCBKS1AQA8uR8He9e2XskDZx+nihMGZ
         ubjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717442848; x=1718047648;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SmTEdHXQ85Dl/tdaJHccb8Q46/nHFSNmwMi+k0konyI=;
        b=wgkHEYkTiqT6qUV1cftQo+J0YhWLbup0fkIFnw51OEMqKR/gohkuu3bY15/K6KmA8E
         rFAl2f+Imuvm+8NW1WK/KaQcwCb4JyaiQXwUolru5qFYQf7KhO6BRSajMc//exOxcU4O
         rNyIxs2TMXG/wnjsQ8BO6UTSToOAky+gMNYRSx2g1rHRPCEb+xLk+lPYf7Y1UGykiOuY
         51gUzWOL+jEQHMJJH+VjStCYd17mOWOQlluU9zNYWoJaZtwUCkefvjDeGEMPi9D+ClFf
         fG/4X0zuK/dyyyjVU7X6SbZisz7Oum9rucWMcalbLvwpQnbKRRrEYuwt/v8ij7norQAn
         mT/w==
X-Forwarded-Encrypted: i=1; AJvYcCUOOKqmzZZgNEyu5WJOesMt0ofu23WXrQMx8q7hBO4EBtRJKVlS/UX2yoQFy6uKYfViX1FbgVJypHJsdtTucSsHqaHBhee6YHz4gn7VI8SeZ1IvPyJPgxBGFuvVi1CkotsaoAF/HlzLmWr8jZI2mP+PqmyCco3Cs+ru5k6d
X-Gm-Message-State: AOJu0YwyODvSUrkNWFvlUQehk5KmYrIPHXuhlx1WqkG94MUY+HrApUxu
	cnoQzDJOpCAxhjaMfeX6bIqmLLLCEX+5d4/W4wEKKB0wHE7KoHKG
X-Google-Smtp-Source: AGHT+IFt+zJ0mg3LTg11DS1JRh5fHggaZdCXXkW+lqhMsGm8HRoczVZZaGeJVxysxnzY+7lwlQy51A==
X-Received: by 2002:a05:6214:440b:b0:6af:518b:170e with SMTP id 6a1803df08f44-6af518b17a2mr59682676d6.33.1717442847600;
        Mon, 03 Jun 2024 12:27:27 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4b4179f4sm33246106d6.113.2024.06.03.12.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 12:27:26 -0700 (PDT)
Date: Mon, 03 Jun 2024 15:27:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Chengen Du <chengen.du@canonical.com>, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 kaber@trash.net, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Chengen Du <chengen.du@canonical.com>, 
 stable@vger.kernel.org
Message-ID: <665e191e62436_239903294b7@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240603034747.162184-1-chengen.du@canonical.com>
References: <20240603034747.162184-1-chengen.du@canonical.com>
Subject: Re: [PATCH v4] af_packet: Handle outgoing VLAN packets without
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

Chengen Du wrote:
> The issue initially stems from libpcap. The ethertype will be overwritten
> as the VLAN TPID if the network interface lacks hardware VLAN offloading.
> In the outbound packet path, if hardware VLAN offloading is unavailable,
> the VLAN tag is inserted into the payload but then cleared from the sk_buff
> struct. Consequently, this can lead to a false negative when checking for
> the presence of a VLAN tag, causing the packet sniffing outcome to lack
> VLAN tag information (i.e., TCI-TPID). As a result, the packet capturing
> tool may be unable to parse packets as expected.
> 
> The TCI-TPID is missing because the prb_fill_vlan_info() function does not
> modify the tp_vlan_tci/tp_vlan_tpid values, as the information is in the
> payload and not in the sk_buff struct. The skb_vlan_tag_present() function
> only checks vlan_all in the sk_buff struct. In cooked mode, the L2 header
> is stripped, preventing the packet capturing tool from determining the
> correct TCI-TPID value. Additionally, the protocol in SLL is incorrect,
> which means the packet capturing tool cannot parse the L3 header correctly.
> 
> Link: https://github.com/the-tcpdump-group/libpcap/issues/1105
> Link: https://lore.kernel.org/netdev/20240520070348.26725-1-chengen.du@canonical.com/T/#u
> Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengen Du <chengen.du@canonical.com>
> ---
>  net/packet/af_packet.c | 85 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 74 insertions(+), 11 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index ea3ebc160e25..21d34a12c11c 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -538,6 +538,62 @@ static void *packet_current_frame(struct packet_sock *po,
>  	return packet_lookup_frame(po, rb, rb->head, status);
>  }
>  
> +static int vlan_get_info(struct sk_buff *skb, u16 *tci, u16 *tpid)
> +{
> +	if (skb_vlan_tag_present(skb)) {
> +		*tci = skb_vlan_tag_get(skb);
> +		*tpid = ntohs(skb->vlan_proto);
> +	} else if (unlikely(eth_type_vlan(skb->protocol))) {
> +		unsigned int vlan_depth = skb->mac_len;
> +		struct vlan_hdr vhdr, *vh;
> +		u8 *skb_head = skb->data;
> +		int skb_len = skb->len;
> +
> +		if (vlan_depth) {
> +			if (WARN_ON(vlan_depth < VLAN_HLEN))
> +				return 0;
> +			vlan_depth -= VLAN_HLEN;
> +		} else {
> +			vlan_depth = ETH_HLEN;
> +		}
> +
> +		skb_push(skb, skb->data - skb_mac_header(skb));
> +		vh = skb_header_pointer(skb, vlan_depth, sizeof(vhdr), &vhdr);
> +		if (skb_head != skb->data) {
> +			skb->data = skb_head;
> +			skb->len = skb_len;
> +		}
> +		if (unlikely(!vh))
> +			return 0;

This duplicates much of __vlan_get_protocol.

With a wrapper to allow calling that while skb->data points at the
network header (as this is only SOCK_DGRAM) rather than the mac
header that it expects.

> +
> +		*tci = ntohs(vh->h_vlan_TCI);
> +		*tpid = ntohs(skb->protocol);
> +	} else {
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +
> +static __be16 sll_get_protocol(struct sk_buff *skb)
> +{
> +	__be16 proto = skb->protocol;
> +
> +	if (unlikely(eth_type_vlan(proto))) {
> +		u8 *skb_head = skb->data;
> +		int skb_len = skb->len;
> +
> +		skb_push(skb, skb->data - skb_mac_header(skb));
> +		proto = __vlan_get_protocol(skb, proto, NULL);
> +		if (skb_head != skb->data) {
> +			skb->data = skb_head;
> +			skb->len = skb_len;
> +		}

Then this does the same, but does call the function.

Is the difference that in the above you're trying to get the data only
out of the outer most vlan tag?

If so, can just call skb_header_pointer(skb, 0, sizeof(vhdr), &vhdr),
as skb->data is pointing to this tag.

As for sll_get_protocol, ideally we could just pass vlan_depth as an
extra parameter to __vlan_get_protocol. But that is too much churn. So
then you're approach of moving skb->data is indeed needed. Maybe call it
vlan_get_protocol_dgram or so. As that better describes the action.
> +	}
> +
> +	return proto;
> +}
> +
>  static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
>  {
>  	del_timer_sync(&pkc->retire_blk_timer);
> @@ -1007,9 +1063,11 @@ static void prb_clear_rxhash(struct tpacket_kbdq_core *pkc,
>  static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
>  			struct tpacket3_hdr *ppd)
>  {
> -	if (skb_vlan_tag_present(pkc->skb)) {
> -		ppd->hv1.tp_vlan_tci = skb_vlan_tag_get(pkc->skb);
> -		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->vlan_proto);
> +	u16 tci, tpid;
> +
> +	if (vlan_get_info(pkc->skb, &tci, &tpid)) {
> +		ppd->hv1.tp_vlan_tci = tci;
> +		ppd->hv1.tp_vlan_tpid = tpid;
>  		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;

Why change this from v3? I found the two separate cases more clear.

>  	} else {
>  		ppd->hv1.tp_vlan_tci = 0;
> @@ -2418,15 +2476,17 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  		hdrlen = sizeof(*h.h1);
>  		break;
>  	case TPACKET_V2:
> +		u16 tci, tpid;
> +
>  		h.h2->tp_len = skb->len;
>  		h.h2->tp_snaplen = snaplen;
>  		h.h2->tp_mac = macoff;
>  		h.h2->tp_net = netoff;
>  		h.h2->tp_sec = ts.tv_sec;
>  		h.h2->tp_nsec = ts.tv_nsec;
> -		if (skb_vlan_tag_present(skb)) {
> -			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
> -			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
> +		if (vlan_get_info(skb, &tci, &tpid)) {
> +			h.h2->tp_vlan_tci = tci;
> +			h.h2->tp_vlan_tpid = tpid;
>  			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>  		} else {
>  			h.h2->tp_vlan_tci = 0;
> @@ -2457,7 +2517,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
>  	sll->sll_family = AF_PACKET;
>  	sll->sll_hatype = dev->type;
> -	sll->sll_protocol = skb->protocol;
> +	sll->sll_protocol = (sk->sk_type == SOCK_DGRAM) ?
> +		sll_get_protocol(skb) : skb->protocol;
>  	sll->sll_pkttype = skb->pkt_type;
>  	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
>  		sll->sll_ifindex = orig_dev->ifindex;
> @@ -3482,7 +3543,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  		/* Original length was stored in sockaddr_ll fields */
>  		origlen = PACKET_SKB_CB(skb)->sa.origlen;
>  		sll->sll_family = AF_PACKET;
> -		sll->sll_protocol = skb->protocol;
> +		sll->sll_protocol = (sock->type == SOCK_DGRAM) ?
> +			sll_get_protocol(skb) : skb->protocol;
>  	}
>  
>  	sock_recv_cmsgs(msg, sk, skb);
> @@ -3521,6 +3583,7 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  
>  	if (packet_sock_flag(pkt_sk(sk), PACKET_SOCK_AUXDATA)) {
>  		struct tpacket_auxdata aux;
> +		u16 tci, tpid;
>  
>  		aux.tp_status = TP_STATUS_USER;
>  		if (skb->ip_summed == CHECKSUM_PARTIAL)
> @@ -3535,9 +3598,9 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  		aux.tp_snaplen = skb->len;
>  		aux.tp_mac = 0;
>  		aux.tp_net = skb_network_offset(skb);
> -		if (skb_vlan_tag_present(skb)) {
> -			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
> -			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
> +		if (vlan_get_info(skb, &tci, &tpid)) {
> +			aux.tp_vlan_tci = tci;
> +			aux.tp_vlan_tpid = tpid;
>  			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>  		} else {
>  			aux.tp_vlan_tci = 0;
> -- 
> 2.43.0
> 



