Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1432578335D
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjHUT7O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjHUT7N (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:59:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DC1183
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:59:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CD51646FF
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36ECCC433C8;
        Mon, 21 Aug 2023 19:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647942;
        bh=CE46UrjLI89jK7OPIFEf+aCDPgDqvk+a44r8r6zt2hk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SXntv5wD5AwOb9BjJXG7UyuNL0cKUGExNRPuOKKztAraYn1xqKBDuSGBi4zksSMVv
         KahzNzkvzMRBQl4zF0JZ2tbRIs+t+C2Stm3SurImP0MOr3+v+mlb+zCn14QS8Cgfe5
         1ZvhYNXHUSVyLD/BXsD/y5rybQQww85cDlNukKec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Evan Quan <evan.quan@amd.com>,
        Umio Yasuno <coelacanth_dream@protonmail.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 164/194] drm/amdgpu/pm: fix throttle_status for other than MP1 11.0.7
Date:   Mon, 21 Aug 2023 21:42:23 +0200
Message-ID: <20230821194129.910879660@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Umio Yasuno <coelacanth_dream@protonmail.com>

commit 6a92761a86817ad15c9a562e2a809386237fae3e upstream.

Use the right metrics table version based on the firmware.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2720
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Umio Yasuno <coelacanth_dream@protonmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -588,7 +588,9 @@ err0_out:
 	return -ENOMEM;
 }
 
-static uint32_t sienna_cichlid_get_throttler_status_locked(struct smu_context *smu)
+static uint32_t sienna_cichlid_get_throttler_status_locked(struct smu_context *smu,
+							   bool use_metrics_v3,
+							   bool use_metrics_v2)
 {
 	struct smu_table_context *smu_table= &smu->smu_table;
 	SmuMetricsExternal_t *metrics_ext =
@@ -596,13 +598,11 @@ static uint32_t sienna_cichlid_get_throt
 	uint32_t throttler_status = 0;
 	int i;
 
-	if ((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
-	     (smu->smc_fw_version >= 0x3A4900)) {
+	if (use_metrics_v3) {
 		for (i = 0; i < THROTTLER_COUNT; i++)
 			throttler_status |=
 				(metrics_ext->SmuMetrics_V3.ThrottlingPercentage[i] ? 1U << i : 0);
-	} else if ((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
-	     (smu->smc_fw_version >= 0x3A4300)) {
+	} else if (use_metrics_v2) {
 		for (i = 0; i < THROTTLER_COUNT; i++)
 			throttler_status |=
 				(metrics_ext->SmuMetrics_V2.ThrottlingPercentage[i] ? 1U << i : 0);
@@ -864,7 +864,7 @@ static int sienna_cichlid_get_smu_metric
 			metrics->TemperatureVrSoc) * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_THROTTLER_STATUS:
-		*value = sienna_cichlid_get_throttler_status_locked(smu);
+		*value = sienna_cichlid_get_throttler_status_locked(smu, use_metrics_v3, use_metrics_v2);
 		break;
 	case METRICS_CURR_FANSPEED:
 		*value = use_metrics_v3 ? metrics_v3->CurrFanSpeed :
@@ -4017,7 +4017,7 @@ static ssize_t sienna_cichlid_get_gpu_me
 	gpu_metrics->current_dclk1 = use_metrics_v3 ? metrics_v3->CurrClock[PPCLK_DCLK_1] :
 		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_DCLK_1] : metrics->CurrClock[PPCLK_DCLK_1];
 
-	gpu_metrics->throttle_status = sienna_cichlid_get_throttler_status_locked(smu);
+	gpu_metrics->throttle_status = sienna_cichlid_get_throttler_status_locked(smu, use_metrics_v3, use_metrics_v2);
 	gpu_metrics->indep_throttle_status =
 			smu_cmn_get_indep_throttler_status(gpu_metrics->throttle_status,
 							   sienna_cichlid_throttler_map);


