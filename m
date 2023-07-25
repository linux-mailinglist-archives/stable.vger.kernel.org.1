Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FA4761194
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjGYKxg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjGYKv7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:51:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D437D212D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:51:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B45DF6165C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A4AC433C9;
        Tue, 25 Jul 2023 10:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282277;
        bh=sB8sdujWmd6fVjrwSYp2RHiAsqzQgxgOzbntDtcbRDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJooWNZMx0AuGRaJIgEe6aKJt211c2K/3Kn08T2sAiK9WADh0Hz+1WeMIONx8IncB
         teqHm4Y+pdZB53J50XUg/LUACHwQvIHO+XnGtrztaFZ4xhQ6EvZIDImF9sm6ejX9At
         h62yV5PvCLArW52L5ecLeR2ofjvN+Tl89eallp+s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.4 064/227] ASoC: qdsp6: audioreach: fix topology probe deferral
Date:   Tue, 25 Jul 2023 12:43:51 +0200
Message-ID: <20230725104517.396627533@linuxfoundation.org>
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
@@ -1277,8 +1277,8 @@ int audioreach_tplg_init(struct snd_soc_
 
 	ret = snd_soc_tplg_component_load(component, &audioreach_tplg_ops, fw);
 	if (ret < 0) {
-		dev_err(dev, "tplg component load failed%d\n", ret);
-		ret = -EINVAL;
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "tplg component load failed: %d\n", ret);
 	}
 
 	release_firmware(fw);


