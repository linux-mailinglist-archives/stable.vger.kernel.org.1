Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2257874C3C7
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjGILgN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjGILgM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:36:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5E9194
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:36:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE65960B51
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21E5C433C7;
        Sun,  9 Jul 2023 11:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902570;
        bh=rZ8cr4f6MXhE0fL75aITSnSdYoSLbEzaTc2DgnyWeyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RMYsqd2MH6gmYerFVW+IDtjCquMCYOH83Y+qclztHCmwUSo4Phmf4ew/t8NBQxYUF
         ahTxCHGKZ/OEd3i43Yzb7upJLVISgPxbaGPWJVEES6aCcdRzT8aHZ2q2jo7Pt7egdx
         vDRXXnn8CaEcgXAzpX0p8cXJYXfjNIL6GhiGDiss=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Xinghui Li <korantli@tencent.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 396/431] PCI: vmd: Fix uninitialized variable usage in vmd_enable_domain()
Date:   Sun,  9 Jul 2023 13:15:44 +0200
Message-ID: <20230709111500.456458253@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Xinghui Li <korantli@tencent.com>

[ Upstream commit 0c0206dc4f5ba2d18b15e24d2047487d6f73916b ]

The ret variable in the vmd_enable_domain() function was used
uninitialized when printing a warning message upon failure of
the pci_reset_bus() function.

Thus, fix the issue by assigning ret with the value returned from
pci_reset_bus() before referencing it in the warning message.

This was detected by Smatch:

  drivers/pci/controller/vmd.c:931 vmd_enable_domain() error: uninitialized symbol 'ret'.

[kwilczynski: drop the second patch from the series, add missing reported
by tag, commit log]
Fixes: 0a584655ef89 ("PCI: vmd: Fix secondary bus reset for Intel bridges")
Link: https://lore.kernel.org/all/202305270219.B96IiIfv-lkp@intel.com
Link: https://lore.kernel.org/linux-pci/20230420094332.1507900-2-korantwork@gmail.com
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Xinghui Li <korantli@tencent.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/vmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 30ec18283aaf4..e718a816d4814 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -927,7 +927,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		if (!list_empty(&child->devices)) {
 			dev = list_first_entry(&child->devices,
 					       struct pci_dev, bus_list);
-			if (pci_reset_bus(dev))
+			ret = pci_reset_bus(dev);
+			if (ret)
 				pci_warn(dev, "can't reset device: %d\n", ret);
 
 			break;
-- 
2.39.2



