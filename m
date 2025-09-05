Return-Path: <stable+bounces-177871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03789B46201
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 20:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8233AB6FA
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 18:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61884305946;
	Fri,  5 Sep 2025 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRO72v3O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13819305944
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757096081; cv=none; b=KL+127dcpXKEchG1zJ/BqSLu31FZ97q4SS+MYP8jPSwZ7DtzfNEHdJ+x7pclsLVvKUkdVFe925lKVES7GPA4niXXachxxs5x7uwQk1y5POSg+eZGKowXkajNoLBc0gjci1/n/DIOZe2vvi957z8MCHPSLGsU5jlM+vXsfQ6FqBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757096081; c=relaxed/simple;
	bh=5NnjlrFp4Iiy5YrZf+WhsByhEwfdzvowj2x1F35hp40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrNDdTWnvt6BwE6K5vjm0UwJmK8gMoZH+A4evqKvU0rEbxfGdFpr2J7G05YPy9rwyHh22sJCrLfqsrlzOtEgJzuK2XjGMzb8X8oT5h0Kw0uozeTZqj8/Lx4YemKhVga0lYCyLZ6emwFyRjNnm8fURU2ePiWeaaCgtdX8TGVCN4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRO72v3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2411C4CEF1;
	Fri,  5 Sep 2025 18:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757096080;
	bh=5NnjlrFp4Iiy5YrZf+WhsByhEwfdzvowj2x1F35hp40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qRO72v3OvCS025nohEeX0V30RlK20w2tNRgLhtift7VqXE+HyNB9t2/zxtqLupaJf
	 ljMQuPpZ1I7NuxAB9yL+M6fBrrJPNI7GhQwF3L05iyvZ2wYBvww09to5+JhYhklf9r
	 iIeAKl6NIbp8oisAC+/EfjfMDntJJj9Zbnx7Mz6LwY8GX/xIswi0RzkIuhVkGQtC/A
	 /TqJMmjPUaGGdoLJCkZ+fWY4MtizdRfbBFgvK95VUwuEuuzwCxn1pJ6T4JwOa71GBa
	 zYZKSg6KEK+XIsy404XxN4pfVtrSEjFmHV3n4BXijRXiiwbu6kCkUvoiduuU/Hq3No
	 I5mLDg38OeS6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] net: dsa: microchip: update tag_ksz masks for KSZ9477 family
Date: Fri,  5 Sep 2025 14:14:35 -0400
Message-ID: <20250905181436.2943036-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025052458-escapable-extended-8ea5@gregkh>
References: <2025052458-escapable-extended-8ea5@gregkh>
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
index 429250298ac4b..809de53d443c2 100644
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
 
@@ -137,7 +138,7 @@ static struct sk_buff *ksz9477_rcv(struct sk_buff *skb, struct net_device *dev)
 {
 	/* Tag decoding */
 	u8 *tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
-	unsigned int port = tag[0] & 7;
+	unsigned int port = tag[0] & KSZ9477_TAIL_TAG_EG_PORT_M;
 	unsigned int len = KSZ_EGRESS_TAG_LEN;
 
 	/* Extra 4-bytes PTP timestamp */
-- 
2.50.1


