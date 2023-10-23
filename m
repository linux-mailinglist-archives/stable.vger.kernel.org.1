Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515897D30BB
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjJWLBk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjJWLBi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:01:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58351D7B
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:01:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99216C433C7;
        Mon, 23 Oct 2023 11:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698058896;
        bh=kdLSCUubBi0w19SyB0R30BfFZFwNiy3FpieWkkqr1Xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZY2txrHLZSrq2n4WjfD8RwI57kMvsC/ycxhb/yNaPTBnOY/ZdrLZ42iqhIK8NYpKA
         gideBnc+XgMavGOsWcbgxoYmWVxHIpvFfvBzXLYM/hgTgEeabzMAVAm5W+WOcIJALg
         kVBX+DeHWIKQHIvDbITSu5+M+fUzdfo2mcU+WW2k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Haibo Chen <haibo.chen@nxp.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 4.14 63/66] gpio: vf610: set value before the direction to avoid a glitch
Date:   Mon, 23 Oct 2023 12:56:53 +0200
Message-ID: <20231023104813.160207048@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104810.781270702@linuxfoundation.org>
References: <20231023104810.781270702@linuxfoundation.org>
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
@@ -137,14 +137,14 @@ static int vf610_gpio_direction_output(s
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
 


