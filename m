Return-Path: <stable+bounces-52635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F03390C361
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 08:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27138283824
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 06:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C2F1D9535;
	Tue, 18 Jun 2024 06:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="v9sAO9Vc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838A61A29A
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 06:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718691473; cv=none; b=kdbcVBlg/fEqWw6awAh/GQ2muD6PHelgXYu0qZ/iI8LafZ6ER00/i36R7m8ZxsGoB5TjLc/1AerxbBWgIFPmORQM8QvjQnpHVoVBfFL8W9gI97XN6ywprNV/nzledfS3uGLwDmy2Rnb+gsmNLinBzgG7sCNctSWjm9FdQ7jyrAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718691473; c=relaxed/simple;
	bh=U8DqPi5nV6Ax8AwqbmEjNJacsVfQKL3n9p6yGWihwhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+X5AXY+Fd7BBA55leP7W8Nc8NukSSmc52taLNxOYnN08Q2H4qs4BsNp8L0C26XOJ/sHcVgnnJu3+Rj1MdBq7jsVGHBHy7K2Aikl0ZEFrAMnUL9VY1c6h5HD78h0SKz17OAJS5Otpk4WfX+96pW7qSjXFZch1S4BQXC4emaSjYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=v9sAO9Vc; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4217136a74dso43317335e9.2
        for <stable@vger.kernel.org>; Mon, 17 Jun 2024 23:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718691469; x=1719296269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BX2tptrJJXy8ed3PziokxT4H9bzzrxMDT/j3fl102RY=;
        b=v9sAO9VcKpHDhvvDaQnQT9oe3BK4AYj5qrxuAwiduzNsdm8GYIf11LXmyV1pCMBccz
         TzXBgqwat6m6qr017LjqTLDfTqnqs4239xyBsLDGDMapVdK9myFbabTusRw3oO1vDlNJ
         Ivoex83YmEKoaArh4HPD8ASeeO5nlVjieayL3xAKGIU7i29vc3EERARglq5lrz9Vstmc
         bHZ+3Ej7b/+sOaRuT+u3WekjsPvRvwca9olNNRVq83HlFDH0sl0lI2OiP31mhnJiYSf8
         fO5K4W4HJ9oOUUGuD8bdouMb5JZfl4gnukOYx/YZpIDy9kyHtgjtJ8AzjHq2eW8UZjTF
         Cvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718691469; x=1719296269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BX2tptrJJXy8ed3PziokxT4H9bzzrxMDT/j3fl102RY=;
        b=LUmoXrER0tU0/MQ1YrkYveQP+2mdYwPdLBKM2fVxB76DlJ9obXC/xakG2EILoAsU89
         OKudCVaFval8v4e1B2lb5rAHxJAmqOlmNyuaNkLjB/+t1J9uKDBND9vIYM7+B+8bVcQx
         qvZRH1oOWmjGOzJZIDVRqQuY5z4Q85TRh9iy9vt43JjvS4sS2Q2yImS8xzRk9T7MfCH9
         MrnAiuLIAJ8kqEj00odzSH+BMxDtSZcnU22hEz6GLY4NqviYhvofNgWpIk4lKEykQIPA
         /0vswnkO4PIuHSI4iSy9cOKGxtQwWq2AvRsfxgLhCmRZ8hm5WymWaKmv6qz5EBLI+kTO
         DFSA==
X-Forwarded-Encrypted: i=1; AJvYcCUdaPA9haonWDa6WSa7upnk4f3TFQLKHPvrN4+KMrLn1Xwf9J1XNUfo+wc2C3ZZ2ZeD5EARlHWjdEoGUUv/QSFCFc8GybPg
X-Gm-Message-State: AOJu0YxIxCSzzTujeXMR/EoPQOd3wVEZya2IW76KAKcDi+wErcTQJITP
	99L+mDoXOXMt3DFsQl2WaeDHu9DIKqbgl92vqArN6t1ERlGwd04CTDP8mxT4OtA=
X-Google-Smtp-Source: AGHT+IH6CM1gTzKj6FCjgNgVsgSvdy5aTYOz7Z2sRn55KttsjbBKGQZmRsym7bESsnvXwvEuZIzadg==
X-Received: by 2002:a05:600c:1e20:b0:422:683b:df57 with SMTP id 5b1f17b1804b1-4230483097cmr81808715e9.21.1718691468481;
        Mon, 17 Jun 2024 23:17:48 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6320c16sm179538615e9.38.2024.06.17.23.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 23:17:47 -0700 (PDT)
Date: Tue, 18 Jun 2024 08:17:44 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Chengen Du <chengen.du@canonical.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	kaber@trash.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v8] af_packet: Handle outgoing VLAN packets without
 hardware offloading
Message-ID: <ZnEmiIhs5K4ehcYH@nanopsycho.orion>
References: <20240617054514.127961-1-chengen.du@canonical.com>
 <ZnAdiDjI_unrELB8@nanopsycho.orion>
 <6670898e1ca78_21d16f2946f@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6670898e1ca78_21d16f2946f@willemb.c.googlers.com.notmuch>

Mon, Jun 17, 2024 at 09:07:58PM CEST, willemdebruijn.kernel@gmail.com wrote:
>Jiri Pirko wrote:
>> Mon, Jun 17, 2024 at 07:45:14AM CEST, chengen.du@canonical.com wrote:
>> >The issue initially stems from libpcap. The ethertype will be overwritten
>> >as the VLAN TPID if the network interface lacks hardware VLAN offloading.
>> >In the outbound packet path, if hardware VLAN offloading is unavailable,
>> >the VLAN tag is inserted into the payload but then cleared from the sk_buff
>> >struct. Consequently, this can lead to a false negative when checking for
>> >the presence of a VLAN tag, causing the packet sniffing outcome to lack
>> >VLAN tag information (i.e., TCI-TPID). As a result, the packet capturing
>> >tool may be unable to parse packets as expected.
>> >
>> >The TCI-TPID is missing because the prb_fill_vlan_info() function does not
>> >modify the tp_vlan_tci/tp_vlan_tpid values, as the information is in the
>> >payload and not in the sk_buff struct. The skb_vlan_tag_present() function
>> >only checks vlan_all in the sk_buff struct. In cooked mode, the L2 header
>> >is stripped, preventing the packet capturing tool from determining the
>> >correct TCI-TPID value. Additionally, the protocol in SLL is incorrect,
>> >which means the packet capturing tool cannot parse the L3 header correctly.
>> >
>> >Link: https://github.com/the-tcpdump-group/libpcap/issues/1105
>> >Link: https://lore.kernel.org/netdev/20240520070348.26725-1-chengen.du@canonical.com/T/#u
>> >Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")
>> >Cc: stable@vger.kernel.org
>> >Signed-off-by: Chengen Du <chengen.du@canonical.com>
>> >---
>> > net/packet/af_packet.c | 86 +++++++++++++++++++++++++++++++++++++++++-
>> > 1 file changed, 84 insertions(+), 2 deletions(-)
>> >
>> >diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
>> >index ea3ebc160e25..84e8884a77e3 100644
>> >--- a/net/packet/af_packet.c
>> >+++ b/net/packet/af_packet.c
>> >@@ -538,6 +538,61 @@ static void *packet_current_frame(struct packet_sock *po,
>> > 	return packet_lookup_frame(po, rb, rb->head, status);
>> > }
>> > 
>> >+static u16 vlan_get_tci(struct sk_buff *skb, struct net_device *dev)
>> >+{
>> >+	struct vlan_hdr vhdr, *vh;
>> >+	u8 *skb_orig_data = skb->data;
>> >+	int skb_orig_len = skb->len;
>> >+	unsigned int header_len;
>> >+
>> >+	if (!dev)
>> >+		return 0;
>> >+
>> >+	/* In the SOCK_DGRAM scenario, skb data starts at the network
>> >+	 * protocol, which is after the VLAN headers. The outer VLAN
>> >+	 * header is at the hard_header_len offset in non-variable
>> >+	 * length link layer headers. If it's a VLAN device, the
>> >+	 * min_header_len should be used to exclude the VLAN header
>> >+	 * size.
>> >+	 */
>> >+	if (dev->min_header_len == dev->hard_header_len)
>> >+		header_len = dev->hard_header_len;
>> >+	else if (is_vlan_dev(dev))
>> >+		header_len = dev->min_header_len;
>> >+	else
>> >+		return 0;
>> >+
>> >+	skb_push(skb, skb->data - skb_mac_header(skb));
>> >+	vh = skb_header_pointer(skb, header_len, sizeof(vhdr), &vhdr);
>> >+	if (skb_orig_data != skb->data) {
>> >+		skb->data = skb_orig_data;
>> >+		skb->len = skb_orig_len;
>> >+	}
>> >+	if (unlikely(!vh))
>> >+		return 0;
>> >+
>> >+	return ntohs(vh->h_vlan_TCI);
>> >+}
>> >+
>> >+static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
>> >+{
>> >+	__be16 proto = skb->protocol;
>> >+
>> >+	if (unlikely(eth_type_vlan(proto))) {
>> >+		u8 *skb_orig_data = skb->data;
>> >+		int skb_orig_len = skb->len;
>> >+
>> >+		skb_push(skb, skb->data - skb_mac_header(skb));
>> >+		proto = __vlan_get_protocol(skb, proto, NULL);
>> >+		if (skb_orig_data != skb->data) {
>> >+			skb->data = skb_orig_data;
>> >+			skb->len = skb_orig_len;
>> >+		}
>> >+	}
>> >+
>> >+	return proto;
>> >+}
>> >+
>> > static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
>> > {
>> > 	del_timer_sync(&pkc->retire_blk_timer);
>> >@@ -1007,10 +1062,16 @@ static void prb_clear_rxhash(struct tpacket_kbdq_core *pkc,
>> > static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
>> > 			struct tpacket3_hdr *ppd)
>> > {
>> >+	struct packet_sock *po = container_of(pkc, struct packet_sock, rx_ring.prb_bdqc);
>> >+
>> > 	if (skb_vlan_tag_present(pkc->skb)) {
>> > 		ppd->hv1.tp_vlan_tci = skb_vlan_tag_get(pkc->skb);
>> > 		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->vlan_proto);
>> > 		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>> >+	} else if (unlikely(po->sk.sk_type == SOCK_DGRAM && eth_type_vlan(pkc->skb->protocol))) {
>> >+		ppd->hv1.tp_vlan_tci = vlan_get_tci(pkc->skb, pkc->skb->dev);
>> >+		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
>> >+		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>> > 	} else {
>> > 		ppd->hv1.tp_vlan_tci = 0;
>> > 		ppd->hv1.tp_vlan_tpid = 0;
>> >@@ -2428,6 +2489,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>> > 			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
>> > 			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
>> > 			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>> >+		} else if (unlikely(sk->sk_type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
>> >+			h.h2->tp_vlan_tci = vlan_get_tci(skb, skb->dev);
>> >+			h.h2->tp_vlan_tpid = ntohs(skb->protocol);
>> >+			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>> > 		} else {
>> > 			h.h2->tp_vlan_tci = 0;
>> > 			h.h2->tp_vlan_tpid = 0;
>> >@@ -2457,7 +2522,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>> > 	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
>> > 	sll->sll_family = AF_PACKET;
>> > 	sll->sll_hatype = dev->type;
>> >-	sll->sll_protocol = skb->protocol;
>> >+	sll->sll_protocol = (sk->sk_type == SOCK_DGRAM) ?
>> >+		vlan_get_protocol_dgram(skb) : skb->protocol;
>> > 	sll->sll_pkttype = skb->pkt_type;
>> > 	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
>> > 		sll->sll_ifindex = orig_dev->ifindex;
>> >@@ -3482,7 +3548,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>> > 		/* Original length was stored in sockaddr_ll fields */
>> > 		origlen = PACKET_SKB_CB(skb)->sa.origlen;
>> > 		sll->sll_family = AF_PACKET;
>> >-		sll->sll_protocol = skb->protocol;
>> >+		sll->sll_protocol = (sock->type == SOCK_DGRAM) ?
>> >+			vlan_get_protocol_dgram(skb) : skb->protocol;
>> > 	}
>> > 
>> > 	sock_recv_cmsgs(msg, sk, skb);
>> >@@ -3539,6 +3606,21 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>> > 			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
>> > 			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
>> > 			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>> >+		} else if (unlikely(sock->type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
>> 
>> I don't understand why this would be needed here. We spent quite a bit
>> of efford in the past to make sure vlan header is always stripped.
>> Could you fix that in tx path to fulfill the expectation?
>
>Doesn't that require NETIF_F_HW_VLAN_CTAG_TX?
>
>I also wondered whether we should just convert the skb for this case
>with skb_vlan_untag, to avoid needing new PF_PACKET logic to handle
>unstripped tags in the packet socket code. But it seems equally
>complex.

Correct. skb_vlan_untag() as a preparation of skb before this function
is called is exactly what I was suggesting.


>
>Aside from this conversation whether we need to support this
>unstripped case at all, code LGTM.

