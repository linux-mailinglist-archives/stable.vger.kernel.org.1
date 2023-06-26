Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD28A73E7BD
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjFZSSV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjFZSSU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:18:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7367294
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:18:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 112D260F40
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCC2C433C8;
        Mon, 26 Jun 2023 18:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803498;
        bh=vqIqFnWSJE0E90bomROB1dnMkiZREdqIziRgYD7M7P4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yde1389JG6vNeoRPcx/NATa/T8BB0a3ma6ZMv3EJCPC+BOKDg1wSAV5QNTw2Y20ZL
         2Yf9z2SDdKC0UkUHA6ojXTG42fk6/wGXJOULxbJsV/UuLNIjUmkns2F/onvO/AYdWN
         ApmshiSsaAvm9qt4tNCHNy7WFC4tCzex/3Z0GW6Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yann Gautier <yann.gautier@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.3 081/199] mmc: mmci: stm32: fix max busy timeout calculation
Date:   Mon, 26 Jun 2023 20:09:47 +0200
Message-ID: <20230626180809.133109117@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
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

From: Christophe Kerello <christophe.kerello@foss.st.com>

commit 47b3ad6b7842f49d374a01b054a4b1461a621bdc upstream.

The way that the timeout is currently calculated could lead to a u64
timeout value in mmci_start_command(). This value is then cast in a u32
register that leads to mmc erase failed issue with some SD cards.

Fixes: 8266c585f489 ("mmc: mmci: add hardware busy timeout feature")
Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230613134146.418016-1-yann.gautier@foss.st.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/mmci.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1735,7 +1735,8 @@ static void mmci_set_max_busy_timeout(st
 		return;
 
 	if (host->variant->busy_timeout && mmc->actual_clock)
-		max_busy_timeout = ~0UL / (mmc->actual_clock / MSEC_PER_SEC);
+		max_busy_timeout = U32_MAX / DIV_ROUND_UP(mmc->actual_clock,
+							  MSEC_PER_SEC);
 
 	mmc->max_busy_timeout = max_busy_timeout;
 }


