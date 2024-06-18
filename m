Return-Path: <stable+bounces-52654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BED990C7DF
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E922844A6
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 10:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4138156F23;
	Tue, 18 Jun 2024 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDWmmcuy"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1EA156C5E;
	Tue, 18 Jun 2024 09:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702667; cv=none; b=jvwel5CIZpIcTQ3I7Vs4EyX+gLvyhXcJF4fQCa8HlNh72hKMuPocS//7cNJBZck5eOFVR0ikxPhmsC35FYtxe38Mc8OZMF1DoWjSmjMgaeZYiPtZtnqkRWanrfAc/3jbvaCIsmutAbAlVp0GP0iPT4Roxl/nXT6u5I2ynqkOJJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702667; c=relaxed/simple;
	bh=uBuyn+HC+CbeuK9M256dF8uqXVicKF2DlTKlt/tweLM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=O/4Bf9TbwGRfy43GemShe5gLVuNBA5PnpUcZQJkAaFCqVoROJ763ZlGKsd0q6jX8T5GRM3SIiCm+fHRjhvgtzIG9rHh6GOepOsEOUyNgfOggZ8XeYjJoNvN6r9Rycx11LvNepgnrnQ6w30FF+uu6UTHcphr4LfDcavUxG1hR43U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDWmmcuy; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b0783b6dd5so22965536d6.1;
        Tue, 18 Jun 2024 02:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718702665; x=1719307465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skCoz0nCayfOZMxdDkUTxIYoJeG0nG+k3/og2TQIRsY=;
        b=WDWmmcuy7LHN7ryvfyOvOZxiQB14VFgfgtUdaOjdTLAh14MXVlrzF0J6BILlG48XG8
         T9a1Ig8kSE1neo5noAuroXmTIBj+ax/GmK4eMPsvOb6XcXNFYKbkJpIQyGzC9Wx4EquP
         /8x4oiUai2+i7Qid4KLR9gCMrie1nMZtg6O/R5kfYX/v/oxRbAicm6VMZqUzA0tVnpUe
         ybyVob8XXKEH4p+om9W2KlJz8sclEnpkydmFzywnnESi2C2WZZOahnbfcp+vjVt7Fu3O
         QIj3UbW6/7UMQDTwwVh0G9QOReQUxFxhEYDZ5nb355uIZuHDpHEPKXWtf9EBcgqqPJht
         baLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718702665; x=1719307465;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=skCoz0nCayfOZMxdDkUTxIYoJeG0nG+k3/og2TQIRsY=;
        b=GqHxoLim5ejcyOajmNFCUOtDPhPBFxv+Vn1kvXHcm2NKIaSGp9Wj7O6c+gmnJHZJE2
         TLOQyH9sAqJBdKqsIHrQ4ByMy9sdrmw5AJMmT0p3ypt7zlpMYhvb0II+MNb+NxkyRUTf
         k8fmWGdq95oSUuDvXWhKXCgbLvNX/SlDdWjd4r3drtqqlXNBTSMTQTe9rvMxuahl+g+T
         JtAOxdumdHqhsVTvfngk8L0Voc15/OEhOGUn43EmKsYK4A07UZGTdOMzuUQ/qn83e0iF
         hLf0ji8btXSJkEB+3XquiFiuXEZcg/HIogtGZoaSv41Kf+HIYmv7rZ4Bklkrjrt+hjS1
         ZHvw==
X-Forwarded-Encrypted: i=1; AJvYcCUJAkFEjukopm+N/GG9L8okwd0O+Q9vQgIY1Q3e7etnw/vc3CBnO1U12Om1tPQmNuwkzI+TkjQoShdONxI19rlEXO+Yy8F1DqJBUhsYOrnlrti4mSL2rD8Eq/8dzy/Oeke4E0iCWf6AAHGCbSEuwRHqXhStMp9Y9swuuVhv
X-Gm-Message-State: AOJu0YzArCQ+4FDHYiC/pILCEYZPo8lf9OBSddNaVkfduwrSaCneAmog
	226bv9xiBUSaE0gXVfMAitQu23KD4B33rhU5i0axrMdD+z+iZvK8
X-Google-Smtp-Source: AGHT+IGpXwUkLG9WScgCj1AuLHqSvgw2LHFYmd+0ZkSAj2+DnV3T9Zo6ebFGoEHXPs7FEjTAbWVXXA==
X-Received: by 2002:a0c:9792:0:b0:6b0:91a4:ece7 with SMTP id 6a1803df08f44-6b2afd61225mr111730846d6.46.1718702664555;
        Tue, 18 Jun 2024 02:24:24 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb4a9csm64494956d6.80.2024.06.18.02.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 02:24:24 -0700 (PDT)
Date: Tue, 18 Jun 2024 05:24:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Chengen Du <chengen.du@canonical.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 kaber@trash.net, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <66715247c147c_23a4e7294a7@willemb.c.googlers.com.notmuch>
In-Reply-To: <ZnEmiIhs5K4ehcYH@nanopsycho.orion>
References: <20240617054514.127961-1-chengen.du@canonical.com>
 <ZnAdiDjI_unrELB8@nanopsycho.orion>
 <6670898e1ca78_21d16f2946f@willemb.c.googlers.com.notmuch>
 <ZnEmiIhs5K4ehcYH@nanopsycho.orion>
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
> Mon, Jun 17, 2024 at 09:07:58PM CEST, willemdebruijn.kernel@gmail.com wrote:
> >Jiri Pirko wrote:
> >> Mon, Jun 17, 2024 at 07:45:14AM CEST, chengen.du@canonical.com wrote:
> >> >The issue initially stems from libpcap. The ethertype will be overwritten
> >> >as the VLAN TPID if the network interface lacks hardware VLAN offloading.
> >> >In the outbound packet path, if hardware VLAN offloading is unavailable,
> >> >the VLAN tag is inserted into the payload but then cleared from the sk_buff
> >> >struct. Consequently, this can lead to a false negative when checking for
> >> >the presence of a VLAN tag, causing the packet sniffing outcome to lack
> >> >VLAN tag information (i.e., TCI-TPID). As a result, the packet capturing
> >> >tool may be unable to parse packets as expected.
> >> >
> >> >The TCI-TPID is missing because the prb_fill_vlan_info() function does not
> >> >modify the tp_vlan_tci/tp_vlan_tpid values, as the information is in the
> >> >payload and not in the sk_buff struct. The skb_vlan_tag_present() function
> >> >only checks vlan_all in the sk_buff struct. In cooked mode, the L2 header
> >> >is stripped, preventing the packet capturing tool from determining the
> >> >correct TCI-TPID value. Additionally, the protocol in SLL is incorrect,
> >> >which means the packet capturing tool cannot parse the L3 header correctly.
> >> >
> >> >Link: https://github.com/the-tcpdump-group/libpcap/issues/1105
> >> >Link: https://lore.kernel.org/netdev/20240520070348.26725-1-chengen.du@canonical.com/T/#u
> >> >Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")
> >> >Cc: stable@vger.kernel.org
> >> >Signed-off-by: Chengen Du <chengen.du@canonical.com>
> >> >---
> >> > net/packet/af_packet.c | 86 +++++++++++++++++++++++++++++++++++++++++-
> >> > 1 file changed, 84 insertions(+), 2 deletions(-)
> >> >
> >> >diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> >> >index ea3ebc160e25..84e8884a77e3 100644
> >> >--- a/net/packet/af_packet.c
> >> >+++ b/net/packet/af_packet.c
> >> >@@ -538,6 +538,61 @@ static void *packet_current_frame(struct packet_sock *po,
> >> > 	return packet_lookup_frame(po, rb, rb->head, status);
> >> > }
> >> > 
> >> >+static u16 vlan_get_tci(struct sk_buff *skb, struct net_device *dev)
> >> >+{
> >> >+	struct vlan_hdr vhdr, *vh;
> >> >+	u8 *skb_orig_data = skb->data;
> >> >+	int skb_orig_len = skb->len;
> >> >+	unsigned int header_len;
> >> >+
> >> >+	if (!dev)
> >> >+		return 0;
> >> >+
> >> >+	/* In the SOCK_DGRAM scenario, skb data starts at the network
> >> >+	 * protocol, which is after the VLAN headers. The outer VLAN
> >> >+	 * header is at the hard_header_len offset in non-variable
> >> >+	 * length link layer headers. If it's a VLAN device, the
> >> >+	 * min_header_len should be used to exclude the VLAN header
> >> >+	 * size.
> >> >+	 */
> >> >+	if (dev->min_header_len == dev->hard_header_len)
> >> >+		header_len = dev->hard_header_len;
> >> >+	else if (is_vlan_dev(dev))
> >> >+		header_len = dev->min_header_len;
> >> >+	else
> >> >+		return 0;
> >> >+
> >> >+	skb_push(skb, skb->data - skb_mac_header(skb));
> >> >+	vh = skb_header_pointer(skb, header_len, sizeof(vhdr), &vhdr);
> >> >+	if (skb_orig_data != skb->data) {
> >> >+		skb->data = skb_orig_data;
> >> >+		skb->len = skb_orig_len;
> >> >+	}
> >> >+	if (unlikely(!vh))
> >> >+		return 0;
> >> >+
> >> >+	return ntohs(vh->h_vlan_TCI);
> >> >+}
> >> >+
> >> >+static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
> >> >+{
> >> >+	__be16 proto = skb->protocol;
> >> >+
> >> >+	if (unlikely(eth_type_vlan(proto))) {
> >> >+		u8 *skb_orig_data = skb->data;
> >> >+		int skb_orig_len = skb->len;
> >> >+
> >> >+		skb_push(skb, skb->data - skb_mac_header(skb));
> >> >+		proto = __vlan_get_protocol(skb, proto, NULL);
> >> >+		if (skb_orig_data != skb->data) {
> >> >+			skb->data = skb_orig_data;
> >> >+			skb->len = skb_orig_len;
> >> >+		}
> >> >+	}
> >> >+
> >> >+	return proto;
> >> >+}
> >> >+
> >> > static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
> >> > {
> >> > 	del_timer_sync(&pkc->retire_blk_timer);
> >> >@@ -1007,10 +1062,16 @@ static void prb_clear_rxhash(struct tpacket_kbdq_core *pkc,
> >> > static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
> >> > 			struct tpacket3_hdr *ppd)
> >> > {
> >> >+	struct packet_sock *po = container_of(pkc, struct packet_sock, rx_ring.prb_bdqc);
> >> >+
> >> > 	if (skb_vlan_tag_present(pkc->skb)) {
> >> > 		ppd->hv1.tp_vlan_tci = skb_vlan_tag_get(pkc->skb);
> >> > 		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->vlan_proto);
> >> > 		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> >> >+	} else if (unlikely(po->sk.sk_type == SOCK_DGRAM && eth_type_vlan(pkc->skb->protocol))) {
> >> >+		ppd->hv1.tp_vlan_tci = vlan_get_tci(pkc->skb, pkc->skb->dev);
> >> >+		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
> >> >+		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> >> > 	} else {
> >> > 		ppd->hv1.tp_vlan_tci = 0;
> >> > 		ppd->hv1.tp_vlan_tpid = 0;
> >> >@@ -2428,6 +2489,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
> >> > 			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
> >> > 			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
> >> > 			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> >> >+		} else if (unlikely(sk->sk_type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
> >> >+			h.h2->tp_vlan_tci = vlan_get_tci(skb, skb->dev);
> >> >+			h.h2->tp_vlan_tpid = ntohs(skb->protocol);
> >> >+			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> >> > 		} else {
> >> > 			h.h2->tp_vlan_tci = 0;
> >> > 			h.h2->tp_vlan_tpid = 0;
> >> >@@ -2457,7 +2522,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
> >> > 	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
> >> > 	sll->sll_family = AF_PACKET;
> >> > 	sll->sll_hatype = dev->type;
> >> >-	sll->sll_protocol = skb->protocol;
> >> >+	sll->sll_protocol = (sk->sk_type == SOCK_DGRAM) ?
> >> >+		vlan_get_protocol_dgram(skb) : skb->protocol;
> >> > 	sll->sll_pkttype = skb->pkt_type;
> >> > 	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
> >> > 		sll->sll_ifindex = orig_dev->ifindex;
> >> >@@ -3482,7 +3548,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> >> > 		/* Original length was stored in sockaddr_ll fields */
> >> > 		origlen = PACKET_SKB_CB(skb)->sa.origlen;
> >> > 		sll->sll_family = AF_PACKET;
> >> >-		sll->sll_protocol = skb->protocol;
> >> >+		sll->sll_protocol = (sock->type == SOCK_DGRAM) ?
> >> >+			vlan_get_protocol_dgram(skb) : skb->protocol;
> >> > 	}
> >> > 
> >> > 	sock_recv_cmsgs(msg, sk, skb);
> >> >@@ -3539,6 +3606,21 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> >> > 			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
> >> > 			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
> >> > 			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> >> >+		} else if (unlikely(sock->type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
> >> 
> >> I don't understand why this would be needed here. We spent quite a bit
> >> of efford in the past to make sure vlan header is always stripped.
> >> Could you fix that in tx path to fulfill the expectation?
> >
> >Doesn't that require NETIF_F_HW_VLAN_CTAG_TX?
> >
> >I also wondered whether we should just convert the skb for this case
> >with skb_vlan_untag, to avoid needing new PF_PACKET logic to handle
> >unstripped tags in the packet socket code. But it seems equally
> >complex.
> 
> Correct. skb_vlan_untag() as a preparation of skb before this function
> is called is exactly what I was suggesting.

It's not necessarily simpler, as that function expects skb->data to
point to the (outer) VLAN header.

It will pull that one, but not any subsequent ones.

SOCK_DGRAM expects skb->data to point to the network layer header.
And we only want to make this change for SOCK_DGRAM and if auxdata is
requested.

Not sure that it will be simpler. But worth a look at least.

