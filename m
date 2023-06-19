Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4EF73536B
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjFSKpe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjFSKo7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:44:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C4010F8
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:44:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12D9F60B88
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EC1C433C8;
        Mon, 19 Jun 2023 10:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171470;
        bh=CHbZjusSHvhm1S3FGdarnEpAyiu+RS/DEBMoN7yQXJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xfYoxy/4B5NbRs0y8P4ial0ew/2MzHTtwr4p30qQjcPJ0GpAFl9U3wb5LY4bhDPAe
         BV2qGO/e+NAgm0G1MUxumEGF/vm6dS/NUwsQWNV3i0QaRIhhrgfmPdyIIMe6EhSGT2
         caSXQ1uYCvQr1dRIhgkvf8P3xNiXLqkUc64QOJpU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 042/166] irqchip/gic: Correctly validate OF quirk descriptors
Date:   Mon, 19 Jun 2023 12:28:39 +0200
Message-ID: <20230619102156.753730948@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
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



