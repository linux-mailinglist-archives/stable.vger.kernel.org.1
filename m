Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4B875559F
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjGPUmw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjGPUmv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:42:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0497E45
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:42:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4497160EB8
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FD7C433C7;
        Sun, 16 Jul 2023 20:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540169;
        bh=isATnDHqU9ZpG/NBC7KVfs5AdKvvF8bkd40Pun4YuKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZG4h9ssK9pN3cgfXIkmo5Vmra3tyRXuCYPrIfcw5Blxn3ALzT7ZnyQUGT5PWyav3t
         XyFMRhC3gCm9piswC/BWUv2IGygSsmWuO0HiGE9yiF2OjnkQrsJXdBRhVW9OGpsZTt
         ICfrKxguz3Ww01wMjetJy8zTeCiTixStzDImGIxc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Evan Quan <Evan.Quan@amd.com>,
        Chengming Gui <Jack.Gui@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        Evan Quan <evan.quan@amd.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 268/591] drm/amdgpu: Fix memcpy() in sienna_cichlid_append_powerplay_table function.
Date:   Sun, 16 Jul 2023 21:46:47 +0200
Message-ID: <20230716194930.831727923@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit d50dc746ff72b9c48812dac3344fa87fbde940a3 ]

Fixes the following gcc with W=1:

In file included from ./include/linux/string.h:253,
                 from ./include/linux/bitmap.h:11,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/cpumask.h:5,
                 from ./arch/x86/include/asm/msr.h:11,
                 from ./arch/x86/include/asm/processor.h:22,
                 from ./arch/x86/include/asm/cpufeature.h:5,
                 from ./arch/x86/include/asm/thread_info.h:53,
                 from ./include/linux/thread_info.h:60,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/firmware.h:7,
                 from drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c:26:
In function ‘fortify_memcpy_chk’,
    inlined from ‘sienna_cichlid_append_powerplay_table’ at drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c:444:2,
    inlined from ‘sienna_cichlid_setup_pptable’ at drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c:506:8,
    inlined from ‘sienna_cichlid_setup_pptable’ at drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/sienna_cichlid_ppt.c:494:12:
./include/linux/fortify-string.h:413:4: warning: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
  413 |    __read_overflow2_field(q_size_field, size);
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

the compiler complains about the size calculation in the memcpy() -
"sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header)" is much
larger than what fits into table_member.

Hence, reuse 'smu_memcpy_trailing' for nv1x

Fixes: 7077b19a38240 ("drm/amd/pm: use macro to get pptable members")
Suggested-by: Evan Quan <Evan.Quan@amd.com>
Cc: Evan Quan <Evan.Quan@amd.com>
Cc: Chengming Gui <Jack.Gui@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 85d53597eb07a..f7ed3e655e397 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -431,7 +431,13 @@ static int sienna_cichlid_append_powerplay_table(struct smu_context *smu)
 {
 	struct atom_smc_dpm_info_v4_9 *smc_dpm_table;
 	int index, ret;
-	I2cControllerConfig_t *table_member;
+	PPTable_beige_goby_t *ppt_beige_goby;
+	PPTable_t *ppt;
+
+	if (smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 13))
+		ppt_beige_goby = smu->smu_table.driver_pptable;
+	else
+		ppt = smu->smu_table.driver_pptable;
 
 	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 					    smc_dpm_info);
@@ -440,9 +446,13 @@ static int sienna_cichlid_append_powerplay_table(struct smu_context *smu)
 				      (uint8_t **)&smc_dpm_table);
 	if (ret)
 		return ret;
-	GET_PPTABLE_MEMBER(I2cControllers, &table_member);
-	memcpy(table_member, smc_dpm_table->I2cControllers,
-			sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header));
+
+	if (smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 13))
+		smu_memcpy_trailing(ppt_beige_goby, I2cControllers, BoardReserved,
+				    smc_dpm_table, I2cControllers);
+	else
+		smu_memcpy_trailing(ppt, I2cControllers, BoardReserved,
+				    smc_dpm_table, I2cControllers);
 
 	return 0;
 }
-- 
2.39.2



