Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0013703572
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243274AbjEOQ7K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243316AbjEOQ7I (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:59:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AFB7A98
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:59:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D534262A3E
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDCFC4339B;
        Mon, 15 May 2023 16:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169946;
        bh=6bc4r8hhPwLpn7u/K2gooVQoh0VagQRG8DT/taaWISk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CQSiTcrhUFHIZ3MwZAnRCP6FqQi6flPJzBPBm6qXnM2mRTFKs0pO2N1DEmRqfWbfW
         IqOrUlyt7ln0NdhB1mErLRi0dB2x6CfHVUsTXO4ZYKip4DctHWFsEziSOjsZ/f4ujF
         fUgTTCWAljF31bKyAX0ubYM8dLKqZpVQtC6rOL7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Rob Clark <robdclark@chromium.org>
Subject: [PATCH 6.3 214/246] drm/msm/adreno: adreno_gpu: Use suspend() instead of idle() on load error
Date:   Mon, 15 May 2023 18:27:06 +0200
Message-Id: <20230515161729.016719126@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

commit 3eeca5e5f3100435b06a5b5d86daa3d135a8a4bd upstream.

The adreno_load_gpu() path is guarded by an error check on
adreno_load_fw(). This function is responsible for loading
Qualcomm-only-signed binaries (e.g. SQE and GMU FW for A6XX), but it
does not take the vendor-signed ZAP blob into account.

By embedding the SQE (and GMU, if necessary) firmware into the
initrd/kernel, we can trigger and unfortunate path that would not bail
out early and proceed with gpu->hw_init(). That will fail, as the ZAP
loader path will not find the firmware and return back to
adreno_load_gpu().

This error path involves pm_runtime_put_sync() which then calls idle()
instead of suspend(). This is suboptimal, as it means that we're not
going through the clean shutdown sequence. With at least A619_holi, this
makes the GPU not wake up until it goes through at least one more
start-fail-stop cycle. The pm_runtime_put_sync that appears in the error
path actually does not guarantee that because of the earlier enabling of
runtime autosuspend.

Fix that by using pm_runtime_put_sync_suspend to force a clean shutdown.

Test cases:
1. All firmware baked into kernel
2. error loading ZAP fw in initrd -> load from rootfs at DE start

Both succeed on A619_holi (SM6375) and A630 (SDM845).

Fixes: 0d997f95b70f ("drm/msm/adreno: fix runtime PM imbalance at gpu load")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Patchwork: https://patchwork.freedesktop.org/patch/530001/
Link: https://lore.kernel.org/r/20230330231517.2747024-1-konrad.dybcio@linaro.org
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -465,7 +465,7 @@ struct msm_gpu *adreno_load_gpu(struct d
 	return gpu;
 
 err_put_rpm:
-	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_put_sync_suspend(&pdev->dev);
 err_disable_rpm:
 	pm_runtime_disable(&pdev->dev);
 


