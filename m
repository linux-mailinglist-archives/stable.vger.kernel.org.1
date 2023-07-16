Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1D3755228
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjGPUEa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjGPUEa (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:04:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5239D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:04:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5448060EA2
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FC9C433C7;
        Sun, 16 Jul 2023 20:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537868;
        bh=10vdpd8yc/Z49wEfcmmZaV0rtId9V9cW2ioVw1xQh2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1gBmlOIhaVDqP7cc/hPssXqS+482NToqi0S+VhFlcH43+/QXqJEi0h7o47/YagQCD
         kClujDdPOV2PVgcA1EXYB4QRDDP70HutjqMKEaJozMX53Z04rHrNQ/de/dVixMHucl
         gB/7J6JVtCh3uDq6i0F9HmQtm8sK0TpMiQ150g8c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Marek Vasut <marek.vasut+renesas@mailbox.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 250/800] clk: rs9: Fix .driver_data content in i2c_device_id
Date:   Sun, 16 Jul 2023 21:41:43 +0200
Message-ID: <20230716194954.906039454@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

[ Upstream commit ad527ca87e4ea42d7baad2ce710b44069287931b ]

The .driver_data content in i2c_device_id table must match the
.data content in of_device_id table, else device_get_match_data()
would return bogus value on i2c_device_id match. Align the two
tables.

The i2c_device_id table is now converted from of_device_id using
's@.compatible = "renesas,\([^"]\+"\), .data = \(.*\)@"\1, .driver_data = (kernel_ulong_t)\2@'

Fixes: 892e0ddea1aa ("clk: rs9: Add Renesas 9-series PCIe clock generator driver")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Link: https://lore.kernel.org/r/20230507133906.15061-3-marek.vasut+renesas@mailbox.org
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-renesas-pcie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-renesas-pcie.c b/drivers/clk/clk-renesas-pcie.c
index 10d31c222a1cb..6060cafe1aa22 100644
--- a/drivers/clk/clk-renesas-pcie.c
+++ b/drivers/clk/clk-renesas-pcie.c
@@ -392,8 +392,8 @@ static const struct rs9_chip_info renesas_9fgv0441_info = {
 };
 
 static const struct i2c_device_id rs9_id[] = {
-	{ "9fgv0241", .driver_data = RENESAS_9FGV0241 },
-	{ "9fgv0441", .driver_data = RENESAS_9FGV0441 },
+	{ "9fgv0241", .driver_data = (kernel_ulong_t)&renesas_9fgv0241_info },
+	{ "9fgv0441", .driver_data = (kernel_ulong_t)&renesas_9fgv0441_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rs9_id);
-- 
2.39.2



