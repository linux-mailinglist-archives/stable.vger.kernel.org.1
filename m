Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6410A75D451
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjGUTTv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjGUTTu (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:19:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7624F30EA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:19:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0704661D9F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF26C433C7;
        Fri, 21 Jul 2023 19:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967187;
        bh=YGh2pPtcaHxqFB5UhNscP44LJ7PgcZxkpMrWJqgz2uw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CbLaslEJ1n4XAOQwdF5EwmwMDJxI9aJ+0gj4Z6ti8l6WjRwhtYKv7IwlJofcct52I
         tNr3lEDJDudADAwrl838AGMgXNtdasMG5Rl6OBEG9pI0se+mSchNwK5yqKgAptKVBP
         eQloOp+mEvRO/oBo9S69KriQUZ72terA5dL3pVRQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kenneth Feng <kenneth.feng@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 074/223] drm/amd/pm: add abnormal fan detection for smu 13.0.0
Date:   Fri, 21 Jul 2023 18:05:27 +0200
Message-ID: <20230721160524.017677954@linuxfoundation.org>
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

From: Kenneth Feng <kenneth.feng@amd.com>

commit 2da0036ea99bccb27f7fe3cf2aa2900860e9be46 upstream.

add abnormal fan detection for smu 13.0.0

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1281,6 +1281,7 @@ static int smu_v13_0_0_get_thermal_tempe
 	range->mem_emergency_max = (pptable->SkuTable.TemperatureLimit[TEMP_MEM] + CTF_OFFSET_MEM)*
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	range->software_shutdown_temp = powerplay_table->software_shutdown_temp;
+	range->software_shutdown_temp_offset = pptable->SkuTable.FanAbnormalTempLimitOffset;
 
 	return 0;
 }


