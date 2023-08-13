Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B848777ACE7
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjHMVi1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjHMVi1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:38:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2898910DD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:38:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB3B6636C7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1720C433C7;
        Sun, 13 Aug 2023 21:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962708;
        bh=Dbj2Hx0+kdpjHVdqSZ5/XwpdvKqRVkjpWihUDD6EIkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oFmxjqDDiW5t+MH0ULIhwVTbQQMGOPdO+ndQw9nezYFrSFYfrVPfdypPRPVbWvIMP
         +Gl3K90Fk6LatifwMZeWFVouclU0RDp7rX1CFbGux1Eue1H1oENMKQVcEva1vMZbzt
         BnnEtA0sl3D7QIayFEH1JVXbmuuK2bTl/e/OOgDQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6.1 126/149] gpio: sim: mark the GPIO chip as a one that can sleep
Date:   Sun, 13 Aug 2023 23:19:31 +0200
Message-ID: <20230813211722.494853297@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

commit 5a78d5db9c90c9dc84212f40a5f2687b7cafc8ec upstream.

Simulated chips use a mutex for synchronization in driver callbacks so
they must not be called from interrupt context. Set the can_sleep field
of the GPIO chip to true to force users to only use threaded irqs.

Fixes: cb8c474e79be ("gpio: sim: new testing module")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-sim.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -425,6 +425,7 @@ static int gpio_sim_add_bank(struct fwno
 	gc->set_config = gpio_sim_set_config;
 	gc->to_irq = gpio_sim_to_irq;
 	gc->free = gpio_sim_free;
+	gc->can_sleep = true;
 
 	ret = devm_gpiochip_add_data(dev, gc, chip);
 	if (ret)


