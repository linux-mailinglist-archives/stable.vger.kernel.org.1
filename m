Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F7276128A
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbjGYLDq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbjGYLDV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:03:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DADD3C3C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:00:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F67F6166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF3FC433C7;
        Tue, 25 Jul 2023 11:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282840;
        bh=05I2kwzK1/93wu/K1lWGDmcZTLQczAulW51VBr1QS8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ezk6PQKhI44YmAbGtlWBSv5mW/66x6mnw7KXpbyfjT1EwvbQxMnqiORJfmTL81tkL
         6MwcESjz1H5MXvDKM2rDXrETX0hCWVc+AGafNN6ZnUWtxljQVY9L2lNNlMOU3WZI9s
         u7P2C1ILrI7Opi0QXRP/tQUkh1XiqRIeDh+ME8Lk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1 046/183] ASoC: codecs: wcd938x: fix missing mbhc init error handling
Date:   Tue, 25 Jul 2023 12:44:34 +0200
Message-ID: <20230725104509.622745800@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Johan Hovold <johan+linaro@kernel.org>

commit 7dfae2631bfbdebecd35fe7b472ab3cc95c9ed66 upstream.

MBHC initialisation can fail so add the missing error handling to avoid
dereferencing an error pointer when later configuring the jack:

    Unable to handle kernel paging request at virtual address fffffffffffffff8

    pc : wcd_mbhc_start+0x28/0x380 [snd_soc_wcd_mbhc]
    lr : wcd938x_codec_set_jack+0x28/0x48 [snd_soc_wcd938x]

    Call trace:
     wcd_mbhc_start+0x28/0x380 [snd_soc_wcd_mbhc]
     wcd938x_codec_set_jack+0x28/0x48 [snd_soc_wcd938x]
     snd_soc_component_set_jack+0x28/0x8c [snd_soc_core]
     qcom_snd_wcd_jack_setup+0x7c/0x19c [snd_soc_qcom_common]
     sc8280xp_snd_init+0x20/0x2c [snd_soc_sc8280xp]
     snd_soc_link_init+0x28/0x90 [snd_soc_core]
     snd_soc_bind_card+0x628/0xbfc [snd_soc_core]
     snd_soc_register_card+0xec/0x104 [snd_soc_core]
     devm_snd_soc_register_card+0x4c/0xa4 [snd_soc_core]
     sc8280xp_platform_probe+0xf0/0x108 [snd_soc_sc8280xp]

Fixes: bcee7ed09b8e ("ASoC: codecs: wcd938x: add Multi Button Headset Control support")
Cc: stable@vger.kernel.org      # 5.15
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20230703124701.11734-1-johan+linaro@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/wcd938x.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -2625,6 +2625,8 @@ static int wcd938x_mbhc_init(struct snd_
 						     WCD938X_IRQ_HPHR_OCP_INT);
 
 	wcd938x->wcd_mbhc = wcd_mbhc_init(component, &mbhc_cb, intr_ids, wcd_mbhc_fields, true);
+	if (IS_ERR(wcd938x->wcd_mbhc))
+		return PTR_ERR(wcd938x->wcd_mbhc);
 
 	snd_soc_add_component_controls(component, impedance_detect_controls,
 				       ARRAY_SIZE(impedance_detect_controls));


