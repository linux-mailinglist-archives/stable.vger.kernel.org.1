Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE3275CD7A
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjGUQL4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjGUQLg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:11:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA5A421C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:11:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB91061D4A
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE85EC433BA;
        Fri, 21 Jul 2023 16:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955872;
        bh=7Zh4UMXAdLAK1GlRpiffl2cLRRBp+VopQ6CZRr+PVu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eW1rde0qSq2Oxw2ePKqu7C7l1EpdfvZdrSWKTGSiIAFzqWZFWz2MV6YHnLt2hOqO5
         1SnNcuXAFU1lrSJ2tO4U/g3MkG/uy7xE+v3MdeEVUcrFeJjH6BFCKaCpchasY4qv+6
         /akAGg8luhOwEa8a7uug8zNrGdV7dquwGGeW/Xsg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuan Can <yuancan@huawei.com>,
        Jon Mason <jdmason@kudzu.us>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 060/292] NTB: amd: Fix error handling in amd_ntb_pci_driver_init()
Date:   Fri, 21 Jul 2023 18:02:49 +0200
Message-ID: <20230721160531.374796153@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yuan Can <yuancan@huawei.com>

[ Upstream commit 98af0a33c1101c29b3ce4f0cf4715fd927c717f9 ]

A problem about ntb_hw_amd create debugfs failed is triggered with the
following log given:

 [  618.431232] AMD(R) PCI-E Non-Transparent Bridge Driver 1.0
 [  618.433284] debugfs: Directory 'ntb_hw_amd' with parent '/' already present!

The reason is that amd_ntb_pci_driver_init() returns pci_register_driver()
directly without checking its return value, if pci_register_driver()
failed, it returns without destroy the newly created debugfs, resulting
the debugfs of ntb_hw_amd can never be created later.

 amd_ntb_pci_driver_init()
   debugfs_create_dir() # create debugfs directory
   pci_register_driver()
     driver_register()
       bus_add_driver()
         priv = kzalloc(...) # OOM happened
   # return without destroy debugfs directory

Fix by removing debugfs when pci_register_driver() returns error.

Fixes: a1b3695820aa ("NTB: Add support for AMD PCI-Express Non-Transparent Bridge")
Signed-off-by: Yuan Can <yuancan@huawei.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 04550b1f984c6..730f2103b91d1 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1338,12 +1338,17 @@ static struct pci_driver amd_ntb_pci_driver = {
 
 static int __init amd_ntb_pci_driver_init(void)
 {
+	int ret;
 	pr_info("%s %s\n", NTB_DESC, NTB_VER);
 
 	if (debugfs_initialized())
 		debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
-	return pci_register_driver(&amd_ntb_pci_driver);
+	ret = pci_register_driver(&amd_ntb_pci_driver);
+	if (ret)
+		debugfs_remove_recursive(debugfs_dir);
+
+	return ret;
 }
 module_init(amd_ntb_pci_driver_init);
 
-- 
2.39.2



