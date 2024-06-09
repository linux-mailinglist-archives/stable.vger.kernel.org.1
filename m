Return-Path: <stable+bounces-50059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 001BA90181A
	for <lists+stable@lfdr.de>; Sun,  9 Jun 2024 22:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FBA11F21310
	for <lists+stable@lfdr.de>; Sun,  9 Jun 2024 20:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E6346441;
	Sun,  9 Jun 2024 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hk6kYI1j"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D171F16B;
	Sun,  9 Jun 2024 20:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717964353; cv=none; b=jx64texTlRvpz3kx5j2nogj6VOOR0P6K+9V7Fw6VTq/HJgv72LHSx/dGbiVdAm2psadREZVkmFg2U6m+x6VZN0Sjf4AvBL4OVnC2wayn842VKHbX0R2uAB3IrczJSiUteVsW3AYfQMoG55h2Pt4qIfgoMb6vp3QVLzzhRifd1kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717964353; c=relaxed/simple;
	bh=pDlWY+0x8r0nKGg7b2/isycRPbVqI8+Y6j8MAkGX6oQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RfykNvJp8IQ5S5eCHDXezGjLQ7Qfq9oV99uD/WKIes/y6jY5pl3WB3vhsC/LZTgq3Uu5o/5AZ5H2ppjA9M2uYijrlAz9HCu6pxvwVoJoaR2+W3chDfuW/rvX6wDbkGlPXcpWZAn8tD8qM1kXEqnpe61wfg9m9Lmx7lMq37NI0LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hk6kYI1j; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b07937b84fso2325956d6.1;
        Sun, 09 Jun 2024 13:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717964350; x=1718569150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQu/J0EQdDwCOiq4hfX8MY6A4cg2WM9qgfGjrJmeBwI=;
        b=Hk6kYI1jVQyo6lWuaEGzkP//myFsIDLnEXmtxfu7UbaCcDVHbmOgpwdpwV4atGgh8p
         WITWn8UHzSkAL9WMDsn+0uZjSz4zrgomwOGKXY0UQvN5jNm/YoRqgqrnY9LRMK6uoUEW
         DYM9oQLyaMY3yEt0n8pWsfEmmnaFQrd4OL9eZSObtZsMhPpx+/V7BwyJpv56YLuMdkZS
         teyLGH/ARE4e2++FjGaw8juycpX2au7obZkz7ImL8BOMGnm8VfFDSO8w8cmsR8pPh0uZ
         ttHDEyp35ikX0lDyvm0FaZgWPVEnIayIHXNv1uSFHvcSFrYmqlCoIdmTwqpPLhv3vJaZ
         HGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717964350; x=1718569150;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nQu/J0EQdDwCOiq4hfX8MY6A4cg2WM9qgfGjrJmeBwI=;
        b=EDbUoqNzV/tBamH/DuQvx19K6KMEM/kpJPCE7j0OgaeSjx3Xjr3FmgGnTjW8BioffK
         oKcqUIAtHD5hcKkBjrFhY2rmxHJSy7xTiayjCuPMYF6vsyWbQmnPN4BbSAxv70qHpmUK
         fG0XLW+WuhqHbAp+p/Bn27EPD0AhSnwyQGpPRm82JaZPkwHuMXSBUuSE1q3DCa4e2swi
         1rGo4fYEi2qw981uH/PmL6QNcqLArWmDaX4bsn1i4YC3KBGX9Bs/x2qHEfUoOl1CXHRM
         vuk6PNZbSisFFlbk9TJx2THAi+xtzVt9Mv6qH8jFus+/uRC4n/KzFkEItnSZQ8ZJYGpj
         DP+g==
X-Forwarded-Encrypted: i=1; AJvYcCURvAtbjQXXb0NyAoTz6k4oTVfGGOYwwyNHwF3y8JD8PsDSZx1Dxp5YhXKuogG9vzxnkA0xzDH5GVy+3WGUgKT1ccgRdEmQ96JQCMxu13XggM2ZFdlyftn3M0Oyj6UkJ+7g3YHJCk4tZVn3bkbgg2srOnN4uxQcBIPOwhvT
X-Gm-Message-State: AOJu0YyMCn3axuxh7yipqBsgvYYeDwG/TvksGzbFb1VRONSf1FdFonVt
	DZsWkc5N5s5Ga93lvUsHe0VWD83+78RRi7sh58oLo+Vd6XtrDv36
X-Google-Smtp-Source: AGHT+IGuN4nXoTpm5MUf0+GL8+JBq6ragPXx5/cWHOmzzS9NAw/CwG49iiVjm60ubk9Q7jnmsw45xA==
X-Received: by 2002:a05:6214:5d8a:b0:6b0:7e89:f4dd with SMTP id 6a1803df08f44-6b07e89f70amr10869446d6.36.1717964350118;
        Sun, 09 Jun 2024 13:19:10 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b0793772e3sm7106026d6.107.2024.06.09.13.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 13:19:09 -0700 (PDT)
Date: Sun, 09 Jun 2024 16:19:08 -0400
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
Message-ID: <66660e3cd5636_8dbbb294c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240608025347.90680-1-chengen.du@canonical.com>
References: <20240608025347.90680-1-chengen.du@canonical.com>
Subject: Re: [PATCH v6] af_packet: Handle outgoing VLAN packets without
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

Overall, solid.

> ---
>  net/packet/af_packet.c | 57 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index ea3ebc160e25..8cffbe1f912d 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -538,6 +538,43 @@ static void *packet_current_frame(struct packet_sock *po,
>  	return packet_lookup_frame(po, rb, rb->head, status);
>  }
>  
> +static u16 vlan_get_tci(struct sk_buff *skb)
> +{
> +	struct vlan_hdr vhdr, *vh;
> +	u8 *skb_orig_data = skb->data;
> +	int skb_orig_len = skb->len;
> +
> +	skb_push(skb, skb->data - skb_mac_header(skb));
> +	vh = skb_header_pointer(skb, ETH_HLEN, sizeof(vhdr), &vhdr);

Don't harcode Ethernet.

According to documentation VLANs are used with other link layers.

More importantly, in practice PF_PACKET allows inserting this
skb->protocol on any device.

We don't use link layer specific constants anywhere in the packet
socket code for this reason. But instead dev->hard_header_len.

One caveat there is variable length link layer headers, where
dev->min_header_len != dev->hard_header_len. Will just have to fail
on those.

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

Only since I had to respond above: this is non-obvious enough to
deserve a function comment. Something like the following?

/* For SOCK_DGRAM, data starts at the network protocol, after any VLAN
 * headers. sll_protocol must point to the network protocol. The
 * (outer) VLAN TCI is still accessible as auxdata.
 */

> +static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
> +{
> +	__be16 proto = skb->protocol;
> +
> +	if (unlikely(eth_type_vlan(proto))) {
> +		u8 *skb_orig_data = skb->data;
> +		int skb_orig_len = skb->len;
> +
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
> @@ -1007,10 +1044,16 @@ static void prb_clear_rxhash(struct tpacket_kbdq_core *pkc,
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
> +		ppd->hv1.tp_vlan_tci = vlan_get_tci(pkc->skb);
> +		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
> +		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>  	} else {
>  		ppd->hv1.tp_vlan_tci = 0;
>  		ppd->hv1.tp_vlan_tpid = 0;
> @@ -2428,6 +2471,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
>  			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
>  			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> +		} else if (unlikely(sk->sk_type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
> +			h.h2->tp_vlan_tci = vlan_get_tci(skb);
> +			h.h2->tp_vlan_tpid = ntohs(skb->protocol);
> +			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>  		} else {
>  			h.h2->tp_vlan_tci = 0;
>  			h.h2->tp_vlan_tpid = 0;
> @@ -2457,7 +2504,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
>  	sll->sll_family = AF_PACKET;
>  	sll->sll_hatype = dev->type;
> -	sll->sll_protocol = skb->protocol;
> +	sll->sll_protocol = (sk->sk_type == SOCK_DGRAM) ?
> +		vlan_get_protocol_dgram(skb) : skb->protocol;
>  	sll->sll_pkttype = skb->pkt_type;
>  	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
>  		sll->sll_ifindex = orig_dev->ifindex;
> @@ -3482,7 +3530,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  		/* Original length was stored in sockaddr_ll fields */
>  		origlen = PACKET_SKB_CB(skb)->sa.origlen;
>  		sll->sll_family = AF_PACKET;
> -		sll->sll_protocol = skb->protocol;
> +		sll->sll_protocol = (sock->type == SOCK_DGRAM) ?
> +			vlan_get_protocol_dgram(skb) : skb->protocol;
>  	}
>  
>  	sock_recv_cmsgs(msg, sk, skb);
> @@ -3539,6 +3588,10 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
>  			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
>  			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> +		} else if (unlikely(sock->type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
> +			aux.tp_vlan_tci = vlan_get_tci(skb);
> +			aux.tp_vlan_tpid = ntohs(skb->protocol);
> +			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>  		} else {
>  			aux.tp_vlan_tci = 0;
>  			aux.tp_vlan_tpid = 0;
> -- 
> 2.43.0
> 



