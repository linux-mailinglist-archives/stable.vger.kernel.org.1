Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B3E76118E
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjGYKxD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjGYKvz (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:51:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C974D19BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:51:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A05E16166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:51:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08ADC433C7;
        Tue, 25 Jul 2023 10:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282266;
        bh=+ILS3B7vazdff0SdC23F2+Cu7aaTz1K7tRDmK6tD1is=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zvciNoiWj+4mHpe73W2ZFnj41NR9qdX0sXiHhXrnteeEZj9Pp8B7Z9NryW4jhPCpJ
         xhlUpzzmgNcKpqIYnkCvxxfpo8c4Ca3rnHd8Kyr97QjVE9WlfLPeA0SrX6HH0iCOna
         wS5fOH4JSntpbiZGNT2sPF9Cyh8HaEjF22ZUYSLM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.4 038/227] Revert "r8169: disable ASPM during NAPI poll"
Date:   Tue, 25 Jul 2023 12:43:25 +0200
Message-ID: <20230725104516.405285017@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
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

From: Heiner Kallweit <hkallweit1@gmail.com>

commit e31a9fedc7d8d80722b19628e66fcb5a36981780 upstream.

This reverts commit e1ed3e4d91112027b90c7ee61479141b3f948e6a.

Turned out the change causes a performance regression.

Link: https://lore.kernel.org/netdev/20230713124914.GA12924@green245/T/
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://lore.kernel.org/r/055c6bc2-74fa-8c67-9897-3f658abb5ae7@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169_main.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4514,10 +4514,6 @@ static irqreturn_t rtl8169_interrupt(int
 	}
 
 	if (napi_schedule_prep(&tp->napi)) {
-		rtl_unlock_config_regs(tp);
-		rtl_hw_aspm_clkreq_enable(tp, false);
-		rtl_lock_config_regs(tp);
-
 		rtl_irq_disable(tp);
 		__napi_schedule(&tp->napi);
 	}
@@ -4577,14 +4573,9 @@ static int rtl8169_poll(struct napi_stru
 
 	work_done = rtl_rx(dev, tp, budget);
 
-	if (work_done < budget && napi_complete_done(napi, work_done)) {
+	if (work_done < budget && napi_complete_done(napi, work_done))
 		rtl_irq_enable(tp);
 
-		rtl_unlock_config_regs(tp);
-		rtl_hw_aspm_clkreq_enable(tp, true);
-		rtl_lock_config_regs(tp);
-	}
-
 	return work_done;
 }
 


