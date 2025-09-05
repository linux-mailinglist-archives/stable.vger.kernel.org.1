Return-Path: <stable+bounces-177874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D11CB46237
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 20:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1575E0146
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 18:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F2123BCE7;
	Fri,  5 Sep 2025 18:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLRCfZcn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB15C305942
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757096732; cv=none; b=la+z16XDcRWau5wF1DhPVWUwzfifv2WcvEAmhpF9ChN5CE8Q5A+ofbhS+c2Y/5itlpjWcjL/W3LqAGW8f0fhJ3MStu9jgTnOLZNhqWJs1PQZXIR9uA3Yjm+FFvg9JSUjjZM2xwiEdJolVwGU2TYqVscFmGB9ly/aXPfQBuhzG8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757096732; c=relaxed/simple;
	bh=U1/eFAOICOQpUEiki9CfpG47ni221Mmpn3uGoR9Pcy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+A546IVM2q5oRSktn4MHg8OzlLdzF7UssZPtZ6gfLP3FFcB0jH3OBIrRtKn5c60QYJloxuyz34Ie+hjg4J0FOFtsSRD0MXJRiPWdyNhVEtz3aHODGTGDifgUoVXMVaNGDYkBAytHVGcn8My2MMYFx+9K+1RFPDpS6n4/w4XNsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLRCfZcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0975FC4CEF1;
	Fri,  5 Sep 2025 18:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757096732;
	bh=U1/eFAOICOQpUEiki9CfpG47ni221Mmpn3uGoR9Pcy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MLRCfZcnAk3pgqbUU7Bq2vHXPIjB6n96Yiku8ySUL0ATJJh7biVMQAACXLNmpUNBu
	 d1XD0B0zumGicXm6jABj5cKaJ/zhQLVgh3DXNyC7dKFaWnv+mNPU8+tywmJoNRGS3c
	 i/dBvr68Nx8Xf8TX8KXDgOSrH4Ln1Paw4um9QWIpnejJv41neCdKi0xGRjKlfRDGKm
	 k5TJvFCHGGsT5rCwdi5zaCaNdfqNaazwv0jAdqBlzcvmrFfl+EvQocmaECDqbLUOPp
	 wnR615XXrFFfb0WFcPcoHudiDhXBdHCSCbDCN3+0ucutBnVeGjTiRvlciaAWXwHWm6
	 YkJyxYWr624Aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] net: dsa: microchip: update tag_ksz masks for KSZ9477 family
Date: Fri,  5 Sep 2025 14:25:28 -0400
Message-ID: <20250905182530.3041307-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025052400-backpack-superior-fb22@gregkh>
References: <2025052400-backpack-superior-fb22@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

[ Upstream commit 3f464b193d40e49299dcd087b10cc3b77cbbea68 ]

Remove magic number 7 by introducing a GENMASK macro instead.
Remove magic number 0x80 by using the BIT macro instead.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://patch.msgid.link/20240909134301.75448-1-vtpieter@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: ba54bce747fa ("net: dsa: microchip: linearize skb for tail-tagging switches")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/dsa/tag_ksz.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index 6795dd0174996..922e5cd4d4f06 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -104,8 +104,9 @@ MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ8795);
 
 #define KSZ9477_INGRESS_TAG_LEN		2
 #define KSZ9477_PTP_TAG_LEN		4
-#define KSZ9477_PTP_TAG_INDICATION	0x80
+#define KSZ9477_PTP_TAG_INDICATION	BIT(7)
 
+#define KSZ9477_TAIL_TAG_EG_PORT_M	GENMASK(2, 0)
 #define KSZ9477_TAIL_TAG_OVERRIDE	BIT(9)
 #define KSZ9477_TAIL_TAG_LOOKUP		BIT(10)
 
@@ -138,7 +139,7 @@ static struct sk_buff *ksz9477_rcv(struct sk_buff *skb, struct net_device *dev)
 {
 	/* Tag decoding */
 	u8 *tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
-	unsigned int port = tag[0] & 7;
+	unsigned int port = tag[0] & KSZ9477_TAIL_TAG_EG_PORT_M;
 	unsigned int len = KSZ_EGRESS_TAG_LEN;
 
 	/* Extra 4-bytes PTP timestamp */
-- 
2.50.1


