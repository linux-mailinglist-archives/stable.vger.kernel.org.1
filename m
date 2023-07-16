Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470BD755635
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjGPUsg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjGPUsd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:48:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68910E66
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:48:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6BFC60EBD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59BDC433C7;
        Sun, 16 Jul 2023 20:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540504;
        bh=e/ntW3KfrNZ+05svX9JjicIM9a3VlH4d3q6kEwugBZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yjKoxSaE7IyLI8h/dODpbWkZiGpiMRUt8XGuLk8BYfV6WZd00vKF60xvwlTurAKFK
         4oS6gqPQnTJ7Oq6RMV6Epb5jbaAEM4Eaw62euIerKpmJXAjyletYa5KiJdxUP6uCcv
         304E16QOmajpIO6imcbn+EgcTvVHP9KoVV/Qiaq8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 387/591] usb: dwc2: platform: Improve error reporting for problems during .remove()
Date:   Sun, 16 Jul 2023 21:48:46 +0200
Message-ID: <20230716194933.932217745@linuxfoundation.org>
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

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 55f223b8b408cbfd85fb1c5b74ab85ccab319a69 ]

Returning an error value in a platform driver's remove callback results in
a generic error message being emitted by the driver core, but otherwise it
doesn't make a difference. The device goes away anyhow.

For each case where ret is non-zero the driver already emits an error
message, so suppress the generic error message by returning zero
unconditionally. (Side note: The return value handling was unreliable
anyhow as the value returned by dwc2_exit_hibernation() was overwritten
anyhow if hsotg->in_ppd was non-zero.)

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Minas Harutyunyan <hminas@synopsys.com>
Link: https://lore.kernel.org/r/20221017195914.1426297-1-u.kleine-koenig@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: ada050c69108 ("usb: dwc2: Fix some error handling paths")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc2/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 0c02ef7628fd5..d1589ba7d322d 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -309,7 +309,7 @@ static int dwc2_driver_remove(struct platform_device *dev)
 	reset_control_assert(hsotg->reset);
 	reset_control_assert(hsotg->reset_ecc);
 
-	return ret;
+	return 0;
 }
 
 /**
-- 
2.39.2



