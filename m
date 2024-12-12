Return-Path: <stable+bounces-102899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B109EF3F9
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E4729061D
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35398217656;
	Thu, 12 Dec 2024 17:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="078qm2Ap"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47B053365;
	Thu, 12 Dec 2024 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022914; cv=none; b=DuaCH6tO4aefJDyb1e+AEfPgMXvXbrd/Kmo4UlZlL5B+lL1Udl56YbCP8nOIQOgY6ZcZFkdv3tvOF7l1kY3warFW9sNVWyMyYhKQgVM0oGghASTJF2XxrTqdl8a0BjLTh4lFDx9YnZG7N/SQ6H2RLX6HSD7lEoTK50U0YKxHq/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022914; c=relaxed/simple;
	bh=e1S9d50QnzFBRG+OuiPy43poZ7vU+3Y6A1SgQt9y2ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnSS6dB1PfAvxBrIv0KT8kmpqPjWl+cnQaEu1NPF0hY/hix8vf4moXejraYZ8ID2ZoNRlvlkFAswqsw5dzGo+98NLAVV42FI57D+r8EBKB/MG953PalQSfp16lp+nF4lXQtANg8pT4iBVICKD8W6aHMWGRPg9A6y8Leo4jnb9XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=078qm2Ap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CD9C4CED0;
	Thu, 12 Dec 2024 17:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734022913;
	bh=e1S9d50QnzFBRG+OuiPy43poZ7vU+3Y6A1SgQt9y2ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=078qm2ApcZLhp06zLHk0jpGdtqm9OyH/HQwYtf8gFR6l6IvMlK67yy10dhXacUu1b
	 HHzodODCKnhbi57f4PmEAVTW0D9t+Pm5ETVK78FWh7zwWNYhvLX0CCSXWFwX1dDr02
	 CrXjWsmqFiSaHTtxtLuJ0U04BjrKGmuRnC7TsEqQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 368/565] rtc: ab-eoz9: dont fail temperature reads on undervoltage notification
Date: Thu, 12 Dec 2024 15:59:23 +0100
Message-ID: <20241212144326.171309632@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maxime Chevallier <maxime.chevallier@bootlin.com>

[ Upstream commit e0779a0dcf41a6452ac0a169cd96863feb5787c7 ]

The undervoltage flags reported by the RTC are useful to know if the
time and date are reliable after a reboot. Although the threshold VLOW1
indicates that the thermometer has been shutdown and time compensation
is off, it doesn't mean that the temperature readout is currently
impossible.

As the system is running, the RTC voltage is now fully established and
we can read the temperature.

Fixes: 67075b63cce2 ("rtc: add AB-RTCMC-32.768kHz-EOZ9 RTC support")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Link: https://lore.kernel.org/r/20241122101031.68916-3-maxime.chevallier@bootlin.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-ab-eoz9.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/rtc/rtc-ab-eoz9.c b/drivers/rtc/rtc-ab-eoz9.c
index a9b355510cd47..31c264100d781 100644
--- a/drivers/rtc/rtc-ab-eoz9.c
+++ b/drivers/rtc/rtc-ab-eoz9.c
@@ -396,13 +396,6 @@ static int abeoz9z3_temp_read(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	if ((val & ABEOZ9_REG_CTRL_STATUS_V1F) ||
-	    (val & ABEOZ9_REG_CTRL_STATUS_V2F)) {
-		dev_err(dev,
-			"thermometer might be disabled due to low voltage\n");
-		return -EINVAL;
-	}
-
 	switch (attr) {
 	case hwmon_temp_input:
 		ret = regmap_read(regmap, ABEOZ9_REG_REG_TEMP, &val);
-- 
2.43.0




