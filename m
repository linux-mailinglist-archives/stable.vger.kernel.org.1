Return-Path: <stable+bounces-47959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3AB8FBF5B
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 00:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050BD1F230E3
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 22:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADF614C5BA;
	Tue,  4 Jun 2024 22:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnQT8mjg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9034143C4D;
	Tue,  4 Jun 2024 22:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717541840; cv=none; b=gqJcdjKk4FM7uZHVSCQe8cOl4ikQBoFukzhjQN6Z8oE9O/czZg2qrcxvg4HS1gijlOYIelPj/gvUHJfhxa4w1mKsE5cMtI+yBEImR2bPotEpGjPFemACyoLb+WskTklrp8hD9dBa6yHBwONoEtuutFrhQIiphdtmN/cRf8tZA9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717541840; c=relaxed/simple;
	bh=tJRpBSdGI5+ztAYNT2EZw2Oo0M0uhQzuPcHSyMbRRr8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=L5ZW2I7Qq8c7FzrzbX++7r2gLMPdXhpm4SfbZL+jOlzdAkMMA7fQdiBaU7/D6n1YVtXR9yH9FvaHqg7YAYkISLvGUv/E9YDU3XKgFsCc5ShH6XAGQTofVayfDo1dkzUkH06omZGbODIZ1nH1e44v3L0cCjBjSGzJmCGYIiBRAfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnQT8mjg; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-794ab181ff7so382361585a.2;
        Tue, 04 Jun 2024 15:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717541838; x=1718146638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuJzxBVSRtkHxvHY9mkYCYLSCzN+uAfLvnKnRjrdECM=;
        b=YnQT8mjgTCADMXnYj5VjqFK5FIWoSzpzegB7bL/mzSmWvC2tkDZPG8fyAs6H0vc9iM
         dDD+wAPp6AIes0Tt3dVeEDgTLEuCIu6C5YFBLCHuRWiBm92NmLL/D0ymu6Dk3qgPTGWP
         GUfjXWGUgMW6K9DRjoI5M0Pm1tQyT+0zB+WBT9OQ/+8/biY6fdvsgBSac/VsN4YwZGse
         kt1iafRNJ8VsTc6yfUrIUXiWLctiDy47Pg4x0bqtqBxVxyFs25TYYLNLfbwmdTPybQkx
         hoq/riCfQgngGhODhc5b5F8NrRWBeS7DJEO6qumjWL294uZM2S5dBO/942VVdaPb/8Wz
         94YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717541838; x=1718146638;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iuJzxBVSRtkHxvHY9mkYCYLSCzN+uAfLvnKnRjrdECM=;
        b=HmqZwhyXjvtv9k/1kRgTAmriAlFH5oO6QX8urnm8qFJ7CEuoTdiy6IXieX66aCDyKu
         yszhKoHIFG7x5+RqsCrLwrWSdlBmodmmg2ZLCAZDx1mHQF0NzHUNqjmZKgz2wZFMTUoK
         ck7nZYtWwxjlSbgCAuSdivD2OJ0J3e6HvZiyr3lm21o3ssB0PtRKcrG9AECe1KjjuDQH
         A9gHQ7GhzZsl031Kfql5EhZxV0uY3u9vEMozDVnIMPL3O3CD6ROIv6teIrbajYcQj+TE
         axoMVtZ24MzYcWcI676IfToVnfpv3MAcyuPuQl7yACgGBDPa90+v/w/6CsNLXCFyeqtN
         anJw==
X-Forwarded-Encrypted: i=1; AJvYcCXiMobBgMvyMtsNB5EyZcHBRYfz3EwbTCN5C5hE89j5SywHMSIEvCnZNlvm8FWwxs90nbwPoB4LluodzGxyY5dh+V0IvHVll+Lj2XNBuSi4Kd3F2QuAwkbf5ZqfyKlF7XdvJptONIbQpqbv6ssdJIc8Pg2qnUJrrXxd0CY6
X-Gm-Message-State: AOJu0YwjjduCvNJy9g5SZ09HCmeJjA6dA1cgY2bYd6xBrw7+tQ7bDlmF
	VVXPbuxNBQ7F/7WhLlY2VXC+c5rsTRJ1DkEeIkdYof7xWsL7igXV
X-Google-Smtp-Source: AGHT+IFW/PA8/iHwNVPAIp5bYmLuK1g2mcIXDOGAUk0NKB6dj3n4+720UJ59lp21H02a2S7NnoXACw==
X-Received: by 2002:a05:620a:c86:b0:792:9960:7891 with SMTP id af79cd13be357-795240d973fmr76409885a.78.1717541837325;
        Tue, 04 Jun 2024 15:57:17 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795223dc408sm33667685a.67.2024.06.04.15.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 15:57:16 -0700 (PDT)
Date: Tue, 04 Jun 2024 18:57:16 -0400
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
Message-ID: <665f9bccaa91c_2bf7de294f4@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240604054823.20649-1-chengen.du@canonical.com>
References: <20240604054823.20649-1-chengen.du@canonical.com>
Subject: Re: [PATCH v5] af_packet: Handle outgoing VLAN packets without
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
>  net/packet/af_packet.c | 64 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 62 insertions(+), 2 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index ea3ebc160e25..53d51ac87ac6 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -538,6 +538,52 @@ static void *packet_current_frame(struct packet_sock *po,
>  	return packet_lookup_frame(po, rb, rb->head, status);
>  }
>  
> +static u16 vlan_get_tci(struct sk_buff *skb)
> +{
> +	unsigned int vlan_depth = skb->mac_len;
> +	struct vlan_hdr vhdr, *vh;
> +	u8 *skb_head = skb->data;
> +	int skb_len = skb->len;
> +
> +	if (vlan_depth) {
> +		if (WARN_ON(vlan_depth < VLAN_HLEN))
> +			return 0;
> +		vlan_depth -= VLAN_HLEN;
> +	} else {
> +		vlan_depth = ETH_HLEN;
> +	}
> +
> +	skb_push(skb, skb->data - skb_mac_header(skb));
> +	vh = skb_header_pointer(skb, vlan_depth, sizeof(vhdr), &vhdr);
> +	if (skb_head != skb->data) {
> +		skb->data = skb_head;
> +		skb->len = skb_len;
> +	}
> +	if (unlikely(!vh))
> +		return 0;
> +
> +	return ntohs(vh->h_vlan_TCI);

As stated in the conversation: no need for the vlan_depth code.

skb->data is either at the link layer header or immediately beyond it
(i.e., at the outer vlan tag).

> +}
> +
> +static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
> +{
> +	__be16 proto = skb->protocol;
> +
> +	if (unlikely(eth_type_vlan(proto))) {
> +		u8 *skb_head = skb->data;

Since skb->head is a different thing from skb->data, please call this
orig_data or so.
> +		int skb_len = skb->len;
> +
> +		skb_push(skb, skb->data - skb_mac_header(skb));
> +		proto = __vlan_get_protocol(skb, proto, NULL);
> +		if (skb_head != skb->data) {
> +			skb->data = skb_head;
> +			skb->len = skb_len;
> +		}
> +	}

I don't see a way around this temporary skb->data mangling, so +1
unless someone else suggests a cleaner way.

On second thought, one option:

This adds some parsing overhead in the datapath. SOCK_RAW does not
need it, as it can see the whole VLAN tag. Perhaps limit the new
branches to SOCK_DGRAM cases? Then the above can also be simplified.

> +
> +	return proto;
> +}
> +
>  static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
>  {
>  	del_timer_sync(&pkc->retire_blk_timer);
> @@ -1011,6 +1057,10 @@ static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
>  		ppd->hv1.tp_vlan_tci = skb_vlan_tag_get(pkc->skb);
>  		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->vlan_proto);
>  		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> +	} else if (unlikely(eth_type_vlan(pkc->skb->protocol))) {
> +		ppd->hv1.tp_vlan_tci = vlan_get_tci(pkc->skb);
> +		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
> +		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>  	} else {
>  		ppd->hv1.tp_vlan_tci = 0;
>  		ppd->hv1.tp_vlan_tpid = 0;
> @@ -2428,6 +2478,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
>  			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
>  			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> +		} else if (unlikely(eth_type_vlan(skb->protocol))) {
> +			h.h2->tp_vlan_tci = vlan_get_tci(skb);
> +			h.h2->tp_vlan_tpid = ntohs(skb->protocol);
> +			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>  		} else {
>  			h.h2->tp_vlan_tci = 0;
>  			h.h2->tp_vlan_tpid = 0;
> @@ -2457,7 +2511,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
>  	sll->sll_family = AF_PACKET;
>  	sll->sll_hatype = dev->type;
> -	sll->sll_protocol = skb->protocol;
> +	sll->sll_protocol = (sk->sk_type == SOCK_DGRAM) ?
> +		vlan_get_protocol_dgram(skb) : skb->protocol;
>  	sll->sll_pkttype = skb->pkt_type;
>  	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
>  		sll->sll_ifindex = orig_dev->ifindex;
> @@ -3482,7 +3537,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  		/* Original length was stored in sockaddr_ll fields */
>  		origlen = PACKET_SKB_CB(skb)->sa.origlen;
>  		sll->sll_family = AF_PACKET;
> -		sll->sll_protocol = skb->protocol;
> +		sll->sll_protocol = (sock->type == SOCK_DGRAM) ?
> +			vlan_get_protocol_dgram(skb) : skb->protocol;
>  	}
>  
>  	sock_recv_cmsgs(msg, sk, skb);
> @@ -3539,6 +3595,10 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
>  			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
>  			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> +		} else if (unlikely(eth_type_vlan(skb->protocol))) {
> +			aux.tp_vlan_tci = vlan_get_tci(skb);
> +			aux.tp_vlan_tpid = ntohs(skb->protocol);
> +			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>  		} else {
>  			aux.tp_vlan_tci = 0;
>  			aux.tp_vlan_tpid = 0;
> -- 
> 2.43.0
> 



