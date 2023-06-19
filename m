Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1611735488
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjFSK44 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjFSK40 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:56:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D90B9
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:54:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AA6460B89
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC23C433C8;
        Mon, 19 Jun 2023 10:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172072;
        bh=kFJhTZ9+oXdU21YMdmh0LIx6yZn7YVMk1DiCeyEIBPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bM1NDLoU+baiUetdQPS8RCLDKNPcJQM4+jPaZKepzeI9e7oc6uNDgKzI26Tok2fIq
         DxHi07TltCfxAiJw2shkj3zB3DPtQPlwo8kJy0mKVoMOGK7gTPR0wdaYlJ0J4gDnz+
         xmM7xdVBq+MZJX6SovxD/xf0o52PV9MwSg8BBRc4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 26/89] irqchip/gic: Correctly validate OF quirk descriptors
Date:   Mon, 19 Jun 2023 12:30:14 +0200
Message-ID: <20230619102139.472634077@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102138.279161276@linuxfoundation.org>
References: <20230619102138.279161276@linuxfoundation.org>
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
index 02828a16979af..b8a10f2e72da7 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -29,6 +29,8 @@ void gic_enable_of_quirks(const struct device_node *np,
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



