Return-Path: <stable+bounces-80113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C067798DBE9
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91D11C23CAD
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71211D07AC;
	Wed,  2 Oct 2024 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hbtF0Idf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8527F1EB21;
	Wed,  2 Oct 2024 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879422; cv=none; b=W4tIsJ6ZOpJb9XqHeBgj/eDq0ZIR419CdrbA1cboOFdshSCHhzM387pfisSpAtuUtXRHiJZfTgR4VVwZft1+MjMLs7Vfy4x7vNcNk2X9fgidOEIlDRaam9BNKGe/dvbzLsX8hR0u8880ajK0k0RjfOBVb+o2VQ1KgDI0TAbdVp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879422; c=relaxed/simple;
	bh=0aYRuNyHrOAHCf0NtoEwcIYEsRfTlRtXmQg228SM9Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ko7ijDTLd2/XHR6JIcqvOi6N3rdhT6cNo44I9XsFPnQVYUiQ/oRsGfZSfEMEgwUYe0DofT7e5TENc9tLyEnZ+j9cm3poSsFzsKTWnASdu/nnX6Zy91GgRYItf/BRz+tPKAGlN221v/VriLlzoEp35EUgx3qhUl8jBqizbdP7oqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hbtF0Idf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0775FC4CEC2;
	Wed,  2 Oct 2024 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727879422;
	bh=0aYRuNyHrOAHCf0NtoEwcIYEsRfTlRtXmQg228SM9Qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hbtF0Idf9JckMlRM7VxZJluVsJUcA73sZ8hABY3l1e4YdUy9glahKkcpFsk/x2s4c
	 ZOqUhpJbhq/3sDG/WREkpX9Ey/Jd/RN9cvyZVMyMm79mVacO7x6xCPZhQBk1no2eaT
	 CIOm563pEcS2R9WRtfAWFXzbh8OIn5KknSmbYPXQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 113/538] ASoC: tas2781: Use of_property_read_reg()
Date: Wed,  2 Oct 2024 14:55:52 +0200
Message-ID: <20241002125756.697649849@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Rob Herring (Arm) <robh@kernel.org>

[ Upstream commit 31a45f9190b5b4f5cd8cdec8471babd5215eee04 ]

Replace the open-coded parsing of "reg" with of_property_read_reg().
The #ifdef is also easily replaced with IS_ENABLED().

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20240702215402.839673-1-robh@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: c2c0b67dca3c ("ASoC: tas2781-i2c: Drop weird GPIO code")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tas2781-i2c.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index a9d179e307739..61a64d18a7d55 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
@@ -633,33 +634,20 @@ static void tasdevice_parse_dt(struct tasdevice_priv *tas_priv)
 
 		tas_priv->irq_info.irq_gpio =
 			acpi_dev_gpio_irq_get(ACPI_COMPANION(&client->dev), 0);
-	} else {
+	} else if (IS_ENABLED(CONFIG_OF)) {
 		struct device_node *np = tas_priv->dev->of_node;
-#ifdef CONFIG_OF
-		const __be32 *reg, *reg_end;
-		int len, sw, aw;
-
-		aw = of_n_addr_cells(np);
-		sw = of_n_size_cells(np);
-		if (sw == 0) {
-			reg = (const __be32 *)of_get_property(np,
-				"reg", &len);
-			reg_end = reg + len/sizeof(*reg);
-			ndev = 0;
-			do {
-				dev_addrs[ndev] = of_read_number(reg, aw);
-				reg += aw;
-				ndev++;
-			} while (reg < reg_end);
-		} else {
-			ndev = 1;
-			dev_addrs[0] = client->addr;
+		u64 addr;
+
+		for (i = 0; i < TASDEVICE_MAX_CHANNELS; i++) {
+			if (of_property_read_reg(np, i, &addr, NULL))
+				break;
+			dev_addrs[ndev++] = addr;
 		}
-#else
+
+		tas_priv->irq_info.irq_gpio = of_irq_get(np, 0);
+	} else {
 		ndev = 1;
 		dev_addrs[0] = client->addr;
-#endif
-		tas_priv->irq_info.irq_gpio = of_irq_get(np, 0);
 	}
 	tas_priv->ndev = ndev;
 	for (i = 0; i < ndev; i++)
-- 
2.43.0




