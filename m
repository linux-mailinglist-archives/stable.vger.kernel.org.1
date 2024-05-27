Return-Path: <stable+bounces-46282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB468CFA4B
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 09:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD710281D8F
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 07:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DB8219E1;
	Mon, 27 May 2024 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="s6Tnn3vr"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F9B200A9
	for <stable@vger.kernel.org>; Mon, 27 May 2024 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716795710; cv=none; b=rauhkjNds71uLY9D78FDCnLYKzDLpP4Pew9rkeayR2KKCHgM/g0qv/moNk+lxmwd5lcQnGzipMO/Kjxrukx+QKPRdzccSXt/fsXCCN8DTaRU3V3IqVTB3uk+BLXBKeS/j1a1yUnzb/d7qvZ7LXKHYI0n0ohDCF7/gvYWNnIzf9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716795710; c=relaxed/simple;
	bh=vkv5hq6lsxJi0KlXu4VtTvGXpDP8px3EhRFjgy+7uqc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sumN63fPpyGV1VNr9tAUVaeWOVQzkYj5YnWVhtBKMoLoEcJEsiMRQMLNnnBkung75GmAk1VWzacWfmTgQb0Yo5C13KBWWbeIbekiTpurTaAGaJTLYrAMhfRF+emScEVDJjdhP49/9KCyuS6hv8OEZiGnog56mN4TLwmxXIIzv5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=s6Tnn3vr; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 023B5411AB
	for <stable@vger.kernel.org>; Mon, 27 May 2024 07:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716795705;
	bh=NKJlqXXBWxTZdncrTmUweWa85elS5Yd/G+CtJGHvhOY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=s6Tnn3vrMDcGPLQ6vQ9ANuniCJWvrpW2pxyXHMCPdQaOFAgF6fJhTNDPxXGcRkBxn
	 ojpdsRxNYDL95URHpKWvAWU2BrYfuTzVKj+peOmam9vq8YSu4x9J3uC1Kz6VGL+kM/
	 6B1zPmYHSmy1tY+34KjBHdHvUuTtbx6WkcHZIcwF4xjleDf8I9qW5KAO9LoPAIyDDe
	 Ds1X8h0bs2bWC3+szm93nzcbYf7LZrqEXgg4S311aDf9CMVoY+wEkRkpoeDLA4X4UA
	 3R+EvFHtp935621Kbci7SXRqgGkCvZMQ5FWqZMhxv5jV1Ppak96FHi3s9f798Rlaqq
	 oGuH0on/cwuZA==
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-6819d87a0cfso2816050a12.3
        for <stable@vger.kernel.org>; Mon, 27 May 2024 00:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716795703; x=1717400503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKJlqXXBWxTZdncrTmUweWa85elS5Yd/G+CtJGHvhOY=;
        b=stR3zZtq/CGkgIcGyNz/uSezuxsNv/E/bNHVNlkDkuchqk3pKE7op/SXS4HGn90R0k
         RxJ5uWzMyGhO+1CGBDmDPlwF0xnp/s3SeaJI+VBZI2YOK9+OK3fkmqxju+kQ65czG56S
         WDFLj0iw5aM2SsR7rta+Y+ZsQzfnyyKQcsmhDRAWyi8Ud6Yhqtahug0tnnejq9a5dwfd
         xDaiz8nktbWz1x/06S+SKGBjJZJjM6ueBQbo6mAGL9zCA14pk7KvfXJgRYsPVkXjNqF9
         XRkXi3ta/aa/B5cmeh4/7T5M5lBLeDV3Ice4wSrLG49w5nL/JMiOvis+XlegWsvMQMac
         vHow==
X-Forwarded-Encrypted: i=1; AJvYcCUuSDm4b2maI38gyV6vX/YxZIWiWDb3l7SYXtciJt0RsXg5m/NzXNRqfbyMwF1PEZEI8L+dgpLC1Rl7MWI0bYBoCnkb/KN1
X-Gm-Message-State: AOJu0Yyd3fMvhFd9Mof0/AXssk1gJ2SxwjO+3RtrXkuMjaADCGAf66eD
	zkbca7uwtwM9VW/aCm7IosBCCYzFidBNgpWEM/uw9yb3aONkJD6OHsyYSxItvLJUWXvGmlEEqyW
	G069QSCibH7X9HJqzWpR5d7LP/eKUHZ8JskJAmFTM7COPpSA3eJ9y1YQwTm0Yh+nZSyPCVg==
X-Received: by 2002:a05:6a21:3398:b0:1af:db2d:d36b with SMTP id adf61e73a8af0-1b212d2a178mr9322215637.15.1716795703414;
        Mon, 27 May 2024 00:41:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV/htkyCqdBie9dVKOd7/sPWGSCGGV79a6DFKSHAwcdhDZaoylvosTVkNh5HFZHFQpJcuF4g==
X-Received: by 2002:a05:6a21:3398:b0:1af:db2d:d36b with SMTP id adf61e73a8af0-1b212d2a178mr9322200637.15.1716795702952;
        Mon, 27 May 2024 00:41:42 -0700 (PDT)
Received: from chengendu.. (36-227-176-221.dynamic-ip.hinet.net. [36.227.176.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fbf2e3d5sm4388410b3a.9.2024.05.27.00.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 00:41:42 -0700 (PDT)
From: Chengen Du <chengen.du@canonical.com>
To: briandododo@gmail.com
Cc: Chengen Du <chengen.du@canonical.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] af_packet: Handle outgoing VLAN packets without hardware offloading
Date: Mon, 27 May 2024 15:41:37 +0800
Message-Id: <20240527074137.8539-1-chengen.du@canonical.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue initially stems from libpcap [1]. In the outbound packet path,
if hardware VLAN offloading is unavailable, the VLAN tag is inserted into
the payload but then cleared from the sk_buff struct. Consequently, this
can lead to a false negative when checking for the presence of a VLAN tag,
causing the packet sniffing outcome to lack VLAN tag information (i.e.,
TCI-TPID). As a result, the packet capturing tool may be unable to parse
packets as expected.

The TCI-TPID is missing because the prb_fill_vlan_info() function does not
modify the tp_vlan_tci/tp_vlan_tpid values, as the information is in the
payload and not in the sk_buff struct. The skb_vlan_tag_present() function
only checks vlan_all in the sk_buff struct. In cooked mode, the L2 header
is stripped, preventing the packet capturing tool from determining the
correct TCI-TPID value. Additionally, the protocol in SLL is incorrect,
which means the packet capturing tool cannot parse the L3 header correctly.

[1] https://github.com/the-tcpdump-group/libpcap/issues/1105

Fixes: f6fb8f100b80 ("af-packet: TPACKET_V3 flexible buffer implementation.")
Cc: stable@vger.kernel.org
Signed-off-by: Chengen Du <chengen.du@canonical.com>
---
 net/packet/af_packet.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index ea3ebc160e25..82b36e90d73b 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1011,6 +1011,10 @@ static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
 		ppd->hv1.tp_vlan_tci = skb_vlan_tag_get(pkc->skb);
 		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->vlan_proto);
 		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+	} else if (eth_type_vlan(pkc->skb->protocol)) {
+		ppd->hv1.tp_vlan_tci = ntohs(vlan_eth_hdr(pkc->skb)->h_vlan_TCI);
+		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
+		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 	} else {
 		ppd->hv1.tp_vlan_tci = 0;
 		ppd->hv1.tp_vlan_tpid = 0;
@@ -2428,6 +2432,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
 			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
 			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+		} else if (eth_type_vlan(skb->protocol)) {
+			h.h2->tp_vlan_tci = ntohs(vlan_eth_hdr(skb)->h_vlan_TCI);
+			h.h2->tp_vlan_tpid = ntohs(skb->protocol);
+			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 		} else {
 			h.h2->tp_vlan_tci = 0;
 			h.h2->tp_vlan_tpid = 0;
@@ -2457,7 +2465,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
 	sll->sll_family = AF_PACKET;
 	sll->sll_hatype = dev->type;
-	sll->sll_protocol = skb->protocol;
+	sll->sll_protocol = (skb->protocol == htons(ETH_P_8021Q)) ?
+		vlan_eth_hdr(skb)->h_vlan_encapsulated_proto : skb->protocol;
 	sll->sll_pkttype = skb->pkt_type;
 	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
@@ -3482,7 +3491,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		/* Original length was stored in sockaddr_ll fields */
 		origlen = PACKET_SKB_CB(skb)->sa.origlen;
 		sll->sll_family = AF_PACKET;
-		sll->sll_protocol = skb->protocol;
+		sll->sll_protocol = (skb->protocol == htons(ETH_P_8021Q)) ?
+			vlan_eth_hdr(skb)->h_vlan_encapsulated_proto : skb->protocol;
 	}
 
 	sock_recv_cmsgs(msg, sk, skb);
@@ -3539,6 +3549,10 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
 			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
 			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+		} else if (eth_type_vlan(skb->protocol)) {
+			aux.tp_vlan_tci = ntohs(vlan_eth_hdr(skb)->h_vlan_TCI);
+			aux.tp_vlan_tpid = ntohs(skb->protocol);
+			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 		} else {
 			aux.tp_vlan_tci = 0;
 			aux.tp_vlan_tpid = 0;
-- 
2.40.1


