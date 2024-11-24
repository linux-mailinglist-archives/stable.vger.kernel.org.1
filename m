Return-Path: <stable+bounces-95161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A641E9D73F8
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DED2B2E7A5
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AEE231A6A;
	Sun, 24 Nov 2024 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y35FdT75"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD46231A60;
	Sun, 24 Nov 2024 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456211; cv=none; b=MKqDnm9YlQJzUDG+JWKSvS7NcsM6yhASTua7cQYP9/zDuSvPp1G92EzkqEdR+GuB90JUXJZnZGtHdyCg7UsFMkZI5ZMLeBdRabuigI9rt6ST9EdibHNw2ZHUaOcLIawTbtP4xvMw8A5/+jvJYb/CPeyq0ebihJDk4yyIz0LnTV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456211; c=relaxed/simple;
	bh=0/lrJt4Pun9VQjyKeRPChgB3iJEeiN6zRRQU3gspIBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnraBmspGHw5hepR7HHhfyAsniVlN8TFByhrE91SdkG61Bwz+XSxZVEl8znEJH/ZfTH3LVY0o4O2B74fx07K0xSmZMAaSsHbrG5JrPi6FQP4ZBbhL2HcTtOOfIbsFfaUKELoeZCsYFk5vWueLqG54ng4B4HrMZ+Rhnd54sbs3y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y35FdT75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85A4C4CED1;
	Sun, 24 Nov 2024 13:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456211;
	bh=0/lrJt4Pun9VQjyKeRPChgB3iJEeiN6zRRQU3gspIBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y35FdT75SRyQnskR/qHxkeIv2OFRtRvUrI5SnpTR6utxFDkqm2XBx9QeRGk+vngVP
	 2Fz2monIpVzVZJWPKogzJs5oSBHWT9hNzaK2qzidTzBe+/FaXtIOZLFS2gVp49xNV8
	 3ETqSOKSUf2l7YpONBKWYY6by8lCW6inAnD3xhb5fhmeBTR2wqvWtu8IUiBG3ckmfV
	 JHyISMuG/+ipyT4lVGQaazNHaP1sQMC/j3KzzKg0Z+XWCa19bwjtGKaBwhdtNPuaYv
	 +T+spOAH3Q1rO7imvWpfhbBFVyJ422CH9G2ULuioQS54p8kJH6azkwtcjo6pa+u9FG
	 s3leczNlxgvrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	nic_swsd@realtek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 10/48] r8169: don't apply UDP padding quirk on RTL8126A
Date: Sun, 24 Nov 2024 08:48:33 -0500
Message-ID: <20241124134950.3348099-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
Content-Transfer-Encoding: 8bit

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 87e26448dbda4523b73a894d96f0f788506d3795 ]

Vendor drivers r8125/r8126 indicate that this quirk isn't needed
any longer for RTL8126A. Mimic this in r8169.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/d1317187-aa81-4a69-b831-678436e4de62@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169_main.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index a74e33bf0302e..4b461e93ffe9d 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4139,8 +4139,8 @@ static unsigned int rtl8125_quirk_udp_padto(struct rtl8169_private *tp,
 {
 	unsigned int padto = 0, len = skb->len;
 
-	if (rtl_is_8125(tp) && len < 128 + RTL_MIN_PATCH_LEN &&
-	    rtl_skb_is_udp(skb) && skb_transport_header_was_set(skb)) {
+	if (len < 128 + RTL_MIN_PATCH_LEN && rtl_skb_is_udp(skb) &&
+	    skb_transport_header_was_set(skb)) {
 		unsigned int trans_data_len = skb_tail_pointer(skb) -
 					      skb_transport_header(skb);
 
@@ -4164,9 +4164,15 @@ static unsigned int rtl8125_quirk_udp_padto(struct rtl8169_private *tp,
 static unsigned int rtl_quirk_packet_padto(struct rtl8169_private *tp,
 					   struct sk_buff *skb)
 {
-	unsigned int padto;
+	unsigned int padto = 0;
 
-	padto = rtl8125_quirk_udp_padto(tp, skb);
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_63:
+		padto = rtl8125_quirk_udp_padto(tp, skb);
+		break;
+	default:
+		break;
+	}
 
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_34:
-- 
2.43.0


