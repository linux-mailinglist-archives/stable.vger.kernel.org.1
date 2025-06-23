Return-Path: <stable+bounces-158017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F9AAE5696
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C9F1C221B2
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37927226533;
	Mon, 23 Jun 2025 22:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JxWvGLTA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AEA225A47;
	Mon, 23 Jun 2025 22:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717280; cv=none; b=FW89XtM+w2eoxaIt0xdHjqifnYIZB4hnN4yw/gRe5lEUruQpcazr5dZqYoug75Iwc9nAulO+2RsREDRc4i5wwCmUB2qtrylkHn/BC22sAfHrxzsjOzD2tz2Y+VZHHJZyGcT/O1lZ3lk+1DXfQd/R57TCx7501mnspOOequcyQ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717280; c=relaxed/simple;
	bh=X52zl2bdaQ4UjnDohsNoaxxUJokEWXa2GXPCjfHuaiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mc9EaA66U0UgZoOxY4SR0p5xxz2a9SDkOn45bzpbmnJ8kXNjpQh0YKj+Uz/omtI0RSw4j/sV8GUsjoCNaFyAJ3OLvbcg7qfRa0rvNyOyuOEAHA6Syzx5I8RT1JUvdItm7N+rXboU9H4JTK5P3W9vOJPyDWjueMrBz5bWMvVCWmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JxWvGLTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82065C4CEF6;
	Mon, 23 Jun 2025 22:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717279;
	bh=X52zl2bdaQ4UjnDohsNoaxxUJokEWXa2GXPCjfHuaiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JxWvGLTAU1jXI2jZW/dxpYnOjiZrRA2NkpDB5XQa3q0dNB1s1RbWOqGs2CptLdVjS
	 0lIhRej4xbleqfYE6DK4znVKV4oFVw30Ev6GRn8brrNzOzIVmh7t6DOmi4D7i3UK2L
	 V2nMlFis7KHomcZsDMO87gxYexYhI9SSoPjQG8y0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Samuel Williams <sam8641@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 394/508] wifi: mt76: mt7921: add 160 MHz AP for mt7922 device
Date: Mon, 23 Jun 2025 15:07:19 +0200
Message-ID: <20250623130654.961901436@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Samuel Williams <sam8641@gmail.com>

[ Upstream commit 7011faebe543f8f094fdb3281d0ec9e1eab81309 ]

This allows mt7922 in hostapd mode to transmit up to 1.4 Gbps.

Signed-off-by: Samuel Williams <sam8641@gmail.com>
Link: https://patch.msgid.link/20250511005316.1118961-1-sam8641@gmail.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 5070cc23917bd..7adda1718d6ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -104,6 +104,11 @@ mt7921_init_he_caps(struct mt7921_phy *phy, enum nl80211_band band,
 			he_cap_elem->phy_cap_info[9] |=
 				IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
 				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU;
+
+			if (is_mt7922(phy->mt76->dev)) {
+				he_cap_elem->phy_cap_info[0] |=
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+			}
 			break;
 		case NL80211_IFTYPE_STATION:
 			he_cap_elem->mac_cap_info[1] |=
-- 
2.39.5




