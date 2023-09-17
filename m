Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E3B7A3CD4
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241082AbjIQUfr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241191AbjIQUfi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:35:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1978D10E
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:35:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B7FC433C8;
        Sun, 17 Sep 2023 20:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982932;
        bh=AjRC50IHzuy87YbJ74UKgIMxGAr8sw22mgae7QWAWU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sUt+cqFTRqqyys4eJDzEG3UxofT9mpsZ+CBPjROsj2FOMmua6OIensxwQO6QWhjxk
         5sgaBpo0GrVEyXswMK1zCYz1bOpm9YiXn6k2dzqkKx71QBrxVnMi/wCPjL4dWxYTP4
         juUXfYgn5866Z9/iDCXIakGBLxixKjfgqZ4lUJ8k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>
Subject: [PATCH 5.15 395/511] parisc: led: Fix LAN receive and transmit LEDs
Date:   Sun, 17 Sep 2023 21:13:42 +0200
Message-ID: <20230917191123.331934747@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit 4db89524b084f712a887256391fc19d9f66c8e55 upstream.

Fix the LAN receive and LAN transmit LEDs, which where swapped
up to now.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/include/asm/led.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/parisc/include/asm/led.h
+++ b/arch/parisc/include/asm/led.h
@@ -11,8 +11,8 @@
 #define	LED1		0x02
 #define	LED0		0x01		/* bottom (or furthest left) LED */
 
-#define	LED_LAN_TX	LED0		/* for LAN transmit activity */
-#define	LED_LAN_RCV	LED1		/* for LAN receive activity */
+#define	LED_LAN_RCV	LED0		/* for LAN receive activity */
+#define	LED_LAN_TX	LED1		/* for LAN transmit activity */
 #define	LED_DISK_IO	LED2		/* for disk activity */
 #define	LED_HEARTBEAT	LED3		/* heartbeat */
 


