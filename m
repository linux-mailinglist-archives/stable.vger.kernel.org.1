Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7B973EA22
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjFZSnl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjFZSni (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:43:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828C1E3
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:43:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F56560F30
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B73C433C0;
        Mon, 26 Jun 2023 18:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687805016;
        bh=CfaFQfla770SxEg3zAb7vGI99dNkxPO+7hWJRkkffgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ce7IqLV1SO6rF45zzipImKEZys66Dg7GCSsPrRonmjP7lSnFTaMT3ucOyAjxABiJX
         qQPcsxVbTCN7fywDDjTq/DW1g5PLXqHDFskYxUF6BEC+HINvTYRaFW/6QZ6Qn1+tdo
         5nJzQ15u5/b/dbGJhgGk2t2+znLLhtA8uykcWrxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 21/81] regmap: spi-avmm: Fix regmap_bus max_raw_write
Date:   Mon, 26 Jun 2023 20:12:03 +0200
Message-ID: <20230626180745.339656657@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180744.453069285@linuxfoundation.org>
References: <20230626180744.453069285@linuxfoundation.org>
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

From: Russ Weight <russell.h.weight@intel.com>

[ Upstream commit c8e796895e2310b6130e7577248da1d771431a77 ]

The max_raw_write member of the regmap_spi_avmm_bus structure is defined
as:
	.max_raw_write = SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT

SPI_AVMM_VAL_SIZE == 4 and MAX_WRITE_CNT == 1 so this results in a
maximum write transfer size of 4 bytes which provides only enough space to
transfer the address of the target register. It provides no space for the
value to be transferred. This bug became an issue (divide-by-zero in
_regmap_raw_write()) after the following was accepted into mainline:

commit 3981514180c9 ("regmap: Account for register length when chunking")

Change max_raw_write to include space (4 additional bytes) for both the
register address and value:

	.max_raw_write = SPI_AVMM_REG_SIZE + SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT

Fixes: 7f9fb67358a2 ("regmap: add Intel SPI Slave to AVMM Bus Bridge support")
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Link: https://lore.kernel.org/r/20230620202824.380313-1-russell.h.weight@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap-spi-avmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-spi-avmm.c b/drivers/base/regmap/regmap-spi-avmm.c
index ad1da83e849fe..67f89937219c3 100644
--- a/drivers/base/regmap/regmap-spi-avmm.c
+++ b/drivers/base/regmap/regmap-spi-avmm.c
@@ -666,7 +666,7 @@ static const struct regmap_bus regmap_spi_avmm_bus = {
 	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
 	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
 	.max_raw_read = SPI_AVMM_VAL_SIZE * MAX_READ_CNT,
-	.max_raw_write = SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,
+	.max_raw_write = SPI_AVMM_REG_SIZE + SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,
 	.free_context = spi_avmm_bridge_ctx_free,
 };
 
-- 
2.39.2



