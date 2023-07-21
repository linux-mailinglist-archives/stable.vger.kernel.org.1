Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A7F75D26A
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjGUS7V (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjGUS7U (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:59:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C40030D0
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:59:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 124A161D80
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F4DC433C7;
        Fri, 21 Jul 2023 18:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965958;
        bh=bWAkDfDK2FZoit3t0CvM1Fh5j1tQCps5OwpjAk4ySL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gTDyjOlEkWu55uiedg4geXUKAlX4eeZwDjpe10HsSWUJjUiucJIR3VG0Hh05//MHc
         7Dqz8IBQFQPwkeB7cN05fP1Woz5e0fdVW7ALK693VX+3kKnTiTXSjSm8Pd3fNHzjKu
         UURDxwEB3qZMVgX9mOkp8UCBfYmGspbhkILs9ZaY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuan Can <yuancan@huawei.com>,
        Thierry Reding <treding@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 175/532] clk: tegra: tegra124-emc: Fix potential memory leak
Date:   Fri, 21 Jul 2023 18:01:19 +0200
Message-ID: <20230721160623.884520677@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
 drivers/clk/tegra/clk-tegra124-emc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra124-emc.c b/drivers/clk/tegra/clk-tegra124-emc.c
index 219c80653dbdb..2a6db04342815 100644
--- a/drivers/clk/tegra/clk-tegra124-emc.c
+++ b/drivers/clk/tegra/clk-tegra124-emc.c
@@ -464,6 +464,7 @@ static int load_timings_from_dt(struct tegra_clk_emc *tegra,
 		err = load_one_timing_from_dt(tegra, timing, child);
 		if (err) {
 			of_node_put(child);
+			kfree(tegra->timings);
 			return err;
 		}
 
@@ -515,6 +516,7 @@ struct clk *tegra124_clk_register_emc(void __iomem *base, struct device_node *np
 		err = load_timings_from_dt(tegra, node, node_ram_code);
 		if (err) {
 			of_node_put(node);
+			kfree(tegra);
 			return ERR_PTR(err);
 		}
 	}
-- 
2.39.2



