Return-Path: <stable+bounces-150298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DACACB6BD
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326E54C3CCF
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535D622A1D5;
	Mon,  2 Jun 2025 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vZTQKW4a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A49226D19;
	Mon,  2 Jun 2025 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876679; cv=none; b=CZtsTgCNaTL/OsEu7tY6YPmUUnngWKgk1BKSUWH7N4/JDJk19dvCdutKSCm8OcVXQXlLubD+T19vU9KtmtmGYsXQxsWgfklwdjU+iVLD/17iGEHcw2cOucnK4J2aW4xr3Ry4gHL6gMhgwS9yyyPMKAeM41UgQHBP32TXt03GXUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876679; c=relaxed/simple;
	bh=al5S0/DGvEIZ1uo82U7aCWI02Lm0wK8jwYvMqOFCBdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fz46Q1oE980su7n385C50Z3s6Tq2jgzR+X5wIdxwj+8R82eSHiWC2BHZOlKFY8is9j6HCCIih6oVn70i0yae7wFXURHNE44HOValFuDYXbpgs5PHczN10L5iZRONWyGJGFBr6uPCNQWw0dtxLFPtneav2fugs3MYQcHxzvnhsJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vZTQKW4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A54C4CEEB;
	Mon,  2 Jun 2025 15:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748876678;
	bh=al5S0/DGvEIZ1uo82U7aCWI02Lm0wK8jwYvMqOFCBdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vZTQKW4aqm4dTOsACiOVKgtYmztzGTcpD+myGRczxmi4QBH+P0xZ22W3izAHWTXuG
	 ivH79FJVZiDXVwS4eqdnh+JTFnQwNmTC3qxTVo6JCGj3oKUHAsndrXTnZrxni/pDMt
	 9W0jCM92sg9S32CQw5PXGc7CFyoPOEX6LAwIqu0k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alice Guo <alice.guo@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 038/325] thermal/drivers/qoriq: Power down TMU on system suspend
Date: Mon,  2 Jun 2025 15:45:14 +0200
Message-ID: <20250602134321.304706851@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
References: <20250602134319.723650984@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index d111e218f362e..b33cb1d880b74 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -19,6 +19,7 @@
 #define SITES_MAX		16
 #define TMR_DISABLE		0x0
 #define TMR_ME			0x80000000
+#define TMR_CMD			BIT(29)
 #define TMR_ALPF		0x0c000000
 #define TMR_ALPF_V2		0x03000000
 #define TMTMIR_DEFAULT	0x0000000f
@@ -345,6 +346,12 @@ static int __maybe_unused qoriq_tmu_suspend(struct device *dev)
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
@@ -359,6 +366,12 @@ static int __maybe_unused qoriq_tmu_resume(struct device *dev)
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




