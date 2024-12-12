Return-Path: <stable+bounces-102788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CCA9EF4B8
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0964E178C44
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E70A23589C;
	Thu, 12 Dec 2024 16:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IQA4C7/W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC10E235891;
	Thu, 12 Dec 2024 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022493; cv=none; b=tiVia8BOwBc5zAVi0ZN7Fa283557HnTOU1aQ8sjFP/BhWcN09XoEVNG5bgGON7/UmNfXjzr5ln6in587agLElHCDoO6Ky4xFXvdv0LILtoZoSEXRfBFmtKS5lx62VwD3vKNXqscpakeneGihC4HS4hbGolhMh+mXFDPmsYLQEcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022493; c=relaxed/simple;
	bh=uzOUhzEfYUIGHuodoQZSvIp+XOwTGstfb9OWAfO5Dow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oP97ERPnXAviaJZxjcDpHPUFgi2OhRPfRzuqqijbxynahyHW6ViMNMBolt0AiuKmcPLyE+opHQG8lccV/0GnMqdmavVN8WNNq5YNlzlkgubkF4c8/eq1bis8hwlrTP/O2yPLDGqHm5Q/PkzGHVkKkKda6KS1/f6m1+lPs5H+uak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IQA4C7/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AEAC4CECE;
	Thu, 12 Dec 2024 16:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734022493;
	bh=uzOUhzEfYUIGHuodoQZSvIp+XOwTGstfb9OWAfO5Dow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IQA4C7/WYcsFCULQzL/sEityGDFHiP4YIMm3VqdGhFaHMAekeXeWXb51/Ts93ldKa
	 mcG1uf7OrGQE+GySbEIMO9ka6plWIoXarZrC5pcJcbsvka438PsWoyCIgV9ZGqD9i7
	 PUk5B90f7QHxObho6z+1KGbnYdyR98H3UaURGt4E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Changzhong <zhangchangzhong@huawei.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 225/565] mfd: rt5033: Fix missing regmap_del_irq_chip()
Date: Thu, 12 Dec 2024 15:57:00 +0100
Message-ID: <20241212144320.383223987@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Changzhong <zhangchangzhong@huawei.com>

[ Upstream commit d256d612f47529ed0b332298e2d5ea981a4dd5b8 ]

Fix missing call to regmap_del_irq_chip() in error handling path by
using devm_regmap_add_irq_chip().

Fixes: 0b271258544b ("mfd: rt5033: Add Richtek RT5033 driver core.")
Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
Link: https://lore.kernel.org/r/1730302867-8391-1-git-send-email-zhangchangzhong@huawei.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/rt5033.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
index df095e91e2666..78bafeda5e470 100644
--- a/drivers/mfd/rt5033.c
+++ b/drivers/mfd/rt5033.c
@@ -82,8 +82,8 @@ static int rt5033_i2c_probe(struct i2c_client *i2c,
 	}
 	dev_info(&i2c->dev, "Device found Device ID: %04x\n", dev_id);
 
-	ret = regmap_add_irq_chip(rt5033->regmap, rt5033->irq,
-			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+	ret = devm_regmap_add_irq_chip(rt5033->dev, rt5033->regmap,
+			rt5033->irq, IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 			0, &rt5033_irq_chip, &rt5033->irq_data);
 	if (ret) {
 		dev_err(&i2c->dev, "Failed to request IRQ %d: %d\n",
-- 
2.43.0




