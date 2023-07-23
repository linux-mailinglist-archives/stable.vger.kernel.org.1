Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4A075E240
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 16:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjGWOBn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 10:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjGWOBm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 10:01:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9141BE
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 07:01:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51A4E60D33
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 14:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0AFC433C7;
        Sun, 23 Jul 2023 14:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690120900;
        bh=XibJCiglwZzVVCVyPH2zISEAfK+qWGHKY051RuNfl4g=;
        h=Subject:To:Cc:From:Date:From;
        b=xdGozEwmS0lUKwfVq+wDuKjKdn9KaHckwyH0UckZp2wbsuXur8q/jDlJHmecUbqu3
         OdkKOA9yjPyiC9pllb5E9QQWTr7xfCSMI4yUpak/fiEYsFXrOa+2ppuKQUnJgTrBJX
         YshR+52qPMSSa3kHz0vtFZWzSpcS5KoA7YQhTAQ8=
Subject: FAILED: patch "[PATCH] r8169: revert 2ab19de62d67 ("r8169: remove ASPM restrictions" failed to apply to 6.4-stable tree
To:     hkallweit1@gmail.com, kuba@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 23 Jul 2023 16:01:38 +0200
Message-ID: <2023072337-dreamlike-rewrite-a12e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x cf2ffdea0839398cb0551762af7f5efb0a6e0fea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072337-dreamlike-rewrite-a12e@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cf2ffdea0839398cb0551762af7f5efb0a6e0fea Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Tue, 18 Jul 2023 13:11:31 +0200
Subject: [PATCH] r8169: revert 2ab19de62d67 ("r8169: remove ASPM restrictions
 now that ASPM is disabled during NAPI poll")

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

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index fce4a2b908c2..8a8b7d8a5c3f 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -623,6 +623,7 @@ struct rtl8169_private {
 	int cfg9346_usage_count;
 
 	unsigned supports_gmii:1;
+	unsigned aspm_manageable:1;
 	dma_addr_t counters_phys_addr;
 	struct rtl8169_counters *counters;
 	struct rtl8169_tc_offsets tc_offset;
@@ -2746,7 +2747,8 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 	if (tp->mac_version < RTL_GIGA_MAC_VER_32)
 		return;
 
-	if (enable) {
+	/* Don't enable ASPM in the chip if OS can't control ASPM */
+	if (enable && tp->aspm_manageable) {
 		/* On these chip versions ASPM can even harm
 		 * bus communication of other PCI devices.
 		 */
@@ -5165,6 +5167,16 @@ static void rtl_init_mac_address(struct rtl8169_private *tp)
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
@@ -5234,6 +5246,19 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 				     xid);
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

