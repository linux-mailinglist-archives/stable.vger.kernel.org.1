Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951E574C383
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjGILdJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjGILcv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:32:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12AE95
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:32:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 668B360BC9
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77536C433C7;
        Sun,  9 Jul 2023 11:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902369;
        bh=uZg6siGsGP9BPVl8qb5HcCYYE05B4Iy6rUl/9DaK99w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VvX7qvyUl12TE4BU8JvrbTN+e+xGTmXvFWeF5hGI27s7hRCaR97TXx8LMa9VVW4hY
         vdkCUrdZ07DZOrbYZOufsKj9v99GASiDIP8cJFCOkzAVp1t6uxU6ocmad1ZRtRgkrv
         TrqYlrl8kw73/UYA+iE7RTKrFZOt8tXRpHmj49aU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 334/431] ASoC: amd: acp: clear pdm dma interrupt mask
Date:   Sun,  9 Jul 2023 13:14:42 +0200
Message-ID: <20230709111459.003758200@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Syed Saba Kareem <Syed.SabaKareem@amd.com>

[ Upstream commit ad60672394bd1f95c58d3d9336902f47e05126fc ]

Clear pdm dma interrupt mask in acp_dmic_shutdown().

'Fixes: c32bd332ce5c9 ("ASoC: amd: acp: Add generic support for
PDM controller on ACP")'

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Link: https://lore.kernel.org/r/Message-Id: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/acp/acp-pdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-pdm.c b/sound/soc/amd/acp/acp-pdm.c
index 66ec6b6a59723..f8030b79ac17c 100644
--- a/sound/soc/amd/acp/acp-pdm.c
+++ b/sound/soc/amd/acp/acp-pdm.c
@@ -176,7 +176,7 @@ static void acp_dmic_dai_shutdown(struct snd_pcm_substream *substream,
 
 	/* Disable DMIC interrupts */
 	ext_int_ctrl = readl(ACP_EXTERNAL_INTR_CNTL(adata, 0));
-	ext_int_ctrl |= ~PDM_DMA_INTR_MASK;
+	ext_int_ctrl &= ~PDM_DMA_INTR_MASK;
 	writel(ext_int_ctrl, ACP_EXTERNAL_INTR_CNTL(adata, 0));
 }
 
-- 
2.39.2



