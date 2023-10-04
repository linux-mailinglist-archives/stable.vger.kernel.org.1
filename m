Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F187B8772
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243792AbjJDSF0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243777AbjJDSFZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:05:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD5AA7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:05:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAC9C433C9;
        Wed,  4 Oct 2023 18:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442721;
        bh=ftSUN+XPDGIe7GLZjBF4SRqb+VD/apfv5YOYlikHSB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lx72D9bjWp05dNC+Np9AbOQdhlgITBRRGgJ5CYtW+QZ2RbH5a8Bf1jyI6uuIbJtCh
         ip+1T9pxkMicet60fAvxPJhO3apDVzDTNl1b3pI/jscYOiDkrP3/VyP035y1gW8Xgs
         KEQB2hqoUxN17QeEUW8uFjLt+byw0yqHzSKW8N3U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paul Menzel <pmenzel@molgen.mpg.de>,
        Tejun Heo <tj@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 085/183] ata: ahci: Add support for AMD A85 FCH (Hudson D4)
Date:   Wed,  4 Oct 2023 19:55:16 +0200
Message-ID: <20231004175207.423366172@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
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

From: Paul Menzel <pmenzel@molgen.mpg.de>

[ Upstream commit a17ab7aba5df4135ef77d7f6d7105e1ea414936f ]

Add support for the AMD A85 FCH (Hudson D4) AHCI adapter.

Since this adapter does not require the default 200 ms debounce delay
in sata_link_resume(), create a new board board_ahci_no_debounce_delay
with the link flag ATA_LFLAG_NO_DEBOUNCE_DELAY, and, for now, configure
the AMD A85 FCH (Hudson D4) to use it. On the ASUS F2A85-M PRO it
reduces the Linux kernel boot time by the expected 200 ms from 787 ms
to 585 ms.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Stable-dep-of: 2a2df98ec592 ("ata: ahci: Add Elkhart Lake AHCI controller")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/ahci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 719fe2e2b36c2..44658ba331c6a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -51,6 +51,7 @@ enum board_ids {
 	board_ahci,
 	board_ahci_ign_iferr,
 	board_ahci_mobile,
+	board_ahci_no_debounce_delay,
 	board_ahci_nomsi,
 	board_ahci_noncq,
 	board_ahci_nosntf,
@@ -142,6 +143,13 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
+	[board_ahci_no_debounce_delay] = {
+		.flags		= AHCI_FLAG_COMMON,
+		.link_flags	= ATA_LFLAG_NO_DEBOUNCE_DELAY,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 	[board_ahci_nomsi] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_MSI),
 		.flags		= AHCI_FLAG_COMMON,
@@ -442,6 +450,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 		board_ahci_al },
 	/* AMD */
 	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
+	{ PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /* AMD Hudson-2 (AHCI mode) */
 	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
 	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Green Sardine */
 	/* AMD is using RAID class only for ahci controllers */
-- 
2.40.1



