Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DB173E859
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjFZSYl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjFZSYU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:24:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D87D2D73
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BFEF60F18
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0965DC433C8;
        Mon, 26 Jun 2023 18:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803824;
        bh=WX97hGv7nM7zOSIgNl2gsNEkMonhpFfsgn9gTcWRj4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S4350LlrqdSKXJkPwiFE8059djAniiK6S17bKc5sws+CG0+NydE2XgATJJAYjm5QZ
         +8ZeEXqQEJGyXNEgEAvxcWCYeFnxjbeS3SG4vpAalsncpj41Hc/69LUvUXjcOMTWxx
         WBkvM7P2r208ypx1scikI1Xiz5XgQvKy2ziAjxjw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Simon Horman <horms@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 182/199] i2c: mchp-pci1xxxx: Avoid cast to incompatible function type
Date:   Mon, 26 Jun 2023 20:11:28 +0200
Message-ID: <20230626180813.753453935@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
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

From: Simon Horman <horms@kernel.org>

[ Upstream commit 7ebfd881abe9e0ea9557b29dab6aa28d294fabb4 ]

Rather than casting pci1xxxx_i2c_shutdown to an incompatible function type,
update the type to match that expected by __devm_add_action.

Reported by clang-16 with W-1:

 .../i2c-mchp-pci1xxxx.c:1159:29: error: cast from 'void (*)(struct pci1xxxx_i2c *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
         ret = devm_add_action(dev, (void (*)(void *))pci1xxxx_i2c_shutdown, i2c);
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 ./include/linux/device.h:251:29: note: expanded from macro 'devm_add_action'
         __devm_add_action(release, action, data, #action)
                                   ^~~~~~

No functional change intended.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Reviewed-by: Tharun Kumar P<tharunkumar.pasumarthi@microchip.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-mchp-pci1xxxx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mchp-pci1xxxx.c b/drivers/i2c/busses/i2c-mchp-pci1xxxx.c
index b21ffd6df9276..5ef136c3ecb12 100644
--- a/drivers/i2c/busses/i2c-mchp-pci1xxxx.c
+++ b/drivers/i2c/busses/i2c-mchp-pci1xxxx.c
@@ -1118,8 +1118,10 @@ static int pci1xxxx_i2c_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(pci1xxxx_i2c_pm_ops, pci1xxxx_i2c_suspend,
 			 pci1xxxx_i2c_resume);
 
-static void pci1xxxx_i2c_shutdown(struct pci1xxxx_i2c *i2c)
+static void pci1xxxx_i2c_shutdown(void *data)
 {
+	struct pci1xxxx_i2c *i2c = data;
+
 	pci1xxxx_i2c_config_padctrl(i2c, false);
 	pci1xxxx_i2c_configure_core_reg(i2c, false);
 }
@@ -1156,7 +1158,7 @@ static int pci1xxxx_i2c_probe_pci(struct pci_dev *pdev,
 	init_completion(&i2c->i2c_xfer_done);
 	pci1xxxx_i2c_init(i2c);
 
-	ret = devm_add_action(dev, (void (*)(void *))pci1xxxx_i2c_shutdown, i2c);
+	ret = devm_add_action(dev, pci1xxxx_i2c_shutdown, i2c);
 	if (ret)
 		return ret;
 
-- 
2.39.2



