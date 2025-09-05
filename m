Return-Path: <stable+bounces-177881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBEEB46337
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 21:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC714174DCD
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 19:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFD5315D58;
	Fri,  5 Sep 2025 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld5y28JU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9D516F265
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099347; cv=none; b=l1qXsbhqAkVaRtiQY7JPzqb08CjwB4ozUpAvBIP/Hb1Dd/n6M/mkZ5lXMmPGuQ/kQ6en+/wmKKd+MMPg4YyFBax1CKZGKnwBF9TR0N9ovPR34v+OSfD1xRimqKin47mD2mMQC1a6gCy/P2EF87c5ahFWEmpso7JpL+RfdVss9dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099347; c=relaxed/simple;
	bh=h/X9QUTGjupzoSGWf9Q76+yCHB2x/lyXoRQifYt2VqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L5V7ZrMSvKW0u47t9rAK+vz3SwbmlD8KgzzxXBfzLnwCYz8A5qT0ZIThzaVu63bT38/ZVWXWXqgU73SOkYTTtE3Hf+6ZeO7pY22a6fzyKAhjdLiGYuCxFSoJ2myGlZdusT9QAHQv5mlLawkQTtG9SzflE44Rem7aits6l7trl+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld5y28JU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C18C4CEF1;
	Fri,  5 Sep 2025 19:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757099347;
	bh=h/X9QUTGjupzoSGWf9Q76+yCHB2x/lyXoRQifYt2VqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ld5y28JUHLxVheKyRws4AZuxeeqViAahXq/XWEv6Id60DAPMVKpKsmxnxa14U/0gS
	 vll8hZjWXwjZkjUgTkskEkImJKBxJf/ljQXfgRswfk5m03HlgMvx2JcPrlxIVs9VYm
	 RyX+q/9OShFfsDiIL8yEnuSLHZjTYzXgOwfm6TbiYy7ms6NXTzxlJmMW/YsmvB/8HP
	 D1XpDjCYOlsu58oULa/+utkbtFaAIwIrhehsml3VLOjoqqfeZQzHLPKd2YuU6hV7B7
	 SvwjRHjbvLAitifWW33JLgODiVKClhmGwjibjaSAi0912RMmwTBZXPi18LnXwTrkBX
	 axnGNOWSdo55g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] net: dsa: microchip: update tag_ksz masks for KSZ9477 family
Date: Fri,  5 Sep 2025 15:09:03 -0400
Message-ID: <20250905190904.3316478-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025052401-envious-gossip-9e66@gregkh>
References: <2025052401-envious-gossip-9e66@gregkh>
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
index 230ddf45dff0d..e949d374b26ab 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -103,8 +103,9 @@ MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ8795);
 
 #define KSZ9477_INGRESS_TAG_LEN		2
 #define KSZ9477_PTP_TAG_LEN		4
-#define KSZ9477_PTP_TAG_INDICATION	0x80
+#define KSZ9477_PTP_TAG_INDICATION	BIT(7)
 
+#define KSZ9477_TAIL_TAG_EG_PORT_M	GENMASK(2, 0)
 #define KSZ9477_TAIL_TAG_OVERRIDE	BIT(9)
 #define KSZ9477_TAIL_TAG_LOOKUP		BIT(10)
 
@@ -135,7 +136,7 @@ static struct sk_buff *ksz9477_rcv(struct sk_buff *skb, struct net_device *dev,
 {
 	/* Tag decoding */
 	u8 *tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
-	unsigned int port = tag[0] & 7;
+	unsigned int port = tag[0] & KSZ9477_TAIL_TAG_EG_PORT_M;
 	unsigned int len = KSZ_EGRESS_TAG_LEN;
 
 	/* Extra 4-bytes PTP timestamp */
-- 
2.50.1


