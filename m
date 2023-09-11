Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F55579AD04
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244159AbjIKVIL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239093AbjIKOLc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:11:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214EFCA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:11:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A0EC433C9;
        Mon, 11 Sep 2023 14:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441487;
        bh=o1/7yg+yoXJ4OetYIdtfJN418BnAWah0pveV5+vJ1zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7qKi0WMl5FQeSTGCCV+2EPX88NVhOscB2o0KI+c75jP5jMy+VIcg9M+IysBYlVei
         4Kh1nNih2JkFDqmwdeMq3ISOhxEq7HhEnpFffJZ+7n3rqbhyg9SLy3s9bH4/T5aPgQ
         i/EN9OvIu3IT8GXkcCARNkw5K3ZBAbWQ1ZUNjm18=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 403/739] PCI: Mark NVIDIA T4 GPUs to avoid bus reset
Date:   Mon, 11 Sep 2023 15:43:22 +0200
Message-ID: <20230911134702.437017586@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
index 321156ca273d5..dc96a126aad4e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3724,7 +3724,7 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
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



