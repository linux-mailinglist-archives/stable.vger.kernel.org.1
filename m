Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8507611AF
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjGYKyl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjGYKyL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:54:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96804489
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:52:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97E9D61655
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCE0C433C8;
        Tue, 25 Jul 2023 10:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282338;
        bh=DksLlr8wsk5KRKmTxgOGiE1oEHdd21RS7vPLPV5Uvt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lCTw7gG8+jm4DoeC2xO0xT481GgeafZhTc2qTyL8Ytr/M7Vk09/d/DgQT4SVJuiH9
         r4DAe4/8OaM1fSmi4IHJdJOpyBHVcqyvbwAafJk9+6zwJCY7pSoNupq4l5/s/Hx1kW
         FcsMURVMm6dcegsL+gJh5W6/GZctcil27Yzd6mtg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.4 066/227] ASoC: codecs: wcd938x: fix resource leaks on component remove
Date:   Tue, 25 Jul 2023 12:43:53 +0200
Message-ID: <20230725104517.483413116@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Johan Hovold <johan+linaro@kernel.org>

commit a3406f87775fee986876e03f93a84385f54d5999 upstream.

Make sure to release allocated resources on component probe failure and
on remove.

This is specifically needed to allow probe deferrals of the sound card
which otherwise fails when reprobing the codec component:

    snd-sc8280xp sound: ASoC: failed to instantiate card -517
    genirq: Flags mismatch irq 289. 00002001 (HPHR PDM WD INT) vs. 00002001 (HPHR PDM WD INT)
    wcd938x_codec audio-codec: Failed to request HPHR WD interrupt (-16)
    genirq: Flags mismatch irq 290. 00002001 (HPHL PDM WD INT) vs. 00002001 (HPHL PDM WD INT)
    wcd938x_codec audio-codec: Failed to request HPHL WD interrupt (-16)
    genirq: Flags mismatch irq 291. 00002001 (AUX PDM WD INT) vs. 00002001 (AUX PDM WD INT)
    wcd938x_codec audio-codec: Failed to request Aux WD interrupt (-16)
    genirq: Flags mismatch irq 292. 00002001 (mbhc sw intr) vs. 00002001 (mbhc sw intr)
    wcd938x_codec audio-codec: Failed to request mbhc interrupts -16

Fixes: 8d78602aa87a ("ASoC: codecs: wcd938x: add basic driver")
Cc: stable@vger.kernel.org	# 5.14
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20230705123018.30903-5-johan+linaro@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/wcd938x.c |   55 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 7 deletions(-)

--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -2633,6 +2633,14 @@ static int wcd938x_mbhc_init(struct snd_
 
 	return 0;
 }
+
+static void wcd938x_mbhc_deinit(struct snd_soc_component *component)
+{
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+
+	wcd_mbhc_deinit(wcd938x->wcd_mbhc);
+}
+
 /* END MBHC */
 
 static const struct snd_kcontrol_new wcd938x_snd_controls[] = {
@@ -3113,20 +3121,26 @@ static int wcd938x_soc_codec_probe(struc
 	ret = request_threaded_irq(wcd938x->hphr_pdm_wd_int, NULL, wcd938x_wd_handle_irq,
 				   IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 				   "HPHR PDM WD INT", wcd938x);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "Failed to request HPHR WD interrupt (%d)\n", ret);
+		goto err_free_clsh_ctrl;
+	}
 
 	ret = request_threaded_irq(wcd938x->hphl_pdm_wd_int, NULL, wcd938x_wd_handle_irq,
 				   IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 				   "HPHL PDM WD INT", wcd938x);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "Failed to request HPHL WD interrupt (%d)\n", ret);
+		goto err_free_hphr_pdm_wd_int;
+	}
 
 	ret = request_threaded_irq(wcd938x->aux_pdm_wd_int, NULL, wcd938x_wd_handle_irq,
 				   IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 				   "AUX PDM WD INT", wcd938x);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "Failed to request Aux WD interrupt (%d)\n", ret);
+		goto err_free_hphl_pdm_wd_int;
+	}
 
 	/* Disable watchdog interrupt for HPH and AUX */
 	disable_irq_nosync(wcd938x->hphr_pdm_wd_int);
@@ -3141,7 +3155,7 @@ static int wcd938x_soc_codec_probe(struc
 			dev_err(component->dev,
 				"%s: Failed to add snd ctrls for variant: %d\n",
 				__func__, wcd938x->variant);
-			goto err;
+			goto err_free_aux_pdm_wd_int;
 		}
 		break;
 	case WCD9385:
@@ -3151,7 +3165,7 @@ static int wcd938x_soc_codec_probe(struc
 			dev_err(component->dev,
 				"%s: Failed to add snd ctrls for variant: %d\n",
 				__func__, wcd938x->variant);
-			goto err;
+			goto err_free_aux_pdm_wd_int;
 		}
 		break;
 	default:
@@ -3159,12 +3173,38 @@ static int wcd938x_soc_codec_probe(struc
 	}
 
 	ret = wcd938x_mbhc_init(component);
-	if (ret)
+	if (ret) {
 		dev_err(component->dev,  "mbhc initialization failed\n");
-err:
+		goto err_free_aux_pdm_wd_int;
+	}
+
+	return 0;
+
+err_free_aux_pdm_wd_int:
+	free_irq(wcd938x->aux_pdm_wd_int, wcd938x);
+err_free_hphl_pdm_wd_int:
+	free_irq(wcd938x->hphl_pdm_wd_int, wcd938x);
+err_free_hphr_pdm_wd_int:
+	free_irq(wcd938x->hphr_pdm_wd_int, wcd938x);
+err_free_clsh_ctrl:
+	wcd_clsh_ctrl_free(wcd938x->clsh_info);
+
 	return ret;
 }
 
+static void wcd938x_soc_codec_remove(struct snd_soc_component *component)
+{
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+
+	wcd938x_mbhc_deinit(component);
+
+	free_irq(wcd938x->aux_pdm_wd_int, wcd938x);
+	free_irq(wcd938x->hphl_pdm_wd_int, wcd938x);
+	free_irq(wcd938x->hphr_pdm_wd_int, wcd938x);
+
+	wcd_clsh_ctrl_free(wcd938x->clsh_info);
+}
+
 static int wcd938x_codec_set_jack(struct snd_soc_component *comp,
 				  struct snd_soc_jack *jack, void *data)
 {
@@ -3181,6 +3221,7 @@ static int wcd938x_codec_set_jack(struct
 static const struct snd_soc_component_driver soc_codec_dev_wcd938x = {
 	.name = "wcd938x_codec",
 	.probe = wcd938x_soc_codec_probe,
+	.remove = wcd938x_soc_codec_remove,
 	.controls = wcd938x_snd_controls,
 	.num_controls = ARRAY_SIZE(wcd938x_snd_controls),
 	.dapm_widgets = wcd938x_dapm_widgets,


