Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C35D775A2D
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjHILF7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjHILF7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:05:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABBD1724
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:05:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3D756309F
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3640C433C8;
        Wed,  9 Aug 2023 11:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579157;
        bh=pBNfEecOGy5y0g4apnTJFUrxtuxRusLi22Jiv62NQNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XMMKjraXNt3dwwRM4dn1xye5RMTON3ZZD9+nsYqS8ZsxiszJ6iBLYcnSwev+qZp6N
         d5+Ehu9zrn4YTL/uQUaCwbtzZQzxUObZAFMYAgHKu6WxPlL7MXu4Upm0PCcK0Js4kP
         xhT+1FHtA1l8IAfo9UpUUlNVA4QBuICIKWiWBHZ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuan Can <yuancan@huawei.com>,
        Jon Mason <jdmason@kudzu.us>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 095/204] ntb: idt: Fix error handling in idt_pci_driver_init()
Date:   Wed,  9 Aug 2023 12:40:33 +0200
Message-ID: <20230809103645.816694704@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index b68e2cad74cc7..d6f68a17bbd91 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2689,6 +2689,7 @@ static struct pci_driver idt_pci_driver = {
 
 static int __init idt_pci_driver_init(void)
 {
+	int ret;
 	pr_info("%s %s\n", NTB_DESC, NTB_VER);
 
 	/* Create the top DebugFS directory if the FS is initialized */
@@ -2696,7 +2697,11 @@ static int __init idt_pci_driver_init(void)
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



