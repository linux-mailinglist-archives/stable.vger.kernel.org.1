Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBE074C2D4
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjGILZO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjGILZN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:25:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBE2130
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:25:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B1AD60BEB
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC50C433C8;
        Sun,  9 Jul 2023 11:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901911;
        bh=/f/qe/x5uw5guA6TWeQzDNDdWGfZFolipMOvbV/kCZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CGr3AD2CuYMFMhsxZsBycV2GlG9Pxpw1e+nZTJam3epJ1b+9/YsULqWRiDnI+/KmU
         fL5EnS57XTm6/qmwY/rmKQ/cSc8pU5zodbfhCgJCr0A+wQJC/kySECZMw0YgPH1nJY
         w8vtQhnqDR43YVcMFTqEPlMT5Mxdb9+p9tSwKJiQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Marek Vasut <marek.vasut+renesas@mailbox.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 181/431] clk: vc7: Fix .driver_data content in i2c_device_id
Date:   Sun,  9 Jul 2023 13:12:09 +0200
Message-ID: <20230709111455.424031257@linuxfoundation.org>
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

[ Upstream commit b5e10beeafaa3266559c582dde7534ae3fe8cefb ]

The .driver_data content in i2c_device_id table must match the
.data content in of_device_id table, else device_get_match_data()
would return bogus value on i2c_device_id match. Align the two
tables.

The i2c_device_id table is now converted from of_device_id using
's@.compatible = "renesas,\([^"]\+"\), .data = \(.*\)@"\1, .driver_data = (kernel_ulong_t)\2@'

Fixes: 48c5e98fedd9 ("clk: Renesas versaclock7 ccf device driver")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Link: https://lore.kernel.org/r/20230507133906.15061-2-marek.vasut+renesas@mailbox.org
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-versaclock7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-versaclock7.c b/drivers/clk/clk-versaclock7.c
index 8e4f86e852aa0..0ae191f50b4b2 100644
--- a/drivers/clk/clk-versaclock7.c
+++ b/drivers/clk/clk-versaclock7.c
@@ -1282,7 +1282,7 @@ static const struct regmap_config vc7_regmap_config = {
 };
 
 static const struct i2c_device_id vc7_i2c_id[] = {
-	{ "rc21008a", VC7_RC21008A },
+	{ "rc21008a", .driver_data = (kernel_ulong_t)&vc7_rc21008a_info },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, vc7_i2c_id);
-- 
2.39.2



