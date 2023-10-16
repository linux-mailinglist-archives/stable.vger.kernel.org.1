Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03C87CABD3
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjJPOqA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbjJPOqA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:46:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66493ED
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:45:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E98C433C8;
        Mon, 16 Oct 2023 14:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467558;
        bh=qxJ7pPRJLtWSyEZVzdfunYjUlzwJzYgfCsDa+Ef+yMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GQzfFaO4vNDFYvOpRryY08uB5xEDuhnPDOYpWCXnPsREKNtpDUy08htCwynZgzZL9
         gcm4q//iFRJuRf9PK+oUHXZg+psHIdvo51/lR3uywdHyh1WjnYcUYYpf83hJBItdoW
         prdqHgmj4NEN48IxcNSR0OYydtmZGmO+jhrQZn/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hal Feng <hal.feng@starfivetech.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 043/191] pinctrl: starfive: jh7110: Fix failure to set irq after CONFIG_PM is enabled
Date:   Mon, 16 Oct 2023 10:40:28 +0200
Message-ID: <20231016084016.413947551@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hal Feng <hal.feng@starfivetech.com>

[ Upstream commit 8406d6b5916663b4edc604b3effbf4935b61c2da ]

The issue was found when we enabled CONFIG_PM and tested edge events using
libgpiod.

> # gpiomon -r gpiochip0 55
> gpiomon: error waiting for events: Permission denied

`gpiomon` will call irq_chip_pm_get() and then call pm_runtime_resume_and_get()
if (IS_ENABLED(CONFIG_PM) && sfp->gc.irq.domain->pm_dev).
pm_runtime_resume_and_get() will fail if the runtime pm of pinctrl device
is disabled.

As we expect the pinctrl driver can be always working and never suspend
during runtime, unset sfp->gc.irq.domain->pm_dev to make sure
pm_runtime_resume_and_get() won't be called when setting irq.

Fixes: 447976ab62c5 ("pinctrl: starfive: Add StarFive JH7110 sys controller driver")
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
Link: https://lore.kernel.org/r/20230905122105.117000-2-hal.feng@starfivetech.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
index 5fe729b4a03de..72747ad497b5e 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
@@ -968,8 +968,6 @@ int jh7110_pinctrl_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "could not register gpiochip\n");
 
-	irq_domain_set_pm_device(sfp->gc.irq.domain, dev);
-
 	dev_info(dev, "StarFive GPIO chip registered %d GPIOs\n", sfp->gc.ngpio);
 
 	return pinctrl_enable(sfp->pctl);
-- 
2.40.1



