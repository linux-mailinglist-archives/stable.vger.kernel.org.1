Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5909676AEF8
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjHAJnn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjHAJn0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:43:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FD05FF6
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:41:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B41F6151F
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DD6C433C7;
        Tue,  1 Aug 2023 09:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882868;
        bh=Z2dVW5ltn2ElYLZWBhidtHujT4gfctGfMvwQrSfG71c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IrEKj44aNy4XODLRPH9Cn4H7Xvkw+xNjogh62cSSr+E5NAfk4PjaoI/c1Kh3i8+Bt
         GaGRQua+/mlZlOo94ONM5vyuLdy5moezgVzkJOwBQZhrA3vK6A8ZpofnNETFEXWWO6
         MaZ478LuSOLL7A+fhlRJLuJWbyjd2OpySPpT8GXQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.4 005/239] r8169: revert 2ab19de62d67 ("r8169: remove ASPM restrictions now that ASPM is disabled during NAPI poll")
Date:   Tue,  1 Aug 2023 11:17:49 +0200
Message-ID: <20230801091925.837435794@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

commit cf2ffdea0839398cb0551762af7f5efb0a6e0fea upstream.

There have been reports that on a number of systems this change breaks
network connectivity. Therefore effectively revert it. Mainly affected
seem to be systems where BIOS denies ASPM access to OS.
Due to later changes we can't do a direct revert.

Fixes: 2ab19de62d67 ("r8169: remove ASPM restrictions now that ASPM is disabled during NAPI poll")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/netdev/e47bac0d-e802-65e1-b311-6acb26d5cf10@freenet.de/T/
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217596
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://lore.kernel.org/r/57f13ec0-b216-d5d8-363d-5b05528ec5fb@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169_main.c |   27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -623,6 +623,7 @@ struct rtl8169_private {
 	int cfg9346_usage_count;
 
 	unsigned supports_gmii:1;
+	unsigned aspm_manageable:1;
 	dma_addr_t counters_phys_addr;
 	struct rtl8169_counters *counters;
 	struct rtl8169_tc_offsets tc_offset;
@@ -2746,7 +2747,8 @@ static void rtl_hw_aspm_clkreq_enable(st
 	if (tp->mac_version < RTL_GIGA_MAC_VER_32)
 		return;
 
-	if (enable) {
+	/* Don't enable ASPM in the chip if OS can't control ASPM */
+	if (enable && tp->aspm_manageable) {
 		/* On these chip versions ASPM can even harm
 		 * bus communication of other PCI devices.
 		 */
@@ -5156,6 +5158,16 @@ done:
 	rtl_rar_set(tp, mac_addr);
 }
 
+/* register is set if system vendor successfully tested ASPM 1.2 */
+static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
+{
+	if (tp->mac_version >= RTL_GIGA_MAC_VER_61 &&
+	    r8168_mac_ocp_read(tp, 0xc0b2) & 0xf)
+		return true;
+
+	return false;
+}
+
 static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct rtl8169_private *tp;
@@ -5227,6 +5239,19 @@ static int rtl_init_one(struct pci_dev *
 
 	tp->mac_version = chipset;
 
+	/* Disable ASPM L1 as that cause random device stop working
+	 * problems as well as full system hangs for some PCIe devices users.
+	 * Chips from RTL8168h partially have issues with L1.2, but seem
+	 * to work fine with L1 and L1.1.
+	 */
+	if (rtl_aspm_is_safe(tp))
+		rc = 0;
+	else if (tp->mac_version >= RTL_GIGA_MAC_VER_46)
+		rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
+	else
+		rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1);
+	tp->aspm_manageable = !rc;
+
 	tp->dash_type = rtl_check_dash(tp);
 
 	tp->cp_cmd = RTL_R16(tp, CPlusCmd) & CPCMD_MASK;


