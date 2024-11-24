Return-Path: <stable+bounces-95193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB37D9D762D
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 17:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE022C0845E
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464C92389CB;
	Sun, 24 Nov 2024 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tm7nwWgy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34742389C4;
	Sun, 24 Nov 2024 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456295; cv=none; b=Kj2m1p6xpkiAaZ1VUI/hFjYuXhRP8cMPZ5YchYLmUsa/CSG7oKRhklPb4MFx8m1qZZQqWqlk+wvg0O19uavhDeiVpWLKi5EAXBszxlm0OKNSfhhxo9EM6dFkhTLXHWvc+qfX6RUrqXGxZMEhEzp3XSmNN+rhlK8bJf5iwm6J1OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456295; c=relaxed/simple;
	bh=0k/HJW7lIikqX2d/so+Q+d9e7++AuEc20ExWdQlwupU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfcFTZ27jn78Ick6izLsPWrhzSPNDSYiVi8PEs4UB80I1G6zRy6b3TniyT2g6bDXOQ5+yNsHV0MV5GwCo8hsUMPConJLaz5sIJgfUeOokZFvyuWOu6FVpdENbrqUS20xMzPqlQRYLfxwuj34DoKiqvcEdz7Qd0lRJg13JkhHUN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tm7nwWgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35230C4CECC;
	Sun, 24 Nov 2024 13:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456294;
	bh=0k/HJW7lIikqX2d/so+Q+d9e7++AuEc20ExWdQlwupU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tm7nwWgywH84uOl29sUueovAWN4VMQV8YYmeEu4XCNCMtHyRwBriJX+8xzD7qgJAO
	 oCGMOiAyOOu+1KFF/zcRSDi6omw7QQ2y8GemuVF4jO5gV/PIl5JaLAJFv3dJgMxxtn
	 Cp57O1V+dGZqxLgMs4rPD12JR4McoTJaMKVKLgss/cqyBOwCwVa2mnjC92QMIhU2qk
	 V7Qd7fBK7LJ3ykGm2T44CliQbRCK2UQPZBjzor2Lu+/41g9LmHeIjJ7vkKquiXpLD/
	 icbZJfIrKXAPUm5QIrRqRxLFYcKUCreuBIS6ZDS/pIGEaNZnplzuw/+oC72IBG6BZy
	 VDW15Ep1hWXWA==
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
	ansuelsmth@gmail.com,
	michal.vokac@ysoft.com,
	javier.carrasco.cruz@gmail.com,
	rmk+kernel@armlinux.org.uk,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 42/48] dsa: qca8k: Use nested lock to avoid splat
Date: Sun, 24 Nov 2024 08:49:05 -0500
Message-ID: <20241124134950.3348099-42-sashal@kernel.org>
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
index 641692f716f86..47e9b2c303831 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -551,7 +551,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	 * We therefore need to lock the MDIO bus onto which the switch is
 	 * connected.
 	 */
-	mutex_lock(&priv->bus->mdio_lock);
+	mutex_lock_nested(&priv->bus->mdio_lock, MDIO_MUTEX_NESTED);
 
 	/* Actually start the request:
 	 * 1. Send mdio master packet
-- 
2.43.0


