Return-Path: <stable+bounces-46343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3939B8D031A
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A51A1C21C00
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FF316E864;
	Mon, 27 May 2024 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSRaJL9W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC4616DEDB;
	Mon, 27 May 2024 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819181; cv=none; b=fiyK4rxUvs+gm26Jkcxd6vFeXbgSdgeWX2IcKJqF/OAEk/Fpy9Z4rVQM/V3VkuVEZQdwPXPY3o1bjf/7Biyc1KZGnTWQ/Wm7wRihX+0/KZvVoIN1hTKol6PmOUt36LJdbHzNWVOJZpLjHXjkOaPUiKm+maxIyMWxjP2C/8u3Us0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819181; c=relaxed/simple;
	bh=AMK0Y8oxG0m+uOtoW2x5sJMwUmv2BQL30RmhLfMRe/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2FVHZrcYvvT9fLwRYLRC1s99a3/eJcVLOF7GXuj0zsBlisB5OCN+HbS1dOTGVFLEQ+uSDrIjZFD+F8x/WE7Z387manHAnGsGJsk8yVYwjf5gmCI5N433g7bEaE+pCUu8U2Cg1bQC5kiriqpM5nbWAHd8GvifP+FZ9RrCLkzKXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSRaJL9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F7FC2BBFC;
	Mon, 27 May 2024 14:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819181;
	bh=AMK0Y8oxG0m+uOtoW2x5sJMwUmv2BQL30RmhLfMRe/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tSRaJL9Wl7Q0l6NhFPIMzxR+6+uTshLlLDX8t6oZ5jgwN30ihpufqh8h1Tj0NG4fc
	 eK3exe71NICwnhCHg7K7YkhQ5GuJQL/PQgJlKdo2GF6GD59DkU9aOwEVl/38THrnjj
	 nmCGS1td85posttQtg2cKoLXsy1L0vozPYK2dupSLKbraqIsJVZiAHe4m3AT2EcOdT
	 y3FQXB+o5OvcNqov4TCdgWe/v9OyheQVLDcAjodmR2l2n4IFCJ8YLSHPZptAhMNXa6
	 gRETmsOAWVrvtBgXQ5QzykFLdY5+mKWfJ7jBJd9dlqkKQTXmOrVua4Lvm6D0H92c9i
	 LqzhmS42hxcCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 23/35] net: dsa: realtek: do not assert reset on remove
Date: Mon, 27 May 2024 10:11:28 -0400
Message-ID: <20240527141214.3844331-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141214.3844331-1-sashal@kernel.org>
References: <20240527141214.3844331-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
Content-Transfer-Encoding: 8bit

From: Luiz Angelo Daros de Luca <luizluca@gmail.com>

[ Upstream commit 4f580e9aced1816398c1c64f178302a22b8ea6e2 ]

The necessity of asserting the reset on removal was previously
questioned, as DSA's own cleanup methods should suffice to prevent
traffic leakage[1].

When a driver has subdrivers controlled by devres, they will be
unregistered after the main driver's .remove is executed. If it asserts
a reset, the subdrivers will be unable to communicate with the hardware
during their cleanup. For LEDs, this means that they will fail to turn
off, resulting in a timeout error.

[1] https://lore.kernel.org/r/20240123215606.26716-9-luizluca@gmail.com/

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/realtek/rtl83xx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index d2e876805393b..a9c1702431efb 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -290,16 +290,13 @@ EXPORT_SYMBOL_NS_GPL(rtl83xx_shutdown, REALTEK_DSA);
  * rtl83xx_remove() - Cleanup a realtek switch driver
  * @priv: realtek_priv pointer
  *
- * If a method is provided, this function asserts the hard reset of the switch
- * in order to avoid leaking traffic when the driver is gone.
+ * Placehold for common cleanup procedures.
  *
- * Context: Might sleep if priv->gdev->chip->can_sleep.
+ * Context: Any
  * Return: nothing
  */
 void rtl83xx_remove(struct realtek_priv *priv)
 {
-	/* leave the device reset asserted */
-	rtl83xx_reset_assert(priv);
 }
 EXPORT_SYMBOL_NS_GPL(rtl83xx_remove, REALTEK_DSA);
 
-- 
2.43.0


