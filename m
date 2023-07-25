Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27439761162
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjGYKuj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbjGYKuV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:50:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BB81FC7
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:50:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34069616A1
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C592C4167D;
        Tue, 25 Jul 2023 10:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282202;
        bh=xooRu0cCCOEw1oT9me3jZBrlvMDLb5FEYYhjeHL0XAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uLeQMGgU5eyVdTVjjtNw7khnRI6ep8XEc6lOTw0Q/D20F6eJn12swsUwvCELxcX+i
         5m6XpXzK84XF+yASHkhlyFWPDL27WMMlx82A98iDIXQRlg09zZiqsQ0PMDi8fy+aSr
         A9VVDVlmsoiZOu2xAKa51LkbQ0mnj5I6DUhEVSN8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kenneth Feng <kenneth.feng@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.4 045/227] drm/amdgpu/pm: make gfxclock consistent for sienna cichlid
Date:   Tue, 25 Jul 2023 12:43:32 +0200
Message-ID: <20230725104516.667140025@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit a4eb11824170d742531998f4ebd1c6a18b63db47 upstream.

Use average gfxclock for consistency with other dGPUs.

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.1.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1927,12 +1927,16 @@ static int sienna_cichlid_read_sensor(st
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GFX_MCLK:
-		ret = sienna_cichlid_get_current_clk_freq_by_table(smu, SMU_UCLK, (uint32_t *)data);
+		ret = sienna_cichlid_get_smu_metrics_data(smu,
+							  METRICS_CURR_UCLK,
+							  (uint32_t *)data);
 		*(uint32_t *)data *= 100;
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GFX_SCLK:
-		ret = sienna_cichlid_get_current_clk_freq_by_table(smu, SMU_GFXCLK, (uint32_t *)data);
+		ret = sienna_cichlid_get_smu_metrics_data(smu,
+							  METRICS_AVERAGE_GFXCLK,
+							  (uint32_t *)data);
 		*(uint32_t *)data *= 100;
 		*size = 4;
 		break;


