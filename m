Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C334A761538
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbjGYL0n (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbjGYL0m (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:26:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87FA19F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:26:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 744756168F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D0BC433C8;
        Tue, 25 Jul 2023 11:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284397;
        bh=Dawbfi9cUKcgHz0FMKbti22L1G5HksK8tkVVdpDwyy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xjUUKTJujHPjZvW73bX0+aPkTdvDaYhoS3m3pNFReKPnFdewL1VdDhj+vZtN0li5N
         X1dnRAfqB7Pf/kR8As5SQ63FaRxDaf7UcwRiZgbNF6DuXDVQg+6Q34kmZ1UMiXy61Z
         KQG4clN5reQ4tg6dSJL6uxsJv5qZXg1pcB1+VDrA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhengchao Shao <shaozhengchao@huawei.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 340/509] net/mlx5e: fix double free in mlx5e_destroy_flow_table
Date:   Tue, 25 Jul 2023 12:44:39 +0200
Message-ID: <20230725104609.287768790@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhengchao Shao <shaozhengchao@huawei.com>

[ Upstream commit 884abe45a9014d0de2e6edb0630dfd64f23f1d1b ]

In function accel_fs_tcp_create_groups(), when the ft->g memory is
successfully allocated but the 'in' memory fails to be allocated, the
memory pointed to by ft->g is released once. And in function
accel_fs_tcp_create_table, mlx5e_destroy_flow_table is called to release
the memory pointed to by ft->g again. This will cause double free problem.

Fixes: c062d52ac24c ("net/mlx5e: Receive flow steering framework for accelerated TCP flows")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
index e51f60b55daa4..2da90f6649d17 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
@@ -194,6 +194,7 @@ static int accel_fs_tcp_create_groups(struct mlx5e_flow_table *ft,
 	in = kvzalloc(inlen, GFP_KERNEL);
 	if  (!in || !ft->g) {
 		kfree(ft->g);
+		ft->g = NULL;
 		kvfree(in);
 		return -ENOMEM;
 	}
-- 
2.39.2



