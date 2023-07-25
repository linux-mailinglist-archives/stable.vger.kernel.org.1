Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6739F7615A8
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbjGYLbm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbjGYLbl (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:31:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39811BC5
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:31:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D468461683
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E595CC433C8;
        Tue, 25 Jul 2023 11:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284693;
        bh=E9+dGMy3fJodDACSOm+ZWJKZ5Nc0pVVZC4430Oytqqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uLQy6ZU16X7d9BSH8EnFZC0h0T/rXgrn8gt7Bu8TsulI33r3/dMh1wLJpv57TQ0ro
         xHdjX5V9Qr9EexE/LrPX4iApRPQqjDzeMzawHC6vrY8otOaGpmedKb5uSJpoliZPaM
         xDuiUX0X4V+6A1qv1f1iKLAgjbb0l8D28VAiicEc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>, stable@kernel.org
Subject: [PATCH 5.10 448/509] regmap: Drop initial version of maximum transfer length fixes
Date:   Tue, 25 Jul 2023 12:46:27 +0200
Message-ID: <20230725104614.258303721@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
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

From: Mark Brown <broonie@kernel.org>

commit bc64734825c59e18a27ac266b07e14944c111fd8 upstream.

When problems were noticed with the register address not being taken
into account when limiting raw transfers with I2C devices we fixed this
in the core.  Unfortunately it has subsequently been realised that a lot
of buses were relying on the prior behaviour, partly due to unclear
documentation not making it obvious what was intended in the core.  This
is all more involved to fix than is sensible for a fix commit so let's
just drop the original fixes, a separate commit will fix the originally
observed problem in an I2C specific way

Fixes: 3981514180c9 ("regmap: Account for register length when chunking")
Fixes: c8e796895e23 ("regmap: spi-avmm: Fix regmap_bus max_raw_write")
Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Cc: stable@kernel.org
Link: https://lore.kernel.org/r/20230712-regmap-max-transfer-v1-1-80e2aed22e83@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/regmap/regmap-spi-avmm.c |    2 +-
 drivers/base/regmap/regmap.c          |    6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/base/regmap/regmap-spi-avmm.c
+++ b/drivers/base/regmap/regmap-spi-avmm.c
@@ -666,7 +666,7 @@ static const struct regmap_bus regmap_sp
 	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
 	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
 	.max_raw_read = SPI_AVMM_VAL_SIZE * MAX_READ_CNT,
-	.max_raw_write = SPI_AVMM_REG_SIZE + SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,
+	.max_raw_write = SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,
 	.free_context = spi_avmm_bridge_ctx_free,
 };
 
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1998,8 +1998,6 @@ int _regmap_raw_write(struct regmap *map
 	size_t val_count = val_len / val_bytes;
 	size_t chunk_count, chunk_bytes;
 	size_t chunk_regs = val_count;
-	size_t max_data = map->max_raw_write - map->format.reg_bytes -
-			map->format.pad_bytes;
 	int ret, i;
 
 	if (!val_count)
@@ -2007,8 +2005,8 @@ int _regmap_raw_write(struct regmap *map
 
 	if (map->use_single_write)
 		chunk_regs = 1;
-	else if (map->max_raw_write && val_len > max_data)
-		chunk_regs = max_data / val_bytes;
+	else if (map->max_raw_write && val_len > map->max_raw_write)
+		chunk_regs = map->max_raw_write / val_bytes;
 
 	chunk_count = val_count / chunk_regs;
 	chunk_bytes = chunk_regs * val_bytes;


