Return-Path: <stable+bounces-113662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F762A29349
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4DF3AC648
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557471779AE;
	Wed,  5 Feb 2025 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WJiW6wFu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135C91519BF;
	Wed,  5 Feb 2025 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767731; cv=none; b=NgbRCY45Ov/0m8qHOmWItwPBkFMID5hagD0MfIt5z0OVCiPuYkl9lpKFX+9I/ZaLpXLoBa9yQgnGzxBBiO1jnHn2KOYK/XlkdWhlQiS+MANeWNlfI+x5gz19sTW4/NWeNJ59yXwP0q9sEK9xhSu/DqxHOdmIAU/G/U2mzgQrh80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767731; c=relaxed/simple;
	bh=Liym+K2wNX3b2R6vux0NrpVUGNM0rsNGQ8uGsfKqDm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QumwpvcZW1jQogoqp3mt3YkVVaAUmc2TQX6Ig9Z2CfdEYQeVZ2jpGAw8pPsupBhiUIa/oE0Zj7ebccKrEp708yOg5lHzcCYQ5l59WrO0miABb6s5fvaPfSnjHdzek5eIMLzmF4Q0Qe+OcnQWQ+BgEKNTikrSJnrSmni4XF/7an4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WJiW6wFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15162C4CED1;
	Wed,  5 Feb 2025 15:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738767729;
	bh=Liym+K2wNX3b2R6vux0NrpVUGNM0rsNGQ8uGsfKqDm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WJiW6wFuSTivGHIOgxCl6uchYeQPxOYcMY4oqPx38rDdlCRpqJMFBm6JAV0bbPyMS
	 3CH30+5FlLfIz7025oRnCYDMhwzJZEHBRSnUaaK/DdpPUwdkLm5s5ARTZkQJbrBcpg
	 tujJ4mOgaQhMcCmRlHlZ73C5F/8KU4F4ygwcQp2c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ming Wang <wangming01@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Keguang Zhang <keguang.zhang@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 470/590] rtc: loongson: clear TOY_MATCH0_REG in loongson_rtc_isr()
Date: Wed,  5 Feb 2025 14:43:45 +0100
Message-ID: <20250205134513.241350189@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Wang <wangming01@loongson.cn>

[ Upstream commit 09471d8f5b390883eaf21b917c4bf3ced1b8a1df ]

The TOY_MATCH0_REG should be cleared to 0 in the RTC interrupt handler,
otherwise the interrupt cannot be cleared, which will cause the
loongson_rtc_isr() to be triggered multiple times.

The previous code cleared TOY_MATCH0_REG in the loongson_rtc_handler(),
which is an ACPI interrupt. This did not prevent loongson_rtc_isr()
from being triggered multiple times.

This commit moves the clearing of TOY_MATCH0_REG to the
loongson_rtc_isr() to ensure that the interrupt is properly cleared.

Fixes: 1b733a9ebc3d ("rtc: Add rtc driver for the Loongson family chips")
Signed-off-by: Ming Wang <wangming01@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Reviewed-by: Keguang Zhang <keguang.zhang@gmail.com> # on LS1B
Tested-by: Keguang Zhang <keguang.zhang@gmail.com>
Link: https://lore.kernel.org/r/20241205114307.1891418-1-wangming01@loongson.cn
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-loongson.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-loongson.c b/drivers/rtc/rtc-loongson.c
index e8ffc1ab90b02..90e9d97a86b48 100644
--- a/drivers/rtc/rtc-loongson.c
+++ b/drivers/rtc/rtc-loongson.c
@@ -114,6 +114,13 @@ static irqreturn_t loongson_rtc_isr(int irq, void *id)
 	struct loongson_rtc_priv *priv = (struct loongson_rtc_priv *)id;
 
 	rtc_update_irq(priv->rtcdev, 1, RTC_AF | RTC_IRQF);
+
+	/*
+	 * The TOY_MATCH0_REG should be cleared 0 here,
+	 * otherwise the interrupt cannot be cleared.
+	 */
+	regmap_write(priv->regmap, TOY_MATCH0_REG, 0);
+
 	return IRQ_HANDLED;
 }
 
@@ -131,11 +138,7 @@ static u32 loongson_rtc_handler(void *id)
 	writel(RTC_STS, priv->pm_base + PM1_STS_REG);
 	spin_unlock(&priv->lock);
 
-	/*
-	 * The TOY_MATCH0_REG should be cleared 0 here,
-	 * otherwise the interrupt cannot be cleared.
-	 */
-	return regmap_write(priv->regmap, TOY_MATCH0_REG, 0);
+	return ACPI_INTERRUPT_HANDLED;
 }
 
 static int loongson_rtc_set_enabled(struct device *dev)
-- 
2.39.5




