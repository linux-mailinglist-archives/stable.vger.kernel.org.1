Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D5B73539B
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjFSKqs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjFSKqN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:46:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78D61731
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:45:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BBA260B73
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B221C433C0;
        Mon, 19 Jun 2023 10:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171558;
        bh=WaZVmAssyh4p/W8srJFwLUfYNxnPdzVJJ0TkrO4fgOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eIqt9eaxcIDEh9inJkdvgmPWiLFsWd4FTj4JNDrAR29F5VlW3pPHBFTR4GmmbKRMg
         4j0xbJfnsCUXOPpGMNUrjUe/Uk9p8cHZPf3EGsDUCz2fgVLy0SgYt1Je4oZ+LBwyr2
         Cu3fXvzPNlPzAuFUe3pXwB1iaTcgkfkVJdRHwXXw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kenneth Feng <kenneth.feng@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 074/166] drm/amd/pm: workaround for compute workload type on some skus
Date:   Mon, 19 Jun 2023 12:29:11 +0200
Message-ID: <20230619102158.356108898@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
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

From: Kenneth Feng <kenneth.feng@amd.com>

commit 7ca302d488f80cf4529620acc1c545f9022d8bb8 upstream.

On smu 13.0.0, the compute workload type cannot be set on all the skus
due to some other problems. This workaround is to make sure compute workload type
can also run on some specific skus.

v2: keep the variable consistent

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Acked-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.1.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c |   33 +++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1675,10 +1675,39 @@ static int smu_v13_0_0_set_power_profile
 		}
 	}
 
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
+	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE &&
+		(((smu->adev->pdev->device == 0x744C) && (smu->adev->pdev->revision == 0xC8)) ||
+		((smu->adev->pdev->device == 0x744C) && (smu->adev->pdev->revision == 0xCC)))) {
+		ret = smu_cmn_update_table(smu,
+					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+					   WORKLOAD_PPLIB_COMPUTE_BIT,
+					   (void *)(&activity_monitor_external),
+					   false);
+		if (ret) {
+			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+			return ret;
+		}
+
+		ret = smu_cmn_update_table(smu,
+					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+					   WORKLOAD_PPLIB_CUSTOM_BIT,
+					   (void *)(&activity_monitor_external),
+					   true);
+		if (ret) {
+			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+			return ret;
+		}
+
+		workload_type = smu_cmn_to_asic_specific_index(smu,
+						       CMN2ASIC_MAPPING_WORKLOAD,
+						       PP_SMC_POWER_PROFILE_CUSTOM);
+	} else {
+		/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
+		workload_type = smu_cmn_to_asic_specific_index(smu,
 						       CMN2ASIC_MAPPING_WORKLOAD,
 						       smu->power_profile_mode);
+	}
+
 	if (workload_type < 0)
 		return -EINVAL;
 


