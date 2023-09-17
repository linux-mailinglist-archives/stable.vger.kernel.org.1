Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720917A3BA9
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240756AbjIQUUu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240787AbjIQUUZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:20:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43720191
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:20:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62120C433C7;
        Sun, 17 Sep 2023 20:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982019;
        bh=KwVt4ZsbGyHrdDk51/25Wg0ctas+zrsVXaqUqHvYPyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=183iOUXN/OUk1SGaxUV8Ne9ocIMp+QSpkZ1Rhh63E1S+1JzNK4qCzFdX0fWJThlHr
         rkfrOcy1Kr+IsKx/SNBoKZA2r85g17IHS2sM2gZrloimfxuSpTakGkhHCbMIzlO4RF
         RBuGVTEa2Sd9axmC6PBPGhJttbPbMz43Ikksdj20=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Shravan Kumar Ramani <shravankr@nvidia.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 206/219] platform/mellanox: mlxbf-pmc: Fix reading of unprogrammed events
Date:   Sun, 17 Sep 2023 21:15:33 +0200
Message-ID: <20230917191048.382434703@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shravan Kumar Ramani <shravankr@nvidia.com>

[ Upstream commit 0f5969452e162efc50bdc98968fb62b424a9874b ]

This fix involves 2 changes:
 - All event regs have a reset value of 0, which is not a valid
   event_number as per the event_list for most blocks and hence seen
   as an error. Add a "disable" event with event_number 0 for all blocks.

 - The enable bit for each counter need not be checked before
   reading the event info, and hence removed.

Fixes: 1a218d312e65 ("platform/mellanox: mlxbf-pmc: Add Mellanox BlueField PMC driver")
Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
Link: https://lore.kernel.org/r/04d0213932d32681de1c716b54320ed894e52425.1693917738.git.shravankr@nvidia.com
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/mellanox/mlxbf-pmc.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 95afcae7b9fa9..2d4bbe99959ef 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -191,6 +191,7 @@ static const struct mlxbf_pmc_events mlxbf_pmc_smgen_events[] = {
 };
 
 static const struct mlxbf_pmc_events mlxbf_pmc_trio_events_1[] = {
+	{ 0x0, "DISABLE" },
 	{ 0xa0, "TPIO_DATA_BEAT" },
 	{ 0xa1, "TDMA_DATA_BEAT" },
 	{ 0xa2, "MAP_DATA_BEAT" },
@@ -214,6 +215,7 @@ static const struct mlxbf_pmc_events mlxbf_pmc_trio_events_1[] = {
 };
 
 static const struct mlxbf_pmc_events mlxbf_pmc_trio_events_2[] = {
+	{ 0x0, "DISABLE" },
 	{ 0xa0, "TPIO_DATA_BEAT" },
 	{ 0xa1, "TDMA_DATA_BEAT" },
 	{ 0xa2, "MAP_DATA_BEAT" },
@@ -246,6 +248,7 @@ static const struct mlxbf_pmc_events mlxbf_pmc_trio_events_2[] = {
 };
 
 static const struct mlxbf_pmc_events mlxbf_pmc_ecc_events[] = {
+	{ 0x0, "DISABLE" },
 	{ 0x100, "ECC_SINGLE_ERROR_CNT" },
 	{ 0x104, "ECC_DOUBLE_ERROR_CNT" },
 	{ 0x114, "SERR_INJ" },
@@ -258,6 +261,7 @@ static const struct mlxbf_pmc_events mlxbf_pmc_ecc_events[] = {
 };
 
 static const struct mlxbf_pmc_events mlxbf_pmc_mss_events[] = {
+	{ 0x0, "DISABLE" },
 	{ 0xc0, "RXREQ_MSS" },
 	{ 0xc1, "RXDAT_MSS" },
 	{ 0xc2, "TXRSP_MSS" },
@@ -265,6 +269,7 @@ static const struct mlxbf_pmc_events mlxbf_pmc_mss_events[] = {
 };
 
 static const struct mlxbf_pmc_events mlxbf_pmc_hnf_events[] = {
+	{ 0x0, "DISABLE" },
 	{ 0x45, "HNF_REQUESTS" },
 	{ 0x46, "HNF_REJECTS" },
 	{ 0x47, "ALL_BUSY" },
@@ -323,6 +328,7 @@ static const struct mlxbf_pmc_events mlxbf_pmc_hnf_events[] = {
 };
 
 static const struct mlxbf_pmc_events mlxbf_pmc_hnfnet_events[] = {
+	{ 0x0, "DISABLE" },
 	{ 0x12, "CDN_REQ" },
 	{ 0x13, "DDN_REQ" },
 	{ 0x14, "NDN_REQ" },
@@ -892,7 +898,7 @@ static int mlxbf_pmc_read_event(int blk_num, uint32_t cnt_num, bool is_l3,
 				uint64_t *result)
 {
 	uint32_t perfcfg_offset, perfval_offset;
-	uint64_t perfmon_cfg, perfevt, perfctl;
+	uint64_t perfmon_cfg, perfevt;
 
 	if (cnt_num >= pmc->block[blk_num].counters)
 		return -EINVAL;
@@ -904,25 +910,6 @@ static int mlxbf_pmc_read_event(int blk_num, uint32_t cnt_num, bool is_l3,
 	perfval_offset = perfcfg_offset +
 			 pmc->block[blk_num].counters * MLXBF_PMC_REG_SIZE;
 
-	/* Set counter in "read" mode */
-	perfmon_cfg = FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_ADDR,
-				 MLXBF_PMC_PERFCTL);
-	perfmon_cfg |= FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_STROBE, 1);
-	perfmon_cfg |= FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_WR_R_B, 0);
-
-	if (mlxbf_pmc_write(pmc->block[blk_num].mmio_base + perfcfg_offset,
-			    MLXBF_PMC_WRITE_REG_64, perfmon_cfg))
-		return -EFAULT;
-
-	/* Check if the counter is enabled */
-
-	if (mlxbf_pmc_read(pmc->block[blk_num].mmio_base + perfval_offset,
-			   MLXBF_PMC_READ_REG_64, &perfctl))
-		return -EFAULT;
-
-	if (!FIELD_GET(MLXBF_PMC_PERFCTL_EN0, perfctl))
-		return -EINVAL;
-
 	/* Set counter in "read" mode */
 	perfmon_cfg = FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_ADDR,
 				 MLXBF_PMC_PERFEVT);
-- 
2.40.1



