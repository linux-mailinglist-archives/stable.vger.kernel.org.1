Return-Path: <stable+bounces-143293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97289AB3B25
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 16:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1718117D93A
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 14:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7489C22A1CD;
	Mon, 12 May 2025 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEeuRNBP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7AD21578F;
	Mon, 12 May 2025 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747061215; cv=none; b=C5xNYnrkft3ynwkHv3s3ibxfsJmO6Qhu5LU4tlGwRIVWoQatPHAqBBOnoNZU3f6/jC75rteN8ha+UZYHwu/QU4cSoGKkjsJ5ycwftwYMWVUhoHUyf1riy3nytAwhG3DpWXduyCy+zrlZdxTlx3efVSuVugLBoYmTJF268CRbMuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747061215; c=relaxed/simple;
	bh=y0vMuL7Jk3buyImcDrOCI0mRiAxBKFqw2NbBhs7V0mU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o+fW5Eg0zaNiCKXQMQ4uzrJz+pdoB936jVVI46/4/ExMEy/ehD3tIm8nbUaW1jYV3gAGE0R8z5Dy6EqxnOzUvNPej6KaxGLpgCoe+h3b1WoduNUhHDN586GbJuDBMXbTO2hYIuGyvFZAqmHLL/VfeP11J/F6BiDCa9ygfbNqiwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEeuRNBP; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5fcf1dc8737so4900833a12.1;
        Mon, 12 May 2025 07:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747061212; x=1747666012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dODwYdoTP5CLtjwQLab2m40ueX2C15m4SlmDSPZB+Rw=;
        b=EEeuRNBPe8MMCoPQg6c0+5PW/W4x7Rx+1IUooHWDYaif4kxNOAwASsARZYbTBrG7WG
         GYwLY3GssTKnko/F1ZVDet6MjgQNHWeaCA5iemOPStJ+BzzacKz+8ODlboIztidOvsEv
         +wkfVGT5aKehKcZqinRKYGh8PYbZf9xkJX4xIWAQVkaxNr+llWQ91A1QNrgGb9co5S+C
         leK7OSysQHcYuGLcdMcDDnIEOBvgyxJFxVxJ381+U+S4CWbPVUpR5YdQS9Rk+4N2c92q
         XF9UDcBTjpPAeROgt6o/enoP3kpm6LZWqTxp0cLpfoIGDC8Bt7KlCCsGZ8+NFssa/jFQ
         45tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747061212; x=1747666012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dODwYdoTP5CLtjwQLab2m40ueX2C15m4SlmDSPZB+Rw=;
        b=lMraTLMG1W66jY0rvaNlf1gWTYEkos0ot7VQa4Es3EvspVBGrhntDuDgz3U0PhyKax
         vXNIvmxyUBPvLO9Aszjg2mnvMnKbM03tNll7npDTgiGUNw4rouB7BkvCIwOW/OLXTkEA
         VZjbuGNi3YpF08raScytJz2K69Z/XWH6se7v1Ucgx7/A+bnklvaGoRQDImFPCVIRlxu3
         tlRwNIpsO2ucwDh4kbpb04jCnQ+Q/8JcPkQ9ItP2lW9huttehFebRPiIRYvyMD4QoHgB
         Z1OTOKt85WAzDP+ahzdo9dobYIwTC1p4BSPTFCPKQfQU6FpuwsSnBkffLYD4y7wYqwfD
         cLUw==
X-Forwarded-Encrypted: i=1; AJvYcCUp+HRR/Hrms0Gbf96LFn29QogVbrgOu8iHQd0nR7/ZNaXyxbohiL9ZrAk+ipICAxQMN4EBHAaS@vger.kernel.org, AJvYcCVhZ5WHDlXajeyH+TgEqZcda/Wi6VnXDux2/s2AkQT+zrCDMgiWVhi+7M05cj+IGFoLPKza4zg+@vger.kernel.org, AJvYcCWXGA9225yW63It0+2PMJA4ZTvVnj2B0TnXx0G8I3k4V2/OhZLJxSlt3uekPUG6pRBR7wIVLIVA1M+5pB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGglSfRfiLNXPTnuJUyql5bE4fZpqAKHd8tum83mg4cxMUMsNY
	OHFBIUandAmII3w2ej+I78/JtKYs3DYUnn7AAv4CUWYfqagRXQeX
X-Gm-Gg: ASbGncvzP0EZEHs8bKGENALYcLcMq/HIHhe1RvD2CvdW050k+3NG2K5wAwW2O7T25aa
	jxATbH1y/JbCsfwR230at+fTtdQbJ4yGnzRJgABpBNeZTx55NP4SmZbHHTBGyJRgBwuLKRIUOoi
	a/JQvQlEcWYXw9tuczchVDBJIaLCiIVgJza8XKdRgFxh6rC0JDg74OmgQyeS995wZxL0KYsE9cO
	MNakhwC3i2EG2oHVhMtgHcgDrYo07me05mSnUhZnokZjY4CfBHD8DM4XCTiOmy0JDbAdK0mqD+f
	/KJ4L5lbTf/eHajPKUtsDIs/gU3aX09Fv5hV3JF2IDEjEm/26xiF1P5xW2Yt0UXYfMEXlcF3ChE
	1HT3FRSA1KK2VaQ3UW2LF49z7W+3HGg==
X-Google-Smtp-Source: AGHT+IE2pf4YYuapDIgRwCICOjUiidG0buuxRhxKXdwb/npfu+yM/uc5CWac1o9ODhHsbILHbvroYQ==
X-Received: by 2002:a17:907:a08d:b0:ad2:4ed5:ca4b with SMTP id a640c23a62f3a-ad24ed5cc4bmr320290066b.61.1747061211427;
        Mon, 12 May 2025 07:46:51 -0700 (PDT)
Received: from localhost.localdomain (ip092042140082.rev.nessus.at. [92.42.140.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197be17csm620475066b.156.2025.05.12.07.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 07:46:50 -0700 (PDT)
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
	Marek Vasut <marex@denx.de>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: jakob.unterwurzacher@cherry.de,
	stable@vger.kernel.org,
	Woojung Huh <Woojung.Huh@microchip.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: dsa: microchip: linearize skb for tail-tagging switches
Date: Mon, 12 May 2025 16:44:18 +0200
Message-Id: <20250512144416.3697054-1-jakob.unterwurzacher@cherry.de>
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
Cc: stable@vger.kernel.org
Fixes: 016e43a26bab ("net: dsa: ksz: Add KSZ8795 tag code")
Fixes: 8b8010fb7876 ("dsa: add support for Microchip KSZ tail tagging)
---
v1: https://lore.kernel.org/netdev/20250509071820.4100022-1-jakob.unterwurzacher@cherry.de/
v2: add Fixes tags, Cc stable, "[PATCH net]" prefix

 net/dsa/tag_ksz.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index 281bbac5539d..55ef093fe66b 100644
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
@@ -311,8 +316,13 @@ static struct sk_buff *ksz9477_xmit(struct sk_buff *skb,
 
 static struct sk_buff *ksz9477_rcv(struct sk_buff *skb, struct net_device *dev)
 {
+	u8 *tag;
+
+	if (skb_linearize(skb))
+		return NULL;
+
 	/* Tag decoding */
-	u8 *tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
+	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
 	unsigned int port = tag[0] & KSZ9477_TAIL_TAG_EG_PORT_M;
 	unsigned int len = KSZ_EGRESS_TAG_LEN;
 
-- 
2.39.5


