Return-Path: <stable+bounces-52284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42969097F2
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 13:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11F63B2190B
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 11:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861603C6BA;
	Sat, 15 Jun 2024 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkDsGc62"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA153B1BC;
	Sat, 15 Jun 2024 11:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718450962; cv=none; b=LDk9GppIK0tSVGmAUjQ1g9+UY8chD8psX9Nm58YaH2juuvjtXN2pWQO9jxS7ZSbciKvWpLBL6Nr47aeq004ICMkRDByBZm/8uS5a4LBoTxmF+Qtd7510uaOIRkB1RFG3ls4Y8SdhYsimi4X0+GtU5fuYH7JY5AsVRHUKm7s5lUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718450962; c=relaxed/simple;
	bh=OOycP8pGgZo75A9hfA/v9HuIRLG9Sscj8JavorVMaCo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HEBnDGZ+Mj2YOhDKPwOiD5ud/7pSlUyMzYbcvjNM88NKlTazkPzC4JOwXoGlzgGJ8bqduCyNnwwVWWfVD3PvzSh0NAzdn7IyWP/6gZeFUfHRyfiXXLU4PE/biBQoiZY77YWX14DD9q4+ww1pIZe5yMvdCtm0fjfKVo0WrAK4kDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkDsGc62; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2547e1c7bbeso1504058fac.2;
        Sat, 15 Jun 2024 04:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718450960; x=1719055760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXx0KpX82zwZVS6MNhXtQouPtEsUc8nuIJPaW3qSTf4=;
        b=fkDsGc62kTxn9ppRivl9KUy3RSmch6HnYHcrfxMS4t6povpNs/Vh/LfQIRoATmvoiC
         GuMX7U0wMNfaShRxBj39FpkOlj6oWiSiY8pWbvuogznzB2u6J3GB70WBf9J3K3bFwBlT
         mGf/Yr1k2rCPEEk76sPiDdtFR5JPhQea6ViJcmi7HOZpY3PXee5+KOMBS8PTU7PKftxo
         xUvjke0qv4E3VPLC41jj8L1LALX6p5nMYHpv5oapoNuOjTZmHIIaduU2wo51/qfwp/UQ
         9owl5cJ9781diRbpTShvaR2Kuj+DTrm6+oVso+eJoBf3aQmh5F7/D18EgTvz6qV3xndU
         Hqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718450960; x=1719055760;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OXx0KpX82zwZVS6MNhXtQouPtEsUc8nuIJPaW3qSTf4=;
        b=BB/F/eUmshM1uc9VXbQTkTJ8rJa3u6l66TPoHwr1HmkspkdthgpbgCa3KHvWXnGhyL
         +bDQY3pmxtwHDYsmjZJIVr02l0jkVvSXE63xVRI/nx3+PtAFCMN3h3l49HcAdodMKVHq
         IbwPfICe/DdEJ+SoPZbhWSaUfiDy5GG4o/Nx9q/gPEW1azqTN5Xej4XmghCG91oSpJh5
         vT3unHcEmtS6amJHYKgFXM8ijPXYwufUH3yPg1RlkeRGdnTI9cXLglth/YV5cb3zV10J
         oxiMy81NEH9DZmiMYpB2GA8OhWKhOaVMyIxGiG/gWCQifoZGQutP/0RzxG7CPKYmlaVj
         H+eA==
X-Forwarded-Encrypted: i=1; AJvYcCVkQWMf7/Fx2or8D6U/TeXMi9CYreH/pQcms5K73AAVId8KnpRJGQIxwwFXZoPzXUIH3+rI2JN0aY1mR2ZNrGEn+5lAtP4CnV9sBwfC/BhseCIFDLAzQEbay9IQn0NyyMGR6Z4QrRFvCGC7hwFoyY4wHKangY/+8M0MYwi1
X-Gm-Message-State: AOJu0YyZxpRtCIazTJsnB+mlJfS4aeOKCAtW32V4nAKjQHYEHgA3Jmyx
	UZlRQW4ow039EAFau903xTFUgM1PTM9BqEmCQ/hiGlGuvNdgrLm5
X-Google-Smtp-Source: AGHT+IHX9VUBD/zu9pao1lUpmqKtZ/Oc9LPJpyGp4Tx64OtAhmCP5J/yv5+WvFoW1sfrYex+qaB9pg==
X-Received: by 2002:a05:6870:a450:b0:254:76c6:bb20 with SMTP id 586e51a60fabf-25842b7b0ebmr5286952fac.51.1718450959582;
        Sat, 15 Jun 2024 04:29:19 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4421231c74fsm22973171cf.55.2024.06.15.04.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 04:29:18 -0700 (PDT)
Date: Sat, 15 Jun 2024 07:29:18 -0400
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
Message-ID: <666d7b0e61a46_1ba35a2944e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240614133545.85626-1-chengen.du@canonical.com>
References: <20240614133545.85626-1-chengen.du@canonical.com>
Subject: Re: [PATCH v7] af_packet: Handle outgoing VLAN packets without
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

Thanks for your patience working through these revisions.

> ---
>  net/packet/af_packet.c | 93 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 91 insertions(+), 2 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index ea3ebc160e25..41d6ebb38774 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -538,6 +538,69 @@ static void *packet_current_frame(struct packet_sock *po,
>  	return packet_lookup_frame(po, rb, rb->head, status);
>  }
>  
> +static u16 vlan_get_tci(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct vlan_hdr vhdr, *vh;
> +	u8 *skb_orig_data = skb->data;
> +	int skb_orig_len = skb->len;
> +	unsigned int header_len;
> +
> +	if (!dev) {
> +		if (!skb->dev)
> +			return 0;

Instead, pass pkc->skb->dev in the callers that now pass NULL.
> +		dev = skb->dev;
> +	}
> +
> +	/* In the SOCK_DGRAM scenario, skb data starts at the network
> +	 * protocol, which is after the VLAN headers. The outer VLAN
> +	 * header is at the hard_header_len offset in non-variable
> +	 * length link layer headers. If it's a VLAN device, the
> +	 * min_header_len should be used to exclude the VLAN header
> +	 * size.
> +	 */

This is a workaround around min_header_len not being correct for vlan
devices. I agree that this is the right approach.

I'll take a look at how to make min_header_len more reliably useful.
But separate from this fix, for net-next.

> +	if (dev->min_header_len == dev->hard_header_len)
> +		header_len = dev->hard_header_len;
> +	else if (is_vlan_dev(dev))
> +		header_len = dev->min_header_len;
> +	else
> +		return 0;
> +
> +	skb_push(skb, skb->data - skb_mac_header(skb));
> +	vh = skb_header_pointer(skb, header_len, sizeof(vhdr), &vhdr);
> +	if (skb_orig_data != skb->data) {
> +		skb->data = skb_orig_data;
> +		skb->len = skb_orig_len;
> +	}
> +	if (unlikely(!vh))
> +		return 0;
> +
> +	return ntohs(vh->h_vlan_TCI);
> +}
> +
> +static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
> +{
> +	__be16 proto = skb->protocol;
> +
> +	if (unlikely(eth_type_vlan(proto))) {
> +		u8 *skb_orig_data = skb->data;
> +		int skb_orig_len = skb->len;
> +
> +		/* In the SOCK_DGRAM scenario, skb data starts at the network
> +		 * protocol, which is after the VLAN headers. The protocol must
> +		 * point to the network protocol to accurately reflect the real
> +		 * scenario.
> +		 */

I don't understand the second sentence. The code is self explanatory.
Drop the whole comment?

> +		skb_push(skb, skb->data - skb_mac_header(skb));
> +		proto = __vlan_get_protocol(skb, proto, NULL);
> +		if (skb_orig_data != skb->data) {
> +			skb->data = skb_orig_data;
> +			skb->len = skb_orig_len;
> +		}
> +	}
> +
> +	return proto;
> +}
> +
>  static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
>  {
>  	del_timer_sync(&pkc->retire_blk_timer);
> @@ -1007,10 +1070,16 @@ static void prb_clear_rxhash(struct tpacket_kbdq_core *pkc,
>  static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
>  			struct tpacket3_hdr *ppd)
>  {
> +	struct packet_sock *po = container_of(pkc, struct packet_sock, rx_ring.prb_bdqc);
> +
>  	if (skb_vlan_tag_present(pkc->skb)) {
>  		ppd->hv1.tp_vlan_tci = skb_vlan_tag_get(pkc->skb);
>  		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->vlan_proto);
>  		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> +	} else if (unlikely(po->sk.sk_type == SOCK_DGRAM && eth_type_vlan(pkc->skb->protocol))) {
> +		ppd->hv1.tp_vlan_tci = vlan_get_tci(pkc->skb, NULL);
> +		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
> +		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>  	} else {
>  		ppd->hv1.tp_vlan_tci = 0;
>  		ppd->hv1.tp_vlan_tpid = 0;
> @@ -2428,6 +2497,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
>  			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
>  			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> +		} else if (unlikely(sk->sk_type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
> +			h.h2->tp_vlan_tci = vlan_get_tci(skb, NULL);
> +			h.h2->tp_vlan_tpid = ntohs(skb->protocol);
> +			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>  		} else {
>  			h.h2->tp_vlan_tci = 0;
>  			h.h2->tp_vlan_tpid = 0;
> @@ -2457,7 +2530,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
>  	sll->sll_family = AF_PACKET;
>  	sll->sll_hatype = dev->type;
> -	sll->sll_protocol = skb->protocol;
> +	sll->sll_protocol = (sk->sk_type == SOCK_DGRAM) ?
> +		vlan_get_protocol_dgram(skb) : skb->protocol;
>  	sll->sll_pkttype = skb->pkt_type;
>  	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
>  		sll->sll_ifindex = orig_dev->ifindex;
> @@ -3482,7 +3556,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  		/* Original length was stored in sockaddr_ll fields */
>  		origlen = PACKET_SKB_CB(skb)->sa.origlen;
>  		sll->sll_family = AF_PACKET;
> -		sll->sll_protocol = skb->protocol;
> +		sll->sll_protocol = (sock->type == SOCK_DGRAM) ?
> +			vlan_get_protocol_dgram(skb) : skb->protocol;
>  	}
>  
>  	sock_recv_cmsgs(msg, sk, skb);
> @@ -3539,6 +3614,20 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
>  			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
>  			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> +		} else if (unlikely(sock->type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
> +			struct sockaddr_ll *sll = &PACKET_SKB_CB(skb)->sa.ll;
> +			struct net_device *dev;
> +
> +			dev = dev_get_by_index(sock_net(sk), sll->sll_ifindex);

This complexity is unfortunate. But skb->dev is cleared in packet_rcv.

Use dev_get_by_index_rcu or netdev_get_by_index, per commment at
dev_get_by_index.

> +			if (dev) {
> +				aux.tp_vlan_tci = vlan_get_tci(skb, dev);
> +				aux.tp_vlan_tpid = ntohs(skb->protocol);
> +				aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> +				dev_put(dev);
> +			} else {
> +				aux.tp_vlan_tci = 0;
> +				aux.tp_vlan_tpid = 0;
> +			}
>  		} else {
>  			aux.tp_vlan_tci = 0;
>  			aux.tp_vlan_tpid = 0;
> -- 
> 2.43.0
> 



