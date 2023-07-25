Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3961761512
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbjGYLZV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbjGYLZU (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:25:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42FF9D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:25:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63E7461682
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73675C433C7;
        Tue, 25 Jul 2023 11:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284318;
        bh=zYNoOPJMh8ggkk+5ZQUOsFyH7CT6cJD8QHQ1TTyo7KU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=guHZ7nfGpzl9GUtNadvIeVpGVI9MKxF+fS4zGVX5qul+GzcsexHYkCJAPcCF6okIw
         C18D4kCkRheQxWeJiLSiQObJFB7mJfsaTlFSqQ/Xa28i46lBOEfnQYJWaIcP3QjtaV
         9K0s2ZbLDAvPxWFmHNXmwFRCJmQ6cfoAGjWH4jzA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yann Gautier <yann.gautier@foss.st.com>
Subject: [PATCH 5.10 285/509] mmc: mmci: Set PROBE_PREFER_ASYNCHRONOUS
Date:   Tue, 25 Jul 2023 12:43:44 +0200
Message-ID: <20230725104606.777095369@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

commit 3108eb2e8aa7e955a9dd3a4c1bf19a7898961822 upstream.

All mmc host drivers should have the asynchronous probe option enabled, but
it seems like we failed to set it for mmci, so let's do that now.

Fixes: 21b2cec61c04 ("mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v4.4")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Yann Gautier <yann.gautier@foss.st.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230612143730.210390-1-ulf.hansson@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/mmci.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -2386,6 +2386,7 @@ static struct amba_driver mmci_driver =
 	.drv		= {
 		.name	= DRIVER_NAME,
 		.pm	= &mmci_dev_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe		= mmci_probe,
 	.remove		= mmci_remove,


