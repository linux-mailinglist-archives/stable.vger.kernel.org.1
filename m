Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE9A7CA2B6
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjJPIxW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjJPIxV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:53:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC73DE1
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:53:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB03EC433C7;
        Mon, 16 Oct 2023 08:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446399;
        bh=cy43WK78YdkxLq3+X1yihi1UY1fB3E7mDcB/Dx+H9lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=spQC65qpAXNYrRMYlh1aej0plqI8/P5H/cDGgMUBYK5jIZmwi4XFa1fEvB8FSUoRl
         PGY+UtXMpeeiXaDWVDfZknfNMkAgLKCdzZfT9qjcUjFn2uoShnXLiqP0f6rCRRZpc5
         dEzmRmqy1P1F+dTmUUiHFdLCdSCiRP71H/B8wR4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1 022/131] ASoC: simple-card-utils: fixup simple_util_startup() error handling
Date:   Mon, 16 Oct 2023 10:40:05 +0200
Message-ID: <20231016084000.618464025@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 69cf63b6560205a390a736b88d112374655adb28 upstream.

It should use "goto" instead of "return"

Fixes: 5ca2ab459817 ("ASoC: simple-card-utils: Add new system-clock-fixed flag")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/202309141205.ITZeDJxV-lkp@intel.com/
Closes: https://lore.kernel.org/all/202309151840.au9Aa2W4-lkp@intel.com/
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87v8c76jnz.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/generic/simple-card-utils.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -331,7 +331,8 @@ int asoc_simple_startup(struct snd_pcm_s
 		if (fixed_sysclk % props->mclk_fs) {
 			dev_err(rtd->dev, "fixed sysclk %u not divisible by mclk_fs %u\n",
 				fixed_sysclk, props->mclk_fs);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto codec_err;
 		}
 		ret = snd_pcm_hw_constraint_minmax(substream->runtime, SNDRV_PCM_HW_PARAM_RATE,
 			fixed_rate, fixed_rate);


