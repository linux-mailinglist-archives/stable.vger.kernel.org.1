Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285E7761657
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbjGYLiZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbjGYLiO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:38:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAE519AA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:38:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D19B61600
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8B0C433C7;
        Tue, 25 Jul 2023 11:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285091;
        bh=KZnft3sVw5x33P3BLTN2j1AAlZ2+XyVaeAqZgoxC67k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1NOS0esnpJ3GL+zmpPlc5ZKREuMqzvWhzD/vqeojJ8MlpptKCJGos6aBtg6odktZ4
         eJiHdcdQDrFfUjPyHtICM0/iPeQl9alS7v1i+CYWzeN+CARYfOtr8qRlRsCkxwsvrC
         b7FgYoiAIVluqRrucC6DLkhBd+dLZ9moLSKyURBI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 080/313] ARM: ep93xx: fix missing-prototype warnings
Date:   Tue, 25 Jul 2023 12:43:53 +0200
Message-ID: <20230725104524.392702818@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 419013740ea1e4343d8ade535d999f59fa28e460 ]

ep93xx_clocksource_read() is only called from the file it is declared in,
while ep93xx_timer_init() is declared in a header that is not included here.

arch/arm/mach-ep93xx/timer-ep93xx.c:120:13: error: no previous prototype for 'ep93xx_timer_init'
arch/arm/mach-ep93xx/timer-ep93xx.c:63:5: error: no previous prototype for 'ep93xx_clocksource_read'

Fixes: 000bc17817bf ("ARM: ep93xx: switch to GENERIC_CLOCKEVENTS")
Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Link: https://lore.kernel.org/r/20230516153109.514251-3-arnd@kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-ep93xx/timer-ep93xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ep93xx/timer-ep93xx.c b/arch/arm/mach-ep93xx/timer-ep93xx.c
index de998830f534f..b07956883e165 100644
--- a/arch/arm/mach-ep93xx/timer-ep93xx.c
+++ b/arch/arm/mach-ep93xx/timer-ep93xx.c
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <asm/mach/time.h>
 #include "soc.h"
+#include "platform.h"
 
 /*************************************************************************
  * Timer handling for EP93xx
@@ -60,7 +61,7 @@ static u64 notrace ep93xx_read_sched_clock(void)
 	return ret;
 }
 
-u64 ep93xx_clocksource_read(struct clocksource *c)
+static u64 ep93xx_clocksource_read(struct clocksource *c)
 {
 	u64 ret;
 
-- 
2.39.2



