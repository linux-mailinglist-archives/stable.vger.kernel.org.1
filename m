Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C5579B885
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349097AbjIKVce (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240630AbjIKOt0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:49:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4D8125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:49:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BC1C433C8;
        Mon, 11 Sep 2023 14:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443761;
        bh=EnTjLYUpcLwLa/plH0vZChIhWDlsih03rIEONuFo3RU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0BxnyvOPRKrqKzPaCc5+lBwOZVkfCxX83BjxbJB/kWHirSUpKUiRdURYInYBEdyq/
         0WHxU1DXScd7/Nnw/co0X6X4QMFddIAjJdJFleEuu55/tMUodOkDYpNlHoyw5F2TgM
         SQDzrqQFoqk+JxXEc3Zdyg4piF2XGLM7XSIQ7GUU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Simon Horman <simon.horman@corigine.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 459/737] wifi: ath11k: Use RMW accessors for changing LNKCTL
Date:   Mon, 11 Sep 2023 15:45:18 +0200
Message-ID: <20230911134703.416860320@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 6c1b6bdb34aaf8f94f65a9cae1d63490320c11bc ]

Don't assume that only the driver would be accessing LNKCTL. ASPM policy
changes can trigger write to LNKCTL outside of driver's control.

Use RMW capability accessors which do proper locking to avoid losing
concurrent updates to the register value. On restore, clear the ASPMC field
properly.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Fixes: e9603f4bdcc0 ("ath11k: pci: disable ASPM L0sLs before downloading firmware")
Link: https://lore.kernel.org/r/20230717120503.15276-9-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Acked-by: Kalle Valo <kvalo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 7b33731a50ee7..6ba4cef6b1c7d 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -581,8 +581,8 @@ static void ath11k_pci_aspm_disable(struct ath11k_pci *ab_pci)
 		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
 
 	/* disable L0s and L1 */
-	pcie_capability_write_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-				   ab_pci->link_ctl & ~PCI_EXP_LNKCTL_ASPMC);
+	pcie_capability_clear_word(ab_pci->pdev, PCI_EXP_LNKCTL,
+				   PCI_EXP_LNKCTL_ASPMC);
 
 	set_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags);
 }
@@ -590,8 +590,10 @@ static void ath11k_pci_aspm_disable(struct ath11k_pci *ab_pci)
 static void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci)
 {
 	if (test_and_clear_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags))
-		pcie_capability_write_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-					   ab_pci->link_ctl);
+		pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_ASPMC,
+						   ab_pci->link_ctl &
+						   PCI_EXP_LNKCTL_ASPMC);
 }
 
 static int ath11k_pci_power_up(struct ath11k_base *ab)
-- 
2.40.1



