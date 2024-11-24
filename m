Return-Path: <stable+bounces-95120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0579D74A1
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52C00BE6478
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006AF229572;
	Sun, 24 Nov 2024 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRTt2nqz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB10229570;
	Sun, 24 Nov 2024 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456068; cv=none; b=l97tJh0MrMkEyJmTYG20EA9fHRiCQxUUJesRHmkBx685B12MnZoJHwJ0KlU27gSO1JRWXr8aGDrIDM0bAfCYek+hGXt7jDXUcUU4CMjdlVIDmypUABZPMkLJNmvKVAiJh9aABBGKnstOB0K8VyXuX1Drg+Y0kAowXQ+jBeM+Y/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456068; c=relaxed/simple;
	bh=Zai5ue7pV7+UeFCKdEX1gi5GIk+aYnLikV09e8vfFqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJT8e2GicKvV7F4AEYR7n9TzKS3s+vhajb0pVuOmXH3jJyw2zL/ENKrawZ+v6cfE2IheCmZNj1eXUs6C/IZ2Rc9HyywYVk5IARjrbN2gDvONOg6XCDrF/ijZBauyZleOZYFhORvYxHLPLedZUN/ulJpOZLEYFT/0PQZv/rmslYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRTt2nqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A80EC4CED3;
	Sun, 24 Nov 2024 13:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456068;
	bh=Zai5ue7pV7+UeFCKdEX1gi5GIk+aYnLikV09e8vfFqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hRTt2nqzs1fDNXo3fC/SeweBdVzAIGhWNXmgsqBTSQ3u+aDvd42WZgtZAfbeOmjrZ
	 V5Owso1T2M8ZUgt03ve2FFMPzm4HIa5RxTivLZY9mgTwCsX3vTtSuCsVp1JZdYS8zZ
	 6AaRoqz5YP+tW78+ddQ6MQE2PCmazkV4rrav9x4hglGbGp+69IaBKTpcSWbCzfYa9z
	 xdQvQ9ruQcFSdd0+BikPQ5Q2A8203JExnrWt5yWTbWGHY6a5KqNy3AQQ8N2r++YXmJ
	 AEXBGSJd6gfpcnDWkLC6zB0jlw93csYPlZ7pMtBmKc7AeWbu+QcAkbZEQ1VieT/YVm
	 LTMCpNe61WKvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shengyu Qu <wiagn233@outlook.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 30/61] net: sfp: change quirks for Alcatel Lucent G-010S-P
Date: Sun, 24 Nov 2024 08:45:05 -0500
Message-ID: <20241124134637.3346391-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Shengyu Qu <wiagn233@outlook.com>

[ Upstream commit 90cb5f1776ba371478e2b08fbf7018c7bd781a8d ]

Seems Alcatel Lucent G-010S-P also have the same problem that it uses
TX_FAULT pin for SOC uart. So apply sfp_fixup_ignore_tx_fault to it.

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
Link: https://patch.msgid.link/TYCPR01MB84373677E45A7BFA5A28232C98792@TYCPR01MB8437.jpnprd01.prod.outlook.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/sfp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 4278a93b055e5..e0e4a68cda3ea 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -441,7 +441,8 @@ static void sfp_quirk_ubnt_uf_instant(const struct sfp_eeprom_id *id,
 static const struct sfp_quirk sfp_quirks[] = {
 	// Alcatel Lucent G-010S-P can operate at 2500base-X, but incorrectly
 	// report 2500MBd NRZ in their EEPROM
-	SFP_QUIRK_M("ALCATELLUCENT", "G010SP", sfp_quirk_2500basex),
+	SFP_QUIRK("ALCATELLUCENT", "G010SP", sfp_quirk_2500basex,
+		  sfp_fixup_ignore_tx_fault),
 
 	// Alcatel Lucent G-010S-A can operate at 2500base-X, but report 3.2GBd
 	// NRZ in their EEPROM
-- 
2.43.0


