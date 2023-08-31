Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D941178EB79
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 13:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345091AbjHaLKo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 07:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343754AbjHaLKo (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 07:10:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300FE170A
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 04:10:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FB21B82261
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 11:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96A9C433C8;
        Thu, 31 Aug 2023 11:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693480195;
        bh=5TadUomiqk7fVpi2MJx42Ho6ckobVlotU+wrsWJtACw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XoDS4NvbMj23wWug5v/U+S9no2esS1boCjyQPkip6b2IvqOz77rNOEdGx/nNdYi//
         h0bG6x7yQBTHofMHstBcsM9HIoDsFnRdofptJ0GYsRbTWZAKlEY1pR0LAmm1pVQAX8
         HY/+VQgL2pIyr4MS8s93t5RXapm80h817m33KqG4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guenter Roeck <linux@roeck-us.net>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 2/2] Revert "ARM: ep93xx: fix missing-prototype warnings"
Date:   Thu, 31 Aug 2023 13:09:43 +0200
Message-ID: <20230831110828.673811945@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230831110828.577111137@linuxfoundation.org>
References: <20230831110828.577111137@linuxfoundation.org>
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 2e50d55578b05664b11538f0a280541c100caefe which is
commit 419013740ea1e4343d8ade535d999f59fa28e460 upstream.

It breaks the build, so should be reverted.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/98dbc981-56fa-4919-afcc-fdf63e0a1c53@roeck-us.net
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-ep93xx/timer-ep93xx.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/arm/mach-ep93xx/timer-ep93xx.c
+++ b/arch/arm/mach-ep93xx/timer-ep93xx.c
@@ -9,7 +9,6 @@
 #include <linux/io.h>
 #include <asm/mach/time.h>
 #include "soc.h"
-#include "platform.h"
 
 /*************************************************************************
  * Timer handling for EP93xx
@@ -61,7 +60,7 @@ static u64 notrace ep93xx_read_sched_clo
 	return ret;
 }
 
-static u64 ep93xx_clocksource_read(struct clocksource *c)
+u64 ep93xx_clocksource_read(struct clocksource *c)
 {
 	u64 ret;
 


