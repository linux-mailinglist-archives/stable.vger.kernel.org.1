Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB9779BC68
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378832AbjIKWhe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239680AbjIKO0Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:26:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD06CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:26:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B484AC433C8;
        Mon, 11 Sep 2023 14:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442371;
        bh=6sMB2t9NDbKSNEbk87OLjdcaBUHGHCgrVwvg25+5bw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LEehNLNLASwsjsBzEl+O2D7MtdJYxiLhxVQba6YUQrehFZwMISQbWq6xkEcTBSwko
         0gkb/NIbbUqTCB2mla0o1QWZSrFBFrMdqtLBckgKAnWGkRqR3z9hFSazaR70vRQbWo
         wTlm7UDkgv2t2KIZeJmHbR3G7cvE41Zwr0T/jgmk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Lech Perczak <lech.perczak@camlingroup.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 731/739] serial: sc16is7xx: remove obsolete out_thread label
Date:   Mon, 11 Sep 2023 15:48:50 +0200
Message-ID: <20230911134711.482147596@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

[ Upstream commit dabc54a45711fe77674a6c0348231e00e66bd567 ]

Commit c8f71b49ee4d ("serial: sc16is7xx: setup GPIO controller later
in probe") moved GPIO setup code later in probe function. Doing so
also required to move ports cleanup code (out_ports label) after the
GPIO cleanup code.

After these moves, the out_thread label becomes misplaced and makes
part of the cleanup code illogical.

This patch remove the now obsolete out_thread label and make GPIO
setup code jump to out_ports label if it fails.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20230807214556.540627-3-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 049994292834 ("serial: sc16is7xx: fix regression with GPIO configuration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index faeb3dc371c05..f714ba3abc980 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1529,7 +1529,7 @@ static int sc16is7xx_probe(struct device *dev,
 		s->gpio.can_sleep	 = 1;
 		ret = gpiochip_add_data(&s->gpio, s);
 		if (ret)
-			goto out_thread;
+			goto out_ports;
 	}
 #endif
 
@@ -1555,8 +1555,6 @@ static int sc16is7xx_probe(struct device *dev,
 #ifdef CONFIG_GPIOLIB
 	if (devtype->nr_gpio)
 		gpiochip_remove(&s->gpio);
-
-out_thread:
 #endif
 
 out_ports:
-- 
2.40.1



