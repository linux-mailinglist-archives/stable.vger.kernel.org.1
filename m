Return-Path: <stable+bounces-80101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE1998DBD3
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC85C1C23CDA
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66E81D07B0;
	Wed,  2 Oct 2024 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gixfT8Pu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A0D1D0438;
	Wed,  2 Oct 2024 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879387; cv=none; b=lzcI4vv/AFdFs0PZHYzrbTsDcp+MdE7MoiCTdPIlAQ+VNJ7ZJUP8MEIu7cD0vmp6zSENsIpufBTVMaY6YyHSf47vfTz89bAcAHWpC19i5b2f0J3VMlm0xdNHMoTA1Gc6qqkuf5vGaktEoVYKvJ/ETtyptEzZaN1D61hYETnJKEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879387; c=relaxed/simple;
	bh=kan7scXuJgH5oey2u31V/zvzx+lHBxkUkFntGhAyBXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6DMuRMFSQR4ZOyaVt1q8FOkIxysw993ozLQSxHAD8t1tpJx0T+dYSHQw4QGgz1+Eyja/5LWwpt5WU7fZHWEhrABkEvUMn5B72FtKDi+fpkfq1yjT8pF/R/pnwEkblB5xKdZwtUWBBtwPrdCdyqFj8xZLKs429bpGyc1WMPeMpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gixfT8Pu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F201C4CEC2;
	Wed,  2 Oct 2024 14:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727879387;
	bh=kan7scXuJgH5oey2u31V/zvzx+lHBxkUkFntGhAyBXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gixfT8PuJl9mUiJooz0aAxmJ5k+qePpXNf666ZHAMDfr3aonXr9+iMCcjBCcTT34m
	 hGA4N7XADFB3rh9Ph1sXEbqFUY9V9aT7kEWLsQxY/tTNjvqHNljP2qgYeqK4RQumck
	 gKsDL+McWx7nP/8YRp1OhI+MqykeLqHN+Q4eYGWI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	William Zhang <william.zhang@broadcom.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 102/538] spi: bcmbca-hsspi: Fix missing pm_runtime_disable()
Date: Wed,  2 Oct 2024 14:55:41 +0200
Message-ID: <20241002125756.258497607@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

[ Upstream commit 4439a2e92cb89028b22c5d7ba1b99e75d7d889f6 ]

The pm_runtime_disable() is missing in remove function, use
devm_pm_runtime_enable() to fix it. So the pm_runtime_disable() in
the probe error path can also be removed.

Fixes: a38a2233f23b ("spi: bcmbca-hsspi: Add driver for newer HSSPI controller")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: William Zhang <william.zhang@broadcom.com>
Link: https://patch.msgid.link/20240826124903.3429235-2-ruanjinjie@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-bcmbca-hsspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcmbca-hsspi.c b/drivers/spi/spi-bcmbca-hsspi.c
index 9f64afd8164ea..4965bc86d7f52 100644
--- a/drivers/spi/spi-bcmbca-hsspi.c
+++ b/drivers/spi/spi-bcmbca-hsspi.c
@@ -546,12 +546,14 @@ static int bcmbca_hsspi_probe(struct platform_device *pdev)
 			goto out_put_host;
 	}
 
-	pm_runtime_enable(&pdev->dev);
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		goto out_put_host;
 
 	ret = sysfs_create_group(&pdev->dev.kobj, &bcmbca_hsspi_group);
 	if (ret) {
 		dev_err(&pdev->dev, "couldn't register sysfs group\n");
-		goto out_pm_disable;
+		goto out_put_host;
 	}
 
 	/* register and we are done */
@@ -565,8 +567,6 @@ static int bcmbca_hsspi_probe(struct platform_device *pdev)
 
 out_sysgroup_disable:
 	sysfs_remove_group(&pdev->dev.kobj, &bcmbca_hsspi_group);
-out_pm_disable:
-	pm_runtime_disable(&pdev->dev);
 out_put_host:
 	spi_controller_put(host);
 out_disable_pll_clk:
-- 
2.43.0




