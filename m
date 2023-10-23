Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69D37D332F
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbjJWL1f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbjJWL1e (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:27:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED8092
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:27:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D82EC433C9;
        Mon, 23 Oct 2023 11:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060452;
        bh=VsG1EGBEvH/02Te+pJ73/c85XJnu1elW9B/wVN8mKBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VgJ+0hlg7xWdH1lR8R1gZfn3a9G0NHqYWo57Iviyhd+fz8HxZq+Z55enCUc+LzF8h
         3+9BaOWg8OkInRWa5QnrYtYzyda+XGu3UW3XK0+dI+RsjctWzjcYJAqwlP3TnqdGLt
         5cd4EyuMYj6Nmd1UVETnLAsAl6c02I9oeHCmaTm0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Haibo Chen <haibo.chen@nxp.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 6.1 177/196] gpio: vf610: set value before the direction to avoid a glitch
Date:   Mon, 23 Oct 2023 12:57:22 +0200
Message-ID: <20231023104833.410669492@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haibo Chen <haibo.chen@nxp.com>

commit fc363413ef8ea842ae7a99e3caf5465dafdd3a49 upstream.

We found a glitch when configuring the pad as output high. To avoid this
glitch, move the data value setting before direction config in the
function vf610_gpio_direction_output().

Fixes: 659d8a62311f ("gpio: vf610: add imx7ulp support")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
[Bartosz: tweak the commit message]
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-vf610.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -128,14 +128,14 @@ static int vf610_gpio_direction_output(s
 	unsigned long mask = BIT(gpio);
 	u32 val;
 
+	vf610_gpio_set(chip, gpio, value);
+
 	if (port->sdata && port->sdata->have_paddr) {
 		val = vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
 		val |= mask;
 		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);
 	}
 
-	vf610_gpio_set(chip, gpio, value);
-
 	return pinctrl_gpio_direction_output(chip->base + gpio);
 }
 


