Return-Path: <stable+bounces-126702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390A2A7161C
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 12:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23B63B11CF
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 11:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7171DDC0D;
	Wed, 26 Mar 2025 11:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndkGu+Uh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA85919CC27;
	Wed, 26 Mar 2025 11:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742990102; cv=none; b=t0LQJNRZTQNPSdiZxPmAaBzk0T5mRyY974IGskth0pOFARs2rlB3TQQdSjbkk8KykQhIYU2cJjJiz/J/Zxf0LCzCC3BZTNyLFqDHIYNnVf1NqwLK5WJKoHfNrtUZ1Tfo5uT7Ipi2T66u6SawJh1gbJwsJvb4LQ7LHqslTZ7Q3/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742990102; c=relaxed/simple;
	bh=7nZSOUrqLzDdrR1+oyL60zfjyk6PKbWIuEV1UY/Jj24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PIVsXkbICdFKZfI/1jIWPSDcsMNIOTotAD0G1E2EvqSHsGfi7utrtH8ojUe7ZzyeNv/6rFdPQudYvD6USb/abMlyDxxZFa1U2AjMr8Sh0et9BCAgrlXmJQedMWzuPblm64J4k3byqoiviyTLHDo93V0iDMB7fVJ/VuTkAACJlLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndkGu+Uh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EABC4CEE2;
	Wed, 26 Mar 2025 11:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742990102;
	bh=7nZSOUrqLzDdrR1+oyL60zfjyk6PKbWIuEV1UY/Jj24=;
	h=From:To:Cc:Subject:Date:From;
	b=ndkGu+UhiFVEp/SCOtgYHKJl+rPEDkEn0b3Ms8O3z/mOcz9gnMdEbtl6caGkTJLL0
	 072q/oZ5KjLTQ2OqCXavaHikOzITJSd5BNZeSHcQ/ojeEMFYcYZ8eSi7PgqGCEwVvT
	 6J1RaTId8UHk30Bl8kap7/+2GQqKFTW32Tl4SB5ll7Cs14dMXLiMEFQaiktfoO4GQ/
	 r9KydgTLS/zO0qVIzJNuEuCWqmpeQkTQUNxAmoyili+AXzZlK/La4XmWa42+NikZem
	 HLe+c5PFx9F1jqUppzbdSJCvLVperVRIJFgVOZIbKFyKDK4y1Tq26QL/a6DkusBtdM
	 vn9HCw+a3WYsQ==
From: Dinh Nguyen <dinguyen@kernel.org>
To: gregkh@linuxfoundation.org
Cc: dinguyen@kernel.org,
	linux-kernel@vger.kernel.org,
	Mahesh Rao <mahesh.rao@intel.com>,
	stable@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH] firmware: stratix10-svc: Add of_platform_default_populate()
Date: Wed, 26 Mar 2025 06:54:46 -0500
Message-ID: <20250326115446.36123-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mahesh Rao <mahesh.rao@intel.com>

Add of_platform_default_populate() to stratix10-svc
driver as the firmware/svc node was moved out of soc.
This fixes the failed probing of child drivers of
svc node.

Cc: stable@vger.kernel.org
Fixes: 23c3ebed382a ("arm64: dts: socfpga: agilex: move firmware out of soc node")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Mahesh Rao <mahesh.rao@intel.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/firmware/stratix10-svc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 3c52cb73237a..e3f990d888d7 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1224,22 +1224,28 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	if (!svc->intel_svc_fcs) {
 		dev_err(dev, "failed to allocate %s device\n", INTEL_FCS);
 		ret = -ENOMEM;
-		goto err_unregister_dev;
+		goto err_unregister_rsu_dev;
 	}
 
 	ret = platform_device_add(svc->intel_svc_fcs);
 	if (ret) {
 		platform_device_put(svc->intel_svc_fcs);
-		goto err_unregister_dev;
+		goto err_unregister_rsu_dev;
 	}
 
+	ret = of_platform_default_populate(dev_of_node(dev), NULL, dev);
+	if (ret)
+		goto err_unregister_fcs_dev;
+
 	dev_set_drvdata(dev, svc);
 
 	pr_info("Intel Service Layer Driver Initialized\n");
 
 	return 0;
 
-err_unregister_dev:
+err_unregister_fcs_dev:
+	platform_device_unregister(svc->intel_svc_fcs);
+err_unregister_rsu_dev:
 	platform_device_unregister(svc->stratix10_svc_rsu);
 err_free_kfifo:
 	kfifo_free(&controller->svc_fifo);
@@ -1253,6 +1259,8 @@ static void stratix10_svc_drv_remove(struct platform_device *pdev)
 	struct stratix10_svc *svc = dev_get_drvdata(&pdev->dev);
 	struct stratix10_svc_controller *ctrl = platform_get_drvdata(pdev);
 
+	of_platform_depopulate(ctrl->dev);
+
 	platform_device_unregister(svc->intel_svc_fcs);
 	platform_device_unregister(svc->stratix10_svc_rsu);
 
-- 
2.42.0.411.g813d9a9188


