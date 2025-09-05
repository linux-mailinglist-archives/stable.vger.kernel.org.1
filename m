Return-Path: <stable+bounces-177863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4F3B46073
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 19:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FAAE7A7C57
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 17:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A03352FC1;
	Fri,  5 Sep 2025 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qw8tbN4G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8706830B537
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094176; cv=none; b=Y4ZmdffcvmeQSqNHQIuyp+KTjF4l5BEwqcBmNdjVXRRad8NaDGql0DQ+SXHz0NxzODQR2UxSui1IXOf/xwTwonXsGf9ykpAwczdyc71NUf5v+99vVPvoqA9WHJ96IUJRHOY2zIJ1iEsjalkj08V0oJMuuFu6nzJhYIn6jHctuOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094176; c=relaxed/simple;
	bh=pO2pue0u027KZG2EIjC17r12YrI1dyESt+5qdi/0VO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2ijb3UWWO5NgIRjFLHV86aMg82dOEkKaaH3dtiO9LKbns4cVj3F5dM0/2UpnKWKzpEN4cjtIUZHWnLfEwDXV7pNG0eqHrch7RYl304njcXBEmNGnQ/sxTFXUw6or2/zisZKPnoXJ+q2BkSy80mxnbpbPUfa4jAuU+pjIpdl3Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qw8tbN4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DE0C4CEF1;
	Fri,  5 Sep 2025 17:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757094176;
	bh=pO2pue0u027KZG2EIjC17r12YrI1dyESt+5qdi/0VO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qw8tbN4GQ4j5disWLAjLpm1jZwTTmA134T5QQuHHLO2tC68OA+29PgP2WD39pGUo4
	 SaH2Gu5h8zvOEjkl17u5wo9nsTySLqfpytmJTC+SkuKx0mmJd01gtA+gQASpEDSNde
	 eLRhRoni+VgybG0LiZYQKb6otaAeqq9xRBLpupnACcL6ZtTRXZ1Ryo45R3cEOFE/Bc
	 2JrSMGZ3RTZkXdux3NvX+KQg5HT678cTNssf5lqCy07txdqFsgcLUIXUOuGzyNycCY
	 FtdSH1erKVK4X9lheXLy5SPKRrpB0GDCIxBHWgvMYyStwn4pAHceJIaE04CSG/OJhf
	 2mh3bh8W30nrg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] net: dsa: microchip: update tag_ksz masks for KSZ9477 family
Date: Fri,  5 Sep 2025 13:42:52 -0400
Message-ID: <20250905174253.2173195-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025052457-rise-remodeler-f63d@gregkh>
References: <2025052457-rise-remodeler-f63d@gregkh>
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
index ea100bd25939b..7bf87fa471a0c 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -176,8 +176,9 @@ MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ8795, KSZ8795_NAME);
 
 #define KSZ9477_INGRESS_TAG_LEN		2
 #define KSZ9477_PTP_TAG_LEN		4
-#define KSZ9477_PTP_TAG_INDICATION	0x80
+#define KSZ9477_PTP_TAG_INDICATION	BIT(7)
 
+#define KSZ9477_TAIL_TAG_EG_PORT_M	GENMASK(2, 0)
 #define KSZ9477_TAIL_TAG_PRIO		GENMASK(8, 7)
 #define KSZ9477_TAIL_TAG_OVERRIDE	BIT(9)
 #define KSZ9477_TAIL_TAG_LOOKUP		BIT(10)
@@ -302,7 +303,7 @@ static struct sk_buff *ksz9477_rcv(struct sk_buff *skb, struct net_device *dev)
 {
 	/* Tag decoding */
 	u8 *tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
-	unsigned int port = tag[0] & 7;
+	unsigned int port = tag[0] & KSZ9477_TAIL_TAG_EG_PORT_M;
 	unsigned int len = KSZ_EGRESS_TAG_LEN;
 
 	/* Extra 4-bytes PTP timestamp */
-- 
2.50.1


