Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8505675D44F
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjGUTTp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjGUTTo (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:19:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C630A30E1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:19:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6367F61D76
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708F6C433C8;
        Fri, 21 Jul 2023 19:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967181;
        bh=5SaG67XmFTXrKTZQScgKzqusmBoAXjU/NZCrO+LXlMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UWRw0hjCzbaqA1asOPBw4XpaW94YTPyeuVnY9t5ucf0OBaa9YufmcfAdpV79Ti4k1
         Z0wBGqP0s4/pXYRs7R15qzlKSDdg3Q5VhciHfLm4Y2FH3Q2vq8gSHFlqhuJgq15Fbq
         Mt0tNhKZNqP0h+JF/tN29q2COpHphTsBHS+YszIM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, lyndonli <Lyndon.Li@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Kenneth Feng <kenneth.feng@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 072/223] drm/amdgpu: add the fan abnormal detection feature
Date:   Fri, 21 Jul 2023 18:05:25 +0200
Message-ID: <20230721160523.933546106@linuxfoundation.org>
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

From: lyndonli <Lyndon.Li@amd.com>

commit ef5fca9f7294509ee5013af9e879edc5837c1d6c upstream.

Update the SW CTF limit from existing register
when there's a fan failure detected via SMU interrupt.

Signed-off-by: lyndonli <Lyndon.Li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h        |    1 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       |   28 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c |    1 
 3 files changed, 30 insertions(+)

--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -168,6 +168,7 @@ struct smu_temperature_range {
 	int mem_crit_max;
 	int mem_emergency_max;
 	int software_shutdown_temp;
+	int software_shutdown_temp_offset;
 };
 
 struct smu_state_validation_block {
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1381,6 +1381,7 @@ static int smu_v13_0_irq_process(struct
 	 */
 	uint32_t ctxid = entry->src_data[0];
 	uint32_t data;
+	uint32_t high;
 
 	if (client_id == SOC15_IH_CLIENTID_THM) {
 		switch (src_id) {
@@ -1437,6 +1438,33 @@ static int smu_v13_0_irq_process(struct
 					schedule_work(&smu->throttling_logging_work);
 
 				break;
+			case 0x8:
+				high = smu->thermal_range.software_shutdown_temp +
+					smu->thermal_range.software_shutdown_temp_offset;
+				high = min(SMU_THERMAL_MAXIMUM_ALERT_TEMP, high);
+				dev_emerg(adev->dev, "Reduce soft CTF limit to %d (by an offset %d)\n",
+							high,
+							smu->thermal_range.software_shutdown_temp_offset);
+
+				data = RREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL);
+				data = REG_SET_FIELD(data, THM_THERMAL_INT_CTRL,
+							DIG_THERM_INTH,
+							(high & 0xff));
+				data = data & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
+				WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, data);
+				break;
+			case 0x9:
+				high = min(SMU_THERMAL_MAXIMUM_ALERT_TEMP,
+					smu->thermal_range.software_shutdown_temp);
+				dev_emerg(adev->dev, "Recover soft CTF limit to %d\n", high);
+
+				data = RREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL);
+				data = REG_SET_FIELD(data, THM_THERMAL_INT_CTRL,
+							DIG_THERM_INTH,
+							(high & 0xff));
+				data = data & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
+				WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, data);
+				break;
 			}
 		}
 	}
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1288,6 +1288,7 @@ static int smu_v13_0_7_get_thermal_tempe
 	range->mem_emergency_max = (pptable->SkuTable.TemperatureLimit[TEMP_MEM] + CTF_OFFSET_MEM)*
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	range->software_shutdown_temp = powerplay_table->software_shutdown_temp;
+	range->software_shutdown_temp_offset = pptable->SkuTable.FanAbnormalTempLimitOffset;
 
 	return 0;
 }


