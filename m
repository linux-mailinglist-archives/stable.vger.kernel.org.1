Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B7C75D269
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjGUS7S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjGUS7R (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:59:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D76330CF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:59:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B50D61D7C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D65BC433C8;
        Fri, 21 Jul 2023 18:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965955;
        bh=/pEUvOQqKqOct7Amivy8kjyacyn3ofp6ed/JZFI7Sp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G9teT3kuB0dO+7TqCZt7R4rYtXyJpvWFqDkU0K3+2FZX6VpPU/NtCPI8LAe82l8D6
         KlA3WUuZT0Nf5zkZAScvWhn5L8qJqBS06QYT3nHUnrHyYWjDUtxNvRTARbU76wH6DS
         HBQrh0v7RWpZVkiwx3UKmM61WOcdpXCqysh8MLdQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 174/532] clk: clocking-wizard: Fix Oops in clk_wzrd_register_divider()
Date:   Fri, 21 Jul 2023 18:01:18 +0200
Message-ID: <20230721160623.832880516@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
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
 drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c b/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
index 39367712ef540..8c1934df70dea 100644
--- a/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
+++ b/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
@@ -347,7 +347,7 @@ static struct clk *clk_wzrd_register_divider(struct device *dev,
 	hw = &div->hw;
 	ret = devm_clk_hw_register(dev, hw);
 	if (ret)
-		hw = ERR_PTR(ret);
+		return ERR_PTR(ret);
 
 	return hw->clk;
 }
-- 
2.39.2



