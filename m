Return-Path: <stable+bounces-129211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B892A7FE8C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828EB443496
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7248A268C60;
	Tue,  8 Apr 2025 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kz/Wlq0t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E19268C55;
	Tue,  8 Apr 2025 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110418; cv=none; b=CLQ6dGEbV8VXmgLeFvvhIW9DCGlXXw2VZlRHO8gQKNCl4RDWkYJkI+IZZ+fc1/FbM75NoZVgzAH5G7f6HNLCPqY710fylay2qlXu7qwLnv9m1Fdqb1jo2XUa7MiofO4m/tso7Xbelnnu8/B6Lv2sRXkBcjomM+535phx76Iz1RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110418; c=relaxed/simple;
	bh=6r84KfGZC9szhkteigqFSescz8OFnpQLktmL23gvT6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfLHULS2HhbjDmSfZtp+RLh3h4iE5Aw3E8VHOf3wHJW36UJf/OIsxSIIZQOn6ZR9txoEUU389R9q2BZrfsfCTqgmLUZBIvcDw4AJIcLTLqMYTZIFGQWfqGM/cFwSO8ks1uzisw1PZRcePVfEk/HVs0KsobqJbZzNMNNSYzdh6HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kz/Wlq0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F087C4CEE5;
	Tue,  8 Apr 2025 11:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744110418;
	bh=6r84KfGZC9szhkteigqFSescz8OFnpQLktmL23gvT6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kz/Wlq0tAadLUcR2/nWCXZiivAhUjX1WPMR6gOhu9csGA3dtJHdmb/BE+IB3edUKK
	 XH5K+cHIKSTHmO2dQ/xjDirlJjWNRtswfooFNsEysnNfxA/7EQXpqycehxEKJy4Jy3
	 +MwZPZLx7MBJs0GvRl+fw1kjfsBt/9VF0dwhi1/4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Marek Vasut <marex@denx.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 057/731] regulator: pca9450: Fix enable register for LDO5
Date: Tue,  8 Apr 2025 12:39:14 +0200
Message-ID: <20250408104915.599546205@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frieder Schrempf <frieder.schrempf@kontron.de>

[ Upstream commit f5aab0438ef17f01c5ecd25e61ae6a03f82a4586 ]

The LDO5 regulator has two configuration registers, but only
LDO5CTRL_L contains the bits for enabling/disabling the regulator.

Fixes: 0935ff5f1f0a ("regulator: pca9450: add pca9450 pmic driver")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Marek Vasut <marex@denx.de>
Link: https://patch.msgid.link/20241218152842.97483-6-frieder@fris.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/pca9450-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index faa6b79c27d75..dfe1dd93d56f5 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -460,7 +460,7 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo5_volts),
 			.vsel_reg = PCA9450_REG_LDO5CTRL_H,
 			.vsel_mask = LDO5HOUT_MASK,
-			.enable_reg = PCA9450_REG_LDO5CTRL_H,
+			.enable_reg = PCA9450_REG_LDO5CTRL_L,
 			.enable_mask = LDO5H_EN_MASK,
 			.owner = THIS_MODULE,
 		},
@@ -674,7 +674,7 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo5_volts),
 			.vsel_reg = PCA9450_REG_LDO5CTRL_H,
 			.vsel_mask = LDO5HOUT_MASK,
-			.enable_reg = PCA9450_REG_LDO5CTRL_H,
+			.enable_reg = PCA9450_REG_LDO5CTRL_L,
 			.enable_mask = LDO5H_EN_MASK,
 			.owner = THIS_MODULE,
 		},
@@ -864,7 +864,7 @@ static const struct pca9450_regulator_desc pca9451a_regulators[] = {
 			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo5_volts),
 			.vsel_reg = PCA9450_REG_LDO5CTRL_H,
 			.vsel_mask = LDO5HOUT_MASK,
-			.enable_reg = PCA9450_REG_LDO5CTRL_H,
+			.enable_reg = PCA9450_REG_LDO5CTRL_L,
 			.enable_mask = LDO5H_EN_MASK,
 			.owner = THIS_MODULE,
 		},
-- 
2.39.5




