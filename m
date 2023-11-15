Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F4C7ECF39
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbjKOTrJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbjKOTrI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:47:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D07B8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:47:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD19C433CC;
        Wed, 15 Nov 2023 19:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077625;
        bh=8K5w4CUT6b3Q3ofKGlh0L0Q8SmH2HuYEjgZ0uEaKVU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xs+NjpishXR7ximZcxfoYibTgyMXGTCTCybgHuYkoZfCCg7EX5zuqBXd5uN2W2FyA
         rg0GzgcBWRPORmy4HuLJGSegvy9idNL9eAKiet/3tfc1xJUZcJCvd/VmZ0RmcZQ5oe
         IchINZLxBQ5VMDVKd+2ME/GbdQ7wtd3uDWj0HlE4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 396/603] ASoC: Intel: Skylake: Fix mem leak when parsing UUIDs fails
Date:   Wed, 15 Nov 2023 14:15:41 -0500
Message-ID: <20231115191640.488427899@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit 168d97844a61db302dec76d44406e9d4d7106b8e ]

Error path in snd_skl_parse_uuids() shall free last allocated module if
its instance_id allocation fails.

Fixes: f8e066521192 ("ASoC: Intel: Skylake: Fix uuid_module memory leak in failure case")
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20231026082558.1864910-1-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index 57ea815d3f041..b776c58dcf47a 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -299,6 +299,7 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
 		module->instance_id = devm_kzalloc(ctx->dev, size, GFP_KERNEL);
 		if (!module->instance_id) {
 			ret = -ENOMEM;
+			kfree(module);
 			goto free_uuid_list;
 		}
 
-- 
2.42.0



