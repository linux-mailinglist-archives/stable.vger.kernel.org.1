Return-Path: <stable+bounces-163646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A6FB0D0FB
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 06:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052B7188C7A9
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 04:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA7228C2D3;
	Tue, 22 Jul 2025 04:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ss/QO73C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22D52E3716
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 04:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753160097; cv=none; b=QdU6OoyvafBnfEq2Ch1rA7ONJOXO6L0LWVSgrlpeKGrbkcrvo5OPWFLQ7Xdfl70RbmZ1cDMZoxxzAOp6VXE0BLVO7CrSO4pmRgotdLTVQeQDzHPCDEwe3abxJOlCxReRE4D7f46/b53m2yGpr8Da2fyMg1ChxtBOdOWPpM59dww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753160097; c=relaxed/simple;
	bh=lgtG8P1GSDL9eXRNkMQBLqoK/gWnmdSjtAO/d3Hd/yE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pyzIKaCchTx1f/voredQQlc7tPG8FSDwZerGEol6kHEXKj9TZHHz6D37lWKT8hLYy291VP2aphGMmoy/6UXyne97j1uzziUpSKE41/1auYbrW52QiulBHgmRD6MTim0Wpl30Z0kjCrbG/XbHQjfbpCFUKztSFwusSll/7PQ1HCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ss/QO73C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA6BC4CEF8;
	Tue, 22 Jul 2025 04:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753160096;
	bh=lgtG8P1GSDL9eXRNkMQBLqoK/gWnmdSjtAO/d3Hd/yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ss/QO73C3uN+nTFbBX2T1QpbL6N19Hqzs8wUkBTl8ouv9q3+OKIx3vj09qg2z6tvx
	 5Uy7i/WS2jG8aEY7StK8Izx7cECnMpG1ZtH0/d8IMjuta62OoVeRaIHIsm64ztaa0S
	 ugBdTxjI5BzFOMklMxtwHESOdiOBYW4E83xm0sdpjhs5gGK1/SxC+ld6CXvngHbT3F
	 SMSLkQQHWaC5VGvaWoDf96VezAtat5yWEPKOIhYzJXfb3w4nJzmk2LtwUcmP9Jgepz
	 +D+ftC1ymEh7AXs/C3mlLiFYRR2GNtxcyjZTdEV/hiqtE7him0UD0Xfobc9suJlQi/
	 mmA8imORg6Stw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] i2c: omap: Handle omap_i2c_init() errors in omap_i2c_probe()
Date: Tue, 22 Jul 2025 00:54:47 -0400
Message-Id: <20250722045447.893946-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250722045447.893946-1-sashal@kernel.org>
References: <2025072119-tragedy-multitude-6649@gregkh>
 <20250722045447.893946-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit a9503a2ecd95e23d7243bcde7138192de8c1c281 ]

omap_i2c_init() can fail. Handle this error in omap_i2c_probe().

Fixes: 010d442c4a29 ("i2c: New bus driver for TI OMAP boards")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: <stable@vger.kernel.org> # v2.6.19+
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/565311abf9bafd7291ca82bcecb48c1fac1e727b.1751701715.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-omap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 5fbce75b5128a..5f1e4ee098c95 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1472,7 +1472,9 @@ omap_i2c_probe(struct platform_device *pdev)
 	}
 
 	/* reset ASAP, clearing any IRQs */
-	omap_i2c_init(omap);
+	r = omap_i2c_init(omap);
+	if (r)
+		goto err_mux_state_deselect;
 
 	if (omap->rev < OMAP_I2C_OMAP1_REV_2)
 		r = devm_request_irq(&pdev->dev, omap->irq, omap_i2c_omap1_isr,
@@ -1515,6 +1517,7 @@ omap_i2c_probe(struct platform_device *pdev)
 
 err_unuse_clocks:
 	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
+err_mux_state_deselect:
 	if (omap->mux_state)
 		mux_state_deselect(omap->mux_state);
 err_put_pm:
-- 
2.39.5


