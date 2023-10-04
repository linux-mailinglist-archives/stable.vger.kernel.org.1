Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628D67B8774
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243794AbjJDSFb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243787AbjJDSFa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:05:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70ACA6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:05:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBACC433C9;
        Wed,  4 Oct 2023 18:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442727;
        bh=i5+xEtzpFP+K8S8j/Atx7Ubn5DxMXgNfxyDvjBGiGvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rg4so1Y9dMDWGX++KClmGmVtZtY1bvAnR3Myoj337swcT2s7/L8HZSyR5T0B6B5Eu
         Ifk/Po849oRWI8Vj5NfTX88zScgguFIXjMnfaVGUiKOy/zGZtasrG6rBEtmzPaNdrh
         cQ7NWYNWjHj7pAaRC91FJOK+hMN50K1OxmhaE0Tc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Werner Fischer <devlists@wefi.net>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 087/183] ata: ahci: Add Elkhart Lake AHCI controller
Date:   Wed,  4 Oct 2023 19:55:18 +0200
Message-ID: <20231004175207.505590292@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Werner Fischer <devlists@wefi.net>

[ Upstream commit 2a2df98ec592667927b5c1351afa6493ea125c9f ]

Elkhart Lake is the successor of Apollo Lake and Gemini Lake. These
CPUs and their PCHs are used in mobile and embedded environments.

With this patch I suggest that Elkhart Lake SATA controllers [1] should
use the default LPM policy for mobile chipsets.
The disadvantage of missing hot-plug support with this setting should
not be an issue, as those CPUs are used in embedded environments and
not in servers with hot-plug backplanes.

We discovered that the Elkhart Lake SATA controllers have been missing
in ahci.c after a customer reported the throttling of his SATA SSD
after a short period of higher I/O. We determined the high temperature
of the SSD controller in idle mode as the root cause for that.

Depending on the used SSD, we have seen up to 1.8 Watt lower system
idle power usage and up to 30°C lower SSD controller temperatures in
our tests, when we set med_power_with_dipm manually. I have provided a
table showing seven different SATA SSDs from ATP, Intel/Solidigm and
Samsung [2].

Intel lists a total of 3 SATA controller IDs (4B60, 4B62, 4B63) in [1]
for those mobile PCHs.
This commit just adds 0x4b63 as I do not have test systems with 0x4b60
and 0x4b62 SATA controllers.
I have tested this patch with a system which uses 0x4b63 as SATA
controller.

[1] https://sata-io.org/product/8803
[2] https://www.thomas-krenn.com/en/wiki/SATA_Link_Power_Management#Example_LES_v4

Signed-off-by: Werner Fischer <devlists@wefi.net>
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/ahci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 3679433108eca..3147b2e6cd8c9 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -425,6 +425,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci_low_power }, /* Ice Lake LP AHCI */
 	{ PCI_VDEVICE(INTEL, 0x02d3), board_ahci_low_power }, /* Comet Lake PCH-U AHCI */
 	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_low_power }, /* Comet Lake PCH RAID */
+	/* Elkhart Lake IDs 0x4b60 & 0x4b62 https://sata-io.org/product/8803 not tested yet */
+	{ PCI_VDEVICE(INTEL, 0x4b63), board_ahci_low_power }, /* Elkhart Lake AHCI */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-- 
2.40.1



