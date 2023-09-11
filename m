Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8186979BFD2
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244451AbjIKWZE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240567AbjIKOr3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:47:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6663106
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:47:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38898C433C7;
        Mon, 11 Sep 2023 14:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443644;
        bh=yfKh7ZIrzaSMva6iEXkSnMOJZY0tJUkwLCalwCVSUMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FwFi22k4SXhlUMR0PMb7koSjOC6YCnZtnPnHKlauNP9faO2gIdp1cz3BlIaX8iK3v
         IT7T/AE6jwIWZzwI86Pn4X+mcHxIvccGVC2IjbUOwyRz6tg1lik7Q17oWWmN4RjBlf
         FmKZLX/Ph6Ze9pHo9yBx9XqUGt7nQAoSGwFSxTxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Jianhua <chris.zjh@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 423/737] clk: sunxi-ng: Modify mismatched function name
Date:   Mon, 11 Sep 2023 15:44:42 +0200
Message-ID: <20230911134702.419917088@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Jianhua <chris.zjh@huawei.com>

[ Upstream commit 075d9ca5b4e17f84fd1c744a405e69ec743be7f0 ]

No functional modification involved.

drivers/clk/sunxi-ng/ccu_mmc_timing.c:54: warning: expecting prototype for sunxi_ccu_set_mmc_timing_mode(). Prototype was for sunxi_ccu_get_mmc_timing_mode() instead

Fixes: f6f64ed868d3 ("clk: sunxi-ng: Add interface to query or configure MMC timing modes.")
Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/r/20230722153107.2078179-1-chris.zjh@huawei.com
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/sunxi-ng/ccu_mmc_timing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mmc_timing.c b/drivers/clk/sunxi-ng/ccu_mmc_timing.c
index 23a8d44e2449b..78919d7843bec 100644
--- a/drivers/clk/sunxi-ng/ccu_mmc_timing.c
+++ b/drivers/clk/sunxi-ng/ccu_mmc_timing.c
@@ -43,7 +43,7 @@ int sunxi_ccu_set_mmc_timing_mode(struct clk *clk, bool new_mode)
 EXPORT_SYMBOL_GPL(sunxi_ccu_set_mmc_timing_mode);
 
 /**
- * sunxi_ccu_set_mmc_timing_mode: Get the current MMC clock timing mode
+ * sunxi_ccu_get_mmc_timing_mode: Get the current MMC clock timing mode
  * @clk: clock to query
  *
  * Return: %0 if the clock is in old timing mode, > %0 if it is in
-- 
2.40.1



