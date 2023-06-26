Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE75F73EA3C
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjFZSoz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjFZSot (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:44:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCDAFA
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:44:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF0FD60F30
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DECC433CB;
        Mon, 26 Jun 2023 18:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687805087;
        bh=qrQU6NpOp3QV75NYJU9QNVl/eV6RJUlil7V54MGjNHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nEuysBZzgx1o2qz+hY/M5Ebbhqxi7W0bUoOv3358y0Kc7isEOm5jg3WiVBkV1MXzs
         SOC9d2Uy6Tae2n0jVbeKuaRh3S5+5mHUJdG6FgfeUIkI3AsQRDCP+eCNOvLjr5HiaY
         4/wbbLHbCfiATYv7tkHnAdxTGnop4ZrUFtOUGhq4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 46/81] mmc: owl: fix deferred probing
Date:   Mon, 26 Jun 2023 20:12:28 +0200
Message-ID: <20230626180746.359727609@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180744.453069285@linuxfoundation.org>
References: <20230626180744.453069285@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sergey Shtylyov <s.shtylyov@omp.ru>

[ Upstream commit 3c482e1e830d79b9be8afb900a965135c01f7893 ]

The driver overrides the error codes returned by platform_get_irq() to
-EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
permanently instead of the deferred probing. Switch to propagating the
error codes upstream.

Fixes: ff65ffe46d28 ("mmc: Add Actions Semi Owl SoCs SD/MMC driver")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Link: https://lore.kernel.org/r/20230617203622.6812-8-s.shtylyov@omp.ru
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/owl-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
index 3d4abf175b1d8..8a40cf8a92db7 100644
--- a/drivers/mmc/host/owl-mmc.c
+++ b/drivers/mmc/host/owl-mmc.c
@@ -640,7 +640,7 @@ static int owl_mmc_probe(struct platform_device *pdev)
 
 	owl_host->irq = platform_get_irq(pdev, 0);
 	if (owl_host->irq < 0) {
-		ret = -EINVAL;
+		ret = owl_host->irq;
 		goto err_release_channel;
 	}
 
-- 
2.39.2



