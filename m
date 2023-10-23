Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBD87D3405
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjJWLgM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbjJWLgI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:36:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017C710EC
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:36:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EF2C433C8;
        Mon, 23 Oct 2023 11:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060963;
        bh=eOfBk1B9IotAPbTqbC8nuGLbXZgMEX9ErPn4nzrsSh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t/My5BHVZHzVgnrbMscfdROy8cuCGgi0A1ruAp1q0aMPmuDiw4N/7E+jk6RGiY+xn
         7qKZASGu+pLXQJKeTxWa+t9Bm26G8ra7INKR4Naju8/JZzJOZ7G0p5hF1tv296B2FE
         AqJpTjpKyS202UmOjGkRexwKXxKIol4r56ATJgos=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.15 028/137] ASoC: codecs: wcd938x: fix unbind tear down order
Date:   Mon, 23 Oct 2023 12:56:25 +0200
Message-ID: <20231023104821.951743050@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
References: <20231023104820.849461819@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan+linaro@kernel.org>

commit fa2f8a991ba4aa733ac1c3b1be0c86148aa4c52c upstream.

Make sure to deregister the component before tearing down the resources
it depends on during unbind().

Fixes: 16572522aece ("ASoC: codecs: wcd938x-sdw: add SoundWire driver")
Cc: stable@vger.kernel.org      # 5.14
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20231003155558.27079-3-johan+linaro@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/wcd938x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -4480,10 +4480,10 @@ static void wcd938x_unbind(struct device
 {
 	struct wcd938x_priv *wcd938x = dev_get_drvdata(dev);
 
+	snd_soc_unregister_component(dev);
 	device_link_remove(dev, wcd938x->txdev);
 	device_link_remove(dev, wcd938x->rxdev);
 	device_link_remove(wcd938x->rxdev, wcd938x->txdev);
-	snd_soc_unregister_component(dev);
 	component_unbind_all(dev, wcd938x);
 }
 


