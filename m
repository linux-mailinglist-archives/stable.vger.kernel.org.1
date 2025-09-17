Return-Path: <stable+bounces-180355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CB6B7F1C5
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD68624B91
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600CD1A3167;
	Wed, 17 Sep 2025 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlDI2dIZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F39F33C77D
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114202; cv=none; b=NFr2dbOH5xTaPusaCWPLCLyZyn2zaFudUEImTekwGLHWYLMpDHo4kY7N4cf4ThjOimtF8MeojzVBghXhuxTR6E2r4hfsFTrVfJITM3UWLI6Y4HNX6BIM7qGDCtf3fFeVO/Cz9LSj1B5RhQtrsUf5QKDo9qQljlrTt8FZDLhmapU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114202; c=relaxed/simple;
	bh=UsL2MK1GIOSsg/hebjbcfNWaxMiCUqqrkq6kubdRU/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ba6iEsO3sGs26aM1wfttdv0nWsPS1uu+pNSaS6I7244dy4p6//5rNPzVeTwuljtKz5SoGzM4y5g9/hsqd27x2htM6XlT4Jai2Tz60Uv8/IUhXgKYf7c9TyAqhHLT2bboXEZnMDmR4zYG5T5h8Xt7h1hE+e+Tccw0s2yIp/FD61w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlDI2dIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8262BC4CEF0;
	Wed, 17 Sep 2025 13:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758114202;
	bh=UsL2MK1GIOSsg/hebjbcfNWaxMiCUqqrkq6kubdRU/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IlDI2dIZxisHVj/FLYNDhTaz5h2U5WsBUHgWOFBx38VVGt/uHn0akMqA7bHXxF7Oa
	 aguZ8nV9FFqYX+m/88APhku9gbydyKFUpElxWsbZWEQP+/Pw2QkRmufEVHJTzctLrq
	 Qnw7n4DN+i+06qE4WNfHkuw+pSJr6yB7ckIgOLtDngyUMrP0/bN9IMsUcFJNsvVXv2
	 WedYMNhbQjyDCPVBFFyGpRQk2MdaG6DEsONzHyJLCcN87DNINQR6gYEmTkGLCt9+Nn
	 r6qAr+Da4C9naO55YB5atHljr5CYUAuoJU5sLqdHFU5gZYOLCgFMfhKWgvaszfCR5c
	 eD8UjmOqkBqpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] serial: sc16is7xx: fix bug in flow control levels init
Date: Wed, 17 Sep 2025 09:03:19 -0400
Message-ID: <20250917130319.535006-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091722-chatter-dyslexia-7db3@gregkh>
References: <2025091722-chatter-dyslexia-7db3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

[ Upstream commit 535fd4c98452c87537a40610abba45daf5761ec6 ]

When trying to set MCR[2], XON1 is incorrectly accessed instead. And when
writing to the TCR register to configure flow control levels, we are
incorrectly writing to the MSR register. The default value of $00 is then
used for TCR, which means that selectable trigger levels in FCR are used
in place of TCR.

TCR/TLR access requires EFR[4] (enable enhanced functions) and MCR[2]
to be set. EFR[4] is already set in probe().

MCR access requires LCR[7] to be zero.

Since LCR is set to $BF when trying to set MCR[2], XON1 is incorrectly
accessed instead because MCR shares the same address space as XON1.

Since MCR[2] is unmodified and still zero, when writing to TCR we are in
fact writing to MSR because TCR/TLR registers share the same address space
as MSR/SPR.

Fix by first removing useless reconfiguration of EFR[4] (enable enhanced
functions), as it is already enabled in sc16is7xx_probe() since commit
43c51bb573aa ("sc16is7xx: make sure device is in suspend once probed").
Now LCR is $00, which means that MCR access is enabled.

Also remove regcache_cache_bypass() calls since we no longer access the
enhanced registers set, and TCR is already declared as volatile (in fact
by declaring MSR as volatile, which shares the same address).

Finally disable access to TCR/TLR registers after modifying them by
clearing MCR[2].

Note: the comment about "... and internal clock div" is wrong and can be
      ignored/removed as access to internal clock div registers (DLL/DLH)
      is permitted only when LCR[7] is logic 1, not when enhanced features
      is enabled. And DLL/DLH access is not needed in sc16is7xx_startup().

Fixes: dfeae619d781 ("serial: sc16is7xx")
Cc: stable@vger.kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20250731124451.1108864-1-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ s->regmap renames + context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 8fb47f73cc7ad..cd767f3878df5 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1032,16 +1032,6 @@ static int sc16is7xx_startup(struct uart_port *port)
 	sc16is7xx_port_write(port, SC16IS7XX_FCR_REG,
 			     SC16IS7XX_FCR_FIFO_BIT);
 
-	/* Enable EFR */
-	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
-			     SC16IS7XX_LCR_CONF_MODE_B);
-
-	regcache_cache_bypass(s->regmap, true);
-
-	/* Enable write access to enhanced features and internal clock div */
-	sc16is7xx_port_write(port, SC16IS7XX_EFR_REG,
-			     SC16IS7XX_EFR_ENABLE_BIT);
-
 	/* Enable TCR/TLR */
 	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
 			      SC16IS7XX_MCR_TCRTLR_BIT,
@@ -1053,7 +1043,8 @@ static int sc16is7xx_startup(struct uart_port *port)
 			     SC16IS7XX_TCR_RX_RESUME(24) |
 			     SC16IS7XX_TCR_RX_HALT(48));
 
-	regcache_cache_bypass(s->regmap, false);
+	/* Disable TCR/TLR access */
+	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG, SC16IS7XX_MCR_TCRTLR_BIT, 0);
 
 	/* Now, initialize the UART */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, SC16IS7XX_LCR_WORD_LEN_8);
-- 
2.51.0


