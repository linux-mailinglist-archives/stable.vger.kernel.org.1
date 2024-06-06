Return-Path: <stable+bounces-48552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4528FE97F
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB0D1B207D2
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45999197A9B;
	Thu,  6 Jun 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="geRv6c4J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02782196C77;
	Thu,  6 Jun 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683030; cv=none; b=gaBxGLbfVIThP/sBh6NRORyhYjJzXVsenrbbXkFMk0lt8qB5620WLxX4B0sc+Ckm7GchCb8/TvLeSY5Gtkf2zl7FbVm1iIQcXasQe9nQRhBL5IZx3K+gP+VddDOoVwMcM5UGEl/5ukJUAt/qZ70ZSNqSb5uuHHvLc7i+eQe8IOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683030; c=relaxed/simple;
	bh=JQ72QMpw1rZR2/WPcRh1BmXM+hom9ejGbR5U83oDahc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vcgl4AXbwZqh2HFPq0VDPgmP4AVjaqm99m+LZaV0aAAl6sB+nOY+pm3jtv1FaxuD+Zol6DZysSPv+5TjflFjFvVaSSb/7IUxApvmwL4jm2Xoa7EHDLPykiqD1ArLWpqlLQAV9JNvalgqkZMDhQqQgiD3T0Oc0mmsXWsvWFGz7ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=geRv6c4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A31C2BD10;
	Thu,  6 Jun 2024 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683029;
	bh=JQ72QMpw1rZR2/WPcRh1BmXM+hom9ejGbR5U83oDahc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=geRv6c4Jgt6d2rl1wz3Gqo3u2+fpOPu1FOyYhcj3dKWgkAxfJDsDKuwZNY0joG75A
	 rBTgDKukyBGGUuHL+3Ovp6mMZfZPkIcHX5XJ1xSvufXw2D0H4e5loGVh2jO/5smgSZ
	 i/bTsMJQoElogrwXXNzVrmkUZQC2SnLXegTPbRsg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Neha Malcom Francis <n-francis@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 252/374] regulator: tps6594-regulator: Correct multi-phase configuration
Date: Thu,  6 Jun 2024 16:03:51 +0200
Message-ID: <20240606131700.278736440@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Neha Malcom Francis <n-francis@ti.com>

[ Upstream commit 74b38cd77d3eb63c6d0ad9cf2ae59812ae54d3ee ]

According to the TPS6594 PMIC Manual (linked) 8.3.2.1.4 Multi-Phase BUCK
Regulator Configurations section, the PMIC ignores all the other bucks'
except the primary buck's regulator registers. This is BUCK1 for
configurations BUCK12, BUCK123 and BUCK1234 while it is BUCK3 for
BUCK34. Correct the registers mapped for these configurations
accordingly.

Fixes: f17ccc5deb4d ("regulator: tps6594-regulator: Add driver for TI TPS6594 regulators")
Link: https://www.ti.com/lit/gpn/tps6594-q1
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
Link: https://msgid.link/r/20240521094758.2190331-1-n-francis@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/tps6594-regulator.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/tps6594-regulator.c b/drivers/regulator/tps6594-regulator.c
index b7f0c87797577..5fad61785e72f 100644
--- a/drivers/regulator/tps6594-regulator.c
+++ b/drivers/regulator/tps6594-regulator.c
@@ -287,30 +287,30 @@ static struct tps6594_regulator_irq_type *tps6594_ldos_irq_types[] = {
 static const struct regulator_desc multi_regs[] = {
 	TPS6594_REGULATOR("BUCK12", "buck12", TPS6594_BUCK_1,
 			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS6594_MASK_BUCKS_VSET,
-			  TPS6594_REG_BUCKX_VOUT_1(1),
+			  TPS6594_REG_BUCKX_VOUT_1(0),
 			  TPS6594_MASK_BUCKS_VSET,
-			  TPS6594_REG_BUCKX_CTRL(1),
+			  TPS6594_REG_BUCKX_CTRL(0),
 			  TPS6594_BIT_BUCK_EN, 0, 0, bucks_ranges,
 			  4, 4000, 0, NULL, 0, 0),
 	TPS6594_REGULATOR("BUCK34", "buck34", TPS6594_BUCK_3,
 			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS6594_MASK_BUCKS_VSET,
-			  TPS6594_REG_BUCKX_VOUT_1(3),
+			  TPS6594_REG_BUCKX_VOUT_1(2),
 			  TPS6594_MASK_BUCKS_VSET,
-			  TPS6594_REG_BUCKX_CTRL(3),
+			  TPS6594_REG_BUCKX_CTRL(2),
 			  TPS6594_BIT_BUCK_EN, 0, 0, bucks_ranges,
 			  4, 0, 0, NULL, 0, 0),
 	TPS6594_REGULATOR("BUCK123", "buck123", TPS6594_BUCK_1,
 			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS6594_MASK_BUCKS_VSET,
-			  TPS6594_REG_BUCKX_VOUT_1(1),
+			  TPS6594_REG_BUCKX_VOUT_1(0),
 			  TPS6594_MASK_BUCKS_VSET,
-			  TPS6594_REG_BUCKX_CTRL(1),
+			  TPS6594_REG_BUCKX_CTRL(0),
 			  TPS6594_BIT_BUCK_EN, 0, 0, bucks_ranges,
 			  4, 4000, 0, NULL, 0, 0),
 	TPS6594_REGULATOR("BUCK1234", "buck1234", TPS6594_BUCK_1,
 			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS6594_MASK_BUCKS_VSET,
-			  TPS6594_REG_BUCKX_VOUT_1(1),
+			  TPS6594_REG_BUCKX_VOUT_1(0),
 			  TPS6594_MASK_BUCKS_VSET,
-			  TPS6594_REG_BUCKX_CTRL(1),
+			  TPS6594_REG_BUCKX_CTRL(0),
 			  TPS6594_BIT_BUCK_EN, 0, 0, bucks_ranges,
 			  4, 4000, 0, NULL, 0, 0),
 };
-- 
2.43.0




