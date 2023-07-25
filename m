Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2717611BC
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjGYKzh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjGYKzG (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:55:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D385D30D8
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:53:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB9166166F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE18BC433C8;
        Tue, 25 Jul 2023 10:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282360;
        bh=gsqR/Q+5vVYY4oDeA8IFdrUxI7ZAFi4fmbx+UrzjTXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I00hCFm5piZ5glImPhksLCsIYDVIUxGKS/FOMP0nWZrbLz8cl0HHMQpbJTT5s82dn
         3FT9QwyT5vSarhlRDaX8GcNTA/l87UiMlMbxOp8pv4MAo6DzYzaXr/XrA7VFAfcp55
         dDOcvFtB/tFBEyAjtA7ueRZa51uvpZO3dB3ULtrY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.4 063/227] ASoC: codecs: wcd-mbhc-v2: fix resource leaks on component remove
Date:   Tue, 25 Jul 2023 12:43:50 +0200
Message-ID: <20230725104517.354771990@linuxfoundation.org>
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

commit a5475829adcc600bc69ee9ff7c9e3e43fb4f8d30 upstream.

The MBHC resources must be released on component probe failure and
removal so can not be tied to the lifetime of the component device.

This is specifically needed to allow probe deferrals of the sound card
which otherwise fails when reprobing the codec component:

    snd-sc8280xp sound: ASoC: failed to instantiate card -517
    genirq: Flags mismatch irq 299. 00002001 (mbhc sw intr) vs. 00002001 (mbhc sw intr)
    wcd938x_codec audio-codec: Failed to request mbhc interrupts -16
    wcd938x_codec audio-codec: mbhc initialization failed
    wcd938x_codec audio-codec: ASoC: error at snd_soc_component_probe on audio-codec: -16
    snd-sc8280xp sound: ASoC: failed to instantiate card -16

Fixes: 0e5c9e7ff899 ("ASoC: codecs: wcd: add multi button Headset detection support")
Cc: stable@vger.kernel.org      # 5.14
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20230705123018.30903-7-johan+linaro@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/wcd-mbhc-v2.c |   57 +++++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 16 deletions(-)

--- a/sound/soc/codecs/wcd-mbhc-v2.c
+++ b/sound/soc/codecs/wcd-mbhc-v2.c
@@ -1454,7 +1454,7 @@ struct wcd_mbhc *wcd_mbhc_init(struct sn
 		return ERR_PTR(-EINVAL);
 	}
 
-	mbhc = devm_kzalloc(dev, sizeof(*mbhc), GFP_KERNEL);
+	mbhc = kzalloc(sizeof(*mbhc), GFP_KERNEL);
 	if (!mbhc)
 		return ERR_PTR(-ENOMEM);
 
@@ -1474,61 +1474,76 @@ struct wcd_mbhc *wcd_mbhc_init(struct sn
 
 	INIT_WORK(&mbhc->correct_plug_swch, wcd_correct_swch_plug);
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->mbhc_sw_intr, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->mbhc_sw_intr, NULL,
 					wcd_mbhc_mech_plug_detect_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"mbhc sw intr", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_mbhc;
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->mbhc_btn_press_intr, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->mbhc_btn_press_intr, NULL,
 					wcd_mbhc_btn_press_handler,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"Button Press detect", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_sw_intr;
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->mbhc_btn_release_intr, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->mbhc_btn_release_intr, NULL,
 					wcd_mbhc_btn_release_handler,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"Button Release detect", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_btn_press_intr;
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->mbhc_hs_ins_intr, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->mbhc_hs_ins_intr, NULL,
 					wcd_mbhc_adc_hs_ins_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"Elect Insert", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_btn_release_intr;
 
 	disable_irq_nosync(mbhc->intr_ids->mbhc_hs_ins_intr);
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->mbhc_hs_rem_intr, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->mbhc_hs_rem_intr, NULL,
 					wcd_mbhc_adc_hs_rem_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"Elect Remove", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_hs_ins_intr;
 
 	disable_irq_nosync(mbhc->intr_ids->mbhc_hs_rem_intr);
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->hph_left_ocp, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->hph_left_ocp, NULL,
 					wcd_mbhc_hphl_ocp_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"HPH_L OCP detect", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_hs_rem_intr;
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->hph_right_ocp, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->hph_right_ocp, NULL,
 					wcd_mbhc_hphr_ocp_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"HPH_R OCP detect", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_hph_left_ocp;
 
 	return mbhc;
-err:
+
+err_free_hph_left_ocp:
+	free_irq(mbhc->intr_ids->hph_left_ocp, mbhc);
+err_free_hs_rem_intr:
+	free_irq(mbhc->intr_ids->mbhc_hs_rem_intr, mbhc);
+err_free_hs_ins_intr:
+	free_irq(mbhc->intr_ids->mbhc_hs_ins_intr, mbhc);
+err_free_btn_release_intr:
+	free_irq(mbhc->intr_ids->mbhc_btn_release_intr, mbhc);
+err_free_btn_press_intr:
+	free_irq(mbhc->intr_ids->mbhc_btn_press_intr, mbhc);
+err_free_sw_intr:
+	free_irq(mbhc->intr_ids->mbhc_sw_intr, mbhc);
+err_free_mbhc:
+	kfree(mbhc);
+
 	dev_err(dev, "Failed to request mbhc interrupts %d\n", ret);
 
 	return ERR_PTR(ret);
@@ -1537,9 +1552,19 @@ EXPORT_SYMBOL(wcd_mbhc_init);
 
 void wcd_mbhc_deinit(struct wcd_mbhc *mbhc)
 {
+	free_irq(mbhc->intr_ids->hph_right_ocp, mbhc);
+	free_irq(mbhc->intr_ids->hph_left_ocp, mbhc);
+	free_irq(mbhc->intr_ids->mbhc_hs_rem_intr, mbhc);
+	free_irq(mbhc->intr_ids->mbhc_hs_ins_intr, mbhc);
+	free_irq(mbhc->intr_ids->mbhc_btn_release_intr, mbhc);
+	free_irq(mbhc->intr_ids->mbhc_btn_press_intr, mbhc);
+	free_irq(mbhc->intr_ids->mbhc_sw_intr, mbhc);
+
 	mutex_lock(&mbhc->lock);
 	wcd_cancel_hs_detect_plug(mbhc,	&mbhc->correct_plug_swch);
 	mutex_unlock(&mbhc->lock);
+
+	kfree(mbhc);
 }
 EXPORT_SYMBOL(wcd_mbhc_deinit);
 


