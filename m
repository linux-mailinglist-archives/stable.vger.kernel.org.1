Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7849472C125
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbjFLK4k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbjFLK4Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:56:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EDFA864
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:44:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45868615CB
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E43C4339B;
        Mon, 12 Jun 2023 10:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566647;
        bh=ZmUaaXT7VrsTT+oBEVLg1mVfw4WlHlUAyC9bKJZIVnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UGQJJdQwS57qVTPIZgOIbCmrt3zmn9Nuph753AjaHEIgL1jHd+pZmhLMT2GuXeYQG
         fuFPXkBm1BFPzKphqVdvg3rGAa5SzZ1e+Pus7UQa24vpvPVD1/E3v1/ojBj7KLVye6
         1GslLFH2CZUAk8pWi06ny/NwKSl3dwN7XiumH6yg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 104/132] ASoC: codecs: wsa883x: do not set can_multi_write flag
Date:   Mon, 12 Jun 2023 12:27:18 +0200
Message-ID: <20230612101715.039212268@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
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

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit 40ba0411074485e2cf1bf8ee0f3db27bdff88394 ]

regmap-sdw does not support multi register writes, so there is
no point in setting this flag. This also leads to incorrect
programming of WSA codecs with regmap_multi_reg_write() call.

This invalid configuration should have been rejected by regmap-sdw.

Fixes: 43b8c7dc85a1 ("ASoC: codecs: add wsa883x amplifier support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20230523154605.4284-1-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wsa883x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index 6e9a64c5948e2..b152f4e5c4f2b 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -950,7 +950,6 @@ static struct regmap_config wsa883x_regmap_config = {
 	.writeable_reg = wsa883x_writeable_register,
 	.reg_format_endian = REGMAP_ENDIAN_NATIVE,
 	.val_format_endian = REGMAP_ENDIAN_NATIVE,
-	.can_multi_write = true,
 	.use_single_read = true,
 };
 
-- 
2.39.2



