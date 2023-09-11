Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A52E79BD6F
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243091AbjIKU7E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242210AbjIKPZI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:25:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9891D8
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:25:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DFEC433C8;
        Mon, 11 Sep 2023 15:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445903;
        bh=D8hCW6mPzspbVYhBu9rDYiOTILa5EX+hWxjYJk3fU1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wpgUBf6g2R3QFA0bmsAxOA2Xvc/UFMzCeWI8zB1xWZO3Wr7k+cd+X5eHctAFxWh6b
         Stf4TNO4nNuAM8JFjwKJweAqTwVG3GFf2LH9Enu9SirD8hIMJh6X1iDBHsgFR4TCZY
         j8zfWCc5lXMw/J3V3BCm7J4Z80nkjMDa5Q6PlxW0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yi Yang <yiyang13@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 486/600] serial: tegra: handle clk prepare error in tegra_uart_hw_init()
Date:   Mon, 11 Sep 2023 15:48:39 +0200
Message-ID: <20230911134647.984805693@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yi Yang <yiyang13@huawei.com>

[ Upstream commit 5abd01145d0cc6cd1b7c2fe6ee0b9ea0fa13671e ]

In tegra_uart_hw_init(), the return value of clk_prepare_enable() should
be checked since it might fail.

Fixes: e9ea096dd225 ("serial: tegra: add serial driver")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
Link: https://lore.kernel.org/r/20230817105406.228674-1-yiyang13@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/serial-tegra.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index c08360212aa20..7aa2b5b67001d 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -999,7 +999,11 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	tup->ier_shadow = 0;
 	tup->current_baud = 0;
 
-	clk_prepare_enable(tup->uart_clk);
+	ret = clk_prepare_enable(tup->uart_clk);
+	if (ret) {
+		dev_err(tup->uport.dev, "could not enable clk\n");
+		return ret;
+	}
 
 	/* Reset the UART controller to clear all previous status.*/
 	reset_control_assert(tup->rst);
-- 
2.40.1



