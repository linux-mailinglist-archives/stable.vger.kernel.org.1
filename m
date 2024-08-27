Return-Path: <stable+bounces-71332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0462896152D
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 19:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9031F244C4
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B899C1CC163;
	Tue, 27 Aug 2024 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Of1t6hNS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B443AD9
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778694; cv=none; b=PM3MtdEisKJU3TIQr0pCPPQeeoUCvhzlqJpyC/Dv652LYC3bHFp4iVNLgNzlRphw37ZzbBqoUqjfcvGfqs6uYGl/x2YPg0OffERv/gAI0/Qiec8hyZh1wCo5SJZodIovJ3e8w0l+mCMWlKHAPLN+x6Z6lgO3dicblVxmq2uTGTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778694; c=relaxed/simple;
	bh=hwcAKO0iibtPZF8CUiwMzKWCtbx88883ElUrEobeEmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n9PIYEq9wvKKRsST4NnsczDpmZA5knOxVRhwJIVQOHV1zfWsMn3BY0FSnC29ajRFGKdIAY1tjII4Lq8W4hw0kIlk1nNruso+WKMrqZb2ejIZGlRtW5E8w6NAweJ8z1wszreKzMmnZywFB8wHD1LPfd+hppDB0vE97RcwlUppiSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Of1t6hNS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so4006121b3a.1
        for <stable@vger.kernel.org>; Tue, 27 Aug 2024 10:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724778692; x=1725383492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IK8SEiBum8hunhZQDt0oY44SDt3A4Q0KuG3fIX/3rsg=;
        b=Of1t6hNSG0JezN0kQH2cnusk5uhZ9eINfXkUlumjAonj3wcwYdFPSBYT20sng14oqS
         7/N2SqseLaBuDf/de1OSfRGfBBzVRLIJFsyVdkpxHqZ1EgsE9wGt0c8kUTP24qi9asvl
         GqFt6BrTrS7bxoe5OqmI5bzIvkPQ6AYmeTtgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724778692; x=1725383492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IK8SEiBum8hunhZQDt0oY44SDt3A4Q0KuG3fIX/3rsg=;
        b=Ii06Ez0T2cMPVLu7J4PJwfMmy4SM0Ts5cvO+T2A0yTVHfsTYiBZgumjRpD4WFxwV7o
         tX3y47QMTAU3xZ1QfaGaIHtj9z9k8W3kV8RfiXYaT1UendOsTIaR40oMK0jj5dfjmsjz
         WajoyKfhXRcpKV+MLn3XSkb0Uf8x548F8ziiK6do2TdSoTibFQCTkN+sWJ9RTAJCW7Fx
         7kSxhejpg1lYOVBTl4nEwhfOn/PMfCp8owNUQLVUmo9jvNbIvxP8fHgNyEfpicFNPE0c
         pM10JBIJpJe9Xwsqr4fqtZZYnNjnuSbZvPWVMLwEUhIhrOnI3GEYiVg09qPEzAgolvko
         OTdg==
X-Forwarded-Encrypted: i=1; AJvYcCVTmgrmGI8Dsx64+CChd0EB+RnTKz1Eavh1LFhA0zygQlME+HDfERtgQ2UXiifprgFyYZetEwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDSJDP95E8CzaGoP3p9FK9p6Kn0UyztPxfZDKNhZWXhOEingQF
	rIw8e31i9rc5IGc0+Fhw6nEkf9Rb7mnauDu/I9pVdwn6jXsmAC2xX2viCDN9VIU05KVH1W5qJSw
	=
X-Google-Smtp-Source: AGHT+IG4YPDdFUYtuMPkwkokpmaThrJJFJG1W58Oml09/8xPYFTHvK1DWSTRwqLa9pqAVl8Dy0b24w==
X-Received: by 2002:a05:6a00:918b:b0:70d:2b95:d9cd with SMTP id d2e1a72fcca58-714457d35c7mr14736149b3a.16.1724778692187;
        Tue, 27 Aug 2024 10:11:32 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:9f27:3f59:914a:3d90])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71434330425sm8813341b3a.190.2024.08.27.10.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 10:11:31 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Jon Lin <jon.lin@rock-chips.com>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Brian Norris <briannorris@chromium.org>,
	stable@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-spi@vger.kernel.org,
	shengfei Xu <xsf@rock-chips.com>
Subject: [PATCH v3] spi: rockchip: Resolve unbalanced runtime PM / system PM handling
Date: Tue, 27 Aug 2024 10:11:16 -0700
Message-ID: <20240827171126.1115748-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit e882575efc77 ("spi: rockchip: Suspend and resume the bus during
NOIRQ_SYSTEM_SLEEP_PM ops") stopped respecting runtime PM status and
simply disabled clocks unconditionally when suspending the system. This
causes problems when the device is already runtime suspended when we go
to sleep -- in which case we double-disable clocks and produce a
WARNing.

Switch back to pm_runtime_force_{suspend,resume}(), because that still
seems like the right thing to do, and the aforementioned commit makes no
explanation why it stopped using it.

Also, refactor some of the resume() error handling, because it's not
actually a good idea to re-disable clocks on failure.

Fixes: e882575efc77 ("spi: rockchip: Suspend and resume the bus during NOIRQ_SYSTEM_SLEEP_PM ops")
Cc: <stable@vger.kernel.org>
Reported-by: "Ondřej Jirman" <megi@xff.cz>
Closes: https://lore.kernel.org/lkml/20220621154218.sau54jeij4bunf56@core/
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v3:
 - actually CC the appropriate lists (sorry, I accidentally dropped them
   on v2)

Changes in v2:
 - fix unused 'rs' warning

 drivers/spi/spi-rockchip.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index e1ecd96c7858..0bb33c43b1b4 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -945,14 +945,16 @@ static int rockchip_spi_suspend(struct device *dev)
 {
 	int ret;
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
-	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 
 	ret = spi_controller_suspend(ctlr);
 	if (ret < 0)
 		return ret;
 
-	clk_disable_unprepare(rs->spiclk);
-	clk_disable_unprepare(rs->apb_pclk);
+	ret = pm_runtime_force_suspend(dev);
+	if (ret < 0) {
+		spi_controller_resume(ctlr);
+		return ret;
+	}
 
 	pinctrl_pm_select_sleep_state(dev);
 
@@ -963,25 +965,14 @@ static int rockchip_spi_resume(struct device *dev)
 {
 	int ret;
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
-	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 
 	pinctrl_pm_select_default_state(dev);
 
-	ret = clk_prepare_enable(rs->apb_pclk);
+	ret = pm_runtime_force_resume(dev);
 	if (ret < 0)
 		return ret;
 
-	ret = clk_prepare_enable(rs->spiclk);
-	if (ret < 0)
-		clk_disable_unprepare(rs->apb_pclk);
-
-	ret = spi_controller_resume(ctlr);
-	if (ret < 0) {
-		clk_disable_unprepare(rs->spiclk);
-		clk_disable_unprepare(rs->apb_pclk);
-	}
-
-	return 0;
+	return spi_controller_resume(ctlr);
 }
 #endif /* CONFIG_PM_SLEEP */
 
-- 
2.46.0.295.g3b9ea8a38a-goog


