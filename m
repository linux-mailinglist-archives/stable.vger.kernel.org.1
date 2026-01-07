Return-Path: <stable+bounces-206078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DF6CFBC0D
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 03:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EC6330AC743
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 02:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B4A227BA4;
	Wed,  7 Jan 2026 02:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioHMM/Zo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BD821CC44
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 02:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767753218; cv=none; b=KTLGgh4un2tTXA0THdTefh6IJ7qt3P8krJkYGJlPxxHgeaT8idoEkhWUltENuXBsFpfQtSVAiuyNIt5QsVqEFyadv2kLl/PjMdGcotr3mHeSgdJDRqZXIljGE/HwpqdeDZwK1Vjhi/R7RUJ8bKzSwHGL6kjRycJCj8iub/FdEIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767753218; c=relaxed/simple;
	bh=7KjNvX19PkwWR5/mM5N6FR120omxR/jCQWDFLMlI1Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAEubsZVE5MsN//sP5lkBk7gdoR4Ued51rKoj1LgPMdHYuT3clL0bxr90Wo9cv3QpNmXJPuXdxmBH06wau9noeEZbjZHoE0Cf1eDSDU47y8Lzj46SsY6u75COvbhzhgu7Rtn39/15es74E81RR9aQmzYOSUOWSsjuf7nsii7Cvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioHMM/Zo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CE2C116C6;
	Wed,  7 Jan 2026 02:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767753218;
	bh=7KjNvX19PkwWR5/mM5N6FR120omxR/jCQWDFLMlI1Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ioHMM/ZoY7htscR4joGitOiX/Tcfu+IUbktSmbgYGucm/tAxnpkw045wQJOwHGj1N
	 ZUy4y2dpR5rHFNRLMcNInylnBB9F5Izh6xlcdmo2qvwB/4Ok3ZMUEF74eWsKQ3bxXl
	 Zeh4sCp1LqNk0nMFNcQm7pHmN6DX8xDdt0xuUKTtB0bKDh1AbgJeUY4dvm7334X5xa
	 qZ9voylfI+2hr1EnZwfjbbnmoOiL1Y++amN5gMfTwriQLLFx1Vjr4oQBgfLfF5FgUZ
	 t89wewUctMeR9/kMWZnpvU0xDGqojcsfNXP9+vVh0Yb9a5esEHuPrVnfwObO4XIgej
	 H5h2w3erZPKzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miaoqian Lin <linmq006@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] net: phy: mediatek: fix nvmem cell reference leak in mt798x_phy_calibration
Date: Tue,  6 Jan 2026 21:33:35 -0500
Message-ID: <20260107023335.3509482-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010551-shredding-placidly-0c57@gregkh>
References: <2026010551-shredding-placidly-0c57@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit 1e5a541420b8c6d87d88eb50b6b978cdeafee1c9 ]

When nvmem_cell_read() fails in mt798x_phy_calibration(), the function
returns without calling nvmem_cell_put(), leaking the cell reference.

Move nvmem_cell_put() right after nvmem_cell_read() to ensure the cell
reference is always released regardless of the read result.

Found via static analysis and code review.

Fixes: 98c485eaf509 ("net: phy: add driver for MediaTek SoC built-in GE PHYs")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20251211081313.2368460-1-linmq006@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/mediatek-ge-soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mediatek-ge-soc.c b/drivers/net/phy/mediatek-ge-soc.c
index f4f9412d0cd7..4b2a9a5444c5 100644
--- a/drivers/net/phy/mediatek-ge-soc.c
+++ b/drivers/net/phy/mediatek-ge-soc.c
@@ -1082,9 +1082,9 @@ static int mt798x_phy_calibration(struct phy_device *phydev)
 	}
 
 	buf = (u32 *)nvmem_cell_read(cell, &len);
+	nvmem_cell_put(cell);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
-	nvmem_cell_put(cell);
 
 	if (!buf[0] || !buf[1] || !buf[2] || !buf[3] || len < 4 * sizeof(u32)) {
 		phydev_err(phydev, "invalid efuse data\n");
-- 
2.51.0


