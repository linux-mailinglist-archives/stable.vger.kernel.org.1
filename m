Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8591791CDF
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243513AbjIDScc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243476AbjIDScc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:32:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F96FCCB
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:32:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6B01ACE0F9A
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6832BC433C9;
        Mon,  4 Sep 2023 18:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852345;
        bh=8qXAN4aSB2iCHC6leWBkFS7A+9l6SMFBCiueFVLxBkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TX9RGwkyD781vIctD3oOoOPz66GbAx/JOKhdclg3IQe+ma8B7kOZW4sD8ZRcsFgof
         38iyvf7QQfXVqaY5tQjkWG2hyJ/KtMc6rvLhbnJHfLJx9k02PAZ9zipbGKwawJ2xey
         IddhE34/JGz8K0dwXUSH9+Cccsi7hf3/vPAI1JfA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6.5 34/34] pinctrl: amd: Dont show `Invalid config param` errors
Date:   Mon,  4 Sep 2023 19:30:21 +0100
Message-ID: <20230904182950.185508443@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182948.594404081@linuxfoundation.org>
References: <20230904182948.594404081@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit 87b549efcb0f7934b0916d2a00607a878b6f1e0f upstream.

On some systems amd_pinconf_set() is called with parameters
0x8 (PIN_CONFIG_DRIVE_PUSH_PULL) or 0x14 (PIN_CONFIG_PERSIST_STATE)
which are not supported by pinctrl-amd.

Don't show an err message when called with an invalid parameter,
downgrade this to debug instead.

Cc: stable@vger.kernel.org # 6.1
Fixes: 635a750d958e1 ("pinctrl: amd: Use amd_pinconf_set() for all config options")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20230717201652.17168-1-mario.limonciello@amd.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/pinctrl-amd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -748,7 +748,7 @@ static int amd_pinconf_get(struct pinctr
 		break;
 
 	default:
-		dev_err(&gpio_dev->pdev->dev, "Invalid config param %04x\n",
+		dev_dbg(&gpio_dev->pdev->dev, "Invalid config param %04x\n",
 			param);
 		return -ENOTSUPP;
 	}
@@ -798,7 +798,7 @@ static int amd_pinconf_set(struct pinctr
 			break;
 
 		default:
-			dev_err(&gpio_dev->pdev->dev,
+			dev_dbg(&gpio_dev->pdev->dev,
 				"Invalid config param %04x\n", param);
 			ret = -ENOTSUPP;
 		}


