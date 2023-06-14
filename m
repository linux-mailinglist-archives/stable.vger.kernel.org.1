Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF84713D40
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjE1TXY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjE1TXY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:23:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DE9A0
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:23:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC1B660EE0
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0EDC433EF;
        Sun, 28 May 2023 19:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301802;
        bh=LGa5rmrsNWZw33RZf0cWsonH+rv2VN+FUrGrm2H+D4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rFZZTdCY6L2pKwm4/SLXwib3mAnM+yVtveaet7u4YCi2Yk56ZPf5m99q4QBj/zBqD
         o3Dir2lwjCnW1OZ7tyt7gmLsEHo184+EkB/GB1yZzAVLfMb1npo6gPkqaTDItNyKNE
         9GifQGoV9LjZGB/hUKStjUvm9R0/qMwHKXEYJSCc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Roy Novich <royno@nvidia.com>,
        Aya Levin <ayal@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 004/161] linux/dim: Do nothing if no time delta between samples
Date:   Sun, 28 May 2023 20:08:48 +0100
Message-Id: <20230528190837.226129476@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Roy Novich <royno@nvidia.com>

[ Upstream commit 162bd18eb55adf464a0fa2b4144b8d61c75ff7c2 ]

Add return value for dim_calc_stats. This is an indication for the
caller if curr_stats was assigned by the function. Avoid using
curr_stats uninitialized over {rdma/net}_dim, when no time delta between
samples. Coverity reported this potential use of an uninitialized
variable.

Fixes: 4c4dbb4a7363 ("net/mlx5e: Move dynamic interrupt coalescing code to include/linux")
Fixes: cb3c7fd4f839 ("net/mlx5e: Support adaptive RX coalescing")
Signed-off-by: Roy Novich <royno@nvidia.com>
Reviewed-by: Aya Levin <ayal@nvidia.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Link: https://lore.kernel.org/r/20230507135743.138993-1-tariqt@nvidia.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/dim.h | 3 ++-
 lib/dim/dim.c       | 5 +++--
 lib/dim/net_dim.c   | 3 ++-
 lib/dim/rdma_dim.c  | 3 ++-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/dim.h b/include/linux/dim.h
index 2571da63877c5..ad5f219ce2ff2 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -233,8 +233,9 @@ void dim_park_tired(struct dim *dim);
  *
  * Calculate the delta between two samples (in data rates).
  * Takes into consideration counter wrap-around.
+ * Returned boolean indicates whether curr_stats are reliable.
  */
-void dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
+bool dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
 		    struct dim_stats *curr_stats);
 
 /**
diff --git a/lib/dim/dim.c b/lib/dim/dim.c
index 38045d6d05381..e89aaf07bde50 100644
--- a/lib/dim/dim.c
+++ b/lib/dim/dim.c
@@ -54,7 +54,7 @@ void dim_park_tired(struct dim *dim)
 }
 EXPORT_SYMBOL(dim_park_tired);
 
-void dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
+bool dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
 		    struct dim_stats *curr_stats)
 {
 	/* u32 holds up to 71 minutes, should be enough */
@@ -66,7 +66,7 @@ void dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
 			     start->comp_ctr);
 
 	if (!delta_us)
-		return;
+		return false;
 
 	curr_stats->ppms = DIV_ROUND_UP(npkts * USEC_PER_MSEC, delta_us);
 	curr_stats->bpms = DIV_ROUND_UP(nbytes * USEC_PER_MSEC, delta_us);
@@ -79,5 +79,6 @@ void dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
 	else
 		curr_stats->cpe_ratio = 0;
 
+	return true;
 }
 EXPORT_SYMBOL(dim_calc_stats);
diff --git a/lib/dim/net_dim.c b/lib/dim/net_dim.c
index dae3b51ac3d9b..0e4f3a686f1de 100644
--- a/lib/dim/net_dim.c
+++ b/lib/dim/net_dim.c
@@ -227,7 +227,8 @@ void net_dim(struct dim *dim, struct dim_sample end_sample)
 				  dim->start_sample.event_ctr);
 		if (nevents < DIM_NEVENTS)
 			break;
-		dim_calc_stats(&dim->start_sample, &end_sample, &curr_stats);
+		if (!dim_calc_stats(&dim->start_sample, &end_sample, &curr_stats))
+			break;
 		if (net_dim_decision(&curr_stats, dim)) {
 			dim->state = DIM_APPLY_NEW_PROFILE;
 			schedule_work(&dim->work);
diff --git a/lib/dim/rdma_dim.c b/lib/dim/rdma_dim.c
index f7e26c7b4749f..d32c8b105adc9 100644
--- a/lib/dim/rdma_dim.c
+++ b/lib/dim/rdma_dim.c
@@ -88,7 +88,8 @@ void rdma_dim(struct dim *dim, u64 completions)
 		nevents = curr_sample->event_ctr - dim->start_sample.event_ctr;
 		if (nevents < DIM_NEVENTS)
 			break;
-		dim_calc_stats(&dim->start_sample, curr_sample, &curr_stats);
+		if (!dim_calc_stats(&dim->start_sample, curr_sample, &curr_stats))
+			break;
 		if (rdma_dim_decision(&curr_stats, dim)) {
 			dim->state = DIM_APPLY_NEW_PROFILE;
 			schedule_work(&dim->work);
-- 
2.39.2



