Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56CB73E9D3
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjFZSka (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjFZSk3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:40:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FFFDA
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:40:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5845260E8D
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A4CC433C0;
        Mon, 26 Jun 2023 18:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804826;
        bh=u5xE2e0AtMKewdHWZC5L5QuqURcKYupE/M+9imC+7YQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0aaFOLUHbXVvgnUVAum9AUtI0EdEuSgC2/sWQFGpwDsr0LqZVMgaFQM6jpPRjDL2h
         xw7yYIJcsSiNqdHjqQvXr6iKZpM5QdbWA52BXbVEx1sfCHyeBtVSscTgkrcRFqe0Kp
         QzmI9BV39w+4RiPJbYo76ZjbEtdr7xEhf0I3qTPU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 55/96] mmc: sh_mmcif: fix deferred probing
Date:   Mon, 26 Jun 2023 20:12:10 +0200
Message-ID: <20230626180749.255223262@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180746.943455203@linuxfoundation.org>
References: <20230626180746.943455203@linuxfoundation.org>
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

[ Upstream commit 5b067d7f855c61df7f8e2e8ccbcee133c282415e ]

The driver overrides the error codes returned by platform_get_irq() to
-ENXIO, so if it returns -EPROBE_DEFER, the driver will fail the probe
permanently instead of the deferred probing. Switch to propagating the
error codes upstream.

Fixes: 9ec36cafe43b ("of/irq: do irq resolution in platform_get_irq")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Link: https://lore.kernel.org/r/20230617203622.6812-11-s.shtylyov@omp.ru
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sh_mmcif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index bcc595c70a9fb..e12fe29b275c2 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1398,7 +1398,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	irq[0] = platform_get_irq(pdev, 0);
 	irq[1] = platform_get_irq_optional(pdev, 1);
 	if (irq[0] < 0)
-		return -ENXIO;
+		return irq[0];
 
 	reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg))
-- 
2.39.2



