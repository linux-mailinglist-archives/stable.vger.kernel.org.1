Return-Path: <stable+bounces-144479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8713AB7ED4
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 09:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF2B4E0829
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 07:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD6A202C46;
	Thu, 15 May 2025 07:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXAxaqQN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC68A27A935;
	Thu, 15 May 2025 07:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747294176; cv=none; b=hk0VC0iqHvE6KkBCIVl31EKGmThKsJFWMvphW1Kf9lO1dX6JBp2Ud09htjUboBDmfQZk0bsP9sHHAAeKp7EdqMuXztIPOs8z4dylj+5jsc0Pfn3v8dk8wdiktSyrpcjXbFzUpV3b+9+spxs40VppeIqqz4NFCUZiE1It3WFGMXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747294176; c=relaxed/simple;
	bh=xT73YG7vjavilCxVefcwNrXMNUFIuptsDRvlJC6qVKY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I0rJeGrfBRnJFypOpXrfZMUV6QtxeSAcSJlxdPsSCIM49o2aXsqSda8vh581R29rpoHm3NDNbzNidSCXJB8imhflGcy22u9R8EbQXdcIsRs/Z3Sdo9gTixEU4aTpesANfv/2McvZmmpS5fNcP0BtlFwA6FDZQ0Vmkbq/pLwb/6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXAxaqQN; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5fbc736f0c7so934817a12.2;
        Thu, 15 May 2025 00:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747294173; x=1747898973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IcSede8Su1QJmSqSFnb7duRkTxUsdythasqSlmba4ww=;
        b=KXAxaqQNEaggWxwTeW4Iovce3tTc0RvwZjFBO+GwKCpiM340QnQ4IG+SKZMVVKNYhB
         1gWuXKsPxT0M+Wuta21EDv2KxDixERJehFkYPBJEtKhHGETIzwP5oScRcnOfPztVFAKo
         v+EqizBr6J2iKJAi5AlMHFtob8HxtyFfivs/HnTwlnfL0RFF8TWkX+FulG0QTevAceYp
         ZasxpBoUjslZh+c4lrDfouaaSM0fYVAhn0vFB03idLLPRo7PS1pOqZjPHSmvEh83tQGI
         bosvBZu3+ivzsLdJmFHAXb2QBHLMaWDkkGHy0X/3Vi6JyIiZhqrKqMkqjttxrQLHvBWP
         Yqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747294173; x=1747898973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IcSede8Su1QJmSqSFnb7duRkTxUsdythasqSlmba4ww=;
        b=mne2JKnLZ/HY7rwt9Z0oA1W/VKyQh/IlPVysanGXcvmjQ65OTHYioDjBpKqBptooV1
         XgLsiJWhI6XgKTCr848Er64lCMoAQ/hNy/VZbohXcRYThx1wbvD+KA9Wlu+UhV1sxFK3
         b9TL4VwEhbaS6zjpdVYMOWE0avy58dRCooNHBknBaxU8kAABF0IhM+oYXagqRrQtk8HS
         oTV7C/8wIt29QJbFLpnCkbd2MQJsLGsQvLNzmahkYuNT3Nhts1XStLZkxBwr0zlo7ryW
         fJDM/dv19wORirZvw3iDteT74pVEBkGMrNF4qao7lOClNUV6UGGSafG9N7D0HHWG+9/S
         61DA==
X-Forwarded-Encrypted: i=1; AJvYcCUanfj3h6T9y/QPSgQQHmAXk0QWcx8pjPRw/NTv8Npr0303CkgeAMkEoFFFPtnMwjBSIcrl0H8S@vger.kernel.org, AJvYcCUmejukToARwfuBXC6+peFS9ryMQdcj6ZbHHJlUNq7mMk33VLP0IFOE2AvAiMP3K3x/1/L2DgIN@vger.kernel.org, AJvYcCXBoR1OcrcbPI8rOWN5F1meP7TDsF0Ghs4Ocgn4KpnFYN4CPD8kMo32KkgQnC96ZceFY7nxkm5dhMNFT10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc/gAlVHmbOnuyawZVxlU07v7qzEpd6ndXOQzamS2hq4KDFEeL
	gKeZWZgPB4/VCYKpMU7gloWlM56CPQyGUAIJs5ckdxGy2JA4avV4
X-Gm-Gg: ASbGnctfSyvs1S+zbaLGB0avfdQfmCvWGHnfuEXLCA+y14NSFX9vvIh5VfnKcT1y8EK
	DXFXEYFMxrLL5PaWSrf8H72IVGY4WFR7PqaiBk7VrlLcMUu9JKXNUDa0Dtl6US24GGNP5PP6fyn
	9QU+4mVY4PoNQAYactoGmFTfZHczzsNaZdj8DqdFUoP6bEvTw6lz9+BZCKVIBy1/HJgxE39g2vY
	TXh2xiFg+oaI2w1yUUeDgHGspGgRNActDndSbIPG4Gepc3g07kUJrY/LiYfb2O7/dbOAf+hOrn9
	Y4p6hYq2tmejbdCSA0oN1xyQ3HasDZQCIzOtu8bSnNPxxXBy8K8zgxYWkx9vFwZdt6mGTGVTT1r
	CMokMM57O2gjiwiDGsyPv5doNi/w72A==
X-Google-Smtp-Source: AGHT+IFSVVDRt3x2PXh3uMgcCoYQ2vtPrrvFgkELSqshxtEzujh1920Xxoj08IE6nOwdDjFPPstsVQ==
X-Received: by 2002:a05:6402:84c:b0:5f8:36b2:dc1a with SMTP id 4fb4d7f45d1cf-5ff988ae1d0mr5580189a12.16.1747294172762;
        Thu, 15 May 2025 00:29:32 -0700 (PDT)
Received: from localhost.localdomain (ip092042140082.rev.nessus.at. [92.42.140.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cc5144csm10064410a12.41.2025.05.15.00.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 00:29:32 -0700 (PDT)
From: Jakob Unterwurzacher <jakobunt@gmail.com>
X-Google-Original-From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Marek Vasut <marex@denx.de>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: quentin.schulz@cherry.de,
	Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>,
	stable@vger.kernel.org,
	Woojung Huh <Woojung.Huh@microchip.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] net: dsa: microchip: linearize skb for tail-tagging switches
Date: Thu, 15 May 2025 09:29:19 +0200
Message-Id: <20250515072920.2313014-1-jakob.unterwurzacher@cherry.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pointer arithmentic for accessing the tail tag only works
for linear skbs.

For nonlinear skbs, it reads uninitialized memory inside the
skb headroom, essentially randomizing the tag. I have observed
it gets set to 6 most of the time.

Example where ksz9477_rcv thinks that the packet from port 1 comes from port 6
(which does not exist for the ksz9896 that's in use), dropping the packet.
Debug prints added by me (not included in this patch):

	[  256.645337] ksz9477_rcv:323 tag0=6
	[  256.645349] skb len=47 headroom=78 headlen=0 tailroom=0
	               mac=(64,14) mac_len=14 net=(78,0) trans=78
	               shinfo(txflags=0 nr_frags=1 gso(size=0 type=0 segs=0))
	               csum(0x0 start=0 offset=0 ip_summed=0 complete_sw=0 valid=0 level=0)
	               hash(0x0 sw=0 l4=0) proto=0x00f8 pkttype=1 iif=3
	               priority=0x0 mark=0x0 alloc_cpu=0 vlan_all=0x0
	               encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
	[  256.645377] dev name=end1 feat=0x0002e10200114bb3
	[  256.645386] skb headroom: 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	[  256.645395] skb headroom: 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	[  256.645403] skb headroom: 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	[  256.645411] skb headroom: 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	[  256.645420] skb headroom: 00000040: ff ff ff ff ff ff 00 1c 19 f2 e2 db 08 06
	[  256.645428] skb frag:     00000000: 00 01 08 00 06 04 00 01 00 1c 19 f2 e2 db 0a 02
	[  256.645436] skb frag:     00000010: 00 83 00 00 00 00 00 00 0a 02 a0 2f 00 00 00 00
	[  256.645444] skb frag:     00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
	[  256.645452] ksz_common_rcv:92 dsa_conduit_find_user returned NULL

Call skb_linearize before trying to access the tag.

This patch fixes ksz9477_rcv which is used by the ksz9896 I have at
hand, and also applies the same fix to ksz8795_rcv which seems to have
the same problem.

Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
CC: stable@vger.kernel.org
Fixes: 016e43a26bab ("net: dsa: ksz: Add KSZ8795 tag code")
Fixes: 8b8010fb7876 ("dsa: add support for Microchip KSZ tail tagging")
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
v1: Initial submission
    https://lore.kernel.org/netdev/20250509071820.4100022-1-jakob.unterwurzacher@cherry.de/
v2: Add Fixes tags, Cc stable, "[PATCH net]" prefix
    https://lore.kernel.org/netdev/20250512144416.3697054-1-jakob.unterwurzacher@cherry.de/
v3: Move declarations before skb_linearize call, pick up Reviewed-By

 net/dsa/tag_ksz.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index c33d4bf17929..0b7564b53790 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -140,7 +140,12 @@ static struct sk_buff *ksz8795_xmit(struct sk_buff *skb, struct net_device *dev)
 
 static struct sk_buff *ksz8795_rcv(struct sk_buff *skb, struct net_device *dev)
 {
-	u8 *tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
+	u8 *tag;
+
+	if (skb_linearize(skb))
+		return NULL;
+
+	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
 
 	return ksz_common_rcv(skb, dev, tag[0] & KSZ8795_TAIL_TAG_EG_PORT_M,
 			      KSZ_EGRESS_TAG_LEN);
@@ -311,10 +316,16 @@ static struct sk_buff *ksz9477_xmit(struct sk_buff *skb,
 
 static struct sk_buff *ksz9477_rcv(struct sk_buff *skb, struct net_device *dev)
 {
-	/* Tag decoding */
-	u8 *tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
-	unsigned int port = tag[0] & KSZ9477_TAIL_TAG_EG_PORT_M;
 	unsigned int len = KSZ_EGRESS_TAG_LEN;
+	unsigned int port;
+	u8 *tag;
+
+	if (skb_linearize(skb))
+		return NULL;
+
+	/* Tag decoding */
+	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
+	port = tag[0] & KSZ9477_TAIL_TAG_EG_PORT_M;
 
 	/* Extra 4-bytes PTP timestamp */
 	if (tag[0] & KSZ9477_PTP_TAG_INDICATION) {
-- 
2.39.5


