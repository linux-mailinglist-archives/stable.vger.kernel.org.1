Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D89D761296
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjGYLEJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbjGYLDw (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:03:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0068448F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:01:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBB006168F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AFFC433C8;
        Tue, 25 Jul 2023 11:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282843;
        bh=PYZ24E6ZDFJRfuCgUGbQDtHOmvWNEBI5BdcBoLSRUWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zM1IYXnTMkl1lTfC7oyxPqQ2YY7ox8rRexuE2MedxaPxt2/in/t/hBWAmnQa0L1eN
         c9vHk+zd6Gq68EBJkhoUq0YQywxjOTcN1qQM7rkH57DpVlOKvte861u4nao8GOTblV
         ngWWrjfxHWU9Aur976yYlUpo73FjVGK6SN3hk4eA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1 047/183] ASoC: codecs: wcd934x: fix resource leaks on component remove
Date:   Tue, 25 Jul 2023 12:44:35 +0200
Message-ID: <20230725104509.668667571@linuxfoundation.org>
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

commit 798590cc7d3c2b5f3a7548d96dd4d8a081c1bc39 upstream.

Make sure to release allocated MBHC resources also on component remove.

This is specifically needed to allow probe deferrals of the sound card
which otherwise fails when reprobing the codec component.

Fixes: 9fb9b1690f0b ("ASoC: codecs: wcd934x: add mbhc support")
Cc: stable@vger.kernel.org      # 5.14
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20230705123018.30903-6-johan+linaro@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/wcd934x.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -3044,6 +3044,17 @@ static int wcd934x_mbhc_init(struct snd_
 
 	return 0;
 }
+
+static void wcd934x_mbhc_deinit(struct snd_soc_component *component)
+{
+	struct wcd934x_codec *wcd = snd_soc_component_get_drvdata(component);
+
+	if (!wcd->mbhc)
+		return;
+
+	wcd_mbhc_deinit(wcd->mbhc);
+}
+
 static int wcd934x_comp_probe(struct snd_soc_component *component)
 {
 	struct wcd934x_codec *wcd = dev_get_drvdata(component->dev);
@@ -3077,6 +3088,7 @@ static void wcd934x_comp_remove(struct s
 {
 	struct wcd934x_codec *wcd = dev_get_drvdata(comp->dev);
 
+	wcd934x_mbhc_deinit(comp);
 	wcd_clsh_ctrl_free(wcd->clsh_ctrl);
 }
 


