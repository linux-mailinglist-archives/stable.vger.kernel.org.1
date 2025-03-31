Return-Path: <stable+bounces-127071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 277C7A76820
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 16:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF51316ABE3
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D627C21B9FC;
	Mon, 31 Mar 2025 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMIIJ3s4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9009C21B199;
	Mon, 31 Mar 2025 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431673; cv=none; b=aTiZXibPJpr15BUpPBXW93J7MkQZMa4M5KkqQwuhkgaka4gVI3VUiV9UBzm0fktBT/mPdp4ET4oS+hj9wXiNKQL0U/wGrjriIzQ3FQsb9Jw3vLrWo0k+JLwbOjl35ZXuIgnb80+DONkhJSmJe0ydA7n6DMbonulVg4aWPJqf3Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431673; c=relaxed/simple;
	bh=pC02LxYEhOQX0acsiBSpSAp+XyktTgRqcV1taCsvBIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OyUXGWkJCGk8jiu+4hzz4JS6Gl/Ec/g1K7bNzFsB8O0rPJTJ5iIleGqWUVITOdVZtMDNqssGPrKJjOqpNIuaoJ3EUFEfTkwrumwsZB+RGho+twEufsbImySnoh7KSnegUXZUcqFg8unn3QbcOLqYd+q8ueoudYipS0gRViZFUDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMIIJ3s4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BD4C4CEE3;
	Mon, 31 Mar 2025 14:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431673;
	bh=pC02LxYEhOQX0acsiBSpSAp+XyktTgRqcV1taCsvBIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YMIIJ3s4V8cDnjbW441hLoEMOlUMf4VTyr7gNpt8PkbjyaCDCiPkAZyh//c7Mq/y/
	 lgMoBrGmFL9hNZm1qjeWJ8982Imu+KxeM7/B6lQqnV8zQb5XhU/1GrGHma67D7r1ou
	 zAIO8N7pKW38xZM5xnytXWjaAsPqLsEx/SU9ID9HHBfYgxwRNtrRuO8amWCIEnM+ci
	 ZgQtpWNTESAgz9KU46Zmrh0is9qre9Wkqt0ys3TlF79dvZhWwXiW0QH3y4xg+fvpuF
	 qtglZ7lvlykP855GEuUONbJZLG5guml1NJNJWRbeCuyHSqsWYeRHTvP91ByTsWAF2f
	 Yhpn9p2IxcRpQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	renyu.zj@linux.alibaba.com,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 09/18] perf/dwc_pcie: fix some unreleased resources
Date: Mon, 31 Mar 2025 10:33:59 -0400
Message-Id: <20250331143409.1682789-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143409.1682789-1-sashal@kernel.org>
References: <20250331143409.1682789-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Yunhui Cui <cuiyunhui@bytedance.com>

[ Upstream commit 6eb1e8ef586ac4a3dcdc20248f9cb45e4ceb141f ]

Release leaked resources, such as plat_dev and dev_info.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Link: https://lore.kernel.org/r/20250220121716.50324-2-cuiyunhui@bytedance.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/dwc_pcie_pmu.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index cccecae9823f6..19fa2ba8dd670 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -572,8 +572,10 @@ static int dwc_pcie_register_dev(struct pci_dev *pdev)
 		return PTR_ERR(plat_dev);
 
 	dev_info = kzalloc(sizeof(*dev_info), GFP_KERNEL);
-	if (!dev_info)
+	if (!dev_info) {
+		platform_device_unregister(plat_dev);
 		return -ENOMEM;
+	}
 
 	/* Cache platform device to handle pci device hotplug */
 	dev_info->plat_dev = plat_dev;
@@ -730,6 +732,15 @@ static struct platform_driver dwc_pcie_pmu_driver = {
 	.driver = {.name = "dwc_pcie_pmu",},
 };
 
+static void dwc_pcie_cleanup_devices(void)
+{
+	struct dwc_pcie_dev_info *dev_info, *tmp;
+
+	list_for_each_entry_safe(dev_info, tmp, &dwc_pcie_dev_info_head, dev_node) {
+		dwc_pcie_unregister_dev(dev_info);
+	}
+}
+
 static int __init dwc_pcie_pmu_init(void)
 {
 	struct pci_dev *pdev = NULL;
@@ -742,7 +753,7 @@ static int __init dwc_pcie_pmu_init(void)
 		ret = dwc_pcie_register_dev(pdev);
 		if (ret) {
 			pci_dev_put(pdev);
-			return ret;
+			goto err_cleanup;
 		}
 	}
 
@@ -751,35 +762,35 @@ static int __init dwc_pcie_pmu_init(void)
 				      dwc_pcie_pmu_online_cpu,
 				      dwc_pcie_pmu_offline_cpu);
 	if (ret < 0)
-		return ret;
+		goto err_cleanup;
 
 	dwc_pcie_pmu_hp_state = ret;
 
 	ret = platform_driver_register(&dwc_pcie_pmu_driver);
 	if (ret)
-		goto platform_driver_register_err;
+		goto err_remove_cpuhp;
 
 	ret = bus_register_notifier(&pci_bus_type, &dwc_pcie_pmu_nb);
 	if (ret)
-		goto platform_driver_register_err;
+		goto err_unregister_driver;
 	notify = true;
 
 	return 0;
 
-platform_driver_register_err:
+err_unregister_driver:
+	platform_driver_unregister(&dwc_pcie_pmu_driver);
+err_remove_cpuhp:
 	cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
-
+err_cleanup:
+	dwc_pcie_cleanup_devices();
 	return ret;
 }
 
 static void __exit dwc_pcie_pmu_exit(void)
 {
-	struct dwc_pcie_dev_info *dev_info, *tmp;
-
 	if (notify)
 		bus_unregister_notifier(&pci_bus_type, &dwc_pcie_pmu_nb);
-	list_for_each_entry_safe(dev_info, tmp, &dwc_pcie_dev_info_head, dev_node)
-		dwc_pcie_unregister_dev(dev_info);
+	dwc_pcie_cleanup_devices();
 	platform_driver_unregister(&dwc_pcie_pmu_driver);
 	cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
 }
-- 
2.39.5


