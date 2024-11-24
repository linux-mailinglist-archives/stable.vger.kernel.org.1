Return-Path: <stable+bounces-95142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B719D73A6
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8BC166A88
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A20F1E0B95;
	Sun, 24 Nov 2024 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMGoqOFg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C621AA789;
	Sun, 24 Nov 2024 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456132; cv=none; b=EUTs73LKlzX+jGc36KiS2IoKI/o4iMKOkyiM4l5uYkNlaaVmtRX8y5BJeU7f0UyXYfY3yU4wlhAMlQRLEPNfDm30Y3Q8OOFmtJPL4PTucFfT27FeeKlztg/19sOTRbt/zd1Fi7QJqZ2P12Z0ASGvHfClwqDvhZHLcTUlBmtwVHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456132; c=relaxed/simple;
	bh=5ETaXAjYX3y32dCcOficXjTBuFwieRfYNChgk1/Jm9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xibn5LxCNNw2Wr9rCg5COyN6fohVEx05We33slGC2N+av8UZQdc7/7lquqf9+dPsN/1nJLu3780EfuLv5p0lfMNScU29c2ACHpf++yBA5IJvCiqZpYw0gn8t7fXUd11hAz+S1cE2Up2e1N+Sp1rOAbuYqXqTsEO49WbCnZnx6pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMGoqOFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1989C4CECC;
	Sun, 24 Nov 2024 13:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456131;
	bh=5ETaXAjYX3y32dCcOficXjTBuFwieRfYNChgk1/Jm9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZMGoqOFghb5pgfdUzd86Ynx9FMD/lNvTDP+zIUFfaMXtpQz1C3MfCecUdVLa5Y/ol
	 OJDLESW0T4YTP6+SbGjxyfFJtmnUPBVor0XuIZIZNH5ubLejRhjfI2goQl6Fy0EVmA
	 +znwK27l36Coiq9epGOppptqy7txysa9/3bNdWF+EiHig0F94tlcosr5rVyjFb2GL6
	 U8Bf2T3HPVD0CC/i2ohk2ocwo6NXrZpHB1EYjeS2OgrGwyJrIr/+kxOI8fxGkkfWed
	 +Zn9QLbyQdu+00+uvOgE7dcNpb4PgoW7D+mGJ+CigYmGN4KjY2V+2T+fKPGCtkfZBY
	 l7oFf96amBxJw==
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
	javier.carrasco.cruz@gmail.com,
	michal.vokac@ysoft.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 52/61] dsa: qca8k: Use nested lock to avoid splat
Date: Sun, 24 Nov 2024 08:45:27 -0500
Message-ID: <20241124134637.3346391-52-sashal@kernel.org>
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
index 17c28fe2d7433..384ae32c05b1c 100644
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


