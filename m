Return-Path: <stable+bounces-103401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3839EF6A2
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF29828AA78
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27832210F8;
	Thu, 12 Dec 2024 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KQz0PHiD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810912210DE;
	Thu, 12 Dec 2024 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024457; cv=none; b=IbKPMv5Y3QjqqI3R2Bj7KKbSKrZM8btjdhu4KV5Tg+/9BxMEiQmEYunHvlWHuNjMFuWWGBqOh4qnf6SfbN/klHlCjfKlcvHzGvPEgI8JfHwPyzTxMMi1WCxjOKgKUMNJU4V4wAgF3wLmRGiX8LVofAdMXZJMVNUGvH1LmStwzOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024457; c=relaxed/simple;
	bh=z/cngDTvq2jGBgnioKmbjmtCGgR+TjvDJEvaSbTAv+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rm8buX/rvCBnxJ6c+EkuwLgy+tZsJ91Uq1LznvgxtJW349jW6NX2As0Awz/Ct9+5U/LKQ/+fnNHF4zxxTvp7PvSYxItRe1QoZrHdKLw5CFtsax97VyNfGa9EJRgKLtUMspX/Uy4IqdMxXg723ttBslutJIW9FENelv/Rztlr58g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KQz0PHiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03505C4CED0;
	Thu, 12 Dec 2024 17:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734024457;
	bh=z/cngDTvq2jGBgnioKmbjmtCGgR+TjvDJEvaSbTAv+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQz0PHiDOrKm87IUeUVKI5WXrALSrEr6GBV2mSRsNnR5r8CENoaPwxsrObnUbU07U
	 JHmjtScjWUJFQyQevjctt3q3/yObXqjwm6geBL73h9AmqJHUwt1w4+kQfRWU50SczB
	 z2QRJ0m0V/OUfv8lEVLLn+ZqUFWBxNECJK9kmC+Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 302/459] rtc: ab-eoz9: dont fail temperature reads on undervoltage notification
Date: Thu, 12 Dec 2024 16:00:40 +0100
Message-ID: <20241212144305.576049879@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index d690985caa4cf..1d6a626fdf933 100644
--- a/drivers/rtc/rtc-ab-eoz9.c
+++ b/drivers/rtc/rtc-ab-eoz9.c
@@ -281,13 +281,6 @@ static int abeoz9z3_temp_read(struct device *dev,
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




