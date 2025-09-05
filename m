Return-Path: <stable+bounces-177884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B277DB46382
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 21:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 752665C1CC7
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 19:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6A6277017;
	Fri,  5 Sep 2025 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKrRAiAr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE2F2750F4
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100168; cv=none; b=kBMSrx8emvo2Ir/9HjE/DlNQpsOxc6QJbN5bV1hJmFFfNGicPJu+fnuTJ2ZMuQNBSzugwYCBZWpUWshVv13msVQYLrpM7/ealJCh22dxXXwjvX3YJGpRBHW+B9H9o1GiaM0+WegUEO2l4abumOJ9/L2zWzEFbHcYpcz5/ag7xKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100168; c=relaxed/simple;
	bh=SbC/HnLiKGsfOBMZxM59KaOdEmVWrqn4p0d1ygsTrSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r98/J2ai6GuMngp1HJ+UoSQZuZSVdQllQAKPkn1fFinNhZ43Oftsc2Z2dLjKuVlDKo8DDZbZsu81mhpYIJjALs59JFP7YjBHc98kvgg8xEQt8zKxGNzJDIB2TYhaWe98OsiOqQuENXHQtCk6boVVTTNaFki9AUvNxYd/apgXndI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKrRAiAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216B0C4CEF1;
	Fri,  5 Sep 2025 19:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757100167;
	bh=SbC/HnLiKGsfOBMZxM59KaOdEmVWrqn4p0d1ygsTrSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eKrRAiArkEBODoy0A/gYXTeeM2Nx0aGZf2ad74q7m+Ed13N5gfceSIB+vYuQ4KPCb
	 OvZgk4ObC6WIAPf6dXFbPpIHR5KpTAPJEcbDyT9I41OOuDQPBoHl9GMKdUXThMzCjH
	 5M55WfnaMGRdgmYRQv5od+EQnqcYorrh0kFOvd9Lx//yj+CkLzHtswiaCCP/jZ0C01
	 Eo7bAN5gjjGgor8abPZSZAs+G0gchdJvkJSKbquxlmoS5ogVk81ZlKkZlYUxv62V0U
	 nxfAVIWF800h5jckaqQuch7Ufqo8P1RAKqc+d0FSq8i8RvSuk51cNVH7LfzMP/4Ri4
	 Ht33Bg/+y9HmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 1/2] net: dsa: microchip: update tag_ksz masks for KSZ9477 family
Date: Fri,  5 Sep 2025 15:22:44 -0400
Message-ID: <20250905192245.3322547-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025052402-concrete-panorama-6840@gregkh>
References: <2025052402-concrete-panorama-6840@gregkh>
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
index 7354c5db3a141..919d8ea512453 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -149,8 +149,9 @@ MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ8795);
 
 #define KSZ9477_INGRESS_TAG_LEN		2
 #define KSZ9477_PTP_TAG_LEN		4
-#define KSZ9477_PTP_TAG_INDICATION	0x80
+#define KSZ9477_PTP_TAG_INDICATION	BIT(7)
 
+#define KSZ9477_TAIL_TAG_EG_PORT_M	GENMASK(2, 0)
 #define KSZ9477_TAIL_TAG_OVERRIDE	BIT(9)
 #define KSZ9477_TAIL_TAG_LOOKUP		BIT(10)
 
@@ -185,7 +186,7 @@ static struct sk_buff *ksz9477_rcv(struct sk_buff *skb, struct net_device *dev,
 {
 	/* Tag decoding */
 	u8 *tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
-	unsigned int port = tag[0] & 7;
+	unsigned int port = tag[0] & KSZ9477_TAIL_TAG_EG_PORT_M;
 	unsigned int len = KSZ_EGRESS_TAG_LEN;
 
 	/* Extra 4-bytes PTP timestamp */
-- 
2.50.1


