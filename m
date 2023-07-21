Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290C975D243
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjGUS6C (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjGUS6B (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:58:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11B13C14
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:57:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DD7D61D7C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5F4C433C8;
        Fri, 21 Jul 2023 18:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965858;
        bh=hEd9Dl1BnV2HT2houBCfENnqi5F1sjUS3TpawDAVmOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ve/Cv6Kqu2oGLe/AIdrab9ZC/oJURZYvEmpZImgNifmyHAGajHbVuUf4TjMYcwOqU
         hiOb/AMAB8Wyr1xRFh/8UXMnXxGt+S9J7ywRDf5eEE+Mlns1xc44qxt/PNa7E1qrVH
         VxqdJEScLH4kfQL8OfxiNPX2ic/2NeOjg2OftrIQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 140/532] ARM: ep93xx: fix missing-prototype warnings
Date:   Fri, 21 Jul 2023 18:00:44 +0200
Message-ID: <20230721160622.051757386@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index dd4b164d18317..a9efa7bc2fa12 100644
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



