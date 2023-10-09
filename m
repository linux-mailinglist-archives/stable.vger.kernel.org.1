Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301297BE127
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377455AbjJINra (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377427AbjJINr3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:47:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359B9DF
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:47:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B434C433C8;
        Mon,  9 Oct 2023 13:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859247;
        bh=IMqin6+GR36mTrCnqcvdxffTEl2EhADjvi5rS+bOEck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QzWVaVT7QutHyjA12EQhQlqttEBWOYTBMkmUI1toMnl0fIWAXNPl3HolEGvvABj66
         yJJRoGRgW/wJ1wrkV5JcOpF5mGFQmBOKY5lGXDZQAmXXGkhGlbSYeqxf9FABISosSW
         DfXuOzlizJtsYlBswgnFDgBHNVL24bL3EZUC27ik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 06/55] gpio: tb10x: Fix an error handling path in tb10x_gpio_probe()
Date:   Mon,  9 Oct 2023 15:06:05 +0200
Message-ID: <20231009130107.954238969@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130107.717692466@linuxfoundation.org>
References: <20231009130107.717692466@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit b547b5e52a0587e6b25ea520bf2f9e03d00cbcb6 ]

If an error occurs after a successful irq_domain_add_linear() call, it
should be undone by a corresponding irq_domain_remove(), as already done
in the remove function.

Fixes: c6ce2b6bffe5 ("gpio: add TB10x GPIO driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-tb10x.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
index 091ffaaec6354..97a9d9823475a 100644
--- a/drivers/gpio/gpio-tb10x.c
+++ b/drivers/gpio/gpio-tb10x.c
@@ -244,7 +244,7 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 				handle_edge_irq, IRQ_NOREQUEST, IRQ_NOPROBE,
 				IRQ_GC_INIT_MASK_CACHE);
 		if (ret)
-			return ret;
+			goto err_remove_domain;
 
 		gc = tb10x_gpio->domain->gc->gc[0];
 		gc->reg_base                         = tb10x_gpio->base;
@@ -258,6 +258,10 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 	}
 
 	return 0;
+
+err_remove_domain:
+	irq_domain_remove(tb10x_gpio->domain);
+	return ret;
 }
 
 static int tb10x_gpio_remove(struct platform_device *pdev)
-- 
2.40.1



