Return-Path: <stable+bounces-92475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A0D9C5444
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA2828364F
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94E1216E0A;
	Tue, 12 Nov 2024 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXCvlAw+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C362141B7;
	Tue, 12 Nov 2024 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407770; cv=none; b=ufmtjz8sB4NRk+Ce6k0lleblu0G0OyWLp+iJ79Dk78JR3dM51fuh0KOFW4tZErVB4N7w14WGYw08OdmaC2Anmc5ySNisNzTT/4D3UUcO7lMLRo/sn4i/7mz135WSTgSVdb/LdPe5vUT2ETx5iYshi6yl35jf013VEzKx5SY7/8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407770; c=relaxed/simple;
	bh=qDTKfggIfifvJuPfik/KCBgX29H1nbyOlrV2/JiQlcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjCJS5cRw4GfGbIjHdyNjePfNiPl9LkiJDnvhpkCJ5PkI95NOUHWrB+Ws1oWEp17M1tobPAgUmhz6if/VX1+e0NYuelXjwaUm0dzYjH3SKjKWUl8j+7V8tChwbZqrm5Z+V7CyWsk7bYGD6rRGpuixklho6CZwCOq1LrLvaURRvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXCvlAw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F34C4CED4;
	Tue, 12 Nov 2024 10:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407770;
	bh=qDTKfggIfifvJuPfik/KCBgX29H1nbyOlrV2/JiQlcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WXCvlAw+73+JZ2tnp/aaO3ezb01YDJxO9EVymBdUSvXyUdte4tqRCl4SEvS360z8f
	 QGxiUGqbyP0kZ330dUZ7DYCzZFpxM3aJK6CyFfDFW+rDEgGYwjX7VZg89AUCNbTtfP
	 92TP2tye3zf8MqkZ2ext50XzETNo2dvzWxHxooMcp/EnCmv/KsfDBH0bVaSEMubkMC
	 wrBSikMRcahbeXYIsFseWvbPYjku3a3lJ5ebcmIJLnJwiJqqwWpdinOvKCO1d1YwoI
	 frwmwmXFB15r9srvKPPYG8Jvtt4i/EhkjQaXVEZhusGwkvp01wjstUL8/9n/ioA4wS
	 eLWcOZJGxe5fw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikhail Rudenko <mike.rudenko@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com
Subject: [PATCH AUTOSEL 6.11 03/16] regulator: rk808: Add apply_bit for BUCK3 on RK809
Date: Tue, 12 Nov 2024 05:35:45 -0500
Message-ID: <20241112103605.1652910-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103605.1652910-1-sashal@kernel.org>
References: <20241112103605.1652910-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.7
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
index 14b60abd6afc6..01a8d04879184 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -1379,6 +1379,8 @@ static const struct regulator_desc rk809_reg[] = {
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


