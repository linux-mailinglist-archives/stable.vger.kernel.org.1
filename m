Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1D36FA7C6
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbjEHKew (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbjEHKeS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:34:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65AB25533
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:33:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3DDC614EA
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A321CC433EF;
        Mon,  8 May 2023 10:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542008;
        bh=YSy9V8mQdM4yFkF4v5ZvF2/EfD/DWjHoRcQO2CMxSao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yiR1hkqEWW7AFXt5ZAqraes2I1hnpFI9dVaKz6YQQ0TcjtxKlHcsqYGrsCSLmPXId
         wsymS6ABo/rrb9+q7jVC7vPPDOj2haNEF/2YvKqzpL/JsbLNlh5rjZAWTrg2k8JUv3
         YasfsuSUN/4jer+3Z6ri8Kqu7PP8ECu4Q8VEquog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 296/663] wifi: ath11k: fix deinitialization of firmware resources
Date:   Mon,  8 May 2023 11:42:02 +0200
Message-Id: <20230508094437.787259608@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Aditya Kumar Singh <quic_adisi@quicinc.com>

[ Upstream commit 5a78ac33e3cb8822da64dd1af196e83664b332b0 ]

Currently, in ath11k_ahb_fw_resources_init(), iommu domain
mapping is done only for the chipsets having fixed firmware
memory. Also, for such chipsets, mapping is done only if it
does not have TrustZone support.

During deinitialization, only if TrustZone support is not there,
iommu is unmapped back. However, for non fixed firmware memory
chipsets, TrustZone support is not there and this makes the
condition check to true and it tries to unmap the memory which
was not mapped during initialization.

This leads to the following trace -

[   83.198790] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
[   83.259537] Modules linked in: ath11k_ahb ath11k qmi_helpers
.. snip ..
[   83.280286] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   83.287228] pc : __iommu_unmap+0x30/0x140
[   83.293907] lr : iommu_unmap+0x5c/0xa4
[   83.298072] sp : ffff80000b3abad0
.. snip ..
[   83.369175] Call trace:
[   83.376282]  __iommu_unmap+0x30/0x140
[   83.378541]  iommu_unmap+0x5c/0xa4
[   83.382360]  ath11k_ahb_fw_resource_deinit.part.12+0x2c/0xac [ath11k_ahb]
[   83.385666]  ath11k_ahb_free_resources+0x140/0x17c [ath11k_ahb]
[   83.392521]  ath11k_ahb_shutdown+0x34/0x40 [ath11k_ahb]
[   83.398248]  platform_shutdown+0x20/0x2c
[   83.403455]  device_shutdown+0x16c/0x1c4
[   83.407621]  kernel_restart_prepare+0x34/0x3c
[   83.411529]  kernel_restart+0x14/0x74
[   83.415781]  __do_sys_reboot+0x1c4/0x22c
[   83.419427]  __arm64_sys_reboot+0x1c/0x24
[   83.423420]  invoke_syscall+0x44/0xfc
[   83.427326]  el0_svc_common.constprop.3+0xac/0xe8
[   83.430974]  do_el0_svc+0xa0/0xa8
[   83.435659]  el0_svc+0x1c/0x44
[   83.438957]  el0t_64_sync_handler+0x60/0x144
[   83.441910]  el0t_64_sync+0x15c/0x160
[   83.446343] Code: aa0103f4 f9400001 f90027a1 d2800001 (f94006a0)
[   83.449903] ---[ end trace 0000000000000000 ]---

This can be reproduced by probing an AHB chipset which is not
having a fixed memory region. During reboot (or rmmod) trace
can be seen.

Fix this issue by adding a condition check on firmware fixed memory
hw_param as done in the counter initialization function.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Fixes: f9eec4947add ("ath11k: Add support for targets without trustzone")
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230309095308.24937-1-quic_adisi@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index f70a119bb5c87..76f275ca53e9c 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -1063,6 +1063,12 @@ static int ath11k_ahb_fw_resource_deinit(struct ath11k_base *ab)
 	struct iommu_domain *iommu;
 	size_t unmapped_size;
 
+	/* Chipsets not requiring MSA would have not initialized
+	 * MSA resources, return success in such cases.
+	 */
+	if (!ab->hw_params.fixed_fw_mem)
+		return 0;
+
 	if (ab_ahb->fw.use_tz)
 		return 0;
 
-- 
2.39.2



