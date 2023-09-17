Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1687A3944
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239994AbjIQTrN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240016AbjIQTqr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:46:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E2F185
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:46:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACF6C433C9;
        Sun, 17 Sep 2023 19:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980001;
        bh=X1ts288xElJ8jQbpBp13NftFq0tedjB9BQd6mUGkFyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bFA3Q8qkWRm7zCI2XIVc0ocEPKvBbCoRvjE5hhmHxWNYKHQiSpvavaZtrn/m5m0vH
         xvGk2Sai+eLwYPWzk1bRWIBb1nmILhYv/jAHpsQgVOuPSkQUXpwCjJyH3vK+iT2q//
         ANi227Iy5vESpJnp8heKAlMXD6l3GovyLGFvTJes=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>
Subject: [PATCH 6.5 040/285] parisc: led: Reduce CPU overhead for disk & lan LED computation
Date:   Sun, 17 Sep 2023 21:10:40 +0200
Message-ID: <20230917191053.059354720@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit 358ad816e52d4253b38c2f312e6b1cbd89e0dbf7 upstream.

Older PA-RISC machines have LEDs which show the disk- and LAN-activity.
The computation is done in software and takes quite some time, e.g. on a
J6500 this may take up to 60% time of one CPU if the machine is loaded
via network traffic.

Since most people don't care about the LEDs, start with LEDs disabled and
just show a CPU heartbeat LED. The disk and LAN LEDs can be turned on
manually via /proc/pdc/led.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/parisc/led.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/parisc/led.c
+++ b/drivers/parisc/led.c
@@ -56,8 +56,8 @@
 static int led_type __read_mostly = -1;
 static unsigned char lastleds;	/* LED state from most recent update */
 static unsigned int led_heartbeat __read_mostly = 1;
-static unsigned int led_diskio    __read_mostly = 1;
-static unsigned int led_lanrxtx   __read_mostly = 1;
+static unsigned int led_diskio    __read_mostly;
+static unsigned int led_lanrxtx   __read_mostly;
 static char lcd_text[32]          __read_mostly;
 static char lcd_text_default[32]  __read_mostly;
 static int  lcd_no_led_support    __read_mostly = 0; /* KittyHawk doesn't support LED on its LCD */


