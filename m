Return-Path: <stable+bounces-179771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E61B7CF34
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01B81899975
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 07:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBC62EF660;
	Wed, 17 Sep 2025 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JAOrktZV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40F82F291B
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758093877; cv=none; b=nelRkYKmTepcPuXAY7cHy14pj6QrtLzzAniOGmv39HH/HIYby1X1eiV8W4qQSs4UR/Np+PBV2o4rgZ9Dur/JlavwC5DkcVLcqvmDPGrPYGFmZu+WD1njfF02ouopam4A2zKo55LrLo6AviQmrrpU3Pg9LhkT1gANYePK530N82o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758093877; c=relaxed/simple;
	bh=gp1I+5EZ85CerMH7yrpXglZ0og3Z3YmOByHsMWvCKTw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uoHSXNl3gpKtQLMBHiUEQmC45isiH/vV5ts+BkU7YR6qu+yDakSuUIksFPeYzt2A9QfIhmiYeQucoODYerdmWIUZcmN/W0t7oyvQpBxO857ZLN5/WE3TDY2LJPcwAt0KT0odgyeVcceWeTGfj7b079vQHdZfyui3vgoiUE4px7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JAOrktZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F96DC4CEF0;
	Wed, 17 Sep 2025 07:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758093876;
	bh=gp1I+5EZ85CerMH7yrpXglZ0og3Z3YmOByHsMWvCKTw=;
	h=Subject:To:Cc:From:Date:From;
	b=JAOrktZVkU/amUfb9iDQ45RtUm4xBq0OYYqeCuMkNBQnSiuR/t3sChnvudwdnTZgG
	 4mJfSAJKOosJg0lDR8ka1uW+P7FuNTIM3CfP3iL37UHFx02dcZOoIPR4g9Myc5Gkp+
	 PCcYQUmnfmwi4Pz09A/anp42eWC1fWh5t2XsLcQc=
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: fix bug in flow control levels init" failed to apply to 5.4-stable tree
To: hvilleneuve@dimonoff.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 17 Sep 2025 09:24:22 +0200
Message-ID: <2025091722-chatter-dyslexia-7db3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 535fd4c98452c87537a40610abba45daf5761ec6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091722-chatter-dyslexia-7db3@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 535fd4c98452c87537a40610abba45daf5761ec6 Mon Sep 17 00:00:00 2001
From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Thu, 31 Jul 2025 08:44:50 -0400
Subject: [PATCH] serial: sc16is7xx: fix bug in flow control levels init

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

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 3f38fba8f6ea..a668e0bb26b3 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1177,17 +1177,6 @@ static int sc16is7xx_startup(struct uart_port *port)
 	sc16is7xx_port_write(port, SC16IS7XX_FCR_REG,
 			     SC16IS7XX_FCR_FIFO_BIT);
 
-	/* Enable EFR */
-	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
-			     SC16IS7XX_LCR_CONF_MODE_B);
-
-	regcache_cache_bypass(one->regmap, true);
-
-	/* Enable write access to enhanced features and internal clock div */
-	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
-			      SC16IS7XX_EFR_ENABLE_BIT,
-			      SC16IS7XX_EFR_ENABLE_BIT);
-
 	/* Enable TCR/TLR */
 	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
 			      SC16IS7XX_MCR_TCRTLR_BIT,
@@ -1199,7 +1188,8 @@ static int sc16is7xx_startup(struct uart_port *port)
 			     SC16IS7XX_TCR_RX_RESUME(24) |
 			     SC16IS7XX_TCR_RX_HALT(48));
 
-	regcache_cache_bypass(one->regmap, false);
+	/* Disable TCR/TLR access */
+	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG, SC16IS7XX_MCR_TCRTLR_BIT, 0);
 
 	/* Now, initialize the UART */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, SC16IS7XX_LCR_WORD_LEN_8);


