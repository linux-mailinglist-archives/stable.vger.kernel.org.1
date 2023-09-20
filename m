Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEB07A7CC5
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbjITMEA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbjITMD5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:03:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7514B4
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:03:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19043C433C8;
        Wed, 20 Sep 2023 12:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211431;
        bh=DiVIDBvTQnbNZp1DWcNZhr9Bc69Ul26PEe6mK7x+WgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FVPXYwU0L44eSBJQohLJvEMWremMAnzpQ/IChOSLD5CfqZ1U8gSvUCDVtgaBEqRKx
         ilJTH5+AcPVEGRPs8jkmhlfv8uq6HFV47MNgV6g7XN3K4nGmxASHt4Ak32jgzfQ87T
         bre/Z4zy1Ngg+kDR4zmbXZbD+MnzyJ67iz44Iifw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yi Yang <yiyang13@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 091/186] serial: tegra: handle clk prepare error in tegra_uart_hw_init()
Date:   Wed, 20 Sep 2023 13:29:54 +0200
Message-ID: <20230920112840.207574157@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index a13d6d4674bcc..05e522be94669 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -827,7 +827,11 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
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



