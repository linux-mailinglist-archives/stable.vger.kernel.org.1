Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F9D7CAC1C
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjJPOti (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjJPOth (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:49:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A8CAB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:49:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE31C433C9;
        Mon, 16 Oct 2023 14:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467774;
        bh=RtOU1IA90ZK6oMO/nvUNyXaYn3hgdjmGZSbcbcCN+fk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NbnPrgCK+4+C0BTQHBAkfsc2bFc21bvnDzw4OoAET+i5l7nU3PF3/AYulObcd4Ugm
         b8bbCnRK4x9ZspOxRLrvi9+G/r5AoZjEJHJIgfcGpnpV1zXc2DBYLaEka+igo7yk5F
         xsTphOUZOitUZSoWcZ0a9DUJ0kiPIFJUwWbjq2qU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Petr Machata <petrm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 063/191] mlxsw: fix mlxsw_sp2_nve_vxlan_learning_set() return type
Date:   Mon, 16 Oct 2023 10:40:48 +0200
Message-ID: <20231016084016.870833590@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 1e0b72a2a6432c0ef67ee5ce8d9172a7c20bba25 ]

The mlxsw_sp2_nve_vxlan_learning_set() function is supposed to return
zero on success or negative error codes.  So it needs to be type int
instead of bool.

Fixes: 4ee70efab68d ("mlxsw: spectrum_nve: Add support for VXLAN on Spectrum-2")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
index bb8eeb86edf75..52c2fe3644d4b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
@@ -310,8 +310,8 @@ const struct mlxsw_sp_nve_ops mlxsw_sp1_nve_vxlan_ops = {
 	.fdb_clear_offload = mlxsw_sp_nve_vxlan_clear_offload,
 };
 
-static bool mlxsw_sp2_nve_vxlan_learning_set(struct mlxsw_sp *mlxsw_sp,
-					     bool learning_en)
+static int mlxsw_sp2_nve_vxlan_learning_set(struct mlxsw_sp *mlxsw_sp,
+					    bool learning_en)
 {
 	char tnpc_pl[MLXSW_REG_TNPC_LEN];
 
-- 
2.40.1



