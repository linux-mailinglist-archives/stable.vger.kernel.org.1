Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7D3761286
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbjGYLDi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbjGYLDO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:03:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCC0422F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:00:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D55EB61692
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14FEC433C7;
        Tue, 25 Jul 2023 11:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282832;
        bh=tw+DjXXLppjdV7VzR4ztWLAsfVm72/NGBJggAufUS40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=08YQxg9wD8fe2/NtVbs8c4RN1CgjQvmXEUswx/DR+4nUe/XdHyPA/3iJfU2+e2Eq5
         eVSeFK1j+FTFXlSrqBD6pDJNJOBBB6ipxwm/W4Ewiwq1IoFg3b+HMEk+ecVOHUOBfv
         xzzUnDVjSR8jBltQexVnWg78aMG5F/cg4C18OFIY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1 043/183] ASoC: qdsp6: audioreach: fix topology probe deferral
Date:   Tue, 25 Jul 2023 12:44:31 +0200
Message-ID: <20230725104509.497284609@linuxfoundation.org>
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

commit 46ec420573cefa1fc98025e7e6841bdafd6f1e20 upstream.

Propagate errors when failing to load the topology component so that
probe deferrals can be handled.

Fixes: 36ad9bf1d93d ("ASoC: qdsp6: audioreach: add topology support")
Cc: stable@vger.kernel.org      # 5.17
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20230705123018.30903-3-johan+linaro@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/qcom/qdsp6/topology.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -1100,8 +1100,8 @@ int audioreach_tplg_init(struct snd_soc_
 
 	ret = snd_soc_tplg_component_load(component, &audioreach_tplg_ops, fw);
 	if (ret < 0) {
-		dev_err(dev, "tplg component load failed%d\n", ret);
-		ret = -EINVAL;
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "tplg component load failed: %d\n", ret);
 	}
 
 	release_firmware(fw);


