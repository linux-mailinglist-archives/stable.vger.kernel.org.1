Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123E077ACBC
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjHMVg3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjHMVg3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:36:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2828D10DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:36:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B393562D18
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4DAC433C8;
        Sun, 13 Aug 2023 21:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962590;
        bh=njk2PxPL5R2Be4lqCjm40bk+UlF9BUA19li5fEx/r2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jlmt5IpVhsduxa1LXo0qfHirtxbBYKnINBUFl7x9hHJM9kyeenbOvBOEP+1pWL528
         Y7E1SWXpY32huEsL0Gd5mUwcHl9mBYN1lhlFLzrqicLUQPd0DS38kBWzKEVMrDTch4
         jucxt5H+3fffK19yMHgX4d61IAUXQhwXXsuuiBd4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ricky Wu <ricky_wu@realtek.com>
Subject: [PATCH 6.1 057/149] misc: rtsx: judge ASPM Mode to set PETXCFG Reg
Date:   Sun, 13 Aug 2023 23:18:22 +0200
Message-ID: <20230813211720.520186679@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ricky WU <ricky_wu@realtek.com>

commit 101bd907b4244a726980ee67f95ed9cafab6ff7a upstream.

ASPM Mode is ASPM_MODE_CFG need to judge the value of clkreq_0
to set HIGH or LOW, if the ASPM Mode is ASPM_MODE_REG
always set to HIGH during the initialization.

Cc: stable@vger.kernel.org
Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
Link: https://lore.kernel.org/r/52906c6836374c8cb068225954c5543a@realtek.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/cardreader/rts5227.c  |    2 +-
 drivers/misc/cardreader/rts5228.c  |   18 ------------------
 drivers/misc/cardreader/rts5249.c  |    3 +--
 drivers/misc/cardreader/rts5260.c  |   18 ------------------
 drivers/misc/cardreader/rts5261.c  |   18 ------------------
 drivers/misc/cardreader/rtsx_pcr.c |    5 ++++-
 6 files changed, 6 insertions(+), 58 deletions(-)

--- a/drivers/misc/cardreader/rts5227.c
+++ b/drivers/misc/cardreader/rts5227.c
@@ -195,7 +195,7 @@ static int rts5227_extra_init_hw(struct
 		}
 	}
 
-	if (option->force_clkreq_0)
+	if (option->force_clkreq_0 && pcr->aspm_mode == ASPM_MODE_CFG)
 		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG,
 				FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
 	else
--- a/drivers/misc/cardreader/rts5228.c
+++ b/drivers/misc/cardreader/rts5228.c
@@ -435,17 +435,10 @@ static void rts5228_init_from_cfg(struct
 			option->ltr_enabled = false;
 		}
 	}
-
-	if (rtsx_check_dev_flag(pcr, ASPM_L1_1_EN | ASPM_L1_2_EN
-				| PM_L1_1_EN | PM_L1_2_EN))
-		option->force_clkreq_0 = false;
-	else
-		option->force_clkreq_0 = true;
 }
 
 static int rts5228_extra_init_hw(struct rtsx_pcr *pcr)
 {
-	struct rtsx_cr_option *option = &pcr->option;
 
 	rtsx_pci_write_register(pcr, RTS5228_AUTOLOAD_CFG1,
 			CD_RESUME_EN_MASK, CD_RESUME_EN_MASK);
@@ -476,17 +469,6 @@ static int rts5228_extra_init_hw(struct
 	else
 		rtsx_pci_write_register(pcr, PETXCFG, 0x30, 0x00);
 
-	/*
-	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
-	 * to drive low, and we forcibly request clock.
-	 */
-	if (option->force_clkreq_0)
-		rtsx_pci_write_register(pcr, PETXCFG,
-				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
-	else
-		rtsx_pci_write_register(pcr, PETXCFG,
-				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
-
 	rtsx_pci_write_register(pcr, PWD_SUSPEND_EN, 0xFF, 0xFB);
 
 	if (pcr->rtd3_en) {
--- a/drivers/misc/cardreader/rts5249.c
+++ b/drivers/misc/cardreader/rts5249.c
@@ -327,12 +327,11 @@ static int rts5249_extra_init_hw(struct
 		}
 	}
 
-
 	/*
 	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
 	 * to drive low, and we forcibly request clock.
 	 */
-	if (option->force_clkreq_0)
+	if (option->force_clkreq_0 && pcr->aspm_mode == ASPM_MODE_CFG)
 		rtsx_pci_write_register(pcr, PETXCFG,
 			FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
 	else
--- a/drivers/misc/cardreader/rts5260.c
+++ b/drivers/misc/cardreader/rts5260.c
@@ -517,17 +517,10 @@ static void rts5260_init_from_cfg(struct
 			option->ltr_enabled = false;
 		}
 	}
-
-	if (rtsx_check_dev_flag(pcr, ASPM_L1_1_EN | ASPM_L1_2_EN
-				| PM_L1_1_EN | PM_L1_2_EN))
-		option->force_clkreq_0 = false;
-	else
-		option->force_clkreq_0 = true;
 }
 
 static int rts5260_extra_init_hw(struct rtsx_pcr *pcr)
 {
-	struct rtsx_cr_option *option = &pcr->option;
 
 	/* Set mcu_cnt to 7 to ensure data can be sampled properly */
 	rtsx_pci_write_register(pcr, 0xFC03, 0x7F, 0x07);
@@ -546,17 +539,6 @@ static int rts5260_extra_init_hw(struct
 
 	rts5260_init_hw(pcr);
 
-	/*
-	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
-	 * to drive low, and we forcibly request clock.
-	 */
-	if (option->force_clkreq_0)
-		rtsx_pci_write_register(pcr, PETXCFG,
-				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
-	else
-		rtsx_pci_write_register(pcr, PETXCFG,
-				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
-
 	rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x10, 0x00);
 
 	return 0;
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -498,17 +498,10 @@ static void rts5261_init_from_cfg(struct
 			option->ltr_enabled = false;
 		}
 	}
-
-	if (rtsx_check_dev_flag(pcr, ASPM_L1_1_EN | ASPM_L1_2_EN
-				| PM_L1_1_EN | PM_L1_2_EN))
-		option->force_clkreq_0 = false;
-	else
-		option->force_clkreq_0 = true;
 }
 
 static int rts5261_extra_init_hw(struct rtsx_pcr *pcr)
 {
-	struct rtsx_cr_option *option = &pcr->option;
 	u32 val;
 
 	rtsx_pci_write_register(pcr, RTS5261_AUTOLOAD_CFG1,
@@ -554,17 +547,6 @@ static int rts5261_extra_init_hw(struct
 	else
 		rtsx_pci_write_register(pcr, PETXCFG, 0x30, 0x00);
 
-	/*
-	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
-	 * to drive low, and we forcibly request clock.
-	 */
-	if (option->force_clkreq_0)
-		rtsx_pci_write_register(pcr, PETXCFG,
-				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
-	else
-		rtsx_pci_write_register(pcr, PETXCFG,
-				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
-
 	rtsx_pci_write_register(pcr, PWD_SUSPEND_EN, 0xFF, 0xFB);
 
 	if (pcr->rtd3_en) {
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1326,8 +1326,11 @@ static int rtsx_pci_init_hw(struct rtsx_
 			return err;
 	}
 
-	if (pcr->aspm_mode == ASPM_MODE_REG)
+	if (pcr->aspm_mode == ASPM_MODE_REG) {
 		rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, 0x30, 0x30);
+		rtsx_pci_write_register(pcr, PETXCFG,
+				FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
+	}
 
 	/* No CD interrupt if probing driver with card inserted.
 	 * So we need to initialize pcr->card_exist here.


