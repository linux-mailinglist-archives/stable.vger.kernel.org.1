Return-Path: <stable+bounces-46274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857B88CF928
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 08:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3D3281EAA
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 06:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566D9101DE;
	Mon, 27 May 2024 06:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="FZCvON5z"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4316D10A36
	for <stable@vger.kernel.org>; Mon, 27 May 2024 06:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791516; cv=none; b=aGUrB+vcFJThOKQv6c7//gzEVMoTXaQDmOh1L9yylNde0gyIMsx2ir4cIsnRBXIfh+DW49U+N0FAo9mW6Jy/qc42DDw2Y2MgYtaibmiT+SXSneXkeIOmArWwSTbrpsBG8eHfkzkeMKF/FYZJFYFb7E9mRd/WfS23X6ptkATi56E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791516; c=relaxed/simple;
	bh=GiX/F6U+4AhQxOl6Y7hnIeCCOl0QPSSAqz7DQ9FqL6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sirq21ACdJDs7gTnY9TYO7rALD8qrBKnAJmE+AkXkbZIPgp3jkN7duHOy3AA/dLaourXGuEnp1/MncvZvNyxwtLJsZnhZoufiKxZp2HjDGoI/Ku0CMfley9IDjpjJ6VQxfR2VGm+wCnlupli4ACAaUHImhqI1uWhfIl0vhZIEKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=FZCvON5z; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E6D1D3F1CC
	for <stable@vger.kernel.org>; Mon, 27 May 2024 06:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716791511;
	bh=MbnK7btCma2THOpFcDrHSellO+iE5ad9pZfYFL7rGkU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=FZCvON5zGdX1O61DfHue+fp4tvnVGxUiYe86rxSls6BF36m4Ndlkd6pLaW+7i3AdG
	 HKAx/ltGkSVzCGe3zPtLcThaLBnXH0HzkCVYdgtUviTFzYt6lOORIte6ki19Rgaf4B
	 jVUcMulGwEYJIlkOUg3XyMKrF/zn5DYEXLd1/LMCBjrk2+LWZ3qK3lIu4SM26ie68m
	 Zv9BxCHiIr/PNr02TnWQSUCx+MtgpewHDWAxRvjKJuGOAZYWtMhOTren+oh+QRsVW5
	 Rj3gJG0JVb7rXDwLToptnPFT12GdjksGE6LlQHnga2G2pVf/X1PyJihboPvqjGevR6
	 ZiSWwu0jt/xaA==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1ecb7e1e3fdso23321435ad.0
        for <stable@vger.kernel.org>; Sun, 26 May 2024 23:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716791510; x=1717396310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MbnK7btCma2THOpFcDrHSellO+iE5ad9pZfYFL7rGkU=;
        b=VvXdty9nEHKex87ZzyrOfwaTviMUJEElbtpfXsBOCClFUQfq3qL8s4i/2LybEzc9MB
         5kA4nuM/uzZd1NG5kOUfpLTWD2UF8Z5pnZ94CgdnCquPTY/+25XxfCJchFyUg99K2ghz
         xPTIHKRZLDfE6GWFB4vkYH3/WPvGozExvX5K4UEgUwEIdoA/1ZfE/kERIVYLh1n888VF
         TNl25a/2X8AmyeZPabC0MQR6qvQ9xM/9Rzy+NOu8k9oc/cc7pmlfaMIIBPKKbOLzLht6
         a58hw2PMBu58goiMaE4gqy8GoYJQ3gz3x3aMXeQo3oNxsm1dgxUNpwj6tsEwxm0VBq0Y
         YwuA==
X-Forwarded-Encrypted: i=1; AJvYcCV8GBu7Pn/7zNZqScWSyJDtdQWX66p+yeexOVqjf9K5xapUUlI1kM+ReSm0h+YR123xode+ATOPag25RfdcvcWzaI1IjGaj
X-Gm-Message-State: AOJu0YzFivxVoc6s3OohNirn/gXGPWkpLTIlgsAQZOMd+QbkkzDnUmqS
	GjlfmMW8/N3PBxuR2n0CWSCJc6serMiIL6Iv6jwK0Vnnl2p1S3R9I3Tw1dzZUGDjAn5QDvoQ/Nt
	kxDC4sq7/tk70QbKsGXWYDzKpCUskWJ0RDlnHipixYBGOW0NxXTMxPjpqGCtLcknHX0VVzQ==
X-Received: by 2002:a17:902:f684:b0:1f3:5ca:4200 with SMTP id d9443c01a7336-1f448126212mr124732155ad.2.1716791510230;
        Sun, 26 May 2024 23:31:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFUziuMR/5+E+Q+QV57THPE3WYQpjvV0wcM+chWabofAbbVJ71xH4WrYKvxXh9Yk8XM+0QQw==
X-Received: by 2002:a17:902:f684:b0:1f3:5ca:4200 with SMTP id d9443c01a7336-1f448126212mr124731835ad.2.1716791509744;
        Sun, 26 May 2024 23:31:49 -0700 (PDT)
Received: from chengendu.. (36-227-176-221.dynamic-ip.hinet.net. [36.227.176.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f4aa742215sm5895275ad.289.2024.05.26.23.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 23:31:49 -0700 (PDT)
From: Chengen Du <chengen.du@canonical.com>
To: willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	loke.chetan@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chengen Du <chengen.du@canonical.com>
Subject: [PATCH v2] af_packet: Handle outgoing VLAN packets without hardware offloading
Date: Mon, 27 May 2024 14:31:36 +0800
Message-Id: <20240527063136.159616-1-chengen.du@canonical.com>
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


