Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12D678AA1E
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjH1KTB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjH1KSf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:18:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7B5A7
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:18:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAE9A63779
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B799AC433C8;
        Mon, 28 Aug 2023 10:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217900;
        bh=6eOstWt77eQhyl7mEGHAPKPLEicevdSE0tuHYMO5rO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PClgAWzPrKc2+qM5uN9QCLp0kFpyHKDGb9/lpuBKebdp8J5Yi/yj2UThOtN/smTcO
         RyueXBibuvUfhg2VOxbEvf42wLu+faqHgSW5UYJ0nifCtRhr+F0UNvslQwxNhj3P/L
         hJEKVnH54Z9V2V+HeCtM9KMBfObmVgzzolCA7Mk0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 023/129] mlxsw: reg: Fix SSPR register layout
Date:   Mon, 28 Aug 2023 12:11:42 +0200
Message-ID: <20230828101158.145513008@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 0dc63b9cfd4c5666ced52c829fdd65dcaeb9f0f1 ]

The two most significant bits of the "local_port" field in the SSPR
register are always cleared since they are overwritten by the deprecated
and overlapping "sub_port" field.

On systems with more than 255 local ports (e.g., Spectrum-4), this
results in the firmware maintaining invalid mappings between system port
and local port. Specifically, two different systems ports (0x1 and
0x101) point to the same local port (0x1), which eventually leads to
firmware errors.

Fix by removing the deprecated "sub_port" field.

Fixes: fd24b29a1b74 ("mlxsw: reg: Align existing registers to use extended local_port field")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/9b909a3033c8d3d6f67f237306bef4411c5e6ae4.1692268427.git.petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/reg.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index 8165bf31a99ae..17160e867befb 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -97,14 +97,6 @@ MLXSW_ITEM32(reg, sspr, m, 0x00, 31, 1);
  */
 MLXSW_ITEM32_LP(reg, sspr, 0x00, 16, 0x00, 12);
 
-/* reg_sspr_sub_port
- * Virtual port within the physical port.
- * Should be set to 0 when virtual ports are not enabled on the port.
- *
- * Access: RW
- */
-MLXSW_ITEM32(reg, sspr, sub_port, 0x00, 8, 8);
-
 /* reg_sspr_system_port
  * Unique identifier within the stacking domain that represents all the ports
  * that are available in the system (external ports).
@@ -120,7 +112,6 @@ static inline void mlxsw_reg_sspr_pack(char *payload, u16 local_port)
 	MLXSW_REG_ZERO(sspr, payload);
 	mlxsw_reg_sspr_m_set(payload, 1);
 	mlxsw_reg_sspr_local_port_set(payload, local_port);
-	mlxsw_reg_sspr_sub_port_set(payload, 0);
 	mlxsw_reg_sspr_system_port_set(payload, local_port);
 }
 
-- 
2.40.1



