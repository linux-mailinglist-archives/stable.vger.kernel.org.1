Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478F075552C
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjGPUiQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjGPUiP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:38:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16807AB
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:38:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DD6560EBD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68CFC433CB;
        Sun, 16 Jul 2023 20:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539894;
        bh=NwwHApb+1zXvG3FUvXx7Xcuk6OijOt8Ou/THKJj97E4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qkYYqKDPLJpcN3mjAs1p40Q16ys1DwOYqJuWBS46tPeaLJwJ4ezFNe2lhv7LEuaqu
         SNgLO02VYlYHM6LAe7JDIBy6p4jzWxWLF4mIoRDxIMGBA+Kf0NlWcPGWPXK1aNIlky
         WQvc4tqLxq9Y6I+XhflJ3Rp6ehNXYvVP+wJOg7Qs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Marek Vasut <marek.vasut+renesas@mailbox.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 162/591] clk: vc5: Fix .driver_data content in i2c_device_id
Date:   Sun, 16 Jul 2023 21:45:01 +0200
Message-ID: <20230716194928.056908095@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

[ Upstream commit be3471c5bd9b921c9adfab7948e8021611639164 ]

The .driver_data content in i2c_device_id table must match the
.data content in of_device_id table, else device_get_match_data()
would return bogus value on i2c_device_id match. Align the two
tables.

The i2c_device_id table is now converted from of_device_id using
's@.compatible = "idt,\([^"]\+"\), .data = \(.*\)@"\1, .driver_data = (kernel_ulong_t)\2@'

Fixes: 9adddb01ce5f ("clk: vc5: Add structure to describe particular chip features")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Link: https://lore.kernel.org/r/20230507133906.15061-1-marek.vasut+renesas@mailbox.org
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-versaclock5.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index abfe59ac4e487..5f2c9093c5b94 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -1255,13 +1255,13 @@ static const struct vc5_chip_info idt_5p49v6975_info = {
 };
 
 static const struct i2c_device_id vc5_id[] = {
-	{ "5p49v5923", .driver_data = IDT_VC5_5P49V5923 },
-	{ "5p49v5925", .driver_data = IDT_VC5_5P49V5925 },
-	{ "5p49v5933", .driver_data = IDT_VC5_5P49V5933 },
-	{ "5p49v5935", .driver_data = IDT_VC5_5P49V5935 },
-	{ "5p49v6901", .driver_data = IDT_VC6_5P49V6901 },
-	{ "5p49v6965", .driver_data = IDT_VC6_5P49V6965 },
-	{ "5p49v6975", .driver_data = IDT_VC6_5P49V6975 },
+	{ "5p49v5923", .driver_data = (kernel_ulong_t)&idt_5p49v5923_info },
+	{ "5p49v5925", .driver_data = (kernel_ulong_t)&idt_5p49v5925_info },
+	{ "5p49v5933", .driver_data = (kernel_ulong_t)&idt_5p49v5933_info },
+	{ "5p49v5935", .driver_data = (kernel_ulong_t)&idt_5p49v5935_info },
+	{ "5p49v6901", .driver_data = (kernel_ulong_t)&idt_5p49v6901_info },
+	{ "5p49v6965", .driver_data = (kernel_ulong_t)&idt_5p49v6965_info },
+	{ "5p49v6975", .driver_data = (kernel_ulong_t)&idt_5p49v6975_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, vc5_id);
-- 
2.39.2



