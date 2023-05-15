Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD937034C1
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243097AbjEOQwB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243098AbjEOQvn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:51:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332C15B91
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:51:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A76962973
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5AFC4339B;
        Mon, 15 May 2023 16:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169501;
        bh=gbvDJcgdwIrhoDmWaxHzrev8B3cRtuP47LC7W19xLiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EIFZpwxpCSl36UEeipBbo4Atscc/TTdAwB2EWZz2XezU0Ewf+AMsh2QIguyFnftqG
         L/Jw8P8c+RV2TWiy0urCmdHvmHleML3jhZPUcdup0GNDUt5fvyCxhVKVTEfRhGevbi
         p5Af3QpvloxwMA+HUnriW0oEJYYA48mqVQZDqs5w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hayes Wang <hayeswang@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 077/246] r8152: fix the autosuspend doesnt work
Date:   Mon, 15 May 2023 18:24:49 +0200
Message-Id: <20230515161724.880284047@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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

From: Hayes Wang <hayeswang@realtek.com>

[ Upstream commit 0fbd79c01a9a657348f7032df70c57a406468c86 ]

Set supports_autosuspend = 1 for the rtl8152_cfgselector_driver.

Fixes: ec51fbd1b8a2 ("r8152: add USB device driver for config selection")
Signed-off-by: Hayes Wang <hayeswang@realtek.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 755b0f72dd44f..0999a58ca9d26 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9910,6 +9910,7 @@ static struct usb_device_driver rtl8152_cfgselector_driver = {
 	.probe =	rtl8152_cfgselector_probe,
 	.id_table =	rtl8152_table,
 	.generic_subclass = 1,
+	.supports_autosuspend = 1,
 };
 
 static int __init rtl8152_driver_init(void)
-- 
2.39.2



