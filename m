Return-Path: <stable+bounces-112960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFC1A28F56
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974DE3AABE1
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FBD15854F;
	Wed,  5 Feb 2025 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gbukN6P3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812B814B959;
	Wed,  5 Feb 2025 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738765343; cv=none; b=E6kKR0Ok5B9DtHeSroxO9C25mjPwVARw/RS85QMnoXNLxc5tQfxZ0LDBTxHTPE8yGaiLVQ50VW1mP63y0S+YOXg/C3LCWyh2vNecw6aVahWzVVNNo3FgDcallTAnSDHb1fItlSLtn8pc9ipsuzUddEUwwB3Jf7ImtRwFQYjQjJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738765343; c=relaxed/simple;
	bh=5EAT2JcRGXsnu1xDquM4TvF4HLSjQj1nwFGYdanpJDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhvGam+WpunGfNzyagvx1qrBhJuc2IqPl/PWzIknvuGfUPyQJnlBlTo6sqAS6DOoOL45UvcFvEELwWPhBfg+V3gk61C2MEern6c1r4KeNWQ4XSaqtAj5Zi8gOk4zc5y3eHG9erTR0RgFFzAo+8Q5+1Qh0yxGAbZYuc2ClWZCQS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gbukN6P3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D31C4CED1;
	Wed,  5 Feb 2025 14:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738765343;
	bh=5EAT2JcRGXsnu1xDquM4TvF4HLSjQj1nwFGYdanpJDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gbukN6P3Xcq7vURS6kEi/ZZgVmXsWCzPQyEc/Tvszafk/ej10ohKN4tXsYAzv+3jT
	 y7aNlJXHzetX0/zTyWCtH6qtwgE3rBMCdEptMWBa9M5Eim9gWlmBhUeVNtxzUeWDV3
	 GHhM1/jL5JrWGVXo5I7MAP7yc21HV3CKFf2hd4B8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Linus Walleij <linus.walleij@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 255/393] ARM: omap1: Fix up the Retu IRQ on Nokia 770
Date: Wed,  5 Feb 2025 14:42:54 +0100
Message-ID: <20250205134430.064927888@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaro Koskinen <aaro.koskinen@iki.fi>

[ Upstream commit ad455e48bba7f21bb5108406da0854cf8dede8ea ]

The Retu IRQ is off by one, as a result the power button does not work.
Fix it.

Fixes: 084b6f216778 ("ARM: omap1: Fix up the Nokia 770 board device IRQs")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/Z3UxH_fOzuftjnuX@darkstar.musicnaut.iki.fi
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap1/board-nokia770.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 3312ef93355da..a5bf5554800fe 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -289,7 +289,7 @@ static struct gpiod_lookup_table nokia770_irq_gpio_table = {
 		GPIO_LOOKUP("gpio-0-15", 15, "ads7846_irq",
 			    GPIO_ACTIVE_HIGH),
 		/* GPIO used for retu IRQ */
-		GPIO_LOOKUP("gpio-48-63", 15, "retu_irq",
+		GPIO_LOOKUP("gpio-48-63", 14, "retu_irq",
 			    GPIO_ACTIVE_HIGH),
 		/* GPIO used for tahvo IRQ */
 		GPIO_LOOKUP("gpio-32-47", 8, "tahvo_irq",
-- 
2.39.5




