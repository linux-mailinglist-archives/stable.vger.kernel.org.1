Return-Path: <stable+bounces-70072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 304FB95D89D
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 23:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FEB11C21986
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 21:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFE71C8247;
	Fri, 23 Aug 2024 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KJQmm6eV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC49F1C8229
	for <stable@vger.kernel.org>; Fri, 23 Aug 2024 21:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724449365; cv=none; b=Irt/NXe6y74lDunpeejC4VpUqW9jM7G0U8LPcXFanziKTNheeuCMVX7uj7JFIH1FM6pUl+sR5uEld28iSQbKCZNkw5f7WMy1trxu5hUKxpW86Lnu4UcogNT2mvzjj50emvSDKr5UAkGzWWuBj8AE3+w0n6myhpzeFhDw37s8S4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724449365; c=relaxed/simple;
	bh=XSXJzOwEhN3LBd9q7srfwXbleUbDiNHKgOWgEYrFn0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WTYSL0K6WIEKplUatF4DTzyg9dz+mUrIIGRe001K0+8nEb+cAidnttqdLH5IEwfYrESAI9ic/zPpx+UE0iZawVURaLMyftSV1aJ0AnN3vOQp0hpI3Pv/vutFqpNXPlJtzZtVQNUb/QRPtPx8dgdSq/dQdwryM4iMqFa0daRTFBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KJQmm6eV; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20230059241so21716485ad.3
        for <stable@vger.kernel.org>; Fri, 23 Aug 2024 14:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724449363; x=1725054163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AjvArJdA06PbNXPgnOry3Qq7eKu1y9KpKSsxjlMv9Wc=;
        b=KJQmm6eVhwVEQZ8DNVvsahDCtoCCXSaAKsahqI3S/FiBwuDAEMF/4x7Q5ACmNUF4g/
         gCbNNyEB6VS9ixV6LMexTg7UtYDX5YWpdTfBXIccYPUs8uqPB9Jse1BUQ0bLRdRGZfNQ
         rdJRE/bxShPiJHia4hsDRkd1ZP80pJ3oTdOuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724449363; x=1725054163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AjvArJdA06PbNXPgnOry3Qq7eKu1y9KpKSsxjlMv9Wc=;
        b=b1gMwkJf9kLSdzdzQwWV3Tuk2Zt4U+YKkRjBII7WifgqwaYUCtKNHKBvulwJxIRfpL
         DQXJkCeRpCIeRG3XobwekGtSyRX57eP2dk+eGiE2Vp4/GZgVc6h9Jpn20Zcgc4xlGYSS
         RYS9RJi+10xBdp/6f8l5CWTlKEdKKdwRAyb5UEeBDWJFTqxu5WHX12fItmZbrnv5PKmj
         lktHHC4K0JOj7rL/7GDV3JJN++OzHY0FMYYCAdJkK6llx6FNOBu1k2aUkDLbyfLB7a61
         PZj36NP+ehliIJZG3bVYhrtY0C6DbZ8xJ+Jss32v3Io+KJT4gL85dO4yR97c9qw7XH0s
         Tkog==
X-Forwarded-Encrypted: i=1; AJvYcCV5ApOWp0T8LPqZavLNFqL131BPItaqQXWaufbmNufnLNXTn68pncrn2Isr0zqf7Xl+Nido97k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvMW8unPV557kjftxggMOaKNPqc0vW9M48QN5HJZ9N/xaINeUl
	SiRNqiLIiStBovVo+1ZyMBswOwtUOURX7f9gU2pW31PjK0tb1ZH//c8fqSsy3Q==
X-Google-Smtp-Source: AGHT+IGx6tc8HURRUBmfNKOOVhPbKyAJLPo58Lxm+iRK79rRI6Fo2cVzD+Gs5a92IWu63jXL+kWA/Q==
X-Received: by 2002:a17:903:22c1:b0:1fb:7c7f:6458 with SMTP id d9443c01a7336-2039e4b4bcemr38350745ad.32.1724449363238;
        Fri, 23 Aug 2024 14:42:43 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:9d43:7af7:9970:8219])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2038560975csm32500335ad.194.2024.08.23.14.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 14:42:42 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Brian Norris <briannorris@chromium.org>,
	stable@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Jon Lin <jon.lin@rock-chips.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-spi@vger.kernel.org,
	shengfei Xu <xsf@rock-chips.com>
Subject: [PATCH] spi: rockchip: Resolve unbalanced runtime PM / system PM handling
Date: Fri, 23 Aug 2024 14:41:56 -0700
Message-ID: <20240823214235.1718769-1-briannorris@chromium.org>
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

 drivers/spi/spi-rockchip.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index e1ecd96c7858..f30af4316b8b 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -951,8 +951,11 @@ static int rockchip_spi_suspend(struct device *dev)
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
 
@@ -967,21 +970,11 @@ static int rockchip_spi_resume(struct device *dev)
 
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


