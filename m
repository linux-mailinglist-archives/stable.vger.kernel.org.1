Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEF579BDBD
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344623AbjIKVOg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239473AbjIKOVf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:21:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F3FDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:21:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF54C433C7;
        Mon, 11 Sep 2023 14:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442090;
        bh=pVeuaXFEv9SUUTMr6LrbZf2tuajZxbByDjcbS6eoaxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CNYnUIs66LQQaGW5LLxA+y3Q27zJRNVMkoKsDMMZm9QL4dNSMRAam5ur5rgJ3Fhuk
         lP/YuUS9MYfh/3tgybrtaGXZYiutj2TmTRrePhJY64xYaQ/5sHTr4Nj1G0M/NMgbJz
         BQffwV9CQbh1zRaixHkfQZxyJkYPLg6bY6EOCdBw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 616/739] mfd: rk808: Make MFD_RK8XX tristate
Date:   Mon, 11 Sep 2023 15:46:55 +0200
Message-ID: <20230911134708.305154337@linuxfoundation.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit d085c27aa62999e2fe054707ab9da2af65d22b2f ]

There is no reason for MFD_RK8XX to be bool, all drivers that depend on
it, or that select it, are tristate.

Fixes: c20e8c5b1203af37 ("mfd: rk808: Split into core and i2c")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Tested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/d132363fc9228473e9e652b70a3761b94de32d70.1688475844.git.geert+renesas@glider.be
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6f5b259a6d6a0..f6b519eaaa710 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1197,7 +1197,7 @@ config MFD_RC5T583
 	  different functionality of the device.
 
 config MFD_RK8XX
-	bool
+	tristate
 	select MFD_CORE
 
 config MFD_RK8XX_I2C
-- 
2.40.1



