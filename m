Return-Path: <stable+bounces-139939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9961AAA2A0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B29EF7A6112
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EA02DDD1F;
	Mon,  5 May 2025 22:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8YEf6ZK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADB82DDD13;
	Mon,  5 May 2025 22:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483711; cv=none; b=YZAG8mIsgKDP15uqt8qLYk4KeYnJ/WnV7Qz8HI6z5b8GcloMu3Wgkd1fNt0TDx+hwM2Bo2IASiBPflH4xDnQXtZmXBXMzLw+UkPohnY5hsiTofMdtuTdBiy4nhWevzGOhun2tenFk2m/vY+Rq0nZjkCKVzEWCrJlZlz/SQxVbJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483711; c=relaxed/simple;
	bh=MpiZQlSSgq1REYlPtzOMCRg2yv1qqrP6TIfr1DHnXfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lhcM/FedkeRaUDdVWypkLBfLED+Z8LBHT5z9ZWq0h4yA6eJKjzWBwGMjV8q37ujXsD1GpAyWurkfwOf5rPTSLss0c7jkoj7+xMp5BVf6+UiU9FC02PD/piGzgbGDXimKMirmuReyyArSgZRa89hq8Zq3Z3H4bhunY1MofD7q764=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8YEf6ZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0091EC4CEEE;
	Mon,  5 May 2025 22:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483711;
	bh=MpiZQlSSgq1REYlPtzOMCRg2yv1qqrP6TIfr1DHnXfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g8YEf6ZKfjfVyxSXlbzPV2Gsg1hcWR5pF6LcOu3w+1xYHYVwatx1pDOiog4K/LAzf
	 Q+XKXNSCrA+WJlNzgqrhTAzXP0BLxh0WYXKedv5XRnMdkqGDLCSE/w4TNhoH4+mVSu
	 rMzYQMM257P+qA0cFuxd9S0u83NvdvugZfsTjgmzOm7AlW1MhC1hsrH76wd2RHhxrd
	 2BLt2bMe7peLDgGLWLxyW206qnI9MYneKgXAJlod7NzQlQzEKGNK+sH4hbJyXS0JJm
	 UVE099wT3i7dVVnWK+oqILUyvunjxjMNb5W4oynHBCuwHuzVqQFNMs0X17PTfxfS2Q
	 hJEskkkgfFybw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	nic_swsd@realtek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 192/642] r8169: increase max jumbo packet size on RTL8125/RTL8126
Date: Mon,  5 May 2025 18:06:48 -0400
Message-Id: <20250505221419.2672473-192-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 473367a5ffe1607a61be481e2feda684eb5faea9 ]

Realtek confirmed that all RTL8125/RTL8126 chip versions support up to
16K jumbo packets. Reflect this in the driver.

Tested by Rui on RTL8125B with 12K jumbo packets.

Suggested-by: Rui Salvaterra <rsalvaterra@gmail.com>
Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/396762ad-cc65-4e60-b01e-8847db89e98b@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 4ead966727734..485ecd62e585d 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -89,6 +89,7 @@
 #define JUMBO_6K	(6 * SZ_1K - VLAN_ETH_HLEN - ETH_FCS_LEN)
 #define JUMBO_7K	(7 * SZ_1K - VLAN_ETH_HLEN - ETH_FCS_LEN)
 #define JUMBO_9K	(9 * SZ_1K - VLAN_ETH_HLEN - ETH_FCS_LEN)
+#define JUMBO_16K	(SZ_16K - VLAN_ETH_HLEN - ETH_FCS_LEN)
 
 static const struct {
 	const char *name;
@@ -5353,6 +5354,9 @@ static int rtl_jumbo_max(struct rtl8169_private *tp)
 	/* RTL8168c */
 	case RTL_GIGA_MAC_VER_18 ... RTL_GIGA_MAC_VER_24:
 		return JUMBO_6K;
+	/* RTL8125/8126 */
+	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_71:
+		return JUMBO_16K;
 	default:
 		return JUMBO_9K;
 	}
-- 
2.39.5


