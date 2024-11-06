Return-Path: <stable+bounces-90981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3929BEBEA
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA3E28210A
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638471F9EC6;
	Wed,  6 Nov 2024 12:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xMgVRSkj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD661EE012;
	Wed,  6 Nov 2024 12:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897388; cv=none; b=XXPWnN7ZwQh5uB8znBfDkDqwOPDpFP1GXVWJ4103ae/opuVY98wATRkHlEkyK5YtAFuduHegUQomlGscmxnypOCz1rhgxysBYDa01f4AaurxpyzRE81Hvx0MurwqcOD2AaGpHPHGYJUxCEQWuqQ/hAvLRNzR4lPqvRU1OXfVgGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897388; c=relaxed/simple;
	bh=yY4ouc97f81XdlYfAXArOLHHCcOcG9OAdDGWYTt5fr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odBEVKg5E8QpTIl6udBbRpIJSUKPlB0l0MwpHeXB9Ws+TmOxAgO8ddOUj1oZSztS7BzLlCYthXPwkCZYk1YqLwjqU8VfrC/GxrCbxZQIEKKcXKEsjc4crsiltypj06PBQ+OGtE1IU4Kc75hyQqOTTmKfOX6vgqrj/j3e9qyqxJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xMgVRSkj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911B9C4CECD;
	Wed,  6 Nov 2024 12:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897388;
	bh=yY4ouc97f81XdlYfAXArOLHHCcOcG9OAdDGWYTt5fr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xMgVRSkjPFE006ZL576JXaTGy8WR7rpLRSEp+spwYJY8MY3rQOheyX/dJh3BZhgjP
	 UeTP3IOEelgHNyX+UmoJGprLaJ570n528n7yvWeoGqyneOeRkD0AYqlW3tEyUWXhD0
	 l+5JeGU5XELnurAmFdxF7p/TuGddiEqSGNs1Nok0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 007/151] spi: geni-qcom: Fix boot warning related to pm_runtime and devres
Date: Wed,  6 Nov 2024 13:03:15 +0100
Message-ID: <20241106120309.041658117@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120308.841299741@linuxfoundation.org>
References: <20241106120308.841299741@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Georgi Djakov <djakov@kernel.org>

[ Upstream commit d0ccf760a405d243a49485be0a43bd5b66ed17e2 ]

During boot, users sometimes observe the following warning:

[7.841431] WARNING: CPU: 4 PID: 492 at
drivers/interconnect/core.c:685 __icc_enable
(drivers/interconnect/core.c:685 (discriminator 7))
[..]
[7.841541] Call trace:
[7.841542] __icc_enable (drivers/interconnect/core.c:685 (discriminator 7))
[7.841545] icc_disable (drivers/interconnect/core.c:708)
[7.841547] geni_icc_disable (drivers/soc/qcom/qcom-geni-se.c:862)
[7.841553] spi_geni_runtime_suspend+0x3c/0x4c spi_geni_qcom

This occurs when the spi-geni driver receives an -EPROBE_DEFER error
from spi_geni_grab_gpi_chan(), causing devres to start releasing all
resources as shown below:

[7.138679] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_icc_release (8 bytes)
[7.138751] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_icc_release (8 bytes)
[7.138827] geni_spi 880000.spi: DEVRES REL ffff800081443800 pm_runtime_disable_action (16 bytes)
[7.139494] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_pm_opp_config_release (16 bytes)
[7.139512] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_spi_release_controller (8 bytes)
[7.139516] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_clk_release (16 bytes)
[7.139519] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_ioremap_release (8 bytes)
[7.139524] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_region_release (24 bytes)
[7.139527] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_kzalloc_release (22 bytes)
[7.139530] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_pinctrl_release (8 bytes)
[7.139539] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_kzalloc_release (40 bytes)

The issue here is that pm_runtime_disable_action() results in a call to
spi_geni_runtime_suspend(), which attempts to suspend the device and
disable an interconnect path that devm_icc_release() has just released.

Resolve this by calling geni_icc_get() before enabling runtime PM. This
approach ensures that when devres releases resources in reverse order,
it will start with pm_runtime_disable_action(), suspending the device,
and then proceed to free the remaining resources.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/r/CA+G9fYtsjFtddG8i+k-SpV8U6okL0p4zpsTiwGfNH5GUA8dWAA@mail.gmail.com
Fixes: 89e362c883c6 ("spi: geni-qcom: Undo runtime PM changes at driver exit time")
Signed-off-by: Georgi Djakov <djakov@kernel.org>
Link: https://patch.msgid.link/20241008231615.430073-1-djakov@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-geni-qcom.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 7401ed3b9acd4..6a3b41dbfa701 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1108,6 +1108,11 @@ static int spi_geni_probe(struct platform_device *pdev)
 	init_completion(&mas->tx_reset_done);
 	init_completion(&mas->rx_reset_done);
 	spin_lock_init(&mas->lock);
+
+	ret = geni_icc_get(&mas->se, NULL);
+	if (ret)
+		return ret;
+
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 250);
 	ret = devm_pm_runtime_enable(dev);
@@ -1117,9 +1122,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (device_property_read_bool(&pdev->dev, "spi-slave"))
 		spi->slave = true;
 
-	ret = geni_icc_get(&mas->se, NULL);
-	if (ret)
-		return ret;
 	/* Set the bus quota to a reasonable value for register access */
 	mas->se.icc_paths[GENI_TO_CORE].avg_bw = Bps_to_icc(CORE_2X_50_MHZ);
 	mas->se.icc_paths[CPU_TO_GENI].avg_bw = GENI_DEFAULT_BW;
-- 
2.43.0




