Return-Path: <stable+bounces-94987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2959D7273
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E68B6B6128B
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFFB1E907C;
	Sun, 24 Nov 2024 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nh6ibUH1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76501B6D06;
	Sun, 24 Nov 2024 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455513; cv=none; b=i3TuKM8Fm0nflLINp4i8tKlntGL0JvFW+WwOc1n8MLU9iMZTUGjSHyyXVMM6rq0vXS0g54CmB0kwYtZmTqJsnreDncQ//x6ipoeuJM1qZIft82wGS8aPC6moEmPwJwF6CA02DEdrvr7Isdxj/97r4xU+7R81SqnwrX6hlE7iv94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455513; c=relaxed/simple;
	bh=frMsR8PTOxaQrnnDp39CBVkRcossL8PMqqCmGH4P73Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/txAO0L2wVzt7TNyCwrRd3QYVOlvoOISS0hDk8yPnRlxdCLp9eL5m6sktlpovYdEds5LRbT09BPvwdkYOOHZngjZwoP3/KxwuAujTC5VWUZdDXDYaXU+ovO4ooNhNKbvbNvjFqpNgJAP9bGki2VlJQbpuJ4e3sCx/B+EDv21cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nh6ibUH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A58C4CECC;
	Sun, 24 Nov 2024 13:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455512;
	bh=frMsR8PTOxaQrnnDp39CBVkRcossL8PMqqCmGH4P73Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nh6ibUH1SFeSwpHTXGM1Q461jDjwOa5XJAxLJsYc1ucdNO6bA35g9OMqAkhQgtWy8
	 pVsMCR3Z/llZssNhclF4sysUviiQlrzyaFNlWdPV6pRpFWsGhs5swvEGReQxlV/sAh
	 MYSu67OKmDz9svI1sIc2MMrahQmWHorjoXPY9SDNIzUD4Nox4Azatzh5xAWeOSXhTz
	 jr8lMdERmCW3p8q6QoydZSaSIImbJOkTpSMPgpI0ttEvRqA7xlQCuuZoJrsa0JNzI3
	 5wipk0oevZGyAPxLZVcQ3waWn+jXk/z94oNhcbfQxwYQVcWov2u/GgEaO+k12418i3
	 bNA4vpVG3kZRA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	florian.fainelli@broadcom.com,
	alsi@bang-olufsen.dk,
	luizluca@gmail.com,
	michal.vokac@ysoft.com,
	rmk+kernel@armlinux.org.uk,
	javier.carrasco.cruz@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 091/107] dsa: qca8k: Use nested lock to avoid splat
Date: Sun, 24 Nov 2024 08:29:51 -0500
Message-ID: <20241124133301.3341829-91-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit 078e0d596f7b5952dad8662ace8f20ed2165e2ce ]

qca8k_phy_eth_command() is used to probe the child MDIO bus while the
parent MDIO is locked. This causes lockdep splat, reporting a possible
deadlock. It is not an actually deadlock, because different locks are
used. By making use of mutex_lock_nested() we can avoid this false
positive.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20241110175955.3053664-1-andrew@lunn.ch
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index f8d8c70642c4f..59b4a7240b583 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -673,7 +673,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	 * We therefore need to lock the MDIO bus onto which the switch is
 	 * connected.
 	 */
-	mutex_lock(&priv->bus->mdio_lock);
+	mutex_lock_nested(&priv->bus->mdio_lock, MDIO_MUTEX_NESTED);
 
 	/* Actually start the request:
 	 * 1. Send mdio master packet
-- 
2.43.0


