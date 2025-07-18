Return-Path: <stable+bounces-163374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2473AB0A5E0
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 16:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3B25A58EE
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 14:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E11127BF7D;
	Fri, 18 Jul 2025 14:10:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFC914F9D6
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 14:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752847843; cv=none; b=gzGXzDRoGWjI+mA1ltpktmyQmUJhx0t2kK+U1FAR6fl8EMsQKUlJHcTwcXofcLL/LxmK4eke7kBre5tDI6nC3X3lNpv3GrEpPxdsMU6DuX1Egpo0z6uBpX4ioKE1qLb5ss6nOCpSz9lDymliWCPP3J/d+7CEeXSUFMOw02uo6gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752847843; c=relaxed/simple;
	bh=wNgzlIWihJQ2SJYAupAvk8MFgzMcNV/iicnmur3+yvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uvDIcLL7mlaSnBbQb9zxg1XSKcm98uNqoFT4jAfm9tdWM5dxDAVnQDYcJtp6oF9WYxShZJN7/2Ocq2bXvJoSAKkfpCD7YPWkK2X4tXn0/8QZF5wFGPDn9QxeH2BhxEcwGVjt1ueawJKyzrH5dWyKJgniuAOwNuWLJk72mC3Ugok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.214.181])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1c823aba4;
	Fri, 18 Jul 2025 22:10:36 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Mark Brown <broonie@kernel.org>,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 6.6.y 1/2] regulator: pwm-regulator: Calculate the output voltage for disabled PWMs
Date: Fri, 18 Jul 2025 22:10:15 +0800
Message-Id: <20250718141016.312952-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250718141016.312952-1-amadeus@jmu.edu.cn>
References: <20250718141016.312952-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a981ddf672103a2kunmb1387368da89
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDT0kfVk4eSklPHhhPGR4eTFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKT1VKQ0pZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0tVSktLVU
	tZBg++

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 6a7d11efd6915d80a025f2a0be4ae09d797b91ec ]

If a PWM output is disabled then it's voltage has to be calculated
based on a zero duty cycle (for normal polarity) or duty cycle being
equal to the PWM period (for inverted polarity). Add support for this
to pwm_regulator_get_voltage().

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Link: https://msgid.link/r/20240113224628.377993-3-martin.blumenstingl@googlemail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 drivers/regulator/pwm-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 226ca4c62673..d27b9a7a30c9 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -157,6 +157,13 @@ static int pwm_regulator_get_voltage(struct regulator_dev *rdev)
 
 	pwm_get_state(drvdata->pwm, &pstate);
 
+	if (!pstate.enabled) {
+		if (pstate.polarity == PWM_POLARITY_INVERSED)
+			pstate.duty_cycle = pstate.period;
+		else
+			pstate.duty_cycle = 0;
+	}
+
 	voltage = pwm_get_relative_duty_cycle(&pstate, duty_unit);
 	if (voltage < min(max_uV_duty, min_uV_duty) ||
 	    voltage > max(max_uV_duty, min_uV_duty))
-- 
2.25.1


