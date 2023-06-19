Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F1B735275
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjFSKfR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjFSKe6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:34:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9757FE70
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:34:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 317EB60B73
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39875C433C0;
        Mon, 19 Jun 2023 10:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170885;
        bh=CHbZjusSHvhm1S3FGdarnEpAyiu+RS/DEBMoN7yQXJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M8RUDLewBXGU7qMNGW5ff8E5ShjI30pyxyB4Lrbia6/eJnSNp84lUND3XSGzahkpa
         zKBxE4IdwTsh87YT3mJbsSLfbmdPbyr5VNFlflNnCCZFKJ/A6PAF/bLbtSyFoWBCmB
         sT2uFVf1vu1NGdSKzqADTBR5HbkpuABEuN5F0Fps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 044/187] irqchip/gic: Correctly validate OF quirk descriptors
Date:   Mon, 19 Jun 2023 12:27:42 +0200
Message-ID: <20230619102159.744921039@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit 91539341a3b6e9c868024a4292455dae36e6f58c ]

When checking for OF quirks, make sure either 'compatible' or 'property'
is set, and give up otherwise.

This avoids non-OF quirks being randomly applied as they don't have any
of the OF data that need checking.

Cc: Douglas Anderson <dianders@chromium.org>
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Fixes: 44bd78dd2b88 ("irqchip/gic-v3: Disable pseudo NMIs on Mediatek devices w/ firmware issues")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-gic-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index de47b51cdadbe..afd6a1841715a 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -16,6 +16,8 @@ void gic_enable_of_quirks(const struct device_node *np,
 			  const struct gic_quirk *quirks, void *data)
 {
 	for (; quirks->desc; quirks++) {
+		if (!quirks->compatible && !quirks->property)
+			continue;
 		if (quirks->compatible &&
 		    !of_device_is_compatible(np, quirks->compatible))
 			continue;
-- 
2.39.2



