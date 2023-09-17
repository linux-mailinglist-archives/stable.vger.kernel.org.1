Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF84B7A3BFD
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240866AbjIQUZH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240870AbjIQUYt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:24:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0E9101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:24:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF963C433C7;
        Sun, 17 Sep 2023 20:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982284;
        bh=451Shb3luee5bCs6OQxFA8qxgTgJfVgA3XCXOyQu9Ms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BaW51y4DD2B/k22UjcLghSHMeuOXBwOq+Kwed2gdwkHQQxi0+5PdXI8+Mzm3vIrrU
         oZsWciRqQrQ3hmMh8+bGNttMVAjZ6Nls96DXMJ1TjJbKhpx8MdwnWnUN6LWqbdi+mM
         zHkU8+jjm4ELBejxIbfSP8IOUi19d5VMoQBzFgv0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 205/511] PCI: Mark NVIDIA T4 GPUs to avoid bus reset
Date:   Sun, 17 Sep 2023 21:10:32 +0200
Message-ID: <20230917191118.774768421@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wu Zongyong <wuzongyong@linux.alibaba.com>

[ Upstream commit d5af729dc2071273f14cbb94abbc60608142fd83 ]

NVIDIA T4 GPUs do not work with SBR. This problem is found when the T4 card
is direct attached to a Root Port only. Avoid bus reset by marking T4 GPUs
PCI_DEV_FLAGS_NO_BUS_RESET.

Fixes: 4c207e7121fa ("PCI: Mark some NVIDIA GPUs to avoid bus reset")
Link: https://lore.kernel.org/r/2dcebea53a6eb9bd212ec6d8974af2e5e0333ef6.1681129861.git.wuzongyong@linux.alibaba.com
Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ec17d42c2a155..2f26058178c31 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3606,7 +3606,7 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
  */
 static void quirk_nvidia_no_bus_reset(struct pci_dev *dev)
 {
-	if ((dev->device & 0xffc0) == 0x2340)
+	if ((dev->device & 0xffc0) == 0x2340 || dev->device == 0x1eb8)
 		quirk_no_bus_reset(dev);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
-- 
2.40.1



