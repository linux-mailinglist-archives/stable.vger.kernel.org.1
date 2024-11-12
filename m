Return-Path: <stable+bounces-92502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D25E9C563A
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1DE6B39F35
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FDA21C17E;
	Tue, 12 Nov 2024 10:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeR0MVM5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A303521C176;
	Tue, 12 Nov 2024 10:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407808; cv=none; b=DCqLnlvbqxDO0JmF6zZmfZ3nBHrrsPXiy0xPz7j2T5d3PteO7KAOyhJMJfT7vN5X45N20lUoWFqV7vPGY7PeI8LgQ/Ac8dOAXx1EGvycurmJ4DvoAUhYEQyJAhjN5pcSZfiAZb2d+3b0zHEeMB6d9NlTi5Q/v/UhGXAEWWaT5FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407808; c=relaxed/simple;
	bh=KLW78Aruj1qCcuq91Dr6O+M+7iNuJPMYEVGl/u8cg7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYFvED0DLLn1QFWy90wb0D/QNaxrxni4VC1A8wlUKxBMLC4AyE+v4WpEhEA/eyXX4fhQFoD+ua5EiVmyI1YU1d6BZ7t4eH8Xv68t45QSE2rtkT1SjNoWQRufGF5paBMJAqUKKTD+U7RpNesx0fGSrik7QPclibXcZmK4fmjl7bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeR0MVM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34D5C4CECD;
	Tue, 12 Nov 2024 10:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407808;
	bh=KLW78Aruj1qCcuq91Dr6O+M+7iNuJPMYEVGl/u8cg7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eeR0MVM5txAwIUaDfAc8mY+nHB75xzevP/Jn1G0vGJEwMYei9MbiL59f3oq9zcHxL
	 YSCsgGt0oAV9JpTtgd1k81n3jxY/d2SFOhaApUtbSMUksNuEV/Oua/ecPXbauYN6wA
	 Bq9ESY7fzmk4HbWtNauTCv9pvb9to12bONi1LLqkZgzi2IkT/edm1FnseSV1+YiTPx
	 lJXF+9J4+jMawxYhPoP44h6Kig5LMyz0SZ+e3JCg6/OKWp9LwYdV+qQA59IAlWRocj
	 m/lcs1vTxyaoCk74+/FDBMVdy1XC9u4eu1PC1pkcC09JbIflLV5wB/wms5XYoUzKFw
	 1Z66Lu/hMGXJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikhail Rudenko <mike.rudenko@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com
Subject: [PATCH AUTOSEL 6.6 03/15] regulator: rk808: Add apply_bit for BUCK3 on RK809
Date: Tue, 12 Nov 2024 05:36:24 -0500
Message-ID: <20241112103643.1653381-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103643.1653381-1-sashal@kernel.org>
References: <20241112103643.1653381-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.60
Content-Transfer-Encoding: 8bit

From: Mikhail Rudenko <mike.rudenko@gmail.com>

[ Upstream commit 5e53e4a66bc7430dd2d11c18a86410e3a38d2940 ]

Currently, RK809's BUCK3 regulator is modelled in the driver as a
configurable regulator with 0.5-2.4V voltage range. But the voltage
setting is not actually applied, because when bit 6 of
PMIC_POWER_CONFIG register is set to 0 (default), BUCK3 output voltage
is determined by the external feedback resistor. Fix this, by setting
bit 6 when voltage selection is set. Existing users which do not
specify voltage constraints in their device trees will not be affected
by this change, since no voltage setting is applied in those cases,
and bit 6 is not enabled.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Link: https://patch.msgid.link/20241017-rk809-dcdc3-v1-1-e3c3de92f39c@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/rk808-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 867a2cf243f68..2c83cb18d60dc 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -1286,6 +1286,8 @@ static const struct regulator_desc rk809_reg[] = {
 		.n_linear_ranges = ARRAY_SIZE(rk817_buck1_voltage_ranges),
 		.vsel_reg = RK817_BUCK3_ON_VSEL_REG,
 		.vsel_mask = RK817_BUCK_VSEL_MASK,
+		.apply_reg = RK817_POWER_CONFIG,
+		.apply_bit = RK817_BUCK3_FB_RES_INTER,
 		.enable_reg = RK817_POWER_EN_REG(0),
 		.enable_mask = ENABLE_MASK(RK817_ID_DCDC3),
 		.enable_val = ENABLE_MASK(RK817_ID_DCDC3),
-- 
2.43.0


