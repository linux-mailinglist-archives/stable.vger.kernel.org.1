Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFDF75D4CF
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjGUTZQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjGUTZO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:25:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E379B30E2
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:25:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55BA661D94
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64615C433C7;
        Fri, 21 Jul 2023 19:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967503;
        bh=4tOuG2+v0VDp68fr0zvhnTUJ/doDxefsBRWyPd6DbWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jA7v7hdSKF19eDTE3Uob9nRROeCKfCK8bi4dAzaMWhZJeFRj+5awLdBNe2Cr4cqTr
         qcuv0YxbgWqFfr4+m22Ie5Zu2JslP45Z//yEe52HlFAsBI+iEDIVbjFGKc/96fuoZ/
         gbq82u9gLYwXjxNKFAGqV9W7Cz/O4RueUza//5KQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Evan Quan <evan.quan@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 186/223] drm/amd/pm: conditionally disable pcie lane/speed switching for SMU13
Date:   Fri, 21 Jul 2023 18:07:19 +0200
Message-ID: <20230721160528.813313377@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

commit 31c7a3b378a136adc63296a2ff17645896fcf303 upstream.

Intel platforms such as Sapphire Rapids and Raptor Lake don't support
dynamic pcie lane or speed switching.

This limitation seems to carry over from one generation to another.
To be safer, disable dynamic pcie lane width and speed switching when
running on an Intel platform.

Link: https://edc.intel.com/content/www/us/en/design/products/platforms/details/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/005/pci-express-support/
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2663
Co-developed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.1.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c |   42 +++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2490,6 +2490,25 @@ int smu_v13_0_mode1_reset(struct smu_con
 	return ret;
 }
 
+/*
+ * Intel hosts such as Raptor Lake and Sapphire Rapids don't support dynamic
+ * speed switching. Until we have confirmation from Intel that a specific host
+ * supports it, it's safer that we keep it disabled for all.
+ *
+ * https://edc.intel.com/content/www/us/en/design/products/platforms/details/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/005/pci-express-support/
+ * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
+ */
+static bool smu_v13_0_is_pcie_dynamic_switching_supported(void)
+{
+#if IS_ENABLED(CONFIG_X86)
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
+	if (c->x86_vendor == X86_VENDOR_INTEL)
+		return false;
+#endif
+	return true;
+}
+
 int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
 				     uint32_t pcie_gen_cap,
 				     uint32_t pcie_width_cap)
@@ -2497,15 +2516,32 @@ int smu_v13_0_update_pcie_parameters(str
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct smu_13_0_pcie_table *pcie_table =
 				&dpm_context->dpm_tables.pcie_table;
+	int num_of_levels = pcie_table->num_of_link_levels;
 	uint32_t smu_pcie_arg;
 	int ret, i;
 
-	for (i = 0; i < pcie_table->num_of_link_levels; i++) {
-		if (pcie_table->pcie_gen[i] > pcie_gen_cap)
+	if (!smu_v13_0_is_pcie_dynamic_switching_supported()) {
+		if (pcie_table->pcie_gen[num_of_levels - 1] < pcie_gen_cap)
+			pcie_gen_cap = pcie_table->pcie_gen[num_of_levels - 1];
+
+		if (pcie_table->pcie_lane[num_of_levels - 1] < pcie_width_cap)
+			pcie_width_cap = pcie_table->pcie_lane[num_of_levels - 1];
+
+		/* Force all levels to use the same settings */
+		for (i = 0; i < num_of_levels; i++) {
 			pcie_table->pcie_gen[i] = pcie_gen_cap;
-		if (pcie_table->pcie_lane[i] > pcie_width_cap)
 			pcie_table->pcie_lane[i] = pcie_width_cap;
+		}
+	} else {
+		for (i = 0; i < num_of_levels; i++) {
+			if (pcie_table->pcie_gen[i] > pcie_gen_cap)
+				pcie_table->pcie_gen[i] = pcie_gen_cap;
+			if (pcie_table->pcie_lane[i] > pcie_width_cap)
+				pcie_table->pcie_lane[i] = pcie_width_cap;
+		}
+	}
 
+	for (i = 0; i < num_of_levels; i++) {
 		smu_pcie_arg = i << 16;
 		smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
 		smu_pcie_arg |= pcie_table->pcie_lane[i];


