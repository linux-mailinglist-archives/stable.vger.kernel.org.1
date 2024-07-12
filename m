Return-Path: <stable+bounces-59202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB9E92FE25
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 18:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98F67B23025
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 16:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C31176AA0;
	Fri, 12 Jul 2024 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I425MlnX"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89EB176240;
	Fri, 12 Jul 2024 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800280; cv=none; b=g1qmVXzXYe0n1XxHh4Fb7rlMM/RCTCja7c3OSEv/Dq1OvXxoWYb/BKHVNYh5+kPEm3YRFMzJDfaGqZ2ipnCTLHT63aR4zZWPVuODvmUJckwEvPO5XGEAXBaYZDIp9zQsDZE4qgzr1pLh/lQt7PGAA5I8jbYcWiHvNcKIGU5irrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800280; c=relaxed/simple;
	bh=ngivLCWE81B27y1GSYx8ldBDIwTbs3kiiSoJyDE+qyQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=QbXI7T65I/aKCihaQTVIpBZEpZ8z2JqtUKwI8ZBFGLdAQqBpnFmXu05uH3q+RNK0PV5GR1TPSL2YwGXD1gDJizEof8dk3w7puGVkGc2pL+ZfgLVYN28+5VfXCyRKEUzlx7RDpRPgs1QCihF+QeNs9Nzwq/bfCI5m7MEcMHgry+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I425MlnX; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b5daf5ea91so12105126d6.1;
        Fri, 12 Jul 2024 09:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720800277; x=1721405077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/h/+q58+aCVjVtZZ4CChDL1/LkloSpcxSAa3+pfndK4=;
        b=I425MlnXO4WvqqcMMR5NkTIm/u2LSgBp78ad1tRCWxNUHMYFZeHdP2DNObd1Kubwp4
         HO4ojcW6Xyi7QclMCLtKkuhG3cNik9Kg3t3nx8hB3E5EThGsTpn7f6e06dEKXpfF6tSW
         zYV0au8j88Q/vltP4Wyaf4J8Ms3PomWLLIAamIJTMfnAA0KcSE0FjqCwXKn4kIU71Jf8
         fCkjkC4IH6ea7l2zRvroxenWTXLswpy8LA+rIMUz3YXwr5HphSxo2GTasX9f8fijPYmy
         PgQNuhiOlaOCDtyHgAdu2i+kY07k9avL3pWslxGFU0GJ7p/NPr1YTraAp3iGPxwFZcgP
         BA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720800277; x=1721405077;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/h/+q58+aCVjVtZZ4CChDL1/LkloSpcxSAa3+pfndK4=;
        b=DRHgs5Pne3dYkLd2/i1DeABuwNgpP1LVZF24BiG6lHSdWhKN5GD3cZ8Go9o1BibmAr
         /9HBTW395drGWVEObhrdVX05r/N30obnjagkeMCpyy1dTXAZ448ZXvClavnwSWIlOPXh
         2ZaTLB0tDA9GbaLp5zCZN6UoscftLchypxm7Tx8KH2uKmj7j4TRa8CnUOXIL++rwXUMt
         RkR1EQWE3lFtFHEWzyctAKpqQ4iRPacoJQk4n8DSwqTMVIsDzCIyEi1P0zqiKK7f+Pea
         3/5JAuRlPT/EM0jf6j/gztzaqRlfjImeQ13FX6Ii8cCvIegE9fP4oUoiRN58wuo0icNs
         xywg==
X-Forwarded-Encrypted: i=1; AJvYcCXMqdjibqdZEysMhoARjCTjmJoQjiApTcWVuMAHKxnJhwsq3G/NQKBJbHu8oUUIDzL2Gd1gR9iiSajAYEVKsZC6vOz36juGO+NX/2Fn4EvEQ5DDzjir0D5+xkvzxIr0fKrSICD0LZn8EUBzly61pednCtfUtMJ8s06c18vv
X-Gm-Message-State: AOJu0Yx+rQb2auVD6CQ7CR/LLhLoJbc/WZifmQNzkoSnsUQGnj+ou3Vh
	C1KL+yr5U49lERg1UXqPqS7DWgmMWhJQYtiBOpO11EOA8wtY4/7C
X-Google-Smtp-Source: AGHT+IE3kAbbk52TIf5qNKA7SJsLMhEkEONymK4QKI6w/YFQFGNsXdyyVTVZ2oa5pOndhcqDWbk6mQ==
X-Received: by 2002:ad4:5764:0:b0:6b5:49c9:ed4f with SMTP id 6a1803df08f44-6b61bf1b917mr135306446d6.34.1720800277201;
        Fri, 12 Jul 2024 09:04:37 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba8c9f1sm36369736d6.123.2024.07.12.09.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 09:04:36 -0700 (PDT)
Date: Fri, 12 Jul 2024 12:04:36 -0400
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
Message-ID: <66915414758be_24ac88294cd@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240712012956.10408-1-chengen.du@canonical.com>
References: <20240712012956.10408-1-chengen.du@canonical.com>
Subject: Re: [PATCH v9] af_packet: Handle outgoing VLAN packets without
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

Reviewed-by: Willem de Bruijn <willemb@google.com>

For next time, please remember to mention the tree: [PATCH net v9].
And give a changelog: Changes v8->v9: no changes, rebased resubmit.

> ---
>  net/packet/af_packet.c | 86 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 84 insertions(+), 2 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index ea3ebc160e25..84e8884a77e3 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -538,6 +538,61 @@ static void *packet_current_frame(struct packet_sock *po,
>  	return packet_lookup_frame(po, rb, rb->head, status);
>  }
>  
> +static u16 vlan_get_tci(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct vlan_hdr vhdr, *vh;
> +	u8 *skb_orig_data = skb->data;
> +	int skb_orig_len = skb->len;
> +	unsigned int header_len;

nit: reverse christmas tree violation

> +
> +	if (!dev)
> +		return 0;
> +
> +	/* In the SOCK_DGRAM scenario, skb data starts at the network
> +	 * protocol, which is after the VLAN headers. The outer VLAN
> +	 * header is at the hard_header_len offset in non-variable
> +	 * length link layer headers. If it's a VLAN device, the
> +	 * min_header_len should be used to exclude the VLAN header
> +	 * size.
> +	 */
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
> @@ -1007,10 +1062,16 @@ static void prb_clear_rxhash(struct tpacket_kbdq_core *pkc,
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
> +		ppd->hv1.tp_vlan_tci = vlan_get_tci(pkc->skb, pkc->skb->dev);
> +		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
> +		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>  	} else {
>  		ppd->hv1.tp_vlan_tci = 0;
>  		ppd->hv1.tp_vlan_tpid = 0;
> @@ -2428,6 +2489,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
>  			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
>  			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> +		} else if (unlikely(sk->sk_type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
> +			h.h2->tp_vlan_tci = vlan_get_tci(skb, skb->dev);
> +			h.h2->tp_vlan_tpid = ntohs(skb->protocol);
> +			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>  		} else {
>  			h.h2->tp_vlan_tci = 0;
>  			h.h2->tp_vlan_tpid = 0;
> @@ -2457,7 +2522,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
>  	sll->sll_family = AF_PACKET;
>  	sll->sll_hatype = dev->type;
> -	sll->sll_protocol = skb->protocol;
> +	sll->sll_protocol = (sk->sk_type == SOCK_DGRAM) ?
> +		vlan_get_protocol_dgram(skb) : skb->protocol;
>  	sll->sll_pkttype = skb->pkt_type;
>  	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
>  		sll->sll_ifindex = orig_dev->ifindex;
> @@ -3482,7 +3548,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  		/* Original length was stored in sockaddr_ll fields */
>  		origlen = PACKET_SKB_CB(skb)->sa.origlen;
>  		sll->sll_family = AF_PACKET;
> -		sll->sll_protocol = skb->protocol;
> +		sll->sll_protocol = (sock->type == SOCK_DGRAM) ?
> +			vlan_get_protocol_dgram(skb) : skb->protocol;
>  	}
>  
>  	sock_recv_cmsgs(msg, sk, skb);
> @@ -3539,6 +3606,21 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
>  			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
>  			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> +		} else if (unlikely(sock->type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
> +			struct sockaddr_ll *sll = &PACKET_SKB_CB(skb)->sa.ll;
> +			struct net_device *dev;
> +
> +			rcu_read_lock();
> +			dev = dev_get_by_index_rcu(sock_net(sk), sll->sll_ifindex);
> +			if (dev) {
> +				aux.tp_vlan_tci = vlan_get_tci(skb, dev);
> +				aux.tp_vlan_tpid = ntohs(skb->protocol);
> +				aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> +			} else {
> +				aux.tp_vlan_tci = 0;
> +				aux.tp_vlan_tpid = 0;
> +			}
> +			rcu_read_unlock();
>  		} else {
>  			aux.tp_vlan_tci = 0;
>  			aux.tp_vlan_tpid = 0;
> -- 
> 2.43.0
> 



