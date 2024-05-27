Return-Path: <stable+bounces-46283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A95C28CFA4F
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 09:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4F01F21818
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 07:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608D628387;
	Mon, 27 May 2024 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="H4R2DvoY"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CCD10A0D
	for <stable@vger.kernel.org>; Mon, 27 May 2024 07:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716795915; cv=none; b=HL3rQJ5a+dI4SaypxYsBKT+HPUmbBGXxI/wEH8gF1QFmm7Zrgl31i9fk8/jnQaXtz/6Gkk3/ShVNpSlKyEdUyHgRlXcvuNMRt/kK6zDAClwshj5b8saDXuHJ/1+8Jhu73q0vTFSrL/FC+ApVS7/xIXcgsINzSwFjkIZKDIdj2DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716795915; c=relaxed/simple;
	bh=vkv5hq6lsxJi0KlXu4VtTvGXpDP8px3EhRFjgy+7uqc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=trIHDnjd1nPSWIfDqRZvp1Cc5k57n6geT+HRtO/6IvUuJ8rJrBqz5rpzvbO8LRQmbHh0v7I9aZe6gk2/rm+eudVxdEWaGpfFt8LJT6X+74V4uFGoV71B1b4EZBvGPEi7uQrd6E1pLz0Qv2b1ewzI5gh8ajX0jbit0A5hEyHoLTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=H4R2DvoY; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3C0FA3F594
	for <stable@vger.kernel.org>; Mon, 27 May 2024 07:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716795909;
	bh=NKJlqXXBWxTZdncrTmUweWa85elS5Yd/G+CtJGHvhOY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=H4R2DvoYnrmRs6R3BkCftlfTB9oOMtdfztdHo3LW9pfsE9UI86AvmpEj/3/Y1hgb5
	 RYcMYeStaclDhUBMpIXGEx53Icr7miApI64u/vS4+xpIgbqskw7AuoS1J5vdNuRx/I
	 GXcvU2kZzIe3NBvMJFYr0RzatKrzsVl/jbAulzSu0+wPj596AC5UKJmXkmv+gJkxQw
	 Msgfwo0+YJl5i/3IC0oOPeDlAom7VOSswkkp3/PM61LodehcIIVUK8VQSRkUZzIdRB
	 oxTqvNXlHXvy23MXyhLhG3ND4mS8fjCwcavENcpaiaLXjtbmwntKtoR8nm7hKYqQDC
	 Jb1NcGJikWeqQ==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1f48b95a46bso6456075ad.1
        for <stable@vger.kernel.org>; Mon, 27 May 2024 00:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716795908; x=1717400708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKJlqXXBWxTZdncrTmUweWa85elS5Yd/G+CtJGHvhOY=;
        b=bjqTNluXvZl8uDtWj/K1BLsXqvu+nFRHPzRA/MYKh1HwlOrjNoeb75IEw+coljWZCN
         XrW5/NkAVDV5H2WffO7V4IfsuhroMgoflBNdWdcvVotncoNAeTjTW4ivKF1OhwiqM/Fe
         iX8FmYeknlTQQMTM+oiujSf77M86ZEod7sw8SSXHYC62fPT8rmSQkxFoFYtRo4TOOm21
         PRc5xMk+iNR4Vv4I8Zqqyu15Z/iiBDjelbmPR3yaoQyti1OogH1541ttW5yXv43Oousf
         s/1gYEBYxPZwPyiqHCuCmEJvYaIVFeroVdDfAgqrVqFQO6vyYqoiBwa1zmFGtPhjW+8S
         3X9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlmc1dj1Sp7LtZF00HCP+K7PKTx3rRaeJnxI0SSUyC1RIHgEgT4ebT0cLTv4BshS5tBLcakG+hNBhgOeMZ89DP+JpfUz01
X-Gm-Message-State: AOJu0YxlxU+TyHG2ox0bUCxa8bQBZT7RanZ5kf4I7SlSf5AoONGTu/Ay
	Vs6lE8k+ARsO21raki07gDRQ4o30XhTETDN/yTE/Bu3U4dY+GSPVdyXBu8qJQXSzsscmUAoyzbQ
	lXfJxx/IhQ+cNzR9TVYsFw6lPnuRbNGHCTEzHDjPofToAKOA4dMv6diTSXJUvTbO9EWK+iA==
X-Received: by 2002:a17:903:32c2:b0:1e2:9aa7:fd21 with SMTP id d9443c01a7336-1f4497db381mr84970065ad.54.1716795907685;
        Mon, 27 May 2024 00:45:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFubTHVSQn/kO3LglR8Ud8SJ6R07rDQ7c+0cFnGPKehvgk91gfVJ0j9e6cIAYJu8GB82vzCWw==
X-Received: by 2002:a17:903:32c2:b0:1e2:9aa7:fd21 with SMTP id d9443c01a7336-1f4497db381mr84969955ad.54.1716795907341;
        Mon, 27 May 2024 00:45:07 -0700 (PDT)
Received: from chengendu.. (36-227-176-221.dynamic-ip.hinet.net. [36.227.176.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f479010035sm29573505ad.82.2024.05.27.00.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 00:45:07 -0700 (PDT)
From: Chengen Du <chengen.du@canonical.com>
To: willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	loke.chetan@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengen Du <chengen.du@canonical.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] af_packet: Handle outgoing VLAN packets without hardware offloading
Date: Mon, 27 May 2024 15:44:56 +0800
Message-Id: <20240527074456.9310-1-chengen.du@canonical.com>
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


