Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9F1713E32
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjE1Tc6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjE1Tc5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:32:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9A9D2
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:32:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D80961DC5
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A18FC433EF;
        Sun, 28 May 2023 19:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302375;
        bh=2YnKG/u1enG7Whl4T4pOCXXfFaDk9JuCPV89dYTqLEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kh+EtEKm6EbrgJPoDq1mIrtKN99JA1DDOMsq/gNjS4gbU2cfVeD3sVZs/rDRwujW7
         uyc7mWQXDT1I4lok+aE/uDLzW6HTjO4u0/HP/Fc/o7Hy2Cazpc5QKUtLKmpVIhowJn
         p7t6CFXRaBcMNPaiCpy6DUuUrkTxrKx2JcnCxV7U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vlad Buslov <vladbu@nvidia.com>,
        Roi Dayan <roid@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH 6.3 110/127] net/mlx5e: Use correct encap attribute during invalidation
Date:   Sun, 28 May 2023 20:11:26 +0100
Message-Id: <20230528190839.842440221@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
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

From: Vlad Buslov <vladbu@nvidia.com>

commit be071cdb167fc3e25fe81922166b3d499d23e8ac upstream.

With introduction of post action infrastructure most of the users of encap
attribute had been modified in order to obtain the correct attribute by
calling mlx5e_tc_get_encap_attr() helper instead of assuming encap action
is always on default attribute. However, the cited commit didn't modify
mlx5e_invalidate_encap() which prevents it from destroying correct modify
header action which leads to a warning [0]. Fix the issue by using correct
attribute.

[0]:

Feb 21 09:47:35 c-237-177-40-045 kernel: WARNING: CPU: 17 PID: 654 at drivers/net/ethernet/mellanox/mlx5/core/en_tc.c:684 mlx5e_tc_attach_mod_hdr+0x1cc/0x230 [mlx5_core]
Feb 21 09:47:35 c-237-177-40-045 kernel: RIP: 0010:mlx5e_tc_attach_mod_hdr+0x1cc/0x230 [mlx5_core]
Feb 21 09:47:35 c-237-177-40-045 kernel: Call Trace:
Feb 21 09:47:35 c-237-177-40-045 kernel:  <TASK>
Feb 21 09:47:35 c-237-177-40-045 kernel:  mlx5e_tc_fib_event_work+0x8e3/0x1f60 [mlx5_core]
Feb 21 09:47:35 c-237-177-40-045 kernel:  ? mlx5e_take_all_encap_flows+0xe0/0xe0 [mlx5_core]
Feb 21 09:47:35 c-237-177-40-045 kernel:  ? lock_downgrade+0x6d0/0x6d0
Feb 21 09:47:35 c-237-177-40-045 kernel:  ? lockdep_hardirqs_on_prepare+0x273/0x3f0
Feb 21 09:47:35 c-237-177-40-045 kernel:  ? lockdep_hardirqs_on_prepare+0x273/0x3f0
Feb 21 09:47:35 c-237-177-40-045 kernel:  process_one_work+0x7c2/0x1310
Feb 21 09:47:35 c-237-177-40-045 kernel:  ? lockdep_hardirqs_on_prepare+0x3f0/0x3f0
Feb 21 09:47:35 c-237-177-40-045 kernel:  ? pwq_dec_nr_in_flight+0x230/0x230
Feb 21 09:47:35 c-237-177-40-045 kernel:  ? rwlock_bug.part.0+0x90/0x90
Feb 21 09:47:35 c-237-177-40-045 kernel:  worker_thread+0x59d/0xec0
Feb 21 09:47:35 c-237-177-40-045 kernel:  ? __kthread_parkme+0xd9/0x1d0

Fixes: 8300f225268b ("net/mlx5e: Create new flow attr for multi table actions")
Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
@@ -1338,11 +1338,13 @@ static void mlx5e_invalidate_encap(struc
 	struct mlx5e_tc_flow *flow;
 
 	list_for_each_entry(flow, encap_flows, tmp_list) {
-		struct mlx5_flow_attr *attr = flow->attr;
 		struct mlx5_esw_flow_attr *esw_attr;
+		struct mlx5_flow_attr *attr;
 
 		if (!mlx5e_is_offloaded_flow(flow))
 			continue;
+
+		attr = mlx5e_tc_get_encap_attr(flow);
 		esw_attr = attr->esw_attr;
 
 		if (flow_flag_test(flow, SLOW))


