Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12E4755244
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjGPUFt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjGPUFt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:05:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B139D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:05:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D550660EA6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11AEC433C8;
        Sun, 16 Jul 2023 20:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537947;
        bh=SsQraP3BvkwqFHiG8wLrcDCdS8fyLrN2Cci99QmXN88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dW26KewhA5KuT8xfV8sGS/piG5NLhaGHB6nyTrjcqaFi0woRcIjC878L1XPmIWgFU
         q8SdCZJLk0HmW8XIUNT+Vx0xmBVSBWmaA4a8Y+du7zR0hFjKwn1LS0kl/Dq6PKA6nm
         e+26nHJ3Nm9Hsm+OztxYtrYNUGkADJZ2m/jtDJRc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Marek Vasut <marek.vasut+renesas@mailbox.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 248/800] clk: vc5: Fix .driver_data content in i2c_device_id
Date:   Sun, 16 Jul 2023 21:41:41 +0200
Message-ID: <20230716194954.861082717@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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
 drivers/clk/clk-versaclock5.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index fa71a57875ce8..5452471b7ba55 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -1271,14 +1271,14 @@ static const struct vc5_chip_info idt_5p49v6975_info = {
 };
 
 static const struct i2c_device_id vc5_id[] = {
-	{ "5p49v5923", .driver_data = IDT_VC5_5P49V5923 },
-	{ "5p49v5925", .driver_data = IDT_VC5_5P49V5925 },
-	{ "5p49v5933", .driver_data = IDT_VC5_5P49V5933 },
-	{ "5p49v5935", .driver_data = IDT_VC5_5P49V5935 },
-	{ "5p49v60", .driver_data = IDT_VC6_5P49V60 },
-	{ "5p49v6901", .driver_data = IDT_VC6_5P49V6901 },
-	{ "5p49v6965", .driver_data = IDT_VC6_5P49V6965 },
-	{ "5p49v6975", .driver_data = IDT_VC6_5P49V6975 },
+	{ "5p49v5923", .driver_data = (kernel_ulong_t)&idt_5p49v5923_info },
+	{ "5p49v5925", .driver_data = (kernel_ulong_t)&idt_5p49v5925_info },
+	{ "5p49v5933", .driver_data = (kernel_ulong_t)&idt_5p49v5933_info },
+	{ "5p49v5935", .driver_data = (kernel_ulong_t)&idt_5p49v5935_info },
+	{ "5p49v60", .driver_data = (kernel_ulong_t)&idt_5p49v60_info },
+	{ "5p49v6901", .driver_data = (kernel_ulong_t)&idt_5p49v6901_info },
+	{ "5p49v6965", .driver_data = (kernel_ulong_t)&idt_5p49v6965_info },
+	{ "5p49v6975", .driver_data = (kernel_ulong_t)&idt_5p49v6975_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, vc5_id);
-- 
2.39.2



