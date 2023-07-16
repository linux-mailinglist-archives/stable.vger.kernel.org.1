Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF655755697
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjGPUwF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjGPUwB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:52:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69BDE57
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:52:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55EE060EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652F2C433C7;
        Sun, 16 Jul 2023 20:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540719;
        bh=Ybfm+uW9wEG43vjWIU7BJwKq6yzjsM/b07/vWWAee48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LFwnDxaVIXjK2HRi0ErJCI49okvuC3DPB5/YPuzLMJnGHsh9AKjahGb3KdByH4vwY
         5ZIMMBz5Bdt3AcKNFrq+EmJs3SYTCrL3XMPsen5G2pPE4CWhBtLeEYrhP27RzdD1pu
         nlbMnxBXljaNOZmDt+lgRnW9gtcyX+S7vs0WgHw4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 437/591] mfd: intel-lpss: Add missing check for platform_get_resource
Date:   Sun, 16 Jul 2023 21:49:36 +0200
Message-ID: <20230716194935.217743325@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit d918e0d5824495a75d00b879118b098fcab36fdb ]

Add the missing check for platform_get_resource and return error
if it fails.

Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/20230609014818.28475-1-jiasheng@iscas.ac.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/intel-lpss-acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
index a143c8dca2d93..212818aef93e2 100644
--- a/drivers/mfd/intel-lpss-acpi.c
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -183,6 +183,9 @@ static int intel_lpss_acpi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	info->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!info->mem)
+		return -ENODEV;
+
 	info->irq = platform_get_irq(pdev, 0);
 
 	ret = intel_lpss_probe(&pdev->dev, info);
-- 
2.39.2



