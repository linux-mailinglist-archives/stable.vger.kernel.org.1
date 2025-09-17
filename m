Return-Path: <stable+bounces-180013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C092BB7E4FE
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91FD1189BB9A
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4345D30CB51;
	Wed, 17 Sep 2025 12:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/b/jbEX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D8031A7EC
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113102; cv=none; b=sSlPgnTY8+fzamCvxFzY/hITUUVPLirG9flGc1CxgSQBaRkSFp/sf09FqkAiJqsDgQAlQx5kKxg3lFJvMo0Vbj+5RbOZnP50M9v6cGqAbVJ/zu4cQ1moMl8n1R4i8ehzA8rjajmpk41QWakFAjVbKQznooStXKqRZOo4QhiYntI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113102; c=relaxed/simple;
	bh=0Oc6nrNUCRgGkXVpG4kb5tm01gaz6a/EdrMuEOLb7Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxZsUhCvjOYcD0u/Nfvc0vw+KWuyKbTIwxGNIF7W/vZnHigU1Esfpd+mDgKNxpe+znjhEdiJ6CHEDfvQgKoe6ACOH1ryx+hcPhMPhOjWrmOsoXCTrYv4xatU01cambh4QnbM5zNN+CAelzw1rka4FP4wr7kioOn2moehDOhy/uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/b/jbEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437ACC4CEF5;
	Wed, 17 Sep 2025 12:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758113101;
	bh=0Oc6nrNUCRgGkXVpG4kb5tm01gaz6a/EdrMuEOLb7Vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t/b/jbEXPPPLSi9Ml5A3sX2QnxLKTpUZ0/obc32tSvsSyYskAfoUnhpSoZEqHhoWI
	 MvX0BMb5rFPqAGGsCbZzz5GDJn++vlpsNrAFbzcBubZZduFJMY80ll6a7sm3X6FDYF
	 MzUJXmtlbhtt/TaJ1g67lOR1rIwQn3N0bzbe7XeJl+/9a2IQkvexELmEu7iZHcwZD0
	 dcmrcobKNRvN/XuPYxpx/7Qm+38Qvh3KSzJ/61kjkp4Z3KL2MwfAFpwX4H9bAdwCYD
	 0XGV7+R0M5CPghK0hOrI3U43r2nBjQzegiMQPj5JBiLVxvWCWwJ1MkJm6LIYbvjwes
	 s+FGsTwP7Fimg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] serial: sc16is7xx: fix bug in flow control levels init
Date: Wed, 17 Sep 2025 08:44:59 -0400
Message-ID: <20250917124459.518238-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091721-speak-detoxify-e6fe@gregkh>
References: <2025091721-speak-detoxify-e6fe@gregkh>
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
[ changed regmap variable from one->regmap to s->regmap ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 4ea52426acf9e..758537381d774 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1018,7 +1018,6 @@ static int sc16is7xx_config_rs485(struct uart_port *port,
 static int sc16is7xx_startup(struct uart_port *port)
 {
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
-	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	unsigned int val;
 
 	sc16is7xx_power(port, 1);
@@ -1030,16 +1029,6 @@ static int sc16is7xx_startup(struct uart_port *port)
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
@@ -1051,7 +1040,8 @@ static int sc16is7xx_startup(struct uart_port *port)
 			     SC16IS7XX_TCR_RX_RESUME(24) |
 			     SC16IS7XX_TCR_RX_HALT(48));
 
-	regcache_cache_bypass(s->regmap, false);
+	/* Disable TCR/TLR access */
+	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG, SC16IS7XX_MCR_TCRTLR_BIT, 0);
 
 	/* Now, initialize the UART */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, SC16IS7XX_LCR_WORD_LEN_8);
-- 
2.51.0


