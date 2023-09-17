Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF837A3A56
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbjIQUCW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240394AbjIQUBo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:01:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0753CD7
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:01:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1137FC4339A;
        Sun, 17 Sep 2023 20:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980882;
        bh=OsQiSKmnP7mYXLs+KXp44JE9oRP0G/XKUTxgMIfnSeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UF+eSAw6M7jVVmhUVY7nwLQAzDeH8kzVeDmrmHVYPq7wP0QJM3VcGvsliqLeXasLC
         ITBbzPDWGrVH6B0Qj3Zwr+ZVNE1bOdQrUs/eHRIrG9oYplz5ZGTm10hAC8XR5J0hvG
         rxYD4RDn+p+TX7fafKfxTNgMDfxo0C2JS0wKk0t4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>
Subject: [PATCH 6.1 036/219] parisc: led: Fix LAN receive and transmit LEDs
Date:   Sun, 17 Sep 2023 21:12:43 +0200
Message-ID: <20230917191042.303958721@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
 


