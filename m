Return-Path: <stable+bounces-200777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E95CB515C
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 09:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C5ED300C297
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 08:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E682DA762;
	Thu, 11 Dec 2025 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlfLN/PI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D963E279DC3
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 08:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765440812; cv=none; b=P4YdmVeA/G/s50LDyXo5j6LmKKJQDRLrfbOdrOFPfbGXUr4AwwYnP87v+sD3Mvy/u5NpC1e6VWo5EgzofHlNKUWwQ2s0D8GIOFbldVMuuoZgt/2fhDuhl0ipnFmG/XcBKsfBAhEP0q7h8c93lH/m8+YlNithwLyJcV/2uUP7Gj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765440812; c=relaxed/simple;
	bh=CRdQskgW/O6U/RpBs/bh42YAt536V9Rswk+rIj7pjMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=belaczfBUTo6095QPR0zDGLF5lf7YylQ/9VJOxrb9DawkrnAItOBXMeWUpQfH6IZRd+klE8zYGovJI+QZgJo3uOyCY5BAV0XxM2qV2jqHahs0MfphjlcrMaaf63OtznH7JLTQidxHLHj97PMfaG60cmA0yu2SP7nMKcF1ytGfLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlfLN/PI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297dd95ffe4so6898105ad.3
        for <stable@vger.kernel.org>; Thu, 11 Dec 2025 00:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765440810; x=1766045610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=trUfnuuHzLWg0hqtTbFZbrBapbqubE16vGf51eAqUyI=;
        b=NlfLN/PInJl3l93OXCX/IrY6gg8tW2yrkeDFDYQ75GGNEGfhf61rtrqglE0t7tFr/e
         OkRBc1lkaFE/q2IGYbP16CwLYiWAc95IffbvIR5pvYBNGr+48ZTc4koCbVgnJnK89tQu
         DjF++058N2d8Kpl9FIUiKbdGbWk10xK21EjG2IW09EoEDOLvRe+isNwC6Z3OFx0wpjSv
         JfoRwjY84Wy8BgUw1rSiqshv8fqS2o77QYG77MbusJsreJx8lPfpYvcXZkfOi+2WtQ20
         YUJEaYXHwCPfMUxQ64JozbC+B2SnYg9jlKbjOQ5051BV8k+HQ/gg4nxWkhLi3nlQhgGB
         hlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765440810; x=1766045610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trUfnuuHzLWg0hqtTbFZbrBapbqubE16vGf51eAqUyI=;
        b=PQ6/ya+FMVWhPOIa7hXn0tmz7XNH7tFfnXV+IwP2qTZZDOOumrZUVvydPtZwwRPBEV
         QBUwhywHZQr4gqjR8q9qK4wit2ywG/ltRzMCkrl18s8Lsbn1LssVKtfyatc0SEWuragY
         lz/1cfL8MV6Su9psXN4OJCGgEvkLLutKjA/ZWt18MYny6chX+dBvsudN0PARCrb5CP10
         RX/SmLZiKBJ6TV7aoPfyZW5VT9OiRzgiF1973YzGD8CMcgaEIQZFFuROMuL4mkfqiepk
         MI858kbsVJhXS3P0WXUuJffgT/maPRax/qXrYDGv+4z9JXW+ULmmzhwssXXvp0kuSl5j
         yn9A==
X-Forwarded-Encrypted: i=1; AJvYcCUeG3/kznYb1/wtzIr8EZs+5TIcJRM54lWlRBWeEb+P78G6o+nDh2D9qrXHxedunazkociwtTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOOpbz6/d0pn7bj6cJPfGvwEBGqHGltQxP2I01LoVpTbFonq+I
	QeLiiVt+IqGL+RI6kcMizbOedJV8IGFVR+8b4xe0mgvV/Gb7bvjwhhvy
X-Gm-Gg: AY/fxX5Gp+iAvahle3RAhC9gVo6EfNjhAH+nP/iUt+SwuL0OBYoDDxCx4bLZNz2+TMT
	tpH4HwlH8gw5EMB9JPrU9+57nW3nc64t0fXzUMR0W/kvNQ/ZNO6zj3LCahvOtRiypROUZUVA87a
	6F1cNusej+553oFyRvivoD0/bJJ6suLx9UXMFHEtce4zPlXoG1e6+iUAQWF8XQweWacdGSfl/tp
	iC6dt4mqqmX3JEA57JEnZgJkZ1eZPafnoI6V2jnlSCEBfKn6t6qAep3txC1bMrWo9S3LmrXB/4C
	LDIOEAFOTKSY870EMDj9LLcxRNDxIc+35sp1MPyXZTS8uB22s4WDaa78+cRn04n9lMkvzAHS1nb
	xOAPUBk0YY0eoeVrYO9stoONk9UypEKxJlVSsRETGCLTOiGYoB9oh4UYS6IrJEw1GnZwm7TmKTZ
	9qfGumoesD
X-Google-Smtp-Source: AGHT+IGpU0Pf7s9UlmMW8EGY8yYMuomHFnlX0/Df9bPI6JMt8uShHZ+gMWWhZpAR4wob/58V/qG9Zw==
X-Received: by 2002:a17:903:2c7:b0:295:6a69:4ad5 with SMTP id d9443c01a7336-29ec2803d18mr60221255ad.56.1765440810038;
        Thu, 11 Dec 2025 00:13:30 -0800 (PST)
Received: from c45b92c47440.. ([202.120.234.58])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29eea04036bsm16048855ad.78.2025.12.11.00.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 00:13:29 -0800 (PST)
From: Miaoqian Lin <linmq006@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] net: phy: mediatek: fix nvmem cell reference leak in mt798x_phy_calibration
Date: Thu, 11 Dec 2025 12:13:13 +0400
Message-Id: <20251211081313.2368460-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When nvmem_cell_read() fails in mt798x_phy_calibration(), the function
returns without calling nvmem_cell_put(), leaking the cell reference.

Move nvmem_cell_put() right after nvmem_cell_read() to ensure the cell
reference is always released regardless of the read result.

Found via static analysis and code review.

Fixes: 98c485eaf509 ("net: phy: add driver for MediaTek SoC built-in GE PHYs")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/net/phy/mediatek/mtk-ge-soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index cd09fbf92ef2..2c4bbc236202 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -1167,9 +1167,9 @@ static int mt798x_phy_calibration(struct phy_device *phydev)
 	}
 
 	buf = (u32 *)nvmem_cell_read(cell, &len);
+	nvmem_cell_put(cell);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
-	nvmem_cell_put(cell);
 
 	if (!buf[0] || !buf[1] || !buf[2] || !buf[3] || len < 4 * sizeof(u32)) {
 		phydev_err(phydev, "invalid efuse data\n");
-- 
2.25.1


