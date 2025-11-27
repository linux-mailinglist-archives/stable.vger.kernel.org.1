Return-Path: <stable+bounces-197106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA21C8E93A
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1C4BC351141
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 13:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E05D2877C2;
	Thu, 27 Nov 2025 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r508GE7U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3548D223DE8;
	Thu, 27 Nov 2025 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251338; cv=none; b=QQc7AFkQukh9JUE02/sIuj7anVKrrMLI9NRQeWFQHWtFaq+gatskSSJe4Qq92KYRoXuN31gNVNtB6hmFgkwZNsLxJXAyQdnnJXbfC8J5Nr49rJ+TsdwIFBgBQmYNvR2gEPXMuYPzixH0o2LQSOLKbLSRBg8oCcUYdT9RAh0DRbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251338; c=relaxed/simple;
	bh=N2+IV1yRY0T/LRl/K2e/owyDnFap0O5LSqnWZ9obaNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ADxjybLP6ULeazYJ6JKg3lg73z/cY8qqDtX8e578T3Bi6JxmSb9V55tguQqYK4vzuQR+Zgvm0XBbBSR6T1z+q7VVcKR0uh6SjkwYuSqTjse2G3KJrkz3xQfkVdQbR6oQv85FU4nXhGn6HXW4gRwHNEHxlaBA3tAlyI2h622Jo2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r508GE7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA45C4CEF8;
	Thu, 27 Nov 2025 13:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764251337;
	bh=N2+IV1yRY0T/LRl/K2e/owyDnFap0O5LSqnWZ9obaNg=;
	h=From:To:Cc:Subject:Date:From;
	b=r508GE7UTowlumnhCbER64bfwPrvcIIFZGX2rAoWGGErHMNURRoAItuSkCK+TUpdo
	 2inaOAv7ca1pUEAfyzDaNVNdNqiq563o093ZjdiLT48SHvXoLzRZ+pm+36czW8cT41
	 JpGe3DY05mgJOOQgdaTz6Ny6vMFFnr9NdhrA8Fx+arT1fR2FbvUm1I1MmfVy1ALmQ5
	 M7+Y88C1HHhYKwAMSrSezssUJfIuwLG7y0TZvZOvqpope8hPCpISqLwCvBjNMiHulC
	 hgeeOpUHoqXPkGVUpVJ6jakPG2TAJAnaBqYpZK7l1x8Xby7QDa8HhNrKjzdiEesWOE
	 XemmX0oycosvA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vOcMm-000000000XO-11gd;
	Thu, 27 Nov 2025 14:49:00 +0100
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Andrew Davis <afd@ti.com>
Subject: [PATCH] phy: ti: gmii-sel: fix regmap leak on probe failure
Date: Thu, 27 Nov 2025 14:48:34 +0100
Message-ID: <20251127134834.2030-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mmio regmap that may be allocated during probe is never freed.

Switch to using the device managed allocator so that the regmap is
released on probe failures (e.g. probe deferral) and on driver unbind.

Fixes: 5ab90f40121a ("phy: ti: gmii-sel: Do not use syscon helper to build regmap")
Cc: stable@vger.kernel.org	# 6.14
Cc: Andrew Davis <afd@ti.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/phy/ti/phy-gmii-sel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index 50adabb867cb..26209a89703a 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -512,7 +512,7 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
 			return dev_err_probe(dev, PTR_ERR(base),
 					     "failed to get base memory resource\n");
 
-		priv->regmap = regmap_init_mmio(dev, base, &phy_gmii_sel_regmap_cfg);
+		priv->regmap = devm_regmap_init_mmio(dev, base, &phy_gmii_sel_regmap_cfg);
 		if (IS_ERR(priv->regmap))
 			return dev_err_probe(dev, PTR_ERR(priv->regmap),
 					     "Failed to get syscon\n");
-- 
2.51.2


