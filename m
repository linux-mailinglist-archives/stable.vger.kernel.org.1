Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CE2775B1A
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbjHILOU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbjHILOT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:14:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284E1ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:14:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1BAE63153
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A26C433C7;
        Wed,  9 Aug 2023 11:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579658;
        bh=xPYz9Qf1ltxneREIyjf/20IeNFScxEpylKzHSjoZiFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CIS4WHV5VNGjC/b4nMFGahha8FxVA5l5f63yY2uXqt3kdQ32ad3RFHVypDLBGtNI7
         IoA5iRsf3g06pDfvtSFu8Pm/ce4bjmeQNJ8S94YEfmyBRoDxRrA/+NR7nOS34t7yV4
         vi7xRv6XOSCsbP/XpD0XBDjnUQbz44hrQvmhmzu4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sui Jingfeng <suijingfeng@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 068/323] PCI: Add pci_clear_master() stub for non-CONFIG_PCI
Date:   Wed,  9 Aug 2023 12:38:26 +0200
Message-ID: <20230809103701.255549413@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
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

From: Sui Jingfeng <suijingfeng@loongson.cn>

[ Upstream commit 2aa5ac633259843f656eb6ecff4cf01e8e810c5e ]

Add a pci_clear_master() stub when CONFIG_PCI is not set so drivers that
support both PCI and platform devices don't need #ifdefs or extra Kconfig
symbols for the PCI parts.

[bhelgaas: commit log]
Fixes: 6a479079c072 ("PCI: Add pci_clear_master() as opposite of pci_set_master()")
Link: https://lore.kernel.org/r/20230531102744.2354313-1-suijingfeng@loongson.cn
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/pci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3e06e9790c255..1d1b0bfd51968 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1643,6 +1643,7 @@ static inline struct pci_dev *pci_get_class(unsigned int class,
 #define pci_dev_put(dev)	do { } while (0)
 
 static inline void pci_set_master(struct pci_dev *dev) { }
+static inline void pci_clear_master(struct pci_dev *dev) { }
 static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
 static inline void pci_disable_device(struct pci_dev *dev) { }
 static inline int pci_assign_resource(struct pci_dev *dev, int i)
-- 
2.39.2



