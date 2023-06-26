Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA0C73E765
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjFZSO4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjFZSOj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:14:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242F2E71
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:14:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B48FD60F3E
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD61C433C8;
        Mon, 26 Jun 2023 18:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803278;
        bh=D/QqrU7YWZuGFmv2FdUa+J1Abg/q6d98nuSNr+f5BXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cG/R0zFNJWS6nlkXVle0TfL4+zkxqeNYm2hUGKwaiCf6pKXWcvozo7WBfa71L7Xfv
         9NYZBSqxQuD/GrBQqzyBCRHpPNd7SmUj8q5rN/OA0Ct6zyKBz8F7u9WUGUHXY5uL+f
         L2yb2XSlDEQ43tOqIAgwdTLO7mdoXi6V9kdSoUCY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 09/26] mmc: mtk-sd: fix deferred probing
Date:   Mon, 26 Jun 2023 20:11:11 +0200
Message-ID: <20230626180734.010459039@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180733.699092073@linuxfoundation.org>
References: <20230626180733.699092073@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sergey Shtylyov <s.shtylyov@omp.ru>

[ Upstream commit 0c4dc0f054891a2cbde0426b0c0fdf232d89f47f ]

The driver overrides the error codes returned by platform_get_irq() to
-EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
permanently instead of the deferred probing. Switch to propagating the
error codes upstream.

Fixes: 208489032bdd ("mmc: mediatek: Add Mediatek MMC driver")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Link: https://lore.kernel.org/r/20230617203622.6812-4-s.shtylyov@omp.ru
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/mtk-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index e51a62cff5ecc..3c77469df73b1 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1663,7 +1663,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq < 0) {
-		ret = -EINVAL;
+		ret = host->irq;
 		goto host_free;
 	}
 
-- 
2.39.2



