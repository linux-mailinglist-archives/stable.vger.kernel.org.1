Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F5676AEDE
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjHAJmm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbjHAJma (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:42:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F12F4EF2
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:40:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17046614FB
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F37C433CB;
        Tue,  1 Aug 2023 09:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882804;
        bh=EdVpqbV+MFVc8PQATiW28CqnSQ/Bl5/e2todtO+2CeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rUaQuBu41UErZiDWBh8sAKZsyGun3MvJpQ0WBovbaKHXUyyYWToxdb+cOOmxbvEWU
         jvbmSterNRSCriqLsQg7zrYJHp2GiwbqyoY9P4XEiDzPuueo6M0ZrH6Ajhtb/TOexG
         Aw8uNfXGFqwH6BaEnD9wsNzLHXQnUm71nqTaDVLE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Patil Rajesh Reddy <Patil.Reddy@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6.4 001/239] platform/x86/amd/pmf: Notify OS power slider update
Date:   Tue,  1 Aug 2023 11:17:45 +0200
Message-ID: <20230801091925.714061931@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

commit 33c9ab5b493a0e922b06c12fed4fdcb862212cda upstream.

APMF fn8 can notify EC about the OS slider position change. Add this
capability to the PMF driver so that it can call the APMF fn8 based on
the changes in the Platform profile events.

Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Patil Rajesh Reddy <Patil.Reddy@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Link: https://lore.kernel.org/r/20230714144435.1239776-2-Shyam-sundar.S-k@amd.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/amd/pmf/acpi.c |   21 ++++++++++
 drivers/platform/x86/amd/pmf/core.c |    9 +++-
 drivers/platform/x86/amd/pmf/pmf.h  |   16 +++++++
 drivers/platform/x86/amd/pmf/sps.c  |   74 ++++++++++++++++++++++++++++++++++--
 4 files changed, 114 insertions(+), 6 deletions(-)

--- a/drivers/platform/x86/amd/pmf/acpi.c
+++ b/drivers/platform/x86/amd/pmf/acpi.c
@@ -106,6 +106,27 @@ int apmf_get_static_slider_granular(stru
 									 data, sizeof(*data));
 }
 
+int apmf_os_power_slider_update(struct amd_pmf_dev *pdev, u8 event)
+{
+	struct os_power_slider args;
+	struct acpi_buffer params;
+	union acpi_object *info;
+	int err = 0;
+
+	args.size = sizeof(args);
+	args.slider_event = event;
+
+	params.length = sizeof(args);
+	params.pointer = (void *)&args;
+
+	info = apmf_if_call(pdev, APMF_FUNC_OS_POWER_SLIDER_UPDATE, &params);
+	if (!info)
+		err = -EIO;
+
+	kfree(info);
+	return err;
+}
+
 static void apmf_sbios_heartbeat_notify(struct work_struct *work)
 {
 	struct amd_pmf_dev *dev = container_of(work, struct amd_pmf_dev, heart_beat.work);
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -71,7 +71,11 @@ static int amd_pmf_pwr_src_notify_call(s
 			return NOTIFY_DONE;
 	}
 
-	amd_pmf_set_sps_power_limits(pmf);
+	if (is_apmf_func_supported(pmf, APMF_FUNC_STATIC_SLIDER_GRANULAR))
+		amd_pmf_set_sps_power_limits(pmf);
+
+	if (is_apmf_func_supported(pmf, APMF_FUNC_OS_POWER_SLIDER_UPDATE))
+		amd_pmf_power_slider_update_event(pmf);
 
 	return NOTIFY_OK;
 }
@@ -295,7 +299,8 @@ static void amd_pmf_init_features(struct
 	int ret;
 
 	/* Enable Static Slider */
-	if (is_apmf_func_supported(dev, APMF_FUNC_STATIC_SLIDER_GRANULAR)) {
+	if (is_apmf_func_supported(dev, APMF_FUNC_STATIC_SLIDER_GRANULAR) ||
+	    is_apmf_func_supported(dev, APMF_FUNC_OS_POWER_SLIDER_UPDATE)) {
 		amd_pmf_init_sps(dev);
 		dev->pwr_src_notifier.notifier_call = amd_pmf_pwr_src_notify_call;
 		power_supply_reg_notifier(&dev->pwr_src_notifier);
--- a/drivers/platform/x86/amd/pmf/pmf.h
+++ b/drivers/platform/x86/amd/pmf/pmf.h
@@ -21,6 +21,7 @@
 #define APMF_FUNC_SBIOS_HEARTBEAT			4
 #define APMF_FUNC_AUTO_MODE					5
 #define APMF_FUNC_SET_FAN_IDX				7
+#define APMF_FUNC_OS_POWER_SLIDER_UPDATE		8
 #define APMF_FUNC_STATIC_SLIDER_GRANULAR       9
 #define APMF_FUNC_DYN_SLIDER_AC				11
 #define APMF_FUNC_DYN_SLIDER_DC				12
@@ -44,6 +45,14 @@
 #define GET_STT_LIMIT_APU	0x20
 #define GET_STT_LIMIT_HS2	0x21
 
+/* OS slider update notification */
+#define DC_BEST_PERF		0
+#define DC_BETTER_PERF		1
+#define DC_BATTERY_SAVER	3
+#define AC_BEST_PERF		4
+#define AC_BETTER_PERF		5
+#define AC_BETTER_BATTERY	6
+
 /* Fan Index for Auto Mode */
 #define FAN_INDEX_AUTO		0xFFFFFFFF
 
@@ -193,6 +202,11 @@ struct amd_pmf_static_slider_granular {
 	struct apmf_sps_prop_granular prop[POWER_SOURCE_MAX][POWER_MODE_MAX];
 };
 
+struct os_power_slider {
+	u16 size;
+	u8 slider_event;
+} __packed;
+
 struct fan_table_control {
 	bool manual;
 	unsigned long fan_id;
@@ -383,6 +397,7 @@ int amd_pmf_send_cmd(struct amd_pmf_dev
 int amd_pmf_init_metrics_table(struct amd_pmf_dev *dev);
 int amd_pmf_get_power_source(void);
 int apmf_install_handler(struct amd_pmf_dev *pmf_dev);
+int apmf_os_power_slider_update(struct amd_pmf_dev *dev, u8 flag);
 
 /* SPS Layer */
 int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf);
@@ -393,6 +408,7 @@ void amd_pmf_deinit_sps(struct amd_pmf_d
 int apmf_get_static_slider_granular(struct amd_pmf_dev *pdev,
 				    struct apmf_static_slider_granular_output *output);
 bool is_pprof_balanced(struct amd_pmf_dev *pmf);
+int amd_pmf_power_slider_update_event(struct amd_pmf_dev *dev);
 
 
 int apmf_update_fan_idx(struct amd_pmf_dev *pdev, bool manual, u32 idx);
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -119,14 +119,77 @@ int amd_pmf_get_pprof_modes(struct amd_p
 	return mode;
 }
 
+int amd_pmf_power_slider_update_event(struct amd_pmf_dev *dev)
+{
+	u8 mode, flag = 0;
+	int src;
+
+	mode = amd_pmf_get_pprof_modes(dev);
+	if (mode < 0)
+		return mode;
+
+	src = amd_pmf_get_power_source();
+
+	if (src == POWER_SOURCE_AC) {
+		switch (mode) {
+		case POWER_MODE_PERFORMANCE:
+			flag |= BIT(AC_BEST_PERF);
+			break;
+		case POWER_MODE_BALANCED_POWER:
+			flag |= BIT(AC_BETTER_PERF);
+			break;
+		case POWER_MODE_POWER_SAVER:
+			flag |= BIT(AC_BETTER_BATTERY);
+			break;
+		default:
+			dev_err(dev->dev, "unsupported platform profile\n");
+			return -EOPNOTSUPP;
+		}
+
+	} else if (src == POWER_SOURCE_DC) {
+		switch (mode) {
+		case POWER_MODE_PERFORMANCE:
+			flag |= BIT(DC_BEST_PERF);
+			break;
+		case POWER_MODE_BALANCED_POWER:
+			flag |= BIT(DC_BETTER_PERF);
+			break;
+		case POWER_MODE_POWER_SAVER:
+			flag |= BIT(DC_BATTERY_SAVER);
+			break;
+		default:
+			dev_err(dev->dev, "unsupported platform profile\n");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	apmf_os_power_slider_update(dev, flag);
+
+	return 0;
+}
+
 static int amd_pmf_profile_set(struct platform_profile_handler *pprof,
 			       enum platform_profile_option profile)
 {
 	struct amd_pmf_dev *pmf = container_of(pprof, struct amd_pmf_dev, pprof);
+	int ret = 0;
 
 	pmf->current_profile = profile;
 
-	return amd_pmf_set_sps_power_limits(pmf);
+	/* Notify EC about the slider position change */
+	if (is_apmf_func_supported(pmf, APMF_FUNC_OS_POWER_SLIDER_UPDATE)) {
+		ret = amd_pmf_power_slider_update_event(pmf);
+		if (ret)
+			return ret;
+	}
+
+	if (is_apmf_func_supported(pmf, APMF_FUNC_STATIC_SLIDER_GRANULAR)) {
+		ret = amd_pmf_set_sps_power_limits(pmf);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 int amd_pmf_init_sps(struct amd_pmf_dev *dev)
@@ -134,10 +197,13 @@ int amd_pmf_init_sps(struct amd_pmf_dev
 	int err;
 
 	dev->current_profile = PLATFORM_PROFILE_BALANCED;
-	amd_pmf_load_defaults_sps(dev);
 
-	/* update SPS balanced power mode thermals */
-	amd_pmf_set_sps_power_limits(dev);
+	if (is_apmf_func_supported(dev, APMF_FUNC_STATIC_SLIDER_GRANULAR)) {
+		amd_pmf_load_defaults_sps(dev);
+
+		/* update SPS balanced power mode thermals */
+		amd_pmf_set_sps_power_limits(dev);
+	}
 
 	dev->pprof.profile_get = amd_pmf_profile_get;
 	dev->pprof.profile_set = amd_pmf_profile_set;


