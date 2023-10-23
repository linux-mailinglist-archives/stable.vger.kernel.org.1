Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED5A7D3401
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbjJWLgI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjJWLgF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:36:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B3510A
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:35:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62629C433CA;
        Mon, 23 Oct 2023 11:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060957;
        bh=Rd3nNFSurS5aBMiS36ox5AOV6zWQI2VUzTbY3dW2rxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wEyy4ecCvuMw7BMpmIifPV5xx2NZD1rxq9ZoUOKLmne8qhOFRPAYYNGKwfzdAVvzK
         8tFFMFVKtwbtLYwA3c4r73EBcpnSCDXTdDDvdHoh2myCeQd7oAWFdqO+03Rzpq4JnC
         e5ia0rgO5cLFp302nh/cwQbwqAjMzhVb0Upsxeog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.15 026/137] ASoC: codecs: wcd938x-sdw: fix runtime PM imbalance on probe errors
Date:   Mon, 23 Oct 2023 12:56:23 +0200
Message-ID: <20231023104821.864936309@linuxfoundation.org>
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

commit c5c0383082eace13da2ffceeea154db2780165e7 upstream.

Make sure to balance the runtime PM operations, including the disable
count, on probe errors and on driver unbind.

Fixes: 16572522aece ("ASoC: codecs: wcd938x-sdw: add SoundWire driver")
Cc: stable@vger.kernel.org      # 5.14
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20231003155558.27079-8-johan+linaro@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/wcd938x-sdw.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -266,7 +266,18 @@ static int wcd9380_probe(struct sdw_slav
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
-	return component_add(dev, &wcd938x_sdw_component_ops);
+	ret = component_add(dev, &wcd938x_sdw_component_ops);
+	if (ret)
+		goto err_disable_rpm;
+
+	return 0;
+
+err_disable_rpm:
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+
+	return ret;
 }
 
 static int wcd9380_remove(struct sdw_slave *pdev)
@@ -275,6 +286,10 @@ static int wcd9380_remove(struct sdw_sla
 
 	component_del(dev, &wcd938x_sdw_component_ops);
 
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+
 	return 0;
 }
 


