Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F093B7758AB
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjHIKyz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjHIKyk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:54:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB90C5265
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD45063141
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14A9C433C8;
        Wed,  9 Aug 2023 10:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578335;
        bh=w8W9vcNiaAvRJxiDXnsDvbwGEJ1KmzsA5O5Ax1MqMQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mXYjX0sK7wdd9DPUFOotx4+tBNznS4phxyNAjwxftFW6J/buJRY1Q1JFu4AH/xmjr
         qr8Iky+x5W3ekbG4MP3NAtgNtQNuVmGosRdJ7oBCIaJs1+WKIJQWfolrkBvmHMADFG
         j60mrGVr86sV9Jl0n6oM30M6wroVCBswKHylF7Xk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhengchao Shao <shaozhengchao@huawei.com>,
        Simon Horman <simon.horman@corigine.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 022/127] net/mlx5e: fix double free in macsec_fs_tx_create_crypto_table_groups
Date:   Wed,  9 Aug 2023 12:40:09 +0200
Message-ID: <20230809103637.378800821@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhengchao Shao <shaozhengchao@huawei.com>

[ Upstream commit aeb660171b0663847fa04806a96302ac6112ad26 ]

In function macsec_fs_tx_create_crypto_table_groups(), when the ft->g
memory is successfully allocated but the 'in' memory fails to be
allocated, the memory pointed to by ft->g is released once. And in function
macsec_fs_tx_create(), macsec_fs_tx_destroy() is called to release the
memory pointed to by ft->g again. This will cause double free problem.

Fixes: e467b283ffd5 ("net/mlx5e: Add MACsec TX steering rules")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c
index 5b658a5588c64..6ecf0bf2366ad 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c
@@ -160,6 +160,7 @@ static int macsec_fs_tx_create_crypto_table_groups(struct mlx5e_flow_table *ft)
 
 	if (!in) {
 		kfree(ft->g);
+		ft->g = NULL;
 		return -ENOMEM;
 	}
 
-- 
2.40.1



