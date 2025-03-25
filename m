Return-Path: <stable+bounces-125995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D2EA6EB42
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 09:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B29E1893B7E
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 08:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA60253F30;
	Tue, 25 Mar 2025 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VhGA1Kp0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xYNPSacZ"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EDE204F98;
	Tue, 25 Mar 2025 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742890498; cv=none; b=lVG2aZQzz0Vt6L144vJ4eRaXvYyem9CNotMMQuz80vIHt8cAejhiuAvnrr3p0rLu81TB3SghsTfamf4NF+3op9U3M0d42/mXPBPYE04VCNgHoutCrQRQtVaSrR8ZXbcht6/2SwyqaXCe7YtSGTJ4Na2215/EnM4bz4hk/8zWg6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742890498; c=relaxed/simple;
	bh=0gVC1ngQ0B8g7LoRgzCuFkYg0SFegqZE4RGZHlHtLfM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MxP6xsl1GWXpJ9FOWt2h8UMAN+NX81Y1zhCakHOXYpodeq36tJYlUJxRIuWqp3860ei2z0xGm7W0FgMpHSr6NNVPlH+N7EUIMNfmyVO8H7Np7k6tTCokBfQ1kaBLAs7jQcJe246PcXO6pdI94tsNFdVdihSnsvrMlb5qChFH55Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VhGA1Kp0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xYNPSacZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:14:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742890495;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a0TNc0IkAGMmWPF2TV9hNbx0P102q56/uvML1F8bx4Q=;
	b=VhGA1Kp0NDTCLRx4Lns3alMSyNIIncSXrNPTLxPk0rquf90uu0ACyNr8eTjHuURJ9j+wL+
	niqtaZsXUD3q4wDEvJr6nTl1r6YAFHg5GPnqI+GRns1R8olB4T+PGJNHA/2wy0Ag84buJn
	ZRc85CPi7pHPoThP6iphsMrxX7PArgn9GmuJnDDpRxP1YBpED03A/RWJkO8Tpd9ADfuKw4
	SclM5AoLcZdQ0zfAdupgDt89Co0zR3W1axMEwpl0kgLXvAQLQCSyF6WEBiIEgXxf70bRPr
	EKqKpfUN4HioE4skcob1H3KzULyL5kvxqVirJXWOA/JR4J3jdSQn8Igf1OPNPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742890495;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a0TNc0IkAGMmWPF2TV9hNbx0P102q56/uvML1F8bx4Q=;
	b=xYNPSacZLb7RGlXPnqiDykkZ6PmByf2t7+EqzkivtkAAOSNfr+L3f77BZZ/V2vt5sYoCIt
	1ZDZtwUduuzwdaAA==
From: "tip-bot2 for Alexandre Torgue" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/stm32-lptimer: Use
 wakeup capable instead of init wakeup
Cc: stable@vger.kernel.org, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250306102501.2980153-1-fabrice.gasnier@foss.st.com>
References: <20250306102501.2980153-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289049490.14745.17000851668929533315.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     96bf4b89a6ab22426ad83ef76e66c72a5a8daca0
Gitweb:        https://git.kernel.org/tip/96bf4b89a6ab22426ad83ef76e66c72a5a8daca0
Author:        Alexandre Torgue <alexandre.torgue@foss.st.com>
AuthorDate:    Thu, 06 Mar 2025 11:25:01 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 07 Mar 2025 17:55:59 +01:00

clocksource/drivers/stm32-lptimer: Use wakeup capable instead of init wakeup

"wakeup-source" property describes a device which has wakeup capability
but should not force this device as a wakeup source.

Fixes: 48b41c5e2de6 ("clocksource: Add Low Power STM32 timers driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Rule: add
Link: https://lore.kernel.org/stable/20250306083407.2374894-1-fabrice.gasnier%40foss.st.com
Link: https://lore.kernel.org/r/20250306102501.2980153-1-fabrice.gasnier@foss.st.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-stm32-lp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer-stm32-lp.c
index 9cd487d..928da2f 100644
--- a/drivers/clocksource/timer-stm32-lp.c
+++ b/drivers/clocksource/timer-stm32-lp.c
@@ -194,9 +194,7 @@ static int stm32_clkevent_lp_probe(struct platform_device *pdev)
 	}
 
 	if (of_property_read_bool(pdev->dev.parent->of_node, "wakeup-source")) {
-		ret = device_init_wakeup(&pdev->dev, true);
-		if (ret)
-			goto out_clk_disable;
+		device_set_wakeup_capable(&pdev->dev, true);
 
 		ret = dev_pm_set_wake_irq(&pdev->dev, irq);
 		if (ret)

