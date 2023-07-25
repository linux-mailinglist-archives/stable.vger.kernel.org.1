Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D489D761271
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjGYLCe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjGYLCT (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:02:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B21359DA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:59:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A73FA61693
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48DCC433C7;
        Tue, 25 Jul 2023 10:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282762;
        bh=GwBqOurlM2tcRF1iQQy1JmEMn2BDp1mQUdYiDLheDg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NZ6fqGbf3uh8dfcdesY2yhKoTBSrV6A925UPtn9VTfY4mY3IR/hgHsbOGs4/4KIeU
         efsRmvqb27Ale7CUpzEpggGBuaIR0sbMLskQk/gpr1S36GRMOaVr9IX/6vW042/sI5
         8VxtK2ze+DIzVLYCy5HjnLDh64G2l57l3KnGQR4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>, stable@kernel.org
Subject: [PATCH 6.1 018/183] regmap: Drop initial version of maximum transfer length fixes
Date:   Tue, 25 Jul 2023 12:44:06 +0200
Message-ID: <20230725104508.525444884@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
@@ -660,7 +660,7 @@ static const struct regmap_bus regmap_sp
 	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
 	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
 	.max_raw_read = SPI_AVMM_VAL_SIZE * MAX_READ_CNT,
-	.max_raw_write = SPI_AVMM_REG_SIZE + SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,
+	.max_raw_write = SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,
 	.free_context = spi_avmm_bridge_ctx_free,
 };
 
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2064,8 +2064,6 @@ int _regmap_raw_write(struct regmap *map
 	size_t val_count = val_len / val_bytes;
 	size_t chunk_count, chunk_bytes;
 	size_t chunk_regs = val_count;
-	size_t max_data = map->max_raw_write - map->format.reg_bytes -
-			map->format.pad_bytes;
 	int ret, i;
 
 	if (!val_count)
@@ -2073,8 +2071,8 @@ int _regmap_raw_write(struct regmap *map
 
 	if (map->use_single_write)
 		chunk_regs = 1;
-	else if (map->max_raw_write && val_len > max_data)
-		chunk_regs = max_data / val_bytes;
+	else if (map->max_raw_write && val_len > map->max_raw_write)
+		chunk_regs = map->max_raw_write / val_bytes;
 
 	chunk_count = val_count / chunk_regs;
 	chunk_bytes = chunk_regs * val_bytes;


