Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7055D6FA5B7
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjEHKMl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbjEHKMb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:12:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B3B3A2A9
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:12:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6B69623EA
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE466C433D2;
        Mon,  8 May 2023 10:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540740;
        bh=aGde8WnBVi/Ha+aQcQmeBTtAMgyOABehjEweiLwcf24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YLd42uNJlp9i4gAtZypk88que0Sij41IOv6IfWWrGk/PtePWr5L7gNmNtIWEMWc1Z
         qC46NZznuiY1zjhtlxCqGBmgkebGCFzQfQJr1btrhA7NPQLh8zaF7+3j4OF46mIlla
         NgwZl8V5jO7wYGkJ8sMRC+/eotCYAlUPwdI+7MMk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 452/611] staging: rtl8192e: Fix W_DISABLE# does not work after stop/start
Date:   Mon,  8 May 2023 11:44:54 +0200
Message-Id: <20230508094436.851988050@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 89bc989cffbae..c1e50084172d8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -717,6 +717,7 @@ static int _rtl92e_sta_up(struct net_device *dev, bool is_silent_reset)
 	else
 		netif_wake_queue(dev);
 
+	priv->bfirst_after_down = false;
 	return 0;
 }
 
-- 
2.39.2



