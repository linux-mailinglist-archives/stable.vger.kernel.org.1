Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526B578AC7E
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjH1Kkf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjH1KkK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:40:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2028493
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:40:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B311B6401D
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7481C433C8;
        Mon, 28 Aug 2023 10:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219207;
        bh=XeXUrf/6TXJ3USwPJFBXTSLF5Sxpnv3irm4WMxHGzq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pE+RP/xDe4CCOAgi35JQFgqF9Aokq1JjIhqUjrt6Wer05/U741zPclO73OptvS6zg
         vx7kqdaINFkgB1cY/3/zH401HyxQBVHnNN7OXy1D0oGYA2fS1VwMDNBq96LnDtuvDg
         l6AQ7/hzgr9DSmfjNX957TV+Yr5jGe5a1jjjb2Jo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Mark Brown <broonie@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 112/158] regmap: Account for register length in SMBus I/O limits
Date:   Mon, 28 Aug 2023 12:13:29 +0200
Message-ID: <20230828101201.076421926@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 0c9d2eb5e94792fe64019008a04d4df5e57625af ]

The SMBus I2C buses have limits on the size of transfers they can do but
do not factor in the register length meaning we may try to do a transfer
longer than our length limit, the core will not take care of this.
Future changes will factor this out into the core but there are a number
of users that assume current behaviour so let's just do something
conservative here.

This does not take account padding bits but practically speaking these
are very rarely if ever used on I2C buses given that they generally run
slowly enough to mean there's no issue.

Cc: stable@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Link: https://lore.kernel.org/r/20230712-regmap-max-transfer-v1-2-80e2aed22e83@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap-i2c.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -242,8 +242,8 @@ static int regmap_i2c_smbus_i2c_read(voi
 static struct regmap_bus regmap_i2c_smbus_i2c_block = {
 	.write = regmap_i2c_smbus_i2c_write,
 	.read = regmap_i2c_smbus_i2c_read,
-	.max_raw_read = I2C_SMBUS_BLOCK_MAX,
-	.max_raw_write = I2C_SMBUS_BLOCK_MAX,
+	.max_raw_read = I2C_SMBUS_BLOCK_MAX - 1,
+	.max_raw_write = I2C_SMBUS_BLOCK_MAX - 1,
 };
 
 static const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,


