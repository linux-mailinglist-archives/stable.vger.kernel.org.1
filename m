Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB05775B77
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjHILRr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjHILRq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:17:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEA8FA
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:17:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E092763185
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E16C433C8;
        Wed,  9 Aug 2023 11:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579865;
        bh=EgkeQbUeDTcschXzVRWWdx3bCJ0wVsNmqSIYObpI270=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gzfyG3aYnxnRZpIYJyjp8506JjDPII8WniQbcj909wK51dEU3+JymAsv0YFF+C6vp
         fHU7/cZSn7hNSTc7tbzfUGTZlRh0MqrEr8oPSj6Gf1UQIpvfheEn9KywzjzYZMuK2D
         pZv1VC+4aE66TT9lCIOApS+s2M5eK/Zdkcsy7/EY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuan Can <yuancan@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jon Mason <jdmason@kudzu.us>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 144/323] ntb: intel: Fix error handling in intel_ntb_pci_driver_init()
Date:   Wed,  9 Aug 2023 12:39:42 +0200
Message-ID: <20230809103704.733126363@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yuan Can <yuancan@huawei.com>

[ Upstream commit 4c3c796aca02883ad35bb117468938cc4022ca41 ]

A problem about ntb_hw_intel create debugfs failed is triggered with the
following log given:

 [  273.112733] Intel(R) PCI-E Non-Transparent Bridge Driver 2.0
 [  273.115342] debugfs: Directory 'ntb_hw_intel' with parent '/' already present!

The reason is that intel_ntb_pci_driver_init() returns
pci_register_driver() directly without checking its return value, if
pci_register_driver() failed, it returns without destroy the newly created
debugfs, resulting the debugfs of ntb_hw_intel can never be created later.

 intel_ntb_pci_driver_init()
   debugfs_create_dir() # create debugfs directory
   pci_register_driver()
     driver_register()
       bus_add_driver()
         priv = kzalloc(...) # OOM happened
   # return without destroy debugfs directory

Fix by removing debugfs when pci_register_driver() returns error.

Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
Signed-off-by: Yuan Can <yuancan@huawei.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/hw/intel/ntb_hw_gen1.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index 2ad263f708da7..084bd1d1ac1dc 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -2052,12 +2052,17 @@ static struct pci_driver intel_ntb_pci_driver = {
 
 static int __init intel_ntb_pci_driver_init(void)
 {
+	int ret;
 	pr_info("%s %s\n", NTB_DESC, NTB_VER);
 
 	if (debugfs_initialized())
 		debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
-	return pci_register_driver(&intel_ntb_pci_driver);
+	ret = pci_register_driver(&intel_ntb_pci_driver);
+	if (ret)
+		debugfs_remove_recursive(debugfs_dir);
+
+	return ret;
 }
 module_init(intel_ntb_pci_driver_init);
 
-- 
2.39.2



