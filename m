Return-Path: <stable+bounces-92571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D8F9C5527
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7B0283CFA
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FF222ABE3;
	Tue, 12 Nov 2024 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puyYpvla"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B5D22ABDD;
	Tue, 12 Nov 2024 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407901; cv=none; b=QbxHS5o1JUEIL9eq65nh4teeKR4EzI/PqqOnEAdT4aLNZBuGARbHv612+6t5b4Bq0BQrUz7FPZmfVaN25t1G3mS+cTKI61XzU6AeMK1S3fhfff6+2584XlFnU5glVJZq6Rqmabe1zOE1A1xc6iXDhgGx8CI0JCPkFcB7391lKAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407901; c=relaxed/simple;
	bh=sEc34wpRX0eBku4kE1EPFp/EoeNePJxeiJMPmh+FJTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9ImoPIYhzMM05TAWc+RahP2dopSn4FphUUmvczTaeUMzEGWgu31NwYAFW+P5yIxvrpx4vh8PBNYxp4dXEFOTT7PxcfI18XahyprwZS7iF3EgzBv03Zk4h4XBYpbc+yQKnr9d6eLY+4y8rAA4t4yLbcW7BdC/MglMYYyYDQHzkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puyYpvla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E964C4CED4;
	Tue, 12 Nov 2024 10:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407900;
	bh=sEc34wpRX0eBku4kE1EPFp/EoeNePJxeiJMPmh+FJTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=puyYpvla5mYNaPaepnqctsEtG4YGYyQgvjzh0rX0VKK+OUmaebYh6kvV1HCDidVQH
	 5lm12ENhSX5sZrSlyfLpnGohmqVtlSleiMsK3MMe+wPZLSR0mm6w0wpQ4KyB3PFz99
	 ldiHUzBuhScSyJawEZgwGxuJzzXOv6sckiwN9/2t4/Uv4I5xAUX0OBxtrnRqCn13dZ
	 psnwhnjnioa7GgmKlh2PZrnxJqLSiDB/LJmPYfhO/yQYRC2mrq6xP+6Wm25O4XWbAn
	 RtIYXXql3ut0iZlqiSIxsOYJ3tMPM9LZYzz6BqjF/rxcUifyJJuKfrXL+HqNC5cx2s
	 uaMaCtgky2A2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikhail Rudenko <mike.rudenko@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com
Subject: [PATCH AUTOSEL 5.4 2/5] regulator: rk808: Add apply_bit for BUCK3 on RK809
Date: Tue, 12 Nov 2024 05:38:12 -0500
Message-ID: <20241112103817.1654333-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103817.1654333-1-sashal@kernel.org>
References: <20241112103817.1654333-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.285
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
index 97c846c19c2f6..da34af37f191f 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -959,6 +959,8 @@ static const struct regulator_desc rk809_reg[] = {
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


