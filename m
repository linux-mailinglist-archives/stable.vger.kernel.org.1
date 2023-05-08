Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A8D6FAC13
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbjEHLUd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbjEHLUc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:20:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC972387F2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:20:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7295F62C7D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83829C433EF;
        Mon,  8 May 2023 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544829;
        bh=kPlUUA4DjkPa9wuT4S37MyKf4L7fho3IXW1JRMFiZGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M+bTT26Ck8yPS6oPE4slY5kgey36T09scYxSF/KLaxVX3zIlyf8+ni4V0Oe2zbDvq
         FfopBURQqXbdkAzIti94K5rKm+s9WpiOcm4QRzk8MSIOxX+IWMx5pQsAJAEd8IEwnn
         HzEc2F3oBDJkqXGfIJDAtC+D3CR2SdopWb3GiS5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhiyi Guo <zhguo@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tarun Gupta <targupta@nvidia.com>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 536/694] PCI/PM: Extend D3hot delay for NVIDIA HDA controllers
Date:   Mon,  8 May 2023 11:46:11 +0200
Message-Id: <20230508094451.796392376@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alex Williamson <alex.williamson@redhat.com>

[ Upstream commit a5a6dd2624698b6e3045c3a1450874d8c790d5d9 ]

Assignment of NVIDIA Ampere-based GPUs have seen a regression since the
below referenced commit, where the reduced D3hot transition delay appears
to introduce a small window where a D3hot->D0 transition followed by a bus
reset can wedge the device.  The entire device is subsequently unavailable,
returning -1 on config space read and is unrecoverable without a host
reset.

This has been observed with RTX A2000 and A5000 GPU and audio functions
assigned to a Windows VM, where shutdown of the VM places the devices in
D3hot prior to vfio-pci performing a bus reset when userspace releases the
devices.  The issue has roughly a 2-3% chance of occurring per shutdown.

Restoring the HDA controller d3hot_delay to the effective value before the
below commit has been shown to resolve the issue.  NVIDIA confirms this
change should be safe for all of their HDA controllers.

Fixes: 3e347969a577 ("PCI/PM: Reduce D3hot delay with usleep_range()")
Link: https://lore.kernel.org/r/20230413194042.605768-1-alex.williamson@redhat.com
Reported-by: Zhiyi Guo <zhguo@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Tarun Gupta <targupta@nvidia.com>
Cc: Abhishek Sahu <abhsahu@nvidia.com>
Cc: Tarun Gupta <targupta@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 44cab813bf951..f4e2a88729fd1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1939,6 +1939,19 @@ static void quirk_radeon_pm(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6741, quirk_radeon_pm);
 
+/*
+ * NVIDIA Ampere-based HDA controllers can wedge the whole device if a bus
+ * reset is performed too soon after transition to D0, extend d3hot_delay
+ * to previous effective default for all NVIDIA HDA controllers.
+ */
+static void quirk_nvidia_hda_pm(struct pci_dev *dev)
+{
+	quirk_d3hot_delay(dev, 20);
+}
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
+			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8,
+			      quirk_nvidia_hda_pm);
+
 /*
  * Ryzen5/7 XHCI controllers fail upon resume from runtime suspend or s2idle.
  * https://bugzilla.kernel.org/show_bug.cgi?id=205587
-- 
2.39.2



