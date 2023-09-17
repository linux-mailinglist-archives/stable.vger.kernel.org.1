Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B0D7A3834
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjIQTdT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239714AbjIQTcu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:32:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0256A189
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:32:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FEDC433C7;
        Sun, 17 Sep 2023 19:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979139;
        bh=cJzMHJvMZ18j6BBxWshHjXdcxA9L9Dto8tIPthwyFfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DXWlL4fjMG4bZyTt6FYBARjJL0YxGvN1J6P1+2NjHwh9VHbdwhEfTJsFwa3O3wcLt
         0PFb42EnhpDleUWPrI0E4Dxn3O96tBi5v0nzCmkbd+f8H2/qIIbnsl+9qPb7QGtQnD
         NimfMIwzl2SAsw4Y9mjEcm9ja5ZyUzIzV3ErXwtM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Simon Horman <simon.horman@corigine.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 190/406] net/mlx5: Use RMW accessors for changing LNKCTL
Date:   Sun, 17 Sep 2023 21:10:44 +0200
Message-ID: <20230917191106.219829687@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 30de872537bda526664d7a20b646adfb3e7ce6e6 ]

Don't assume that only the driver would be accessing LNKCTL of the upstream
bridge. ASPM policy changes can trigger write to LNKCTL outside of driver's
control.

Use RMW capability accessors which do proper locking to avoid losing
concurrent updates to the register value.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Fixes: eabe8e5e88f5 ("net/mlx5: Handle sync reset now event")
Link: https://lore.kernel.org/r/20230717120503.15276-8-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index e29db4c39b37f..a2d9904e10492 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -279,16 +279,11 @@ static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
 		pci_cfg_access_lock(sdev);
 	}
 	/* PCI link toggle */
-	err = pci_read_config_word(bridge, cap + PCI_EXP_LNKCTL, &reg16);
-	if (err)
-		return err;
-	reg16 |= PCI_EXP_LNKCTL_LD;
-	err = pci_write_config_word(bridge, cap + PCI_EXP_LNKCTL, reg16);
+	err = pcie_capability_set_word(bridge, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_LD);
 	if (err)
 		return err;
 	msleep(500);
-	reg16 &= ~PCI_EXP_LNKCTL_LD;
-	err = pci_write_config_word(bridge, cap + PCI_EXP_LNKCTL, reg16);
+	err = pcie_capability_clear_word(bridge, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_LD);
 	if (err)
 		return err;
 
-- 
2.40.1



