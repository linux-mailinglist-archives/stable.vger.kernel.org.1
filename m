Return-Path: <stable+bounces-177882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5E3B46338
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 21:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FD817185E
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 19:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B178E1DE89A;
	Fri,  5 Sep 2025 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6TMJWmU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DA9315D5C
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099348; cv=none; b=YhHBmQDqBOXXFh21qgjNhDUnK+Ucljg8SXZ4Es5ohokRjQoAXb3iCspqNo2ofU1TKP9xI5Qf7tIQk/AiTpIQzo7ZPyrSfjp5P3xChd/cxgOGTsiRh+YhmaKmQWi7pvOZJOHvx0kb1smeWDNedjd4WKjd8s0DXiSv+jOpTVNwnas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099348; c=relaxed/simple;
	bh=wXCiYn31bF21z//uAWuddCoA+07S2cWlHPaeAOtiXsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ra2V3k78ihK9d9yJ5YkSNOkC27tRqCWSnrXIXXbFFjYP5Bz1vKGGvg0YTPSzfTgcJ/6LtA2cyjxeUGxwMprzmVYIiuVCkxbSGz3jGOi+BtyzKsWwt9orLQmBMGWaVst4EpzowiCQqkU0Oo0MB+nBQXuZBUP9WFZvPYIR4S7Z1dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6TMJWmU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848A1C4CEFA;
	Fri,  5 Sep 2025 19:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757099348;
	bh=wXCiYn31bF21z//uAWuddCoA+07S2cWlHPaeAOtiXsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A6TMJWmUl70TMM5Wrp5aus16/u8Dbt5BBWTkAlUUNk9ux/doYRIAYfaZny5F9yoHT
	 GCkxf9huOFfEx/1QcXsLnKbbCGb1Xyr08HNIblTd4ICkED5RcM7iNbhJPLEeApu7Ji
	 A2loO0aAXNFSbih3sSE3cP4bcF8wknIduuxhiAgqT+HvS8Sb8tGXjPMieBVwq0iwqK
	 UAVpPTcgwaohKyqxyekgE3uCDG+APFdB06IZd5yeazSwAa/DSQZpHlQyBGSGUY9vm6
	 2eREngftimPNYwyb2Ztzgo7qIg65xwhUeFN1P/lHMlKxhnHF44z1IFhwBN9ceyIlEQ
	 ur4sMuvTP86bQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jakob Unterwurzacher <jakobunt@gmail.com>,
	Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] net: dsa: microchip: linearize skb for tail-tagging switches
Date: Fri,  5 Sep 2025 15:09:04 -0400
Message-ID: <20250905190904.3316478-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905190904.3316478-1-sashal@kernel.org>
References: <2025052401-envious-gossip-9e66@gregkh>
 <20250905190904.3316478-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakob Unterwurzacher <jakobunt@gmail.com>

[ Upstream commit ba54bce747fa9e07896c1abd9b48545f7b4b31d2 ]

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
Link: https://patch.msgid.link/20250515072920.2313014-1-jakob.unterwurzacher@cherry.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/dsa/tag_ksz.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index e949d374b26ab..836dadb8ab347 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -68,7 +68,12 @@ static struct sk_buff *ksz8795_xmit(struct sk_buff *skb, struct net_device *dev)
 static struct sk_buff *ksz8795_rcv(struct sk_buff *skb, struct net_device *dev,
 				  struct packet_type *pt)
 {
-	u8 *tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
+	u8 *tag;
+
+	if (skb_linearize(skb))
+		return NULL;
+
+	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
 
 	return ksz_common_rcv(skb, dev, tag[0] & 7, KSZ_EGRESS_TAG_LEN);
 }
@@ -134,10 +139,16 @@ static struct sk_buff *ksz9477_xmit(struct sk_buff *skb,
 static struct sk_buff *ksz9477_rcv(struct sk_buff *skb, struct net_device *dev,
 				   struct packet_type *pt)
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
 	if (tag[0] & KSZ9477_PTP_TAG_INDICATION)
-- 
2.50.1


