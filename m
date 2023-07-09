Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F56474C2F0
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjGIL0a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjGIL03 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:26:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60741B0
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:26:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55D1C60BC9
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EB6C433C7;
        Sun,  9 Jul 2023 11:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901981;
        bh=10vdpd8yc/Z49wEfcmmZaV0rtId9V9cW2ioVw1xQh2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=el8Wl0gRqCNqPynG83WT8ud/uYGrntkp2eryKFUCaauOUVm2BkITQ75ZiJGql2nQ7
         QdMpI2HGy8juP2OSutc9VYG1BRAZ1CEnojiqw0AOIioV34Zt8KToty0xa0XS8vbsxP
         Fjng44Di84Yry0gQHZjGKEIj/Qc4TLBNd5c9auy4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Marek Vasut <marek.vasut+renesas@mailbox.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 185/431] clk: rs9: Fix .driver_data content in i2c_device_id
Date:   Sun,  9 Jul 2023 13:12:13 +0200
Message-ID: <20230709111455.516021356@linuxfoundation.org>
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



