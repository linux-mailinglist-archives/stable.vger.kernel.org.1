Return-Path: <stable+bounces-95028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A91C9D74A3
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9496DB66B5A
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBF81F8EEF;
	Sun, 24 Nov 2024 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceZGW94u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE641F8EE7;
	Sun, 24 Nov 2024 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455757; cv=none; b=hPE3BPRIu7OTKP2XgfARIVVxSdRUDdQ2STj1utYof5MIRhiUE0WQtLDgPDJn9GNBYlip/76ipj8JIsv4zJXFzB9opjmK4UD9auVcLTLaCypSRnXusObV2w3GNqXLDmbU6Y4wNmvQeIK1CeAfkGXAb443X5PHnozDouWicLk675U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455757; c=relaxed/simple;
	bh=/KFNwNO08aOZa5cYfqyUiitHoceudOv4tmkeEsw/1P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLglWsrPU7SjGUgI9hYBIdgd+RXxmGqUQBnB9oUx7MYwsERSc5M2xjuRiOI31M+QkthRUY0xZQht4F9kldb54gJBALS3+YTOMVCnfAFhvoMBJGwtd6TA4QIcEQ00MKF9l8ghrtaZ7PPMXrDTzcU2UBS75JnJgrB7iQs1yqN5B1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceZGW94u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D30C4CECC;
	Sun, 24 Nov 2024 13:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455757;
	bh=/KFNwNO08aOZa5cYfqyUiitHoceudOv4tmkeEsw/1P4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ceZGW94uCs+bnPt336OXDQEFwlXZQpDcWtQluxpj7bEG5jRbtFu0sevfbYSswe2iq
	 8cgVSmoQHWQRb16a9xcIPAm570LBvcBDmyxjlbqB/43c+ticrV8Ha9+bKPz81rRZo2
	 6OyqN4ETCzPWcnkaaAmY/1sP0Fz9vCV17HRHmUgtUXxbyCyj3ks7lWsSFNt7iwKDVI
	 WFxV23LBpXlwR9yhIIv5sH+QxDXoociEkiL4Nv8ErPVYB6kWummg5T4vRuy1TAr9sO
	 xC4ausAZCDm6ZKFDE2Gyfe65BuhoS8mpzOn8v3rZQFpnJZrZzBeEjD/wTy5iDvv7r5
	 7VKK43ya+um7A==
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
Subject: [PATCH AUTOSEL 6.11 25/87] r8169: don't apply UDP padding quirk on RTL8126A
Date: Sun, 24 Nov 2024 08:38:03 -0500
Message-ID: <20241124134102.3344326-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index 91a8c62b180ae..6e449fe6c7436 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4220,8 +4220,8 @@ static unsigned int rtl8125_quirk_udp_padto(struct rtl8169_private *tp,
 {
 	unsigned int padto = 0, len = skb->len;
 
-	if (rtl_is_8125(tp) && len < 128 + RTL_MIN_PATCH_LEN &&
-	    rtl_skb_is_udp(skb) && skb_transport_header_was_set(skb)) {
+	if (len < 128 + RTL_MIN_PATCH_LEN && rtl_skb_is_udp(skb) &&
+	    skb_transport_header_was_set(skb)) {
 		unsigned int trans_data_len = skb_tail_pointer(skb) -
 					      skb_transport_header(skb);
 
@@ -4245,9 +4245,15 @@ static unsigned int rtl8125_quirk_udp_padto(struct rtl8169_private *tp,
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


