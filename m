Return-Path: <stable+bounces-49793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B968FEEE1
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03B1284FAA
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD561A1875;
	Thu,  6 Jun 2024 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pI+2Pw7C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC4A1C89EF;
	Thu,  6 Jun 2024 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683712; cv=none; b=jXX4Staqie+40ZM7EwYLbm3ItgekUHVW6JW7W4XSgyds1KfhUFP1s7lbM8qNXS4jqgmUQrnhxaPnud3oOGTt7yZ4ZbB7JMGrgWalPGExWBoykSpbrnWTSiqNH6snLJa8gyAvx31AmksX9SzS/Iy9xsb9g+ZZvnEWIh/yvfEeGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683712; c=relaxed/simple;
	bh=3bKBLLX2J7ffgaCdWSGiq71yAghlEr8PyXwJzvbRALI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XINsyMd/FkqhT2KfhxOp7Bswr6wzCSqM1/PxFyWnt3Q8iD4gwedrSHHwjgRL0e8V8FOM385AUFlvnGHLUnQjanFFhBXO4YYixBYnsmTgzahpwj1u7ON74kbGuYHqJpQsmRelAurG6q/6A9ajcidcNTdmjwxURTO3YhWtO0XY8Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pI+2Pw7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F82C32782;
	Thu,  6 Jun 2024 14:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683712;
	bh=3bKBLLX2J7ffgaCdWSGiq71yAghlEr8PyXwJzvbRALI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pI+2Pw7CNlUNkwlL2FiYBlnkdkQqLO/mPjapfm6o2LNGKcZ4uKrxMeP8Ea+OaxK/4
	 BgiZAR2+/sckAmfjE5hthXqwaqGp3ioxkKUs+5QLNNlZJsJXmxJlH3rnGOBxOnMYLF
	 Ox3p0j0BGEkydxBI3bts1MDdNH3gINR1J5Shc4HI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 643/744] regulator: pickable ranges: dont always cache vsel
Date: Thu,  6 Jun 2024 16:05:15 +0200
Message-ID: <20240606131753.095741971@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

From: Matti Vaittinen <mazziesaccount@gmail.com>

[ Upstream commit f4f4276f985a5aac7b310a4ed040b47e275e7591 ]

Some PMICs treat the vsel_reg same as apply-bit. Eg, when voltage range
is changed, the new voltage setting is not taking effect until the vsel
register is written.

Add a flag 'range_applied_by_vsel' to the regulator desc to indicate this
behaviour and to force the vsel value to be written to hardware if range
was changed, even if the old selector was same as the new one.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Link: https://msgid.link/r/ZktCpcGZdgHWuN_L@fedora
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 1ace99d7c7c4 ("regulator: tps6287x: Force writing VSEL bit")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/helpers.c      | 43 ++++++++++++++++++++++----------
 include/linux/regulator/driver.h |  3 +++
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index d492683365532..6e1ace660b8cf 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -161,6 +161,32 @@ int regulator_get_voltage_sel_pickable_regmap(struct regulator_dev *rdev)
 }
 EXPORT_SYMBOL_GPL(regulator_get_voltage_sel_pickable_regmap);
 
+static int write_separate_vsel_and_range(struct regulator_dev *rdev,
+					 unsigned int sel, unsigned int range)
+{
+	bool range_updated;
+	int ret;
+
+	ret = regmap_update_bits_base(rdev->regmap, rdev->desc->vsel_range_reg,
+				      rdev->desc->vsel_range_mask,
+				      range, &range_updated, false, false);
+	if (ret)
+		return ret;
+
+	/*
+	 * Some PMICs treat the vsel_reg same as apply-bit. Force it to be
+	 * written if the range changed, even if the old selector was same as
+	 * the new one
+	 */
+	if (rdev->desc->range_applied_by_vsel && range_updated)
+		return regmap_write_bits(rdev->regmap,
+					rdev->desc->vsel_reg,
+					rdev->desc->vsel_mask, sel);
+
+	return regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg,
+				  rdev->desc->vsel_mask, sel);
+}
+
 /**
  * regulator_set_voltage_sel_pickable_regmap - pickable range set_voltage_sel
  *
@@ -199,21 +225,12 @@ int regulator_set_voltage_sel_pickable_regmap(struct regulator_dev *rdev,
 	range = rdev->desc->linear_range_selectors_bitfield[i];
 	range <<= ffs(rdev->desc->vsel_range_mask) - 1;
 
-	if (rdev->desc->vsel_reg == rdev->desc->vsel_range_reg) {
-		ret = regmap_update_bits(rdev->regmap,
-					 rdev->desc->vsel_reg,
+	if (rdev->desc->vsel_reg == rdev->desc->vsel_range_reg)
+		ret = regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg,
 					 rdev->desc->vsel_range_mask |
 					 rdev->desc->vsel_mask, sel | range);
-	} else {
-		ret = regmap_update_bits(rdev->regmap,
-					 rdev->desc->vsel_range_reg,
-					 rdev->desc->vsel_range_mask, range);
-		if (ret)
-			return ret;
-
-		ret = regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg,
-				  rdev->desc->vsel_mask, sel);
-	}
+	else
+		ret = write_separate_vsel_and_range(rdev, sel, range);
 
 	if (ret)
 		return ret;
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 4b7eceb3828b0..2dbf87233f85a 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -304,6 +304,8 @@ enum regulator_type {
  * @vsel_range_reg: Register for range selector when using pickable ranges
  *		    and ``regulator_map_*_voltage_*_pickable`` functions.
  * @vsel_range_mask: Mask for register bitfield used for range selector
+ * @range_applied_by_vsel: A flag to indicate that changes to vsel_range_reg
+ *			   are only effective after vsel_reg is written
  * @vsel_reg: Register for selector when using ``regulator_map_*_voltage_*``
  * @vsel_mask: Mask for register bitfield used for selector
  * @vsel_step: Specify the resolution of selector stepping when setting
@@ -394,6 +396,7 @@ struct regulator_desc {
 
 	unsigned int vsel_range_reg;
 	unsigned int vsel_range_mask;
+	bool range_applied_by_vsel;
 	unsigned int vsel_reg;
 	unsigned int vsel_mask;
 	unsigned int vsel_step;
-- 
2.43.0




