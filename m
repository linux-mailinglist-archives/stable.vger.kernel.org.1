Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7807D3284
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbjJWLVC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbjJWLU7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:20:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3706FA4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:20:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C266C433C7;
        Mon, 23 Oct 2023 11:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060056;
        bh=nSYFRlvD9XKIAr3h7s8A0bIEJaCAtZEX52ZLdULCkTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PMGyxoEzuF63zfKR+mM2/Hk+Ery1A6n4ByzY+itspOJzoK7HIjKYd7z0bEW/oqMhV
         MF/odCWfH2hPf1rgEn2FRyQ45UaaqRFILiXjCHcBWmmnBh5IA+zacKCLPL1LN1gRdl
         9wkS1N7nXfbxNg2/WtSmcT8+buVueaVdeQ/1b4YE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1 043/196] ASoC: codecs: wcd938x: drop bogus bind error handling
Date:   Mon, 23 Oct 2023 12:55:08 +0200
Message-ID: <20231023104829.729399178@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan+linaro@kernel.org>

commit bfbc79de60c53e5fed505390440b87ef59ee268c upstream.

Drop the bogus error handling for a soundwire device backcast during
bind() that cannot fail.

Fixes: 16572522aece ("ASoC: codecs: wcd938x-sdw: add SoundWire driver")
Cc: stable@vger.kernel.org      # 5.14
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20231003155558.27079-2-johan+linaro@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/wcd938x.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3454,10 +3454,6 @@ static int wcd938x_bind(struct device *d
 	wcd938x->sdw_priv[AIF1_CAP] = dev_get_drvdata(wcd938x->txdev);
 	wcd938x->sdw_priv[AIF1_CAP]->wcd938x = wcd938x;
 	wcd938x->tx_sdw_dev = dev_to_sdw_dev(wcd938x->txdev);
-	if (!wcd938x->tx_sdw_dev) {
-		dev_err(dev, "could not get txslave with matching of dev\n");
-		return -EINVAL;
-	}
 
 	/* As TX is main CSR reg interface, which should not be suspended first.
 	 * expicilty add the dependency link */


