Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B59D6FA922
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbjEHKsc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbjEHKsN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:48:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BF62FCCB
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:47:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BBC7628F2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F45C433EF;
        Mon,  8 May 2023 10:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542842;
        bh=Ac2IXETuJtXZBCXg0ff+R78dOEQFF0bRUUpg0FilAk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZXQv5mHX22OoetwJscncRMX9riBGUSZNJXtuZrkM24BBL3ndnXUr3C20sJYY9MwlQ
         Ot1coEqMqLBZaWGzgmURVjTGwnRYJa+lhJAztf01GrS2IJo7CuuMmirQlQWBnSbT1r
         9KtXyxJvC283KD4PdfUsw1Fah4+/Yopz5GF18RqE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Avihai Horon <avihaih@nvidia.com>,
        Shay Drory <shayd@nvidia.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 567/663] RDMA/mlx5: Check pcie_relaxed_ordering_enabled() in UMR
Date:   Mon,  8 May 2023 11:46:33 +0200
Message-Id: <20230508094447.599365825@linuxfoundation.org>
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

From: Avihai Horon <avihaih@nvidia.com>

[ Upstream commit d43b020b0f82c088ef8ff3196ef00575a97d200e ]

relaxed_ordering_read HCA capability is set if both the device supports
relaxed ordering (RO) read and RO is set in PCI config space.

RO in PCI config space can change during runtime. This will change the
value of relaxed_ordering_read HCA capability in FW, but the driver will
not see it since it queries the capabilities only once.

This can lead to the following scenario:
1. RO in PCI config space is enabled.
2. User creates MKey without RO.
3. RO in PCI config space is disabled.
   As a result, relaxed_ordering_read HCA capability is turned off in FW
   but remains on in driver copy of the capabilities.
4. User requests to reconfig the MKey with RO via UMR.
5. Driver will try to reconfig the MKey with RO read although it
   shouldn't (as relaxed_ordering_read HCA capability is really off).

To fix this, check pcie_relaxed_ordering_enabled() before setting RO
read in UMR.

Fixes: 896ec9735336 ("RDMA/mlx5: Set mkey relaxed ordering by UMR with ConnectX-7")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Link: https://lore.kernel.org/r/8d39eb8317e7bed1a354311a20ae707788fd94ed.1681131553.git.leon@kernel.org
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/umr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index 029e9536ec28f..8b674514818a1 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -380,6 +380,9 @@ static void mlx5r_umr_set_access_flags(struct mlx5_ib_dev *dev,
 				       struct mlx5_mkey_seg *seg,
 				       unsigned int access_flags)
 {
+	bool ro_read = (access_flags & IB_ACCESS_RELAXED_ORDERING) &&
+		       pcie_relaxed_ordering_enabled(dev->mdev->pdev);
+
 	MLX5_SET(mkc, seg, a, !!(access_flags & IB_ACCESS_REMOTE_ATOMIC));
 	MLX5_SET(mkc, seg, rw, !!(access_flags & IB_ACCESS_REMOTE_WRITE));
 	MLX5_SET(mkc, seg, rr, !!(access_flags & IB_ACCESS_REMOTE_READ));
@@ -387,8 +390,7 @@ static void mlx5r_umr_set_access_flags(struct mlx5_ib_dev *dev,
 	MLX5_SET(mkc, seg, lr, 1);
 	MLX5_SET(mkc, seg, relaxed_ordering_write,
 		 !!(access_flags & IB_ACCESS_RELAXED_ORDERING));
-	MLX5_SET(mkc, seg, relaxed_ordering_read,
-		 !!(access_flags & IB_ACCESS_RELAXED_ORDERING));
+	MLX5_SET(mkc, seg, relaxed_ordering_read, ro_read);
 }
 
 int mlx5r_umr_rereg_pd_access(struct mlx5_ib_mr *mr, struct ib_pd *pd,
-- 
2.39.2



