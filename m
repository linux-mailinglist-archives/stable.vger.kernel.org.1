Return-Path: <stable+bounces-87862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0D19ACCA4
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B111C2138B
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E8A1D9A50;
	Wed, 23 Oct 2024 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6+S0XV9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22281D9667;
	Wed, 23 Oct 2024 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693861; cv=none; b=ZRAVLsB4weDwX7QJgC0809e9448GYyb3F4K/dYU7uCdoNI4/zu0FmKk0x+F5lWwkUJWxt9WzvoKaXKzZtiWWKUzWbSUsuif0FnWAZ1Eo8Mgw0p4tPAnY2y/1H2AlS+4MMPqtnLcoJslxIzpFxEUfAo7Hvc7GDN4ltrvLuq1hL7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693861; c=relaxed/simple;
	bh=TJDqKmWx8NFMqxvpICR8eEvMuQorJuWmsNwdKIDufc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNu9SsN+BGcADxSq/nUAHBcE4yVV2qHEG1g+TY+TrFeeT8iHwY6rxglVVkvIxTVQayVnFiGyIAijtbL3Z9F7lvL2F7RfkhwGxJISVaVz0qPRJK/khAOdmG8wrO2KodDZEhTIqu621v+hD2HOaDhLNR0EIkl+IaJYCaDa8lKYWtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6+S0XV9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B57C4CEE6;
	Wed, 23 Oct 2024 14:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693861;
	bh=TJDqKmWx8NFMqxvpICR8eEvMuQorJuWmsNwdKIDufc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C6+S0XV90y4L3qG1gkwQ6Oypyk/YyaIkS2INgK5gWarYAh8jDf3K800YPs/JKDzs3
	 dP25QqH4Vdum75Q6KcVNhTm/swv6VW9w2YRFF7/JKKULcIxeClL9jbIFrsoy9eX5Sy
	 Kgt/VARXuXvxlZSJY6DwHDHBjqI14nCwwfX/SrQ/WUJnz6hRo1kt12DtFguvDfNsI+
	 OBSOrIXrK3Nv9NYhLjkQbci1/bMhFsttA6X53obx/iSK5akBlHoKntqugMFiSN3czc
	 KltLVirXuguMtxj0oF9OCK0+xL3EFbIEDxFVMG3b3RmD+FpbOuCDEwy4BUtmWVv+TC
	 g1erKtq0WuowA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	opendmb@gmail.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 27/30] net: phy: mdio-bcm-unimac: Add BCM6846 support
Date: Wed, 23 Oct 2024 10:29:52 -0400
Message-ID: <20241023143012.2980728-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143012.2980728-1-sashal@kernel.org>
References: <20241023143012.2980728-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 906b77ca91c7e9833b4e47bedb6bec76be71d497 ]

Add Unimac mdio compatible string for the special BCM6846
variant.

This variant has a few extra registers compared to other
versions.

Suggested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/linux-devicetree/b542b2e8-115c-4234-a464-e73aa6bece5c@broadcom.com/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://patch.msgid.link/20241012-bcm6846-mdio-v1-2-c703ca83e962@linaro.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/mdio/mdio-bcm-unimac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mdio/mdio-bcm-unimac.c b/drivers/net/mdio/mdio-bcm-unimac.c
index f40eb50bb978d..b7bc70586ee0a 100644
--- a/drivers/net/mdio/mdio-bcm-unimac.c
+++ b/drivers/net/mdio/mdio-bcm-unimac.c
@@ -337,6 +337,7 @@ static const struct of_device_id unimac_mdio_ids[] = {
 	{ .compatible = "brcm,asp-v2.2-mdio", },
 	{ .compatible = "brcm,asp-v2.1-mdio", },
 	{ .compatible = "brcm,asp-v2.0-mdio", },
+	{ .compatible = "brcm,bcm6846-mdio", },
 	{ .compatible = "brcm,genet-mdio-v5", },
 	{ .compatible = "brcm,genet-mdio-v4", },
 	{ .compatible = "brcm,genet-mdio-v3", },
-- 
2.43.0


