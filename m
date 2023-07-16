Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A28F75530C
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjGPUOr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjGPUOq (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:14:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA50790
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:14:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 478B160E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522E8C433C8;
        Sun, 16 Jul 2023 20:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538484;
        bh=P8qIvRFxnCuSjZvFfT4JztNTT7qADds5h/jc7dFQxJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NOlG+8uTnbtlHZ6oVHDPoQrvCeGFYHv1CEuJ10yfTor+248MD1+wHydkr90YTGkUx
         yOejGYaVxxKnqgjkiUlCR1rHmCdk7YgC7vsk7BhVdx/3fIqPrezM9qYkoZ8B0Rzrg5
         9lNGOvCDiPj6pW4kXXbfK9Ca2UQEbpARpYgJ8mY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "David E. Box" <david.e.box@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 468/800] platform/x86/intel/pmc: Add resume callback
Date:   Sun, 16 Jul 2023 21:45:21 +0200
Message-ID: <20230716194959.951731125@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: David E. Box <david.e.box@linux.intel.com>

[ Upstream commit 801e5dc9853fcc36164c502456078145d72b23c5 ]

Add a resume callback to perform platform specific functions during resume
from suspend.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Link: https://lore.kernel.org/r/20230607233849.239047-1-david.e.box@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Stable-dep-of: f2b689ab2f8c ("platform/x86/intel/pmc/mtl: Put devices in D3 during resume")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/pmc/core.c | 14 ++++++++++++--
 drivers/platform/x86/intel/pmc/core.h |  3 +++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index b8711330e4112..ed91ef9d1cf6c 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1222,11 +1222,11 @@ static inline bool pmc_core_is_s0ix_failed(struct pmc_dev *pmcdev)
 	return false;
 }
 
-static __maybe_unused int pmc_core_resume(struct device *dev)
+int pmc_core_resume_common(struct pmc_dev *pmcdev)
 {
-	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
 	const struct pmc_bit_map **maps = pmcdev->map->lpm_sts;
 	int offset = pmcdev->map->lpm_status_offset;
+	struct device *dev = &pmcdev->pdev->dev;
 
 	/* Check if the syspend used S0ix */
 	if (pm_suspend_via_firmware())
@@ -1256,6 +1256,16 @@ static __maybe_unused int pmc_core_resume(struct device *dev)
 	return 0;
 }
 
+static __maybe_unused int pmc_core_resume(struct device *dev)
+{
+	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
+
+	if (pmcdev->resume)
+		return pmcdev->resume(pmcdev);
+
+	return pmc_core_resume_common(pmcdev);
+}
+
 static const struct dev_pm_ops pmc_core_pm_ops = {
 	SET_LATE_SYSTEM_SLEEP_PM_OPS(pmc_core_suspend, pmc_core_resume)
 };
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 9ca9b97467193..7c95586e742be 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -327,6 +327,7 @@ struct pmc_reg_map {
  * @lpm_en_modes:	Array of enabled modes from lowest to highest priority
  * @lpm_req_regs:	List of substate requirements
  * @core_configure:	Function pointer to configure the platform
+ * @resume:		Function to perform platform specific resume
  *
  * pmc_dev contains info about power management controller device.
  */
@@ -345,6 +346,7 @@ struct pmc_dev {
 	int lpm_en_modes[LPM_MAX_NUM_MODES];
 	u32 *lpm_req_regs;
 	void (*core_configure)(struct pmc_dev *pmcdev);
+	int (*resume)(struct pmc_dev *pmcdev);
 };
 
 extern const struct pmc_bit_map msr_map[];
@@ -398,6 +400,7 @@ extern const struct pmc_reg_map mtl_reg_map;
 extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
 extern int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
 
+int pmc_core_resume_common(struct pmc_dev *pmcdev);
 void spt_core_init(struct pmc_dev *pmcdev);
 void cnp_core_init(struct pmc_dev *pmcdev);
 void icl_core_init(struct pmc_dev *pmcdev);
-- 
2.39.2



