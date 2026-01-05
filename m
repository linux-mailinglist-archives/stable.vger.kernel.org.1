Return-Path: <stable+bounces-204615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB64CF2C56
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 10:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B748C3002D21
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 09:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D39332C94A;
	Mon,  5 Jan 2026 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ttHQpzq6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78BD2E173D
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767605375; cv=none; b=I6Znk5LkKeYhszvI4bGmC5AZOhAcjuzRVN3AXvYMFYuMnMODFMZ0Za39qUD4EBBoRqXqgczB4RdtcZWqEyp3vz6UeCHbxymnFxwBkqr7ekK7Y8Oi3hkui4y5aKlk0ZX8cszy5Mv3XJwqpVhEcH6n7oEojhpX6fo1VKbu1q2g/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767605375; c=relaxed/simple;
	bh=JFm17OVdpYTAg/M75ko1ge6FpLKebCbd/z/tgkbq1SI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZgsXktg+B1U+e7XoshipdAQ4vLmxe6cNcF8XNJEPaMwwjSFQ+jqfuNprOrm/rkp5ULun17mDLcP++AYruItcVBG4pWr8jIbuXCemCuqA8STI8y51LyoMuwxeLqBF4IhznJJGlGdZeKdWqILYjjWkQ55xFhACzK0oI3pJItja0SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ttHQpzq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3121CC116D0;
	Mon,  5 Jan 2026 09:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767605374;
	bh=JFm17OVdpYTAg/M75ko1ge6FpLKebCbd/z/tgkbq1SI=;
	h=Subject:To:Cc:From:Date:From;
	b=ttHQpzq6xfKllm0wKYPzqGpSw/XvZOJBh2fG2OgQTzOFiEh1k4VFshR3ClvrSwsp6
	 wxSypuolEEmpSiCmt7y50oSxiXLQLk8HEJaHdbc84h3aDKonjVgkoYYSWTWT+kJ1qi
	 unkmqB5lKrIiDHBBpyIJfKD4CeWCNjyyIQ2UyFfo=
Subject: FAILED: patch "[PATCH] iommu/qcom: fix device leak on of_xlate()" failed to apply to 5.15-stable tree
To: johan@kernel.org,joerg.roedel@amd.com,robin.clark@oss.qualcomm.com,robin.murphy@arm.com,yukuai3@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 10:29:20 +0100
Message-ID: <2026010520-snowdrop-judgingly-e0c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6a3908ce56e6879920b44ef136252b2f0c954194
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010520-snowdrop-judgingly-e0c4@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6a3908ce56e6879920b44ef136252b2f0c954194 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 20 Oct 2025 06:53:06 +0200
Subject: [PATCH] iommu/qcom: fix device leak on of_xlate()

Make sure to drop the reference taken to the iommu platform device when
looking up its driver data during of_xlate().

Note that commit e2eae09939a8 ("iommu/qcom: add missing put_device()
call in qcom_iommu_of_xlate()") fixed the leak in a couple of error
paths, but the reference is still leaking on success and late failures.

Fixes: 0ae349a0f33f ("iommu/qcom: Add qcom_iommu")
Cc: stable@vger.kernel.org	# 4.14: e2eae09939a8
Cc: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 9222a4a48bb3..f69d9276dc55 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -566,14 +566,14 @@ static int qcom_iommu_of_xlate(struct device *dev,
 
 	qcom_iommu = platform_get_drvdata(iommu_pdev);
 
+	put_device(&iommu_pdev->dev);
+
 	/* make sure the asid specified in dt is valid, so we don't have
 	 * to sanity check this elsewhere:
 	 */
 	if (WARN_ON(asid > qcom_iommu->max_asid) ||
-	    WARN_ON(qcom_iommu->ctxs[asid] == NULL)) {
-		put_device(&iommu_pdev->dev);
+	    WARN_ON(qcom_iommu->ctxs[asid] == NULL))
 		return -EINVAL;
-	}
 
 	if (!dev_iommu_priv_get(dev)) {
 		dev_iommu_priv_set(dev, qcom_iommu);
@@ -582,10 +582,8 @@ static int qcom_iommu_of_xlate(struct device *dev,
 		 * multiple different iommu devices.  Multiple context
 		 * banks are ok, but multiple devices are not:
 		 */
-		if (WARN_ON(qcom_iommu != dev_iommu_priv_get(dev))) {
-			put_device(&iommu_pdev->dev);
+		if (WARN_ON(qcom_iommu != dev_iommu_priv_get(dev)))
 			return -EINVAL;
-		}
 	}
 
 	return iommu_fwspec_add_ids(dev, &asid, 1);


