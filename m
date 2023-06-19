Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87392735235
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjFSKcT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjFSKcS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:32:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B31CC
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:32:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78CA660B6D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D86FC433C0;
        Mon, 19 Jun 2023 10:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170735;
        bh=uVLvJFqCtBCFoD3U8CvCkGWS/edNg3ODXo2sOwJUcl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RhLBEYVXl5/5nc7Lhm0kAH82uxRjQg4Ll0StngFEeHshyVcqA/GQpX6jQP5WMTtjm
         urKXvBVyMV9gw+z82RsuzoiQrZjFpUe+1Cr6o+YYy5Eg7LnFg6jSkHA0JD1JX3QxTB
         lCS9/XF/1Jn9Z4wqrrUDRyvkybMfNPXtjwCRl3S0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mark Blakeney <mark.blakeney@bullet-systems.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 017/187] PCI/DPC: Quirk PIO log size for Intel Ice Lake Root Ports
Date:   Mon, 19 Jun 2023 12:27:15 +0200
Message-ID: <20230619102158.452023884@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 3b8803494a0612acdeee714cb72aa142b1e05ce5 ]

Commit 5459c0b70467 ("PCI/DPC: Quirk PIO log size for certain Intel Root
Ports") added quirks for Tiger and Alder Lake Root Ports but missed that
the same issue exists also in the previous generation, Ice Lake.

Apply the quirk for Ice Lake Root Ports as well.  This prevents kernel
complaints like:

  DPC: RP PIO log size 0 is invalid

and also enables the DPC driver to dump the RP PIO Log registers when DPC
is triggered.

[bhelgaas: add dmesg warning and RP PIO Log dump info]
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=209943
Link: https://lore.kernel.org/r/20230511121905.73949-1-mika.westerberg@linux.intel.com
Reported-by: Mark Blakeney <mark.blakeney@bullet-systems.net>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f4e2a88729fd1..c525867760bf8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6003,8 +6003,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency
 
 #ifdef CONFIG_PCIE_DPC
 /*
- * Intel Tiger Lake and Alder Lake BIOS has a bug that clears the DPC
- * RP PIO Log Size of the integrated Thunderbolt PCIe Root Ports.
+ * Intel Ice Lake, Tiger Lake and Alder Lake BIOS has a bug that clears
+ * the DPC RP PIO Log Size of the integrated Thunderbolt PCIe Root
+ * Ports.
  */
 static void dpc_log_size(struct pci_dev *dev)
 {
@@ -6027,6 +6028,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x461f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x462f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x463f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x466e, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8a1d, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8a1f, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8a21, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8a23, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a23, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a25, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a27, dpc_log_size);
-- 
2.39.2



