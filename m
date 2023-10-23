Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FA77D30FC
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjJWLES (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjJWLEM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:04:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCD8170B
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:04:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C68C433B6;
        Mon, 23 Oct 2023 11:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059047;
        bh=cBGSD1Qu3cy5AbPY2tEiz/9sNQV7lklGlR0tAxig00w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zkN+Jb4b7F4XARxSmsYKN/awhx/xio2PzQ/I7QgrEkAUPbemM8Z4UBrD3G04X3sda
         ZKKJR9+n7iSjDomJltSmhv4e5cjhqwyYSp71eQ2SsGTBfBboDMaFh6l8f1Af+wjBTQ
         +XvVZ1QbcsldWPMOll8k5gaZCVWzFjZkaNGL7WB0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.5 046/241] ASoC: codecs: wcd938x-sdw: fix use after free on driver unbind
Date:   Mon, 23 Oct 2023 12:53:52 +0200
Message-ID: <20231023104835.036065548@linuxfoundation.org>
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

commit f0dfdcbe706462495d47982eecd13a61aabd644d upstream.

Make sure to deregister the component when the driver is being unbound
and before the underlying device-managed resources are freed.

Fixes: 16572522aece ("ASoC: codecs: wcd938x-sdw: add SoundWire driver")
Cc: stable@vger.kernel.org      # 5.14
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20231003155558.27079-7-johan+linaro@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/wcd938x-sdw.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -1281,6 +1281,15 @@ static int wcd9380_probe(struct sdw_slav
 	return component_add(dev, &wcd938x_sdw_component_ops);
 }
 
+static int wcd9380_remove(struct sdw_slave *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	component_del(dev, &wcd938x_sdw_component_ops);
+
+	return 0;
+}
+
 static const struct sdw_device_id wcd9380_slave_id[] = {
 	SDW_SLAVE_ENTRY(0x0217, 0x10d, 0),
 	{},
@@ -1320,6 +1329,7 @@ static const struct dev_pm_ops wcd938x_s
 
 static struct sdw_driver wcd9380_codec_driver = {
 	.probe	= wcd9380_probe,
+	.remove	= wcd9380_remove,
 	.ops = &wcd9380_slave_ops,
 	.id_table = wcd9380_slave_id,
 	.driver = {


