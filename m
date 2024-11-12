Return-Path: <stable+bounces-92547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D02F69C54F1
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884401F24D33
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0BF22B3AA;
	Tue, 12 Nov 2024 10:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRnNXcUT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D063B215035;
	Tue, 12 Nov 2024 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407868; cv=none; b=EB4kzkSEijzHI6pg0To5XBF//gbm/Koc77lhD6c05ydKjL7kH5qDUYL60+eKKDbaiFIeULh3qbAboFSobXv0Y+0/y2+70K/v2I9PIj0UuvrsJYtbXdkvbmL6Xb1D7heJBSgULyezeizFG5wqgT48JSSiFVwFcOjuwop4SrO9Mgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407868; c=relaxed/simple;
	bh=Pj3o9DOYNSuguyP0WWPqdOHvptaSxLOHOGwqMG/NIJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psO9gq5YIOxnRmHlmta91jiWOntyY22lJi674vsApy/VdyGj1CcW+rLAYzA7gyqXlIy63Ib7wS/hA9Wm0Ov7ukTQqPlZ7CGI0pgq732TYaHyMZOhp43409dr2OZ8gI13WpRfhvj0kfXhBzMK27dwTgpQqMEwd5MWodWKpe9usaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRnNXcUT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0257BC4CED8;
	Tue, 12 Nov 2024 10:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407868;
	bh=Pj3o9DOYNSuguyP0WWPqdOHvptaSxLOHOGwqMG/NIJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZRnNXcUTrxyqj4vXxsdRSO+Z2zdbPw3njELqzbs9+uqy6CSSaKKcaLSDC1OFDQonz
	 hzhlobWm+Lq4oXwUhW0lX8vO5REAGUdtUqMatpegrVJsamIiWUJFw0jKEFS7HcszOJ
	 AKvxBCbADTxNzbD2shtCKBxTh3IsGVoe/5PX2owHjGLi/8OBKAUfA2Fck9yVCMjj/k
	 DhFX9vEOKXudaJt/yTve4+WgX3KjFkkj2HvoeZn5h1N90dFP1X/E8bVbm6eCTPFlTR
	 VgwJP2khWrJixT9q5ZvMT4guEZ/RTc1+zKDkVFu+w5LuR0V4oaTJNNtRU7sLl7y84K
	 n8c3NVtmgIcfQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikhail Rudenko <mike.rudenko@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com
Subject: [PATCH AUTOSEL 5.15 2/8] regulator: rk808: Add apply_bit for BUCK3 on RK809
Date: Tue, 12 Nov 2024 05:37:36 -0500
Message-ID: <20241112103745.1653994-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103745.1653994-1-sashal@kernel.org>
References: <20241112103745.1653994-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.171
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
index 127dc2e2e6903..0763a5bbee2f5 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -906,6 +906,8 @@ static const struct regulator_desc rk809_reg[] = {
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


