Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A825179BC5A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjIKWsK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240213AbjIKOjL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:39:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE67CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:39:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042E4C433CA;
        Mon, 11 Sep 2023 14:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443147;
        bh=2KSkbcue2oBoTklx8jOQpBug/0YeaRCTmK49JfWh9t4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qcn+mUdi9Yovmg6wFNwEc/vTrzQ6esnX7ThfRBccNAd/oCCOPU3kCGfQvE5xpfIBR
         2Gn9k/dD1khs4c17DJWORhN7gkY/8MZypvsoY0fJghYGzk24aNoagXy9kawtaOu3RD
         xUFZzcW5LXpiDFBm44I68touN+KcSy4j0CfP/PwM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon Horman <horms@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 247/737] net/mlx5: Dynamic cyclecounter shift calculation for PTP free running clock
Date:   Mon, 11 Sep 2023 15:41:46 +0200
Message-ID: <20230911134657.500384220@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

[ Upstream commit 84a58e60038fa0366006977dba85eae16b2e3d78 ]

Use a dynamic calculation to determine the shift value for the internal
timer cyclecounter that will lead to the highest precision frequency
adjustments. Previously used a constant for the shift value assuming all
devices supported by the driver had a nominal frequency of 1GHz. However,
there are devices that operate at different frequencies. The previous shift
value constant would break the PHC functionality for those devices.

Reported-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Closes: https://lore.kernel.org/netdev/20230815151507.3028503-1-vadfed@meta.com/
Fixes: 6a4010927562 ("net/mlx5: Update cyclecounter shift value to improve ptp free running mode precision")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Tested-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Acked-by: Saeed Mahameed <saeedm@nvidia.com>
Link: https://lore.kernel.org/r/20230821230554.236210-1-rrameshbabu@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 32 ++++++++++++++++---
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index dba4c5e2f7667..94a1635ecdd47 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -32,16 +32,13 @@
 
 #include <linux/clocksource.h>
 #include <linux/highmem.h>
+#include <linux/log2.h>
 #include <linux/ptp_clock_kernel.h>
 #include <rdma/mlx5-abi.h>
 #include "lib/eq.h"
 #include "en.h"
 #include "clock.h"
 
-enum {
-	MLX5_CYCLES_SHIFT	= 31
-};
-
 enum {
 	MLX5_PIN_MODE_IN		= 0x0,
 	MLX5_PIN_MODE_OUT		= 0x1,
@@ -93,6 +90,31 @@ static bool mlx5_modify_mtutc_allowed(struct mlx5_core_dev *mdev)
 	return MLX5_CAP_MCAM_FEATURE(mdev, ptpcyc2realtime_modify);
 }
 
+static u32 mlx5_ptp_shift_constant(u32 dev_freq_khz)
+{
+	/* Optimal shift constant leads to corrections above just 1 scaled ppm.
+	 *
+	 * Two sets of equations are needed to derive the optimal shift
+	 * constant for the cyclecounter.
+	 *
+	 *    dev_freq_khz * 1000 / 2^shift_constant = 1 scaled_ppm
+	 *    ppb = scaled_ppm * 1000 / 2^16
+	 *
+	 * Using the two equations together
+	 *
+	 *    dev_freq_khz * 1000 / 1 scaled_ppm = 2^shift_constant
+	 *    dev_freq_khz * 2^16 / 1 ppb = 2^shift_constant
+	 *    dev_freq_khz = 2^(shift_constant - 16)
+	 *
+	 * then yields
+	 *
+	 *    shift_constant = ilog2(dev_freq_khz) + 16
+	 */
+
+	return min(ilog2(dev_freq_khz) + 16,
+		   ilog2((U32_MAX / NSEC_PER_MSEC) * dev_freq_khz));
+}
+
 static bool mlx5_is_mtutc_time_adj_cap(struct mlx5_core_dev *mdev, s64 delta)
 {
 	s64 min = MLX5_MTUTC_OPERATION_ADJUST_TIME_MIN;
@@ -910,7 +932,7 @@ static void mlx5_timecounter_init(struct mlx5_core_dev *mdev)
 
 	dev_freq = MLX5_CAP_GEN(mdev, device_frequency_khz);
 	timer->cycles.read = read_internal_timer;
-	timer->cycles.shift = MLX5_CYCLES_SHIFT;
+	timer->cycles.shift = mlx5_ptp_shift_constant(dev_freq);
 	timer->cycles.mult = clocksource_khz2mult(dev_freq,
 						  timer->cycles.shift);
 	timer->nominal_c_mult = timer->cycles.mult;
-- 
2.40.1



