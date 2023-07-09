Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B668274C349
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjGILa3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjGILa2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:30:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD4813D
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:30:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5025F60BA4
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E126C433C8;
        Sun,  9 Jul 2023 11:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902226;
        bh=1aaewutBxzIn6IKsbdTxPhCBGDSaFB6Opf0SanHpfGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gVfZfViYgyYh7j7luIwrAzdcK5/PS10khhYrDW85728CqvRt42Sjn6Fkz5+3Zr9JK
         GPJX15QeJQjRh5B/TcWUJKw+ZEOwUAqqo3i+qihD2zbkK+VG0uLVBvC4ZxcmusKCbK
         +EoQ4bGVet9JcApPq7OKBXa/Dutr8py7gDX4+1iM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 300/431] clk: clocking-wizard: Fix Oops in clk_wzrd_register_divider()
Date:   Sun,  9 Jul 2023 13:14:08 +0200
Message-ID: <20230709111458.174377377@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 9c632a6396505a019ea6d12b5ab45e659a542a93 ]

Smatch detected this potential error pointer dereference
clk_wzrd_register_divider().  If devm_clk_hw_register() fails then
it sets "hw" to an error pointer and then dereferences it on the
next line.  Return the error directly instead.

Fixes: 5a853722eb32 ("staging: clocking-wizard: Add support for dynamic reconfiguration")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/f0e39b5c-4554-41e0-80d9-54ca3fabd060@kili.mountain
Reviewed-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
index eb1dfe7ecc1b4..4a23583933bcc 100644
--- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
@@ -354,7 +354,7 @@ static struct clk *clk_wzrd_register_divider(struct device *dev,
 	hw = &div->hw;
 	ret = devm_clk_hw_register(dev, hw);
 	if (ret)
-		hw = ERR_PTR(ret);
+		return ERR_PTR(ret);
 
 	return hw->clk;
 }
-- 
2.39.2



