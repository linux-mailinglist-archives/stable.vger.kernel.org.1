Return-Path: <stable+bounces-46460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D438D0543
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 17:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD582889BA
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 15:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5BA61FE7;
	Mon, 27 May 2024 14:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmyV0Dkp"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF0F61FC0;
	Mon, 27 May 2024 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821050; cv=none; b=Hu6VnKN7ZYC8heaT5PinSqs7ZHawms3zS84zF3GF+ANtd2h2hTVOMdgQ/RC0HzyT8UddnxYAP+yKdL0MxhvssgwlSt10Ji1k6AJoveoBIOMum/HGuBW9Z4oWmj+iwMfmNbW+2tqdJkSm5EJBfD2J2ZY39064NlZBp6e5eCyki50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821050; c=relaxed/simple;
	bh=qvX3RliwmS0AWBg/MBZkPGJDobJusbbwVS+qslPFgko=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=czPujwcA1SyGSuPP3coJiE1oQ3rr9edDVH7HygVDQXZ8lxsZScMS/2UiuHU9sjyWWpYOwL3nYQ5fXNHiLaJ++WvM4OUkKHPrVTafP+yT33P41GkzRdPdAa/lDu69p/RQE+jIsxMltY4nQvf4OO8QEFnIEDjiZ5HHKWEyq6u3GZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmyV0Dkp; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-24c91c46d00so1875160fac.2;
        Mon, 27 May 2024 07:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716821047; x=1717425847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwD7XyrVcKBS1VkIWc/Q0G9yZOd/6w+0LFfX510sSyY=;
        b=LmyV0Dkp8neEBryTsLx5Ovitr4P1x9GqX3p3irWqprtK58GeEh9pp7BBekDp8oeTmz
         Q5FDxXxjRFP/76eRKT0hwFWY6uAFlPhxf+KVLvb9B+8n/bdd30V07R8fOjlhL375vHEG
         RzjDHCSf6GFgWbq85OFyb9wOLvyuwyItIsWvNzbjDgvGBfznMB1kmHfnDjXDBkiqmqwj
         U2toyaeyJlu+ueLIJDPCDNhDDy5Q/QljsbXKHrIS5qjCLHF1in8vFNwa1GpRVm4HTw7R
         160eE6atWk7nlHjqRQkmPQ1Px5kWqKCr4iY84IffmFYyPfNOxUbv57yssJQlNIrIa3BO
         uYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716821047; x=1717425847;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BwD7XyrVcKBS1VkIWc/Q0G9yZOd/6w+0LFfX510sSyY=;
        b=d0fwb+Vp4AiRLRZIeBhLGpz1p28l9Z2+z/eBvFAfGds4XO0Os3PuJu3yPlFqkPMZ0Z
         Fuk59iFad8gdPL+/+QDjGhCM43RCs4NN/EZMhMngCkz1I5T2QYveXGXnioNgf7E9J0Ay
         +MGoWSVChhff5GWNhEE2GFRYmYZtO3+DQJvEPNtZsi/RE5hlr5sGLDXmGXYoDiV3RmMh
         3XXGTQ2LFziNWKTidfTFBQFjmb6IwmwcgmQLbOlWhJoyTBB6F54KV2wy14tynGHIg7kN
         47G7qLwFhi5uwhTwaup9R1U9y8m+5TOpTJ6k1EZ6YQjBuzJA1PeQR5M/ByhvG1U7nsPR
         KDHA==
X-Forwarded-Encrypted: i=1; AJvYcCWzhMRJggfK4hv34KKUTR2w8EjIjnP8x86EmxPiXEq6Tr0sXfaQ0T7FwcjbVgdFiuDHDercSuNGlao7ALiYS4zwdvvxex+W8aPVmLiaOKfJNefTQsHpJho5U1Q1zBoAOE2bhFeN0AH1rlulY0OWGtSGrFSh1ikKacjOjoR+
X-Gm-Message-State: AOJu0Yzw4ImwjGEPSKnAkg+w1vP0EPbuuExwOzcBU5CgMtaNHqxS42/c
	s9z7s+BaXfiJIIwY5KsScU1NCu/oyXbedaqznwijsCThLC64pOVi
X-Google-Smtp-Source: AGHT+IGGnCwnK3T8cqacBKrtjoqEXSRb+AgmcjQzeZ/s/QuBkvFdGxTTFZZa+D0n+P5Gq7Do17HUXg==
X-Received: by 2002:a05:6870:c088:b0:24f:e5e1:b0cb with SMTP id 586e51a60fabf-24fe5e208c8mr4689840fac.15.1716821047520;
        Mon, 27 May 2024 07:44:07 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb1827696sm34599101cf.51.2024.05.27.07.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:44:06 -0700 (PDT)
Date: Mon, 27 May 2024 10:44:06 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Chengen Du <chengen.du@canonical.com>, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 loke.chetan@gmail.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Chengen Du <chengen.du@canonical.com>, 
 stable@vger.kernel.org
Message-ID: <66549c368764b_268e8229462@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240527074456.9310-1-chengen.du@canonical.com>
References: <20240527074456.9310-1-chengen.du@canonical.com>
Subject: Re: [PATCH v3] af_packet: Handle outgoing VLAN packets without
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

Include target: net vs net-next

[PATCH net v3]

Chengen Du wrote:
> The issue initially stems from libpcap [1]. In the outbound packet path,
> if hardware VLAN offloading is unavailable, the VLAN tag is inserted into
> the payload but then cleared from the sk_buff struct. Consequently, this
> can lead to a false negative when checking for the presence of a VLAN tag,
> causing the packet sniffing outcome to lack VLAN tag information (i.e.,
> TCI-TPID). As a result, the packet capturing tool may be unable to parse
> packets as expected.
> 
> The TCI-TPID is missing because the prb_fill_vlan_info() function does not
> modify the tp_vlan_tci/tp_vlan_tpid values, as the information is in the
> payload and not in the sk_buff struct. The skb_vlan_tag_present() function
> only checks vlan_all in the sk_buff struct. In cooked mode, the L2 header
> is stripped, preventing the packet capturing tool from determining the
> correct TCI-TPID value. Additionally, the protocol in SLL is incorrect,
> which means the packet capturing tool cannot parse the L3 header correctly.
> 

This does not add much context over v1 of the patch. But at least a
pointer to context.

> [1] https://github.com/the-tcpdump-group/libpcap/issues/1105

Prefer Link: $URL

Please also add a Link to the conversation on patch 1:

Link: https://lore.kernel.org/netdev/20240520070348.26725-1-chengen.du@canonical.com/T/#u
 
> Fixes: f6fb8f100b80 ("af-packet: TPACKET_V3 flexible buffer implementation.")

The referenced commit only introduces v3. The code changes to
tpacket_rcv and packet_recvmsg indicate that this goes back further.
Let's say to the introduction of explicitly passing VLAN information:

Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")

> Cc: stable@vger.kernel.org
> Signed-off-by: Chengen Du <chengen.du@canonical.com>
> ---
>  net/packet/af_packet.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index ea3ebc160e25..82b36e90d73b 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1011,6 +1011,10 @@ static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
>  		ppd->hv1.tp_vlan_tci = skb_vlan_tag_get(pkc->skb);
>  		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->vlan_proto);
>  		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> +	} else if (eth_type_vlan(pkc->skb->protocol)) {
> +		ppd->hv1.tp_vlan_tci = ntohs(vlan_eth_hdr(pkc->skb)->h_vlan_TCI);

Careful about packet length. A malicious packet can be inserted that
is an Ethernet header with zero payload, but ETH_P_8021Q as h_proto.

See how __vlan_get_protocol carefully reads the headers.

> +		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
> +		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>  	} else {
>  		ppd->hv1.tp_vlan_tci = 0;
>  		ppd->hv1.tp_vlan_tpid = 0;
> @@ -2428,6 +2432,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
>  			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
>  			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> +		} else if (eth_type_vlan(skb->protocol)) {
> +			h.h2->tp_vlan_tci = ntohs(vlan_eth_hdr(skb)->h_vlan_TCI);
> +			h.h2->tp_vlan_tpid = ntohs(skb->protocol);
> +			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>  		} else {
>  			h.h2->tp_vlan_tci = 0;
>  			h.h2->tp_vlan_tpid = 0;
> @@ -2457,7 +2465,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
>  	sll->sll_family = AF_PACKET;
>  	sll->sll_hatype = dev->type;
> -	sll->sll_protocol = skb->protocol;
> +	sll->sll_protocol = (skb->protocol == htons(ETH_P_8021Q)) ?
> +		vlan_eth_hdr(skb)->h_vlan_encapsulated_proto : skb->protocol;

In SOCK_RAW mode, the VLAN tag will be present, so should be returned.

I'm concerned about returning a different value between SOCK_RAW and
SOCK_DGRAM. But don't immediately see a better option. And for
SOCK_DGRAM this approach is indistinguishable from the result on a
device with hardware offload, so is acceptable.

This test for ETH_P_8021Q ignores the QinQ stacked VLAN case. When
fixing VLAN encap, both variants should be addressed at the same time.
Note that ETH_P_8021AD is included in the eth_type_vlan test you call
above.

All these extra branches also makes the common case slower. Let's try
to mitigate that as much as possible.

>  	sll->sll_pkttype = skb->pkt_type;
>  	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
>  		sll->sll_ifindex = orig_dev->ifindex;
> @@ -3482,7 +3491,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  		/* Original length was stored in sockaddr_ll fields */
>  		origlen = PACKET_SKB_CB(skb)->sa.origlen;
>  		sll->sll_family = AF_PACKET;
> -		sll->sll_protocol = skb->protocol;
> +		sll->sll_protocol = (skb->protocol == htons(ETH_P_8021Q)) ?
> +			vlan_eth_hdr(skb)->h_vlan_encapsulated_proto : skb->protocol;
>  	}
>  
>  	sock_recv_cmsgs(msg, sk, skb);
> @@ -3539,6 +3549,10 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
>  			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
>  			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> +		} else if (eth_type_vlan(skb->protocol)) {
> +			aux.tp_vlan_tci = ntohs(vlan_eth_hdr(skb)->h_vlan_TCI);
> +			aux.tp_vlan_tpid = ntohs(skb->protocol);
> +			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>  		} else {
>  			aux.tp_vlan_tci = 0;
>  			aux.tp_vlan_tpid = 0;
> -- 
> 2.40.1
> 



