Return-Path: <stable+bounces-15301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98D983857A
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6C91B292C4
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C161374E03;
	Tue, 23 Jan 2024 02:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HgnQfRmF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816FB745D6;
	Tue, 23 Jan 2024 02:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975463; cv=none; b=MQ8UkrGtycolHTXYewTf0Hnis/+TEcCkM2atgioIcN6XUrO1LzO1nm2NUIR61TcvTcIz2SedAENea/11Ovqqrk1UBA9dKDY41z4+Mu1c9f/Ng5nwwMrL/hZbzML+sQCyoYp1tHo8MDG+HHgfvaNK/LXTyL3ctCpdPr5lnpmgUdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975463; c=relaxed/simple;
	bh=ZXW7R36bJFm2satXuvZA6BBVyTUTbObN6/8cIh1XPg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVq7fdsjDo9+C3SeV4/yQ+5oMdR9+MeBNXwSOmPZ/jbvAD5xWw/q3VEyp1FZJRX5SYEArp6rSmaP47H9rJ7Dcn0nSDXyTs12+vGo0kl1WZ+BtMGW9KfPWS23044Sysqus8VYWgW3NqHmOeOcNP2d2S8LxbPW8a/DWmuQ/wLL84A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HgnQfRmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C29C433C7;
	Tue, 23 Jan 2024 02:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975463;
	bh=ZXW7R36bJFm2satXuvZA6BBVyTUTbObN6/8cIh1XPg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HgnQfRmFUtcT7+zEIKkJZSvoGA1AhNok5jfEq7MyBvAE51sUeNxDoKCq55/bj6Xt8
	 H4fy8qtgt4opWHYv4aJ49Yh1T8bLwCNmjs6xWq6Kv938D5Cr0R2oDizFc9UNbsvIdp
	 QzynG27LnqpdxYphVYmpOO8tjel/NoqHoHRlEQzw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rob Clark <robdclark@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 6.6 411/583] iommu/arm-smmu-qcom: Add missing GMU entry to match table
Date: Mon, 22 Jan 2024 15:57:42 -0800
Message-ID: <20240122235824.545952731@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

From: Rob Clark <robdclark@chromium.org>

commit afc95681c3068956fed1241a1ff1612c066c75ac upstream.

In some cases the firmware expects cbndx 1 to be assigned to the GMU,
so we also want the default domain for the GMU to be an identy domain.
This way it does not get a context bank assigned.  Without this, both
of_dma_configure() and drm/msm's iommu_domain_attach() will trigger
allocating and configuring a context bank.  So GMU ends up attached to
both cbndx 1 and later cbndx 2.  This arrangement seemingly confounds
and surprises the firmware if the GPU later triggers a translation
fault, resulting (on sc8280xp / lenovo x13s, at least) in the SMMU
getting wedged and the GPU stuck without memory access.

Cc: stable@vger.kernel.org
Signed-off-by: Rob Clark <robdclark@chromium.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/20231210180655.75542-1-robdclark@gmail.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -243,6 +243,7 @@ static int qcom_adreno_smmu_init_context
 
 static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,adreno" },
+	{ .compatible = "qcom,adreno-gmu" },
 	{ .compatible = "qcom,mdp4" },
 	{ .compatible = "qcom,mdss" },
 	{ .compatible = "qcom,sc7180-mdss" },



