Return-Path: <stable+bounces-140656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EFBAAAEA5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24EB3AC925
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21022E5DC0;
	Mon,  5 May 2025 23:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7QBW3+T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1313B36E08B;
	Mon,  5 May 2025 22:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485848; cv=none; b=tj9sIuenph2Jm2eMdWBEt/5Xz9LT3CP1NUwM61YPtURyLSOJtlK3SV9inLcF29sUjb3Tbf9KhVvnEOBNGbpjTtxKZF8WyMkcVAV7PyTy9dR/mziCa5ER+V3FpgEZ4839li5389ngOAQu/spEWmrK+LdeWX5zl3lbm0JObWEgutE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485848; c=relaxed/simple;
	bh=gAz+aUFuLUPxRXt58pKLDYqHkb8l7aAmg0L0zi/3UnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s2GCkdlORtqkX9eS2RPvV7IY1dr9605YoZEtfzLpX6ikKcwPHK7yQGOFa3+ioAc3HCTWuABCGGX37lW50CtwrW6zmpVJSRv7iKQ5YqkNSmIBAUxhwzOndPRMzK9jN07JqY7dTHqj210SwS+OG0VYVgFSKk67g8xP5xtTEm5iAfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7QBW3+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECC4C4CEF2;
	Mon,  5 May 2025 22:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485846;
	bh=gAz+aUFuLUPxRXt58pKLDYqHkb8l7aAmg0L0zi/3UnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g7QBW3+TwTZMUqHW/c8gGyuKfbb6YZtyGvMEvIp3KUJ+89nLo2bAm4KcqtvPSoE4V
	 nEwJucXccWEi3uONuOTg2M/SnxrSfKaBvAObHmFTK1BJ0WftUyG9Kw7Yo4tIT45EZF
	 p/XiOMYHgzxN5QVg6O4Q5BCBdZkNA601fzPcRavBe+LR1DWTuLRu7yeUa6fcUp9HOF
	 b53u1LhL/gs86ORUraJdosmw2CRPc/G92ojjw+haRBn+yIGlGYN5pSPjJgzHMyt5ft
	 MZmha5RrsOzxd39oi7iy+NkHpqKf9EoemBB+FouNS4lHIJdc/5EPKlld4ChJmVflIm
	 IKpZGdWzp34fQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alice Guo <alice.guo@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 026/294] thermal/drivers/qoriq: Power down TMU on system suspend
Date: Mon,  5 May 2025 18:52:06 -0400
Message-Id: <20250505225634.2688578-26-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Alice Guo <alice.guo@nxp.com>

[ Upstream commit 229f3feb4b0442835b27d519679168bea2de96c2 ]

Enable power-down of TMU (Thermal Management Unit) for TMU version 2 during
system suspend to save power. Save approximately 4.3mW on VDD_ANA_1P8 on
i.MX93 platforms.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20241209164859.3758906-2-Frank.Li@nxp.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/qoriq_thermal.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 404f01cca4dab..ff8657afb31d3 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -18,6 +18,7 @@
 #define SITES_MAX		16
 #define TMR_DISABLE		0x0
 #define TMR_ME			0x80000000
+#define TMR_CMD			BIT(29)
 #define TMR_ALPF		0x0c000000
 #define TMR_ALPF_V2		0x03000000
 #define TMTMIR_DEFAULT	0x0000000f
@@ -356,6 +357,12 @@ static int __maybe_unused qoriq_tmu_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (data->ver > TMU_VER1) {
+		ret = regmap_set_bits(data->regmap, REGS_TMR, TMR_CMD);
+		if (ret)
+			return ret;
+	}
+
 	clk_disable_unprepare(data->clk);
 
 	return 0;
@@ -370,6 +377,12 @@ static int __maybe_unused qoriq_tmu_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (data->ver > TMU_VER1) {
+		ret = regmap_clear_bits(data->regmap, REGS_TMR, TMR_CMD);
+		if (ret)
+			return ret;
+	}
+
 	/* Enable monitoring */
 	return regmap_update_bits(data->regmap, REGS_TMR, TMR_ME, TMR_ME);
 }
-- 
2.39.5


