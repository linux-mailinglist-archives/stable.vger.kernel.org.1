Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7B275D41E
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjGUTSK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjGUTSJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:18:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9614E3A85
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:17:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35D7161D70
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F86C433C9;
        Fri, 21 Jul 2023 19:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967078;
        bh=valDxcbwD86q6Dqhmgsn3bQ61zmpH5uEzL+jpcukp3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W1iF4Qes2ZvyfymKyt8AxEumcrNnuyPr/WmEkqeh9zQCUUERiSiUn6Q8CFRchDmIw
         o7qfLon2IrYqOw/hoRrU/CiGBzEG0N+eoNLHIprharKFUBIn5CarVh6M8J1OiWHDx4
         4ZKbkVsHNM1Fur3wAvIqMvr5eJakpRh1oRSZ2/o8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuan Can <yuancan@huawei.com>,
        Jon Mason <jdmason@kudzu.us>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 036/223] ntb: idt: Fix error handling in idt_pci_driver_init()
Date:   Fri, 21 Jul 2023 18:04:49 +0200
Message-ID: <20230721160522.405033086@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yuan Can <yuancan@huawei.com>

[ Upstream commit c012968259b451dc4db407f2310fe131eaefd800 ]

A problem about ntb_hw_idt create debugfs failed is triggered with the
following log given:

 [ 1236.637636] IDT PCI-E Non-Transparent Bridge Driver 2.0
 [ 1236.639292] debugfs: Directory 'ntb_hw_idt' with parent '/' already present!

The reason is that idt_pci_driver_init() returns pci_register_driver()
directly without checking its return value, if pci_register_driver()
failed, it returns without destroy the newly created debugfs, resulting
the debugfs of ntb_hw_idt can never be created later.

 idt_pci_driver_init()
   debugfs_create_dir() # create debugfs directory
   pci_register_driver()
     driver_register()
       bus_add_driver()
         priv = kzalloc(...) # OOM happened
   # return without destroy debugfs directory

Fix by removing debugfs when pci_register_driver() returns error.

Fixes: bf2a952d31d2 ("NTB: Add IDT 89HPESxNTx PCIe-switches support")
Signed-off-by: Yuan Can <yuancan@huawei.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 0ed6f809ff2ee..51799fccf8404 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2891,6 +2891,7 @@ static struct pci_driver idt_pci_driver = {
 
 static int __init idt_pci_driver_init(void)
 {
+	int ret;
 	pr_info("%s %s\n", NTB_DESC, NTB_VER);
 
 	/* Create the top DebugFS directory if the FS is initialized */
@@ -2898,7 +2899,11 @@ static int __init idt_pci_driver_init(void)
 		dbgfs_topdir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
 	/* Register the NTB hardware driver to handle the PCI device */
-	return pci_register_driver(&idt_pci_driver);
+	ret = pci_register_driver(&idt_pci_driver);
+	if (ret)
+		debugfs_remove_recursive(dbgfs_topdir);
+
+	return ret;
 }
 module_init(idt_pci_driver_init);
 
-- 
2.39.2



