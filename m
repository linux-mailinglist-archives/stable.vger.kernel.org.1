Return-Path: <stable+bounces-87886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC36F9ACCE9
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1FB01C20F17
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BB3206E94;
	Wed, 23 Oct 2024 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+eRgqnP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3AE206972;
	Wed, 23 Oct 2024 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693912; cv=none; b=DxF07Xd1pErlSI34wIS0V2zsaeCOrb1VvRnRUYVFpQVs5Nkag7X4Zxv3aWkcZ7s/KLMuQnHoEYvgPC4ezbm04ZmKCyIKSrPXoC4wJjDpgRpP5QtFC7XJMnCHha/XbsOCMDLjMY+gq1O/v+97GMcXluxj4WBMLv7l8hitBCKDlQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693912; c=relaxed/simple;
	bh=SlBQzsEAo/x6o3r86R4cy7HoJeHZz3+LE9P1qcBrK2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7pyLFGpZ7NsI0bKSs/He2p2/S50uglTnNuN5cemgporGGkfjOsazgRtmevx10z3l2Efz3aQ+imwm6XVHp0hGlODz0pn7yng04qFxQ+HQ7dN+dmcYIkcwSQSAONGnzr89s5rWGQykSFjMBUyQ4+lpqxj5Lm9HPSLbSwhbVqAzMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+eRgqnP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C48AC4CEE6;
	Wed, 23 Oct 2024 14:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693912;
	bh=SlBQzsEAo/x6o3r86R4cy7HoJeHZz3+LE9P1qcBrK2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s+eRgqnP/VPHsscwlonC5nIkcjq8IWkbnhskQqFtqH3RS7fl2Z5DBhPMiUPqCPeSj
	 WUZpNbPjawDoKUxQZm1iOqQYAsrdU6/Z7J3t6CCFSn++6QJ1HLc9yGVPVNnCV64KOp
	 hxznGR9BBmIHdri2dwHfkMCXjjPpcsVmGp/NGyYwOWezay+NVdIU9ND5T417QVtnuz
	 ea1bCrhLV3B0zBMTIoHe5RNH/sA5pqGQBep9gqC+qPebed8dWFx3RV37003qOoa38X
	 eYafkTi9Y3rTngyOssyZhp2rHdNP0Y5cYRD68Ia60cZOgGjw3UtHVbt3tSPvZkxpoT
	 fpdFbKDgvGHWg==
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
Subject: [PATCH AUTOSEL 6.6 21/23] net: phy: mdio-bcm-unimac: Add BCM6846 support
Date: Wed, 23 Oct 2024 10:31:05 -0400
Message-ID: <20241023143116.2981369-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143116.2981369-1-sashal@kernel.org>
References: <20241023143116.2981369-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
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
index 6b26a0803696d..a29838be335c9 100644
--- a/drivers/net/mdio/mdio-bcm-unimac.c
+++ b/drivers/net/mdio/mdio-bcm-unimac.c
@@ -336,6 +336,7 @@ static SIMPLE_DEV_PM_OPS(unimac_mdio_pm_ops,
 static const struct of_device_id unimac_mdio_ids[] = {
 	{ .compatible = "brcm,asp-v2.1-mdio", },
 	{ .compatible = "brcm,asp-v2.0-mdio", },
+	{ .compatible = "brcm,bcm6846-mdio", },
 	{ .compatible = "brcm,genet-mdio-v5", },
 	{ .compatible = "brcm,genet-mdio-v4", },
 	{ .compatible = "brcm,genet-mdio-v3", },
-- 
2.43.0


