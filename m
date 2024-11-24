Return-Path: <stable+bounces-95077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293F29D730A
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952141657FD
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861B52101AD;
	Sun, 24 Nov 2024 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azzdcQzv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D9A2101A1;
	Sun, 24 Nov 2024 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455910; cv=none; b=aDOXHl7UkvLSvd/u74JwpLP0DNw8SuyVgNHN/mmn6nRXrn2j+2sfLYqEEIWqtiIeD6Mn80fzczKsk+Y+8P7nSXOOwSYLgucQSPTniN8KF/yFZUvVuj62ys0mH9p7v14A4yMHTthoqdfMblWF9biqyKACpkqC77HyGt+W2pYoMJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455910; c=relaxed/simple;
	bh=frMsR8PTOxaQrnnDp39CBVkRcossL8PMqqCmGH4P73Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGovDmU2LSoHdmkNradwbvJRLXO/VtOAe/0zeksNrHLnr/2S1WxUOixiIGtoY7a/mbkJlJHsjMQQ2xHA6J6SbqjDFQtHeXVLMWY+u93Es/YEEcNXd1fX/a6klqJTAWwrNXWb7/utc3Oig48ayeXV4fu4qFuYONrjjW+s13pXykA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azzdcQzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729E8C4CED6;
	Sun, 24 Nov 2024 13:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455910;
	bh=frMsR8PTOxaQrnnDp39CBVkRcossL8PMqqCmGH4P73Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=azzdcQzvwhFP7RBiTXLFutrUUVEUVYrF5JH/mTBCmeUNfv/vxKyqxKzpVZTYQ9LJF
	 ib43Y6tmm7HTi+jw8QhJmekK/2JkEol17lWflIGyjCFUEgcqEiJpfc4+mcsIwyluD3
	 0+rUvbh4CEsYnXMQ8yobnjuLTJFDuBLLMpqjBnEucdpxA7PVxw4Mp/ISd0duBwrK0L
	 gHcW29oO9zaU0zfMI/qCHVCXc33zP7DQyDQrEK/18M9rbQPiW3x+Kg4d4/ijvvnhA2
	 AdPUSTyaOeES4SbYggZGv2f+0riQkngrjp/TmnJioayTGQwgAbuwFt+v0K1GHmgHRb
	 LIZ6sQ4jJRbBw==
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
	rmk+kernel@armlinux.org.uk,
	michal.vokac@ysoft.com,
	javier.carrasco.cruz@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 74/87] dsa: qca8k: Use nested lock to avoid splat
Date: Sun, 24 Nov 2024 08:38:52 -0500
Message-ID: <20241124134102.3344326-74-sashal@kernel.org>
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


