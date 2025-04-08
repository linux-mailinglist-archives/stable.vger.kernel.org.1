Return-Path: <stable+bounces-128930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC17A7FC75
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DDB43B5A12
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6036D267AFC;
	Tue,  8 Apr 2025 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dXHsQEkD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20496206F18
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108590; cv=none; b=rwVmAhCOCj3CkDWvw3f6dXRmUEuy2YkFyTWJnUTCLItz+G84uHjl8DCJrCkHd4tStdlxB59NlJfE+ZbKR63Nc+c00QHNefLGvbNyA4xKNgW8bxj2r0+aiTKT5eII182nphnxTXApq9Dnj2AwvWTNnS/gcxWtPvbz6srHmOKeq1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108590; c=relaxed/simple;
	bh=i0wKzWyfeGx6BaPlz6qNL/Yuog9K1Vh3fF7eW1I3CZU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=W8F82+LlB+uFr2khdRZVtq4NaiOFyc3xUCO1DbL0Jc4/xChFfu0bS9x1Udqw/YjJQQ7nwqzARzvqdMcjE1y5mBbZKxc4gxro/avor3/qrzCztoRUoD2lREUV8VBXbrocCxwLTS4sUpG5xez2Qybs7PuotB9sI87l+tByTLt3bEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dXHsQEkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B600C4CEE5;
	Tue,  8 Apr 2025 10:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744108589;
	bh=i0wKzWyfeGx6BaPlz6qNL/Yuog9K1Vh3fF7eW1I3CZU=;
	h=Subject:To:Cc:From:Date:From;
	b=dXHsQEkDdjoHGz8ZbWOMABD/wtWueuYenaD4nT25oA3AuHZFGrRgTjWOhKtlUJ+th
	 xWsGUATlKQrnltiQnZh8EE2cXnDWusWKqZy6ciB5Q9GbMrh0zBabeFmZo1l5/yg1jp
	 rZmZWEe0/q3BUVWXe1r4qeiJ32/Snoyfdo+mxaQI=
Subject: FAILED: patch "[PATCH] mmc: sdhci-msm: fix dev reference leaked through" failed to apply to 6.13-stable tree
To: tudor.ambarus@linaro.org,abel.vesa@linaro.org,andersson@kernel.org,krzysztof.kozlowski@linaro.org,manivannan.sadhasivam@linaro.org,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Apr 2025 12:34:46 +0200
Message-ID: <2025040846-elude-harpist-dd96@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.13-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.13.y
git checkout FETCH_HEAD
git cherry-pick -x cbef7442fba510b7eb229dcc9f39d3dde4a159a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040846-elude-harpist-dd96@gregkh' --subject-prefix 'PATCH 6.13.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cbef7442fba510b7eb229dcc9f39d3dde4a159a4 Mon Sep 17 00:00:00 2001
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 17 Jan 2025 14:18:51 +0000
Subject: [PATCH] mmc: sdhci-msm: fix dev reference leaked through
 of_qcom_ice_get

The driver leaks the device reference taken with
of_find_device_by_node(). Fix the leak by using devm_of_qcom_ice_get().

Fixes: c7eed31e235c ("mmc: sdhci-msm: Switch to the new ICE API")
Cc: stable@vger.kernel.org
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20250117-qcom-ice-fix-dev-leak-v2-2-1ffa5b6884cb@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index e3d39311fdc7..3fd898647237 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1873,7 +1873,7 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
 	if (!(cqhci_readl(cq_host, CQHCI_CAP) & CQHCI_CAP_CS))
 		return 0;
 
-	ice = of_qcom_ice_get(dev);
+	ice = devm_of_qcom_ice_get(dev);
 	if (ice == ERR_PTR(-EOPNOTSUPP)) {
 		dev_warn(dev, "Disabling inline encryption support\n");
 		ice = NULL;


