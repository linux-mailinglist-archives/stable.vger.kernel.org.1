Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6ED76166C
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbjGYLjW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbjGYLjP (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:39:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ED01FE2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:38:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8798C6169A
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945A3C433C7;
        Tue, 25 Jul 2023 11:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285139;
        bh=QyWUOdIXI1sD1NaxF0endeXbCioZrfpkNa1CYqKPjFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xj+ULuDOgp1HZDZU5rymWDHwcmrZX9hI9AhW7qGsKKtlT1YkfipjQSJ5/4MZB4nDB
         F6mJWhK3jTTjb9q66rpSqhVCnta3QeWaacHuF9LtUdhWdZOtJ1u/AebtJ1qlsGPQVx
         mKjJUEMK/Kre+MbuTGjvFd1qyGWJIbAeA3W2bfN0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuan Can <yuancan@huawei.com>,
        Thierry Reding <treding@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 090/313] clk: tegra: tegra124-emc: Fix potential memory leak
Date:   Tue, 25 Jul 2023 12:44:03 +0200
Message-ID: <20230725104524.837597433@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
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

From: Yuan Can <yuancan@huawei.com>

[ Upstream commit 53a06e5924c0d43c11379a08c5a78529c3e61595 ]

The tegra and tegra needs to be freed in the error handling path, otherwise
it will be leaked.

Fixes: 2db04f16b589 ("clk: tegra: Add EMC clock driver")
Signed-off-by: Yuan Can <yuancan@huawei.com>
Link: https://lore.kernel.org/r/20221209094124.71043-1-yuancan@huawei.com
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/tegra/clk-emc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/tegra/clk-emc.c b/drivers/clk/tegra/clk-emc.c
index 0c1b83bedb73d..eb2411a4cd783 100644
--- a/drivers/clk/tegra/clk-emc.c
+++ b/drivers/clk/tegra/clk-emc.c
@@ -459,6 +459,7 @@ static int load_timings_from_dt(struct tegra_clk_emc *tegra,
 		err = load_one_timing_from_dt(tegra, timing, child);
 		if (err) {
 			of_node_put(child);
+			kfree(tegra->timings);
 			return err;
 		}
 
@@ -510,6 +511,7 @@ struct clk *tegra_clk_register_emc(void __iomem *base, struct device_node *np,
 		err = load_timings_from_dt(tegra, node, node_ram_code);
 		if (err) {
 			of_node_put(node);
+			kfree(tegra);
 			return ERR_PTR(err);
 		}
 	}
-- 
2.39.2



