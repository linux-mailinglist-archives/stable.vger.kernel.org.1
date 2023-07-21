Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2DC75D450
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjGUTTu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjGUTTq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:19:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B892737
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:19:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31AC561B24
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431C4C433C8;
        Fri, 21 Jul 2023 19:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967184;
        bh=D7FY89jS0eww/FqRuswgJiEtyq7MWSyhA6ACkA3gFC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ewif6H6ePFMNwiGNMG1+R3UQlUWpNn5WuDc3xvW1x0p412jS/oQLVht8mIDcOEt77
         uM4GZlZDRzdBnRnHMisyK5HiV1Lu7cTPJceywy3x6U35nGinMIwiK6WC6jkwtrGMdZ
         QPui1hXC5rUTmWULk/fA2FOn3AWm+kubAkqg4E1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alex Deucher <Alexander.Deucher@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 073/223] drm/amdgpu: Fix minmax warning
Date:   Fri, 21 Jul 2023 18:05:26 +0200
Message-ID: <20230721160523.975740832@linuxfoundation.org>
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

From: Luben Tuikov <luben.tuikov@amd.com>

commit abd51738fe754a684ec44b7a9eca1981e1704ad9 upstream.

Fix minmax warning by using min_t() macro and explicitly specifying
the assignment type.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1441,7 +1441,9 @@ static int smu_v13_0_irq_process(struct
 			case 0x8:
 				high = smu->thermal_range.software_shutdown_temp +
 					smu->thermal_range.software_shutdown_temp_offset;
-				high = min(SMU_THERMAL_MAXIMUM_ALERT_TEMP, high);
+				high = min_t(typeof(high),
+					     SMU_THERMAL_MAXIMUM_ALERT_TEMP,
+					     high);
 				dev_emerg(adev->dev, "Reduce soft CTF limit to %d (by an offset %d)\n",
 							high,
 							smu->thermal_range.software_shutdown_temp_offset);
@@ -1454,8 +1456,9 @@ static int smu_v13_0_irq_process(struct
 				WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, data);
 				break;
 			case 0x9:
-				high = min(SMU_THERMAL_MAXIMUM_ALERT_TEMP,
-					smu->thermal_range.software_shutdown_temp);
+				high = min_t(typeof(high),
+					     SMU_THERMAL_MAXIMUM_ALERT_TEMP,
+					     smu->thermal_range.software_shutdown_temp);
 				dev_emerg(adev->dev, "Recover soft CTF limit to %d\n", high);
 
 				data = RREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL);


