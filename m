Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4D07A7DE4
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbjITMNM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbjITMNL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:13:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA444C2
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:13:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64E6C433C8;
        Wed, 20 Sep 2023 12:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211985;
        bh=B0eqCZHDEt29SwoAuF77RLWz81Aty7CPgkjYwlqge5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KcSZZ7G3YJ/qioNyZ0It5idxsECm7zrJ5/GnMJ/uxsa7xp54iR4hsEwECRNt1PpKa
         KerGB/3sB6TXJKdjOjwBbLVedLSwLDXYRj1DaABc1D7dpr9G2QDDiEaanol2ODlxNF
         yUfwJg+FSnkBN7R//koDF/SjL39SDYMO0dCAnC2U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 108/273] PCI: Mark NVIDIA T4 GPUs to avoid bus reset
Date:   Wed, 20 Sep 2023 13:29:08 +0200
Message-ID: <20230920112849.813755295@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index fa9d6c8f1cf89..a43e0e20b1ea6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3472,7 +3472,7 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
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



