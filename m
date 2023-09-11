Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D75979B28A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359511AbjIKWRX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242301AbjIKP1L (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:27:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD50F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:27:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A8EC433C9;
        Mon, 11 Sep 2023 15:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694446027;
        bh=wvPjOIglBieHp99YVZ7EbU3eErqtrHKq8YJv+i+d8hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VSGpdL6KzQZ0oHqULVEp/fOwaO4FAW59RYkMH/RB10k00OhxikfrGU2jMVa64/Fa8
         vTy9D7zn3GGkO1gkLCMZZvY1YGyeebYsbPtOyUGPTU/AHr1PQ2L/WZFttGYpAA7Vva
         iRTNthqVY4WrZlJVUusi2AqCc9HfnXsglSUBxXjQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6.1 557/600] Revert "PCI: Mark NVIDIA T4 GPUs to avoid bus reset"
Date:   Mon, 11 Sep 2023 15:49:50 +0200
Message-ID: <20230911134650.056633003@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Helgaas <bhelgaas@google.com>

commit 5260bd6d36c83c5b269c33baaaf8c78e520908b0 upstream.

This reverts commit d5af729dc2071273f14cbb94abbc60608142fd83.

d5af729dc207 ("PCI: Mark NVIDIA T4 GPUs to avoid bus reset") avoided
Secondary Bus Reset on the T4 because the reset seemed to not work when the
T4 was directly attached to a Root Port.

But NVIDIA thinks the issue is probably related to some issue with the Root
Port, not with the T4.  The T4 provides neither PM nor FLR reset, so
masking bus reset compromises this device for assignment scenarios.

Revert d5af729dc207 as requested by Wu Zongyong.  This will leave SBR
broken in the specific configuration Wu tested, as it was in v6.5, so Wu
will debug that further.

Link: https://lore.kernel.org/r/ZPqMCDWvITlOLHgJ@wuzongyong-alibaba
Link: https://lore.kernel.org/r/20230908201104.GA305023@bhelgaas
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/quirks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3631,7 +3631,7 @@ static void quirk_no_bus_reset(struct pc
  */
 static void quirk_nvidia_no_bus_reset(struct pci_dev *dev)
 {
-	if ((dev->device & 0xffc0) == 0x2340 || dev->device == 0x1eb8)
+	if ((dev->device & 0xffc0) == 0x2340)
 		quirk_no_bus_reset(dev);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,


