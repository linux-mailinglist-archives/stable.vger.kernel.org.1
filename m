Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB867D3100
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjJWLE1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbjJWLEV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:04:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92E510C7
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:04:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB68C433C8;
        Mon, 23 Oct 2023 11:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059059;
        bh=xsdPU5aw5ODszBlh5BFBypSUbZhTyFwAw9Q4LBwAdpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y80kT/xj6WETWjM5v2HNzgC6P93pVKb0pGkS16Kalhurau+jFUYxTNLGlt/d/0/dZ
         KOass6UlLVjMlD66GKCqZWBHxfe2fI05FccK7dGaPENbsy3pEs7H0rYXEMsgnqcjVq
         frOEuH6F1Ii0k8uWnFjXuPZqhDUyuhUznJkWrJRA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.5 049/241] ASoC: codecs: wcd938x: fix unbind tear down order
Date:   Mon, 23 Oct 2023 12:53:55 +0200
Message-ID: <20231023104835.107207826@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3504,10 +3504,10 @@ static void wcd938x_unbind(struct device
 {
 	struct wcd938x_priv *wcd938x = dev_get_drvdata(dev);
 
+	snd_soc_unregister_component(dev);
 	device_link_remove(dev, wcd938x->txdev);
 	device_link_remove(dev, wcd938x->rxdev);
 	device_link_remove(wcd938x->rxdev, wcd938x->txdev);
-	snd_soc_unregister_component(dev);
 	component_unbind_all(dev, wcd938x);
 }
 


