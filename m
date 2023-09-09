Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F80799B55
	for <lists+stable@lfdr.de>; Sat,  9 Sep 2023 23:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbjIIVSx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 9 Sep 2023 17:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjIIVSw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 9 Sep 2023 17:18:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786F0131
        for <stable@vger.kernel.org>; Sat,  9 Sep 2023 14:18:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1F7C433C7;
        Sat,  9 Sep 2023 21:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694294328;
        bh=dweleWf9bX0PA+1gYpVhWK/vOEz1+IUs3Sg4kq9kqzw=;
        h=Subject:To:Cc:From:Date:From;
        b=Q2M0YRrFt1dQZ+w5h9C17R9OfQWBGxDU3BaPjgPNX/xf0wojoTC5ThF7M7GXVoIpd
         YUoGLd6w3PxUUElgGmUFKvf9ap4T3+WcD9hUXkO/wxi9ol3BCbEE1ljVwlV8IfYT99
         CwAKsHO6Noa38G/ZxqdCTnICeo/c1/Kq/vbzj2oE=
Subject: FAILED: patch "[PATCH] media: venus: hfi_venus: Write to VIDC_CTRL_INIT after" failed to apply to 5.4-stable tree
To:     konrad.dybcio@linaro.org, hverkuil-cisco@xs4all.nl,
        stanimir.k.varbanov@gmail.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 09 Sep 2023 22:18:37 +0100
Message-ID: <2023090937-manila-baggy-02be@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x d74e481609808330b4625b3691cf01e1f56e255e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023090937-manila-baggy-02be@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

d74e48160980 ("media: venus: hfi_venus: Write to VIDC_CTRL_INIT after unmasking interrupts")
255385ca433c ("media: venus: hfi: Add a 6xx boot logic")
ff2a7013b3e6 ("media: venus: hfi,pm,firmware: Convert to block relative addressing")
7482a983dea3 ("media: venus: redesign clocks and pm domains control")
fd1ee315dcd4 ("media: venus: cache vb payload to be used by clock scaling")
219031a6e7df ("media: venus: fix build on 32bit environments")
c0e284ccfeda ("media: venus: Update clock scaling")
8dbebb2bd01e ("media: venus: Fix occasionally failures to suspend")
32f0a6ddc8c9 ("media: venus: Use on-chip interconnect API")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d74e481609808330b4625b3691cf01e1f56e255e Mon Sep 17 00:00:00 2001
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 30 May 2023 14:30:36 +0200
Subject: [PATCH] media: venus: hfi_venus: Write to VIDC_CTRL_INIT after
 unmasking interrupts

The startup procedure shouldn't be started with interrupts masked, as that
may entail silent failures.

Kick off initialization only after the interrupts are unmasked.

Cc: stable@vger.kernel.org # v4.12+
Fixes: d96d3f30c0f2 ("[media] media: venus: hfi: add Venus HFI files")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 918a283bd890..5506a0d196ef 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -453,7 +453,6 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
 	void __iomem *wrapper_base = hdev->core->wrapper_base;
 	int ret = 0;
 
-	writel(BIT(VIDC_CTRL_INIT_CTRL_SHIFT), cpu_cs_base + VIDC_CTRL_INIT);
 	if (IS_V6(hdev->core)) {
 		mask_val = readl(wrapper_base + WRAPPER_INTR_MASK);
 		mask_val &= ~(WRAPPER_INTR_MASK_A2HWD_BASK_V6 |
@@ -464,6 +463,7 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
 	writel(mask_val, wrapper_base + WRAPPER_INTR_MASK);
 	writel(1, cpu_cs_base + CPU_CS_SCIACMDARG3);
 
+	writel(BIT(VIDC_CTRL_INIT_CTRL_SHIFT), cpu_cs_base + VIDC_CTRL_INIT);
 	while (!ctrl_status && count < max_tries) {
 		ctrl_status = readl(cpu_cs_base + CPU_CS_SCIACMDARG0);
 		if ((ctrl_status & CPU_CS_SCIACMDARG0_ERROR_STATUS_MASK) == 4) {

