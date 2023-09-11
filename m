Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86A379C088
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242503AbjIKU6A (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240865AbjIKO4C (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:56:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BFB118
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:55:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2D3C433C8;
        Mon, 11 Sep 2023 14:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444157;
        bh=GVsi5Rh4VOtvve2Ohb5tgopq3uJf4mHuk+CTNvauALQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M2Rs2GuxQBmSYqMoMm2Fhh/A5xXSjHCBx/8hHBLVWO/SmHo+Qev+WQ0QpbMh3HSbT
         jgGTbTtzhr7gXWPN59ZLqUHJSzPKB/tpB/NsDi+Cl8dTkLycxGGpnYhc5dx9buaFke
         1rxsuwAJNXb5StHJ1FkPAuQwMas3mrPBjDuGcmXE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 630/737] um: virt-pci: fix missing declaration warning
Date:   Mon, 11 Sep 2023 15:48:09 +0200
Message-ID: <20230911134708.127403607@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vincent Whitchurch <vincent.whitchurch@axis.com>

[ Upstream commit 974b808d85abbc03c3914af63d60d5816aabf2ca ]

Fix this warning which appears with W=1 and without CONFIG_OF:

 warning: no previous declaration for 'pcibios_get_phb_of_node'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308230949.PphIIlhq-lkp@intel.com/
Fixes: 314a1408b79a ("um: virt-pci: implement pcibios_get_phb_of_node()")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/virt-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 7699ca5f35d48..ffe2ee8a02465 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -544,6 +544,7 @@ static void um_pci_irq_vq_cb(struct virtqueue *vq)
 	}
 }
 
+#ifdef CONFIG_OF
 /* Copied from arch/x86/kernel/devicetree.c */
 struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
 {
@@ -562,6 +563,7 @@ struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
 	}
 	return NULL;
 }
+#endif
 
 static int um_pci_init_vqs(struct um_pci_device *dev)
 {
-- 
2.40.1



