Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE517ED001
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbjKOTwO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbjKOTwN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:52:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B27992
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:52:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3EBC433C8;
        Wed, 15 Nov 2023 19:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077930;
        bh=vzH4y0kdhs4Pu0f0x1Y2gSX1/K0YwhpN1bgyTlbCFKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KqX+KyPOC2aiBrW80V8cExMCZXoDYTdMftweEqMFdCdoH11rwJ/3Ihm161/8b+c5e
         l2vMfGqT3mJ+dvuJkW6AuVDjZCPOlxiefcf2KijxNtO3dSIgD5PWVnBQN9CveXFdoH
         3ijN9uTIGlpNjg0/UopzJ3SfYcMDDaVhhwc2mux8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Heiner Kallweit <hkallweit1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6.6 600/603] Revert "PCI/ASPM: Disable only ASPM_STATE_L1 when driver, disables L1"
Date:   Wed, 15 Nov 2023 14:19:05 -0500
Message-ID: <20231115191652.570032834@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

commit 3cb4f534bac010258b2688395c2f13459a932be9 upstream.

This reverts commit fb097dcd5a28c0a2325632405c76a66777a6bed9.

After fb097dcd5a28 ("PCI/ASPM: Disable only ASPM_STATE_L1 when driver
disables L1"), disabling L1 via pci_disable_link_state(PCIE_LINK_STATE_L1),
then enabling one substate, e.g., L1.1, via sysfs actually enables *all*
the substates.

For example, r8169 disables L1 because of hardware issues on a number of
systems, which implicitly disables the L1.1 and L1.2 substates.

On some systems, L1 and L1.1 work fine, but L1.2 causes missed rx packets.
Enabling L1.1 via the sysfs "aspm_l1_1" attribute unexpectedly enables L1.2
as well as L1.1.

After fb097dcd5a28, pci_disable_link_state(PCIE_LINK_STATE_L1) adds only
ASPM_L1 (but not any of the L1.x substates) to the "aspm_disable" mask:

  --- Before fb097dcd5a28
  +++ After fb097dcd5a28

  # r8169 disables L1:
    pci_disable_link_state(PCIE_LINK_STATE_L1)
  -   disable |= ASPM_L1 | ASPM_L1_1 | ASPM_L1_2 | ...  # disable L1, L1.x
  +   disable |= ASPM_L1                                # disable L1 only

  # write "1" to sysfs "aspm_l1_1" attribute:
    l1_1_aspm
      aspm_attr_store_common(state = ASPM_L1_1)
        disable &= ~ASPM_L1_1              # enable L1.1
        if (state & (ASPM_L1_1 | ...))     # if enabling any substate
          disable &= ~ASPM_L1              # enable L1

  # final state:
  - disable = ASPM_L1_2 | ...              # L1, L1.1 enabled; L1.2 disabled
  + disable = 0                            # L1, L1.1, L1.2 all enabled

Enabling an L1.x substate removes the substate and L1 from the
"aspm_disable" mask.  After fb097dcd5a28, the substates were not added to
the mask when disabling L1, so enabling one substate implicitly enables all
of them.

Revert fb097dcd5a28 so enabling one substate doesn't enable the others.

Link: https://lore.kernel.org/r/c75931ac-7208-4200-9ca1-821629cf5e28@gmail.com
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
[bhelgaas: work through example in commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pcie/aspm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1059,7 +1059,8 @@ static int __pci_disable_link_state(stru
 	if (state & PCIE_LINK_STATE_L0S)
 		link->aspm_disable |= ASPM_STATE_L0S;
 	if (state & PCIE_LINK_STATE_L1)
-		link->aspm_disable |= ASPM_STATE_L1;
+		/* L1 PM substates require L1 */
+		link->aspm_disable |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
 	if (state & PCIE_LINK_STATE_L1_1)
 		link->aspm_disable |= ASPM_STATE_L1_1;
 	if (state & PCIE_LINK_STATE_L1_2)


