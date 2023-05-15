Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27009703B71
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244848AbjEOSDD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244644AbjEOSCk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:02:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9E319BE0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 162DD63013
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE1DC433D2;
        Mon, 15 May 2023 18:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173618;
        bh=yMtuwGpr7Y/pHYqyM6jaS/qaDl6oFZhjdmt1MViOw8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jeSMJcad+95BjHu/QWa4HdbuuG2pFuUV2n3aUeIvoQKWlLSmY5P6PvFBHJV5WDjXY
         u0llyDw7pcIzFNLcWD7cxhkYSt+hE2MS6AlSMWqta2fWESksP/qjx7bj9b4Hv4R1pN
         YBoFgInIpZXH/U757sLhenqX4GwJYuUaVaXTeI3c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 152/282] staging: rtl8192e: Fix W_DISABLE# does not work after stop/start
Date:   Mon, 15 May 2023 18:28:50 +0200
Message-Id: <20230515161726.780550473@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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

From: Philipp Hortmann <philipp.g.hortmann@gmail.com>

[ Upstream commit 3fac2397f562eb669ddc2f45867a253f3fc26184 ]

When loading the driver for rtl8192e, the W_DISABLE# switch is working as
intended. But when the WLAN is turned off in software and then turned on
again the W_DISABLE# does not work anymore. Reason for this is that in
the function _rtl92e_dm_check_rf_ctrl_gpio() the bfirst_after_down is
checked and returned when true. bfirst_after_down is set true when
switching the WLAN off in software. But it is not set to false again
when WLAN is turned on again.

Add bfirst_after_down = false in _rtl92e_sta_up to reset bit and fix
above described bug.

Fixes: 94a799425eee ("From: wlanfae <wlanfae@realtek.com> [PATCH 1/8] rtl8192e: Import new version of driver from realtek")
Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Link: https://lore.kernel.org/r/20230418200201.GA17398@matrix-ESPRIMO-P710
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index bcbf0c8cd4209..be377e75703bf 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -767,6 +767,7 @@ static int _rtl92e_sta_up(struct net_device *dev, bool is_silent_reset)
 	else
 		netif_wake_queue(dev);
 
+	priv->bfirst_after_down = false;
 	return 0;
 }
 
-- 
2.39.2



