Return-Path: <stable+bounces-113573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F34BEA292C8
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C7C16E37E
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB221A83ED;
	Wed,  5 Feb 2025 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iFlbsMgF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B14813C8E2;
	Wed,  5 Feb 2025 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767423; cv=none; b=SdYq+2THt11QxxMlUND5hcMmsH3l1EtxsWGspHXeD1FDa/C2H2HIQaS81mY+cX68IxR3zy3N1usRFJIjqhFUEvewSZZKj05+lVAv2x/muIhnoVngIZmfNNBpq3PJQipHLfODSIk1hi42VYrbuF+E9b6vuzL72huXv24AFnfzf9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767423; c=relaxed/simple;
	bh=f5Fg3506eSu+0X4Ev4YwIq5BNIsESUJnDtsz1VA1SPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/Y7HJf/jKTXowmTk0d2u0y+qOE2BiwUeR3mirZtty9Xq7GOp9jc+IIJvwfjhpyrr1+qxVIdqCYeocWmoS1m8d9n8Loek398atHP7bUaWva1k1ihh2deRZ7eDEZonmIbLBnpHQuOY4lIhvKnM5YtrNwpSuCJKinPHq1WQF1REgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iFlbsMgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D7FC4CED1;
	Wed,  5 Feb 2025 14:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738767422;
	bh=f5Fg3506eSu+0X4Ev4YwIq5BNIsESUJnDtsz1VA1SPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iFlbsMgF4x8bJkHJgU+ueY8bat8HdppL5ieR7XfwBQesaCTsiHY6BvTTdt9RYRs4j
	 TYTf3K+ddl6sme5WIgIbpQmHQeOnN9y+LSqjaWsJ2BnuxI+JmA2FAR46T5h9Sjflac
	 LoLQxoaLokOV0wrS3IYlQanQ9ES0zTaH+LlFnvIQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Linus Walleij <linus.walleij@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 402/623] ARM: omap1: Fix up the Retu IRQ on Nokia 770
Date: Wed,  5 Feb 2025 14:42:24 +0100
Message-ID: <20250205134511.601160622@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

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




