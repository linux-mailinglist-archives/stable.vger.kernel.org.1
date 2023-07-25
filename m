Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA49D761284
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjGYLDd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbjGYLDJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:03:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B51E420B
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:00:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4191561681
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A68C433C7;
        Tue, 25 Jul 2023 11:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282826;
        bh=WdatwkBH+sr+wCUTUUWc0mRmh5vHUpNkuCLz73eqFPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yufTGLFSw2x/6P11qM/lVQbZoEVCqRdn2fjG8J55ujTGZUjjiwNFnoh0u9OsKg3Dl
         KsN6kf0996sg/A4bbqzIdvEQsaMZGjmQmQyxuc9P48kbGKeSSQYrIJHungqu8dsCvS
         rULcZGR8tLTP/dsO/DapD2vd9Zu8D2XsAMOfw6Hg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1 041/183] ASoC: codecs: wcd938x: fix missing clsh ctrl error handling
Date:   Tue, 25 Jul 2023 12:44:29 +0200
Message-ID: <20230725104509.412419693@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
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

commit ed0dd9205bf69593edb495cb4b086dbae96a3f05 upstream.

Allocation of the clash control structure may fail so add the missing
error handling to avoid dereferencing an error pointer.

Fixes: 8d78602aa87a ("ASoC: codecs: wcd938x: add basic driver")
Cc: stable@vger.kernel.org	# 5.14
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20230705123018.30903-4-johan+linaro@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/wcd938x.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3090,6 +3090,10 @@ static int wcd938x_soc_codec_probe(struc
 						 WCD938X_ID_MASK);
 
 	wcd938x->clsh_info = wcd_clsh_ctrl_alloc(component, WCD938X);
+	if (IS_ERR(wcd938x->clsh_info)) {
+		pm_runtime_put(dev);
+		return PTR_ERR(wcd938x->clsh_info);
+	}
 
 	wcd938x_io_init(wcd938x);
 	/* Set all interrupts as edge triggered */


