Return-Path: <stable+bounces-71331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A960961523
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 19:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E85FFB216C1
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE131CF2A4;
	Tue, 27 Aug 2024 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bA3NTZ7t"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F66C45025
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778602; cv=none; b=K/gh9NhPKu6SIEoAJ3BnmCe5b/PYGSLW0Ik1I5fFMl2S1ZabpH8/1pBT13gzH6LFjyejG1HMHPKj2EV5Ragz1ANxRk6z6zE5x7VWuDjcu9lng2nK2QuxO10KGeQ4clH52LXylW3hsMI74NF8aa/BA8BTNtjEfwc4DDO95xn6rTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778602; c=relaxed/simple;
	bh=fy5R6qAzuIdoU1PkjXfshuohI8xcw+3b4hj6IesDCm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lMzhkn2ni7OzNQ/1xC4uzTd5hUVpYH9f5q2cC2d2CZ1im278htHcGxPdv1AmCTv9WMk092ZpP5TVkvQbfGVd8h3NTKlTP9lm6AcjRp3dmS/9AVJ+K1jSLhy7t5r6FCki8xF0jllBsuqEBJ4XTa13Uh2t2+WoM/OZnzhQGkyURuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bA3NTZ7t; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7142448aaf9so3924310b3a.1
        for <stable@vger.kernel.org>; Tue, 27 Aug 2024 10:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724778600; x=1725383400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uv8IVcj6ZzCfOVmGQynDa+tROKhWXmjzh4zLKQiPRI4=;
        b=bA3NTZ7tRdpGtTZlaQKnGtgoR3EguTgYQiKIEYPEuCy7sNMP++hXgjSGhLrIZx0Rl5
         7jlU6nd25EfizpqHDdH9nNeSvc0YI82jFDT7pNs/DVeRAbKzvVYz5hCkI3O6ykWOy59d
         PphPMDR+22AJITtA8FNEmKRWdnf+br9vZQz0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724778600; x=1725383400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uv8IVcj6ZzCfOVmGQynDa+tROKhWXmjzh4zLKQiPRI4=;
        b=R5v1CijQ87WzceGI/QBTLi3NXJxQWItRRStsZwUyYPRZocyS3q8n9T/Ed772IxA5fg
         A/+p13B0fKEpDvN6U//ADAxxO0HRnSUYuCpCgmAeJAcvi/th8rHQ6HOIpIKG0hJkbCuc
         t4NKK2wSA1pQOub/7RtQT+4YfhkIsCbUnABO+G+6UoMg/wCAgkim+1hHHDSJvHkElet6
         196dHhLV0VjWsz8W7euPl4k1ryNS6CG6/QES/e8ekK2qDevPEUU5ZP4y1sbrvGg/uXxx
         aEYjpoJN3LuBvyp2QhEEFNNH5x3aN1Hk1W92TzaLuxov0hasWuKFU7OmCkLP08nlmGDz
         IlkA==
X-Forwarded-Encrypted: i=1; AJvYcCXF3cjyiMa/h6IiAFv7YU8V15aY40yzROBzJB8/sh3QyT+8hTQYPEZTERtwmX6+FCfV8GSQv/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgGTRZ7y+SyBCY1d+shwPZcoHOLqu5pJ9dj3czr+ccDSLbVzt8
	TELHFy1Mhc+vvFThvR6tn7mUAubr89j/my/z32VjoWPNnWxPfEdFzH1e4wD2qw==
X-Google-Smtp-Source: AGHT+IFdsHfi2o9Q3II/Ocfn7hl+vxY/+LySwFr6+sZDxvVoq02QrDw6DbbsWfXw32ZaowPeLtTThA==
X-Received: by 2002:a05:6a00:76b0:b0:712:7195:265d with SMTP id d2e1a72fcca58-715bfdc6b21mr4073224b3a.0.1724778599502;
        Tue, 27 Aug 2024 10:09:59 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:9f27:3f59:914a:3d90])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7cd9ac9827bsm8334172a12.1.2024.08.27.10.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 10:09:59 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Jon Lin <jon.lin@rock-chips.com>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Brian Norris <briannorris@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] spi: rockchip: Resolve unbalanced runtime PM / system PM handling
Date: Tue, 27 Aug 2024 10:09:30 -0700
Message-ID: <20240827170954.1113160-1-briannorris@chromium.org>
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


