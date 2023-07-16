Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2007551D8
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjGPUAv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjGPUAt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:00:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E8F1B9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:00:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E1F060E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0B6C433C8;
        Sun, 16 Jul 2023 20:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537647;
        bh=hhI4rf84MfGU/fIg4KdU1DAWAJmUXSgito3nS/X4vx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mg+02VPUyKcNxExTyCOEJqKjCuSmkFgU1WbH35lA28OutDh6SsPuFZedb5EsUtKVL
         AXGlP5PSvvUBqj8uhdCrkYj1jRShNZRVX5iBNgkr3h3YoM3+YG1OjdmVOqLhEh88cv
         3rLF6pQ9dVfskBcjQg6yUu9f8idFZBbvv3YpG3NI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ziyang Huang <hzyitc@outlook.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 170/800] wifi: ath11k: Restart firmware after cold boot calibration for IPQ5018
Date:   Sun, 16 Jul 2023 21:40:23 +0200
Message-ID: <20230716194953.057410838@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ziyang Huang <hzyitc@outlook.com>

[ Upstream commit 80c5390e1f5e5b16d820512265530ef26073d8e0 ]

Restart is required after cold boot calibration on IPQ5018. Otherwise,
we get the following exception:

	[   14.412829] qcom-q6-mpd cd00000.remoteproc: fatal error received: err_smem_ver.2.1:
	[   14.412829] QC Image Version : QC_IMAGE_VERSION_STRING=WLAN.HK.2.6.0.1-00974-QCAHKSWPL_SILICONZ-1
	[   14.412829] Image Variant : IMAGE_VARIANT_STRING=5018.wlanfw2.map_spr_spr_evalQ
	[   14.412829] DALSysLogEvent.c:174 Assertion 0 failed param0 :zero,param1 :zero,param2 :zero
	[   14.412829] Thread ID : 0x00000048 Thread name : WLAN RT0 Process ID : 0x00000001 Process name :wlan0
	[   14.412829]
	[   14.412829] Registers:
	[   14.412829] SP : 0x4c81c120
	[   14.412829] FP : 0x4c81c138
	[   14.412829] PC : 0xb022c590
	[   14.412829] SSR : 0x00000000
	[   14.412829] BADVA : 0x00000000
	[   14.412829] LR : 0xb0008490
	[   14.412829]
	[   14.412829] StackDump
	[   14.412829] from:0x4c81c120
	[   14.412829] to: 0x00000000:
	[   14.412829]
	[   14.463006] remoteproc remoteproc0: crash detected in cd00000.remoteproc: type fatal error

Fixes: 8dfe875aa24a ("wifi: ath11k: update hw params for IPQ5018")
Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/TYZPR01MB55566969818BD4B49E770445C953A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index b1b90bd34d67e..9de23c11e18bb 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -664,6 +664,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hal_params = &ath11k_hw_hal_params_ipq8074,
 		.single_pdev_only = false,
 		.cold_boot_calib = true,
+		.cbcal_restart_fw = true,
 		.fix_l1ss = true,
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = true,
-- 
2.39.2



