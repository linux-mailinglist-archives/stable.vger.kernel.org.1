Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF51870CA16
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbjEVTzO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbjEVTyr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:54:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F55B7
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:54:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8511B61EDE
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EE2C433D2;
        Mon, 22 May 2023 19:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785284;
        bh=DaCZ2HVeQLtrgWMCB9lcS1+0OuyNAwP5R7TvfKVzG4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aXAoTWXaSe0BBoB9USypbah6SeKSPjqu4DGSfAKQNEqsrdNbvCTJAGtdANmkVCVc/
         PoP7dYI5OoeFZ12yt5WVF0EcoOy6UjYBn15Rk043nbdfegcaynobbPZcUUy6juucY2
         sx2vGAQ6h3Zspuxj3BQeeLSALyaf72KAZo77shhc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lepton Wu <lepton@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 6.3 343/364] iommu/arm-smmu-qcom: Fix missing adreno_smmus
Date:   Mon, 22 May 2023 20:10:48 +0100
Message-Id: <20230522190421.369625012@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

commit e36ca2fad6bb4ef0603bdb5556578e9082fe0056 upstream.

When the special handling of qcom,adreno-smmu was moved into
qcom_smmu_create(), it was overlooked that we didn't have all the
required entries in qcom_smmu_impl_of_match.  So we stopped getting
adreno_smmu_priv on sc7180, breaking per-process pgtables.

Fixes: 30b912a03d91 ("iommu/arm-smmu-qcom: Move the qcom,adreno-smmu check into qcom_smmu_create")
Cc: <stable@vger.kernel.org>
Suggested-by: Lepton Wu <lepton@chromium.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/537357/
Link: https://lore.kernel.org/r/20230516222039.907690-1-robdclark@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -517,6 +517,7 @@ static const struct of_device_id __maybe
 	{ .compatible = "qcom,qcm2290-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,qdu1000-smmu-500", .data = &qcom_smmu_500_impl0_data  },
 	{ .compatible = "qcom,sc7180-smmu-500", .data = &qcom_smmu_500_impl0_data },
+	{ .compatible = "qcom,sc7180-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,sc7280-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sc8180x-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sc8280xp-smmu-500", .data = &qcom_smmu_500_impl0_data },
@@ -561,5 +562,14 @@ struct arm_smmu_device *qcom_smmu_impl_i
 	if (match)
 		return qcom_smmu_create(smmu, match->data);
 
+	/*
+	 * If you hit this WARN_ON() you are missing an entry in the
+	 * qcom_smmu_impl_of_match[] table, and GPU per-process page-
+	 * tables will be broken.
+	 */
+	WARN(of_device_is_compatible(np, "qcom,adreno-smmu"),
+	     "Missing qcom_smmu_impl_of_match entry for: %s",
+	     dev_name(smmu->dev));
+
 	return smmu;
 }


