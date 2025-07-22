Return-Path: <stable+bounces-163648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2D6B0D0FD
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 06:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 597EC7AC644
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 04:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46DD28C2D0;
	Tue, 22 Jul 2025 04:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHUuBsa3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E2D2E3716
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 04:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753160154; cv=none; b=pMLugU0MjL68L8sMnmlAr2iO9sjOE/rdzG1Wv4vcFtkgmRzeRJj0YGhA+KDs/ifkj5dFu2xKWrW6rBD8MYMW5B86ne2EUz7FK3gp3jfeyh8+R0Mf/9H+PPsxc8x4YZig8tV/R86dqbh97NsODfP6Ni8C0z22wSng94R/8fpjjW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753160154; c=relaxed/simple;
	bh=R2uFK6+ptSE2IRYg/UVSpTJk+Jk9VSHFc9ct/MDWRCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YQ3LQdorliuiNLVEiLbcy9jZH84779FS2WVz8bQkTriEjZqNWpBfaAr63pwD4YL18qKqRPsK0ET+n73OLi7bjE/T0odUs7argZbrjaByV8wUdT8gYpV1qlrkM1oxi+ciDabb4LcjpCIvoj96pXKLtIHuqk3OPtHBKFRwaRKt/ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHUuBsa3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EDCC4CEEB;
	Tue, 22 Jul 2025 04:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753160154;
	bh=R2uFK6+ptSE2IRYg/UVSpTJk+Jk9VSHFc9ct/MDWRCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DHUuBsa3C9J9hrMumEnGCBZgbO0L/SjwI3I8Bm//nD/RLbhu/p9T9w1aL+WTa5xTM
	 pJhbqeP88daH//ZoJQ8uHGwstjYa6pUcTpe4EsG9M15PkUPuMkpdB/y3fUTfUsEzkX
	 aWTEItahYbyaWGTSJO5t3KmfLoB9W7wADeJw94aMkP+YSuwWDkFZJ8USnSoI/e+ZLv
	 qYcP4nOzTU6iHjNUyScmCY9Kr2FEWIIkYsjx47Ka5vKzTSq4rXtBY7zg+TqHg+7ll9
	 M2rFmhZew9RAkdaWA/AV3+wKgHh2cn919P2700ZEKyuff3M4X/iYpEOYbQkxApNLjb
	 9wSFpSuq7tCVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] i2c: omap: Fix an error handling path in omap_i2c_probe()
Date: Tue, 22 Jul 2025 00:55:33 -0400
Message-Id: <20250722045534.894081-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250722045534.894081-1-sashal@kernel.org>
References: <2025072119-stifling-dismount-033b@gregkh>
 <20250722045534.894081-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 666c23af755dccca8c25b5d5200ca28153c69a05 ]

If an error occurs after calling mux_state_select(), mux_state_deselect()
should be called as already done in the remove function.

Fixes: b6ef830c60b6 ("i2c: omap: Add support for setting mux")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: <stable@vger.kernel.org> # v6.15+
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/998542981b6d2435c057dd8b9fe71743927babab.1749913149.git.christophe.jaillet@wanadoo.fr
Stable-dep-of: a9503a2ecd95 ("i2c: omap: Handle omap_i2c_init() errors in omap_i2c_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-omap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index ffc116e76ba18..16c5d79143ff8 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1464,13 +1464,13 @@ omap_i2c_probe(struct platform_device *pdev)
 		if (IS_ERR(mux_state)) {
 			r = PTR_ERR(mux_state);
 			dev_dbg(&pdev->dev, "failed to get I2C mux: %d\n", r);
-			goto err_disable_pm;
+			goto err_put_pm;
 		}
 		omap->mux_state = mux_state;
 		r = mux_state_select(omap->mux_state);
 		if (r) {
 			dev_err(&pdev->dev, "failed to select I2C mux: %d\n", r);
-			goto err_disable_pm;
+			goto err_put_pm;
 		}
 	}
 
@@ -1518,6 +1518,9 @@ omap_i2c_probe(struct platform_device *pdev)
 
 err_unuse_clocks:
 	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
+	if (omap->mux_state)
+		mux_state_deselect(omap->mux_state);
+err_put_pm:
 	pm_runtime_dont_use_autosuspend(omap->dev);
 	pm_runtime_put_sync(omap->dev);
 err_disable_pm:
-- 
2.39.5


